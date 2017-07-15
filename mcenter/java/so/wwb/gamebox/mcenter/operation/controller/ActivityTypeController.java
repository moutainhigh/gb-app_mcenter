package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.enums.EnumTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.query.sort.Direction;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.operation.ActivityMoneyPeriodTool;
import so.wwb.gamebox.iservice.master.operation.IActivityTypeService;
import so.wwb.gamebox.mcenter.operation.form.ActivityContentStepForm;
import so.wwb.gamebox.mcenter.operation.form.ActivityTypeForm;
import so.wwb.gamebox.mcenter.operation.form.ActivityTypeSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.company.site.po.SiteI18n;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.master.enums.ActivityTypeEnum;
import so.wwb.gamebox.model.master.enums.DepositWayEnum;
import so.wwb.gamebox.model.master.operation.po.*;
import so.wwb.gamebox.model.master.operation.vo.*;
import so.wwb.gamebox.model.master.player.po.PlayerRank;
import so.wwb.gamebox.model.master.setting.po.RakebackSet;
import so.wwb.gamebox.model.master.setting.vo.RakebackSetListVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


/**
 * 活动类型表控制器
 *
 * @author eagle
 * @time 2015-10-10 18:28:55
 */
@Controller
//region your codes 1
@RequestMapping("/operation/activityType")
public class ActivityTypeController extends ActivityController<IActivityTypeService, ActivityTypeListVo, ActivityTypeVo, ActivityTypeSearchForm, ActivityTypeForm, ActivityType, Integer> {
    //endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/activityType/";
        //endregion your codes 2
    }

    //region your codes 3
    private static final String OPERATION_ACTIVITY_STEP = "/operation/activity/createStep/ActivityStep";
    private static final String OPERATION_ACTIVITY_TYPE_INDEX = "/operation/activityType/Index";
    private static final String OPERATION_ACTIVITY_VIEW_ACTIVITY_DETAIL = "/operation/activity/ViewActivityDetail";
    private static final String OPERATION_ACTIVITY_TYPE_BACK_WATER_CASE = "/operation/activityType/BackWaterCase";
    private static final String OPERATION_ACTIVITY_TYPE_REGIST_SEND_CASE = "/operation/activityType/RegistSendCase";
    private static final String OPERATION_ACTIVITY_TYPE_DEPOSIT_SEND_CASE = "/operation/activityType/DepositSendCase";
    private static final String OPERATION_ACTIVITY_TYPE_EFFECTIVE_TRANSACTION_CASE = "/operation/activityType/EffectiveTransactionCase";
    private static final String OPERATION_ACTIVITY_TYPE_FIRST_DEPOSIT_CASE = "/operation/activityType/FirstDepositCase";
    private static final String OPERATION_ACTIVITY_TYPE_PROFIT_LOSS_CASE = "/operation/activityType/ProfitLossCase";
    private static final String OPERATION_ACTIVITY_TYPE_RELIEF_FUND_CASE = "/operation/activityType/ReliefFundCase";
    private static final String OPERATION_ACTIVITY_TYPE_BACK_WATER_CASE_DIALOG = "/operation/activityType/BackWaterCaseDialog";
    private static final String OPERATION_ACTIVITY_TYPE_REGIST_SEND_CASE_DIALOG = "/operation/activityType/RegistSendCaseDialog";
    private static final String OPERATION_ACTIVITY_TYPE_DEPOSIT_SEND_CASE_DIALOG = "/operation/activityType/DepositSendCaseDialog";
    private static final String OPERATION_ACTIVITY_TYPE_EFFECTIVE_TRANSACTION_CASE_DIALOG = "/operation/activityType/EffectiveTransactionCaseDialog";
    private static final String OPERATION_ACTIVITY_TYPE_FIRST_DEPOSIT_CASE_DIALOG = "/operation/activityType/FirstDepositCaseDialog";
    private static final String OPERATION_ACTIVITY_TYPE_PROFIT_LOSS_CASE_DIALOG = "/operation/activityType/ProfitLossCaseDialog";
    private static final String OPERATION_ACTIVITY_TYPE_RELIEF_FUND_CASE_DIALOG = "/operation/activityType/ReliefFundCaseDialog";

    /**
     * 活动类型选择列表
     *
     * @param listVo
     * @param model
     * @return
     */
    @RequestMapping("/customList")
    public String activityTypeList(ActivityTypeListVo listVo, Model model) {

        List<ActivityType> activityTypeList = ServiceTool.activityTypeService().allSearch(listVo);
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
            if (ActivityTypeEnum.FIRST_DEPOSIT.getCode().equals(code) || ActivityTypeEnum.REGIST_SEND.getCode().equals(code)) {
                List<VActivityMessage> vActivityMessages = loadActivityMessageByActivityType(code);
                String combinedRanks = getCombinedRanks(vActivityMessages);
                Map<String, Object> objectMap = isAllRank(combinedRanks);
                Map<String, Object> map = filterRanksAndConvertRankIdToName(vActivityMessages);
                model.addAttribute("playerRank", combinedRanks);
                model.addAttribute("playerRanks", map.get("playerRanks"));
                model.addAttribute("isAllRank", objectMap.get("isAllRank"));
                model.addAttribute("vActivityMessages", vActivityMessages);
            } else {
                List<PlayerRank> playerRanks = getNormalPlayRanks();
                model.addAttribute("playerRanks", playerRanks);
            }

            if (ActivityTypeEnum.FIRST_DEPOSIT.getCode().equals(code) || ActivityTypeEnum.DEPOSIT_SEND.getCode().equals(code)) {
                model.addAttribute("activityDepositWays",getDepositWays());
            }
        }

        if (ActivityTypeEnum.BACK_WATER.getCode().equals(code)) {
            getNormalRakebackSet(model);
        }
        if(ActivityTypeEnum.MONEY.getCode().equals(code)){
            buildActivityMoneyData(model);
        }

        //获取活动分类
        model.addAttribute("siteI18ns", getSiteI18ns());

        //获取语言列表
        model.addAttribute("languageList", Cache.getAvailableSiteLanguage());

        vo.getSearch().setCode(code);
        ActivityTypeVo activityType = ServiceTool.activityTypeService().search(vo);
        model.addAttribute("activityType", activityType);
        model.addAttribute("validateRule", JsRuleCreator.create(ActivityContentStepForm.class));

        //创建活动时间最小为当前时间
        model.addAttribute("minDate",SessionManager.getDate().getNow());
        return OPERATION_ACTIVITY_STEP;
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

        activityMessageVo = ServiceTool.activityMessageService().get(activityMessageVo);
        List<ActivityMessageI18n> activityMessageI18ns = ServiceTool.activityMessageI18nService().activityMessageI18ns(activityMessageVo);
        if (activityMessageI18ns != null && activityMessageI18ns.size() > 0) {
            Map activityMessageI18nsMap = CollectionTool.toEntityMap(activityMessageI18ns, ActivityMessageI18n.PROP_ACTIVITY_VERSION, String.class);
            model.addAttribute("activityMessageI18ns", activityMessageI18nsMap);
        }

        //编辑功能规则页面信息
