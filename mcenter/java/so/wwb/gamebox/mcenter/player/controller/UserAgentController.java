package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionQueryTool;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.collections.ListTool;
import org.soul.commons.collections.MapTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.enums.EnumTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.RandomStringTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.commons.query.Criteria;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.Paging;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.query.sort.Direction;
import org.soul.commons.query.sort.Order;
import org.soul.commons.security.Base36;
import org.soul.commons.support._Module;
import org.soul.model.log.audit.enums.OpType;
import org.soul.model.log.audit.vo.BaseLog;
import org.soul.model.log.audit.vo.LogVo;
import org.soul.model.msg.notice.enums.NoticePublishMethod;
import org.soul.model.msg.notice.po.NoticeContactWay;
import org.soul.model.msg.notice.po.NoticeTmpl;
import org.soul.model.msg.notice.vo.NoticeContactWayListVo;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.model.security.privilege.po.SysUser;
import org.soul.model.security.privilege.po.SysUserStatus;
import org.soul.model.security.privilege.so.SysUserSo;
import org.soul.model.security.privilege.vo.SysUserListVo;
import org.soul.model.security.privilege.vo.SysUserProtectionVo;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.model.sys.po.SysAuditLog;
import org.soul.model.sys.po.SysDict;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.so.SysAuditLogSo;
import org.soul.model.sys.vo.SysAuditLogListVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.security.AuthTool;
import so.wwb.gamebox.iservice.master.fund.IAgentWithdrawOrderService;
import so.wwb.gamebox.iservice.master.player.IUserAgentService;
import so.wwb.gamebox.iservice.master.player.IUserBankcardService;
import so.wwb.gamebox.mcenter.init.ConfigManager;
import so.wwb.gamebox.mcenter.player.form.*;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.*;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.common.notice.enums.AutoNoticeEvent;
import so.wwb.gamebox.model.common.notice.enums.ContactWayType;
import so.wwb.gamebox.model.company.enums.BankEnum;
import so.wwb.gamebox.model.company.site.po.SiteCurrency;
import so.wwb.gamebox.model.company.site.po.SiteI18n;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.company.site.po.VGameType;
import so.wwb.gamebox.model.company.site.vo.SiteLanguageListVo;
import so.wwb.gamebox.model.company.site.vo.VGameTypeListVo;
import so.wwb.gamebox.model.company.sys.po.SysDomain;
import so.wwb.gamebox.model.company.sys.vo.SysDomainListVo;
import so.wwb.gamebox.model.company.vo.BankListVo;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.enums.SiteLangStatusEnum;
import so.wwb.gamebox.model.master.enums.TransactionStatusEnum;
import so.wwb.gamebox.model.master.fund.so.AgentWithdrawOrderSo;
import so.wwb.gamebox.model.master.fund.vo.AgentWithdrawOrderListVo;
import so.wwb.gamebox.model.master.operation.po.VAgentRebateOrder;
import so.wwb.gamebox.model.master.operation.vo.AgentWaterBillVo;
import so.wwb.gamebox.model.master.operation.vo.VAgentRebateOrderListVo;
import so.wwb.gamebox.model.master.operation.vo.VAgentRebateOrderVo;
import so.wwb.gamebox.model.master.player.enums.UserAgentEnum;
import so.wwb.gamebox.model.master.player.po.*;
import so.wwb.gamebox.model.master.player.vo.*;
import so.wwb.gamebox.model.master.setting.po.FieldSort;
import so.wwb.gamebox.model.master.setting.vo.RakebackSetListVo;
import so.wwb.gamebox.model.master.setting.vo.RebateSetListVo;
import so.wwb.gamebox.model.report.enums.SettlementStateEnum;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.Serializable;
import java.util.*;


/**
 * 代理子账号控制器
 *
 * @author loong
 * @time 2015-9-6 9:48:09
 */
@Controller
//region your codes 1
@RequestMapping("/userAgent")
public class UserAgentController extends BaseCrudController<IUserAgentService, UserAgentListVo, UserAgentVo, UserAgentSearchForm, UserAgentForm, UserAgent, Integer> {


    private static final Log LOG = LogFactory.getLog(UserAgentController.class);
    private static final String AGENT_DETAIL_URI = "Detail";
    private static final String AGENT_DETAIL_BANK_CARD_URI = "detail.include/BankCard";
    private static final String AGENT_DETAIL_BANK_CARD_EDIT_URI = "detail.include/BankCardEdit";
    private static final String AGENT_DETAIL_LOG_URI = "/player/agent/detail.include/Log";
    private static final String AGENT_DETAIL_FUNDS_REBATE = "detail.include/Funds_rebate";
    private static final String AGENT_DETAIL_FUNDS_WITHDRAW = "detail.include/Funds_withdraw";
    private static final String AGENT_DETAIL_FUNDS_REBATEDETAIL = "detail.include/Funds_rebate_detail";
    private static final String CAPTCHA_SESSION_CODE = "agentCaptcha";
    private static final String EDIT_TOP_AGENT = "/player/topagent/Edit";
    private final static String TOP_AGENT_EDIT_PARTIAL = "/player/topagent/EditPartial";
    private final static String TOP_AGENT_API_SET = "/player/topagent/ApiSet";
    private final static String TOP_AGENT_DETAIL_RATIO_EDIT= "/player/topagent/detail.include/RatioEdit";
    private final static String TOP_AGENT_DETAIL_RATIO_INDEX= "/player/topagent/detail.include/Ratio";
    private final static String EDIT_TYPE_AGENT = "agent";
    private final static String EDIT_TYPE_TOP_AGENT = "topAgent";


