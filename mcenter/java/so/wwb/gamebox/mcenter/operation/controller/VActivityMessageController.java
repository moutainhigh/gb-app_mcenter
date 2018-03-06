package so.wwb.gamebox.mcenter.operation.controller;


import com.fasterxml.jackson.core.type.TypeReference;
import org.apache.commons.collections.map.ListOrderedMap;
import org.soul.commons.collections.CollectionQueryTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.LogFactory;
import org.soul.commons.query.Criteria;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.query.sort.Direction;
import org.soul.commons.support._Module;
import org.soul.model.log.audit.enums.OpType;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceActivityTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.operation.ActivityMoneyPeriodTool;
import so.wwb.gamebox.iservice.master.operation.IVActivityMessageService;
import so.wwb.gamebox.mcenter.operation.form.*;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.SendMessageTool;
import so.wwb.gamebox.model.*;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.common.ContentCheckEnum;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.company.serve.po.SiteContentAudit;
import so.wwb.gamebox.model.company.serve.vo.SiteContentAuditVo;
import so.wwb.gamebox.model.company.site.po.SiteI18n;
import so.wwb.gamebox.model.company.site.vo.SiteI18nListVo;
import so.wwb.gamebox.model.company.site.vo.SiteI18nVo;
import so.wwb.gamebox.model.master.enums.ActivityClaimPeriod;
import so.wwb.gamebox.model.master.enums.ActivityStateEnum;
import so.wwb.gamebox.model.master.enums.ActivityTypeEnum;
import so.wwb.gamebox.model.master.enums.UserTaskEnum;
import so.wwb.gamebox.model.master.operation.po.*;
import so.wwb.gamebox.model.master.operation.vo.*;
import so.wwb.gamebox.web.BussAuditLogTool;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;

import javax.validation.Valid;
import java.io.Serializable;
import java.util.*;

/**
 * 控制器
 *
 * @author eagle
 * @time 2015-10-10 20:02:39
 */
