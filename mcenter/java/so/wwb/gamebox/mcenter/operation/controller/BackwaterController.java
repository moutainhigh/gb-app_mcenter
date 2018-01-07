package so.wwb.gamebox.mcenter.operation.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionQueryTool;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.math.NumberTool;
import org.soul.commons.net.ServletTool;
import org.soul.commons.query.Criteria;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.support._Module;
import org.soul.iservice.taskschedule.ITaskScheduleService;
import org.soul.model.log.audit.enums.OpType;
import org.soul.model.log.audit.enums.ParamType;
import org.soul.model.log.audit.vo.BaseLog;
import org.soul.model.log.audit.vo.LogVo;
import org.soul.model.log.audit.vo.Param;
import org.soul.model.msg.notice.vo.NoticeLocaleTmpl;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.model.sys.po.SysAuditLog;
import org.soul.model.taskschedule.po.TaskSchedule;
import org.soul.model.taskschedule.vo.TaskScheduleVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.session.SessionManagerBase;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceScheduleTool;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.operation.IRakebackBillService;
import so.wwb.gamebox.mcenter.operation.form.BackwaterActualForm;
import so.wwb.gamebox.mcenter.operation.form.BackwaterReasonForm;
import so.wwb.gamebox.mcenter.report.rakeback.form.RakebackBillForm;
import so.wwb.gamebox.mcenter.report.rakeback.form.RakebackBillSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.ModuleType;
import so.wwb.gamebox.model.TerminalEnum;
import so.wwb.gamebox.model.boss.enums.TaskScheduleEnum;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.common.notice.enums.AutoNoticeEvent;
import so.wwb.gamebox.model.common.notice.enums.ManualNoticeEvent;
import so.wwb.gamebox.model.common.notice.enums.NoticeParamEnum;
import so.wwb.gamebox.model.company.site.po.SiteCustomerService;
import so.wwb.gamebox.model.master.enums.RakebackSettleCodeEnum;
import so.wwb.gamebox.model.master.enums.RemarkEnum;
import so.wwb.gamebox.model.master.operation.po.*;
import so.wwb.gamebox.model.master.operation.vo.*;
import so.wwb.gamebox.model.master.player.po.PlayerTransaction;
import so.wwb.gamebox.model.master.player.po.Remark;
import so.wwb.gamebox.model.master.player.vo.PlayerRankVo;
import so.wwb.gamebox.model.master.player.vo.RemarkVo;
import so.wwb.gamebox.model.report.enums.SettlementStateEnum;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.*;

/**
 * 运营管理-返水结算
 * Created by cheery on 15-9-7.
 */
@Controller
@RequestMapping("/operation/rakebackBill")
public class BackwaterController extends BaseCrudController<IRakebackBillService, RakebackBillListVo, RakebackBillVo, RakebackBillSearchForm, RakebackBillForm, RakebackBill, Integer> {

    private static final Log LOG = LogFactory.getLog(BackwaterController.class);

    @Override
    protected String getViewBasePath() {
        return "/operation/rakebackBill/";
    }

    @Override
    protected RakebackBillListVo doList(RakebackBillListVo listVo, RakebackBillSearchForm form, BindingResult result, Model model) {
        model.addAttribute("lssuingStates", DictTool.get(DictEnum.LSSUING_STATE));
        return super.doList(listVo, form, result, model);
    }

    /***
     * 返水明细
     *
     * @param listVo
     * @param backwaterDetailListVo
     * @param rakebackBillVo
     * @param model
     * @return
     */
    @RequestMapping("/backwaterView")
    protected String backwaterView(RakebackPlayerListVo listVo, RakebackApiListVo backwaterDetailListVo, RakebackBillVo rakebackBillVo, Model model, HttpServletRequest request) {
        rakebackBillVo.getSearch().setId(listVo.getSearch().getRakebackBillId());
        rakebackBillVo = getService().get(rakebackBillVo);//返水
        model.addAttribute("rakebackBillVo", rakebackBillVo);
        displayBackwaterDetail(listVo, backwaterDetailListVo, model);
        return ServletTool.isAjaxSoulRequest(request) ? getViewBasePath() + "ViewPartial" : getViewBasePath() + "View";
    }

