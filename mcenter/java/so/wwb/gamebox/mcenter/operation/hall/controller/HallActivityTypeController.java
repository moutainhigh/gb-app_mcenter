package so.wwb.gamebox.mcenter.operation.hall.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.enums.EnumTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.query.sort.Direction;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceActivityTool;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.operation.ActivityMoneyPeriodTool;
import so.wwb.gamebox.iservice.master.operation.IActivityTypeService;
import so.wwb.gamebox.mcenter.operation.form.ActivityContentStepForm;
import so.wwb.gamebox.mcenter.operation.form.ActivityTypeForm;
import so.wwb.gamebox.mcenter.operation.form.ActivityTypeSearchForm;
import so.wwb.gamebox.mcenter.operation.form.HallActivityDepositSendContentStepForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.TerminalEnum;
import so.wwb.gamebox.model.company.setting.po.ApiGametypeRelation;
import so.wwb.gamebox.model.company.setting.vo.ApiGametypeRelationListVo;
import so.wwb.gamebox.model.company.site.po.SiteI18n;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.master.content.po.CttFloatPic;
import so.wwb.gamebox.model.master.content.vo.CttFloatPicVo;
import so.wwb.gamebox.model.master.enums.ActivityTypeEnum;
import so.wwb.gamebox.model.master.enums.DepositWayEnum;
import so.wwb.gamebox.model.master.operation.po.*;
import so.wwb.gamebox.model.master.operation.vo.*;
import so.wwb.gamebox.model.master.player.po.PlayerRank;
import so.wwb.gamebox.model.master.setting.po.RakebackSet;
import so.wwb.gamebox.model.master.setting.vo.RakebackSetListVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;

import javax.servlet.http.HttpServletRequest;
import java.util.*;


/**
 * 活动类型表控制器
 *
 * @author eagle
 * @time 2015-10-10 18:28:55
 */