//        String states = vActivityMessageVo.getStates();
//        if (ActivityStateEnum.PROCESSING.getCode().equals(states) || ActivityStateEnum.NOTSTARTED.getCode().equals(states)) {
            vActivityMessageVo.setActivityMessageId(activityMessageVo.getSearch().getId());
            ActivityRule activityRule = ServiceTool.vActivityMessageService().getActivityRule(vActivityMessageVo);
            if (activityRule != null) {
                model.addAttribute("playerRank", activityRule.getRank() + ",");
            } else {
                model.addAttribute("playerRank", "");
            }

            model.addAttribute("activityRule", activityRule);

            //根据活动类型组装数据
            String code = activityMessageVo.getResult().getActivityTypeCode();
            if (ActivityTypeEnum.EFFECTIVE_TRANSACTION.getCode().equals(code)
                    || ActivityTypeEnum.FIRST_DEPOSIT.getCode().equals(code)
                    || ActivityTypeEnum.DEPOSIT_SEND.getCode().equals(code)) {
                List activitypreferentialList = ServiceTool.activityPreferentialRelationService().queryPreferential(vActivityMessageVo);
                model.addAttribute("activitypreferentialList", activitypreferentialList);
            }

            if (ActivityTypeEnum.REGIST_SEND.getCode().equals(code)) {
                ActivityWayRelation activityWayRelation = ServiceTool.activityWayRelationService().getActivityWayRelation(vActivityMessageVo);
                model.addAttribute("activityWayRelation", activityWayRelation);
            }

            if (ActivityTypeEnum.RELIEF_FUND.getCode().equals(code)) {
                List<ActivityPreferentialRelation> activityPreferentialRelations = ServiceTool.activityPreferentialRelationService().queryPreferentialByTransaction(vActivityMessageVo);
                List<ActivityPreferentialRelation> activityPreferentialRelationList = ServiceTool.activityPreferentialRelationService().queryPreferentialByTotal(vActivityMessageVo);
                Map map = CollectionTool.toEntityMap(activityPreferentialRelationList, ActivityPreferentialRelation.PROP_ORDER_COLUMN, Integer.class);
                List<ActivityPreferentialRelation> activityPreferentialRelationList1 = ServiceTool.activityPreferentialRelationService().queryPreferentialByLossAmount(vActivityMessageVo);
                Map map2 = CollectionTool.toEntityMap(activityPreferentialRelationList1, ActivityPreferentialRelation.PROP_ORDER_COLUMN, Integer.class);
                List<ActivityWayRelation> activityWayRelations = ServiceTool.activityWayRelationService().getActivityWayRelationList(vActivityMessageVo);
                Map map1 = CollectionTool.toEntityMap(activityWayRelations, ActivityWayRelation.PROP_ORDER_COLUMN, Integer.class);

                model.addAttribute("activityPreferentialRelations", activityPreferentialRelations);
                model.addAttribute("activityPreferentialRelationList", map);
                model.addAttribute("activityWayRelations", map1);
                model.addAttribute("activityPreferentialRelationList1", map2);
            }

            if (ActivityTypeEnum.PROFIT.getCode().equals(code)) {
                List profitPreferential = ServiceTool.activityPreferentialRelationService().queryProfitPreferential(vActivityMessageVo);
                List lossPreferential = ServiceTool.activityPreferentialRelationService().queryLossPreferential(vActivityMessageVo);
                model.addAttribute("profitPreferential", profitPreferential);
                model.addAttribute("lossPreferential", lossPreferential);
            }

            if (ActivityTypeEnum.BACK_WATER.getCode().equals(code)) {
                getNormalRakebackSet(model);
            }

            if (ActivityTypeEnum.REGIST_SEND.getCode().equals(code) || ActivityTypeEnum.FIRST_DEPOSIT.getCode().equals(code)) {
                List<VActivityMessage> vActivityMessages = loadActivityMessageByActivityType(code,activityMessageVo.getResult().getId());
                String combinedRanks = getCombinedRanks(vActivityMessages);
                Map<String, Object> objectMap = isAllRank(combinedRanks);
                Map<String, Object> map = filterRanksAndConvertRankIdToName(vActivityMessages);
                model.addAttribute("playerRank", combinedRanks);
                model.addAttribute("playerRanks", map.get("playerRanks"));
                model.addAttribute("isAllRank", objectMap.get("isAllRank"));
                model.addAttribute("vActivityMessages", vActivityMessages);
                model.addAttribute("type","edit");
            }

            if (ActivityTypeEnum.FIRST_DEPOSIT.getCode().equals(code) || ActivityTypeEnum.DEPOSIT_SEND.getCode().equals(code)) {
                model.addAttribute("activityDepositWays",getDepositWays());
            }

            if(ActivityTypeEnum.MONEY.getCode().equals(code)){
                buildActivityMoneyData(model);
                getActivityMoneyDetail(model,activityMessageVo.getSearch().getId());
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
        ActivityTypeVo activityType = ServiceTool.activityTypeService().search(activityTypeVo);
        model.addAttribute("activityType", activityType);
        model.addAttribute("activityMessageVo", activityMessageVo);
        model.addAttribute("validateRule", JsRuleCreator.create(ActivityContentStepForm.class));

        return OPERATION_ACTIVITY_STEP;
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
        activityMessageVo = ServiceTool.activityMessageService().get(activityMessageVo);
        model.addAttribute("command", activityMessageVo);

        Integer activityMessageId = activityMessageVo.getSearch().getId();
        //获取国际话信息
        ActivityMessageI18nListVo activityMessageI18nListVo = new ActivityMessageI18nListVo();
        activityMessageI18nListVo.getSearch().setActivityMessageId(activityMessageId);
        activityMessageI18nListVo = ServiceTool.activityMessageI18nService().search(activityMessageI18nListVo);
        model.addAttribute("activityMessageI18nListVo", activityMessageI18nListVo);

        //优惠条件
        ActivityRuleVo activityRuleVo = new ActivityRuleVo();
        activityRuleVo.getSearch().setActivityMessageId(activityMessageId);
        activityRuleVo = ServiceTool.activityRuleService().getActivityRule(activityRuleVo);
        model.addAttribute("activityRuleVo", activityRuleVo);

        VActivityMessage vActivityMessage = new VActivityMessage();
        vActivityMessage.setId(activityMessageId);
        vActivityMessage.setCode(activityMessageVo.getResult().getActivityTypeCode());
        VActivityMessageVo vActivityMessageVo = new VActivityMessageVo();
        vActivityMessageVo.setResult(vActivityMessage);
        Map<Integer, List<Map<String, Object>>> preferentialWayRelation = ServiceTool.vActivityMessageService().getPreferentialRelation(vActivityMessageVo);
        model.addAttribute("preferentialWayRelation", preferentialWayRelation);

        //获取返水
        if (ActivityTypeEnum.BACK_WATER.getCode().equals(activityMessageVo.getResult().getActivityTypeCode())) {
            RakebackSetListVo rakebackSetListVo = new RakebackSetListVo();
            List<RakebackSet> rakebackSets = ServiceTool.rakebackSetService().searchNormalRakebackSet(rakebackSetListVo);
            //获取结算周期
            SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.SETTING_RAKEBACKSETTING_SETTLEMENTPERIODTIMES);
            String paramValue = null;
            if (sysParam != null) {
                paramValue = sysParam.getParamValue();
            }
            model.addAttribute("rakebackSetting", paramValue);
            model.addAttribute("rakebackSets", rakebackSets);
        }
        if(ActivityTypeEnum.MONEY.getCode().equals(activityMessageVo.getResult().getActivityTypeCode())){
            getActivityMoneyDetail(model, activityMessageId);

        }
        return OPERATION_ACTIVITY_VIEW_ACTIVITY_DETAIL;
    }

    private void getActivityMoneyDetail(Model model, Integer activityMessageId) {
        ActivityOpenPeriodListVo periodListVo = new ActivityOpenPeriodListVo();
        periodListVo.setPaging(null);
        periodListVo.getSearch().setActivityMessageId(activityMessageId);
        periodListVo = ServiceTool.activityMoneyOpenPeriodService().search(periodListVo);
        ActivityMoneyPeriodTool.sortOpenPeriod(periodListVo.getResult());

        ActivityMoneyConditionListVo conditionListVo = new ActivityMoneyConditionListVo();
        conditionListVo.setPaging(null);
        conditionListVo.getSearch().setActivityMessageId(activityMessageId);
        conditionListVo = ServiceTool.activityMoneyConditionService().search(conditionListVo);

        ActivityMoneyAwardsRulesListVo rulesListVo = new ActivityMoneyAwardsRulesListVo();
        rulesListVo.setPaging(null);
        rulesListVo.getQuery().addOrder(ActivityMoneyAwardsRules.PROP_AMOUNT, Direction.ASC);
        rulesListVo.getSearch().setActivityMessageId(activityMessageId);
        rulesListVo = ServiceTool.activityMoneyAwardsRulesService().search(rulesListVo);

        model.addAttribute("periodListVo",periodListVo);
        model.addAttribute("conditionListVo",conditionListVo);
        model.addAttribute("rulesListVo",rulesListVo);
    }

    /**
     * 案例介绍
     *
     * @param vo
     * @return
     */
    @RequestMapping("/chooseCase")
    public String chooseCase(ActivityTypeVo vo) {

        if (vo == null || vo.getResult() == null) {
            return "";
        }

        String code = vo.getResult().getCode();
        String casePage = null;
        if (ActivityTypeEnum.BACK_WATER.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_BACK_WATER_CASE;
        } else if (ActivityTypeEnum.REGIST_SEND.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_REGIST_SEND_CASE;
        } else if (ActivityTypeEnum.DEPOSIT_SEND.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_DEPOSIT_SEND_CASE;
        } else if (ActivityTypeEnum.EFFECTIVE_TRANSACTION.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_EFFECTIVE_TRANSACTION_CASE;
        } else if (ActivityTypeEnum.FIRST_DEPOSIT.getCode().equals(code)) {
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
    public String chooseCaseDialog(ActivityTypeVo vo) {

        if (vo == null || vo.getResult() == null) {
            return "";
        }

        String code = vo.getResult().getCode();
        String casePage = null;
        if (ActivityTypeEnum.BACK_WATER.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_BACK_WATER_CASE_DIALOG;
        } else if (ActivityTypeEnum.REGIST_SEND.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_REGIST_SEND_CASE_DIALOG;
        } else if (ActivityTypeEnum.DEPOSIT_SEND.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_DEPOSIT_SEND_CASE_DIALOG;
        } else if (ActivityTypeEnum.EFFECTIVE_TRANSACTION.getCode().equals(code)) {
            casePage = OPERATION_ACTIVITY_TYPE_EFFECTIVE_TRANSACTION_CASE_DIALOG;
        } else if (ActivityTypeEnum.FIRST_DEPOSIT.getCode().equals(code)) {
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

        List<RakebackSet> rakebackSets = ServiceTool.rakebackSetService().searchNormalRakebackSet(new RakebackSetListVo());
        //获取结算周期
        List<SysParam> rakebackSetting = ServiceTool.vActivityMessageService().getRakebackSetting(new SysParamVo());
        model.addAttribute("rakebackSetting", rakebackSetting);
        model.addAttribute("rakebackSets", rakebackSets);
    }

    /**
     * 获取存款方式
     * @return
     */
    private List<DepositWayEnum> getDepositWays() {
        return EnumTool.getEnumList(DepositWayEnum.class);
    }

    //endregion your codes 3

}