    /**
     * 返水明细和返水结算列表展示
     *
     * @param listVo
     * @param backwaterDetailListVo
     * @param model
     */
    private void displayBackwaterDetail(RakebackPlayerListVo listVo, RakebackApiListVo backwaterDetailListVo, Model model) {
        //查询站长层级
        PlayerRankVo playerRankVo = new PlayerRankVo();
        List<Map<String, Object>> ranks = ServiceSiteTool.playerRankService().queryUsableRankList(playerRankVo);
        listVo = getService().searchBackwaterPlayer(listVo);//玩家返水

        //列表表头组装
        listVo = joinTabTitle(listVo, backwaterDetailListVo);

        backwaterDetailListVo = getService().searchAllBackwaterDetail(backwaterDetailListVo);//查询返水明细
        Map<Integer, Map<Integer, BackwaterApi>> map = new HashMap<>(listVo.getResult().size(), 1f);
        if (CollectionTool.isNotEmpty(listVo.getResult()) && CollectionTool.isNotEmpty(backwaterDetailListVo.getResult()) && CollectionTool.isNotEmpty(listVo.getTabTitles())) {
            Map<Integer, List<RakebackApi>> data = CollectionTool.groupByProperty(backwaterDetailListVo.getResult(), RakebackPlayer.PROP_PLAYER_ID, Integer.class);//根据玩家id划分map
            //组装每个列表下的金额
            for (RakebackPlayer obj : listVo.getResult()) {
                List<RakebackApi> details = data.get(obj.getPlayerId());
                Map<Integer, BackwaterApi> backwaterApis = new HashMap<>(listVo.getTabTitles().size(), 1f);
                Map<Integer, List<RakebackApi>> data2 = CollectionTool.groupByProperty(details, RakebackApi.PROP_API_ID, Integer.class);//根据apiId划分map
                for (TabTitle tabTitle : listVo.getTabTitles()) {
                    BackwaterApi backwaterApi = new BackwaterApi();
                    Integer apiId = tabTitle.getId();
                    backwaterApi.setId(apiId);
                    List<RakebackApi> data3 = data2.get(apiId);
                    double backwater = 0d;
                    Map<String, Double> gameTypeMap = new HashMap<>();
                    if (CollectionTool.isNotEmpty(data3)) {
                        for (RakebackApi detail : data3) {
                            Double rakebackValue = detail.getRakeback() == null ? 0d : detail.getRakeback();
                            backwater = backwater + rakebackValue;
                            gameTypeMap.put(detail.getGameType(), rakebackValue);
                        }
                    }
                    if (CollectionTool.isNotEmpty(tabTitle.getGameType())) {
                        backwaterApi.setGameTypeWater(gameTypeMap);//如果是查询api下的游戏分类，将各个游戏分类返水填充
                    }
                    backwaterApi.setBackwater(backwater);//api的返水等于各个游戏类型的返水之和
                    backwaterApis.put(apiId, backwaterApi);
                }
                map.put(obj.getPlayerId(), backwaterApis);
            }
        }
        model.addAttribute("map", map);
        model.addAttribute("command", listVo);
        model.addAttribute("ranks", ranks);
    }

    /**
     * 返水明细和返水结算列表表头组装
     *
     * @param listVo
     * @param backwaterDetailListVo
     */
    private RakebackPlayerListVo joinTabTitle(RakebackPlayerListVo listVo, RakebackApiListVo backwaterDetailListVo) {
        //表头是否更改标识
        List<TabTitle> tabTitles;
        if (StringTool.isBlank(listVo.getChangeType())) {
            tabTitles = JsonTool.fromJson(listVo.getOriginData(), new TypeReference<ArrayList<TabTitle>>() {
            });
        } else {
            tabTitles = JsonTool.fromJson(backwaterDetailListVo.getFilterData(), new TypeReference<ArrayList<TabTitle>>() {
            });
            listVo.setOriginData(backwaterDetailListVo.getFilterData());
        }
        if (CollectionTool.isEmpty(tabTitles)) {
            listVo.setTabTitles(getService().queryAllApi(listVo));
        } else {
            listVo.setTabTitles(tabTitles);
        }
        return listVo;
    }