    //endregion your codes 1
    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/player/agent/";
        //endregion your codes 2
    }

    //region your codes 3
    @Override
    protected UserAgentVo doCreate(UserAgentVo objectVo, Model model) {
        objectVo = super.doCreate(objectVo, model);
        objectVo.getResult().setRegistCode(RandomStringTool.randomAlphanumeric(6).toLowerCase());
        createOrEdit(objectVo);
        if(objectVo.getSysUser()==null){
            objectVo.setSysUser(new SysUser());
        }
        objectVo.getSysUser().setDefaultTimezone(CommonContext.get().getTimeZone().getDisplayName());
        return objectVo;
    }

    /**
     * 修改代理详情
     * @param agentVo
     * @param request
     * @return
     */
    @RequestMapping("/updateAgent")
    @ResponseBody
    @Audit(module = Module.AGENT, moduleType = ModuleType.PLAYER_AGENTDETAIL_SUCCESS, opType = OpType.UPDATE)
    protected Map doPersist(UserAgentVo agentVo,HttpServletRequest request) {
        Integer id = agentVo.getResult().getId();
        if (id == null || "".equals((id + "").trim())) {
            agentVo = doSave(agentVo);
        } else {
            //填充玩家名称
            VUserAgentVo vUserAgentVo = new VUserAgentVo();
            vUserAgentVo.setResult(new VUserAgent());
            vUserAgentVo.getSearch().setId(agentVo.getResult().getId());
            vUserAgentVo = ServiceTool.vUserAgentService().get(vUserAgentVo);
            agentVo = doUpdate(agentVo);
            if(agentVo.isSuccess()){
                //操作日志
                addLog(request, "player.agentDetail.success", vUserAgentVo);
            }
        }

        if (agentVo.isSuccess()) {
            agentVo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "update.success"));
        } else {
            agentVo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "update.failed"));
        }
        HashMap map = new HashMap(2,1f);
        map.put("msg", StringTool.isNotBlank(agentVo.getOkMsg()) ? agentVo.getOkMsg() : agentVo.getErrMsg());
        map.put("state", Boolean.valueOf(agentVo.isSuccess()));
        return map;
    }

    /**
     * 日志
     *
     * @param request
     * @param description 日志描述
     */
    private void addLog(HttpServletRequest request, String description, VUserAgentVo vUserAgentVo) {
        LogVo logVo = new LogVo();
        BaseLog baseLog = logVo.addBussLog();
        baseLog.setDescription(description);
        baseLog.setEntityId(vUserAgentVo.getResult().getId());
        baseLog.setEntityUserId(vUserAgentVo.getResult().getId());
        baseLog.setEntityUsername(vUserAgentVo.getResult().getUsername());
        baseLog.addParam(vUserAgentVo.getResult().getUsername());
        request.setAttribute(SysAuditLog.AUDIT_LOG, logVo);
    }

    @Override
    protected UserAgentVo doEdit(UserAgentVo objectVo, Model model) {
        objectVo = super.doEdit(objectVo, model);
        createOrEdit(objectVo);
        return objectVo;
    }

    public void createOrEdit(UserAgentVo userAgentVo){
        /*站长子账号*/
        UserTypeEnum userTypeEnum = SessionManager.getUserType();
        if(userTypeEnum.equals(UserTypeEnum.MASTER_SUB)){
            /*只有站长子账号 可以选择总代 （user_agent parent_id == null）*/
            userAgentVo.setEditSelectAgent(true);
        } else if(userTypeEnum.equals(UserTypeEnum.AGENT)){
            /*总代 及 代理*/
            if(SessionManager.getUser().getOwnerId() == null){
                /*总代*/
                userAgentVo.getSearch().setUserId(SessionManager.getUserId());
            }else{
                /*代理子账号*/
                userAgentVo.getSearch().setUserId(SessionManager.getUser().getOwnerId());
            }
            getService().getForAgent(userAgentVo);
        }

        /*层级*/
        /*PlayerRankListVo playerRankListVo = new PlayerRankListVo();

        playerRankListVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(PlayerRank.PROP_STATUS, Operator.EQ, RankStatusEnum.NORMAL.getCode()),
                new Criterion(PlayerRank.PROP_WITHDRAW_MAX_NUM, Operator.IS_NOT_NULL,null),
                new Criterion(PlayerRank.PROP_ONLINE_PAY_MAX,Operator.IS_NOT_NULL,null)
        });

        playerRankListVo.setProperties(PlayerRank.PROP_ID, PlayerRank.PROP_RANK_NAME);

        userAgentVo.setSomePlayerRanks(ServiceTool.playerRankService().searchProperties(playerRankListVo));*/
        PlayerRankVo playerRankVo = new PlayerRankVo();
        userAgentVo.setSomePlayerRanks(ServiceTool.playerRankService().queryUsableRankList(playerRankVo));

        SysParam param= ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SETTING_FIELD_SETTING_AGENT);
        List<FieldSort> fieldSortAll = (List<FieldSort>) JsonTool.fromJson(param.getParamValue(),JsonTool.createCollectionType(ArrayList.class,FieldSort.class));

        /*使用中的注册项*/
        List<FieldSort> fieldSorts = CollectionQueryTool.andQuery(fieldSortAll, ListTool.newArrayList(new Criterion(FieldSort.PROP_IS_REGFIELD, Operator.NE, "2"),
                new Criterion(FieldSort.PROP_NAME, Operator.NOT_IN, userAgentVo.getDefaultCode())), Order.asc(FieldSort.PROP_SORT));
        /*List<String> fieldNameList = CollectionTool.extractToList(fieldSorts, FieldSort.PROP_NAME);
        userAgentVo.setFieldNameList(fieldNameList);*/
        /*必填的注册项*/
        List<FieldSort> requiredFieldSorts = CollectionQueryTool.andQuery(fieldSorts, ListTool.newArrayList(new Criterion(FieldSort.PROP_IS_REGFIELD, Operator.NE, "2"), new Criterion(FieldSort.PROP_IS_REQUIRED, Operator.NE, "2")), Order.asc(FieldSort.PROP_SORT));

        /*必填的注册项name的json*/
        String required = JsonTool.toJson(CollectionTool.extractToList(requiredFieldSorts, FieldSort.PROP_NAME));

        userAgentVo.setRequired(required);