@Controller
//region your codes 1
@RequestMapping("/activityHall/activityType")
public class HallActivityTypeController extends HallActivityController<IActivityTypeService, ActivityTypeListVo, ActivityTypeVo, ActivityTypeSearchForm, ActivityTypeForm, ActivityType, Integer> {
    //endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/activityHall/activityType/";
        //endregion your codes 2
    }

    //region your codes 3
    private static final String OPERATION_ACTIVITY_STEP = "/operation/activityHall/activity/createStep/ActivityStep";
    private static final String OPERATION_ACTIVITY_TYPE_INDEX = "/operation/activityHall/activityType/Index";
    private static final String OPERATION_ACTIVITY_VIEW_ACTIVITY_DETAIL = "/operation/activityHall/activity/ViewActivityDetail";
    private static final String OPERATION_ACTIVITY_TYPE_BACK_WATER_CASE = "/operation/activityHall/activityType/BackWaterCase";
    private static final String OPERATION_ACTIVITY_TYPE_REGIST_SEND_CASE = "/operation/activityHall/activityType/RegistSendCase";
    private static final String OPERATION_ACTIVITY_TYPE_DEPOSIT_SEND_CASE = "/operation/activityHall/activityType/DepositSendCase";
    private static final String OPERATION_ACTIVITY_TYPE_EFFECTIVE_TRANSACTION_CASE = "/operation/activityHall/activityType/EffectiveTransactionCase";
    private static final String OPERATION_ACTIVITY_TYPE_FIRST_DEPOSIT_CASE = "/operation/activityHall/activityType/FirstDepositCase";
    private static final String OPERATION_ACTIVITY_TYPE_PROFIT_LOSS_CASE = "/operation/activityHall/activityType/ProfitLossCase";
    private static final String OPERATION_ACTIVITY_TYPE_RELIEF_FUND_CASE = "/operation/activityHall/activityType/ReliefFundCase";
    private static final String OPERATION_ACTIVITY_TYPE_BACK_WATER_CASE_DIALOG = "/operation/activityHall/activityType/BackWaterCaseDialog";
    private static final String OPERATION_ACTIVITY_TYPE_REGIST_SEND_CASE_DIALOG = "/operation/activityHall/activityType/RegistSendCaseDialog";
    private static final String OPERATION_ACTIVITY_TYPE_DEPOSIT_SEND_CASE_DIALOG = "/operation/activityHall/activityType/DepositSendCaseDialog";
    private static final String OPERATION_ACTIVITY_TYPE_EFFECTIVE_TRANSACTION_CASE_DIALOG = "/operation/activityHall/activityType/EffectiveTransactionCaseDialog";
    private static final String OPERATION_ACTIVITY_TYPE_FIRST_DEPOSIT_CASE_DIALOG = "/operation/activityHall/activityType/FirstDepositCaseDialog";
    private static final String OPERATION_ACTIVITY_TYPE_PROFIT_LOSS_CASE_DIALOG = "/operation/activityHall/activityType/ProfitLossCaseDialog";
    private static final String OPERATION_ACTIVITY_TYPE_RELIEF_FUND_CASE_DIALOG = "/operation/activityHall/activityType/ReliefFundCaseDialog";


    /**
     * 活动类型选择列表
     *
     * @param listVo
     * @param model
     * @return
     */
    @RequestMapping("/customList")
    public String activityTypeList(ActivityTypeListVo listVo, Model model) {

        List<ActivityType> activityTypeList = ServiceActivityTool.activityTypeService().allSearch(listVo);
        /*for (ActivityType activityType : activityTypeList) {
            String code = activityType.getCode();
            if (ActivityTypeEnum.FIRST_DEPOSIT.getCode().equals(code) || ActivityTypeEnum.REGIST_SEND.getCode().equals(code)) {
                activityType.setHasUseRank(hasUseRank(code));
            }
        }*/
        model.addAttribute("command", activityTypeList);
        return OPERATION_ACTIVITY_TYPE_INDEX;
    }

    /**
     * 跳转对应活动页面
     *
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping("/choose")
    @Token(generate = true)
    public String choose(ActivityTypeVo vo, Model model) {

        if (vo == null || vo.getResult() == null) {
            return "";
        }

        //获取参与层级目前只有返水优惠不需要
        String code = vo.getResult().getCode();
        if (!ActivityTypeEnum.BACK_WATER.getCode().equals(code)) {
            if (ActivityTypeEnum.DEPOSIT_SEND.getCode().equals(code)) {
                List<VActivityMessage> vActivityMessages = loadActivityMessageByActivityType(code);
                String combinedRanks = getCombinedRanks(vActivityMessages);
                Map<String, Object> objectMap = isAllRank(combinedRanks);
                Map<String, Object> map = filterRanksAndConvertRankIdToName(vActivityMessages);
                model.addAttribute("playerRank", combinedRanks);
                model.addAttribute("playerRanks", map.get("playerRanks"));
                model.addAttribute("isAllRank", objectMap.get("isAllRank"));
                model.addAttribute("vActivityMessages", vActivityMessages);
                //获取其他存就送存款方式
                String otherUsedDepositWay = getOtherUsedDepositWay(vActivityMessages);
                model.addAttribute("otherUsedDepositWay", otherUsedDepositWay);
            } else {
                List<PlayerRank> playerRanks = getNormalPlayRanks();
                model.addAttribute("playerRanks", playerRanks);
            }

            if (VActivityMessageVo.is123Deposit(code) || ActivityTypeEnum.DEPOSIT_SEND.getCode().equals(code)) {
                model.addAttribute("activityDepositWays", getDepositWays());
            }
        }

        if (ActivityTypeEnum.BACK_WATER.getCode().equals(code)) {
            getNormalRakebackSet(model);
        }
        if (ActivityTypeEnum.MONEY.getCode().equals(code)) {
            buildActivityMoneyData(model);
        }

        //获取活动分类
        model.addAttribute("siteI18ns", getSiteI18ns());

        //获取语言列表
        model.addAttribute("languageList", Cache.getAvailableSiteLanguage());

        vo.getSearch().setCode(code);
        ActivityTypeVo activityType = ServiceActivityTool.activityTypeService().search(vo);
        model.addAttribute("activityType", activityType);
        if(ActivityTypeEnum.DEPOSIT_SEND.getCode().equals(code)) {
            model.addAttribute("validateRule", JsRuleCreator.create(HallActivityDepositSendContentStepForm.class));
        }else{
            model.addAttribute("validateRule", JsRuleCreator.create(ActivityContentStepForm.class));
        }

        //创建活动时间最小为当前时间
        model.addAttribute("minDate", SessionManager.getDate().getNow());
        isSetFloat(model);

        model.addAttribute("is123Deposit", VActivityMessageVo.is123Deposit(code));

        if (ActivityTypeEnum.EFFECTIVE_TRANSACTION.getCode().equals(code) || ActivityTypeEnum.RELIEF_FUND.getCode().equals(code) || ActivityTypeEnum.PROFIT.getCode().equals(code)) {
            getApiGameTypeRelation(model);
        }
        return OPERATION_ACTIVITY_STEP;
    }

    private void getApiGameTypeRelation(Model model) {
        ApiGametypeRelationListVo apiGametypeRelationListVo = new ApiGametypeRelationListVo();
        apiGametypeRelationListVo.setPaging(null);
        apiGametypeRelationListVo = ServiceTool.apiGametypeRelationService().search(apiGametypeRelationListVo);
        List<ApiGametypeRelation> list = apiGametypeRelationListVo.getResult();
        if (CollectionTool.isNotEmpty(list)) {
            Map<String, List<ApiGametypeRelation>> apiGametypeRelationMap = CollectionTool.groupByProperty(list, ApiGametypeRelation.PROP_GAME_TYPE, String.class);
            model.addAttribute("apiGametypeRelationMap", apiGametypeRelationMap);
        }
    }

    /**
     * 活动信息编辑
     *
     * @param activityMessageVo
     * @param model
     * @return
     */
    @RequestMapping("/activityEdit")
    @Token(generate = true)
    public String activityEdit(ActivityMessageVo activityMessageVo, VActivityMessageVo vActivityMessageVo, Model model) {
        //内容的结构加了一层终端,旧数据默认为pc端数据
        activityMessageVo = ServiceActivityTool.activityMessageService().get(activityMessageVo);
        List<ActivityMessageI18n> activityMessageI18ns = ServiceActivityTool.activityMessageI18nService().activityMessageI18ns(activityMessageVo);
        Map<String, Map<String, ActivityMessageI18n>> activityMessageI18nsMap = new LinkedHashMap<>();
        if (activityMessageI18ns != null && activityMessageI18ns.size() > 0) {
            Map<String, List<ActivityMessageI18n>> groupByTerminal = new HashMap<>(4,1f);
            if (StringTool.isBlank(activityMessageI18ns.get(0).getActivityTerminalType())) {
                groupByTerminal.put(TerminalEnum.PC.getCode(), activityMessageI18ns);
            }else {
                groupByTerminal = CollectionTool.groupByProperty(activityMessageI18ns, ActivityMessageI18n.PROP_ACTIVITY_TERMINAL_TYPE, String.class);
            }
            for (String key : groupByTerminal.keySet()) {
                LinkedHashMap<String, ActivityMessageI18n> map = (LinkedHashMap) CollectionTool.toEntityMap(groupByTerminal.get(key), ActivityMessageI18n.PROP_ACTIVITY_VERSION, String.class);
                activityMessageI18nsMap.put(key, map);
            }

            model.addAttribute("activityMessageI18ns", activityMessageI18nsMap);
        }

        //编辑功能规则页面信息
//        String states = vActivityMessageVo.getStates();
//        if (ActivityStateEnum.PROCESSING.getCode().equals(states) || ActivityStateEnum.NOTSTARTED.getCode().equals(states)) {
        vActivityMessageVo.setActivityMessageId(activityMessageVo.getSearch().getId());
        ActivityRule activityRule = ServiceActivityTool.vActivityMessageService().getActivityRule(vActivityMessageVo);
        if (activityRule != null) {
            model.addAttribute("playerRank", activityRule.getRank() + ",");
        } else {
            model.addAttribute("playerRank", "");
        }

        model.addAttribute("activityRule", activityRule);

        //根据活动类型组装数据
        String code = activityMessageVo.getResult().getActivityTypeCode();
        if (ActivityTypeEnum.EFFECTIVE_TRANSACTION.getCode().equals(code)
                || VActivityMessageVo.is123Deposit(code)
                || ActivityTypeEnum.DEPOSIT_SEND.getCode().equals(code)) {
            List activitypreferentialList = ServiceActivityTool.activityPreferentialRelationService().queryPreferential(vActivityMessageVo);
            model.addAttribute("activitypreferentialList", activitypreferentialList);
        }

        if (ActivityTypeEnum.REGIST_SEND.getCode().equals(code)) {
            ActivityWayRelation activityWayRelation = ServiceActivityTool.activityWayRelationService().getActivityWayRelation(vActivityMessageVo);
            model.addAttribute("activityWayRelation", activityWayRelation);
            //注册送有效条件
            ActivityPreferentialRelationListVo activityPreferentialRelationListVo = new ActivityPreferentialRelationListVo();
            activityPreferentialRelationListVo.getSearch().setActivityMessageId(vActivityMessageVo.getActivityMessageId());
            ActivityPreferentialRelationListVo effectiveCondition = ServiceActivityTool.activityPreferentialRelationService().search(activityPreferentialRelationListVo);
            @SuppressWarnings("deprecation")
            Set effectiveConditionSet = CollectionTool.extractToMap(effectiveCondition.getResult(), ActivityPreferentialRelation.PROP_PREFERENTIAL_CODE, ActivityPreferentialRelation.PROP_PREFERENTIAL_VALUE).keySet();
            model.addAttribute("effectiveConditionSet", effectiveConditionSet);

        }

        if (ActivityTypeEnum.RELIEF_FUND.getCode().equals(code)) {
            List<ActivityPreferentialRelation> activityPreferentialRelationList = ServiceActivityTool.activityPreferentialRelationService().queryPreferentialByTotal(vActivityMessageVo);
            Map map = CollectionTool.toEntityMap(activityPreferentialRelationList, ActivityPreferentialRelation.PROP_ORDER_COLUMN, Integer.class);
            List<ActivityPreferentialRelation> activityPreferentialRelationList1 = ServiceActivityTool.activityPreferentialRelationService().queryPreferentialByLossAmount(vActivityMessageVo);
            Map map2 = CollectionTool.toEntityMap(activityPreferentialRelationList1, ActivityPreferentialRelation.PROP_ORDER_COLUMN, Integer.class);
            List<ActivityWayRelation> activityWayRelations = ServiceActivityTool.activityWayRelationService().getActivityWayRelationList(vActivityMessageVo);
            Map map1 = CollectionTool.toEntityMap(activityWayRelations, ActivityWayRelation.PROP_ORDER_COLUMN, Integer.class);
            //把有效投注额去掉了,所以需要传一个list过去遍历
            model.addAttribute("activityPreferentialRelationTotal", activityPreferentialRelationList);
            model.addAttribute("activityPreferentialRelationList", map);
            model.addAttribute("activityWayRelations", map1);
            model.addAttribute("activityPreferentialRelationList1", map2);
        }

        if (ActivityTypeEnum.PROFIT.getCode().equals(code)) {
            List profitPreferential = ServiceActivityTool.activityPreferentialRelationService().queryProfitPreferential(vActivityMessageVo);
            List lossPreferential = ServiceActivityTool.activityPreferentialRelationService().queryLossPreferential(vActivityMessageVo);
            model.addAttribute("profitPreferential", profitPreferential);
            model.addAttribute("lossPreferential", lossPreferential);
        }

        if (ActivityTypeEnum.BACK_WATER.getCode().equals(code)) {
            getNormalRakebackSet(model);
        }

        if (ActivityTypeEnum.DEPOSIT_SEND.getCode().equals(code)) {
            List<VActivityMessage> vActivityMessages = loadActivityMessageByActivityType(code, activityMessageVo.getResult().getId());
            String combinedRanks = getCombinedRanks(vActivityMessages);
            Map<String, Object> objectMap = isAllRank(combinedRanks);
            Map<String, Object> map = filterRanksAndConvertRankIdToName(vActivityMessages);
            model.addAttribute("playerRank", combinedRanks);
            model.addAttribute("playerRanks", map.get("playerRanks"));
            model.addAttribute("isAllRank", objectMap.get("isAllRank"));
            model.addAttribute("vActivityMessages", vActivityMessages);
            model.addAttribute("type", "edit");
            //获取其他存就送存款方式
            String otherUsedDepositWay = getOtherUsedDepositWay(vActivityMessages);
            model.addAttribute("otherUsedDepositWay", otherUsedDepositWay);
        }


        if (VActivityMessageVo.is123Deposit(code) || ActivityTypeEnum.DEPOSIT_SEND.getCode().equals(code)) {
            model.addAttribute("activityDepositWays", getDepositWays());
        }
        if (ActivityTypeEnum.MONEY.getCode().equals(code)) {
            buildActivityMoneyData(model);
            getActivityMoneyDetail(model, activityMessageVo.getSearch().getId());
        }

//        }

        //获取参与层级
        if (!ActivityTypeEnum.BACK_WATER.getCode().equals(activityMessageVo.getResult().getActivityTypeCode())) {
            List<PlayerRank> playerRanks = getNormalPlayRanks();
            model.addAttribute("playerRanks", playerRanks);
        }

        //获取活动
        List<SiteI18n> siteI18nList = getSiteI18ns();
        model.addAttribute("siteI18ns", siteI18nList);

        //获取语言列表
        model.addAttribute("languageList", Cache.getAvailableSiteLanguage());

        ActivityTypeVo activityTypeVo = new ActivityTypeVo();
        activityTypeVo.getSearch().setCode(activityMessageVo.getResult().getActivityTypeCode());
        ActivityTypeVo activityType = ServiceActivityTool.activityTypeService().search(activityTypeVo);
        model.addAttribute("activityType", activityType);
        model.addAttribute("activityMessageVo", activityMessageVo);
        //存就送需要验证名称重复
        if(ActivityTypeEnum.DEPOSIT_SEND.getCode().equals(code)) {
            model.addAttribute("validateRule", JsRuleCreator.create(HallActivityDepositSendContentStepForm.class));
        }else{
            model.addAttribute("validateRule", JsRuleCreator.create(ActivityContentStepForm.class));
        }

        isSetFloat(model);

        model.addAttribute("is123Deposit", VActivityMessageVo.is123Deposit(code));

        if (ActivityTypeEnum.EFFECTIVE_TRANSACTION.getCode().equals(code) || ActivityTypeEnum.RELIEF_FUND.getCode().equals(code) || ActivityTypeEnum.PROFIT.getCode().equals(code)) {
            getApiGameTypeRelation(model);
            getActivityRuleIncludeGameMap(activityMessageVo, model);
        }
        return OPERATION_ACTIVITY_STEP;
    }

    /**
     * 已经被其他(存就送活动)使用的存款方式
     * @param vActivityMessages
     * @return
     */
    private String getOtherUsedDepositWay(List<VActivityMessage> vActivityMessages) {
        StringBuilder stringBuilder = new StringBuilder();
        for (int i = 0; i < vActivityMessages.size(); i++) {
            stringBuilder.append(vActivityMessages.get(i).getDepositWay()).append(",");
        }
        return stringBuilder.toString();
    }


