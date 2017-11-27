package so.wwb.gamebox.mcenter.fund.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.IpTool;
import org.soul.commons.net.ServletTool;
import org.soul.commons.support._Module;
import org.soul.model.comet.vo.MessageVo;
import org.soul.model.listop.po.SysListOperator;
import org.soul.model.msg.notice.vo.NoticeLocaleTmpl;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.model.security.privilege.po.SysUser;
import org.soul.model.security.privilege.vo.SysResourceListVo;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.model.sys.po.SysDict;
import org.soul.model.sys.po.SysParam;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.listop.ListOpTool;
import org.soul.web.session.SessionManagerBase;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.fund.IVAgentWithdrawOrderService;
import so.wwb.gamebox.mcenter.enmus.ListOpEnum;
import so.wwb.gamebox.mcenter.fund.form.VAgentWithdrawOrderForm;
import so.wwb.gamebox.mcenter.fund.form.VAgentWithdrawOrderSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.share.form.SysListOperatorForm;
import so.wwb.gamebox.model.*;
import so.wwb.gamebox.model.boss.enums.TemplateCodeEnum;
import so.wwb.gamebox.model.common.Const;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.common.notice.enums.AutoNoticeEvent;
import so.wwb.gamebox.model.common.notice.enums.CometSubscribeType;
import so.wwb.gamebox.model.common.notice.enums.ManualNoticeEvent;
import so.wwb.gamebox.model.common.notice.enums.NoticeParamEnum;
import so.wwb.gamebox.model.company.site.po.SiteCurrency;
import so.wwb.gamebox.model.company.site.po.SiteCustomerService;
import so.wwb.gamebox.model.company.site.vo.SiteCustomerServiceVo;
import so.wwb.gamebox.model.listop.FilterRow;
import so.wwb.gamebox.model.listop.FilterSelectConstant;
import so.wwb.gamebox.model.listop.TabTypeEnum;
import so.wwb.gamebox.model.master.enums.RemarkEnum;
import so.wwb.gamebox.model.master.fund.enums.AgentWithdrawOrderStatusEnum;
import so.wwb.gamebox.model.master.fund.enums.CheckStatusEnum;
import so.wwb.gamebox.model.master.fund.enums.TransferStatusEnum;
import so.wwb.gamebox.model.master.fund.po.AgentWithdrawOrder;
import so.wwb.gamebox.model.master.fund.po.VAgentWithdrawOrder;
import so.wwb.gamebox.model.master.fund.po.VPlayerWithdraw;
import so.wwb.gamebox.model.master.fund.so.VAgentWithdrawOrderSo;
import so.wwb.gamebox.model.master.fund.vo.AgentWithdrawOrderVo;
import so.wwb.gamebox.model.master.fund.vo.VAgentWithdrawOrderListVo;
import so.wwb.gamebox.model.master.fund.vo.VAgentWithdrawOrderVo;
import so.wwb.gamebox.model.master.player.po.Remark;
import so.wwb.gamebox.model.master.player.vo.RemarkListVo;
import so.wwb.gamebox.model.master.player.vo.UserAgentVo;
import so.wwb.gamebox.model.master.player.vo.UserBankcardVo;
import so.wwb.gamebox.web.cache.Cache;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.text.MessageFormat;
import java.util.*;


/**
 * 控制器
 *
 * @author orange
 * @time 2015-9-17 15:05:28
 */
@Controller
@RequestMapping("/fund/vAgentWithdrawOrder")
public class VAgentWithdrawOrderController extends BaseCrudController<IVAgentWithdrawOrderService, VAgentWithdrawOrderListVo, VAgentWithdrawOrderVo, VAgentWithdrawOrderSearchForm, VAgentWithdrawOrderForm, VAgentWithdrawOrder, Integer> {

    private static final Log LOG = LogFactory.getLog(VAgentWithdrawOrderController.class);
    private static final String AGENT_LIST = "/fund/agentWithdraw/Index";
    private static final String AGENT_AUDIT = "/fund/agentWithdraw/AgentAudit";
    private static final String AGENT_DETAIL = "/fund/agentWithdraw/AgentDetail";
    private static final String WITHDRAW_PUT_CONFIRM_CHECK_PASS_URI = "/fund/agentWithdraw/PutConfirmOK";
    //提现记录-选择审核失败原因
    public static final String WITHDRAW_PUT_CHECK_FAILURE_URI = "/fund/agentWithdraw/PutConfirmError";
    //提现记录-拒绝申请原因
    public static final String WITHDRAW_PUT_CHECK_REFUSES_URI = "/fund/agentWithdraw/PutConfirmRefuses";

