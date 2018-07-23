package so.wwb.gamebox.mcenter.content.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import org.apache.commons.collections.Predicate;
import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.collections.MapTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.enums.YesNot;
import org.soul.commons.exception.SystemException;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.security.CryptoTool;
import org.soul.commons.support._Module;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.listop.ListOpTool;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.cache.Cache;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.content.IVPayAccountService;
import so.wwb.gamebox.mcenter.content.form.PayAccountDepositForm;
import so.wwb.gamebox.mcenter.content.form.VPayAccountForm;
import so.wwb.gamebox.mcenter.content.form.VPayAccountHideSettingForm;
import so.wwb.gamebox.mcenter.content.form.VPayAccountSearchForm;
import so.wwb.gamebox.mcenter.enmus.ListOpEnum;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.*;
import so.wwb.gamebox.model.common.Const;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.company.enums.BankCodeEnum;
import so.wwb.gamebox.model.company.site.po.SiteI18n;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.company.site.vo.SiteCustomerServiceListVo;
import so.wwb.gamebox.model.company.site.vo.SiteI18nListVo;
import so.wwb.gamebox.model.company.site.vo.SiteI18nVo;
import so.wwb.gamebox.model.listop.FilterRow;
import so.wwb.gamebox.model.listop.FilterSelectConstant;
import so.wwb.gamebox.model.listop.TabTypeEnum;
import so.wwb.gamebox.model.master.content.enums.PayAccountStatusEnum;
import so.wwb.gamebox.model.master.content.po.VPayAccount;
import so.wwb.gamebox.model.master.content.po.VPayAccountCashOrder;
import so.wwb.gamebox.model.master.content.vo.PayAccountCurrencyListVo;
import so.wwb.gamebox.model.master.content.vo.PayAccountListVo;
import so.wwb.gamebox.model.master.content.vo.VPayAccountListVo;
import so.wwb.gamebox.model.master.content.vo.VPayAccountVo;
import so.wwb.gamebox.model.master.enums.PayAccountAccountType;
import so.wwb.gamebox.model.master.enums.PayAccountType;
import so.wwb.gamebox.model.master.enums.SiteLangStatusEnum;
import so.wwb.gamebox.model.master.player.po.PayRank;
import so.wwb.gamebox.model.master.player.po.PlayerRank;
import so.wwb.gamebox.model.master.player.vo.PayRankListVo;
import so.wwb.gamebox.model.master.player.vo.PlayerRankVo;
import so.wwb.gamebox.web.cache.CachePage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.Serializable;
import java.util.*;


/**
 * 收款账户控制器
 *
 * @author tom
 * @time 2015-7-29 10:39:22
 */
