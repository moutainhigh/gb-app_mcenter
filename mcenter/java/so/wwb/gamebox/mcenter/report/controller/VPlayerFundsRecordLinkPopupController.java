package so.wwb.gamebox.mcenter.report.controller;

import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.model.sys.po.SysParam;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.iservice.master.report.IVPlayerFundsRecordService;
import so.wwb.gamebox.mcenter.report.form.VPlayerFundsRecordForm;
import so.wwb.gamebox.mcenter.report.form.VPlayerFundsRecordSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.WeekTool;
import so.wwb.gamebox.model.master.enums.CommonStatusEnum;
import so.wwb.gamebox.model.master.report.po.VPlayerFundsRecord;
import so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordListVo;
import so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordVo;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.Map;


/**
 * 控制器
 *
 * @author linsen
 * @time 2018-6-14 10:12:15
 */
@Controller
//region your codes 1
@RequestMapping("/report/vPlayerFundsRecordLinkPopup")
public class VPlayerFundsRecordLinkPopupController extends BaseCrudController<IVPlayerFundsRecordService, VPlayerFundsRecordListVo, VPlayerFundsRecordVo, VPlayerFundsRecordSearchForm, VPlayerFundsRecordForm, VPlayerFundsRecord, Integer> {
//endregion your codes 1
    private static final Log LOG = LogFactory.getLog(VPlayerFundsRecordLinkPopupController.class);

    private static final String BY_PLAYER_DETAIL="byPlayerDetail";//玩家详细页

    private static final String BY_HOME_INDEX="byHomeIndex";//首页