    @Override
    protected String getViewBasePath() {
        return "/fund/agentWithdraw/";
    }

    /**
     * 资金管理-代理取款审核
     *
     * @param listVo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/agentList")
    public String agentList(VAgentWithdrawOrderListVo listVo, Model model, HttpServletRequest request) {
        VAgentWithdrawOrderSo search = listVo.getSearch();
        if(StringTool.isNotBlank(search.getUsername())){
            String[] split = search.getUsername().split(",");
            if(split.length == 1){
                search.setUsername(search.getUsername().replaceAll("_","\\\\_"));
            }
        }
        if(StringTool.isNotBlank(search.getAuditname())){
            search.setAuditname(search.getAuditname().replaceAll("_","\\\\_"));
        }
        if(StringTool.isNotBlank(search.getRealName())){
            search.setRealName(search.getRealName().replaceAll("_","\\\\_"));
        }
        if(StringTool.isNotBlank(search.getAgentBankcard())){
            search.setAgentBankcard(search.getAgentBankcard().replaceAll("_","\\\\_"));
        }
        listVo.setSearch(search);
        //ip转义
        String ipStr = listVo.getSearch().getIpStr();
        listVo.getSearch().setIpWithdraw(StringTool.isBlank(ipStr)?null: IpTool.ipv4StringToLong(listVo.getSearch().getIpStr()));
        listVo.setValidateRule(JsRuleCreator.create(VAgentWithdrawOrderSearchForm.class, "search"));
        listVo = ServiceTool.getVAgentWithdrawOrderService().searchAgentWithdraw(listVo);
        // 公司入款声音参数
        SysParam systemParam = ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DRAW);
        model.addAttribute("systemParam", systemParam);
        if (SessionManager.getAgentWithdrawNotice() != null) {
            systemParam.setActive(SessionManager.getAgentWithdrawNotice());
        }
        listVo.setTone(systemParam);

        //筛选模板
        String templateCode = TemplateCodeEnum.fund_withdraw_agent_check.getCode();
        model.addAttribute("searchTempCode", templateCode);
        model.addAttribute("searchTemplates", CacheBase.getSysSearchTempByCondition(SessionManagerBase.getUserId(), TemplateCodeEnum.fund_withdraw_agent_check.getCode()));
        //总额计算
        listVo.setPropertyName(VPlayerWithdraw.PROP_WITHDRAW_AMOUNT);
        Number sum = this.getService().sum(listVo);

        listVo.setTotalSum(CurrencyTool.CURRENCY.format(sum == null?0:sum.doubleValue()));
        model.addAttribute("command", listVo);

        Map<String, Serializable> transactionStatus = DictTool.get(DictEnum.TRANSACTION_STATUS);
        model.addAttribute("transactionStatus", transactionStatus);
        Map<String, Serializable> bankName = DictTool.get(DictEnum.BANKNAME);
        model.addAttribute("bankName", bankName);
        if(StringTool.isNotBlank(search.getUsername())){
            search.setUsername(search.getUsername().replaceAll("\\\\",""));
        }
        if(StringTool.isNotBlank(search.getAuditname())){
            search.setAuditname(search.getAuditname().replaceAll("\\\\",""));
        }
        if(StringTool.isNotBlank(search.getRealName())){
            search.setRealName(search.getRealName().replaceAll("\\\\",""));
        }
        if(StringTool.isNotBlank(search.getAgentBankcard())){
            search.setAgentBankcard(search.getAgentBankcard().replaceAll("\\\\",""));
        }
        listVo.setSearch(search);
        todayTotal(listVo);
        return ServletTool.isAjaxSoulRequest(request) ? AGENT_LIST + "Partial" : AGENT_LIST;
    }
    //查询今日成功订单总额
    public void todayTotal(VAgentWithdrawOrderListVo listVo) {
        VAgentWithdrawOrderListVo vAgentWithdrawOrderListVo = new VAgentWithdrawOrderListVo();

        Date today = SessionManager.getDate().getToday();
        Date todayEnd = DateTool.addDays(SessionManager.getDate().getToday(),1);
        vAgentWithdrawOrderListVo.getSearch().setCheckTimeStart(today);
        vAgentWithdrawOrderListVo.getSearch().setCheckTimeEnd(todayEnd);
        vAgentWithdrawOrderListVo.getSearch().setTransactionStatus(TransferStatusEnum.SUCCESS.getCode());
        vAgentWithdrawOrderListVo._setContextParam(listVo._getContextParam());
        vAgentWithdrawOrderListVo.setPropertyName(VAgentWithdrawOrder.PROP_ACTUAL_AMOUNT);
        Number sum = this.getService().sum(vAgentWithdrawOrderListVo);
        listVo.setTodayTotal(CurrencyTool.formatCurrency(sum == null ? 0 : sum));
    }
    /**
     * 启用停用声音提醒
     */
    @RequestMapping({"/toneSwitch"})
    @ResponseBody
    public Map<String, Object> toneSwitch(@RequestParam("paramVal") String paramVal) {
        SessionManager.setAgentWithdrawNotice(paramVal);
        Map map = new HashMap();
        map.put("state", true);
        return map;//toneSwitch(SiteParamEnum.WARMING_TONE_DRAW);
    }