    /**
     * 返水结算和返水明细列表中选择字段展示
     *
     * @param listVo
     * @param model
     * @return
     */
    @RequestMapping("/choose")
    protected String choose(RakebackPlayerListVo listVo, Model model) {
        listVo.setTabTitles(getService().queryAllApi(listVo));
        model.addAttribute("command", listVo);//查询所有api
        model.addAttribute("apiTypes", getService().queryAllApiType(listVo));//查询所有api类型

        Map<Integer, Map<String, RakebackApi>> gemtypes = getService().getApiGameTypes(listVo);
        model.addAttribute("gametypes", gemtypes);
        return getViewBasePath() + "Choose";
    }

    /**
     * 返水结算
     *
     * @param listVo
     * @param backwaterDetailListVo
     * @param rakebackBillVo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/settlement")
    @Token(generate = true)
    protected String settlement(RakebackPlayerListVo listVo, RakebackApiListVo backwaterDetailListVo, RakebackBillVo rakebackBillVo, Model model, HttpServletRequest request) {
        rakebackBillVo.getSearch().setId(listVo.getSearch().getRakebackBillId());
        rakebackBillVo = getService().get(rakebackBillVo);//返水
        model.addAttribute("rakebackBillVo", rakebackBillVo);
        listVo.getSearch().setSettlementState(SettlementStateEnum.PENDING_LSSUING.getCode());//查询返水状态应为待结算
        displayBackwaterDetail(listVo, backwaterDetailListVo, model);
        return ServletTool.isAjaxSoulRequest(request) ? getViewBasePath() + "SettlementPartial" : getViewBasePath() + "Settlement";
    }

    /**
     * 跳转修改实付返水页面
     *
     * @param vo
     * @return
     */
    @RequestMapping("/editBackwaterActual")
    protected String editBackwaterActual(RakebackPlayerVo vo, Model model) {
        vo = ServiceSiteTool.rakebackPlayerService().get(vo);
        if (vo.getResult() == null || vo.getResult().getPlayerId() == null) {
            return null;
        }
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setId(vo.getResult().getPlayerId());
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        model.addAttribute("command", vo);
        model.addAttribute("sysUserVo", sysUserVo);
        model.addAttribute("validateRule", JsRuleCreator.create(BackwaterActualForm.class, "result"));
        return getViewBasePath() + "EditBackwaterActual";
    }