@Controller
//region your codes 1
@RequestMapping("/vPayAccount")
public class VPayAccountController extends BaseCrudController<IVPayAccountService, VPayAccountListVo, VPayAccountVo, VPayAccountSearchForm, VPayAccountForm, VPayAccount, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/payaccount/";
        //endregion your codes 2
    }

    //region your codes 3
    private static final String HIDE_SETTING = "/content/payaccount/HideSetting";

    @RequestMapping("/companyList")
    public String companyList(VPayAccountListVo listVo, @FormModel("search") @Valid VPayAccountSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        listVo.getSearch().setType("1");
        return super.list(listVo, form, result, model, request, response);
    }

    @RequestMapping("/onLineList")
    public String onLineList(VPayAccountListVo listVo, @FormModel("search") @Valid VPayAccountSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        listVo.getSearch().setType("2");
        return super.list(listVo, form, result, model, request, response);
    }

    /**
     * 收款账户查询
     *
     * @param listVo
     * @param form
     * @param result
     * @param model
     * @return
     */
    @Override
    protected VPayAccountListVo doList(VPayAccountListVo listVo, VPayAccountSearchForm form, BindingResult result, Model model) {
        PlayerRankVo vo = new PlayerRankVo();
        vo.getSearch().setStatus(RankStatusEnum.NORMAL.getCode());
        List<PlayerRank> playerRanks = ServiceSiteTool.playerRankService().queryUsableList(vo);
        listVo.setPlayerRanks(playerRanks);
        Map<String, Serializable> status = DictTool.get(DictEnum.PAY_ACCOUNT_STATUS);
        status.remove(PayAccountStatusEnum.DELETED.getCode());
        // Map<String, Bank> filterDeposit = Cache.getBank();
        model.addAttribute("statusMap", status);
        //model.addAttribute("filterDeposit", filterDeposit.values());
        return this.getService().search(listVo);
    }

    @RequestMapping("/searchPayRankList")
    @ResponseBody
    protected String searchPayRankList(VPayAccountListVo listVo) {
        return JsonTool.toJson(getService().searchPayRankList(listVo));
    }

    /**
     * 金流顺序的筛选
     *
     * @param listVo
     * @param model
     * @return
     */
    @RequestMapping("/filters")
    protected String payAccountFilter(VPayAccountListVo listVo, Model model) {
        Map<String, VPayAccount> listOp = ListOpTool.getFilter(ListOpEnum.VPayAccountListVo);
        if (listOp != null && listOp.size() > 0) {
            model.addAttribute("filters", listOp.values());
        }
        List<Pair> masterFilter = getService().searchMstFilter(new VPayAccountVo());
        String entityClassName = VPayAccount.class.getSimpleName();
        List<FilterRow> filterRowList = new ArrayList<>();
        filterRowList.add(new FilterRow(PayRank.PROP_PLAYER_RANK_ID, LocaleTool.tranView("column", entityClassName + "." + PayRank.PROP_PLAYER_RANK_ID),
                FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, masterFilter));
        filterRowList.add(new FilterRow(VPayAccount.PROP_DISABLE_AMOUNT, LocaleTool.tranView("column", entityClassName + "." + VPayAccount.PROP_DISABLE_AMOUNT),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        filterRowList.add(new FilterRow(VPayAccount.PROP_RECHARGE_NUM, LocaleTool.tranView("column", entityClassName + "." + VPayAccount.PROP_RECHARGE_NUM),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        filterRowList.add(new FilterRow(VPayAccount.PROP_RECHARGE_AMOUNT, LocaleTool.tranView("column", entityClassName + "." + VPayAccount.PROP_RECHARGE_AMOUNT),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        List<Pair> status = new ArrayList<>();
//        status.add(new Pair(PayAccountEnum.STOP.getCode(), PayAccountEnum.STOP.getDesc()));
//        status.add(new Pair(PayAccountEnum.NORMAL.getCode(), PayAccountEnum.NORMAL.getDesc()));
//        status.add(new Pair(PayAccountEnum.FROZEN.getCode(), PayAccountEnum.FROZEN.getDesc()));
//        filterRowList.add(new FilterRow(VPayAccount.PROP_STATUS, LocaleTool.tranView("column", entityClassName + "." + VPayAccount.PROP_STATUS),
//                FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, status));
//        List<Pair> rechargeType = new ArrayList<>();
//        rechargeType.add(new Pair(PayAccountEnum.AUTOMATIC.getCode(), PayAccountEnum.AUTOMATIC.getDesc()));
//        rechargeType.add(new Pair(PayAccountEnum.ARTIFICIAL.getCode(), PayAccountEnum.ARTIFICIAL.getDesc()));
        /*filterRowList.add(new FilterRow(VPayAccount.PROP_AUTOMATIC_TYPE, LocaleTool.tranView("column", entityClassName + "." + VPayAccount.PROP_AUTOMATIC_TYPE),
                FilterSelectConstant.onlyEqual, TabTypeEnum.SELECT, rechargeType));*/
        filterRowList.add(new FilterRow(VPayAccount.PROP_LAST_RECHARGE, LocaleTool.tranView("column", entityClassName + "." + VPayAccount.PROP_LAST_RECHARGE),
                FilterSelectConstant.equalRange, TabTypeEnum.DATE, null));

        model.addAttribute("filterList", filterRowList);
        model.addAttribute("keyClassName", ListOpEnum.VPayAccountListVo.getClassName());
        model.addAttribute("jsonFilterList", JsonTool.toJson(filterRowList));
        model.addAttribute("goFilterUrl", "/content/payaccount/index.html");

        return "/share/ListFilters";
    }

    @RequestMapping("/detail")
    public String detail(VPayAccountVo vo, Model model) {
        vo = ServiceSiteTool.vPayAccountService().detailPayAccount(vo);
        vo = getPayCurrencyAndRank(vo);
        vo = buildChannelJson(vo);
        vo.setValidateRule(JsRuleCreator.create(PayAccountDepositForm.class));
        model.addAttribute("command", vo);
        return getViewBasePath() + "/View";
    }

    private VPayAccountVo buildChannelJson(VPayAccountVo objectVo) {
        String jsonString = objectVo.getResult().getChannelJson();
        // 解决比特币和其他支付账户channelJson格式不一致问题
        if (StringTool.isNotBlank(jsonString) && !objectVo.getResult().getChannelJson().startsWith("[")) {
            return objectVo;
        } else {
            List<Map<String, String>> channelJson = JsonTool.fromJson(jsonString, List.class);
            if (channelJson != null) {
                for (Map<String, String> map : channelJson) {
                    if (map.get("column").equals("key")) {
                        String key = map.get("value");
                        CryptoTool.aesEncrypt(key);
                        map.put("value", CryptoTool.aesDecrypt(key));
                    }
                }
                objectVo.setChannelJson(channelJson);
            }
            return objectVo;
        }
    }

    /**
     * 编辑需要加载货币和已设置层级
     */
    private VPayAccountVo getPayCurrencyAndRank(VPayAccountVo objectVo) {
        PayAccountCurrencyListVo payAccountCurrencyListVo = new PayAccountCurrencyListVo();
        Integer payAccountId = objectVo.getResult().getId();
        if (payAccountId != null) {
            payAccountCurrencyListVo.getSearch().setPayAccountId(payAccountId);
            payAccountCurrencyListVo = ServiceSiteTool.payAccountCurrencyService().search(payAccountCurrencyListVo);
            objectVo.setPayAccountCurrencyList(payAccountCurrencyListVo.getResult());
        }
        return objectVo;
    }

    /**
     * 收款账户：金流顺序查询
     */
    @RequestMapping("/cashFlowOrder")
    public String cashFlowOrder(String id, Model model) {
        // 查询金流玩家层级player_rank 和 账号关联表pay_rank 和 账号信息 pay_account
        VPayAccountListVo vo = new VPayAccountListVo();
        if (StringTool.isNotEmpty(id)) {
            vo.getSearch().setId(Integer.parseInt(id));
        }
        vo = ServiceSiteTool.vPayAccountService().searchCashFlowOrder(vo);
        //对线上支付金流顺序进行分组（线上支付、扫码支付）
        groupCahFlowOrder(vo);
        model.addAttribute("command", vo);
        model.addAttribute("id", id);
        return getViewBasePath() + "cashFlowOrder";
    }

    private void groupCahFlowOrder(VPayAccountListVo vo) {
        List<VPayAccountCashOrder> cashOrders = vo.getPayAccountCashOrderList();
        List<VPayAccountCashOrder> scanCashOrders = new ArrayList<>();
        Iterator<VPayAccountCashOrder> iter = cashOrders.iterator();
        while (iter.hasNext()) {
            VPayAccountCashOrder cashOrder = iter.next();
            if (PayAccountAccountType.WECHAT.getCode().equals(cashOrder.getAccountType()) || PayAccountAccountType.ALIPAY.getCode().equals(cashOrder.getAccountType())) {
                scanCashOrders.add(cashOrder);
                iter.remove();
            }
        }
        vo.setScanCashOrderList(scanCashOrders);

    }

    /**
     * 金流顺序：设置层级的轮流入款和收款账户顺序
     */
    @RequestMapping(value = "/saveCashFlowOrder", method = RequestMethod.POST, headers = {"Content-type=application/json"})
    @ResponseBody
    public Boolean settingCashFlowOrder(@RequestBody VPayAccountVo vPayAccountVo, Model model) {
        return ServiceSiteTool.vPayAccountService().saveCashFlowOrder(vPayAccountVo);
    }

    @RequestMapping(value = "/hideSetting", method = RequestMethod.GET)
    public String hideSetting(VPayAccountListVo vPayAccountListVo, Model model) {
        // 语言
        if (MapTool.isNotEmpty(Cache.getSiteLanguage())) {
            Collection<SiteLanguage> siteLanguageCollection = Cache.getSiteLanguage().values();
            siteLanguageCollection = CollectionTool.filter(siteLanguageCollection, new Predicate() {
                @Override
                public boolean evaluate(Object o) {
                    return SiteLangStatusEnum.USING.getCode().equals(((SiteLanguage) o).getStatus());
                }
            });
            vPayAccountListVo.setSiteLanguages((List<SiteLanguage>) siteLanguageCollection);
        }
        // 文案
        if (MapTool.isNotEmpty(Cache.getSiteI18n(SiteI18nEnum.MASTER_CONTENT_HIDE_ACCOUNT_CONTENT))) {
            vPayAccountListVo.setSiteI18ns(new ArrayList<SiteI18n>());
            CollectionTool.addAll(vPayAccountListVo.getSiteI18ns(), Cache.getSiteI18n(SiteI18nEnum.MASTER_CONTENT_HIDE_ACCOUNT_CONTENT).values().iterator());
            //vPayAccountListVo.setSiteI18ns((List<SiteI18n>) Cache.getSiteI18n(SiteI18nEnum.MASTER_CONTENT_HIDE_ACCOUNT_CONTENT).values());
        }
        // 客服
        SiteCustomerServiceListVo customerServiceListVo = new SiteCustomerServiceListVo();
        customerServiceListVo.getSearch().setSiteId(SessionManager.getSiteId());
        customerServiceListVo.setPaging(null);
        customerServiceListVo = ServiceTool.siteCustomerServiceService().search(customerServiceListVo);
        //ServiceTool.siteCustomerServiceService().searchProperties(customerServiceListVo);
        vPayAccountListVo.setHandleCustomerService(ParamTool.getSysParam(SiteParamEnum.CONTENT_PAY_ACCOUNT_HANDLE_CUSTOMER_SERVICE));
        vPayAccountListVo.setPlayerAccountHide(ParamTool.getSysParam(SiteParamEnum.CONTENT_PAY_ACCOUNT_HIDE));
        vPayAccountListVo.setValidateRule(JsRuleCreator.create(VPayAccountHideSettingForm.class, "result"));
        vPayAccountListVo.setCustomerListVo(customerServiceListVo);
        model.addAttribute("vPayAccountListVo", vPayAccountListVo);
        Collection<SysParam> sysParams = ParamTool.getSysParams(SiteParamEnum.PAY_ACCOUNT_HIDE_ONLINE_BANKING);
        model.addAttribute("sysParams", sysParams);
        return HIDE_SETTING;
    }

    @RequestMapping("/resetHide")
    @ResponseBody
    public Map resetHide(VPayAccountListVo vPayAccountListVo, @FormModel("result") @Valid VPayAccountHideSettingForm form, BindingResult result, SysParamVo sysParamVo) {
        if (result.hasErrors()) {
            Map map = new HashMap(2, 1f);
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
            map.put("state", false);
            return map;
        }
//        vPayAccountListVo = getService().resetting(vPayAccountListVo);

        SiteI18nVo siteI18nVo = new SiteI18nVo();
        siteI18nVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(SiteI18n.PROP_MODULE, Operator.EQ,
                        SiteI18nEnum.MASTER_CONTENT_HIDE_ACCOUNT_CONTENT.getModule().getCode()),
                new Criterion(SiteI18n.PROP_TYPE, Operator.EQ,
                        SiteI18nEnum.MASTER_CONTENT_HIDE_ACCOUNT_CONTENT.getType()),
                new Criterion(SiteI18n.PROP_KEY, Operator.EQ,
                        SiteI18nEnum.MASTER_CONTENT_HIDE_ACCOUNT_CONTENT.getCode())
        });
        ServiceTool.siteI18nService().batchDeleteCriteria(siteI18nVo);
        SiteI18nListVo listVo = new SiteI18nListVo();
        listVo.setSiteI18ns(vPayAccountListVo.getSiteI18ns());
        listVo.setSiteId(SessionManager.getSiteId());
        ServiceTool.siteI18nService().hideInsertI18n(listVo);
        Cache.refreshSiteI18n(SiteI18nEnum.MASTER_CONTENT_HIDE_ACCOUNT_CONTENT);
        CachePage.refreshCurrentSitePageCache();
        //保存隐藏开关
        sysParamVo.setResult(vPayAccountListVo.getPlayerAccountHide());
        sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE);
        ServiceTool.getSysParamService().updateOnly(sysParamVo);
        ParamTool.refresh(SiteParamEnum.CONTENT_PAY_ACCOUNT_HIDE);

        // 公司入款
        sysParamVo.setResult(vPayAccountListVo.getOnline_banking());
        ServiceTool.getSysParamService().updateOnly(sysParamVo);
        ParamTool.refresh(SiteParamEnum.PAY_ACCOUNT_HIDE_ONLINE_BANKING);
        // 电子支付
        sysParamVo.setResult(vPayAccountListVo.getE_payment());
        ServiceTool.getSysParamService().updateOnly(sysParamVo);
        ParamTool.refresh(SiteParamEnum.PAY_ACCOUNT_HIDE_E_PAYMENT);
        // 柜员机/柜台存款
        sysParamVo.setResult(vPayAccountListVo.getAtm_counter());
        ServiceTool.getSysParamService().updateOnly(sysParamVo);
        ParamTool.refresh(SiteParamEnum.PAY_ACCOUNT_HIDE_ATM_COUNTER);

        //保存客服
        sysParamVo.setResult(vPayAccountListVo.getHandleCustomerService());
        ServiceTool.getSysParamService().updateOnly(sysParamVo);
        ParamTool.refresh(SiteParamEnum.CONTENT_PAY_ACCOUNT_HANDLE_CUSTOMER_SERVICE);

        return getVoMessage(vPayAccountListVo);
    }

    @RequestMapping("/delpayrank")
    @ResponseBody
    public Map delPayRank(PayRankListVo payRankListVo) {
        if (payRankListVo.getSearch().getId() == null || StringTool.isBlank(payRankListVo.getSearch().getId().toString())) {
            throw new SystemException("层级id参数必须指定！");
        }
        payRankListVo = getService().delPayRank(payRankListVo);
        if (payRankListVo.isSuccess()) {
            payRankListVo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_SUCCESS));
        } else if (!payRankListVo.isSuccess()) {
            payRankListVo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_FAILED));
        }

        return this.getVoMessage(payRankListVo);
    }

    @RequestMapping("/askRemeberInfo")
    @ResponseBody
    public Map askRemeberInfo(HttpServletRequest request) {
        Map<String, String> result = new HashMap();
        String status = (String) SessionManager.getAttribute(Const.sessionRemindKey);
        if (StringTool.isEmpty(status)) {
            result.put("code", "pop");
        } else {
            result.put("code", "nopop");
        }
        return result;
    }

    /**
     * 弹出是否记住本次登入期间不再提示Dialog
     *
     * @return
     */
    @RequestMapping("/remDialog")
    public String remDialog() {
        return getViewBasePath() + "/RemDialog";
    }

    @RequestMapping("/remember")
    @ResponseBody
    public void remember(HttpServletRequest request) {
        SessionManager.setAttribute(Const.sessionRemindKey, YesNot.YES.getCode());
    }

    /**
     * 公司入款金流顺序
     *
     * @param model
     * @return
     */
    @RequestMapping("/companySort")
    public String companySort(Model model) {
        List<PlayerRank> ranks = ServiceSiteTool.playerRankService().searchCompanyAccountRank(new PlayerRankVo());
        model.addAttribute("ranks", ranks);
        if (CollectionTool.isNotEmpty(ranks)) {
            companyAccountByRank(model, ranks.get(0).getId());
        }
        return getViewBasePath() + "/company/Sort";
    }

    /**
     * 根据层级获取收款账户
     *
     * @param model
     * @param rankId
     * @return
     */
    @RequestMapping("/companyAccountByRank")
    public String companyAccountByRank(Model model, Integer rankId) {
        PayAccountListVo payAccountListVo = new PayAccountListVo();
        payAccountListVo.setRankId(rankId);
        payAccountListVo.getSearch().setType(PayAccountType.COMPANY_ACCOUNT.getCode());
        List<VPayAccountCashOrder> payAccounts = ServiceSiteTool.payAccountService().queryAccountByRank(payAccountListVo);
        List<VPayAccountCashOrder> bankAccounts = new ArrayList<>();
        List<VPayAccountCashOrder> electronicAccounts = new ArrayList<>();
        List<VPayAccountCashOrder> bitAccounts = new ArrayList<>();
        String bank = PayAccountAccountType.BANKACCOUNT.getCode();
        String bitcoin = BankCodeEnum.BITCOIN.getCode();
        for (VPayAccountCashOrder cashOrder : payAccounts) {
            if (bank.equals(cashOrder.getAccountType())) {
                bankAccounts.add(cashOrder);
            } else if (bitcoin.equals(cashOrder.getBankCode())) {
                bitAccounts.add(cashOrder);
            } else {
                electronicAccounts.add(cashOrder);
            }
        }
        model.addAttribute("bankAccounts", bankAccounts);
        model.addAttribute("thirdAccounts", electronicAccounts);
        model.addAttribute("bitAccounts", bitAccounts);
        model.addAttribute("rankId", rankId);
        //查询层级获取是否展示多个账号
        PlayerRankVo rankVo = new PlayerRankVo();
        rankVo.getSearch().setId(rankId);
        rankVo = ServiceSiteTool.playerRankService().get(rankVo);
        model.addAttribute("rank", rankVo.getResult());
        return getViewBasePath() + "/company/SortPartial";
    }

    /**
     * 保存公司入款收款账号金流顺序
     *
     * @param payRankJson
     * @return
     */
    @RequestMapping("/saveCompanySort")
    @ResponseBody
    public boolean saveCompanySort(String payRankJson) {
        if (StringTool.isBlank(payRankJson)) {
            return false;
        }
        PayRankListVo payRankListVo = new PayRankListVo();
        try {
            List<PayRank> list = JsonTool.fromJson(payRankJson, new TypeReference<ArrayList<PayRank>>() {
            });
            payRankListVo.setResult(list);
        } catch (Exception e) {
            return false;
        }
        if (CollectionTool.isEmpty(payRankListVo.getResult())) {
            return true;
        }
        Date date = new Date();
        for (PayRank payRank : payRankListVo.getResult()) {
            payRank.setCreateTime(date);
            payRank.setCreateUser(SessionManager.getUserId());
        }
        int count = ServiceSiteTool.payRankService().batchSaveOrUpdatePayRank(payRankListVo);
        if (count > 0) {
            return true;
        }
        return false;
    }

    /**
     * 变更公司入款是否展示多个账户
     *
     * @return
     */
    @RequestMapping("changeOpenAccounts")
    @ResponseBody
    public boolean saveOpenAccounts(Integer rankId, Boolean state) {
        if (rankId == null || state == null) {
            return false;
        }
        PlayerRankVo playerRankVo = new PlayerRankVo();
        PlayerRank playerRank = new PlayerRank();
        playerRank.setId(rankId);
        playerRank.setDisplayCompanyAccount(state);
        playerRankVo.setResult(playerRank);
        playerRankVo.setProperties(PlayerRank.PROP_DISPLAY_COMPANY_ACCOUNT);
        playerRankVo = ServiceSiteTool.playerRankService().updateOnly(playerRankVo);
        return playerRankVo.isSuccess();
    }
    //endregion your codes 3

}