    /**
     * 进入审核页面
     *
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping("/agentAudit")
    public String agentAudit(VAgentWithdrawOrderVo vo, Model model) {
        setAuditData(vo, model);
        return AGENT_AUDIT;
    }

    private VAgentWithdrawOrderVo setAuditData(VAgentWithdrawOrderVo vo, Model model) {
        //审核页面
        vo = ServiceTool.getVAgentWithdrawOrderService().get(vo);
        vo.setThisUserId(SessionManager.getUserId());
        vo.setUserType(SessionManager.getUser().getUserType());
        setBankcard(vo, model);

        getNextId(vo, model);


        model.addAttribute("command", vo);
        return vo;
    }

    private void setBankcard(VAgentWithdrawOrderVo vo, Model model) {
        //判断收款账号是否是第一次使用
        UserBankcardVo userBankcardVo = new UserBankcardVo();
        userBankcardVo.getSearch().setUserId(vo.getResult().getAgentId());
        userBankcardVo.getSearch().setIsDefault(true);
        userBankcardVo = ServiceTool.userBankcardService().search(userBankcardVo);
        model.addAttribute("userBankcardVo", userBankcardVo);
    }

    private void getNextId(VAgentWithdrawOrderVo vo, Model model) {
        //判断是否有没有下一条数据
        VAgentWithdrawOrderVo vo1 = new VAgentWithdrawOrderVo();
        vo1.setResult(new VAgentWithdrawOrder());
        vo1 = ServiceTool.getVAgentWithdrawOrderService().searchNext(vo);
        model.addAttribute("commandNextId", vo1);
    }

    @RequestMapping("/showAgentAuditView")
    public String showAgentAuditView(VAgentWithdrawOrderVo vo, Model model){
        vo = setAuditData(vo, model);
        setOtherData(vo, model);
        return getViewBasePath() + "AgentAuditView";
    }

    private void setOtherData(VAgentWithdrawOrderVo vo, Model model) {
        if(vo.getResult()!=null&&vo.getResult().getAgentId()!=null){
            UserAgentVo agentVo = new UserAgentVo();
            agentVo.getSearch().setId(vo.getResult().getAgentId());
            agentVo = ServiceTool.getUserAgentService().get(agentVo);
            if(agentVo.getResult()!=null&&agentVo.getResult().getParentId()!=null){
                SysUserVo topAgentVo = new SysUserVo();
                topAgentVo.getSearch().setId(agentVo.getResult().getParentId());
                topAgentVo = ServiceTool.sysUserService().get(topAgentVo);
                model.addAttribute("topAgentVo",topAgentVo);
            }

        }
    }

    /**
     * 进去详细页面
     *
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping("/agentDetail")
    public String agentDetail(VAgentWithdrawOrderVo vo, RemarkListVo listVo, Model model, HttpServletRequest request) {
        setAuditDetailData(vo, listVo, model);
        return ServletTool.isAjaxSoulRequest(request) ? AGENT_DETAIL + "Partial" : AGENT_DETAIL;
    }

    private VAgentWithdrawOrderVo setAuditDetailData(VAgentWithdrawOrderVo vo, RemarkListVo listVo, Model model) {
        vo = ServiceTool.getVAgentWithdrawOrderService().get(vo);
        vo.setThisUserId(SessionManager.getUserId());
        vo.setUserType(SessionManager.getUser().getUserType());
        model.addAttribute("vo", vo);
        //备注列表
        if(vo.getResult().getAgentId()!=null){
            listVo.getSearch().setEntityUserId(vo.getResult().getAgentId());
            listVo.getSearch().setEntityId(vo.getResult().getId());
            listVo.getSearch().setRemarkType(RemarkEnum.FUND_WITHDRAW.getType());
            listVo.getSearch().setModel(RemarkEnum.FUND_WITHDRAW.getModel());
            listVo = ServiceTool.getRemarkService().search(listVo);
        }

        model.addAttribute("command", listVo);
        return vo;
    }

    @RequestMapping("/showAgentAuditDetail")
    public String showAgentAuditDetail(VAgentWithdrawOrderVo vo, RemarkListVo listVo, Model model){
        vo = setAuditDetailData(vo, listVo, model);
        setOtherData(vo, model);
        setBankcard(vo, model);
        getNextId(vo, model);
        return getViewBasePath() + "AgentAuditDetail";
    }

    /**
     * 代理取款--筛选
     *
     * @param model
     * @return
     */
    @RequestMapping("/agentWithdrawFilter")
    public String agentWithdrawFilter(Model model) {
        Map<String, SysListOperator> listOp = ListOpTool.getFilter(ListOpEnum.VAgentWithdrawOrderListVo);
        Map i18nMap = I18nTool.getDictsMap(SessionManager.getLocale().toString()).get(Module.FUND.getCode());

        if (listOp != null && listOp.size() > 0) {
            model.addAttribute("filters", listOp.values());
        }
        List<FilterRow> filterRowList = new ArrayList<>();
        //货币：等于/不等于
        List<Pair> currencys = new ArrayList<>();
        Map<String, SiteCurrency> currencyList = Cache.getSiteCurrency();
        if (CollectionTool.isNotEmpty(currencyList.values())) {
            Map<String, String> curencyI18nMap = I18nTool.getDictsMap(SessionManagerBase.getLocale().toString()).get(Module.COMMON.getCode()).get(DictEnum.COMMON_CURRENCY.getType());
            for (SiteCurrency currency : currencyList.values()) {
                currencys.add(new Pair(currency.getCode(), curencyI18nMap.get(currency.getCode())));
            }
        }
        //filterRowList.add(new FilterRow(VAgentWithdrawOrder.PROP_CURRENCY, LocaleTool.tranView("column", VAgentWithdrawOrder.class.getSimpleName() + "." + VAgentWithdrawOrder.PROP_CURRENCY), FilterSelectConstant.equal, TabTypeEnum.SELECT, currencys));

        //申请取款金额：大于等于/等于/小于等于
        filterRowList.add(new FilterRow(VAgentWithdrawOrder.PROP_WITHDRAW_AMOUNT, LocaleTool.tranView("column", VAgentWithdrawOrder.class.getSimpleName() + "." + VAgentWithdrawOrder.PROP_WITHDRAW_AMOUNT), FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));

        //取款时间：大于等于/等于/小于等于
        filterRowList.add(new FilterRow(VAgentWithdrawOrder.PROP_CREATE_TIME, LocaleTool.tranView("column", VAgentWithdrawOrder.class.getSimpleName() + "." + VAgentWithdrawOrder.PROP_CREATE_TIME), FilterSelectConstant.equalRange, TabTypeEnum.DATE, null));

        //状态：包含/不包含
        List<Pair> checkStatus = new ArrayList<>();

        Map<String, SysDict> withdrawStatusMap = DictTool.get(DictEnum.TRANSACTION_STATUS);

        Map agentTypeMap = (Map) i18nMap.get(DictEnum.TRANSACTION_STATUS.getType());
        for (String key : withdrawStatusMap.keySet()) {
            checkStatus.add(new Pair(key, agentTypeMap.get(key)));
        }
        filterRowList.add(new FilterRow(VAgentWithdrawOrder.PROP_TRANSACTION_STATUS, LocaleTool.tranView("column", VAgentWithdrawOrder.class.getSimpleName() + "." + VAgentWithdrawOrder.PROP_TRANSACTION_STATUS), FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, checkStatus));

        model.addAttribute("validateRule", JsRuleCreator.create(SysListOperatorForm.class, ""));
        model.addAttribute("keyClassName", ListOpEnum.VAgentWithdrawOrderListVo.getClassName());
        model.addAttribute("filterList", filterRowList);
        model.addAttribute("jsonFilterList", JsonTool.toJson(filterRowList));
        model.addAttribute("goFilterUrl", "/agent/agentTradingOrder/agentList.html");
        return "/share/ListFilters";
    }

