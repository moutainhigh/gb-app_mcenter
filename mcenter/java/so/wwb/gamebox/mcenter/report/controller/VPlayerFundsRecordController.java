package so.wwb.gamebox.mcenter.report.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.net.ServletTool;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.model.sys.po.SysParam;
import org.soul.web.session.SessionManagerBase;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceActivityTool;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.report.IVPlayerFundsRecordService;
import so.wwb.gamebox.mcenter.report.form.VPlayerFundsRecordForm;
import so.wwb.gamebox.mcenter.report.form.VPlayerFundsRecordSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.*;
import so.wwb.gamebox.model.boss.enums.ExportFileTypeEnum;
import so.wwb.gamebox.model.boss.enums.TemplateCodeEnum;
import so.wwb.gamebox.model.company.setting.po.SysExport;
import so.wwb.gamebox.model.company.setting.vo.SysExportVo;
import so.wwb.gamebox.model.company.site.po.SiteApi;
import so.wwb.gamebox.model.master.enums.CommonStatusEnum;
import so.wwb.gamebox.model.master.fund.enums.TransactionTypeEnum;
import so.wwb.gamebox.model.master.fund.enums.TransactionWayEnum;
import so.wwb.gamebox.model.master.fund.vo.PlayerFavorableVo;
import so.wwb.gamebox.model.master.fund.vo.PlayerRechargeVo;
import so.wwb.gamebox.model.master.fund.vo.PlayerWithdrawListVo;
import so.wwb.gamebox.model.master.operation.vo.ActivityMessageVo;
import so.wwb.gamebox.model.master.operation.vo.RakebackBillVo;
import so.wwb.gamebox.model.master.operation.vo.RakebackPlayerVo;
import so.wwb.gamebox.model.master.report.po.VPlayerFundsRecord;
import so.wwb.gamebox.model.master.report.so.VPlayerFundsRecordSo;
import so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordListVo;
import so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.report.controller.AbstractExportController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * 控制器
 *
 * @author faker
 * @time 2016-11-9 10:52:15
 */