//    public

    private void getActivityRuleIncludeGameMap(ActivityMessageVo activityMessageVo, Model model) {
        ActivityRuleIncludeGameListVo activityRuleIncludeGameListVo = new ActivityRuleIncludeGameListVo();
        activityRuleIncludeGameListVo.getSearch().setActivityMessageId(activityMessageVo.getResult().getId());
        activityRuleIncludeGameListVo.setPaging(null);
        activityRuleIncludeGameListVo = ServiceActivityTool.activityRuleIncludeGameService().search(activityRuleIncludeGameListVo);
        List<ActivityRuleIncludeGame> activityRuleIncludeGameList = activityRuleIncludeGameListVo.getResult();
        if (CollectionTool.isNotEmpty(activityRuleIncludeGameList)) {
            Map<String, List<ActivityRuleIncludeGame>> activityRIGMap = CollectionTool.groupByProperty(activityRuleIncludeGameList, ActivityRuleIncludeGame.PROP_GAME_TYPE, String.class);
            model.addAttribute("activityRIGMap", activityRIGMap);
        }
    }

    /*是否设置红包--首页浮层弹窗*/
    private void isSetFloat(Model model) {
        CttFloatPicVo cttFloatPicVo = new CttFloatPicVo();
        cttFloatPicVo.getSearch().setPicType("2");
        cttFloatPicVo.getSearch().setStatus(true);
        List<CttFloatPic> cttFloatPics = ServiceSiteTool.cttFloatPicService().isExistAgent(cttFloatPicVo);
        String isExist = "true";
        if (CollectionTool.isNotEmpty(cttFloatPics) && cttFloatPics.size() > 0) {
            isExist = "false";
            Integer id = cttFloatPics.get(0).getId();
            model.addAttribute("id", id);
        }
        model.addAttribute("isPicType", isExist);
    }


    /**
     * 活动详情
     *
     * @param activityMessageVo
     * @param model
     * @return
     */
    @RequestMapping("/viewActivityDetail")
    public String viewActivityDetail(ActivityMessageVo activityMessageVo, Model model) {

        //语言列表
        Map<String, SiteLanguage> siteLanguageMap = Cache.getAvailableSiteLanguage();
        model.addAttribute("languageList", siteLanguageMap.values());

        //活动分类
        Map<String, SiteI18n> siteI18nMap = Cache.getOperateActivityClassify();
        Map<String, SiteI18n> tempMap = new LinkedHashMap<>();
        for (Map.Entry<String, SiteI18n> entry : siteI18nMap.entrySet()) {
            SiteI18n siteI18n = entry.getValue();
            if (SessionManager.getLocale().toString().equals(siteI18n.getLocale())) {
                tempMap.put(siteI18n.getKey(), siteI18n);
            }
        }
        model.addAttribute("siteI18nMap", tempMap);

        //获取活动基本信息
        activityMessageVo = ServiceActivityTool.activityMessageService().get(activityMessageVo);
        activityMessageVo.setTotalPeriods(queryTotalCount(activityMessageVo.getResult().getId()));
        model.addAttribute("command", activityMessageVo);
        model.addAttribute("is123Deposit", VActivityMessageVo.is123Deposit(activityMessageVo.getResult().getActivityTypeCode()));

        Integer activityMessageId = activityMessageVo.getSearch().getId();
        //获取国际话信息
        ActivityMessageI18nListVo activityMessageI18nListVo = new ActivityMessageI18nListVo();
        activityMessageI18nListVo.getSearch().setActivityMessageId(activityMessageId);
        activityMessageI18nListVo = ServiceActivityTool.activityMessageI18nService().search(activityMessageI18nListVo);
        model.addAttribute("activityMessageI18nListVo", activityMessageI18nListVo);

        //优惠条件
        ActivityRuleVo activityRuleVo = new ActivityRuleVo();
        activityRuleVo.getSearch().setActivityMessageId(activityMessageId);
        activityRuleVo = ServiceActivityTool.activityRuleService().getActivityRule(activityRuleVo);
        model.addAttribute("activityRuleVo", activityRuleVo);

        VActivityMessage vActivityMessage = new VActivityMessage();
        vActivityMessage.setId(activityMessageId);
        vActivityMessage.setCode(activityMessageVo.getResult().getActivityTypeCode());
        VActivityMessageVo vActivityMessageVo = new VActivityMessageVo();
        vActivityMessageVo.setResult(vActivityMessage);
        Map<Integer, List<Map<String, Object>>> preferentialWayRelation = ServiceActivityTool.vActivityMessageService().getPreferentialRelation(vActivityMessageVo);
        model.addAttribute("preferentialWayRelation", preferentialWayRelation);

        //注册送,有效条件,(不想多加字段,就放在了PreferentialRelation表,只要有code=xx标识就算有这个条件了)
        if (ActivityTypeEnum.REGIST_SEND.getCode().equals(activityMessageVo.getResult().getActivityTypeCode())) {
            ActivityPreferentialRelationListVo activityPreferentialRelationListVo = new ActivityPreferentialRelationListVo();
            activityPreferentialRelationListVo.getSearch().setActivityMessageId(activityMessageVo.getSearch().getId());
            ActivityPreferentialRelationListVo registeEffectiveListVo = ServiceActivityTool.activityPreferentialRelationService().search(activityPreferentialRelationListVo);
            model.addAttribute("registeEffectiveList", registeEffectiveListVo.getResult());
        }


        //获取返水
        if (ActivityTypeEnum.BACK_WATER.getCode().equals(activityMessageVo.getResult().getActivityTypeCode())) {
            RakebackSetListVo rakebackSetListVo = new RakebackSetListVo();
            List<RakebackSet> rakebackSets = ServiceSiteTool.rakebackSetService().searchNormalRakebackSet(rakebackSetListVo);
            //获取结算周期
            SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.SETTING_RAKEBACKSETTING_SETTLEMENTPERIODTIMES);
            String paramValue = null;
            if (sysParam != null) {
                paramValue = sysParam.getParamValue();
            }
            model.addAttribute("rakebackSetting", paramValue);
            model.addAttribute("rakebackSets", rakebackSets);
        }
        if (ActivityTypeEnum.MONEY.getCode().equals(activityMessageVo.getResult().getActivityTypeCode())) {
            getActivityMoneyDetail(model, activityMessageId);

        }
        model.addAttribute("is123Deposit", VActivityMessageVo.is123Deposit(activityMessageVo.getResult().getActivityTypeCode()));
        return OPERATION_ACTIVITY_VIEW_ACTIVITY_DETAIL;
    }

    private Long queryTotalCount(Integer activityMessageId) {
        ActivityMoneyDefaultWinVo objectVo = new ActivityMoneyDefaultWinVo();
        objectVo.setResult(new ActivityMoneyDefaultWin());
        objectVo.getResult().setActivityMessageId(activityMessageId);
        return ServiceActivityTool.activityMoneyDefaultWinService().countTotalPeriod(objectVo);
    }

    private void getActivityMoneyDetail(Model model, Integer activityMessageId) {
        ActivityOpenPeriodListVo periodListVo = new ActivityOpenPeriodListVo();
        periodListVo.setPaging(null);
        periodListVo.getSearch().setActivityMessageId(activityMessageId);
        periodListVo = ServiceActivityTool.activityMoneyOpenPeriodService().search(periodListVo);
        ActivityMoneyPeriodTool.sortOpenPeriod(periodListVo.getResult());

        ActivityMoneyConditionListVo conditionListVo = new ActivityMoneyConditionListVo();
        conditionListVo.setPaging(null);
        conditionListVo.getSearch().setActivityMessageId(activityMessageId);
        conditionListVo = ServiceActivityTool.activityMoneyConditionService().search(conditionListVo);

        ActivityMoneyAwardsRulesListVo rulesListVo = new ActivityMoneyAwardsRulesListVo();
        rulesListVo.setPaging(null);
        rulesListVo.getQuery().addOrder(ActivityMoneyAwardsRules.PROP_AMOUNT, Direction.ASC);
        rulesListVo.getSearch().setActivityMessageId(activityMessageId);
        rulesListVo = ServiceActivityTool.activityMoneyAwardsRulesService().search(rulesListVo);

        model.addAttribute("periodListVo", periodListVo);
        model.addAttribute("conditionListVo", conditionListVo);
        model.addAttribute("rulesListVo", rulesListVo);
    }

    /**
     * 案例介绍
     *
     * @param vo
     * @return
     */
    @RequestMapping("/chooseCase")
    public String chooseCase(ActivityTypeVo vo, Model model) {

        if (vo == null || vo.getResult() == null) {
            return "";
        }

        String code = vo.getResult().getCode();
        model.addAttribute("activityType",code);
        String casePage = null;
        if (ActivityTypeEnum.BACK_WATER.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_BACK_WATER_CASE;
        } else if (ActivityTypeEnum.REGIST_SEND.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_REGIST_SEND_CASE;
        } else if (ActivityTypeEnum.DEPOSIT_SEND.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_DEPOSIT_SEND_CASE;
        } else if (ActivityTypeEnum.EFFECTIVE_TRANSACTION.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_EFFECTIVE_TRANSACTION_CASE;
        } else if (VActivityMessageVo.is123Deposit(code) || ActivityTypeEnum.MONEY.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_FIRST_DEPOSIT_CASE;
        } else if (ActivityTypeEnum.PROFIT.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_PROFIT_LOSS_CASE;
        } else if (ActivityTypeEnum.RELIEF_FUND.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_RELIEF_FUND_CASE;
        }
        return casePage;
    }

    /**
     * 案例介绍弹窗
     *
     * @param vo
     * @return
     */
    @RequestMapping("/chooseCaseDialog")
    public String chooseCaseDialog(ActivityTypeVo vo, Model model) {

        if (vo == null || vo.getResult() == null) {
            return "";
        }

        String code = vo.getResult().getCode();
        model.addAttribute("activityType",code);
        String casePage = null;
        if (ActivityTypeEnum.BACK_WATER.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_BACK_WATER_CASE_DIALOG;
        } else if (ActivityTypeEnum.REGIST_SEND.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_REGIST_SEND_CASE_DIALOG;
        } else if (ActivityTypeEnum.DEPOSIT_SEND.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_DEPOSIT_SEND_CASE_DIALOG;
        } else if (ActivityTypeEnum.EFFECTIVE_TRANSACTION.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_EFFECTIVE_TRANSACTION_CASE_DIALOG;
        } else if (VActivityMessageVo.is123Deposit(code)  || ActivityTypeEnum.MONEY.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_FIRST_DEPOSIT_CASE_DIALOG;
        } else if (ActivityTypeEnum.PROFIT.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_PROFIT_LOSS_CASE_DIALOG;
        } else if (ActivityTypeEnum.RELIEF_FUND.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_RELIEF_FUND_CASE_DIALOG;
        }
        return casePage;
    }

    /**
     * 添加活动分类后对下拉框的回调刷新
     *
     * @return
     */
    @RequestMapping("/refreshSiteI8n")
    @ResponseBody
    public List<SiteI18n> refreshSiteI8n() {
        return getSiteI18ns();
    }

    /**
     * 获取活动分类
     *
     * @return
     */
    private List<SiteI18n> getSiteI18ns() {
        Map<String, SiteI18n> siteI18nMap = Cache.getOperateActivityClassify();
        List<SiteI18n> siteI18ns = new ArrayList<>();
        String language = SessionManager.getLocale().toString();
        for (String siteI18nMapKey : siteI18nMap.keySet()) {
            String[] key = StringTool.split(siteI18nMapKey, ":");
            if (language.equals(key[1])) {
                siteI18ns.add(siteI18nMap.get(siteI18nMapKey));
            }
        }
        return siteI18ns;

    }

    /**
     * 获取正常的返水优惠
     *
     * @param model
     */
    private void getNormalRakebackSet(Model model) {

        List<RakebackSet> rakebackSets = ServiceSiteTool.rakebackSetService().searchNormalRakebackSet(new RakebackSetListVo());
        //获取结算周期
        List<SysParam> rakebackSetting = ServiceActivityTool.vActivityMessageService().getRakebackSetting(new SysParamVo());
        model.addAttribute("rakebackSetting", rakebackSetting);
        model.addAttribute("rakebackSets", rakebackSets);
        model.addAttribute("rakebackPeriod", ParamTool.getSysParam(SiteParamEnum.SETTING_RAKEBACKSETTING_SETTLEMENTPERIODTIMES));
    }

    /**
     * 获取存款方式
     *
     * @return
     */
    private List<DepositWayEnum> getDepositWays() {
        return EnumTool.getEnumList(DepositWayEnum.class);
    }

    /**
     * 判断开始时间 结束时间
     *
     * @param request
     * @param startTime
     * @param endTime
     * @return
     */
    @RequestMapping("/checkTime")
    @ResponseBody
    public String checkTime(HttpServletRequest request, @RequestParam("activityMessage.startTime") Date startTime, @RequestParam("activityMessage.endTime") Date endTime) {
        return startTime.getTime() >= endTime.getTime() ? "false" : "true";
    }

    /**
     * 检查活动名称是否重复
     * @param activityContentStepForm
     * @return
     */
    @RequestMapping(value = "/checkActivityName")
    @ResponseBody
    public String checkActivityName(@FormModel HallActivityDepositSendContentStepForm activityContentStepForm, HttpServletRequest request) {

        VActivityMessageListVo vActivityMessageListVo = new VActivityMessageListVo();
        vActivityMessageListVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(VActivityMessage.PROP_ACTIVITY_NAME, Operator.EQ,activityContentStepForm.getActivityMessageI18ns$$_activityName()[0]),
                new Criterion(VActivityMessage.PROP_CODE, Operator.EQ,activityContentStepForm.getResult_code()),
                new Criterion(VActivityMessage.PROP_ID, Operator.NE,activityContentStepForm.getResult_id())
        });
        long count = ServiceActivityTool.vActivityMessageService().count(vActivityMessageListVo);
        return Boolean.valueOf(count <= 0).toString();
    }

    //endregion your codes 3

}