    /**
     * 锁定订单
     *
     * @param vo
     * @return
     */
    @RequestMapping("/lockOrder")
    @ResponseBody
    public Map lockOrder(AgentWithdrawOrderVo vo) {
        vo.setResult(new AgentWithdrawOrder());
        vo.getResult().setId(vo.getSearch().getId());
        vo.getResult().setIsLock(1);
        vo.getResult().setLockPersonId(SessionManager.getUserId());
        vo.setProperties(AgentWithdrawOrder.PROP_IS_LOCK, AgentWithdrawOrder.PROP_LOCK_PERSON_ID);
        vo = ServiceTool.getAgentWithdrawOrderService().updateOnly(vo);
        if (vo.isSuccess()) {
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "update.success"));
        } else {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "update.failed"));
        }
        HashMap map = new HashMap(2,1f);
        map.put("msg", StringTool.isNotBlank(vo.getOkMsg()) ? vo.getOkMsg() : vo.getErrMsg());
        map.put("state", Boolean.valueOf(vo.isSuccess()));
        return map;
    }

    /**
     * 取消锁定订单
     *
     * @return
     */
    @RequestMapping("/cancelLockOrder")
    @ResponseBody
    public Map cancelLockOrder(AgentWithdrawOrderVo vo) {
        if(vo.getSearch().getId()!=null){
            vo.setResult(new AgentWithdrawOrder());
            vo.getResult().setId(vo.getSearch().getId());
            vo.getResult().setIsLock(null);
            vo.getResult().setLockPersonId(null);
            vo.setProperties(AgentWithdrawOrder.PROP_IS_LOCK, AgentWithdrawOrder.PROP_LOCK_PERSON_ID);
            vo = ServiceTool.getAgentWithdrawOrderService().updateOnly(vo);
        }else{
            vo.setSuccess(false);
        }
        HashMap map = new HashMap(2,1f);
        //map.put("msg", StringTool.isNotBlank(vo.getOkMsg()) ? vo.getOkMsg() : vo.getErrMsg());
        map.put("state", vo.isSuccess());
        return map;
    }

    /**
     * 提现审核前先判断订单是否已锁定
     *
     * @param vo
     * @return
     */
    @RequestMapping({"/isAuditPerson"})
    @ResponseBody
    protected String isAuditPerson(AgentWithdrawOrderVo vo) {
        Integer id = SessionManager.getUserId();
        String json = null;
        vo = ServiceTool.getAgentWithdrawOrderService().get(vo);//取款视图表
        if ((id).equals(vo.getResult().getLockPersonId()) || vo.getResult().getLockPersonId() == null) {
            json = "true";
        } else {
            //取款订单被锁定
            SysUserVo sysUserVo = new SysUserVo();
            sysUserVo.setResult(new SysUser());
            sysUserVo.getSearch().setId(vo.getResult().getLockPersonId());
            sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
            String username = sysUserVo.getResult().getUsername();
            json = username;
        }
        return json;
    }

    /**
     * 提现记录-确认审核通过弹窗
     *
     * @param objVo
     * @param model
     * @return
     */
    @RequestMapping("/putConfirmCheck")
    public String putConfirmCheck(VAgentWithdrawOrderVo objVo, Model model) {
        if(objVo.getSearch().getId()!=null){
            objVo = ServiceTool.getVAgentWithdrawOrderService().search(objVo);
            objVo.getResult().setActualAmount(objVo.getResult().getWithdrawAmount());
            model.addAttribute("command", objVo);
            setOtherData(objVo,model);
        }
        return WITHDRAW_PUT_CONFIRM_CHECK_PASS_URI;
    }

    /**
     * 判断是否已经审核过
     *
     * @param objVo
     * @return
     */
    @RequestMapping("/isAudit")
    @ResponseBody
    private Map isAudit(AgentWithdrawOrderVo objVo) {
        objVo = ServiceTool.getAgentWithdrawOrderService().get(objVo);
        Boolean bool = null;
        bool = !AgentWithdrawOrderStatusEnum.PENDING.getCode().equals(objVo.getResult().getTransactionStatus());
        HashMap map = new HashMap(1,1f);
        map.put("state", bool);
        return map;
    }

    /**
     * 提现记录-提现审核：更新审核订单状态
     * Modified  jerry  2016-12-11
     * @param objVo
     */
    @RequestMapping("/putAuditStatus")
    @ResponseBody
    public Map putAuditStatus(AgentWithdrawOrderVo objVo, UserAgentVo vo, Remark remark) {
        objVo = ServiceTool.getAgentWithdrawOrderService().get(objVo);

        SysUserVo agentUser = new SysUserVo();
        agentUser.getSearch().setId(objVo.getResult().getAgentId());
        agentUser = ServiceTool.sysUserService().get(agentUser);
        objVo.setUsername(agentUser.getResult().getUsername());

        String timezone = Cache.getUserTimezone(objVo.getResult().getAgentId());
        String time = LocaleDateTool.formatDate(objVo.getResult().getCreateTime(), LocaleDateTool.getFormat("DAY_SECOND"), timezone);
        String money = CurrencyTool.formatCurrency(objVo.getResult().getWithdrawAmount());
        SiteCustomerServiceVo serviceVo = new SiteCustomerServiceVo();
        serviceVo.getSearch().setSiteId(SessionManager.getSiteId());
        String customer = LocaleTool.tranMessage(Module.COMPANY_SETTING, MessageI18nConst.NOTICE_PARAM_CUSTOMER);
        SiteCustomerService defaultCustomService = ServiceTool.siteCustomerServiceService().getDefaultCustomService(serviceVo);
        if (defaultCustomService != null) {
            customer = "<a href=\"" + defaultCustomService.getParameter() + "\" target=\"_blank\">" + customer + "</a>";
        }
        String username = agentUser.getResult().getUsername();
        if (StringTool.isNotBlank(remark.getRemarkContent())) {
            remark = buildRemarkData(objVo, remark);
            String remarkTitle = I18nTool.getDictsMap(SessionManagerBase.getLocale().toString()).get(Module.COMMON.getCode()).get(DictEnum.COMMON_REMARK_TITLE.getType()).get("agent_withdraw");
            remarkTitle = remarkTitle.replace("%checkUser%", SessionManager.getUserName());
            remarkTitle = remarkTitle.replace("%player%", objVo.getUsername());
            remarkTitle = remarkTitle.replace("%createTime%", LocaleDateTool.formatDate(objVo.getResult().getCreateTime(),
                    CommonContext.getDateFormat().getDAY_SECOND(), time));
            remark.setRemarkTitle(remarkTitle);
        }
        //审核内容
        if (objVo.getSearch().getReasonTitle() != null && objVo.getSearch().getReasonContent() != null) {
            String orginTitle = objVo.getSearch().getReasonTitle();
            orginTitle = orginTitle.replace("${orderlaunchtime}", time);
            orginTitle = orginTitle.replace("${orderamount}", money);
            if (orginTitle.length() > 128) {
                LOG.warn("代理审核反馈标题超长,被截取");
                orginTitle = orginTitle.substring(0, 125) + "...";
            }
            objVo.getResult().setReasonTitle(orginTitle);
            String orginContent = objVo.getSearch().getReasonContent();
            orginContent = orginContent.replace("${orderlaunchtime}", time);
            orginContent = orginContent.replace("${orderamount}", money);
            orginContent = orginContent.replace("${ordernum}", objVo.getResult().getTransactionNo());
            orginContent = orginContent.replace("${customer}", customer);
            if (orginContent.length() > 1000) {
                LOG.warn("代理审核反馈内容超长,被截取");
                orginContent = orginContent.substring(0, 997) + "...";
            }
            objVo.getResult().setReasonContent(orginContent);
        }
        objVo.getResult().setAuditTime(SessionManager.getDate().getNow());
        objVo.getResult().setAuditUserId(SessionManager.getUserId());
        if (AgentWithdrawOrderStatusEnum.SUCCESS.getCode().equals(objVo.getSearch().getTransactionStatus())) {
            objVo.getResult().setCheckStatus(CheckStatusEnum.SUCCESS.getCode());
            objVo.getResult().setTransactionStatus(AgentWithdrawOrderStatusEnum.SUCCESS.getCode());
        }
        if (AgentWithdrawOrderStatusEnum.FAIL.getCode().equals(objVo.getSearch().getTransactionStatus())) {
            objVo.getResult().setCheckStatus(CheckStatusEnum.FAILURE.getCode());
            objVo.getResult().setTransactionStatus(AgentWithdrawOrderStatusEnum.FAIL.getCode());
        }
        if (AgentWithdrawOrderStatusEnum.REFUSE.getCode().equals(objVo.getSearch().getTransactionStatus())) {
            objVo.getResult().setCheckStatus(CheckStatusEnum.REJECT.getCode());
            objVo.getResult().setTransactionStatus(AgentWithdrawOrderStatusEnum.REFUSE.getCode());
        }
        vo.getSearch().setId(objVo.getResult().getAgentId());
        vo = ServiceTool.getUserAgentService().get(vo);
        objVo = ServiceTool.getVAgentWithdrawOrderService().auditStatus(objVo, vo, remark);


        if (objVo.isSuccess() == true && AgentWithdrawOrderStatusEnum.SUCCESS.getCode().equals(objVo.getResult().getTransactionStatus())) {
            //发送固定站内信内容
            NoticeVo noticeVo = NoticeVo.autoNotify(AutoNoticeEvent.AGENT_WITHDRAWAL_AUDIT_SUCCESS, objVo.getResult().getAgentId());
            String bankName = LocaleTool.tranDict(DictEnum.BANKNAME, objVo.getResult().getAgentBank());
            noticeVo.addParams(
                    new Pair<String, String>("time", time),
                    new Pair<String, String>("plaseMoney", money),
                    new Pair<String, String>("order", objVo.getResult().getTransactionNo()),
                    new Pair<String, String>("bank", bankName),
                    new Pair<String, String>("tailNumber", objVo.getResult().getAgentBankcard().substring(objVo.getResult().getAgentBankcard().length() - 4, objVo.getResult().getAgentBankcard().length())));
            try{
                ServiceTool.noticeService().publish(noticeVo);
            }catch (Exception ex){
                LogFactory.getLog(this.getClass()).error(ex,"发布消息不成功");
            }
        }
        if (objVo.isSuccess() == true && AgentWithdrawOrderStatusEnum.FAIL.getCode().equals(objVo.getResult().getTransactionStatus())) {
            //发送站内信模板内容
            NoticeVo noticeVo = NoticeVo.manualNotify(objVo.getGroupCode(), null, objVo.getResult().getAgentId());
            noticeVo.addParams(new Pair(NoticeParamEnum.ORDER_AMOUNT.getCode(), money), new Pair(NoticeParamEnum.ORDER_LAUNCH_TIME.getCode(), time), new Pair(NoticeParamEnum.ORDER_NUM.getCode(), objVo.getResult().getTransactionNo()),
                    new Pair(NoticeParamEnum.CUSTOMER.getCode(), customer), new Pair(NoticeParamEnum.USER.getCode(), username));
            try{
                ServiceTool.noticeService().publish(noticeVo);
            }catch (Exception ex){
                LogFactory.getLog(this.getClass()).error(ex,"发布消息不成功");
            }
        }
        if (objVo.isSuccess() == true && AgentWithdrawOrderStatusEnum.REFUSE.getCode().equals(objVo.getResult().getTransactionStatus())) {
            //发送站内信模板内容
            NoticeVo noticeVo = NoticeVo.manualNotify(objVo.getGroupCode(), null, objVo.getResult().getAgentId());
            noticeVo.addParams(new Pair(NoticeParamEnum.ORDER_AMOUNT.getCode(), money), new Pair(NoticeParamEnum.ORDER_LAUNCH_TIME.getCode(), time), new Pair(NoticeParamEnum.ORDER_NUM.getCode(), objVo.getResult().getTransactionNo()),
                    new Pair(NoticeParamEnum.CUSTOMER.getCode(), customer), new Pair(NoticeParamEnum.USER.getCode(), username));
            try{
                ServiceTool.noticeService().publish(noticeVo);
            }catch (Exception ex){
                LogFactory.getLog(this.getClass()).error(ex,"发布消息不成功");
            }
        }
        HashMap map = new HashMap(2,1f);
        //map.put("msg", StringTool.isNotBlank(objVo.getOkMsg()) ? objVo.getOkMsg() : objVo.getErrMsg());
        map.put("state", Boolean.valueOf(objVo.isSuccess()));



        //推送消息给前端
        MessageVo message = new MessageVo();
        message.setSubscribeType(CometSubscribeType.MCENTER_RECHARGE_CHECK_REMINDER.getCode());
        message.setSendToUser(true);
        message.setCcenterId(SessionManager.getSiteParentId());
        message.setSiteId(SessionManager.getSiteId());
        message.setMasterId(SessionManager.getSiteUserId());
        SysResourceListVo sysResourceListVo = new SysResourceListVo();
        sysResourceListVo.getSearch().setUrl("fund/vAgentWithdrawOrder/agentList.html");
        List<Integer> userIdByUrl = ServiceTool.playerRechargeService().findUserIdByUrl(sysResourceListVo);
        userIdByUrl.add(Const.MASTER_BUILT_IN_ID);
        //自已会刷新，不发给自己
        if(userIdByUrl.contains(SessionManager.getUserId())){
            userIdByUrl.remove(SessionManager.getUserId());
        }
        message.addUserIds(userIdByUrl);
        message.setMsgBody("agent_withdraw");
        ServiceTool.messageService().sendToMcenterMsg(message);
        return map;
    }

    private Remark buildRemarkData(AgentWithdrawOrderVo objVo, Remark remark) {
        remark.setModel(RemarkEnum.FUND_WITHDRAW.getModel());
        remark.setRemarkType(RemarkEnum.FUND_WITHDRAW.getType());
        remark.setEntityId(objVo.getResult().getId());
        remark.setEntityUserId(objVo.getResult().getAgentId());
        remark.setRemarkTime(SessionManager.getDate().getNow());
        remark.setOperatorId(SessionManager.getUserId());
        remark.setOperator(SessionManager.getUserName());
        return remark;
    }

    @RequestMapping("/saveAuditRemark")
    @ResponseBody
    public Map saveAuditRemark(AgentWithdrawOrderVo objVo,Remark remark){
        Map map = new HashMap();
        try{
            remark = buildRemarkData(objVo,remark);
            remark = setRemarkTitle(objVo, remark);
            objVo.setRemark(remark);
            objVo = ServiceTool.getAgentWithdrawOrderService().updateWithdrawRemark(objVo);
            map.put("state",objVo.isSuccess());
        }catch (Exception ex){
            map.put("state","false");
        }
        return map;
    }

    private Remark setRemarkTitle(AgentWithdrawOrderVo objVo, Remark remark) {
        if(objVo.getResult().getId()!=null){
            VAgentWithdrawOrderVo orderVo = new VAgentWithdrawOrderVo();
            orderVo.getSearch().setId(objVo.getResult().getId());
            orderVo = ServiceTool.getVAgentWithdrawOrderService().get(orderVo);
			if(orderVo.getResult()!=null){
				String title = "{0}手动修改了代理[{1}]的取款订单备注";
				title = MessageFormat.format(title, SessionManager.getUser().getUsername(),orderVo.getResult().getUsername());
				remark.setRemarkTitle(title);
			}

		}
        return remark;
    }

    /**
     * 提现记录-拒绝申请原因
     *
     * @param objVo
     * @param model
     * @return
     */
    @RequestMapping("/putConfirmRefuses")
    public String putConfirmRefuses(VAgentWithdrawOrderVo objVo, Model model) {
        objVo = ServiceTool.getVAgentWithdrawOrderService().get(objVo);

        //查询拒绝原因模板
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.REFUSE_AGENT_WITHDRAWAL);
        List<NoticeLocaleTmpl> failReasons = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);

        model.addAttribute("failReasons", failReasons);
        model.addAttribute("command", objVo);
        return WITHDRAW_PUT_CHECK_REFUSES_URI;
    }

    /**
     * 提现记录-选择审核失败原因
     *
     * @param objVo
     * @param model
     * @return
     */
    @RequestMapping("/putCheckFailure")
    public String putCheckFailure(VAgentWithdrawOrderVo objVo, Remark remark, Model model) {
        objVo = ServiceTool.getVAgentWithdrawOrderService().get(objVo);

        //查询失败原因模板
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.AGENT_WITHDRAWAL_AUDIT_FAIL);
        List<NoticeLocaleTmpl> failReasons = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);

        model.addAttribute("failReasons", failReasons);
        model.addAttribute("command", objVo);
        model.addAttribute("remark", remark);
        return WITHDRAW_PUT_CHECK_FAILURE_URI;
    }

    @RequestMapping("/hasReason")
    @ResponseBody
    private Map hasReason(AgentWithdrawOrderVo objVo) {
        //查询失败原因模板
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.AGENT_WITHDRAWAL_AUDIT_FAIL);
        List<NoticeLocaleTmpl> failReasons = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);
        boolean bool = false;
        if (failReasons!=null&&failReasons.size()>0) {
            bool = true;
        }
        HashMap map = new HashMap(1,1f);
        map.put("state", bool);
        return map;
    }

    @RequestMapping("/hasRefuseReason")
    @ResponseBody
    private Map hasRefuseReason(AgentWithdrawOrderVo objVo) {
        //查询失败原因模板
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.REFUSE_AGENT_WITHDRAWAL);
        List<NoticeLocaleTmpl> failReasons = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);
        boolean bool = false;
        if (failReasons!=null&&failReasons.size()>0) {
            bool = true;
        }
        HashMap map = new HashMap(1,1f);
        map.put("state", bool);
        return map;
    }

}