    private static final String BY_ANALYZE_NEW_AGENT="analyzeNewAgent";//代理新进


    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/linkPopup/fund/";
        //endregion your codes 2
    }

    //region your codes 3

    /**
     * 资金记录链接弹窗查询展示
     *
     * @param listVo
     * @param form
     * @param result
     * @param model
     * @return
     */
    @RequestMapping("/fundsRecord")
    public String fundsRecord(VPlayerFundsRecordListVo listVo, VPlayerFundsRecordSearchForm form, BindingResult result, Model model, HttpServletRequest request) {
        initData(model);
        String linkType = listVo.getLinkType();
        LOG.info("站点：{0}，查询资金记录链接弹窗类型：linkType={1}", SessionManager.getSiteId(), linkType);
        model.addAttribute("linkType", linkType);
        //默认搜索成功订单
        if (listVo.getSearch().getStatus() == null) {
            listVo.getSearch().setStatus(CommonStatusEnum.SUCCESS.getCode());
        }

        if (BY_PLAYER_DETAIL.equals(linkType)) {//玩家详细页
            byPlayerDetail(listVo, model);
        } else if (BY_HOME_INDEX.equals(linkType)) {//首页
            byHomeIndex(listVo, model);
        } else if (BY_ANALYZE_NEW_AGENT.equals(linkType)) {//代理新进
            byAnalyzeNewAgent(listVo, model);
        } else {
            model.addAttribute("command", listVo);
        }

        if (ServletTool.isAjaxSoulRequest(request)) {
            return getViewBasePath() + "IndexPartial";
        } else {
            return getViewBasePath() + "Index";
        }
    }

    /**
     * 代理新进查询
     * @param listVo
     * @param model
     */
    private void byAnalyzeNewAgent(VPlayerFundsRecordListVo listVo,Model model){
        listVo.getSearch().setOrigin("all");
        listVo = VPlayerFundsRecordController.getFundsListByAnalyzeNewAgent(listVo);
        //根据条件汇总总金额
        listVo.setPropertyName(VPlayerFundsRecord.PROP_TRANSACTION_MONEY);
        Number sumMoney = VPlayerFundsRecordController.getAmountSumByAnalyzeNewAgent(listVo);
        model.addAttribute("command", listVo);
        model.addAttribute("sumMoney",CurrencyTool.formatCurrency(sumMoney == null ? 0 : sumMoney));
    }


    private void byPlayerDetail(VPlayerFundsRecordListVo listVo,Model model){

        if (listVo.isAnalyzeNewAgent()) {
            listVo.getSearch().setOrigin("all");
        }

        listVo = ServiceSiteTool.vPlayerFundsRecordService().search(listVo);
        model.addAttribute("command", listVo);
        //根据条件汇总总金额
        listVo.setPropertyName(VPlayerFundsRecord.PROP_TRANSACTION_MONEY);
        Number sumMoney = ServiceSiteTool.vPlayerFundsRecordService().AmountSum(listVo);
        model.addAttribute("sumMoney",CurrencyTool.formatCurrency(sumMoney == null ? 0 : sumMoney));
    }

    /**
     * 首页弹窗
     *
     * @param listVo
     * @param model
     * @return
     */
    private void byHomeIndex(VPlayerFundsRecordListVo listVo, Model model) {
        initDate(listVo);//获取查询日期
        Number sumMoney = 0;
        Integer comp = listVo.getSearch().getComp();
        if (comp != null && comp == 1) {
            //新玩家存款
            int rawOffset = SessionManager.getTimeZone().getRawOffset();
            int hour = rawOffset / 1000 / 3600;
            listVo.getSearch().setTimeZoneInterval(hour);
            listVo = ServiceSiteTool.vPlayerFundsRecordService().queryPlayerTransactionOutLink(listVo);
            sumMoney = ServiceSiteTool.vPlayerFundsRecordService().playerTransactionOutLinkSum(listVo);
        } else {
            listVo = ServiceSiteTool.vPlayerFundsRecordService().search(listVo);
            listVo.setPropertyName(VPlayerFundsRecord.PROP_TRANSACTION_MONEY);
            sumMoney = ServiceSiteTool.vPlayerFundsRecordService().AmountSum(listVo);
        }
        model.addAttribute("command", listVo);
        model.addAttribute("sumMoney",CurrencyTool.formatCurrency(sumMoney));
    }

    /**
     * 初始化数据
     * @param model
     */
    private void initData(Model model){
        //表头的状态和资金类型列表
        //model.addAttribute("dictCommonStatus", DictTool.get(DictEnum.COMMON_STATUS));
        Map<String, String> dictFundType = DictTool.get(DictEnum.COMMON_FUND_TYPE);
        //model.addAttribute("dictFundType", dictFundType);
        model.addAttribute("validateRule", JsRuleCreator.create(VPlayerFundsRecordSearchForm.class));

        //出款入口开启状态
        model.addAttribute("easyPaymentStatus",ParamTool.getSysParam(SiteParamEnum.EASY_PAYMENT).getParamValue());
        //model.addAttribute("withdrawCkeckStatus", DictTool.get(DictEnum.WITHDRAW_CHECK_STATUS));
    }

    /**
     * 通过outer控制completionTime
     * 0/null:默认最近1天
     * 小于0::不控制 即所有时间
     *
     * @param listVo
     */
    private void initDate(VPlayerFundsRecordListVo listVo) {
        Integer outer = listVo.getSearch().getOuter() == null ? 0 : listVo.getSearch().getOuter();
        if (outer != 0) {
            if (listVo.getSearch().getStartTime() != null && listVo.getSearch().getEndTime() != null) {
                return;
            }
            Date today = SessionManager.getDate().getToday();
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
                    listVo.getSearch().setEndTime(today);
                    break;
                case 4: // 上周
                    listVo.getSearch().setStartTime(DateTool.addDays(weekStartDate, -7));
                    listVo.getSearch().setEndTime(weekStartDate);
                    break;
                case 5: // 本月
                    listVo.getSearch().setStartTime(monthStartDate);
                    listVo.getSearch().setEndTime(today);
                    break;
                case 6: // 上月
                    Date lastMonthDay = DateQuickPicker.getInstance().getLastMonthFirstDay(SessionManager.getTimeZone());
                    listVo.getSearch().setStartTime(lastMonthDay);
                    listVo.getSearch().setEndTime(monthStartDate);
                    break;
                case 12: // 前天(两天前)
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -2));
                    listVo.getSearch().setEndTime(yestoday);
                    break;
                case 13: // 三天前
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -3));
                    listVo.getSearch().setEndTime(DateTool.addDays(today, -2));
                    break;
                case 14: // 四天前
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -4));
                    listVo.getSearch().setEndTime(DateTool.addDays(today, -3));
                    break;
                case 15: // 五天前
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -5));
                    listVo.getSearch().setEndTime(DateTool.addDays(today, -4));
                    break;
                case 16: // 六天前
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -6));
                    listVo.getSearch().setEndTime(DateTool.addDays(today, -5));
                    break;
                case 17: // 七天前
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -7));
                    listVo.getSearch().setEndTime(DateTool.addDays(today, -6));
                    break;
            }
        } else {
            //默认检索完成时间:最近1天
            if (listVo.getSearch().getStartTime() == null && listVo.getSearch().getEndTime() == null && listVo.getSearch().getStartCreateTime() == null && listVo.getSearch().getEndCreateTime() == null) {
                listVo.getSearch().setStartTime(SessionManager.getDate().getToday());
                listVo.getSearch().setEndTime(SessionManager.getDate().getTomorrow());
            }
        }
    }
    //endregion your codes 3

}