package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.model.log.audit.enums.OpType;
import org.soul.model.log.audit.enums.ParamType;
import org.soul.model.log.audit.vo.BaseLog;
import org.soul.model.log.audit.vo.LogVo;
import org.soul.model.log.audit.vo.Param;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.model.sys.po.SysAuditLog;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.operation.IRebateAgentService;
import so.wwb.gamebox.mcenter.operation.form.RebateAgentForm;
import so.wwb.gamebox.mcenter.operation.form.RebateAgentSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.ModuleType;
import so.wwb.gamebox.model.SiteI18nEnum;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.common.notice.enums.AutoNoticeEvent;
import so.wwb.gamebox.model.common.notice.enums.NoticeParamEnum;
import so.wwb.gamebox.model.master.enums.RemarkEnum;
import so.wwb.gamebox.model.master.operation.po.RebateAgent;
import so.wwb.gamebox.model.master.operation.vo.RebateAgentListVo;
import so.wwb.gamebox.model.master.operation.vo.RebateAgentVo;
import so.wwb.gamebox.model.master.operation.vo.RebateBillVo;
import so.wwb.gamebox.model.master.player.po.Remark;
import so.wwb.gamebox.model.master.player.vo.RemarkVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.*;


/**
 * 玩家返佣表控制器
 *
 * @author eagle
 * @time 2015-9-14 11:35:46
 */
@Controller
//region your codes 1
@RequestMapping("/operation/rebateAgent")
public class SettlementRebateAgentController extends BaseCrudController<IRebateAgentService, RebateAgentListVo, RebateAgentVo, RebateAgentSearchForm, RebateAgentForm, RebateAgent, Integer> {

