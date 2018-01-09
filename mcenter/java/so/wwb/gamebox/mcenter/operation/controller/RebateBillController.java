package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.net.ServletTool;
import org.soul.model.msg.notice.vo.NoticeLocaleTmpl;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.operation.IRebateBillService;
import so.wwb.gamebox.mcenter.operation.form.ConfirmSettlementForm;
import so.wwb.gamebox.mcenter.operation.form.RebateAgentForm;
import so.wwb.gamebox.mcenter.report.rebate.form.RebateBillForm;
import so.wwb.gamebox.mcenter.report.rebate.form.RebateBillSearchForm;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.common.notice.enums.ManualNoticeEvent;
import so.wwb.gamebox.model.master.operation.po.*;
import so.wwb.gamebox.model.master.operation.vo.*;
import so.wwb.gamebox.model.master.player.po.UserAgent;
import so.wwb.gamebox.model.master.player.vo.UserAgentListVo;
import so.wwb.gamebox.model.report.enums.SettlementStateEnum;
import so.wwb.gamebox.web.common.token.Token;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.util.*;

/**
 * 返佣账单
 * todo::will delete
 * @author younger
 * @time 2017-08-08 11:35:46
 */
@Controller
@RequestMapping("/rebateBill")
public class RebateBillController extends BaseCrudController<IRebateBillService, RebateBillListVo, RebateBillVo, RebateBillSearchForm, RebateBillForm, RebateBill, Integer> {

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/rebate/";
        //endregion your codes 2
    }
    //region your codes 3
    private static final String OPERATION_REBATE_CLEARING = "/operation/rebate/clearing";
    private static final String OPERATION_REBATE_REFUSE_SETTLEMENT = "/operation/rebate/refuseSettlement";
    private static final String OPERATION_REBATE_CONFIRM_SETTLEMENT = "/operation/rebate/confirmSettlement";
    private static final String OPERATION_REBATE_UPDATE_SETTLEMENT = "/operation/rebate/updateSettlement";
    private static final String OPERATION_REBATE_VIEW = "/operation/rebate/View";
    private static final String OPERATION_REBATE_REFUSESETTLEMENTPARTIAL = "/operation/rebate/refuseSettlementPartial";

    /**
     * 返佣结算列表页展示
     *
     * @param listVo
     * @param form
     * @param result
     * @param model
     * @return
     */
    @Override
    protected RebateBillListVo doList(RebateBillListVo listVo, RebateBillSearchForm form, BindingResult result, Model model) {

        Map<String, Serializable> lssuingState = DictTool.get(DictEnum.LSSUING_STATE);
        model.addAttribute("lssuingState", lssuingState);
        //listVo.getSearch().setMasterId(SessionManager.getSiteUserId());
        return this.getService().search(listVo);
    }

    /**
     * 返佣结算详细
     *
     * @param rebateAgentListVo
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/detail")
    public String detail(RebateAgentListVo rebateAgentListVo, Integer id, Model model, HttpServletRequest request) {

        if (id == null) {
            return null;
        }

        List<UserAgent> userAgentList = getUserAgentInfo();
        RebateBillVo rebateBillVo = getSettlementRebate(new RebateBillVo(), id);
        model.addAttribute("objectVo", rebateBillVo);

        rebateAgentListVo.getSearch().setRebateBillId(id);
        rebateAgentListVo.getSearch().setSettlementState(request.getParameter("settlementState"));//此处用于列表页待发放/已发放/拒绝链接的过滤
        rebateAgentListVo = ServiceSiteTool.settlementRebateAgentService().search(rebateAgentListVo);
        rebateAgentListVo = assembledListData(rebateAgentListVo,userAgentList);
        model.addAttribute("command", rebateAgentListVo);

        //详细页面链接
        List<AgentRebateOrder> list = new ArrayList<>();
        for (RebateAgent rebateAgent : rebateAgentListVo.getResult()) {
            Integer agentId = rebateAgent.getAgentId();
            AgentRebateOrderVo agentRebateOrderVo = new AgentRebateOrderVo();
            agentRebateOrderVo.getSearch().setAgentId(agentId);
            agentRebateOrderVo.getSearch().setRebateBillId(id);
            agentRebateOrderVo = ServiceSiteTool.agentRebateOrderService().search(agentRebateOrderVo);
            if (agentRebateOrderVo.getResult() != null) {
                list.add(agentRebateOrderVo.getResult());
            }
        }

        //当没有交易记录
        if (list.size() > 0) {
            Map agentRebateOrderMap = CollectionTool.toEntityMap(list, AgentRebateOrder.PROP_AGENT_ID, Integer.class);
            model.addAttribute("agentRebateOrderMap", agentRebateOrderMap);
        }
        model.addAttribute("agentRebateOrderList", list);
        return ServletTool.isAjaxSoulRequest(request) ? OPERATION_REBATE_VIEW + "Partial" : OPERATION_REBATE_VIEW;
    }

    /**
     * 返佣结算明细
     *
     * @param objectVo
     * @param model
     * @return
     */
    @RequestMapping("/clearing")
    public String clearing(RebateAgentListVo rebateAgentListVo, Integer id, RebateBillVo objectVo, RebateAgentVo rebateAgentVo, Model model, HttpServletRequest request) {

        objectVo = getSettlementRebate(objectVo, id);
        model.addAttribute("objectVo", objectVo);

        List<UserAgent> userAgentList = getUserAgentInfo();
        rebateAgentListVo.getSearch().setRebateBillId(id);
        rebateAgentListVo.getSearch().setSettlementState(SettlementStateEnum.PENDING_LSSUING.getCode());
        rebateAgentListVo = ServiceSiteTool.settlementRebateAgentService().search(rebateAgentListVo);
        rebateAgentListVo = assembledListData(rebateAgentListVo,userAgentList);
        model.addAttribute("command", rebateAgentListVo);

        if (ServletTool.isAjaxSoulRequest(request)) {
            return OPERATION_REBATE_CLEARING + "Partial";
        } else {
            return OPERATION_REBATE_CLEARING;
        }

    }

    /**
     * 拒绝结算弹出框
     *
     * @param ids
     * @param model
     * @param rebateAgentVo
     * @return
     */
    @RequestMapping("/toRefuseSettlement")
    @Token(generate = true)
    public String toRefuseSettlementDialog(Integer[] ids, Model model, RebateAgentVo rebateAgentVo, RebateBillVo objectVo) {

        objectVo = getSettlementRebate(objectVo, objectVo.getSearch().getId());
        model.addAttribute("objectVo", objectVo);

        //加载拒付原因模板
        Map<String,String> paramMap = addParam(objectVo);
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.REFUSE_RETURN_COMMISSION);
        List<NoticeLocaleTmpl> noticeLocaleTmpls = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);
        for (NoticeLocaleTmpl noticeLocaleTmpl : noticeLocaleTmpls) {
            noticeLocaleTmpl.setTitle(StringTool.fillTemplate(noticeLocaleTmpl.getTitle(),paramMap));
            noticeLocaleTmpl.setContent(StringTool.fillTemplate(noticeLocaleTmpl.getContent(),paramMap));
        }
        model.addAttribute("noticeLocaleTmpls", noticeLocaleTmpls);

        model.addAttribute("ids", StringTool.join(",", ids));
        rebateAgentVo.setValidateRule(JsRuleCreator.create(ConfirmSettlementForm.class, "result"));
        model.addAttribute("command", rebateAgentVo);

        return OPERATION_REBATE_REFUSE_SETTLEMENT;
    }

    @RequestMapping("/hasReason")
    @ResponseBody
    public Map hasReason(RakebackBillVo vo){
        Map result = new HashMap();
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.REFUSE_RETURN_COMMISSION);
        List<NoticeLocaleTmpl> noticeLocaleTmpls = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);
        if(noticeLocaleTmpls!=null&&noticeLocaleTmpls.size()>0){
            result.put("state",true);
        }else{
            result.put("state",false);
        }
        return result;
    }

    /**
     * 确认结算弹出框
     *
     * @param ids
     * @param objectVo
     * @param model
     * @return
     */
    @RequestMapping("/toConfirmSettlement")
    @Token(generate = true)
    public String toConfirmSettlementDialog(Integer[] ids, RebateBillVo objectVo, Model model) {

        objectVo = getSettlementRebate(objectVo, objectVo.getSearch().getId());
        model.addAttribute("objectVo", objectVo);

        model.addAttribute("thisPay", ids.length);
        model.addAttribute("ids", StringTool.join(",", ids));

        RebateAgentListVo rebateAgentListVo = new RebateAgentListVo();
        rebateAgentListVo.getSearch().setIds(ids);
        Double sum = ServiceSiteTool.settlementRebateAgentService().statisticsTotalRebate(rebateAgentListVo);
        model.addAttribute("sum", sum);

        return OPERATION_REBATE_CONFIRM_SETTLEMENT;
    }

    /**
     * 修改实付金额弹出框
     *
     * @param rebateAgentVo
     * @param model
     * @return
     */
    @RequestMapping("/toModifySettlement")
    @Token(generate = true)
    public String toModifySettlementDialog(RebateAgentVo rebateAgentVo, Model model) {
        rebateAgentVo = ServiceSiteTool.settlementRebateAgentService().get(rebateAgentVo);
        RebateBillVo objectVo = getSettlementRebate(new RebateBillVo(), rebateAgentVo.getResult().getRebateBillId());
        model.addAttribute("objectVo", objectVo);
        model.addAttribute("command", rebateAgentVo);
        rebateAgentVo.setValidateRule(JsRuleCreator.create(RebateAgentForm.class, "result"));

        return OPERATION_REBATE_UPDATE_SETTLEMENT;
    }

    /**
     * 拒绝原因预览更多
     *
     * @param vo
     * @return
     */
    @RequestMapping("/previewMore")
    public String settlementPreviewMore(NoticeVo vo, Model model) {
        Map<String, Map<String, NoticeLocaleTmpl>> stringMapMap = ServiceTool.noticeService().previewTmplsByGroupCode(vo);
        model.addAttribute("command", stringMapMap);
        return OPERATION_REBATE_REFUSESETTLEMENTPARTIAL;
    }

    /**
     * 获取返佣结算账单信息
     *
     * @param objectVo
     * @param id
     */
    private RebateBillVo getSettlementRebate(RebateBillVo objectVo, Integer id) {
        objectVo.getSearch().setId(id);
        objectVo = getService().get(objectVo);
        return objectVo;
    }

    /**
     * 获取代理信息主要通过id获得佣金
     */
    private List<UserAgent> getUserAgentInfo() {
        UserAgentListVo userAgentListVo = new UserAgentListVo();
        return ServiceSiteTool.userAgentService().allSearch(userAgentListVo);
    }

    /**
     * 把佣金余额组装到列表
     * @param rebateAgentListVo
     * @param userAgentList
     * @return
     */
    private RebateAgentListVo assembledListData (RebateAgentListVo rebateAgentListVo, List<UserAgent> userAgentList) {

        for (RebateAgent rebateAgent : rebateAgentListVo.getResult()) {
            for (UserAgent userAgent : userAgentList) {
                if (rebateAgent.getAgentId().equals(userAgent.getId())) {
                    rebateAgent.setBalance(userAgent.getAccountBalance());
                }
            }
        }
        return rebateAgentListVo;
    }

    /**
     * 返佣未出账单
     *
     * @param model
     * @param request
     * @param listVo
     * @return
     */
    @RequestMapping("/rebateNosettled")
    public String rebateNosettled(Model model, HttpServletRequest request, RebateAgentNosettledListVo listVo) {
        //查询返佣未出账单
        RebateBillNosettledVo rebateBillNosettledVo = new RebateBillNosettledVo();
        RebateBillNosettled rebateBillNosettled = getService().searchLastRebateBillNosettled(rebateBillNosettledVo);
        model.addAttribute("rebateBillNosettled", rebateBillNosettled);


        double[] total = new double[]{0d, 0d, 0d, 0d, 0d, 0d, 0d, 0d, 0d, 0d,0d};
        if (rebateBillNosettled != null) {
            //查询返佣未出账单列表
            listVo.getSearch().setRebateBillId(rebateBillNosettled.getId());
            listVo = getService().searchRebateAgentNosettled(listVo);

            //计算合计
            for (RebateAgentNosettled rebateAgentNosettled : listVo.getResult()) {
                total[0] = total[0] + rebateAgentNosettled.getEffectivePlayer();
                total[1] = total[1] + (rebateAgentNosettled.getEffectiveTransaction()==null?0.00d:rebateAgentNosettled.getEffectiveTransaction());
                total[2] = total[2] + (rebateAgentNosettled.getProfitLoss()==null?0.00d:rebateAgentNosettled.getProfitLoss());
                total[3] = total[3] + (rebateAgentNosettled.getDepositAmount()==null?0.00d:rebateAgentNosettled.getDepositAmount());
                total[4] = total[4] + (rebateAgentNosettled.getWithdrawAmount()==null?0.00d:rebateAgentNosettled.getWithdrawAmount());
                total[5] = total[5] + (rebateAgentNosettled.getRakebackAmount()==null?0.00d:rebateAgentNosettled.getRakebackAmount());
                total[6] = total[6] + ((rebateAgentNosettled.getFavorableAmount()==null || rebateAgentNosettled.getFavorableAmount()==null)?0.00d:rebateAgentNosettled.getFavorableAmount());
                //total[7] = total[7] + (rebateAgentNosettled.getRefundFee()==null?0.00d:rebateAgentNosettled.getRefundFee());
                //total[8] = total[8] + (rebateAgentNosettled.getApportion()==null?0.00d:rebateAgentNosettled.getApportion());
               // total[9] = total[9] + (rebateAgentNosettled.getHistoryApportion()==null?0.00d:rebateAgentNosettled.getHistoryApportion());
                total[10] = total[10] + (rebateAgentNosettled.getRebateTotal()==null?0.00d:rebateAgentNosettled.getRebateTotal());
            }

        }
        model.addAttribute("command", listVo);
        model.addAttribute("total", total);
        return ServletTool.isAjaxSoulRequest(request) ? getViewBasePath() + "RebateNosettledPartial" : getViewBasePath() + "RebateNosettled";

    }

    /**
     * 替换模板参数
     * @param objectVo
     * @return
     */
    private Map<String,String> addParam(RebateBillVo objectVo) {
        Calendar c = Calendar.getInstance();
        c.setTime(objectVo.getResult().getEndTime());
        int year = c.get(Calendar.YEAR);
        int month = c.get(Calendar.MONTH)+1;
        Map<String,String> paramMap = new HashMap<>();
        paramMap.put("year",String.valueOf(year));
        paramMap.put("month",String.valueOf(month));
        Integer period = Integer.valueOf(objectVo.getResult().getPeriod());
        paramMap.put("period",String.format("%02d",period));
        paramMap.put("startDate", DateTool.formatDate(objectVo.getResult().getStartTime(), DateTool.yyyy_MM_dd));
        paramMap.put("endDate",DateTool.formatDate(objectVo.getResult().getEndTime(),DateTool.yyyy_MM_dd));
        return paramMap;
    }
}