    /**
     * 修改实付返水
     *
     * @param vo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping("/saveBackwaterActual")
    @ResponseBody
    protected Map saveBackwaterActual(RakebackPlayerVo vo, @FormModel @Valid BackwaterActualForm form, BindingResult result) {
        if (result.hasErrors()) {
            return null;
        }
        LOG.info("账号{0}修改实付返水:{1}", SessionManager.getUserName(), vo.getResult().getRakebackActual());
        vo = getService().saveBackwaterActual(vo);//修改实付返水
        return this.getVoMessage(vo);
    }

    /**
     * 跳转确认结算页面
     *
     * @param ids
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping("/backwaterSuccess")
    @Token(generate = true)
    protected String backwaterSuccess(Integer[] ids, RakebackBillVo vo, Model model) {
        vo = getService().get(vo);
        model.addAttribute("rakebackActual", getService().searchBackwaterActual(vo, ids));
        model.addAttribute("ids", ids);
        model.addAttribute("command", vo);
        model.addAttribute("master", SessionManager.getMasterInfo());
        return getViewBasePath() + "BackwaterSuccess";
    }

    /**
     * 跳转拒绝结算页面
     *
     * @param ids
     * @param model
     * @return
     */
    @RequestMapping("/backwaterFailure")
    @Token(generate = true)
    protected String backwaterFailure(Integer[] ids, Model model, RakebackBillVo vo) {
        model.addAttribute("ids", ids);
        //拒绝结算原因模板
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.REFUSE_RETURN_RABBET);
        List<NoticeLocaleTmpl> noticeLocaleTmpls = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);

        model.addAttribute("command", vo);
        model.addAttribute("noticeLocaleTmpls", noticeLocaleTmpls);
        model.addAttribute("validateRule", JsRuleCreator.create(BackwaterReasonForm.class, "result"));
        return getViewBasePath() + "BackwaterFailure";
    }

    @RequestMapping("/hasReason")
    @ResponseBody
    public Map hasReason(RakebackBillVo vo) {
        Map result = new HashMap();
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.REFUSE_RETURN_RABBET);
        List<NoticeLocaleTmpl> noticeLocaleTmpls = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);
        if (noticeLocaleTmpls != null && noticeLocaleTmpls.size() > 0) {
            result.put("state", true);
        } else {
            result.put("state", false);
        }
        return result;
    }

    /**
     * 检测实付返水金额（返水金额需小于应付返水）
     *
     * @param actual
     * @param total
     * @return
     */
    @RequestMapping("/checkBackwaterActual")
    @ResponseBody
    public String checkBackwaterActual(@RequestParam("result.rakebackActual") String actual, @RequestParam("result.rakebackPending") String total) {
        double rakebackActual = NumberTool.createDouble(actual);
        double rakebackTotal = NumberTool.createDouble(total);
        if (rakebackActual <= rakebackTotal) {
            return "true";
        } else {
            return "false";
        }
    }

    /**
     * 返水结算通过
     *
     * @param vo
     * @param ids
     * @param request
     * @return
     */
    @Token(valid = true)
    @Audit(module = Module.MASTER_OPERATION, moduleType = ModuleType.BACKWATER_SETTLEMENT_SUCCESS, opType = OpType.AUDIT)
    @RequestMapping("/settlementSuccess")
    @ResponseBody
    protected Map<String, Object> settlementSuccess(RakebackBillVo vo, @RequestParam("ids") Integer[] ids, HttpServletRequest request) {
        //所有需结算的返水信息
        if (ids == null || ids.length == 0) {
            Map map = new HashMap();
            map.put("state", false);
            return map;
        }

        vo = getService().get(vo);
        vo.getResult().setLastOperateTime(SessionManager.getDate().getNow());
        vo.getResult().setUserId(SessionManager.getUserId());
        vo.getResult().setUsername(SessionManager.getUserName());
        vo.setSettlementName(vo.getResult().getSettlementName());
        if (ServletTool.isMobile(request)) {
            vo.setOrigin(TerminalEnum.MOBILE.getName());
        }

        vo = getService().saveSettlementBackwater(vo, ids, SettlementStateEnum.LSSUING.getCode());
        if (vo.isSuccess()) {
            //更新消息
            List<RakebackPlayer> list = vo.getEligibleRakebackPlayer(); //getService().searchSettlementBackwaterPlayerByIds(vo, ids);
            List<Remark> remarks = null;
            List<Integer> userIds = null;
            if (list != null) {
                remarks = new ArrayList<>(list.size());//备注
                //备注标题内容
                String backwterName = LocaleDateTool.formatDate(vo.getResult().getEndTime(),
                        CommonContext.getDateFormat().getYEAR(), SessionManager.getTimeZone())
                        + LocaleTool.tranMessage(_Module.COMMON, "year")
                        + LocaleDateTool.formatDate(vo.getResult().getEndTime(), LocaleDateTool.getFormat("MONTH"), SessionManager.getUser().getDefaultTimezone())
                        + LocaleTool.tranMessage(_Module.COMMON, "month")
                        + vo.getResult().getPeriod()
                        + LocaleTool.tranMessage(_Module.COMMON, RakebackBill.PROP_PERIOD);
                String remarkTitle = I18nTool.getDictsMap(SessionManagerBase.getLocale().toString()).get(Module.COMMON.getCode()).get(DictEnum.COMMON_REMARK_TITLE.getType()).get(RemarkEnum.OPERATION_BACKWATER.getType()).replace("{backwatername}", backwterName);
                RakebackPlayerVo rakebackPlayerVo = new RakebackPlayerVo();
                userIds = new ArrayList<Integer>();//记录发送固定内容的玩家id
                Map<String, Pair<String, String>> localeTmplMap;//发送消息内容
                SysUserVo userVo = new SysUserVo();
                for (RakebackPlayer obj : list) {
                    if (StringTool.isNotBlank(obj.getRemark())) {
                        Remark remark = new Remark();
                        remark.setRemarkTime(SessionManager.getDate().getNow());
                        remark.setEntityId(vo.getResult().getId());
                        remark.setModel(RemarkEnum.OPERATION_BACKWATER.getModel());
                        remark.setRemarkType(RemarkEnum.OPERATION_BACKWATER.getType());
                        remark.setOperatorId(SessionManager.getUserId());
                        remark.setOperator(SessionManager.getUserName());
                        remark.setRemarkTitle(remarkTitle);
                        remark.setRemarkContent(obj.getRemark());
                        remark.setEntityUserId(obj.getPlayerId());
                        remarks.add(remark);

                        //发送结算消息
                        userVo.getSearch().setId(obj.getPlayerId());
                        localeTmplMap = new HashMap<>(1, 1f);
                        userVo = ServiceTool.sysUserService().get(userVo);
                        localeTmplMap.put(userVo.getResult().getDefaultLocale(), new Pair(remarkTitle, obj.getRemark()));
                        NoticeVo variableNoticeVo = new NoticeVo();//修改实付返水，结算后发送的内容是站长填写的备注内容
                        variableNoticeVo.setEventType(AutoNoticeEvent.RETURN_RABBET_SUCCESS);
                        variableNoticeVo.addUserIds(obj.getPlayerId());
                        variableNoticeVo.setLocaleTmplMap(localeTmplMap);
                        try {
                            ServiceTool.noticeService().publish(variableNoticeVo);
                        } catch (Exception ex) {
                            LogFactory.getLog(this.getClass()).error(ex, "发布消息不成功");
                        }
                    } else {
                        userIds.add(obj.getPlayerId());
                    }
                    rakebackPlayerVo.setResult(obj);

                    //新增操作日志
                    addLog(request, "backwater.success.msg", obj, vo);
                }
            }

            //发送消息-无修改实付返水，结算后发送固定站内信内容
            if (CollectionTool.isNotEmpty(userIds)) {
                NoticeVo noticeVo = NoticeVo.autoNotify(AutoNoticeEvent.RETURN_RABBET_SUCCESS, userIds.toArray(new Integer[userIds.size()]));
                noticeVo = addParams(vo, noticeVo);
                try {
                    ServiceTool.noticeService().publish(noticeVo);
                } catch (Exception ex) {
                    LogFactory.getLog(this.getClass()).error(ex, "发布消息不成功");
                }
            }

            //如果修改实付返水，需添加备注
            if (CollectionTool.isNotEmpty(remarks)) {
                RemarkVo remarkVo = new RemarkVo();
                remarkVo.setEntities(remarks);
                ServiceTool.getRemarkService().batchInsert(remarkVo);
            }
        }
        return this.getVoMessage(vo);
    }


    /**
     * 拒绝返水结算
     *
     * @param vo
     * @param ids
     * @param request
     * @param form
     * @param result
     * @return
     */
    @Token(valid = true)
    @Audit(module = Module.MASTER_OPERATION, moduleType = ModuleType.BACKWATER_SETTLEMENT_FAILURE, opType = OpType.AUDIT)
    @RequestMapping("/settlementReject")
    @ResponseBody
    protected Map<String, Object> settlementReject(RakebackBillVo vo, @RequestParam("ids") Integer[] ids, HttpServletRequest request, @FormModel BackwaterReasonForm form, BindingResult result) {
        if (result.hasErrors()) {
            vo.setSuccess(false);
            return getVoMessage(vo);
        }

        if (ids == null || ids.length == 0) {
            Map map = new HashMap();
            map.put("state", false);
            return map;
        }

        vo = getService().get(vo);
        vo.getResult().setLastOperateTime(SessionManager.getDate().getNow());
        vo.getResult().setUserId(SessionManager.getUserId());
        vo.getResult().setUsername(SessionManager.getUserName());
        vo = getService().saveSettlementBackwater(vo, ids, SettlementStateEnum.REJECT_LSSUING.getCode());
        if (vo.isSuccess()) {
            List<RakebackPlayer> list = vo.getEligibleRakebackPlayer(); //getService().searchSettlementBackwaterPlayerByIds(vo, ids);
            Integer[] userIds = null;
            if (list != null) {
                userIds = new Integer[list.size()];
                int i = 0;
                for (RakebackPlayer obj : list) {
                    //新增操作日志
                    addLog(request, "backwater.reject.msg", obj, vo);
                    userIds[i] = obj.getPlayerId();
                    i++;
                }
            }

            //发送信息
            if (StringTool.isNotBlank(vo.getGroupCode())) {
                NoticeVo noticeVo = NoticeVo.manualNotify(vo.getGroupCode(), null, userIds);
                noticeVo = addParams(vo, noticeVo);
                try {
                    ServiceTool.noticeService().publish(noticeVo);
                } catch (Exception ex) {
                    LOG.error(ex, "发布消息不成功");
                }
            }

        }
        return this.getVoMessage(vo);
    }

    /**
     * 添加返水信息模板展示参数
     *
     * @param vo
     * @return
     */
    private NoticeVo addParams(RakebackBillVo vo, NoticeVo noticeVo) {
        SiteCustomerService siteCustomerService = Cache.getDefaultCustomerService();
        Date endTime = vo.getResult().getEndTime();
        String timeZone = SessionManager.getUser().getDefaultTimezone();
        Pair year = new Pair(NoticeParamEnum.YEAR.getCode(), LocaleDateTool.formatDate(endTime,
                CommonContext.getDateFormat().getYEAR(), timeZone));
        Pair month = new Pair(NoticeParamEnum.MONTH.getCode(), LocaleDateTool.formatDate(endTime,
                CommonContext.getDateFormat().getMONTH(), timeZone));
        Pair period = new Pair(NoticeParamEnum.PERIOD.getCode(), vo.getResult().getPeriod());
        Pair customer;
        if (siteCustomerService != null) {
            String url = siteCustomerService.getParameter();
            if (StringTool.isNotBlank(url) && !url.contains("http")) {
                url = "http://" + url;
            }
            customer = new Pair(NoticeParamEnum.CUSTOMER.getCode(), "<a class=\"\" href=\"" + url + "\" target=\"_blank\">" + LocaleTool.tranMessage(_Module.COMMON, "contactCustomerService") + "</a>");
        } else {
            customer = new Pair(NoticeParamEnum.CUSTOMER.getCode(), LocaleTool.tranMessage(_Module.COMMON, "contactCustomerService"));
        }
        noticeVo.addParams(year, month, period, customer);
        return noticeVo;
    }

    /**
     * 返水新增日志
     *
     * @param request
     * @param description 日志描述
     * @param obj         玩家返水
     * @param vo          返水vo
     */
    private void addLog(HttpServletRequest request, String description, RakebackPlayer obj, RakebackBillVo vo) {
        LogVo logVo = new LogVo();
        BaseLog baseLog = logVo.addBussLog();
        baseLog.setDescription(description);
        baseLog.setEntityId(obj.getId());
        baseLog.setEntityUserId(obj.getPlayerId());
        baseLog.setEntityUsername(obj.getUsername());
        baseLog.addParam("date", new Param("date", SessionManager.getDate().getNow(), ParamType.DATE.getCode())).addParam(SessionManager.getUserName()).addParam(obj.getUsername()).addParam(LocaleDateTool.formatDate(vo.getResult().getEndTime(), LocaleDateTool.getFormat("YEAR"), SessionManager.getUser().getDefaultTimezone())).addParam(LocaleDateTool.formatDate(vo.getResult().getEndTime(), LocaleDateTool.getFormat("MONTH"), SessionManager.getUser().getDefaultTimezone())).addParam(vo.getResult().getPeriod());
        request.setAttribute(SysAuditLog.AUDIT_LOG, logVo);

    }

    /**
     * 返水详细
     *
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping("/backwaterDetail")
    protected String backwaterDetail(Model model, RakebackPlayerVo vo) {
        PlayerTransaction playerTransaction = getService().getPlayerTransaction(vo);
        RakebackPlayer rakebackPlayer = getService().getSettlementBackwaterPlayer(vo);
        model.addAttribute("playerTransaction", playerTransaction);
        model.addAttribute("rakebackPlayer", rakebackPlayer);
        RakebackBillVo rakebackBillVo = new RakebackBillVo();
        rakebackBillVo.getSearch().setId(rakebackPlayer.getRakebackBillId());
        model.addAttribute("rakebackBillVo", getService().get(rakebackBillVo));
        return getViewBasePath() + "BackwaterDetail";
    }

    /**
     * 返水未出账单
     *
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/rakebackNosettled")
    public String rakebackNoSettled(Model model, HttpServletRequest request, RakebackPlayerNosettledListVo listVo) {
        RakebackBillNosettledVo vo = new RakebackBillNosettledVo();
        RakebackBillNosettled rakebackBillNosettled = getService().searchRakeBillNosettled(vo);//查询最新一期未出账单
        model.addAttribute("rakebackBillNosettled", rakebackBillNosettled);

        List<Map<String, Object>> ranks = ServiceSiteTool.playerRankService().queryUsableRankList(new PlayerRankVo());//查询站长层级
        model.addAttribute("ranks", ranks);

        if (rakebackBillNosettled != null) {
            listVo.getSearch().setRakebackBillNosettledId(rakebackBillNosettled.getId());
            listVo = getService().searchRakePlayerNosettleds(listVo);

            RakebackApiNosettledListVo apiNosettledListVo = new RakebackApiNosettledListVo();
            apiNosettledListVo.getSearch().setRakebackBillNosettledId(rakebackBillNosettled.getId());
            List<RakebackApiNosettled> apiNosettleds = getService().searchRakebackApiNoseetled(apiNosettledListVo);
            listVo = rakebackNosettleTabTitle(listVo);
            listVo = rakebackApiNosettleds(model, listVo, apiNosettleds);
        }
        model.addAttribute("command", listVo);
        return ServletTool.isAjaxSoulRequest(request) ? getViewBasePath() + "RakebackNosettledPartial" : getViewBasePath() + "RakebackNosettled";
    }

    /**
     * 生成返水未出账单表头
     *
     * @param listVo
     * @return
     */
    private RakebackPlayerNosettledListVo rakebackNosettleTabTitle(RakebackPlayerNosettledListVo listVo) {
        if (StringTool.isBlank(listVo.getFilterData()) && StringTool.isBlank(listVo.getOriginData())) {
            listVo.setTabTitles(getService().queryApis(listVo));
        } else if (StringTool.isNotBlank(listVo.getOriginData())) {
            listVo.setTabTitles(JsonTool.fromJson(listVo.getOriginData(), new TypeReference<ArrayList<TabTitle>>() {
            }));
        } else {
            listVo.setTabTitles(JsonTool.fromJson(listVo.getFilterData(), new TypeReference<ArrayList<TabTitle>>() {
            }));
            listVo.setOriginData(listVo.getFilterData());
        }
        return listVo;
    }

    /**
     * 返水未出账单列表展示
     *
     * @param model
     * @param listVo
     * @param apiNosettleds
     * @return
     */
    private RakebackPlayerNosettledListVo rakebackApiNosettleds(Model model, RakebackPlayerNosettledListVo listVo, List<RakebackApiNosettled> apiNosettleds) {
        Map<Integer, Map<Integer, BackwaterApi>> rakebackApisMap = new HashMap<>(listVo.getResult().size(), 1f);
        if (!apiNosettleds.isEmpty()) {
            List<TabTitle> tabTitles = listVo.getTabTitles();
            Criteria criteria;
            BackwaterApi backwaterApi;
            double sum = 0d;//api返水
            Map<String, Double> gameTypeMap;//游戏分类返水map
            Map<Integer, BackwaterApi> rakebackApiMap;
            for (RakebackPlayerNosettled playerNosettled : listVo.getResult()) {
                rakebackApiMap = new HashMap<>();
                for (TabTitle tabTitle : tabTitles) {
                    criteria = Criteria.add(RakebackApiNosettled.PROP_PLAYER_ID, Operator.EQ, playerNosettled.getPlayerId());
                    criteria.addAnd(RakebackApiNosettled.PROP_API_ID, Operator.EQ, tabTitle.getId());
                    backwaterApi = new BackwaterApi();
                    backwaterApi.setId(tabTitle.getId());
                    List<RakebackApiNosettled> apiNosettledList = CollectionQueryTool.query(apiNosettleds, criteria);
                    gameTypeMap = new HashMap<>();//游戏分类
                    sum = 0d;
                    for (RakebackApiNosettled apiNosettled : apiNosettledList) {
                        Double rakebackNosettled = apiNosettled.getRakeback() == null ? 0d : apiNosettled.getRakeback();
                        gameTypeMap.put(apiNosettled.getGameType(), rakebackNosettled);
                        sum = sum + rakebackNosettled;
                    }
                    backwaterApi.setGameTypeWater(gameTypeMap);
                    backwaterApi.setBackwater(sum);
                    rakebackApiMap.put(tabTitle.getId(), backwaterApi);
                }
                rakebackApisMap.put(playerNosettled.getPlayerId(), rakebackApiMap);
            }
        }
        model.addAttribute("rakebackApisMap", rakebackApisMap);
        return listVo;
    }

    /**
     * 返水未出账单-选择列表展示
     *
     * @param listVo
     * @param model
     * @return
     */
    @RequestMapping("/nosettledChoose")
    protected String nosettledChoose(RakebackPlayerNosettledListVo listVo, Model model) {
        listVo.setTabTitles(getService().queryApis(listVo));
        model.addAttribute("command", listVo);//查询所有api
        model.addAttribute("apiTypes", getService().queryApiType(listVo));//查询所有api类型

        Map<Integer, Map<String, RakebackApiNosettled>> gemtypes = getService().getApiGameTypes(listVo);
        model.addAttribute("gametypes", gemtypes);
        return getViewBasePath() + "NosettledChoose";
    }

    @RequestMapping("/reSettleRakeback")
    @ResponseBody
    public Map reSettleRakeback(RakebackBillVo rakebackBillVo) {
        Map resultMap = new HashMap();
        try {
            String returnCode = getService().reSettleRakeback(rakebackBillVo);
            LOG.info("调用返水重结返回值:{0}", returnCode);
            if (RakebackSettleCodeEnum.EXCEPTION.getCode().equals(returnCode)) {
                resultMap.put("state", false);
            } else {
                resultMap.put("state", true);
            }
        } catch (Exception ex) {
            resultMap.put("state", false);
            LOG.error(ex, "返水重结出错");
        }

        return resultMap;
    }

    @RequestMapping("batchSettleRakeBack")
    @ResponseBody
    public Map<String, Object> batchSettleRakeBack(RakebackBillVo rakebackBillVo) {
        RakebackBatchSettlement rakebackBatchSettlement = new RakebackBatchSettlement();
        rakebackBatchSettlement.setSiteId(SessionManager.getSiteId());
        rakebackBatchSettlement.setLocale(SessionManager.getLocale());
        rakebackBatchSettlement.setOperateId(SessionManager.getUserId());
        rakebackBatchSettlement.setOperator(SessionManager.getUserName());
        rakebackBatchSettlement.setTimeZone(SessionManager.getTimeZone());
        rakebackBatchSettlement.setRakebackBillId(rakebackBillVo.getSearch().getId());
        rakebackBatchSettlement.setSiteCode(CommonContext.get().getSiteCode());
        try {
            TaskScheduleVo taskScheduleVo = new TaskScheduleVo();
            taskScheduleVo.setResult(new TaskSchedule(TaskScheduleEnum.BATCH_SETTLE_RAKEBACK.getCode()));
            ITaskScheduleService taskScheduleService = ServiceScheduleTool.getTaskScheduleService();
            taskScheduleService.runOnceTask(taskScheduleVo, rakebackBatchSettlement);
        } catch (Exception e) {
            LOG.error(e);
            rakebackBillVo.setSuccess(false);
        }

        return getVoMessage(rakebackBillVo);
    }

}