//        userAgentVo.setFieldSorts(fieldSorts);
        userAgentVo.setFieldSorts(fieldSorts);

        /* 时区 */
        userAgentVo.setTimeZone(getDefaultTimezone());

        /* 联系方式 */
        userAgentVo.setContact(DictTool.get(DictEnum.COMMON_CONTACT_WAY_TYPE));

        /*查出所有总代*/


        SysUserListVo sysUserListVo = new SysUserListVo();
        sysUserListVo.setSearch(new SysUserSo());
        sysUserListVo.setProperties(SysUser.PROP_ID, SysUser.PROP_USERNAME);


        if(userAgentVo.getResult().getParentId()!=null){
            SysUserVo sysUserVo = new SysUserVo();
            sysUserVo.getSearch().setId(userAgentVo.getResult().getParentId());
            sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
            if(sysUserVo!=null&&sysUserVo.getResult()!=null){
                userAgentVo.setTopAgentName(sysUserVo.getResult().getUsername());
            }else{
                userAgentVo.setTopAgentName("");
            }
        }
        userAgentVo.setDictConstellation(DictTool.get(DictEnum.COMMON_CONSTELLATION));
        if(UserAgentEnum.EDIT_TYPE_SUB_AGENT.getCode().equals(userAgentVo.getEditType())){
            sysUserListVo.getQuery().setCriterions(new Criterion[]{new Criterion(SysUser.PROP_ID, Operator.EQ, userAgentVo.getSearch().getParentId())});
            userAgentVo.setTopAgents(ServiceTool.sysUserService().searchProperties(sysUserListVo));
            userAgentVo.setAgentUserId(userAgentVo.getSearch().getParentId());
        }else{
            sysUserListVo.getQuery().setCriterions(new Criterion[]{new Criterion(SysUser.PROP_USER_TYPE, Operator.EQ, UserTypeEnum.TOP_AGENT.getCode()),
                    new Criterion(SysUser.PROP_STATUS,Operator.EQ,SysUserStatus.NORMAL.getCode())});
            userAgentVo.setTopAgents(ServiceTool.sysUserService().searchProperties(sysUserListVo));

        }

        SysUser master = SessionManager.getUser();

        getAnswer(userAgentVo);
    }
    private void getAnswer(UserAgentVo userAgentVo){
        SysUserProtectionVo protection = new SysUserProtectionVo();
        protection.getSearch().setId(userAgentVo.getResult().getId());
        protection = ServiceTool.sysUserProtectionService().get(protection);
        userAgentVo.setSysUserProtection(protection.getResult());
    }
    /**
     * 代理--详细页
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping("/agent/detail")
    public String agentDetail(UserAgentVo vo, Model model) {
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setId(vo.getSearch().getId());
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        model.addAttribute("command",sysUserVo);
        model.addAttribute("now",new Date());

        Map map = this.getService().findAgentDetail(vo);
        vo=getService().get(vo);
        Integer userId = vo.getSearch().getId();
        NoticeContactWay phone = getContactVal(userId, ContactWayType.CELLPHONE.getCode());
        NoticeContactWay email = getContactVal(userId, ContactWayType.EMAIL.getCode());
        NoticeContactWay msn = getContactVal(userId, ContactWayType.MSN.getCode());
        NoticeContactWay skype = getContactVal(userId, ContactWayType.SKYPE.getCode());
        NoticeContactWay qq = getContactVal(userId, ContactWayType.QQ.getCode());
        NoticeContactWay weixin = getContactVal(userId, ContactWayType.WEIXIN.getCode());
        model.addAttribute("phone", phone);
        model.addAttribute("email", email);
        model.addAttribute("msn", msn);
        model.addAttribute("skype", skype);
        model.addAttribute("qq", qq);
        model.addAttribute("weixin", weixin);
        model.addAttribute("map", map);
//        model.addAttribute("extendedLinks",vo.getExtendedLinks());　add by eagle

        UserAgentRakebackListVo userAgentRakebackListVo = new UserAgentRakebackListVo();
        Map tempMap = new HashMap(1,1f);
        tempMap.put(UserAgentRakeback.PROP_USER_ID,sysUserVo.getResult().getId());
        userAgentRakebackListVo.setConditions(tempMap);
        List<UserAgentRakeback> userAgentRakebackList = ServiceTool.userAgentRakebackService().andSearch(userAgentRakebackListVo);
        if (!userAgentRakebackList.isEmpty()){
            model.addAttribute("rakebackId",userAgentRakebackList.get(0).getRakebackId());
        }
        UserAgentRebateListVo userAgentRebateListVo = new UserAgentRebateListVo();
        Map tempMap2 = new HashMap(1,1f);
        tempMap2.put(UserAgentRebate.PROP_USER_ID,sysUserVo.getResult().getId());
        userAgentRebateListVo.setConditions(tempMap2);
        List<UserAgentRebate> userAgentRebateList = ServiceTool.userAgentRebateService().andSearch(userAgentRebateListVo);
        if(!userAgentRebateList.isEmpty()){
            model.addAttribute("rebateId",userAgentRebateList.get(0).getRebateId());
        }
        setAgentDomains(vo, model);
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.SETTING_WITHDRAW_TYPE_IS_BITCOIN);
        model.addAttribute("bitcoin",sysParam.getParamValue());
        return getViewBasePath() + AGENT_DETAIL_URI;
    }

    private void setAgentDomains(UserAgentVo vo, Model model) {
        model.addAttribute("domains",getDomains());
        model.addAttribute("indexDomains",getAgentDomainUrl(vo.getSearch().getId()));

        String invitationCode = encryptInvitationCode(vo.getSearch().getId());
        if (StringTool.isNotBlank(invitationCode)){
            model.addAttribute("invitationCode", Base36.encryptIgnoreCase(invitationCode));
        }
    }

    private String encryptInvitationCode(Integer agentId) {
        if (agentId==null){
            return "";
        }
        UserAgentVo userAgentVo = new UserAgentVo();
        userAgentVo.getSearch().setId(agentId);
        userAgentVo = ServiceTool.userAgentService().get(userAgentVo);
        if(StringTool.isNotBlank(userAgentVo.getResult().getRegistCode())){
            return  userAgentVo.getResult().getRegistCode()+agentId;
        }else{
            return "";
        }

    }
    @RequestMapping("/showAllDomains")
    public String showAllDomains(UserAgentVo vo, Model model){
        setAgentDomains(vo, model);
        if(UserAgentEnum.EDIT_TYPE_AGENT.getCode().equals(vo.getEditType())){
            return getViewBasePath() + "detail.include/AgentDomains";
        }else{
            return "/player/topagent/detail.include/TopAgentDomains";
        }

    }

    /**
     * 推广网址
     */
    private List<SysDomain> getDomains() {
        SysDomainListVo listVo = new SysDomainListVo();
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo.getSearch().setSubsysCode(SubSysCodeEnum.MSITES.getCode());
        //listVo.getSearch().setPageUrl(DomainPageUrlEnum.INDEX.getCode());
        listVo.getSearch().setForAgent(true);
        //推广网址
        List<SysDomain> domains = ServiceTool.sysDomainService().queryDomain4Agent(listVo);
        return  domains;
    }

    private List<SysDomain> getAgentDomainUrl(Integer agentId) {
        //独立网址
        SysDomainListVo indeListVo = new SysDomainListVo();
        indeListVo.getSearch().setSiteId(SessionManager.getSiteId());
        indeListVo.getSearch().setAgentId(agentId);
        List<SysDomain> indeList = ServiceTool.sysDomainService().queryDomain4Agent(indeListVo);
        return indeList;
        //
    }

    @RequestMapping("/agent/veiwDetail")
    public String veiwDetail(UserAgentVo vo, Model model) {
        model.addAttribute("unencryption", SessionManager.checkPrivilegeStatus());
        return agentDetail(vo,model);
    }

    /**
     * 代理资金-返佣页
     * @param vo
     * @return
     */
    @RequestMapping("/agent/funds")
    public String funds(VAgentRebateOrderListVo vo, Model model) {

        vo.getQuery().setCriterions(new Criterion[]{
                new Criterion(VAgentRebateOrder.PROP_SETTLEMENT_STATE,Operator.EQ,vo.getSearch().getSettlementState()),
                new Criterion(VAgentRebateOrder.PROP_AGENT_ID, Operator.EQ,vo.getSearch().getAgentId()),
                new Criterion(VAgentRebateOrder.PROP_START_TIME,Operator.GE,DateTool.addDays(new Date(), -90)),
                new Criterion(VAgentRebateOrder.PROP_END_TIME,Operator.LE,new Date())
        });
        vo = ServiceTool.vAgentRebateOrderService().search(vo);
        model.addAttribute("command", vo);

        //get status dict
        final Map<String, SettlementStateEnum> enumMap = EnumTool.getEnumMap(SettlementStateEnum.class);
        model.addAttribute("fundsStatus", enumMap);

        //get default currency
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setId(vo.getSearch().getAgentId());
        String defaultCurrency = ServiceTool.sysUserService().get(sysUserVo).getResult().getDefaultCurrency();
        model.addAttribute("currency", defaultCurrency);

//        UserAgentVo userAgentVo = new UserAgentVo();
//        userAgentVo.getSearch().setId(vo.getSearch().getAgentId());
//        UserAgent useragent = ServiceTool.userAgentService().get(userAgentVo).getResult();

        Double rebateTotal = 0d;
        if (vo.getResult()!=null && vo.getResult().size()>0) {
            vo.getQuery().setCriterions(new Criterion[]{
                    new Criterion(VAgentRebateOrder.PROP_AGENT_ID, Operator.EQ,vo.getSearch().getAgentId()),
                    new Criterion(VAgentRebateOrder.PROP_SETTLEMENT_STATE, Operator.EQ,SettlementStateEnum.LSSUING.getCode()),
                    new Criterion(VAgentRebateOrder.PROP_START_TIME,Operator.GE,DateTool.addDays(new Date(), -90)),
                    new Criterion(VAgentRebateOrder.PROP_START_TIME,Operator.LE,new Date())
            });
            vo.setPropertyName(VAgentRebateOrder.PROP_ACTUAL_AMOUNT);
            rebateTotal = ServiceTool.vAgentRebateOrderService().sum(vo).doubleValue();
        }

        model.addAttribute("rebateTotalAmount", rebateTotal);

        return getViewBasePath() + AGENT_DETAIL_FUNDS_REBATE;
    }

    /**
     * 代理资金--返佣详情
     *
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping("/rebateDetail")
    public String rebateDetail(VAgentRebateOrderVo vo, Model model) {
        VAgentRebateOrderVo vAgentRebateOrderVo = ServiceTool.vAgentRebateOrderService().search(vo);
        model.addAttribute("orderVo", vAgentRebateOrderVo);

        //get agent username
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setId(vAgentRebateOrderVo.getResult().getAgentId());
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        String username = sysUserVo.getResult().getUsername();
        model.addAttribute("username", username);
        model.addAttribute("agentId", vAgentRebateOrderVo.getResult().getAgentId());

        AgentWaterBillVo waterBillVo = new AgentWaterBillVo();
        waterBillVo.getSearch().setOrderId(vo.getSearch().getId());
        AgentWaterBillVo billVo = ServiceTool.agentWaterBillService().search(waterBillVo);
        model.addAttribute("billVo", billVo);

        return getViewBasePath() + AGENT_DETAIL_FUNDS_REBATEDETAIL;
    }

    /**
     * 代理资金-取款页
     * @param vo
     * @return
     */
    @RequestMapping("/agent/withdraw")
    public String withdraw(AgentWithdrawOrderListVo vo, Model model) {
        IAgentWithdrawOrderService withdrawOrderService = ServiceTool.getAgentWithdrawOrderService();
        AgentWithdrawOrderSo search = vo.getSearch();
        vo = withdrawOrderService.search(vo);
        model.addAttribute("command", vo);

        //get status dict
        final Map<String, TransactionStatusEnum> enumMap = EnumTool.getEnumMap(TransactionStatusEnum.class);
        model.addAttribute("status", enumMap);

        //get default currency
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setId(search.getAgentId());
        String defaultCurrency = ServiceTool.sysUserService().get(sysUserVo).getResult().getDefaultCurrency();
        model.addAttribute("currency", defaultCurrency);

        //get rebate total amount
        Map param = MapTool.newHashMap();
        param.put("status", "2");
        param.put("agentId", search.getAgentId());
        vo.setConditions(param);
        Double withdrawTotalAmount = withdrawOrderService.getTotalAmount(vo);
        model.addAttribute("withdrawTotalAmount", withdrawTotalAmount);

        return getViewBasePath() + AGENT_DETAIL_FUNDS_WITHDRAW;
    }

    /**
     * 总代--详细页
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping("/topagent/detail")
    public String topAgentDetail(UserAgentVo vo, Model model) {
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setId(vo.getSearch().getId());
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        sysUserVo = SysUserTool.replaceStatus(sysUserVo);
        model.addAttribute("command",sysUserVo);
        model.addAttribute("now",new Date());

        Map map = this.getService().findAgentDetail(vo);
        Integer userId = vo.getSearch().getId();
        NoticeContactWay phone = getContactVal(userId, ContactWayType.CELLPHONE.getCode());
        NoticeContactWay email = getContactVal(userId, ContactWayType.EMAIL.getCode());
        NoticeContactWay msn = getContactVal(userId, ContactWayType.MSN.getCode());
        NoticeContactWay skype = getContactVal(userId, ContactWayType.SKYPE.getCode());
        NoticeContactWay qq = getContactVal(userId, ContactWayType.QQ.getCode());
        NoticeContactWay weixin = getContactVal(userId, ContactWayType.WEIXIN.getCode());
        model.addAttribute("phone", phone);
        model.addAttribute("email", email);
        model.addAttribute("msn", msn);
        model.addAttribute("skype", skype);
        model.addAttribute("qq", qq);
        model.addAttribute("weixin", weixin);
        model.addAttribute("map", map);
        setAgentDomains(vo, model);
        return "/player/topagent/Detail";
    }

    @RequestMapping("/topagent/veiwDetail")
    public String topAgentViewDetail(UserAgentVo vo, Model model) {
        model.addAttribute("unencryption", SessionManager.checkPrivilegeStatus());
        return topAgentDetail(vo,model);
    }

    /**
     * 获取联系方式
     * @param userId
     * @param contactType
     * @return
     */
    private NoticeContactWay getContactVal(Integer userId,String contactType){
        NoticeContactWayListVo noticeContactWayListVo = new NoticeContactWayListVo();
        noticeContactWayListVo.getSearch().setUserIds(ListTool.newArrayList(userId));
        noticeContactWayListVo.getSearch().setContactType(contactType);
        List<NoticeContactWay> noticeContactWays = ServiceTool.noticeContactWayService().fetchContactWaysByUserIdsAndType(noticeContactWayListVo);
        NoticeContactWay way = new NoticeContactWay();
        if(CollectionTool.isNotEmpty(noticeContactWays)){
            way = noticeContactWays.get(0);
        }
        return way;
    }

    /**
     * 代理--详细页--银行卡
     * @param listVo
     * @param model
     * @return
     */
    @RequestMapping("/agent/bankCard")
    public String agentBankCard(UserBankcardListVo listVo, Model model) {
        listVo.getPaging().setPageSize(10);
        listVo.getQuery().getPageOrderMap().put(UserBankcard.PROP_IS_DEFAULT, Direction.DESC.name());
        listVo.getQuery().getPageOrderMap().put(UserBankcard.PROP_CREATE_TIME, Direction.DESC.name());
        listVo = ServiceTool.userBankcardService().search(listVo);
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.SETTING_WITHDRAW_TYPE_IS_BITCOIN);
        model.addAttribute("bitcoin",sysParam.getParamValue());
        model.addAttribute("command", listVo);
        return getViewBasePath() + AGENT_DETAIL_BANK_CARD_URI;
    }

    /**
     * 总代理--详细页--银行卡
     * @param listVo
     * @param model
     * @return
     */
    @RequestMapping("/topagent/bankCard")
    public String generalBankCard(UserBankcardListVo listVo, Model model) {
        listVo.getPaging().setPageSize(10);
        listVo = ServiceTool.userBankcardService().search(listVo);
        model.addAttribute("command", listVo);
        return "/player/topagent/detail.include/BankCard";
    }

    /**
     * 代理--详细页--银行卡编辑页
     * @param objVo
     * @param model
     * @param bankListVo
     * @return
     */
    @RequestMapping("/agent/bankEdit")
    public String agentBankCardEdit(UserBankcardVo objVo, Model model, BankListVo bankListVo) {
        objVo.getSearch().setIsDefault(true);
        objVo = ServiceTool.userBankcardService().search(objVo);
        if(objVo.getResult()==null){
            objVo.setResult(new UserBankcard());
            objVo.getResult().setUserId(objVo.getSearch().getUserId());
        }
        model.addAttribute("command", objVo);

        bankListVo.getSearch().setType(BankEnum.TYPE_BANK.getCode());
        bankListVo.getSearch().setIsUse(true);
        bankListVo.setPaging(null);
        bankListVo = ServiceTool.bankService().search(bankListVo);
        model.addAttribute("bankListVo", bankListVo);

        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setId(objVo.getResult().getUserId());
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        model.addAttribute("sysUser", sysUserVo.getResult());
        //表单校验
        model.addAttribute("validate", JsRuleCreator.create(UserBankcardForm.class));
        return getViewBasePath() + AGENT_DETAIL_BANK_CARD_EDIT_URI;
    }

    /**
     * 总代理--详细页--银行卡编辑页
     * @param objVo
     * @param model
     * @param bankListVo
     * @return
     */
    @RequestMapping("/topagent/bankEdit")
    public String generalBankCardEdit(UserBankcardVo objVo, Model model, BankListVo bankListVo) {
        objVo.getSearch().setIsDefault(true);
        objVo = ServiceTool.userBankcardService().search(objVo);
        model.addAttribute("command", objVo);
        bankListVo.setResult(ServiceTool.bankService().allSearch(bankListVo));
        model.addAttribute("bankListVo", bankListVo);
        //表单校验
        model.addAttribute("validate", JsRuleCreator.create(UserBankcardForm.class));
        return "/player/topagent/detail.include/BankCardEdit";
    }

    /**
     * 代理--详细页--银行卡保存
     * @param objVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping("/agent/bankCardSave")
    @ResponseBody
    public Map agentBankCardSave(UserBankcardVo objVo, @FormModel @Valid UserBankcardForm form, BindingResult result) {
        Map map = new HashMap();
        if (result.hasErrors()) {
            map.put("state",false);
            return map;
        }
        saveUserBankcard(objVo, map);
        return map;
        //return editAndNewBankCard(objVo);
    }

    private void saveUserBankcard(UserBankcardVo objVo, Map map) {
        objVo = ServiceTool.userBankcardService().updateBank(objVo);
        if (objVo.isSuccess()) {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_SUCCESS));
        } else {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
        }

        map.put("state", Boolean.valueOf(objVo.isSuccess()));
    }

    /**
     * 总代理--详细页--银行卡保存
     * @param objVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping("/topagent/bankCardSave")
    @ResponseBody
    public Map topAgentBankCardSave(UserBankcardVo objVo, @FormModel @Valid UserBankcardForm form, BindingResult result) {
        Map map = new HashMap();
        if (result.hasErrors()) {
            map.put("state",false);
            return map;
        }
        saveUserBankcard(objVo, map);
        return map;
        //return editAndNewBankCard(objVo);
    }

    /**
     * 保存并新增银行卡
     * @param objVo
     * @return
     */
    public Map editAndNewBankCard(UserBankcardVo objVo) {
        UserBankcardVo newVo = new UserBankcardVo();
        UserBankcard newPo = new UserBankcard();
        UserBankcard oldPo = objVo.getResult();
        newPo.setUserId(oldPo.getUserId());
        newPo.setBankcardMasterName(oldPo.getBankcardMasterName());
        newPo.setBankcardNumber(oldPo.getBankcardNumber());
        newPo.setBankName(oldPo.getBankName());
        newPo.setCreateTime(SessionManager.getDate().getNow());
        newPo.setUseCount(0);
        newPo.setUseStauts(true);
        newPo.setIsDefault(true);
        newVo.setResult(newPo);
        newVo.setProperties(UserBankcard.PROP_ID);
        IUserBankcardService userBankcardService = ServiceTool.userBankcardService();
        UserBankcardVo insertReturnVo = userBankcardService.insertExclude(newVo);
        if (insertReturnVo.isSuccess()) {
            oldPo.setIsDefault(false);
            objVo.setProperties(UserBankcard.PROP_IS_DEFAULT);
            userBankcardService.updateOnly(objVo);
        }
        HashMap map = new HashMap(2,1f);
        if (objVo.isSuccess()) {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_SUCCESS));
        } else {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
        }

        map.put("state", Boolean.valueOf(objVo.isSuccess()));
        return map;
    }

    /**
     * 代理日志
     * @param model
     * @param sysAuditLogListVo
     * @return
     */
    @RequestMapping("/agent/log")
    public String log(Model model, SysAuditLogListVo sysAuditLogListVo, String roleType, HttpServletRequest request) {
        if(sysAuditLogListVo.getSearch().getOperatorBegin()==null&&sysAuditLogListVo.getSearch().getOperatorEnd()==null){
            sysAuditLogListVo.getSearch().setOperatorEnd(new Date());
            sysAuditLogListVo.getSearch().setOperatorBegin(DateTool.addDays(sysAuditLogListVo.getSearch().getOperatorEnd(),-7));
        }
        //日期不等
        if(sysAuditLogListVo.getSearch().getOperatorBegin()!=null && sysAuditLogListVo.getSearch().getOperatorEnd()!=null
                && DateTool.truncatedEquals(sysAuditLogListVo.getSearch().getOperatorBegin(), sysAuditLogListVo.getSearch().getOperatorEnd(), Calendar.SECOND)==false){
            sysAuditLogListVo.getSearch().setOperatorEnd(DateTool.addDays(sysAuditLogListVo.getSearch().getOperatorEnd(), +1));
        }
        //日期相等
        if(sysAuditLogListVo.getSearch().getOperatorBegin()!=null && sysAuditLogListVo.getSearch().getOperatorEnd()!=null && DateTool.truncatedCompareTo(sysAuditLogListVo.getSearch().getOperatorBegin(), sysAuditLogListVo.getSearch().getOperatorEnd(), Calendar.SECOND)==0){
            sysAuditLogListVo.getSearch().setOperatorEnd(DateTool.addDays(sysAuditLogListVo.getSearch().getOperatorEnd(), +1));
        }
        SysAuditLogSo search = sysAuditLogListVo.getSearch();
        search.setModuleType(ModuleType.PASSPORT_LOGIN.getCode());
        Paging paging = new Paging();
        paging.setPageSize(10);
        paging.setPageNumber(1);
        sysAuditLogListVo.setPaging(paging);
        sysAuditLogListVo.setSearch(search);
        SysAuditLogListVo logListVo = ServiceTool.userAgentService().searchLoginLog(sysAuditLogListVo);
        if(logListVo.getSearch().getOperatorBegin()!=null && logListVo.getSearch().getOperatorEnd()!=null){
            logListVo.getSearch().setOperatorEnd(DateTool.addDays(logListVo.getSearch().getOperatorEnd(), -1));
        }
        model.addAttribute("command", logListVo);
        model.addAttribute("roleType",roleType);
        model.addAttribute("maxDate", new Date());
        return ServletTool.isAjaxSoulRequest(request) ? AGENT_DETAIL_LOG_URI + "Partial" : AGENT_DETAIL_LOG_URI;
    }

    @RequestMapping("/getDefaultLocale")
    @ResponseBody
    public String getDefaultLocale(SiteLanguageListVo siteLanguageListVo){
        /*设置查询参数*/
        siteLanguageListVo.getSearch().setStatus(SiteLangStatusEnum.USING.getCode());
        siteLanguageListVo.getSearch().setSiteId(SessionManager.getSiteId());

        /*取字典国际化*/
        Map i18nMap = I18nTool.getDictsMap(SessionManager.getLocale().toString()).get(DictEnum.COMMON_LANGUAGE.getModule().getCode()).get(DictEnum.COMMON_LANGUAGE.getType());

        /*查询出*/
        List<SiteLanguage> siteLanguages  = CollectionQueryTool.query(
                                                    new ArrayList<>(Cache.getSiteLanguage().values()),
                                                    Criteria.add(SiteLanguage.PROP_STATUS, Operator.EQ, SiteLangStatusEnum.USING.getCode())
                                            );

        for(int i = 0;!siteLanguages.isEmpty()&&i < siteLanguages.size();i++){
            i18nMap.get(siteLanguages.get(i).getLanguage());
            String lang = StringTool.substringBefore(i18nMap.get(siteLanguages.get(i).getLanguage()).toString(), "#");
            siteLanguages.get(i).setStatus((lang));
        }

        return JsonTool.toJson(siteLanguages);
//        return ServiceTool.siteLanguageService().search(siteLanguageListVo).getResult();
    }

    @RequestMapping("/getSex")
    @ResponseBody
    public String getSex(){
        Map i18nMap = I18nTool.getDictsMap(SessionManager.getLocale().toString()).get(DictEnum.COMMON_SEX.getModule().getCode()).get(DictEnum.COMMON_SEX.getType());
        Map<String,Serializable> dictMap = DictTool.get(DictEnum.COMMON_SEX);
        for (String key : dictMap.keySet()){
            String i18n = i18nMap.get(((SysDict) dictMap.get(key)).getDictCode()).toString();
            ((SysDict) dictMap.get(key)).setRemark(i18n);

        }
        return JsonTool.toJson(dictMap.values());
    }
    @RequestMapping("/getMainCurrency")
    @ResponseBody
    public String mainCurrency(){
        Map i18nMap = I18nTool.getDictsMap(SessionManager.getLocale().toString()).get(DictEnum.COMMON_CURRENCY.getModule().getCode()).get(DictEnum.COMMON_CURRENCY.getType());
        Map<String,Serializable> dictMap = getSiteCurrencyMap();
        Map<String,SysDict> tempMap = new HashMap<>();
        for (String key : dictMap.keySet()){
            SysDict dict = new SysDict();
            dict.setDictCode(key);
            dict.setRemark(dictMap.get(key).toString());
            tempMap.put(key,dict);
        }
        return JsonTool.toJson(tempMap.values());
    }
    @RequestMapping("/checkAgentUserName")
    @ResponseBody
    public String checkAgentUserName(@RequestParam("agentUserName")String agentUserName){

        VUserTopAgentManageListVo vUserTopAgentManageListVo= new VUserTopAgentManageListVo();
        vUserTopAgentManageListVo.getSearch().setUsername(agentUserName);
        Criterion[] criterions = {new Criterion(VUserTopAgentManage.PROP_USERNAME,Operator.EQ,agentUserName)};
        vUserTopAgentManageListVo.getQuery().setCriterions(criterions);
        long count = ServiceTool.vUserTopAgentManageService().count(vUserTopAgentManageListVo);
        return (count>0) + "";
    }

    @RequestMapping("/getSomeByTop")
    @ResponseBody
    public String getSomeByTop(UserAgentVo userAgentVo){
        return JsonTool.toJson(getService().queryAgentRebate(userAgentVo));
    }

    @Override
    protected UserAgentVo doSave(UserAgentVo objectVo) {
        objectVo = doInitByParentId(objectVo);
        objectVo.getResult().setSitesId(SessionManager.getSiteId());
        objectVo.getResult().setBuiltIn(false);
        objectVo.getResult().setCreateChannel(UserAgentEnum.BACKGROUND_ADD.getCode());
        SysUser sysUser = buildUserData(objectVo);
        objectVo.setSysUser(sysUser);
        objectVo.getResult().setCheckTime(new Date());
        objectVo.getResult().setCheckUserId(SessionManager.getUser().getId());
        objectVo = getService().saveAgentInfo(objectVo);
        sendSiteMsg(objectVo);
        return objectVo;
    }
    /**
     * 组状用户信息
     * @param objectVo
     * @return
     */
    private SysUser buildUserData(UserAgentVo objectVo) {
        SysUser sysUser = objectVo.getSysUser();
        sysUser.setStatus(SysUserStatus.NORMAL.getCode());
        sysUser.setUserType(UserTypeEnum.AGENT.getCode());
        doInitUserOwnerId(objectVo, sysUser);
        sysUser.setBuiltIn(false);
        sysUser.setSiteId(SessionManager.getSiteId());
        sysUser.setCreateUser(SessionManager.getUserId());
        sysUser.setCreateTime(new Date());
        sysUser.setRegisterIp(SessionManager.getUser().getLoginIp());
        sysUser.setSubsysCode(ConfigManager.getConfigration().getAgentSubSysCode());
        if(StringTool.isBlank(sysUser.getDefaultLocale())){
            sysUser.setDefaultLocale(CommonContext.get().getLocale().toString());
        }
        if(StringTool.isBlank(sysUser.getDefaultCurrency())){
            sysUser.setDefaultCurrency(SessionManager.getUser().getDefaultCurrency());
        }
        doInitUserPassword(sysUser);
        return sysUser;
    }
    /**
     * 设置用户密码
     * @param sysUser
     */
    private void doInitUserPassword(SysUser sysUser) {
    /*密码*/
        String password = sysUser.getPassword();
        String PermissionPwd = sysUser.getPermissionPwd();

        if(!StringTool.isBlank(password)){
            sysUser.setPassword(AuthTool.md5SysUserPassword(password, sysUser.getUsername()));
        }
        if(!StringTool.isBlank(PermissionPwd)){
            sysUser.setPermissionPwd(AuthTool.md5SysUserPermission(PermissionPwd, sysUser.getUsername()));
        }
    }

    /**
     * 设置代理的上级代理信息
     * @param objectVo
     */
    private UserAgentVo doInitByParentId(UserAgentVo objectVo) {
        Integer parentId = objectVo.getAgentUserId();
        objectVo.getResult().setParentId(parentId);
        objectVo = getService().doInitByParent(objectVo);
        return objectVo;
    }
    /**
     * 设置用户的拥有者
     * @param objectVo
     * @param sysUser
     */
    private void doInitUserOwnerId(UserAgentVo objectVo, SysUser sysUser) {
        Integer parentId = objectVo.getAgentUserId();
        SysUserVo parentUserVo = new SysUserVo();
        parentUserVo.getSearch().setId(parentId);
        parentUserVo = ServiceTool.sysUserService().get(parentUserVo);
        if(parentUserVo.getResult()!=null&&parentUserVo.getResult().getOwnerId()!=null){
            sysUser.setOwnerId(parentUserVo.getResult().getOwnerId());
        }else{
            sysUser.setOwnerId(parentId);
        }
    }

    @Override
    protected UserAgentVo doUpdate(UserAgentVo objectVo) {
        SysParam param= ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SETTING_FIELD_SETTING_AGENT);
        List<FieldSort> fieldSortAll = (List<FieldSort>) JsonTool.fromJson(param.getParamValue(),JsonTool.createCollectionType(ArrayList.class,FieldSort.class));
        /*查询所有sys_user的注册项*/
        List<FieldSort> fieldSorts = CollectionQueryTool.andQuery(fieldSortAll, ListTool.newArrayList(new Criterion(FieldSort.PROP_STATUS, Operator.NE, "2"),
                new Criterion(FieldSort.PROP_IS_REGFIELD, Operator.EQ, "1")), Order.asc(FieldSort.PROP_SORT));
        objectVo.setFieldSorts(fieldSorts);
        objectVo.getSysUser().setUpdateTime(new Date());
        objectVo.getResult().setSitesId(SessionManager.getSiteId());
        objectVo.getSysUser().setSiteId(SessionManager.getSiteId());
        objectVo.getSysUser().setUpdateUser(SessionManager.getUserId());
        if(StringTool.isBlank(objectVo.getSysUser().getDefaultLocale())){
            objectVo.getSysUser().setDefaultLocale(CommonContext.get().getLocale().toString());
        }
        if(StringTool.isBlank(objectVo.getSysUser().getDefaultCurrency())){
            objectVo.getSysUser().setDefaultCurrency(SessionManager.getUser().getDefaultCurrency());
        }
        objectVo.setEditType(objectVo.getEditTypeAgent());
        objectVo.setChangeRebate(hasChangeRebate(objectVo));
        objectVo = getService().updateAgentInfo(objectVo);
        return objectVo;
    }

    private boolean hasChangeRebate(UserAgentVo objectVo){
        Integer userId = objectVo.getSysUser().getId();
        if(userId!=null){
            UserAgentRebateVo userAgentRebateVo = new UserAgentRebateVo();
            userAgentRebateVo.getSearch().setUserId(userId);
            userAgentRebateVo = ServiceTool.userAgentRebateService().search(userAgentRebateVo);
            if(userAgentRebateVo.getResult()!=null){
                Integer rebateId = userAgentRebateVo.getResult().getRebateId();
                Integer newRebateId = objectVo.getUserAgentRebate().getRebateId();
                if(rebateId!=null&&newRebateId!=null&&!rebateId.equals(newRebateId)){
                    return true;
                }
            }

        }
        return false;
    }

    @RequestMapping("/getMasterQuestion/{question}")
    @ResponseBody
    public String masterQuestion(@PathVariable String question){

        DictEnum dictEnum = null;
        if ("question1".equals(question)) {
            dictEnum = DictEnum.SETTING_MASTER_QUESTION1;
        } else if ("question2".equals(question)) {
            dictEnum = DictEnum.SETTING_MASTER_QUESTION2;
        } else if ("question3".equals(question)) {
            dictEnum = DictEnum.SETTING_MASTER_QUESTION3;
        }
        Map i18nMap = I18nTool.getDictsMap(SessionManager.getLocale().toString()).get(dictEnum.getModule().getCode()).get(dictEnum.getType());
        Map<String,Serializable> dictMap = DictTool.get(dictEnum);
        for (String key : dictMap.keySet()){
            String i18n = i18nMap.get(((SysDict) dictMap.get(key)).getDictCode()).toString();
            ((SysDict) dictMap.get(key)).setRemark(i18n);
        }
        return JsonTool.toJson(dictMap.values());
    }

    /**
     * 跳转到代理审核页面
     * @return
     */
    @RequestMapping("/toCheck")
    public String toCheck(UserAgentVo vo, Model model) {
        vo = getService().get(vo);
        Map map = this.getService().findAgentDetail(vo);
        Integer userId = vo.getSearch().getId();
        NoticeContactWay phone = getContactVal(userId, ContactWayType.CELLPHONE.getCode());
        NoticeContactWay email = getContactVal(userId, ContactWayType.EMAIL.getCode());
        NoticeContactWay msn = getContactVal(userId, ContactWayType.MSN.getCode());
        NoticeContactWay skype = getContactVal(userId, ContactWayType.SKYPE.getCode());
        NoticeContactWay qq = getContactVal(userId, ContactWayType.QQ.getCode());
        NoticeContactWay weixin = getContactVal(userId, ContactWayType.WEIXIN.getCode());
        VProgramListVo pvo = new VProgramListVo();
        pvo.getSearch().setUserId(vo.getSearch().getId());
        pvo = ServiceTool.vProgramService().search(pvo);
        for(VProgram v :pvo.getResult()){
            String type = v.getType();
            model.addAttribute(type, v);
        }
        /*站长、站长子账号*/
        UserTypeEnum userTypeEnum = SessionManager.getUserType();
        if(!userTypeEnum.equals(UserTypeEnum.MASTER) && !userTypeEnum.equals(UserTypeEnum.MASTER_SUB)){
            vo.getSearch().setParentId(SessionManager.getUserId());
        }
        Integer nextCheckAgentId = this.getService().findNextCheckAgentId(vo);
        model.addAttribute("validateRule",JsRuleCreator.create(AuditAgentForm.class));
        model.addAttribute("nextCheckAgentId", nextCheckAgentId);
        model.addAttribute("phone", phone);
        model.addAttribute("email", email);
        model.addAttribute("msn", msn);
        model.addAttribute("skype", skype);
        model.addAttribute("qq", qq);
        model.addAttribute("weixin", weixin);
        model.addAttribute("map", map);
        return getViewBasePath()+"Check";
    }

    /**
     * 获取代理对应总代方案
     * @return
     */
    @RequestMapping("/getProgram")
    @ResponseBody
    public List getProgram(VProgramListVo vo){
        if(vo.getSearch().getUserId()==null){
            return new ArrayList();
        }
        UserAgentVo userAgentVo = new UserAgentVo();
        userAgentVo.getSearch().setUserId(vo.getSearch().getUserId());
        List<VProgram> vPrograms = getService().getvProgramsByAgentId(userAgentVo);
        return vPrograms;
    }

    /**
     * 代理审核
     * @param vo
     * @return
     */
    @RequestMapping("/check")
    @ResponseBody
    public Map check(UserAgentVo vo){
        vo.setCheckUserId(SessionManager.getUserId());
        vo = this.getService().check(vo);
        //TODO 审核通过后系统需向代理发送“注册成功邮件”，
        if(vo.isSuccess() && StringTool.isBlank(vo.getOkMsg())) {
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "operation.success"));
        } else if(!vo.isSuccess() && StringTool.isBlank(vo.getErrMsg())) {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "operation.fail"));
        }
        return this.getVoMessage(vo);
    }
    /*private void updateTaskNum(){
        //生成任务提醒-1
        try{
            UserTaskReminderVo userTaskReminderVo = new UserTaskReminderVo();
            userTaskReminderVo.setTaskEnum(UserTaskEnum.AGENTREG);
            ServiceTool.userTaskReminderService().reduceTaskReminder(userTaskReminderVo);
        }catch (Exception ex){
            LOG.error(ex,"更新任务数出错");
        }

    }*/
    /**
     * 总代占成
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping("/topagent/ratio")
    public String ratio(UserAgentApiListVo vo,Model model){
        vo =ServiceTool.userAgentApiService().findRatioByUserId(vo);
        model.addAttribute("command", setGameType4Ratio(vo));
        return TOP_AGENT_DETAIL_RATIO_INDEX;
    }

    @RequestMapping("/editTopAgent")
    @Token(generate = true)
    public String editTopAgent(UserAgentVo userAgentVo,Model model){
        if(userAgentVo.getSearch().getId() == null){
            userAgentVo.setSysUser(new SysUser());
            userAgentVo.getSysUser().setDefaultCurrency(SessionManager.getUser().getDefaultCurrency());
            userAgentVo.getSysUser().setDefaultLocale(SessionManager.getUser().getDefaultLocale());
            String displayName = CommonContext.get().getTimeZone().getDisplayName();
            userAgentVo.getSysUser().setDefaultTimezone(displayName);
        }
        userAgentVo = getService().getForTopAgent(userAgentVo);

        /*联系方式*/
        userAgentVo.setContact(DictTool.get(DictEnum.COMMON_CONTACT_WAY_TYPE));

        /*时区*/
        userAgentVo.setTimeZone(getDefaultTimezone());

        /*主语言*/
        userAgentVo.setDictLanguage(DictTool.get(DictEnum.COMMON_LANGUAGE));

        //站点货币
        userAgentVo.setDictCurrency(getSiteCurrencyMap());

        /*星座*/
        userAgentVo.setDictConstellation(DictTool.get(DictEnum.COMMON_CONSTELLATION));

        userAgentVo.setValidateRule(JsRuleCreator.create(UserAgentForm.class, "result"));
        model.addAttribute("command", userAgentVo);
        return EDIT_TOP_AGENT;
    }

    @RequestMapping("/editAgent")
    @Token(generate = true)
    public String editAgent(UserAgentVo userAgentVo,Model model){
        userAgentVo = doCreate(userAgentVo,model);
        if(userAgentVo.getSearch().getId() == null){
            userAgentVo.setSysUser(new SysUser());
            userAgentVo.getSysUser().setDefaultCurrency(SessionManager.getUser().getDefaultCurrency());
            userAgentVo.getSysUser().setDefaultLocale(SessionManager.getUser().getDefaultLocale());
            String displayName = CommonContext.get().getTimeZone().getDisplayName();
            userAgentVo.getSysUser().setDefaultTimezone(displayName);
        }
        userAgentVo.setValidateRule(JsRuleCreator.create(UserAgentForm.class, "result"));
        model.addAttribute("command", userAgentVo);
        return getViewBasePath()+"Edit";
    }

    private Map<String,Serializable> getDefaultTimezone(){
        Map<String,Serializable> timezone = new HashMap<>();
        String displayName = CommonContext.get().getTimeZone().getDisplayName();
        Map<String, Serializable> dict = DictTool.getDict(Module.COMMON.getCode(), DictEnum.COMMON_TIME_ZONE.getType());
        Serializable serializable = dict.get(displayName);
        timezone.put(displayName,serializable);
        return timezone;
    }

    public Map<String, Serializable> getSiteCurrencyMap() {
        Map<String,SiteCurrency> siteCurrencyMap = Cache.getSiteCurrency(SessionManager.getSiteId());
        Map<String, Serializable> tempMap = new HashMap<>();
        Iterator<String> iter = siteCurrencyMap.keySet().iterator();
        while (iter.hasNext()){
            SiteCurrency currency = siteCurrencyMap.get(iter.next());
            String tran = LocaleTool.tranDict(DictEnum.COMMON_CURRENCY, currency.getCode());
            tempMap.put(currency.getCode(),tran);
        }
        return tempMap;
    }
    @RequestMapping("/previewTopagent")
    public String previewTopagent(UserAgentVo objectVo, @FormModel("result") @Valid UserAgentForm form, BindingResult result,Model model){
        /*if(result.hasErrors())
            return null;*/
        objectVo = initTopagent(objectVo);

        RakebackSetListVo listVo = new RakebackSetListVo();
        if(objectVo.getRakebackIds()!=null&&objectVo.getRakebackIds().size()>0){
            listVo.getSearch().setIds(objectVo.getRakebackIds());
            listVo.setPaging(null);
            listVo = ServiceTool.rakebackSetService().search(listVo);
            model.addAttribute("rakeback", listVo.getResult());
        }
        //rebateIds rakebackIds
        RebateSetListVo rebateSetListVo = new RebateSetListVo();
        if(objectVo.getRebateIds()!=null&&objectVo.getRebateIds().size()>0){
            rebateSetListVo.getSearch().setIds(objectVo.getRebateIds());
            rebateSetListVo.setPaging(null);
            rebateSetListVo = ServiceTool.rebateSetService().search(rebateSetListVo);
            model.addAttribute("rebate", rebateSetListVo.getResult());
        }
        objectVo.setGameTypeMap(getGameTypeI18n());
        model.addAttribute("command",objectVo);
        return "/player/topagent/TopagentPreview";
    }

    private UserAgentVo initTopagent(UserAgentVo objectVo){
        SysUser sysUser = objectVo.getSysUser();
        objectVo.getResult().setSitesId(SessionManager.getSiteId());
        objectVo.getResult().setBuiltIn(false);
        objectVo.getResult().setAgentRank(0);
        objectVo.getResult().setCreateChannel(UserAgentEnum.BACKGROUND_ADD.getCode());
        sysUser.setStatus(SysUserStatus.NORMAL.getCode());
//        添加完没刷新列表
//        默认语言、默认币种取站长的d
        sysUser.setCreateTime(new Date());
        sysUser.setCreateUser(SessionManager.getUserId());
        sysUser.setRegisterIp(SessionManager.getUser().getLoginIp());
        sysUser.setSubsysCode(ConfigManager.getConfigration().getTopAgentSubSysCode());
        sysUser.setUserType(UserTypeEnum.TOP_AGENT.getCode());
        sysUser.setBuiltIn(false);
        sysUser.setSiteId(SessionManager.getSiteId());
        objectVo.getResult().setRegistCode(RandomStringTool.randomAlphanumeric(6).toLowerCase());
        /*密码*/
        doInitUserPassword(sysUser);
        return objectVo;
    }

    @RequestMapping("/persistTopAgent")
    @ResponseBody
    @Token(valid = true)
    public Map persistTopAgent(UserAgentVo objectVo, @FormModel("result") @Valid UserAgentForm form, BindingResult result){
        Map resultMap = new HashMap();
        if(result.hasErrors()){
            resultMap.put("state",false);
            return resultMap;
        }
        try{
            objectVo = initTopagent(objectVo);
            objectVo = getService().persistTopAgent(objectVo);
            return getVoMessage(objectVo);
        }catch (Exception ex){
            LOG.error(ex,"保存总代出错");
            resultMap.put("state",false);
            resultMap.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
            return resultMap;
        }
    }
    @RequestMapping("/topagent/ratioEdit")
    public String ratioEdit(UserAgentApiListVo userAgentApiListVo,Model model){
        userAgentApiListVo.setValidateRule(JsRuleCreator.create(UserAgentApiForm.class,"result"));
        userAgentApiListVo =ServiceTool.userAgentApiService().findRatioByUserId(userAgentApiListVo);
        model.addAttribute("command", setGameType4Ratio(userAgentApiListVo));
        /*form*/
        return TOP_AGENT_DETAIL_RATIO_EDIT;
    }
    @RequestMapping("/topagent/ratioPersist")
    @ResponseBody
    public Map ratioPersist(UserAgentApiListVo userAgentApiListVo,@FormModel("result") @Valid UserAgentApiForm form,BindingResult result){
        if(result.hasErrors())
            return null;
        userAgentApiListVo = getService().apiPersist(userAgentApiListVo);
        return getVoMessage(userAgentApiListVo);
    }
    @RequestMapping("/editTopAgentPartial")
    public String editTopAgentPartial(UserAgentApiListVo userAgentApiListVo,Model model){
        userAgentApiListVo.setForEditTopAgent(true);
        userAgentApiListVo =ServiceTool.userAgentApiService().findRatioByUserId(userAgentApiListVo);
        model.addAttribute("command", setGameType4Ratio(userAgentApiListVo));
        return TOP_AGENT_EDIT_PARTIAL;
    }
    @RequestMapping("/toApiSet")
    public String toApiSet(UserAgentApiListVo userAgentApiListVo,Model model){

        return TOP_AGENT_API_SET;
    }

    @RequestMapping(value = "/checkAgentName")
    @ResponseBody
    public String checkAgentName(@RequestParam("sysUser.username") String userName,@RequestParam("editType") String editType){
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.setSearch(new SysUserSo());
        if(EDIT_TYPE_AGENT.equals(editType)){
            sysUserVo.getSearch().setSubsysCode(SubSysCodeEnum.MCENTER_AGENT.getCode());
        }else if (EDIT_TYPE_TOP_AGENT.equals(editType)){
            sysUserVo.getSearch().setSubsysCode(SubSysCodeEnum.MCENTER_TOP_AGENT.getCode());
        }
        sysUserVo.getSearch().setUsername(userName);
        sysUserVo.getSearch().setSiteId(SessionManager.getSiteId());
        boolean exists = ServiceTool.sysUserService().isExists(sysUserVo);

        return exists ? "false" : "true";
    }

    /**
     * 设置游戏类型与api关系，总代设置占成使用
     * @param objectVo
     * @return
     */
    public UserAgentApiListVo setGameType4Ratio(UserAgentApiListVo objectVo){
        VGameTypeListVo vGameTypeListVo = new VGameTypeListVo();
        vGameTypeListVo.getQuery().addOrder(VGameType.PROP_API_ID,Direction.ASC).addOrder(VGameType.PROP_GAME_TYPE,Direction.ASC);
        vGameTypeListVo.getQuery().setCriterions(new Criterion[]{new Criterion(VGameType.PROP_SITE_ID, Operator.EQ,objectVo._getSiteId())});
        vGameTypeListVo.setProperties(VGameType.PROP_GAME_TYPE,VGameType.PROP_API_ID);
        List<Map<String,Object>> someGames = ServiceTool.vGameTypeService().searchProperties(vGameTypeListVo);
        objectVo.setGroupSomeGames(CollectionTool.groupByProperty(someGames, VGameType.PROP_API_ID, Map.class));
        objectVo.setSomeGames(someGames);
        objectVo.setGameTypeMap(getGameTypeI18n());
        return objectVo;
    }

    private Map<String, SiteI18n> getGameTypeI18n(){
        Map<String, SiteI18n> map = Cache.getGameTypeI18n();
        return map;
    }

    private void sendSiteMsg(UserAgentVo userAgentVo){
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(AutoNoticeEvent.AGENT_REGISTER_SUCCESS);
        noticeVo.setSendUserId(NoticeVo.SEND_USER_ID);
        Map<NoticePublishMethod, Set<NoticeTmpl>> noticePublishMethodSetMap = ServiceTool.noticeService().fetchTmpls(noticeVo);
        noticeVo.setTmplMap(noticePublishMethodSetMap);
        noticeVo.addUserIds(userAgentVo.getResult().getId());
        noticeVo.addParams(new Pair<String, String>("sitename",SessionManager.getSiteName(null)));
        try{
            ServiceTool.noticeService().publish(noticeVo);
        }catch (Exception ex){
            LogFactory.getLog(this.getClass()).error(ex,"发布消息不成功");
        }
    }

    //endregion your codes 3

}