@Controller
//region your codes 1
@RequestMapping("/operation/activity")
public class VActivityMessageController extends ActivityController<IVActivityMessageService, VActivityMessageListVo,
        VActivityMessageVo, VActivityMessageSearchForm, VActivityMessageForm, VActivityMessage, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/activity/";
        //endregion your codes 2
    }

    //region your codes 3

    /**
     * 优惠活动列表
     *
     * @param listVo
     * @param form
     * @param result
     * @param model
     * @return
     */
    @Override
    protected VActivityMessageListVo doList(VActivityMessageListVo listVo, VActivityMessageSearchForm form,
                                            BindingResult result, Model model) {

        String localLanguage = SessionManager.getLocale().toString();

        //活动状态
        Map<String, Serializable> activityState = DictTool.get(DictEnum.ACTIVITY_STATE);
        model.addAttribute("activityState", activityState);

        //活动类型
        Map<String, Serializable> activityType = DictTool.get(DictEnum.ACTIVITY_TYPE);
        model.addAttribute("activityType", activityType);

        //获取site18n信息
        Map<String, SiteI18n> siteI18nMap = Cache.getOperateActivityClassify();
        Map<String, SiteI18n> tempMap = new LinkedHashMap<>();
        for (Map.Entry<String, SiteI18n> entry : siteI18nMap.entrySet()) {
            SiteI18n siteI18n = entry.getValue();
            if (localLanguage.equals(siteI18n.getLocale())) {
                tempMap.put(siteI18n.getKey(), siteI18n);
            }
        }
        model.addAttribute("siteI18nMap", tempMap);
        model.addAttribute("siteI18ns", new ArrayList<>(tempMap.values()));

        model.addAttribute("localLanguage", localLanguage);

        listVo.getSearch().setActivityVersion(localLanguage);
        listVo.getSearch().setIsDeleted(Boolean.FALSE);
        //过滤掉状态用＂---＂表示状态的数据
        /*if (ActivityStateEnum.PROCESSING.getCode().equals(listVo.getSearch().getStates())
                || ActivityStateEnum.FINISHED.getCode().equals(listVo.getSearch().getStates())) {
            listVo.getSearch().setCheckStatus(ContentCheckEnum.PASS.getCode());
        }*/

        //增加按照状态排序
        listVo.getQuery().addOrder(VActivityMessage.PROP_LIST_ORDER_NUM,Direction.ASC).addOrder(VActivityMessage.PROP_START_TIME,Direction.DESC);

        VActivityMessageListVo vActivityMessageListVo = this.getService().search(listVo);
        /*if (vActivityMessageListVo.getResult() != null) {
            for (VActivityMessage vActivityMessage : vActivityMessageListVo.getResult()) {
                String code = vActivityMessage.getCode();
                if (ActivityTypeEnum.FIRST_DEPOSIT.getCode().equals(code) || ActivityTypeEnum.REGIST_SEND.getCode().equals(code)) {
                    vActivityMessage.setHasUseRank(hasUseRank(vActivityMessage.getCode()));
                }
            }
        }*/

        return vActivityMessageListVo;
    }

    /**
     * 删除活动信息更新isDeleted
     *
     * @return
     */
    @RequestMapping("/deleteActivity")
    @ResponseBody
    public Map deleteActivityMessage(ActivityMessageVo activityMessageVo) {
        activityMessageVo.setProperties(ActivityMessage.PROP_IS_DELETED);
        activityMessageVo.getResult().setIsDeleted(true);
        activityMessageVo = ServiceActivityTool.activityMessageService().updateOnly(activityMessageVo);
        HashMap map = new HashMap(2, 1f);
        if (activityMessageVo.isSuccess()) {
            Cache.refreshActivityMessages();
            Cache.refreshCurrentSitePageCache();
            map.put("okMsg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_SUCCESS));
        } else {
            map.put("errMsg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_FAILED));
        }
        map.put("state", activityMessageVo.isSuccess());
        return map;
    }

    /**
     * 活动分类管理
     *
     * @param model
     * @return
     */
    @RequestMapping("/classificationManager")
    @Token(generate = true)
    protected String sortManager(Model model) {
        Map<String, SiteI18n> siteI18nMap = Cache.getOperateActivityClassify();
        Map<String, Map<String, SiteI18n>> command = new ListOrderedMap();
        for (String siteI18nKey : siteI18nMap.keySet()) {
            String[] keyLocale = StringTool.split(siteI18nKey, ":");
            if (command.get(keyLocale[0]) == null) {
                command.put(keyLocale[0], new HashMap<String, SiteI18n>());
            }
            command.get(keyLocale[0]).put(keyLocale[1], siteI18nMap.get(siteI18nKey));
        }
        model.addAttribute("command", command);
        model.addAttribute("siteLang", CacheBase.getAvailableSiteLanguage());//语言分类
        model.addAttribute("validate", JsRuleCreator.create(ClassficationForm.class));//表单验证
        return getViewBasePath() + "ClassificationManager";
    }

    /**
     * 删除活动分类
     *
     * @param key
     * @return
     */
    @RequestMapping("/deleteClassificationManager")
    @ResponseBody
    protected Map deleteClassificationManager(String key, SiteI18nVo vo) {
        Map<String, SiteI18n> siteI18nMap = Cache.getOperateActivityClassify();
        List<SiteI18n> siteI18ns = CollectionQueryTool.query(siteI18nMap.values(), Criteria.add(SiteI18n.PROP_KEY, Operator.EQ, key));
        boolean isDefault = false;
        //判断是否为默认分类，如果是默认分类不能删除
        for (SiteI18n siteI18n : siteI18ns) {
            if (siteI18n.getBuiltIn() != null && siteI18n.getBuiltIn()) {
                isDefault = true;
                break;
            }
        }
        Map<String, Object> map = new HashMap(4, 1f);
        map.put("isDefault", isDefault);
        if (isDefault) {
            map.put("msg", LocaleTool.tranMessage(Module.MASTER_OPERATION.getCode(), "classification.defaultNotDelete"));
            return map;
        }
        ActivityMessageListVo activityMessageListVo = new ActivityMessageListVo();
        activityMessageListVo.getSearch().setActivityClassifyKey(key);
        long count = getService().queryActivityCount(activityMessageListVo);//该分类下的优惠活动数量
        boolean hasActivity = count > 0;//是否含优惠活动
        //非默认分类无优惠活动，直接删除
        map.put("hasActivity", hasActivity);
        if (!hasActivity) {
            //删除活动分类
            vo.getQuery().setCriterions(new Criterion[]{
                    new Criterion(SiteI18n.PROP_MODULE, Operator.EQ, Module.MASTER_OPERATION.getCode()),
                    new Criterion(SiteI18n.PROP_TYPE, Operator.EQ, SiteI18nEnum.OPERATE_ACTIVITY_CLASSIFY.getType()),
                    new Criterion(SiteI18n.PROP_KEY, Operator.EQ, key)
            });
            boolean state = ServiceTool.siteI18nService().batchDeleteCriteria(vo) >= 0;
            map.put("state", state);
            if (state) {
                CacheBase.refreshSiteI18n(SiteI18nEnum.OPERATE_ACTIVITY_CLASSIFY);
                Cache.refreshCurrentSitePageCache();
                map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_SUCCESS));
            } else {
                map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_FAILED));
            }
            return map;
        }
        //非默认分类，且该分类下含有优惠活动，提示用户
        map.put("msg", LocaleTool.tranMessage(Module.MASTER_OPERATION.getCode(), "classification.ClassificationHasActivityConfirmToDelete").replace("{}", count + ""));
        return map;
    }

    /**
     * 删除含有优惠活动的分类（更新优惠的活动分类为默认分类，删除该活动分类）
     *
     * @param key
     * @return
     */
    @RequestMapping("/deleteClassification")
    @ResponseBody
    protected Map deleteClassification(String key) {
        SiteI18nVo vo = new SiteI18nVo();
        //批量删除分类的查询条件
        vo.getQuery().setCriterions(new Criterion[]{
                new Criterion(SiteI18n.PROP_MODULE, Operator.EQ, Module.MASTER_OPERATION.getCode()),
                new Criterion(SiteI18n.PROP_TYPE, Operator.EQ, SiteI18nEnum.OPERATE_ACTIVITY_CLASSIFY.getType()),
                new Criterion(SiteI18n.PROP_KEY, Operator.EQ, key)
        });

        /**
         * Cache.getSiteI18n(SiteI18nEnum.OPERATE_ACTIVITY_CLASSIFY);
         * 修改为：
         * Cache.getOperateActivityClassify();
         * 默认分类，不属于站点分类，这里做特殊处理
         */
        Map<String, SiteI18n> siteI18nMap = Cache.getOperateActivityClassify();
        for (SiteI18n siteI18n : siteI18nMap.values()) {
            if (siteI18n.getBuiltIn() != null && siteI18n.getBuiltIn()) {
                vo.setDefaultKey(siteI18n.getKey());
                break;
            }
        }
        vo.getSearch().setKey(key);
        boolean state = getService().deleteClassification(vo);
        Map<String, Object> map = new HashMap<>(2, 1f);
        map.put("state", state);
        if (state) {
            CacheBase.refreshSiteI18n(SiteI18nEnum.OPERATE_ACTIVITY_CLASSIFY);
            Cache.refreshCurrentSitePageCache();
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_SUCCESS));
        } else {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_FAILED));
        }
        return map;
    }

    /**
     * 保存活动分类
     *
     * @return
     */
    @RequestMapping(value = "/saveClassification")
    @ResponseBody
    @Token(valid = true)
    protected Map saveClassfication(String data, @FormModel @Valid ClassficationForm form, BindingResult result) {
        if (result.hasErrors()) {
            return null;
        }
        List<Classification> list = JsonTool.fromJson(data, new TypeReference<ArrayList<Classification>>() {
        });
        SiteI18nListVo listVo = new SiteI18nListVo();
        listVo.setClassifications(list);
        listVo.setSiteId(SessionManager.getSiteId());
        listVo = ServiceTool.siteI18nService().saveClassification(listVo);
        if (listVo.isSuccess()) {
            CacheBase.refreshSiteI18n(SiteI18nEnum.OPERATE_ACTIVITY_CLASSIFY);
            Cache.refreshCurrentSitePageCache();
        }
        return getVoMessage(listVo);
    }

    /**
     * 活动内容下一步按钮
     *
     * @return
     */
    @RequestMapping("/activityRule")
    @ResponseBody
    public Map activityRule(ActivityTypeVo activityTypeVo) {

        //获取参与层级
        String code = activityTypeVo.getResult().getCode();
        String activityRuleForm = createActivityRuleForm(code);

        Map list = new HashMap();
        list.put("activityRuleForm", activityRuleForm);

        return list;
    }

    /**
     * 活动规则页面上一步表单重新绑定
     *
     * @return
     */
    @RequestMapping("/activityRulePre")
    @ResponseBody
    public String activityRulePre() {
        return JsRuleCreator.create(ActivityContentStepForm.class);
    }

    /**
     * 活动预览页面上一步表单重新绑定
     *
     * @return
     */
    @RequestMapping("/activityPreviewPre")
    @ResponseBody
    public String activityPreviewPre(ActivityTypeVo activityTypeVo) {
        return createActivityRuleForm(activityTypeVo.getResult().getCode());
    }

    /**
     * 第一步活动内容保存草稿
     *
     * @param activityTypeVo
     * @param model
     * @return
     */
    @RequestMapping("/activityContentDraft")
    @ResponseBody
    @Token(valid = true)
    public Map activityContentDraft(ActivityTypeVo activityTypeVo, VActivityMessageVo vActivityMessageVo, Model model) {

        assignment(activityTypeVo, vActivityMessageVo);

        int activityMessageId;
        if (ActivityTypeEnum.CONTENT.getCode().equals(activityTypeVo.getResult().getCode())) {
            activityMessageId = ServiceActivityTool.vActivityMessageService().saveContentAndRuleDraft(vActivityMessageVo);
        } else {
            activityMessageId = ServiceActivityTool.vActivityMessageService().saveContentDraft(vActivityMessageVo);
        }

        model.addAttribute("activityMessageId", activityMessageId);
        Map params = getVoMessage(vActivityMessageVo);
        params.put("activityMessageId", activityMessageId);
        params.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
        return params;
    }

    /**
     * 第二步活动规则草稿保存
     *
     * @param activityTypeVo
     * @param model
     * @return
     */
    @RequestMapping("/activityRuleDraft")
    @ResponseBody
    @Token(valid = true)
    public Map activityRuleDraft(ActivityTypeVo activityTypeVo, VActivityMessageVo vActivityMessageVo, Model model) {

        vActivityMessageVo.setCode(activityTypeVo.getResult().getCode());
        assignment(activityTypeVo, vActivityMessageVo);

        int activityMessageId = ServiceActivityTool.vActivityMessageService().saveContentAndRuleDraft(vActivityMessageVo);
        model.addAttribute("activityMessageId", activityMessageId);
        Map params = getVoMessage(vActivityMessageVo);
        params.put("activityMessageId", activityMessageId);
        params.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
        return params;
    }

    /**
     * 活动预览发布
     *
     * @param activityTypeVo
     * @param vActivityMessageVo
     * @return
     */
    @RequestMapping("/activityRelease")
    @ResponseBody
    @Token(valid = true)
    @Audit(module = Module.ACTIVITY, moduleType = ModuleType.ACTIVITY_ACTIVITYRELEASE_SUCCESS, opType = OpType.CREATE)
    public Map activityRelease(ActivityTypeVo activityTypeVo, VActivityMessageVo vActivityMessageVo) {
        Map map = new HashMap(2, 1f);
        try {
            vActivityMessageVo.setCode(activityTypeVo.getResult().getCode());
            assignment(activityTypeVo, vActivityMessageVo);


            boolean success = ServiceActivityTool.vActivityMessageService().activityRelease(vActivityMessageVo);

            if (success) {
                updateSiteContentAudit();
                Cache.refreshActivityMessages();// 发布和编辑刷新缓存
                Cache.refreshCurrentSitePageCache();
                map.put("okMsg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_SUCCESS));
                //日志
                String logPara1 = activityTypeVo.getResult() == null ? "" : activityTypeVo.getResult().getName();
                String logPara2 = (vActivityMessageVo.getActivityMessageI18ns() == null || vActivityMessageVo.getActivityMessageI18ns().size() < 0)
                        ? "" : vActivityMessageVo.getActivityMessageI18ns().get(0).getActivityName();
                BussAuditLogTool.addBussLog(Module.ACTIVITY, ModuleType.ACTIVITY_ACTIVITYRELEASE_SUCCESS, OpType.CREATE, "ACTIVITY_ACTIVITYRELEASE_SUCCESS",
                        logPara1, logPara2);
            } else {
                map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
                map.put("errMsg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
            }
            map.put("state", success);
            //推送任务给运营商
            SendMessageTool.addTaskReminder(UserTaskEnum.ACTIVITY);
            SendMessageTool.sendAuditMessageToCcenter();
        } catch (Exception ex) {
            map.put("state", false);
            map.put("errMsg", ex.getMessage());
            map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
            LogFactory.getLog(this.getClass()).error(ex, "保存活动异常");
        }


        return map;
    }


    private void updateSiteContentAudit() {
        SiteContentAudit contentAudit = ServiceActivityTool.vActivityMessageUserService().countCompanyAuditCount(new ActivityMessageVo());
        if (contentAudit == null) {
            return;
        }
        SiteContentAudit oldRecord = getSiteContentAuditBySiteId();
        if (oldRecord == null) {
            oldRecord = new SiteContentAudit();
            oldRecord.setSiteId(SessionManager.getSiteId());
            oldRecord.setActivityReadCount(contentAudit.getActivityReadCount());
            oldRecord.setActivityRemoveCount(contentAudit.getActivityRemoveCount());
            oldRecord.setActivityTotalCount(contentAudit.getActivityTotalCount());
            SiteContentAuditVo vo = new SiteContentAuditVo();
            vo.setResult(oldRecord);
            ServiceTool.siteContentAuditService().insert(vo);
        } else {
            oldRecord.setActivityReadCount(contentAudit.getActivityReadCount());
            oldRecord.setActivityRemoveCount(contentAudit.getActivityRemoveCount());
            oldRecord.setActivityTotalCount(contentAudit.getActivityTotalCount());
            SiteContentAuditVo vo = new SiteContentAuditVo();
            vo.setResult(oldRecord);
            vo.setProperties(SiteContentAudit.PROP_ACTIVITY_READ_COUNT, SiteContentAudit.PROP_ACTIVITY_REMOVE_COUNT, SiteContentAudit.PROP_ACTIVITY_TOTAL_COUNT);
            ServiceTool.siteContentAuditService().updateOnly(vo);
        }
    }

    private SiteContentAudit getSiteContentAuditBySiteId() {
        SiteContentAuditVo siteContentAuditVo = new SiteContentAuditVo();
        siteContentAuditVo.getSearch().setSiteId(SessionManager.getSiteId());
        siteContentAuditVo = ServiceTool.siteContentAuditService().search(siteContentAuditVo);
        return siteContentAuditVo.getResult();
    }

    /**
     * 前端展示开关启用，停用切换
     *
     * @param activityMessageVo
     * @return
     */
    @RequestMapping(value = "/changeDisplayStatus")
    @ResponseBody
    public Map changeDisplayStatus(ActivityMessageVo activityMessageVo) {
        activityMessageVo = ServiceActivityTool.activityMessageService().updateDisplayStatus(activityMessageVo);
        /*activityMessageVo.setProperties(ActivityMessage.PROP_IS_DISPLAY);
        activityMessageVo = ServiceSiteTool.activityMessageService().updateOnly(activityMessageVo);
        */
        Cache.refreshActivityMessages(SessionManager.getSiteId());
        Cache.refreshCurrentSitePageCache();
        Map map = new HashMap();
        map.put("state", activityMessageVo.isSuccess());
        return map;
    }

    /**
     * 远程验证--检测开始时间大于
     *
     * @return
     */
    @RequestMapping(value = "/checkStartDate")
    @ResponseBody
    public String checkStartDate(@RequestParam("activityMessage.startTime") Date startDate) {
        return startDate.getTime() >= SessionManager.getDate().getNow().getTime() ? "true" : "false";
    }

    /**
     * 表单验证绑定
     *
     * @param code
     * @return
     */
    private String createActivityRuleForm(String code) {
        String activityRule = null;
        if (ActivityTypeEnum.FIRST_DEPOSIT.getCode().equals(code)
                || ActivityTypeEnum.DEPOSIT_SEND.getCode().equals(code)) {
            activityRule = JsRuleCreator.create(ActivityRuleFirstDepositForm.class);
        }
        if (ActivityTypeEnum.REGIST_SEND.getCode().equals(code)) {
            activityRule = JsRuleCreator.create(ActivityRuleRegistSendForm.class);
        }
        if (ActivityTypeEnum.EFFECTIVE_TRANSACTION.getCode().equals(code)) {
            activityRule = JsRuleCreator.create(ActivityRuleEffectiveTransactionForm.class);
        }
        if (ActivityTypeEnum.PROFIT.getCode().equals(code)) {
            activityRule = JsRuleCreator.create(ActivityRuleProfitLossForm.class);
        }
        if (ActivityTypeEnum.RELIEF_FUND.getCode().equals(code)) {
            activityRule = JsRuleCreator.create(ActivityRuleReliefFundForm.class);
        }
        if (ActivityTypeEnum.CONTENT.getCode().equals(code)) {
            activityRule = JsRuleCreator.create(ActivityContentStepForm.class);
        }
        if (ActivityTypeEnum.MONEY.getCode().equals(code)) {
            activityRule = JsRuleCreator.create(ActivityMoneyConditionForm.class);
        }
        return activityRule;
    }

    /**
     * 为activityMessage赋值
     *
     * @param activityTypeVo
     * @param vActivityMessageVo
     */
    private void assignment(ActivityTypeVo activityTypeVo, VActivityMessageVo vActivityMessageVo) {

        String code = activityTypeVo.getResult().getCode();
        if (!ActivityTypeEnum.BACK_WATER.getCode().equals(code)) {
            vActivityMessageVo.getActivityRule().setRank(vActivityMessageVo.getRank());
            if (StringTool.isNotBlank(vActivityMessageVo.getIsAllRank())) {
                if ("false".equals(vActivityMessageVo.getIsAllRank())) {
                    vActivityMessageVo.getActivityRule().setIsAllRank(Boolean.FALSE);
                }
            }
            if (vActivityMessageVo.getActivityRule().getIsAllRank() == null) {
                vActivityMessageVo.getActivityRule().setIsAllRank(Boolean.FALSE);
            }
        }

        ActivityMessage activityMessage = vActivityMessageVo.getActivityMessage();
        activityMessage.setActivityTypeCode(code);
        if (StringTool.isNotBlank(vActivityMessageVo.getActivityState())
                && ActivityStateEnum.DRAFT.getCode().equals(vActivityMessageVo.getActivityState())) {
            activityMessage.setActivityState(ActivityStateEnum.DRAFT.getCode());
        } else {
            activityMessage.setActivityState(ActivityStateEnum.RELEASE.getCode());
            activityMessage.setCheckStatus(ContentCheckEnum.PASS.getCode());//add by eagle on 20151116 增加营运商审核状态
            activityMessage.setIsRead(false);
            activityMessage.setIsRemove(false);
        }
        if (vActivityMessageVo.getActivityMessageId() == null) {
            activityMessage.setCreateTime(SessionManager.getDate().getNow());
            activityMessage.setUserId(SessionManager.getAuditUserId());
            activityMessage.setUserName(SessionManager.getUserName());
        } else {
            activityMessage.setUpdateUserId(SessionManager.getAuditUserId());
            activityMessage.setUpdateTime(SessionManager.getDate().getNow());
        }

        boolean isCode = ActivityTypeEnum.EFFECTIVE_TRANSACTION.getCode().equals(code)
                || ActivityTypeEnum.RELIEF_FUND.getCode().equals(code)
                || ActivityTypeEnum.PROFIT.getCode().equals(code);
        Date startTime = vActivityMessageVo.getActivityMessage().getStartTime();
        Date endTime = vActivityMessageVo.getActivityMessage().getEndTime();
        if (isCode && startTime != null && endTime != null) {

            //如果调度有结算过,重新编辑活动
            String claimPeriod = vActivityMessageVo.getActivityRule().getClaimPeriod();
            Date settlementTimeNext = null;
            if (vActivityMessageVo.getActivityMessageId() == null) {
                settlementTimeNext = calSettlementTimeNext(startTime, endTime, claimPeriod);
            } else {
                ActivityMessageVo activityMessageVo = new ActivityMessageVo();
                activityMessageVo.getSearch().setId(vActivityMessageVo.getActivityMessageId());
                activityMessageVo = ServiceActivityTool.activityMessageService().get(activityMessageVo);

                if (activityMessageVo.getResult() != null) {
                    if (activityMessageVo.getResult().getSettlementTimeLatest() == null) {
                        settlementTimeNext = calSettlementTimeNext(startTime, endTime, claimPeriod);
                    } else { //如果有下次结算时间，更改为等下次发放生效后，下下次生效结算时间
                        settlementTimeNext = activityMessageVo.getResult().getSettlementTimeNext();
                    }
                }
            }

            activityMessage.setSettlementTimeNext(settlementTimeNext);
        }
        activityMessage.setIsDeleted(Boolean.FALSE);
        vActivityMessageVo.setActivityMessage(activityMessage);
    }

    /**
     * 计算下个周期申领截止时间
     *
     * @param startTime   　　　　 活动开始时间
     * @param endTime     　　　　　 活动结束时间
     * @param claimPeriod 　　　活动周期
     * @return
     */
    private Date calSettlementTimeNext(Date startTime, Date endTime, String claimPeriod) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(startTime);
        Date settlementTimeNext = null;
        Date today = SessionManager.getDate().getToday();
        if (ActivityClaimPeriod.NATURALDAY.getCode().equals(claimPeriod)) {
            calendar.add(Calendar.DATE, 1);
            Date newTime = calendar.getTime();
            settlementTimeNext = compareSettlementTimeNext(newTime, endTime, today);
        } else if (ActivityClaimPeriod.NATURALWEEK.getCode().equals(claimPeriod)) {
            calendar.add(Calendar.DATE, 7);
            Date newTime = calendar.getTime();
            settlementTimeNext = compareSettlementTimeNext(newTime, endTime, today);
        } else if (ActivityClaimPeriod.NATURALMONTH.getCode().equals(claimPeriod)) {
            calendar.add(Calendar.MONTH, 1);
            Date newTime = calendar.getTime();
            settlementTimeNext = compareSettlementTimeNext(newTime, endTime, today);
        } else {
            settlementTimeNext = endTime;
        }
        return settlementTimeNext;
    }

    /**
     * 判断是否超过活动时间
     *
     * @param newTime
     * @param endTime
     * @return
     */
    private Date compareSettlementTimeNext(Date newTime, Date endTime, Date today) {
        Date settlementTimeNext = null;
        int daysBetween = (int) DateTool.daysBetween(today, newTime);
        if (daysBetween > 0) {
            settlementTimeNext = DateTool.addDays(newTime, daysBetween + 1);
        } else if (DateTool.secondsBetween(newTime, endTime) > 0) {
            settlementTimeNext = endTime;
        } else {
            settlementTimeNext = newTime;
        }
        return settlementTimeNext;
    }

    @RequestMapping(value = "/setDefaultWin")
    @Token(generate = true)
    public String setDefaultWin(ActivityMessageVo activityMessageVo, Model model) {
        String url = getViewBasePath() + "SetMoneyDefaultWin";
        if (activityMessageVo.getSearch().getId() == null) {
            activityMessageVo.setResult(new ActivityMessage());
            return url;
        }
        activityMessageVo = ServiceActivityTool.activityMessageService().get(activityMessageVo);
        if (activityMessageVo.getResult() == null) {
            activityMessageVo.setResult(new ActivityMessage());
        }
        if (!ActivityTypeEnum.MONEY.getCode().equals(activityMessageVo.getResult().getActivityTypeCode())) {
            return null;
        }
        List<ActivityMoneyAwardsRules> activityMoneyAwardsRules = queryMoneyRulesByActivityId(activityMessageVo);
        if (activityMessageVo == null) {
            activityMoneyAwardsRules = new ArrayList<>();
        }
        model.addAttribute("activityMoneyAwardsRules", activityMoneyAwardsRules);
        model.addAttribute("activityMessageVo", activityMessageVo);
        queryOperateRecord(activityMessageVo, model);
        model.addAttribute("validateRule", JsRuleCreator.create(ActivityMoneyDefaultWinForm.class));
        //ActivityMoneyDefaultWinListVo winListVo = queryDefaultWinPlayer(activityMessageVo);
        //model.addAttribute("winListVo",winListVo);
        return url;
    }

    private void queryOperateRecord(ActivityMessageVo activityMessageVo, Model model) {
        ActivityMoneyDefaultWinRecordListVo recordListVo = new ActivityMoneyDefaultWinRecordListVo();
        recordListVo.getSearch().setActivityMessageId(activityMessageVo.getResult().getId());
        recordListVo = ServiceActivityTool.activityMoneyDefaultWinRecordService().search(recordListVo);
        ActivityMoneyDefaultWinListVo winListVo = queryDefaultWinPlayer(activityMessageVo);
        model.addAttribute("recordListVo", recordListVo);
        model.addAttribute("winListVo", winListVo);

    }

    private ActivityMoneyDefaultWinListVo queryDefaultWinPlayer(ActivityMessageVo activityMessageVo) {
        ActivityMoneyDefaultWinListVo winListVo = new ActivityMoneyDefaultWinListVo();
        if (activityMessageVo.getResult() == null || activityMessageVo.getResult().getId() == null) {
            return winListVo;
        }

        winListVo.getSearch().setActivityMessageId(activityMessageVo.getResult().getId());
        winListVo.getSearch().setStatus(null);
        winListVo.getQuery().addOrder(ActivityMoneyDefaultWin.PROP_OPERATE_TIME, Direction.DESC);
        winListVo = ServiceActivityTool.activityMoneyDefaultWinService().search(winListVo);
        Map<Integer, List<ActivityMoneyDefaultWinPlayer>> playerMap = new HashMap<>();
        if (winListVo.getResult() != null) {
            for (ActivityMoneyDefaultWin defaultWin : winListVo.getResult()) {
                ActivityMoneyDefaultWinPlayerListVo winPlayerListVo = new ActivityMoneyDefaultWinPlayerListVo();
                winPlayerListVo.getSearch().setDefaultWinId(defaultWin.getId());
                winPlayerListVo.getQuery().addOrder(ActivityMoneyDefaultWinPlayer.PROP_ID, Direction.ASC);
                winPlayerListVo.setPaging(null);
                winPlayerListVo = ServiceActivityTool.activityMoneyDefaultWinPlayerService().search(winPlayerListVo);
                playerMap.put(defaultWin.getId(), winPlayerListVo.getResult());
                //xxxx-40天前 [username]内定玩家xxx,xxx,xxx,xxx,xx等玩家中奖x次，奖项为xxxx元。收起 取消内定
            }
        }
        winListVo.setPlayerMap(playerMap);
        return winListVo;

    }

    private List<ActivityMoneyAwardsRules> queryMoneyRulesByActivityId(ActivityMessageVo activityMessageVo) {
        if (activityMessageVo.getResult() == null || activityMessageVo.getResult().getId() == null) {
            return null;
        }
        ActivityMoneyAwardsRulesListVo rulesListVo = new ActivityMoneyAwardsRulesListVo();
        rulesListVo.getSearch().setActivityMessageId(activityMessageVo.getResult().getId());
        rulesListVo.getQuery().addOrder(ActivityMoneyAwardsRules.PROP_AMOUNT, Direction.ASC);
        rulesListVo = ServiceActivityTool.activityMoneyAwardsRulesService().search(rulesListVo);
        return rulesListVo.getResult();
    }

    @RequestMapping(value = "/queryExistMoneyActivity")
    @ResponseBody
    public Map queryExistMoneyActivity(Integer id) {
        List<VActivityMessage> vActivityMessages = getService().queryExistMoneyActivity(new VActivityMessageListVo());
        Map map = new HashMap();
        boolean flag = false;
        if (vActivityMessages != null) {
            if (vActivityMessages.size() == 0) {
                flag = false;
            } else if (vActivityMessages.size() == 1) {
                if (id != null) {
                    if (!id.equals(vActivityMessages.get(0).getId())) {
                        flag = true;
                    }
                } else {
                    flag = true;
                }
            } else {
                for (VActivityMessage message : vActivityMessages) {
                    if (message.getIsDisplay() && !message.getId().equals(id)) {
                        flag = true;
                        break;
                    }
                }
            }
        }
        map.put("state", flag);
        return map;
    }

    @RequestMapping(value = "/validatePeriodArea")
    @ResponseBody
    public Map validatePeriodArea(ActivityTypeVo activityTypeVo, VActivityMessageVo vActivityMessageVo) {
        Map map = new HashMap();
        List<ActivityOpenPeriod> activityOpenPeriods = ActivityMoneyPeriodTool.buildPeriodDataList(vActivityMessageVo);
        Boolean aBoolean = ActivityMoneyPeriodTool.validatePeriodArea(activityOpenPeriods);
        map.put("state", aBoolean.booleanValue());
        return map;
    }
    //endregion your codes 3

}