@Controller
//region your codes 1
@RequestMapping("/report/vPlayerFundsRecord")
public class VPlayerFundsRecordController extends AbstractExportController<IVPlayerFundsRecordService, VPlayerFundsRecordListVo, VPlayerFundsRecordVo, VPlayerFundsRecordSearchForm, VPlayerFundsRecordForm, VPlayerFundsRecord, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/report/funds/";
        //endregion your codes 2
    }

    //region your codes 3

    /**
     * 通过条件查询返回不同页面
     *
     * @param listVo
     * @param form
     * @param result
     * @param model
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/fundsLog")
    public String fundsLog(VPlayerFundsRecordListVo listVo, VPlayerFundsRecordSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        initDate(listVo, model);
        trimSearch(listVo);
        //在搜素的时候资金记录查询条件相关的内容无需重新查询一次
        if (!ServletTool.isAjaxSoulRequest(request)) {
            //所有可用的玩家层级
            //model.addAttribute("playerRanks", ServiceSiteTool.playerRankService().queryUsableList(new PlayerRankVo()));
            //账号类型列表
            model.addAttribute("userTypeSearchKeys", initUserTypeSearchKeys());
            //搜索模板
            model.addAttribute("searchTempCode", TemplateCodeEnum.TRANSACTION.getCode());
            model.addAttribute("searchTemplates", CacheBase.getSysSearchTempByCondition(SessionManagerBase.getUserId(), TemplateCodeEnum.TRANSACTION.getCode()));

        }

        //表头的状态和资金类型列表
        model.addAttribute("dictCommonStatus", DictTool.get(DictEnum.COMMON_STATUS));
        Map<String, String> dictFundType = DictTool.get(DictEnum.COMMON_FUND_TYPE);
        model.addAttribute("dictFundType", dictFundType);
        model.addAttribute("validateRule", JsRuleCreator.create(VPlayerFundsRecordSearchForm.class));

        Map<String, SiteApi> siteApiMaps = Cache.getSiteApi(SessionManager.getSiteId());
        model.addAttribute("siteApiMaps", siteApiMaps);
        withdrawAccountIsSwitch(model);//是否开启出款账户
        model.addAttribute("withdrawCkeckStatus", DictTool.get(DictEnum.WITHDRAW_CHECK_STATUS));

        //默认搜索成功订单:列表页面
        if (listVo.getSearch().getStatus() == null) {
            listVo.getSearch().setStatus(CommonStatusEnum.SUCCESS.getCode());
        }
        if (listVo.isAnalyzeNewAgent()) {
            listVo.getSearch().setOrigin("all");
        }
        //判断进入统计页面或资金列表页面
        if (isSummary(listVo)) {
            /** 统计汇总页面 */
            //统计玩家稽核扣除
            PlayerWithdrawListVo playerWithdrawListVo = new PlayerWithdrawListVo();
            playerWithdrawListVo.getSearch().setStartTime(listVo.getSearch().getStartTime());
            playerWithdrawListVo.getSearch().setEndTime(listVo.getSearch().getEndTime());
            //统计:公司入款 玩家取款 线上支付 人工取出 人工存入 玩家优惠
            model.addAttribute("fundsSum", ServiceSiteTool.vPlayerFundsRecordService().fundsSum(listVo));
            //第一次加载页面时,判断加载统计页面或者资金列表页面
            model.addAttribute("isSummary", true);
            model.addAttribute("command", listVo);
            if (ServletTool.isAjaxSoulRequest(request)) {
                return getViewBasePath() + "Summary";
            } else {
                return getViewBasePath() + "Index";
            }
        } else {
            /** 资金列表页面 */
            //首页的新用户订单
            Integer comp = listVo.getSearch().getComp();
            if (comp != null && comp == 1) {
                int rawOffset = SessionManager.getTimeZone().getRawOffset();
                int hour = rawOffset / 1000 / 3600;
                listVo.getSearch().setTimeZoneInterval(hour);
                listVo = ServiceSiteTool.vPlayerFundsRecordService().queryPlayerTransactionOutLink(listVo);
            } else {
                //查询列表
                if (listVo.isAnalyzeNewAgent()) {
                    listVo.getSearch().setOrigin("");
                    Integer searchType = listVo.getSearchType();
                    if (searchType != null) {
                        if (searchType == 1) {
                            listVo.getSearch().setTransactionType("deposit");
                            listVo = ServiceSiteTool.vPlayerFundsRecordService().queryPlayerTransactionOrder(listVo);
                        } else if (searchType == 2) {
                            listVo.getSearch().setTransactionType("withdrawals");
                            listVo = ServiceSiteTool.vPlayerFundsRecordService().queryPlayerTransactionOrder(listVo);
                        } else if (searchType == 3) {
                            listVo.getSearch().setTransactionType("deposit");
                            listVo = ServiceSiteTool.vPlayerFundsRecordService().queryPlayerTransactionTotalOrder(listVo);
                        } else if (searchType == 4) {
                            listVo.getSearch().setTransactionType("withdrawals");
                            listVo = ServiceSiteTool.vPlayerFundsRecordService().queryPlayerTransactionTotalOrder(listVo);
                        } else if (searchType == 5) {
                            listVo.getSearch().setTransactionType("deposit");
                            listVo = ServiceSiteTool.vPlayerFundsRecordService().queryTotalTransactionOrder(listVo);
                        } else {
                            listVo.getSearch().setTransactionType("withdrawals");
                            listVo = ServiceSiteTool.vPlayerFundsRecordService().queryTotalTransactionOrder(listVo);
                        }
                    }
                } else {
                    listVo = super.doList(listVo, form, result, model);
                }
            }
            String queryParamsJson = JsonTool.toJson(listVo.getSearch());
            model.addAttribute("queryParamsJson", queryParamsJson);
            model.addAttribute("command", listVo);
            //根据条件汇总总金额
            listVo.setPropertyName(VPlayerFundsRecord.PROP_TRANSACTION_MONEY);
            //第一次加载页面时,判断加载统计页面或者资金列表页面
            model.addAttribute("isSummary", false);
            if (ServletTool.isAjaxSoulRequest(request)) {
                return getViewBasePath() + "IndexPartial";
            } else {
                return getViewBasePath() + "Index";
            }
        }
    }

    /**
     * 根据条件判断进入返回汇总或列表页面
     *
     * @param listVo
     * @return
     */
    private boolean isSummary(VPlayerFundsRecordListVo listVo) {
        return StringTool.isBlank(listVo.getSearch().getTransactionNo()) &&
                StringTool.isBlank(listVo.getSearch().getUsernames()) &&
                StringTool.isBlank(listVo.getSearch().getOrigin()) &&
                listVo.getSearch().getTransactionWays() == null &&
                listVo.getSearch().getManualWithdraws() == null &&
                listVo.getSearch().getStartCreateTime() == null &&
                listVo.getSearch().getManualSaves() == null &&
                listVo.getSearch().getEndCreateTime() == null &&
                listVo.getSearch().getPlayerRanks() == null &&
                listVo.getSearch().getStartMoney() == null &&
                listVo.getSearch().getEndMoney() == null &&
                listVo.getSearch().getFundTypes() == null &&
                listVo.getSearch().getApiList() == null;
    }

    /**
     * 账号类型列表
     */
    private List<Pair> initUserTypeSearchKeys() {
        List<Pair> searchKeys;
        searchKeys = new ArrayList<>();
        searchKeys.add(new Pair("username", LocaleTool.tranView(Module.COLUMN.getCode(), "playerAccount")));
        searchKeys.add(new Pair("agentname", LocaleTool.tranView(Module.COLUMN.getCode(), "agentAccount")));
        searchKeys.add(new Pair("topagentname", LocaleTool.tranView(Module.COLUMN.getCode(), "agentTopAccount")));
        return searchKeys;
    }

    /**
     * 通过outer控制completionTime
     * 0/null:默认最近7天
     * 小于0::不控制 即所有时间
     *
     * @param listVo
     * @param model
     */
    private void initDate(VPlayerFundsRecordListVo listVo, Model model) {
        Integer outer = listVo.getSearch().getOuter() == null ? 0 : listVo.getSearch().getOuter();
        if (outer != 0) {
            if (listVo.getSearch().getStartTime() != null && listVo.getSearch().getEndTime() != null) {
                return;
            }
            Date today = SessionManager.getDate().getToday();
            Date now = SessionManager.getDate().getNow();
            Date weekStartDate = WeekTool.getWeekStartDate(today,null);
            Date monthStartDate = DateQuickPicker.getInstance().getMonthFirstDay(SessionManager.getTimeZone());
            Date tomorrow = DateQuickPicker.getInstance().getTomorrow();
            Date yestoday = DateQuickPicker.getInstance().getYestoday();
            switch (outer) {
                case 1: // 今日
                    listVo.getSearch().setStartTime(today);
                    listVo.getSearch().setEndTime(tomorrow);
                    break;
                case 2: // 昨日
                    listVo.getSearch().setStartTime(SessionManager.getDate().getYestoday());
                    listVo.getSearch().setEndTime(today);
                case 11:
                    listVo.getSearch().setStartTime(SessionManager.getDate().getYestoday());
                    listVo.getSearch().setEndTime(today);
                    break;
                case 3: // 本周
                    listVo.getSearch().setStartTime(weekStartDate);
                    listVo.getSearch().setEndTime(tomorrow);
                    break;
                case 4: // 上周
                    listVo.getSearch().setStartTime(DateTool.addDays(weekStartDate, -7));
                    listVo.getSearch().setEndTime(weekStartDate);
                    break;
                case 5: // 本月
                    listVo.getSearch().setStartTime(monthStartDate);
                    listVo.getSearch().setEndTime(tomorrow);
                    break;
                case 6: // 上月
                    Date lastMonthDay = DateQuickPicker.getInstance().getLastMonthFirstDay(SessionManager.getTimeZone());
                    listVo.getSearch().setStartTime(lastMonthDay);
                    listVo.getSearch().setEndTime(monthStartDate);
                    break;
                case 12: // 前天
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -2));
                    listVo.getSearch().setEndTime(yestoday);
                    break;
                case 13: // 大前天
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -3));
                    listVo.getSearch().setEndTime(DateTool.addDays(today, -2));
                    break;
                case 14: // 大大前天
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -4));
                    listVo.getSearch().setEndTime(DateTool.addDays(today, -3));
                    break;
                case 15: // 大大大前天
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -5));
                    listVo.getSearch().setEndTime(DateTool.addDays(today, -4));
                    break;
                case 16: // 大大大大前天
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -6));
                    listVo.getSearch().setEndTime(DateTool.addDays(today, -5));
                    break;
                case 17: // 大大大大大前天
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -7));
                    listVo.getSearch().setEndTime(DateTool.addDays(today, -6));
                    break;
            }
        } else {
            //默认检索完成时间:最近7天
            if (listVo.getSearch().getStartTime() == null && listVo.getSearch().getEndTime() == null && listVo.getSearch().getStartCreateTime() == null && listVo.getSearch().getEndCreateTime() == null) {
                listVo.getSearch().setStartTime(SessionManager.getDate().getToday());
                listVo.getSearch().setEndTime(SessionManager.getDate().getTomorrow());
            }
        }
    }

    /**
     * 导出数据
     *
     * @param vo
     * @return
     */
    @Override
    protected SysExportVo buildExportData(SysExportVo vo) {
        if (vo.getResult() == null) {
            vo.setResult(new SysExport());
        }
        vo.setExportFileType(ExportFileTypeEnum.PLAYER_FUND_REPORT.getCode());
        vo.setExportLocale(SessionManager.getLocale().toString());
        vo.getResult().setService(IVPlayerFundsRecordService.class.getName());
        vo.getResult().setMethod("searchCustomFundsRecord");
        vo.getResult().setParam(VPlayerFundsRecordListVo.class.getName());
        vo.getResult().setUsername(SessionManager.getUserName());
        vo.getResult().setExportUserId(SessionManager.getUserId());
        vo.getResult().setExportUserSiteId(SessionManager.getSiteId());
        if (vo.getResult().getSiteId() == null) {
            vo.getResult().setSiteId(SessionManager.getSiteId());
        }
        vo.getResult().setFileName(LocaleTool.tranView("export", "fund_report") + "-"
                + DateTool.formatDate(DateQuickPicker.getInstance().getNow(), SessionManager.getLocale(), SessionManager.getTimeZone(), "yyyyMMddHHmmss"));
        return vo;
    }

    @RequestMapping("/initSum")
    @ResponseBody
    public String initSum(VPlayerFundsRecordListVo listVo, VPlayerFundsRecordSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        listVo.setAnalyzeStartTime(listVo.getBeginTime());
        listVo.setAnalyzeEndTime(listVo.getEndTime());
        initDate(listVo, model);
        trimSearch(listVo);
        Integer comp = listVo.getSearch().getComp();
        Number sumMoney = 0;
        if (comp != null && comp == 1) {
            int rawOffset = SessionManager.getTimeZone().getRawOffset();
            int hour = rawOffset / 1000 / 3600;
            listVo.getSearch().setTimeZoneInterval(hour);
            sumMoney = ServiceSiteTool.vPlayerFundsRecordService().playerTransactionOutLinkSum(listVo);

        }
        if (listVo.isAnalyzeNewAgent()) {
            Integer searchType = listVo.getSearchType();
            if (searchType != null) {
                if (searchType == 1 || searchType == 2) {
                    sumMoney = ServiceSiteTool.vPlayerFundsRecordService().queryPlayerTransactionOrderSum(listVo);
                } else if (searchType == 3 || searchType == 4) {
                    sumMoney = ServiceSiteTool.vPlayerFundsRecordService().queryPlayerTransactionTotalOrderSum(listVo);
                } else {
                    sumMoney = ServiceSiteTool.vPlayerFundsRecordService().queryTotalTransactionOrderSum(listVo);
                }
            }
        } else {
            sumMoney = ServiceSiteTool.vPlayerFundsRecordService().AmountSum(listVo);
        }
        return CurrencyTool.formatCurrency(sumMoney == null ? 0 : sumMoney);
    }

    /**
     * 重写doView方法
     *
     * @param objectVo
     * @param model
     * @return
     */
    @Override
    protected VPlayerFundsRecordVo doView(VPlayerFundsRecordVo objectVo, Model model) {
        objectVo = getService().get(objectVo);
        Integer sourceId = objectVo.getResult().getSourceId();
        String transactionType = objectVo.getResult().getTransactionType();
        VPlayerFundsRecordVo vo = super.doView(objectVo, model);
        SysUserVo operator = new SysUserVo();
        Map<String, Object> map = JsonTool.fromJson(vo.getResult().getTransactionData(), Map.class);
        if (StringTool.equals(transactionType, TransactionTypeEnum.FAVORABLE.getCode())) {
            //优惠名称
            if (map != null) {
                if (map.get(SessionManager.getLocale().toString()) != null) {

                    vo.getResult().setTransactionData(map.get(SessionManager.getLocale().toString()).toString());
                } else if (map.get("activityName") != null) {
                    vo.getResult().setTransactionData(map.get("activityName").toString());
                }
            }
        } else if (StringTool.equals(transactionType, TransactionTypeEnum.BACKWATER.getCode())) {
            Date d = new Date((long) map.get("date"));
            RakebackBillVo rakebackBillVo = new RakebackBillVo();
            rakebackBillVo.getSearch().setEndTime(d);
            rakebackBillVo.getSearch().setPeriod(map.get("period").toString());
            rakebackBillVo = ServiceSiteTool.rakebackBillService().getOneByEndtimeAndPeriod(rakebackBillVo);
            if (rakebackBillVo != null && rakebackBillVo.getResult() != null) {
                vo.setBackwaterCircle(DateTool.formatDate(rakebackBillVo.getResult().getStartTime(), DateTool.yyyy_MM_dd) + " ~ " + DateTool.formatDate(rakebackBillVo.getResult().getEndTime(), DateTool.yyyy_MM_dd));
                RakebackPlayerVo rakebackPlayerVo = new RakebackPlayerVo();
                rakebackPlayerVo.getSearch().setPlayerId(vo.getResult().getPlayerId());
                rakebackPlayerVo.getSearch().setRakebackBillId(rakebackBillVo.getResult().getId());
                rakebackPlayerVo = ServiceSiteTool.rakebackPlayerService().getOneByPlayerAndBill(rakebackPlayerVo);
                if (rakebackPlayerVo != null && rakebackPlayerVo.getResult() != null) {
                    vo.setBackwaterTotal(rakebackPlayerVo.getResult().getRakebackTotal());
                }
            }
        }


        //操作人
        PlayerFavorableVo playerFavorableVo = new PlayerFavorableVo();
        playerFavorableVo.getSearch().setTransactionNo(vo.getResult().getTransactionNo());
        playerFavorableVo = ServiceSiteTool.playerFavorableService().getOneByTransactionNo(playerFavorableVo);
        if (playerFavorableVo != null && playerFavorableVo.getResult() != null) {
            operator.getSearch().setId(playerFavorableVo.getResult().getOperatorId());
            if (ServiceTool.sysUserService().get(operator).getResult() != null) {
                if (operator.getSearch().getId() == null) {
                    vo.setOperator("系统自动");
                } else {
                    vo.setOperator((ServiceTool.sysUserService().get(operator)).getResult().getUsername());
                }
                if (StringTool.equals(transactionType, TransactionTypeEnum.FAVORABLE.getCode()) && !StringTool.equals(vo.getResult().getTransactionWay(), TransactionWayEnum.REFUND_FEE.getCode())) {
                    //活动是否下架
                    ActivityMessageVo amVo = new ActivityMessageVo();
                    amVo.getSearch().setId(playerFavorableVo.getResult().getActivityMessageId());
                    amVo = ServiceActivityTool.activityMessageService().get(amVo);
                    if (amVo.getResult() != null && !amVo.getResult().getIsDeleted()) {
                        vo.setActivityMessageId(playerFavorableVo.getResult().getActivityMessageId());
                    }
                } else if (StringTool.equals(vo.getResult().getTransactionWay(), TransactionWayEnum.REFUND_FEE.getCode())) {
                    PlayerRechargeVo playerRechargeVo = new PlayerRechargeVo();
                    playerRechargeVo.getSearch().setId(playerFavorableVo.getResult().getPlayerRechargeId());
                    playerRechargeVo = ServiceSiteTool.playerRechargeService().get(playerRechargeVo);
                    vo.setDepositTransactionNo(playerRechargeVo.getResult().getTransactionNo());
                    vo.setDepositMoney(playerRechargeVo.getResult().getRechargeAmount());
                }
            } else {
                vo.setActivityMessageId(playerFavorableVo.getResult().getActivityMessageId());
            }
            //稽核倍数
            vo.setAuditFavorableMultiple(playerFavorableVo.getResult().getAuditFavorableMultiple());
            //稽核来源
            vo.setFavorableSource(playerFavorableVo.getResult().getFavorableSource());
        } else {
            vo.setOperator("系统自动");
        }

        return vo;
    }

    /**
     * 自动清空前后的空格
     *
     * @param listVo
     */
    private void trimSearch(VPlayerFundsRecordListVo listVo) {
        VPlayerFundsRecordSo so = listVo.getSearch();
        if (StringTool.isNotBlank(so.getUsernames())) {
            so.setUsernames(so.getUsernames().trim());
        }
        if (StringTool.isNotBlank(so.getTransactionNo())) {
            so.setTransactionNo(so.getTransactionNo());
        }
    }

    /**
     * 是否开启出款账户
     *
     * @param model
     */
    private void withdrawAccountIsSwitch(Model model) {
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.WITHDRAW_ACCOUNT);
        model.addAttribute("isSwitch", sysParam.getIsSwitch());
    }

    //endregion your codes 3

}