    private static final Log LOG = LogFactory.getLog(SettlementRebateAgentController.class);
    //endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/rebate/";
        //endregion your codes 2
    }

    //region your codes 3
    private static final String REBATE_SETTLEMENT_REJECT_MSG = "rebate.settlement.reject.msg";
    private static final String REBATE_SETTLEMENT_SUCCESS_MSG = "rebate.settlement.success.msg";

    /**
     * 实付金额操作
     *
     * @param objectVo
     * @return
     */
    @Override
    protected RebateAgentVo doUpdate(RebateAgentVo objectVo) {

        if (objectVo == null || objectVo.getResult() == null) {
            return null;
        }

        //实付佣金
        Double rebateActual = objectVo.getResult().getRebateActual();
        //String remark = objectVo.getResult().getRemark();
        objectVo.getSearch().setId(objectVo.getResult().getId());
        objectVo = getService().get(objectVo);
        objectVo.getResult().setRebateActual(rebateActual);
        //objectVo.getResult().setRemark(remark);
        return super.doUpdate(objectVo);
    }

    @Override
    @Token(valid = true)
    public Map persist(RebateAgentVo objectVo, @FormModel("result") @Valid RebateAgentForm form, BindingResult result) {
        return super.persist(objectVo, form, result);
    }

    /**
     * 确认结算
     *
     * @param objectVo
     * @param ids
     * @param total
     * @param id
     * @param request
     * @return
     */
    @RequestMapping("/confirmSettlement")
    @ResponseBody
    @Audit(module = Module.MASTER_OPERATION, moduleType = ModuleType.Rebate_SETTLEMENT_SUCCESS, opType = OpType.AUDIT)
    @Token(valid = true)
    public Map confirmSettlement(RebateAgentVo objectVo, String ids, Double total, Integer id, HttpServletRequest request) {

        //实付佣金
        List<Integer> rids = convertIdToInteger(ids);
        if(rids == null || rids.size() == 0){
            Map map = new HashMap();
            map.put("state",false);
            return map;
        }
        objectVo.setRids(rids);

        //更新结算周期待发放、已发放、拒绝、最后操作人,周期内实付总金额
        objectVo.setTotal(total);
        objectVo.setcId(id);
        objectVo.getRebateBillVo().setLastOperateTime(SessionManager.getDate().getNow());
        objectVo.setUserId(SessionManager.getUserId());
        objectVo.setUserName(SessionManager.getUserName());
        objectVo = getService().updateConfirmRebateActual(objectVo);

        //操作日志记录和消息发送
        if (objectVo.isSuccess()) {
            List<String> agentNames = sendNoticeAndLogging(objectVo);
            logging(id, REBATE_SETTLEMENT_SUCCESS_MSG, request, agentNames);
        }
        return getVoMessage(objectVo);
    }
    @RequestMapping("/refuseSettlementNoReason")
    @ResponseBody
    @Audit(module = Module.MASTER_OPERATION, moduleType = ModuleType.Rebate_SETTLEMENT_FAILURE, opType = OpType.AUDIT)
    public Map refuseSettlementNoReason(RebateAgentVo objectVo, String ids, String reasonTitle, String reasonContent, Integer id, HttpServletRequest request){
        return refuseSettlementOrder(objectVo, ids, reasonTitle, reasonContent, id, request);
    }

    /**
     * 拒绝结算
     *
     * @param objectVo
     * @param ids
     * @param reasonTitle
     * @param reasonContent
     * @param id
     * @param request
     * @return
     */
    @RequestMapping("/refuseSettlement")
    @ResponseBody
    @Audit(module = Module.MASTER_OPERATION, moduleType = ModuleType.Rebate_SETTLEMENT_FAILURE, opType = OpType.AUDIT)
    @Token(valid = true)
    public Map refuseSettlement(RebateAgentVo objectVo, String ids, String reasonTitle, String reasonContent, Integer id, HttpServletRequest request) {
        return refuseSettlementOrder(objectVo, ids, reasonTitle, reasonContent, id, request);


    }

    private Map refuseSettlementOrder(RebateAgentVo objectVo, String ids, String reasonTitle, String reasonContent, Integer id, HttpServletRequest request) {
        //更新拒付原因
        List<Integer> rids = convertIdToInteger(ids);
        if(rids == null || rids.size() == 0){
            Map map = new HashMap();
            map.put("state",false);
            return map;
        }
        objectVo.setRids(rids);
        objectVo.setReasonTitle(reasonTitle);
        objectVo.setReasonContent(reasonContent);
        //更新结算周期待发放、已发放、拒绝、最后操作人,周期内实付总金额
        if(objectVo.getRebateBillVo()==null){
            RebateBillVo rebateBillVo = new RebateBillVo();
            rebateBillVo.getSearch().setId(id);
            rebateBillVo = ServiceSiteTool.rebateBillService().get(rebateBillVo);
            objectVo.setRebateBillVo(rebateBillVo);
        }
        objectVo.setcId(id);
        objectVo.getRebateBillVo().setLastOperateTime(SessionManager.getDate().getNow());
        objectVo.setUserId(SessionManager.getUserId());
        objectVo.setUserName(SessionManager.getUserName());

       /* List<String> agentNames = new ArrayList<>();
        int len = settlementRebateAgents.size();
        Integer[] messageIds = new Integer[len];
        for (int i = 0; i < len ; i++) {
            Map<String, Object> map = settlementRebateAgents.get(i);
            agentNames.add((String)map.get("agentName"));
            messageIds[i] = (Integer)map.get("agentId");
        }*/

        objectVo = getService().updateRefuseRebate(objectVo);
        if (objectVo.isSuccess()) {
            List<String> agentNames = new ArrayList<>();
            if(StringTool.isNotBlank(objectVo.getGroupCode())){
                if (objectVo.getSettlementRebateAgents() != null) {
                    for (Map<String, Object> map : objectVo.getSettlementRebateAgents()) {

                        agentNames.add((String) map.get("agentName"));
                        try {
                            //消息发送
                            NoticeVo noticeVo = NoticeVo.manualNotify(objectVo.getGroupCode(), null, (Integer) map.get("agentId"));
                            noticeVo.addParams(addParams(objectVo, map));
                            ServiceTool.noticeService().publish(noticeVo);
                        } catch (Exception e) {
                            LOG.error(e,"拒绝返佣站内信发送异常");
                        }
                    }
                }

            }
            //操作日志记录
            logging(id, REBATE_SETTLEMENT_REJECT_MSG, request, agentNames);
        }

        return getVoMessage(objectVo);
    }

    /**
     * 记录日志
     *
     * @param id         settlement_rebate主键
     * @param request
     * @param agentNames
     */
    private void logging(Integer id, String desc, HttpServletRequest request, List<String> agentNames) {
        LogVo logVo = new LogVo();
        BaseLog baseLog = logVo.addBussLog();
        baseLog.setDescription(desc);
        baseLog.setEntityId(id);//此处id是主表settlement_rebate上的id
        baseLog.addParam("date", new Param("date", SessionManager.getDate().getNow(), ParamType.DATE.getCode()));
        baseLog.addParam(SessionManager.getUserName()).addParam(StringTool.join(",", agentNames));
        request.setAttribute(SysAuditLog.AUDIT_LOG, logVo);
    }

    /**
     * 字符串id转为整型
     *
     * @param ids
     * @return
     */
    private List<Integer> convertIdToInteger(String ids) {
        String[] idarray = StringTool.split(ids, ",");
        List<Integer> rids = null;
        if (idarray != null && idarray.length > 0) {
            rids = new ArrayList<>();
            for (int i = 0; i < idarray.length; i++) {
                Integer temp = Integer.parseInt(idarray[i]);
                rids.add(temp);
            }
        }
        return rids;
    }

    /**
     * 日志记录和消息发送
     *
     * @param rebateAgentVo
     * @return
     */
    private List<String> sendNoticeAndLogging(RebateAgentVo rebateAgentVo) {
        List<String> agentNames = new ArrayList<>();
        List<Integer> agentIds = new ArrayList<>();
        if (rebateAgentVo.getSettlementRebateAgents() != null) {
            for (Map<String, Object> map : rebateAgentVo.getSettlementRebateAgents()) {
                agentNames.add((String) map.get("agentName"));
                String remarkContent = (String) map.get("remark");
                Integer agentId = (Integer) map.get("agentId");
                agentIds.add(agentId);
                if (StringTool.isNotBlank(remarkContent)) {

                /*
                    备注类型：修改实付返佣
                    备注标题：本期结算名称+返佣结算，如2015年08月04期返佣结算；
                    内容：显示站长填写的备注内容；
                    备注的存储需要判断备注是否有内容，并且有备注的发送信息的时候内容不一样
                 */
                    Calendar c = Calendar.getInstance();
                    c.setTime(rebateAgentVo.getRebateBillVo().getEndTime());
                    int year = c.get(Calendar.YEAR);
                    int month = c.get(Calendar.MONTH) + 1;
                    Integer period = Integer.valueOf(rebateAgentVo.getRebateBillVo().getSettlementName());
                    Map<String, String> paramMap = new HashMap<>();
                    paramMap.put("year", String.valueOf(year));
                    paramMap.put("month", String.valueOf(month));
                    paramMap.put("period", String.format("%02d", period));
                    String remarkTitle = StringTool.fillTemplate(LocaleTool.tranView(Module.MASTER_OPERATION, "Rebate.settlementName.remarkTitle"), paramMap);
                    addRemark(remarkContent, agentId, remarkTitle);
                    sendAutoNoticeWithModifyRebateActual(remarkContent, agentId, paramMap);
                } else {
                    sendAutoNoticeWithNoModifyRebateActual(rebateAgentVo, agentIds, map);
                }
            }
        }
        return agentNames;
    }

    /**
     * 修改实付
     * 站内信标题：本期结算名称+返佣结算，如2015年08月04期返佣结算；
     * 站内信内容：显示站长填写的备注内容；
     *
     * @param remarkContent
     * @param agentId
     * @param paramMap
     */
    private void sendAutoNoticeWithModifyRebateActual(String remarkContent, Integer agentId, Map<String, String> paramMap) {

        String title = StringTool.fillTemplate(LocaleTool.tranView(Module.MASTER_OPERATION, "Rebate.settlementName.title"), paramMap);
        SysUserVo userVo = new SysUserVo();
        userVo.getSearch().setId(agentId);
        userVo = ServiceTool.sysUserService().get(userVo);
        ServiceTool.sysUserService().get(userVo);

        NoticeVo variableNoticeVo = new NoticeVo();
        variableNoticeVo.setEventType(AutoNoticeEvent.RETURN_COMMISSION_SUCCESS);
        Map<String, Pair<String, String>> localeTmplMap = new HashMap<>();//发送消息内容
        localeTmplMap.put(userVo.getResult().getDefaultLocale(), new Pair(title, remarkContent));
        variableNoticeVo.addUserIds(agentId);
        variableNoticeVo.setLocaleTmplMap(localeTmplMap);
        try {
            ServiceTool.noticeService().publish(variableNoticeVo);
        } catch (Exception e) {
            LOG.warn("修改实付金额返佣确认结算站内信发送异常");
        }

    }

    /**
     * 插入备注
     *
     * @param remarkContent
     * @param agentId
     * @param remarkTitle
     */
    private void addRemark(String remarkContent, Integer agentId, String remarkTitle) {
        Remark remark = new Remark();
        RemarkVo remarkVo = new RemarkVo();
        remark.setEntityUserId(agentId);
        remark.setRemarkTime(SessionManager.getDate().getNow());
        remark.setEntityId(null);
        remark.setModel(RemarkEnum.OPERATION_REBAATE.getModel());
        remark.setRemarkType(RemarkEnum.OPERATION_REBAATE.getType());
        remark.setOperatorId(SessionManager.getUserId());
        remark.setOperator(SessionManager.getUserName());
        remark.setRemarkTitle(remarkTitle);
        remark.setRemarkContent(remarkContent);
        remarkVo.setResult(remark);
        ServiceTool.getRemarkService().insert(remarkVo);
    }

    /**
     * 未修改实付
     * 标题：2015年08月01期返佣，已结算!
     * 内容：本期（2015-08-01~2015-08-07）返佣已发放至您的账户，请查收！
     *
     * @param rebateAgentVo
     * @param agentIds
     * @param rebateAgentMap
     */
    private void sendAutoNoticeWithNoModifyRebateActual(RebateAgentVo rebateAgentVo, List<Integer> agentIds, Map<String, Object> rebateAgentMap) {

        NoticeVo noticeVo = NoticeVo.autoNotify(AutoNoticeEvent.RETURN_COMMISSION_SUCCESS, agentIds.toArray(new Integer[agentIds.size()]));
        noticeVo.addParams(addParams(rebateAgentVo, rebateAgentMap)
        );
        try {
            ServiceTool.noticeService().publish(noticeVo);
        } catch (Exception e) {
            LOG.warn("未修改实付返佣确认结算站内信发送异常");
        }
    }

    /**
     * 替换模板参数
     *
     * @param rebateAgentVo
     * @param rebateAgentMap
     * @return
     */
    private Pair[] addParams(RebateAgentVo rebateAgentVo, Map<String, Object> rebateAgentMap) {

        Calendar c = Calendar.getInstance();
        c.setTime(rebateAgentVo.getRebateBillVo().getEndTime());
        Integer period = Integer.valueOf(rebateAgentVo.getRebateBillVo().getSettlementName());
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(SessionManager.getDate().getNow());
        String timezone = Cache.getUserTimezone(rebateAgentVo.getResult()!=null?rebateAgentVo.getResult().getAgentId():rebateAgentVo.getUserId());
        String startTime = LocaleDateTool.formatDate(rebateAgentVo.getRebateBillVo().getStartTime(),DateTool.yyyy_MM_dd,timezone);
        String endTime = LocaleDateTool.formatDate(rebateAgentVo.getRebateBillVo().getEndTime(),DateTool.yyyy_MM_dd,timezone);
        return new Pair[]
                {
                        new Pair<String, String>(NoticeParamEnum.YEAR.getCode(), String.valueOf(c.get(Calendar.YEAR))),
                        new Pair<String, String>(NoticeParamEnum.MONTH.getCode(), String.valueOf(c.get(Calendar.MONTH) + 1)),
                        new Pair<String, String>(NoticeParamEnum.PERIOD.getCode(), String.format("%02d", period)),
                        new Pair<String, String>(NoticeParamEnum.START_DATE.getCode(), startTime),
                        new Pair<String, String>(NoticeParamEnum.END_DATE.getCode(), endTime),
                        new Pair<String, String>(NoticeParamEnum.USER.getCode(), (String) rebateAgentMap.get("agentName")),
                        new Pair<String, String>(NoticeParamEnum.SITE_NAME.getCode(), Cache.getSiteI18n(SiteI18nEnum.SETTING_SITE_NAME).get(SessionManager.getLocale().toString()).getValue()),
                        new Pair<String, String>(NoticeParamEnum.SEND_YEAR.getCode(), String.valueOf(calendar.get(Calendar.YEAR))),
                        new Pair<String, String>(NoticeParamEnum.SEND_MONTH.getCode(), String.valueOf(calendar.get(Calendar.MONTH) + 1)),
                        new Pair<String, String>(NoticeParamEnum.SEND_DAY.getCode(), String.valueOf(calendar.get(Calendar.DAY_OF_MONTH)))
                };
    }
    //endregion your codes 3

}