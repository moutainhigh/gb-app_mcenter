package so.wwb.gamebox.mcenter.content.controller;

import org.soul.commons.collections.CollectionQueryTool;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.collections.MapTool;
import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.exception.SystemException;
import org.soul.commons.lang.ArrayTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.math.NumberTool;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.query.sort.Direction;
import org.soul.commons.security.CryptoTool;
import org.soul.commons.support._Module;
import org.soul.iservice.pay.IOnlinePayService;
import org.soul.model.log.audit.enums.OpType;
import org.soul.model.log.audit.vo.BaseLog;
import org.soul.model.log.audit.vo.LogVo;
import org.soul.model.pay.vo.OnlinePayVo;
import org.soul.model.sys.po.SysAuditLog;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.listop.ListOpTool;
import org.soul.web.session.SessionManagerBase;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import so.wwb.gamebox.common.cache.Cache;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.content.IPayAccountService;
import so.wwb.gamebox.mcenter.content.form.*;
import so.wwb.gamebox.mcenter.enmus.ListOpEnum;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.*;
import so.wwb.gamebox.model.bitcoin.enums.BitCoinChannelEnum;
import so.wwb.gamebox.model.bitcoin.po.BitCoinChannel;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.common.CryptoKey;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.company.enums.BankEnum;
import so.wwb.gamebox.model.company.enums.BankPayTypeEnum;
import so.wwb.gamebox.model.company.enums.ResolveStatusEnum;
import so.wwb.gamebox.model.company.po.Bank;
import so.wwb.gamebox.model.company.po.BankSupportCurrency;
import so.wwb.gamebox.model.company.site.po.SiteCurrency;
import so.wwb.gamebox.model.company.site.vo.SiteCurrencyListVo;
import so.wwb.gamebox.model.company.sys.po.SysDomain;
import so.wwb.gamebox.model.company.sys.vo.SysDomainListVo;
import so.wwb.gamebox.model.company.vo.BankExtendVo;
import so.wwb.gamebox.model.company.vo.BankListVo;
import so.wwb.gamebox.model.company.vo.BankSupportCurrencyListVo;
import so.wwb.gamebox.model.company.vo.BankVo;
import so.wwb.gamebox.model.master.content.enums.PayAccountStatusEnum;
import so.wwb.gamebox.model.master.content.po.PayAccount;
import so.wwb.gamebox.model.master.content.po.VPayAccount;
import so.wwb.gamebox.model.master.content.vo.*;
import so.wwb.gamebox.model.master.digiccy.po.DigiccyAccountInfo;
import so.wwb.gamebox.model.master.enums.PayAccountAccountType;
import so.wwb.gamebox.model.master.enums.PayAccountType;
import so.wwb.gamebox.model.master.enums.UserTaskEnum;
import so.wwb.gamebox.model.master.fee.po.FeeAccountRelation;
import so.wwb.gamebox.model.master.fee.vo.FeeAccountRelationVo;
import so.wwb.gamebox.model.master.fee.vo.RechargeFeeSchemaListVo;
import so.wwb.gamebox.model.master.fund.enums.RechargeTypeParentEnum;
import so.wwb.gamebox.model.master.fund.so.VPlayerRechargeSo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerRechargeListVo;
import so.wwb.gamebox.model.master.player.po.PlayerRank;
import so.wwb.gamebox.model.master.player.po.VPlayerTag;
import so.wwb.gamebox.model.master.player.vo.*;
import so.wwb.gamebox.model.master.setting.enums.SiteCurrencyEnum;
import so.wwb.gamebox.model.master.tasknotify.vo.UserTaskReminderVo;
import so.wwb.gamebox.model.report.vo.AddLogVo;
import so.wwb.gamebox.web.BussAuditLogTool;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.*;

import static org.soul.commons.lang.string.StringTool.isBlank;
import static org.soul.commons.lang.string.StringTool.replaceHtml;

/**
 * 收款账户表控制器
 * <p/>
 * Created by loong using soul-code-generator on 2015-7-27 15:22:07
 */
@Controller
//region your codes 1
@RequestMapping("/payAccount")
public class PayAccountController extends BaseCrudController<IPayAccountService, PayAccountListVo, PayAccountVo, PayAccountSearchForm, PayAccountOnlineForm, PayAccount, Integer> {

    private static final Log LOG = LogFactory.getLog(PayAccountController.class);

    //预警设置
    private static final String WARNING_SETTINGS_URL = "/content/payaccount/WarningSettings";
    private static final String PAY_ACCOUNT_WARNING_SETTINGS_URL = "/content/payaccount/WarningSettingsOfPayAccount";
    private static final String PAY_ACCOUNT_WARNING_SETTINGS_UNUSUAL_URL = "/content/payaccount/WarningSettingsOfPayAccountUnusual";
    private static final String PAY_ACCOUNT_ADD = "/content/payaccount/Add";

//endregion your codes 1


    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/payaccount/";
        //endregion your codes 2
    }

    @Override
    protected String getCreateViewName() {
        return PAY_ACCOUNT_ADD;
    }

    //region your codes 3

    @RequestMapping("/filters")
    protected String payAccountFilter(VPayAccountListVo listVo, Model model) {
        Map<String, VPayAccount> listOp = ListOpTool.getFilter(ListOpEnum.VPayAccountListVo);
        if (listOp != null && listOp.size() > 0) {
            model.addAttribute("filters", listOp.values());
        }
        return "/share/ListFilters";
    }

    /**
     * 查日志
     *
     * @param model            Model
     * @param payWarningListVo PayWarningListVo
     * @param type             1：公司入款账户；2：线上支付账户
     * @return url
     */
    @RequestMapping({"/warningSettings/logs/{type}"})
    public String logsInAlarmSetting(Model model, PayWarningListVo payWarningListVo, @PathVariable String type) {
        if (PayAccountType.COMPANY_ACCOUNT.getCode().equals(type)) {
            payWarningListVo.getSearch().setAccountType(RechargeTypeParentEnum.COMPANY_DEPOSIT.getCode());
        } else {
            payWarningListVo.getSearch().setAccountType(RechargeTypeParentEnum.ONLINE_DEPOSIT.getCode());
        }
        payWarningListVo = ServiceSiteTool.payWarningService().search(payWarningListVo);
        model.addAttribute("command", payWarningListVo);
        return WARNING_SETTINGS_URL + "Partial";
    }

    /**
     * 保存预警设置
     *
     * @param vo PayAccountVo
     * @return Map
     */
    @RequestMapping({"/saveWarningSettings"})
    @ResponseBody
    public Map saveWarningSettings(PayAccountVo vo, @FormModel @Valid WarningSettingsForm form, BindingResult result) {
        if (result.hasErrors()) {
            vo.setSuccess(false);
            return getVoMessage(vo);
        }
        int count = batchSaveWarningSetting(vo);
        refreshParam();
        if (count <= 0) {
            vo.setSuccess(false);
        }
        return this.getVoMessage(vo);
    }

    /**
     * 刷新预警设置相关参数缓存
     */
    private void refreshParam() {
        ParamTool.refresh(SiteParamEnum.CONTENT_DEPOSIT_ACCOUNT_WARNING_INADEQUATE_COUNT);
        ParamTool.refresh(SiteParamEnum.CONTENT_DEPOSIT_ACCOUNT_WARNING_INADEQUATE_STATE);
        ParamTool.refresh(SiteParamEnum.CONTENT_PAY_ACCOUNT_WARNING_INADEQUATE_COUNT);
        ParamTool.refresh(SiteParamEnum.CONTENT_PAY_ACCOUNT_WARNING_INADEQUATE_STATE);
    }


    /**
     * 批量保存预警设置
     *
     * @param vo
     * @return
     */
    private int batchSaveWarningSetting(PayAccountVo vo) {
        //层级账号不足传回值为空，则默认为false
        SysParam inadequateState = vo.getInadequateState();
        if (isBlank(inadequateState.getParamValue())) {
            inadequateState.setParamValue(Boolean.FALSE.toString());
        }

        List<SysParam> sysParams = new ArrayList<>(2);
        sysParams.add(vo.getInadequateState());
        sysParams.add(vo.getInadequateCount());
        SysParamVo sysParamVo = new SysParamVo();
        sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE);
        sysParamVo.setEntities(sysParams);
        try {
            return ServiceTool.getSysParamService().batchUpdateOnly(sysParamVo);
        } catch (Exception e) {
            LOG.error(e);
            return 0;
        }

    }

    /**
     * 账户异常设置
     *
     * @param model Model
     * @return url
     */
    @RequestMapping({"/unusualSettings"})
    public String unusualSettings(Model model) {
        SysParam p11 = ParamTool.getSysParam(SiteParamEnum.CONTENT_PAY_ACCOUNT_WARNING_UNUSUAL_ERROR_NOTICE_VAL);
        SysParam p12 = ParamTool.getSysParam(SiteParamEnum.CONTENT_PAY_ACCOUNT_WARNING_UNUSUAL_NOINCOME_NOTICE_VAL);
        model.addAttribute("p11", p11);
        model.addAttribute("p12", p12);
        model.addAttribute("rule", JsRuleCreator.create(WarningOfUnusualForm.class));
        return PAY_ACCOUNT_WARNING_SETTINGS_UNUSUAL_URL;
    }

    /**
     * 账户异常设置--保存
     *
     * @param vo PayAccountVo
     * @return Map
     */
    @RequestMapping({"/saveWarningUnusualSettings"})
    @ResponseBody
    public Map saveWarningUnusualSettings(PayAccountVo vo, @FormModel() @Valid WarningOfUnusualForm form, BindingResult result) {
        Map<String, Object> map = MapTool.newHashMap();
        if (result.hasErrors()) {
            map.put("state", false);
            map.put("msg", LocaleTool.tranMessage(Module.COMPANY_SETTING, "myAccount.updatePassword.failed"));
            return map;
        }
        SysParam pv11 = vo.getPv()[11];
        if (pv11.getActive()) {
            pv11.setParamValue(form.getPv$$_v1()[0] + "," + form.getPv$$_v2()[0] + "," + form.getPv$$_v3()[0]);
        } else {
            pv11.setParamValue(null);
        }
        vo = this.getService().saveWarningSettingsWithState(vo);
        if (vo.isSuccess()) {
            ParamTool.refresh(SiteParamEnum.CONTENT_PAY_ACCOUNT_WARNING_UNUSUAL_NOINCOME_NOTICE_VAL);
        }
        return this.getVoMessage(vo);
    }

    /**
     * 删除收款账户
     */
    @RequestMapping({"/deleteAccount"})
    @ResponseBody
    public Map deleteAccount(Integer[] ids) {
        PayAccountVo vo = new PayAccountVo();
        if (ArrayTool.isEmpty(ids)) {
            vo.setSuccess(false);
            return this.getVoMessage(vo);
        }
        vo.setIds(Arrays.asList(ids));
        vo = this.getService().deleteAccount(vo);
        if (vo.isSuccess() && isBlank(vo.getOkMsg())) {
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_SUCCESS));
        } else if (!vo.isSuccess() && isBlank(vo.getErrMsg())) {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_FAILED));
        }
        return this.getVoMessage(vo);
    }

    /**
     * 收款账户设置层级
     */
    @RequestMapping({"/rankSettings"})
    @ResponseBody
    public Map rankSettings(Integer[] ids, Integer rankId) {
        PayAccountVo vo = new PayAccountVo();
        if (ArrayTool.isEmpty(ids)) {
            vo.setSuccess(false);
            return this.getVoMessage(vo);
        }
        vo.setIds(Arrays.asList(ids));
        vo.setRankId(rankId);
        vo.getSearch().setCreateTime(new Date());
        vo.getSearch().setCreateUser(SessionManagerBase.getUserId());
        vo = this.getService().rankSettings(vo);
        return this.getVoMessage(vo);
    }

    /**
     * 公司入款新增入款
     */
    @RequestMapping({"/companyCreate"})
    @Token(generate = true)
    protected String companyCreate(PayAccountVo objectVo, Model model) {
        objectVo = super.doCreate(objectVo, model);
        objectVo.setResult(new PayAccount());
        objectVo.getResult().setType(objectVo.getSearch().getType());
        objectVo.getSearch().setType(PayAccountType.COMPANY_ACCOUNT.getCode());
        objectVo = getPayAccountVo(objectVo);
        objectVo.setOpenAndSupportList(new ArrayList<SiteCurrency>());
        for (SiteCurrency siteCurrency : Cache.getSiteCurrency().values()) {
            objectVo.getOpenAndSupportList().add(siteCurrency);
        }
        model.addAttribute("bitChannel", BitCoinChannelEnum.values());
        objectVo.setValidateRule(JsRuleCreator.create(PayAccountCompanyForm.class, "result"));
        model.addAttribute("command", objectVo);
        return "/content/payaccount/company/Add";
    }

    @RequestMapping({"/companyEdit"})
    @Token(generate = true)
    public String companyEdit(PayAccountVo objectVo, Integer id, Model model) {
        if (id == null || isBlank(id.toString())) {
            throw new SystemException("加载实体时id参数必须指定！");
        }
        this.checkResult(objectVo);
        objectVo.getSearch().setId(id);
        objectVo = this.doEdit(objectVo, model);
        objectVo.getSearch().setType(PayAccountType.COMPANY_ACCOUNT.getCode());
        objectVo = getPayAccountVo(objectVo);
        objectVo.setValidateRule(JsRuleCreator.create(PayAccountCompanyForm.class, "result"));
        this.getPayCurrencyAndRank(objectVo);
        VPayAccountVo vPayAccountVo = new VPayAccountVo();
        vPayAccountVo.getSearch().setId(objectVo.getResult().getId());
        vPayAccountVo = ServiceSiteTool.vPayAccountService().get(vPayAccountVo);
        objectVo.getSearch().setRechargeNum(vPayAccountVo.getResult().getRechargeNum() == null ? 0 : vPayAccountVo.getResult().getRechargeNum());
        objectVo.getSearch().setRechargeAmount(vPayAccountVo.getResult().getRechargeAmount() == null ? 0 : vPayAccountVo.getResult().getRechargeAmount()
        );
        //公司入款
        if (PayAccountType.COMPANY_ACCOUNT.getCode().equals(objectVo.getResult().getType())) {
            objectVo.setOpenAndSupportList(this.openAndSupportCurrencies(objectVo.getResult().getBankCode()));
            if (StringTool.isNotBlank(objectVo.getResult().getChannelJson())) {
                BitCoinChannel bitCoinChannelVo = JsonTool.fromJson(objectVo.getResult().getChannelJson(), BitCoinChannel.class);
                objectVo.setBitCoinChannelVo(bitCoinChannelVo);
            }
        } else {
            objectVo.setOpenAndSupportList(this.openAndSupport(objectVo.getResult().getBankCode()));
        }
        model.addAttribute("bitChannel", BitCoinChannelEnum.values());
        model.addAttribute("command", objectVo);
        return "/content/payaccount/company/Add";
    }

    /**
     * 异步加载支付渠道
     */
    @RequestMapping("/loadPayType")
    @ResponseBody
    public PayAccountVo loadPayType(String payType) {
        PayAccountVo objectVo = new PayAccountVo();
        List<Bank> list = new ArrayList();
        List<Bank> onlineBank = getOnlineBank(payType);
        if (onlineBank != null && onlineBank.size() > 0) {
            Map<String, String> i18n = I18nTool.getDictMapByEnum(SessionManager.getLocale(), DictEnum.BANKNAME);
            for (Bank bank : onlineBank) {
                //bankName国际化处理
                String interlingua = i18n.get(bank.getBankName());
                if (StringTool.isNotEmpty(interlingua)) {
                    bank.setInterlinguaBankName(interlingua);
                } else {
                    bank.setInterlinguaBankName(bank.getBankShortName());
                }
                list.add(bank);
            }
        }
        objectVo.setBankList(list);
        return objectVo;
    }

    private List<Bank> getOnlineBank(String paytype) {
        BankListVo bankListVo = new BankListVo();
        bankListVo.getSearch().setType(BankEnum.TYPE_ONLINE.getCode());
        bankListVo.getSearch().setIsUse(true);
        bankListVo.setPaging(null);
        bankListVo.getSearch().setPayType(paytype);
        bankListVo.getQuery().addOrder(Bank.PROP_ORDER_NUM, Direction.ASC).addOrder(Bank.PROP_BANK_NAME, Direction.ASC);
        bankListVo = ServiceTool.bankService().queryBankByPayType(bankListVo);
        return bankListVo.getResult();
    }

    @RequestMapping({"/onLineCreate"})
    @Token(generate = true)
    public String onLineCreate(PayAccountVo objectVo, Model model, SysDomainListVo sysDomainListVo) {
        objectVo = this.doCreate(objectVo, model);
        objectVo.getSearch().setType(PayAccountType.ONLINE_ACCOUNT.getCode());
        objectVo = getPayAccountVo(objectVo);
//        objectVo.setBankList(getOnlineBank("0"));
        objectVo.setSysDomains(getSysDomainList(sysDomainListVo));

        model.addAttribute("command", objectVo);
        objectVo.setValidateRule(JsRuleCreator.create(PayAccountOnlineForm.class, "result"));
        model.addAttribute("bankPayTypes", BankPayTypeEnum.values());
        RechargeFeeSchemaListVo schemaListVo = new RechargeFeeSchemaListVo();
        schemaListVo = ServiceSiteTool.rechargeFeeSchemaService().searchList(schemaListVo);
        model.addAttribute("schemaListVo", schemaListVo);
        return "/content/payaccount/onLine/Add";
    }

    private List<SysDomain> getSysDomainList(SysDomainListVo sysDomainListVo) {
        //查询该站点的支付域名列表
        SysParam sysParam = ParamTool.getSysParam(BossParamEnum.CONTENT_DOMAIN_TYPE_ONLINEPAY);
        if (sysParam == null) {
            return null;
        }
        sysDomainListVo.getSearch().setSiteId(SessionManager.getSiteId());
        sysDomainListVo.getSearch().setPageUrl(sysParam.getParamValue());
        sysDomainListVo.getSearch().setType(null);
        sysDomainListVo.setPaging(null);
        sysDomainListVo.getSearch().setResolveStatus(ResolveStatusEnum.SUCCESS.getCode());
        sysDomainListVo = ServiceTool.sysDomainService().search(sysDomainListVo);
        return sysDomainListVo.getResult();

    }

    @RequestMapping({"/onLineEdit"})
    @Token(generate = true)
    public String onLineEdit(PayAccountVo objectVo, Integer id, Model model) {
        if (id == null || isBlank(id.toString())) {
            throw new SystemException("加载实体时id参数必须指定！");
        }
        this.checkResult(objectVo);
        objectVo.getSearch().setId(id);
        objectVo.getSearch().setType(PayAccountType.ONLINE_ACCOUNT.getCode());
        objectVo = this.doEdit(objectVo, model);
        objectVo = getPayAccountVo(objectVo);
        objectVo.setBankList(getOnlineBank(""));
        objectVo.setValidateRule(JsRuleCreator.create(PayAccountOnlineForm.class, "result"));
        this.getPayCurrencyAndRank(objectVo);
        List<Map<String, String>> channelJson = JsonTool.fromJson(objectVo.getResult().getChannelJson(), List.class);
        if (channelJson != null) {
            for (Map<String, String> map : channelJson) {
                if (map.get("column").equals("key")) {
                    String key = map.get("value");
                    CryptoTool.aesEncrypt(key);
                    map.put("value", CryptoTool.aesDecrypt(key));
                }
            }
        }
        BankVo bankVo = new BankVo();
        bankVo.getSearch().setBankName(objectVo.getResult().getBankCode());
        bankVo = ServiceTool.bankService().search(bankVo);
        SysDomainListVo sysDomainListVo = new SysDomainListVo();
        objectVo.setSysDomains(getSysDomainList(sysDomainListVo));
        model.addAttribute("currentBank", bankVo);
        model.addAttribute("channelJson", channelJson);
        model.addAttribute("command", objectVo);
        model.addAttribute("bankPayTypes", BankPayTypeEnum.values());
        //手续费列表
        RechargeFeeSchemaListVo schemaListVo = new RechargeFeeSchemaListVo();
        schemaListVo = ServiceSiteTool.rechargeFeeSchemaService().searchList(schemaListVo);
        model.addAttribute("schemaListVo", schemaListVo);
        //账户关联的手续费
        FeeAccountRelationVo feeAccountRelationVo = new FeeAccountRelationVo();
        feeAccountRelationVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(FeeAccountRelation.PROP_PAY_ACCOUNT_ID,Operator.EQ,objectVo.getResult().getId())
        });
        feeAccountRelationVo = ServiceSiteTool.feeAccountRelationService().search(feeAccountRelationVo);
        model.addAttribute("feeAccountRelation", feeAccountRelationVo.getResult());
        return "/content/payaccount/onLine/Add";
    }

    /**
     * 编辑需要加载货币和已设置层级
     */
    private void getPayCurrencyAndRank(PayAccountVo objectVo) {
        PayAccountCurrencyListVo payAccountCurrencyListVo = new PayAccountCurrencyListVo();
        Integer payAccountId = objectVo.getResult().getId();
        payAccountCurrencyListVo.getSearch().setPayAccountId(payAccountId);
        payAccountCurrencyListVo = ServiceSiteTool.payAccountCurrencyService().search(payAccountCurrencyListVo);
        objectVo.setPayAccountCurrencyList(payAccountCurrencyListVo.getResult());
        PayRankListVo payRankListVo = new PayRankListVo();
        payRankListVo.getSearch().setPayAccountId(objectVo.getResult().getId());
        payRankListVo.setPaging(null);
        payRankListVo = ServiceSiteTool.payRankService().search(payRankListVo);
        objectVo.setPayRankList(payRankListVo.getResult());
    }

    /**
     * 加载收款账户信息
     */
    private PayAccountVo getPayAccountVo(PayAccountVo objectVo) {
        //公司入款支持开通的货币
        if (PayAccountType.COMPANY_ACCOUNT.getCode().equals(objectVo.getSearch().getType())) {
            objectVo.setSiteCurrencyList(this.openAndSupportCurrencies(objectVo.getResult().getBankCode()));
            getBankList(objectVo);//支持的银行
        } else {
            //在线支付支持开通的货币
            objectVo.setSiteCurrencyList(this.openAndSupport(objectVo.getResult().getBankCode()));
        }
        objectVo.setAccountType(DictTool.get(DictEnum.PAY_ACCOUNT_ACCOUNT_TYPE));
        //编辑
        /*if (objectVo.getResult().getId() != null) {
            bankListVo.getSearch().setBankName(objectVo.getResult().getBankCode());
        } else {
            //新增,生成账户代号
            objectVo = this.getService().generationPayCode(objectVo);
        }*/
        objectVo = this.getService().generationPayCode(objectVo);
        //获取可用的层级列表
        objectVo.setPlayerRankList(ServiceSiteTool.playerRankService().queryUsableList(new PlayerRankVo()));

        return objectVo;
    }

    private void getBankList(PayAccountVo objectVo) {
        Map<String, Bank> bankMap = Cache.getBank();
        List<Bank> bankList = new LinkedList<>();
        List<Bank> thirdBankList = new ArrayList<>();
        String bankType = BankEnum.TYPE_BANK.getCode();
        String thirdType = BankEnum.TYPE_THIRD.getCode();
        for (Bank bank : bankMap.values()) {
            if (bankType.equals(bank.getType())) {
                bankList.add(bank);
            } else if (thirdType.equals(bank.getType())) {
                thirdBankList.add(bank);
            }
        }
        objectVo.setBankList(bankList);
        objectVo.setThirdBankList(thirdBankList);
    }

    /**
     * create by ke
     *
     * @return 保存公司入款账户
     */
    @RequestMapping({"/saveCompany"})
    @ResponseBody
    @Token(valid = true)
    public Map saveCompany(PayAccountVo payAccountVo, @FormModel("result") @Valid PayAccountCompanyForm form, BindingResult result) {
        if (!result.hasErrors()) {
            PayAccount account = payAccountVo.getResult();
            //过滤 html 标签
            account.setRemark(replaceHtml(account.getRemark()));
            /*account.setRemark(isBlank(remark) ? remark : remark.replace("\r\n", "<br>"));*/

            if (PayAccountAccountType.BANKACCOUNT.getCode().equals(account.getAccountType())) {
                account.setCustomBankName(form.get$customBankName());
            }
            if (account.getSupportAtmCounter() == null) {
                account.setSupportAtmCounter(false);
            }
            //比特币地址存在channeljson里
            if (StringTool.isNotBlank(form.getBitCoinChannelVo_apiKey()) && StringTool.isNotBlank(form.getBitCoinChannelVo_apiSecret())) {
                payAccountVo.getBitCoinChannelVo().setApiKey(CryptoTool.aesEncrypt(form.getBitCoinChannelVo_apiKey(), CryptoKey.KEY_BIT_COIN_CHANNEL));
                payAccountVo.getBitCoinChannelVo().setApiSecret(CryptoTool.aesEncrypt(form.getBitCoinChannelVo_apiSecret(), CryptoKey.KEY_BIT_COIN_CHANNEL));
                account.setChannelJson(JsonTool.toJson(payAccountVo.getBitCoinChannelVo()));
            }
            if (account.getId() == null) {
                if (PayAccountAccountType.BANKACCOUNT.getCode().equals(account.getAccountType())) {
                    account.setQrCodeUrl(null);
                }
                payAccountVo.getSearch().setType(PayAccountType.COMPANY_ACCOUNT.getCode());
                account.setDepositDefaultCount(0);
                account.setAccount(PayAccountType.COMPANY_ACCOUNT.getCode().equals(account.getAccountType()) ? payAccountVo.getAccount1() : payAccountVo.getAccount2());
                account.setDepositCount(0);
                account.setDepositDefaultTotal(0.0);
                account.setDepositTotal(0.0);
                account.setCreateUser(SessionManagerBase.getUserId());
                account.setStatus(PayAccountStatusEnum.USING.getCode());
                account.setCreateTime(new Date());
                this.getService().savePayAccount(payAccountVo);
            } else {
                payAccountVo = this.getService().updatePayAccount(payAccountVo);
            }
            return this.getVoMessage(payAccountVo);
        } else {
            payAccountVo.setSuccess(false);
            if (result.getAllErrors().size() > 0) {
                String mesg = result.getAllErrors().get(0).getDefaultMessage();
                if (StringTool.isNotBlank(mesg) && mesg.indexOf(".") > -1) {
                    String module = mesg.substring(0, mesg.indexOf("."));
                    String errmsg = LocaleTool.tranMessage(module, mesg.substring(mesg.indexOf(".") + 1));
                    payAccountVo.setErrMsg(errmsg);
                }

            }
            Map voMessage = this.getVoMessage(payAccountVo);
            voMessage.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
            return voMessage;
        }

    }

    /**
     * create by ke
     *
     * @return 保存在线支付
     */
    @RequestMapping({"/saveOnLine"})
    @ResponseBody
    @Audit(module = Module.PAY, moduleType = ModuleType.ONLINE_ACCOUNT_EDIT, opType = OpType.CREATE)
    @Token(valid = true)
    public Map saveOnLine(PayAccountVo vo, @FormModel("result") @Valid PayAccountOnlineForm form, BindingResult result) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        //操作日志
        LogVo logVo = new LogVo();
        BaseLog baseLog = logVo.addBussLog();
        if (!result.hasErrors()) {
            vo.getResult().setAccount(vo.getResult().getAccount().trim());
            // 设置支付方式
            setAccountType(vo);
            // 设置支付借口参数
            setPayParam(vo);
            if (vo.getResult().getId() == null) {
                // 初始化vo
                initAccountVo(vo);
                this.getService().savePayAccount(vo);
            } else {
                vo = this.getService().updatePayAccountEdit(vo);
            }
            addLog(vo, request, logVo, baseLog);
        } else {
            vo.setSuccess(false);
            Map voMessage = this.getVoMessage(vo);
            voMessage.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
            return voMessage;
        }
        return this.getVoMessage(vo);
    }

    /**
     * 日志描述
     *
     * @param vo
     * @param request
     * @param logVo
     * @param baseLog
     */
    private void addLog(PayAccountVo vo, HttpServletRequest request, LogVo logVo, BaseLog baseLog) {
        List<String> list = new ArrayList<>();
        list.add(vo.getResult().getBankCode());
        list.add(vo.getResult().getAccount());
        String channelJson = vo.getResult().getChannelJson();
        if (vo.getResult().getSingleDepositMin() != null) {
            list.add(vo.getResult().getSingleDepositMin().toString());
        } else {
            list.add(null);
        }
        if (vo.getResult().getSingleDepositMax() != null) {
            list.add(vo.getResult().getSingleDepositMax().toString());
        } else {
            list.add(null);
        }
        AddLogVo addLogVo = new AddLogVo();
        addLogVo.setList(list);
        baseLog.setDescription("change.payAccount.online");
        baseLog.addParam("channelJson", channelJson);

        for (String param : addLogVo.getList()) {
            baseLog.addParam(param);
        }
        request.setAttribute(SysAuditLog.AUDIT_LOG, logVo);
    }

    /**
     * 初始化vo
     *
     * @param vo PayAccountVo
     */
    private void initAccountVo(PayAccountVo vo) {
        vo.getSearch().setType(PayAccountType.ONLINE_ACCOUNT.getCode());
        vo.getResult().setDepositDefaultCount(0);
        vo.getResult().setDepositCount(0);
        vo.getResult().setDepositDefaultTotal(0.0);
        vo.getResult().setDepositTotal(0.0);
        vo.getResult().setCreateUser(SessionManagerBase.getUserId());
        vo.getResult().setStatus(PayAccountStatusEnum.USING.getCode());
        vo.getResult().setCreateTime(new Date());
    }

    /**
     * 设置支付方式
     *
     * @param vo PayAccountVo
     */
    private void setAccountType(PayAccountVo vo) {
        String accountType = PayAccountAccountType.THIRTY.getCode();
        Bank bank = Cache.getBank().get(vo.getResult().getBankCode());
        String payType = bank != null ? bank.getPayType() : "";
        if (BankPayTypeEnum.ALIPAY.getCode().equals(payType)) {
            accountType = PayAccountAccountType.ALIPAY.getCode();
        } else if (BankPayTypeEnum.WECHAT.getCode().equals(payType)) {
            accountType = PayAccountAccountType.WECHAT.getCode();
        } else if (BankPayTypeEnum.QQWALLET.getCode().equals(payType)) {
            accountType = PayAccountAccountType.QQWALLET.getCode();
        } else if (BankPayTypeEnum.JD_PAY.getCode().equals(payType)) {
            accountType = PayAccountAccountType.JD_PAY.getCode();
        } else if (BankPayTypeEnum.BAIFU_PAY.getCode().equals(payType)) {
            accountType = PayAccountAccountType.BAIFU_PAY.getCode();
        } else if (BankPayTypeEnum.ＵUNION_PAY.getCode().equals(payType)) {
            accountType = PayAccountAccountType.UNION_PAY.getCode();
        } else if (BankPayTypeEnum.WECHAT_MICROPAY.getCode().equals(payType)) {
            accountType = PayAccountAccountType.WECHAT_MICROPAY.getCode();
        } else if (BankPayTypeEnum.ALIPAY_MICROPAY.getCode().equals(payType)) {
            accountType = PayAccountAccountType.ALIPAY_MICROPAY.getCode();
        } else if (BankPayTypeEnum.QQ_MICROPAY.getCode().equals(payType)) {
            accountType = PayAccountAccountType.QQ_MICROPAY.getCode();
        } else if (BankPayTypeEnum.EASY_PAY.getCode().equals(payType)) {
            accountType = PayAccountAccountType.EASY_PAY.getCode();
        }
        vo.getResult().setAccountType(accountType);
    }

    /**
     * 设置支付借口参数
     *
     * @param vo PayAccountVo
     */
    private void setPayParam(PayAccountVo vo) {
        //线上支付的密钥要加密
        if (PayAccountType.ONLINE_ACCOUNT.getCode().equals(vo.getResult().getType())) {
            ArrayList<Map<String, String>> arrayList = JsonTool.fromJson(vo.getResult().getChannelJson(), ArrayList.class);
            for (Map<String, String> map : arrayList) {
                if (map.get("column").equals("key")) {
                    String key = map.get("value");
                    CryptoTool.aesEncrypt(key);
                    map.put("value", CryptoTool.aesEncrypt(key));
                }
            }
            vo.getResult().setChannelJson(JsonTool.toJson(arrayList));
        }
    }

    /**
     * 更新公司入款账户
     *
     * @return create by ke
     */
    @RequestMapping({"/updateCompany"})
    @ResponseBody
    public Map updateCompany(PayAccountVo payAccountVo, @FormModel("result") @Valid PayAccountCompanyEditForm form, BindingResult result) {
        if (!result.hasErrors()) {
            payAccountVo = this.getService().updatePayAccount(payAccountVo);
            return this.getVoMessage(payAccountVo);
        }
        return null;
    }

    /**
     * 编辑线上支付
     *
     * @return 编辑保存线上支付
     * create by ke
     */
    @RequestMapping({"/updateOnLine"})
    @ResponseBody
    public Map updateOnLine(PayAccountVo payAccountVo, @FormModel("result") @Valid PayAccountOnLineEditForm form, BindingResult result) {
        if (!result.hasErrors()) {
            payAccountVo = this.getService().updatePayAccountEdit(payAccountVo);
            return this.getVoMessage(payAccountVo);
        }
        return null;
    }

    /**
     * 如果有层级的收款账户只有这个账户，需要提示
     *
     * @return create by ke
     */
    @RequestMapping({"/payRankIsA"})
    @ResponseBody
    public String payRankIsA(Integer payRankId, PayAccountVo vo) {
        List<PlayerRank> rankList = this.getService().payRankIsA(payRankId, vo);
        return JsonTool.toJson(rankList);
    }

    /**
     * 修改账户状态
     *
     * @param vo create by ke
     */
    @RequestMapping({"/changePayStatus"})
    @ResponseBody
    @Audit(module = Module.MASTER_OPERATION, moduleType = ModuleType.COMPANY_ACCOUNT_ENABLE, opType = OpType.UPDATE)
    public String changePayStatus(PayAccountVo vo) {
        String[] properties = new String[1];
        properties[0] = PayAccount.PROP_STATUS;
        vo.setProperties(properties);
        this.getService().updateOnly(vo);
        vo.getSearch().setId(vo.getResult().getId());
        addChangePayStatusLog(vo);
        return "true";
    }

    /**
     * 添加日志
     *
     * @param vo
     */
    private void addChangePayStatusLog(PayAccountVo vo) {
        try {
            if (vo.isSuccess()) {
                vo = getService().get(vo);
                String status = "";
                if ("1".equals(vo.getResult().getStatus())) {
                    status = "启用";
                } else if ("2".equals(vo.getResult().getStatus())) {
                    status = "停用";
                }
                BussAuditLogTool.addLog("COMPANY_ACCOUNT_FREEZE", vo.getResult().getPayName(), status);
            }
        } catch (Exception ex) {

        }
    }


    /**
     * @param vo create by ke
     */
    @RequestMapping({"/thawInfo"})
    public String thawInfo(PayAccountVo vo, Model model) {
        if (vo.getReminder() != null) {
            model.addAttribute("taskId", vo.getReminder().getId());
        } else {
            UserTaskReminderVo reminderVo = new UserTaskReminderVo();
            reminderVo.getSearch().setDictCode(UserTaskEnum.FREEZE.getCode());
            reminderVo = ServiceSiteTool.userTaskReminderService().search(reminderVo);
            if (reminderVo.getResult() != null) {
                model.addAttribute("taskId", reminderVo.getResult().getId());
            }

        }
        vo = this.getService().get(vo);
        model.addAttribute("command", vo);
        if (vo != null && vo.getResult() != null) {
            model.addAttribute("payId", vo.getResult().getId());
        }
        model.addAttribute("country", SessionManager.getTimeZone());
        return "/content/payaccount/Thaw";
    }

    /**
     * 获取停用金额，跳转至去提高页面
     */
    @RequestMapping({"/getDisableInfo"})
    public String getDisableInfo(PayAccountVo vo, Model model, Date startTime, Date endTime) {
        if (vo.getReminder() != null) {
            Integer taskId = vo.getReminder().getId();
            model.addAttribute("taskId", taskId);
        }

        vo = this.getService().get(vo);
        vo.setValidateRule(JsRuleCreator.create(PayAccountToImproveForm.class, "result"));
        if (startTime != null || endTime != null) {
            Map map;
            VPlayerRechargeListVo vPlayerRechargeListVo = new VPlayerRechargeListVo();
            VPlayerRechargeSo query = vPlayerRechargeListVo.getSearch();
            query.setStartTime(startTime);
            query.setEndTime(endTime);
            query.setPayAccountId(vo.getSearch().getId());
            map = ServiceSiteTool.vPlayerRechargeService().getStatistics(vPlayerRechargeListVo);

            Integer hours = endTime.getHours();
            Number totalAmount = (Number) map.get("totalAmount");
            if (totalAmount != null && totalAmount.longValue() > 0) {
                totalAmount = (totalAmount.longValue() / hours) * 24;
            }
            model.addAttribute("totalAmount", totalAmount == null ? 0 : totalAmount.longValue());
        }
        model.addAttribute("command", vo);
        return "/content/payaccount/toImprove";
    }

    /**
     * 提高金额保存
     *
     * @param originalDisableAmount 提高前的停用金额
     */
    @RequestMapping({"/toImproveAmount"})
    @ResponseBody
    @Audit(module = Module.PAY_WARNING, moduleType = ModuleType.COMPANY_ACCOUNT_UNFREEZE, opType = OpType.OTHER)
    public Map toImproveAmount(PayAccountVo vo, @FormModel("result") @Valid PayAccountToImproveForm form, BindingResult result, Integer originalDisableAmount) {
        result.getAllErrors();
        if (!result.hasErrors()) {
            String[] properties = new String[2];
            properties[0] = PayAccount.PROP_DISABLE_AMOUNT;
            properties[1] = PayAccount.PROP_STATUS;
            vo.setProperties(properties);
            vo.getResult().setStatus(PayAccountStatusEnum.USING.getCode());
            vo.setOriginalDisableAmount(originalDisableAmount);
            vo.setUsername(SessionManager.getUserName());
            this.getService().unfreezePayAccount(vo);

            return this.getVoMessage(vo);
        }
        return null;
    }

    /**
     * 验证输入的停用金额是否大于原来的值
     */
    @RequestMapping({"/validToImprove"})
    @ResponseBody
    public String validToImprove(@RequestParam("result.disableAmount") String disableAmount, @RequestParam("result.id") String id) {
        PayAccountVo vo = new PayAccountVo();
        vo.getSearch().setId(isBlank(id) ? null : Integer.valueOf(id));
        vo = this.getService().get(vo);
        return Integer.valueOf(disableAmount) > vo.getResult().getDisableAmount() ? "true" : "false";
    }

    /**
     * 验证输入的停用金额是否大于累计的值
     */
    @RequestMapping({"/validToDepositTotal"})
    @ResponseBody
    public String validToDepositTotal(@RequestParam("result.disableAmount") String disableAmount, @RequestParam("result.id") String id) {
        PayAccountVo vo = new PayAccountVo();
        vo.getSearch().setId(isBlank(id) ? null : Integer.valueOf(id));
        vo = this.getService().get(vo);
        return Integer.valueOf(disableAmount) > vo.getResult().getDepositTotal() ? "true" : "false";
    }

    /**
     * 输入账号查询对应银行
     */
    @RequestMapping({"/getBankInfo"})
    @ResponseBody
    public PayAccountVo getBankInfo(BankExtendVo bankExtendVo, PayAccountVo payAccountVo) {
        String account = bankExtendVo.getSearch().getBankCardBegin();
        bankExtendVo.getSearch().setBankCardBegin(account.substring(0, 4));
        Bank bank = ServiceTool.bankExtendService().getBank(bankExtendVo);
        if (bank != null) {
            List<SiteCurrency> inQuery = openAndSupportCurrencies(bank.getBankName());

            payAccountVo.setSiteCurrencyList(inQuery);

            payAccountVo.setBank(bank);
        }
        return payAccountVo;
    }

    /**
     * 选择第三方平台查询对应货币
     */
    @RequestMapping({"/getThirdBank"})
    @ResponseBody
    public PayAccountVo getThirdBank(PayAccountVo payAccountVo) {

        if (StringTool.isNotBlank(payAccountVo.getSearch().getBankCode())) {
            List<SiteCurrency> inQuery = openAndSupportCurrencies(payAccountVo.getSearch().getBankCode());
            payAccountVo.setSiteCurrencyList(inQuery);
        }
        return payAccountVo;
    }

    /**
     * 公司入款，开通并支持的货币
     */
    private List<SiteCurrency> openAndSupportCurrencies(String bankName) {
        SiteCurrencyListVo siteCurrencyListVo = new SiteCurrencyListVo();
        siteCurrencyListVo.getSearch().setStatus(SiteCurrencyEnum.NORMAL.getCode());
        siteCurrencyListVo.getSearch().setSiteId(SessionManager.getSiteId());
        siteCurrencyListVo = ServiceTool.sysSiteCurrencyService().search(siteCurrencyListVo);

        BankSupportCurrencyListVo bankSupportCurrencyListVo = new BankSupportCurrencyListVo();
        bankSupportCurrencyListVo.getSearch().setBankCode(bankName);
        bankSupportCurrencyListVo = ServiceTool.bankSupportCurrencyService().search(bankSupportCurrencyListVo);

        List list = CollectionQueryTool.queryProperty(bankSupportCurrencyListVo.getResult(), BankSupportCurrency.PROP_CURRENCY_CODE);
        if (list.size() == 0) {
            return null;
        }
        return CollectionQueryTool.inQuery(siteCurrencyListVo.getResult(), SiteCurrency.PROP_CODE, list);
    }

    /**
     * 查询在线支付接口需要的字段
     */
    @RequestMapping({"/queryChannelColumn"})
    @ResponseBody
    public PayAccountVo queryChannelColumn(OnlinePayVo onlinePayVo, PayAccountVo payAccountVo) {
        if (isBlank(onlinePayVo.getChannelCode())) {
            return null;
        }
        payAccountVo.setOpenAndSupportList(this.openAndSupport(onlinePayVo.getChannelCode()));
        IOnlinePayService onlinePayService = ServiceTool.onlinePayService();
        OnlinePayVo accountList = onlinePayService.getAccountList(onlinePayVo);
        payAccountVo.setPayApiParams(accountList.getAccountParams());
        //查询支持终端
        onlinePayVo = onlinePayService.getSupportTerminalByChannel(onlinePayVo);
        payAccountVo.setSupportTerminalSet(onlinePayVo.getSupportTerminalSet());
        return payAccountVo;
    }

    /**
     * 查出站长开通的并且第三方支付接口支持的货币
     *
     * @param channelCode 第三方接口code
     * @return List
     */
    private List<SiteCurrency> openAndSupport(String channelCode) {
        if (isBlank(channelCode)) {
            return null;
        }
        //站长支持的货币
        SiteCurrencyListVo siteCurrencyListVo = new SiteCurrencyListVo();
        siteCurrencyListVo.getSearch().setSiteId(SessionManager.getSiteId());
        siteCurrencyListVo.getSearch().setStatus(SiteCurrencyEnum.NORMAL.getCode());
        siteCurrencyListVo = ServiceTool.sysSiteCurrencyService().search(siteCurrencyListVo);

        OnlinePayVo onlinePayVo = new OnlinePayVo();
        onlinePayVo.setChannelCode(channelCode);
        OnlinePayVo supportCurrencyByChannel = ServiceTool.onlinePayService().getSupportCurrencyByChannel(onlinePayVo);
        if (CollectionTool.isEmpty(supportCurrencyByChannel.getSupportCurrencySet())) {
            return null;
        }
        List<String> list = new ArrayList<>(supportCurrencyByChannel.getSupportCurrencySet());

        return CollectionQueryTool.inQuery(siteCurrencyListVo.getResult(), SiteCurrency.PROP_CODE, list);
    }

    @RequestMapping("/getRankByUserId")
    public String getRankByUserId(VPlayerTagVo vPlayerTagVo, Model model) {
        List<VPlayerTag> vPlayerTags = ServiceSiteTool.vPlayerTagService().getPayRankByUsers(vPlayerTagVo);

        model.addAttribute("tags", vPlayerTags);
        model.addAttribute("userLen", vPlayerTagVo.getUserId().size());
        model.addAttribute("userIds", vPlayerTagVo.getUserId());
        return this.getViewBasePath() + "/RankTags";
    }

    @RequestMapping("/saveRank")
    @ResponseBody
    public Map saveRank(PayRankVo payRankVo) {
        try {
            payRankVo = ServiceSiteTool.payRankService().saveOrUpdatePayRanks(payRankVo);
        } catch (Exception e) {
            LOG.error(e);
            payRankVo.setSuccess(false);
        }
        return getVoMessage(payRankVo);
    }

    /**
     * 远程验证 - account唯一验证
     */
    @RequestMapping("/checkChnnel")
    @ResponseBody
    public boolean checkChnnel(@RequestParam("result.bankCode") String channel, @RequestParam("result.account") String account, @RequestParam("result.id") String id) {
        PayAccountListVo payAccountListVo = new PayAccountListVo();
        payAccountListVo.getSearch().setAccount(account);
        payAccountListVo.getSearch().setBankCode(channel);
        if (StringTool.isNotBlank(id)) {
            payAccountListVo.getSearch().setId(Integer.valueOf(id));
        }
        return this.getService().checkAccountUniqueUnderBankCode(payAccountListVo);
    }

    /**
     * 验证该名称是否存在
     */
    @RequestMapping("/checkPayName")
    @ResponseBody
    public boolean checkPayName(@RequestParam("result.payName") String payName, @RequestParam("result.accountType") String type, @RequestParam("result.id") Integer id, @RequestParam("result.bankCode") String bankCode) {
        PayAccountListVo payAccountListVo = new PayAccountListVo();
        payAccountListVo.getSearch().setPayName(payName);
        payAccountListVo.getSearch().setType(type);
        payAccountListVo.getSearch().setId(id);
        if (PayAccountType.ONLINE_ACCOUNT.getCode().equals(type)) {
            payAccountListVo.getSearch().setBankCode(bankCode);
        }

        boolean isExist = this.getService().payNameIsExist(payAccountListVo);
        return !isExist;
    }

    /**
     * 预警设置
     *
     * @param type 1：公司入款账户；2：线上支付账户
     */
    @RequestMapping({"/warningSettings/{type}"})
    public String alarmSetting(Model model, @PathVariable String type, HttpServletRequest request) {
        if (PayAccountType.COMPANY_ACCOUNT.getCode().equals(type)) {
            //层级账户不足个数
            model.addAttribute("inadequateCount", ParamTool.getSysParam(SiteParamEnum.CONTENT_DEPOSIT_ACCOUNT_WARNING_INADEQUATE_COUNT));
            //层级账户不足提醒
            model.addAttribute("inadequateState", ParamTool.getSysParam(SiteParamEnum.CONTENT_DEPOSIT_ACCOUNT_WARNING_INADEQUATE_STATE));
        } else if (PayAccountType.ONLINE_ACCOUNT.getCode().equals(type)) {
            //层级账户不足个数
            model.addAttribute("inadequateCount", ParamTool.getSysParam(SiteParamEnum.CONTENT_PAY_ACCOUNT_WARNING_INADEQUATE_COUNT));
            //层级账户不足提醒
            model.addAttribute("inadequateState", ParamTool.getSysParam(SiteParamEnum.CONTENT_PAY_ACCOUNT_WARNING_INADEQUATE_STATE));
        }
        model.addAttribute("validateRule", JsRuleCreator.create(WarningSettingsForm.class));
        return "/content/payaccount/WarningSettings";
    }

    @RequestMapping("/revertData")
    @ResponseBody
    public PayAccount revertData(@RequestParam("id") Integer id) {
        if (id == null) {
            return new PayAccount();
        }
        PayAccountVo payAccountVo = new PayAccountVo();
        payAccountVo.getSearch().setId(id);
        payAccountVo = ServiceSiteTool.payAccountService().get(payAccountVo);
        if (payAccountVo.getResult() != null) {
            return payAccountVo.getResult();
        }
        return new PayAccount();
    }

    /**
     * 更新累计存款次数
     *
     * @param payAccountVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping("/saveDepositDefaultCount")
    @ResponseBody
    public Map saveDepositDefaultCount(PayAccountVo payAccountVo, @FormModel @Valid PayAccountDepositForm form,
                                       BindingResult result) {
        Map<String, Object> map = new HashMap<>(3, 1f);
        if (result.hasErrors()) {
            map.put("state", false);
            map.put("msg", LocaleTool.tranMessage(Module.COMMON, MessageI18nConst.SAVE_FAILED));
            return map;
        }

        payAccountVo.setProperties(PayAccount.PROP_DEPOSIT_DEFAULT_COUNT);
        payAccountVo = ServiceSiteTool.payAccountService().updateOnly(payAccountVo);
        if (payAccountVo.isSuccess()) {
            map.put("payAccountValue", payAccountVo.getResult().getDepositDefaultCount());
            map.put("state", true);
            map.put("msg", LocaleTool.tranMessage(Module.COMMON, MessageI18nConst.SAVE_SUCCESS));
        } else {
            map.put("state", false);
            map.put("msg", LocaleTool.tranMessage(Module.COMMON, MessageI18nConst.SAVE_FAILED));
        }
        return map;
    }

    /**
     * 更新累计存款次数
     *
     * @param payAccountVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping("/saveDepositDefaultTotal")
    @ResponseBody
    public Map saveDepositDefaultTotal(PayAccountVo payAccountVo, @FormModel @Valid PayAccountDepositForm form,
                                       BindingResult result) {
        Map<String, Object> map = new HashMap<>(3, 1f);
        if (result.hasErrors()) {
            map.put("state", false);
            map.put("msg", LocaleTool.tranMessage(Module.COMMON, MessageI18nConst.SAVE_FAILED));
            return map;
        }

        payAccountVo.setProperties(PayAccount.PROP_DEPOSIT_DEFAULT_TOTAL);
        payAccountVo = ServiceSiteTool.payAccountService().updateOnly(payAccountVo);
        if (payAccountVo.isSuccess()) {
            map.put("payAccountValue", CurrencyTool.formatCurrency(payAccountVo.getResult().getDepositDefaultTotal()));
            map.put("state", true);
            map.put("msg", LocaleTool.tranMessage(Module.COMMON, MessageI18nConst.SAVE_SUCCESS));
        } else {
            map.put("state", false);
            map.put("msg", LocaleTool.tranMessage(Module.COMMON, MessageI18nConst.SAVE_FAILED));
        }
        return map;
    }

    /**
     * 数据恢复
     *
     * @param payAccountVo
     * @return
     */
    @RequestMapping("/recoveryData/{types}")
    @ResponseBody
    public Map recoveryData(PayAccountVo payAccountVo, @PathVariable String types) {
        Map<String, Object> map = new HashMap<>(3, 1f);
        PayAccount payAccount = payAccountVo.getResult();
        if (payAccount == null || payAccount.getId() == null) {
            map.put("state", false);
            map.put("msg", LocaleTool.tranMessage(Module.COMMON, MessageI18nConst.SAVE_FAILED));
            return map;
        }

        VPayAccountVo vPayAccountVo = new VPayAccountVo();
        vPayAccountVo.getSearch().setId(payAccount.getId());
        vPayAccountVo = ServiceSiteTool.vPayAccountService().get(vPayAccountVo);

        if ("count".equals(types)) {
            payAccountVo.setProperties(PayAccount.PROP_DEPOSIT_DEFAULT_COUNT);
            payAccount.setDepositDefaultCount(vPayAccountVo.getResult().getRechargeNum().intValue());
        } else if ("total".equals(types)) {
            payAccountVo.setProperties(PayAccount.PROP_DEPOSIT_DEFAULT_TOTAL);
            payAccount.setDepositDefaultTotal(vPayAccountVo.getResult().getRechargeAmount());
        }
        payAccountVo = ServiceSiteTool.payAccountService().updateOnly(payAccountVo);

        if (payAccountVo.isSuccess()) {
            if ("count".equals(types)) {
                map.put("payAccountValue", payAccountVo.getResult().getDepositDefaultCount());
            } else if ("total".equals(types)) {
                map.put("payAccountValue", payAccountVo.getResult().getDepositDefaultTotal() == null ? 0.00
                        : payAccountVo.getResult().getDepositDefaultTotal());
            }
            map.put("state", true);
            map.put("msg", LocaleTool.tranMessage(Module.COMMON, MessageI18nConst.SAVE_SUCCESS));
        } else {
            map.put("state", false);
            map.put("msg", LocaleTool.tranMessage(Module.COMMON, MessageI18nConst.SAVE_FAILED));
        }

        return map;
    }

    @RequestMapping("/fetchPayAccount")
    @ResponseBody
    public PayAccount fetchPayAccount(Integer accountId) {
        if (accountId == null) {
            return null;
        }
        PayAccountVo payAccountVo = new PayAccountVo();
        payAccountVo.getSearch().setId(accountId);
        payAccountVo = ServiceSiteTool.payAccountService().get(payAccountVo);

        return payAccountVo.getResult();
    }

    @RequestMapping("/rechargeUrl")
    public String rechargeUrl(Model model) {
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.SETTING_RECHARGE_URL);
        model.addAttribute("command", sysParam);
        SysParam allRank = ParamTool.getSysParam(SiteParamEnum.SETTING_RECHARGE_URL_ALL_RANK);
        model.addAttribute("allRank", allRank);
        SysParam ranksParam = ParamTool.getSysParam(SiteParamEnum.SETTING_RECHARGE_URL_RANKS);
        model.addAttribute("ranksParam", ranksParam);
        PlayerRankListVo playerRankListVo = new PlayerRankListVo();
        playerRankListVo.setProperties(PlayerRank.PROP_ID, PlayerRank.PROP_RANK_NAME);
        playerRankListVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(PlayerRank.PROP_STATUS, Operator.EQ, RankStatusEnum.NORMAL.getCode())
        });
        model.addAttribute("ranks", ServiceSiteTool.playerRankService().searchProperties(playerRankListVo));
        model.addAttribute("validateRule", JsRuleCreator.create(RechargeUrlForm.class));
        return getViewBasePath() + "RechargeUrl";
    }

    /**
     * 保存快速充值
     *
     * @param paramValue
     * @return
     */
    @RequestMapping("/saveRechargeUrl")
    @ResponseBody
    public Map savePageUrl(String paramValue, String allRank, String rank, @FormModel @Valid RechargeUrlForm form, BindingResult result) {
        SysParamVo sysParamVo = new SysParamVo();
        if (result.hasErrors()) {
            sysParamVo.setSuccess(false);
            return getVoMessage(sysParamVo);
        }
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.SETTING_RECHARGE_URL);
        if (sysParam == null) {
            LOG.info("获取快速充值参数找不到！");
            sysParamVo.setSuccess(false);
            return getVoMessage(sysParamVo);
        }
        sysParam.setParamValue(paramValue);
        sysParamVo.setResult(sysParam);
        sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE);
        sysParamVo = ServiceSiteTool.siteSysParamService().updateOnly(sysParamVo);
        SysParam allRankParam = ParamTool.getSysParam(SiteParamEnum.SETTING_RECHARGE_URL_ALL_RANK);
        if (allRankParam != null) {
            sysParamVo.setResult(allRankParam);
            allRankParam.setParamValue(allRank);
            sysParamVo = ServiceSiteTool.siteSysParamService().updateOnly(sysParamVo);
        }
        SysParam ranksParam = ParamTool.getSysParam(SiteParamEnum.SETTING_RECHARGE_URL_RANKS);
        if (ranksParam != null) {
            sysParamVo.setResult(ranksParam);
            ranksParam.setParamValue(rank);
            sysParamVo = ServiceSiteTool.siteSysParamService().updateOnly(sysParamVo);
        }
        ParamTool.refresh(SiteParamEnum.SETTING_RECHARGE_URL);
        ParamTool.refresh(SiteParamEnum.SETTING_RECHARGE_URL_ALL_RANK);
        ParamTool.refresh(SiteParamEnum.SETTING_RECHARGE_URL_RANKS);
        return getVoMessage(sysParamVo);
    }

    /**
     * 数字货币信息
     *
     * @param model
     * @return
     */
    @RequestMapping("/digiccyAccount")
    public String digiccyAccount(Model model) {
        SysParam param = ParamTool.getSysParam(SiteParamEnum.DIGICCY_PROVIDER_ACCOUNT_INFO);
        if (param != null && StringTool.isNotBlank(param.getParamValue())) {
            model.addAttribute("info", JsonTool.fromJson(param.getParamValue(), DigiccyAccountInfo.class));
        }
        model.addAttribute("providers", Cache.getDigiccyApiProviderMap());
        return "/content/payaccount/onLine/DigiccyAccount";
    }

    /**
     * 保存数字货币信息
     *
     * @param digiccyAccountInfo
     * @return
     */
    @RequestMapping("/saveDigiccyAccount")
    @ResponseBody
    public Map saveDigiccyAccount(DigiccyAccountInfo digiccyAccountInfo) {
        if (!PayAccountStatusEnum.USING.getCode().equals(digiccyAccountInfo.getStatus())) {
            digiccyAccountInfo.setStatus(PayAccountStatusEnum.DISABLED.getCode());
        }
        SysParam param = ParamTool.getSysParam(SiteParamEnum.DIGICCY_PROVIDER_ACCOUNT_INFO);
        SysParamVo sysParamVo = new SysParamVo();
        if (param != null) {
            digiccyAccountInfo.setAccount(CryptoTool.aesEncrypt(digiccyAccountInfo.getAccount(), CryptoKey.KEY_DIGICCY_ACCOUNT_INFO));
            digiccyAccountInfo.setPwd(CryptoTool.aesEncrypt(digiccyAccountInfo.getPwd(), CryptoKey.KEY_DIGICCY_ACCOUNT_INFO));
            param.setParamValue(JsonTool.toJson(digiccyAccountInfo));
            sysParamVo.setResult(param);
            sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE);
            sysParamVo = ServiceSiteTool.siteSysParamService().updateOnly(sysParamVo);
            ParamTool.refresh(SiteParamEnum.DIGICCY_PROVIDER_ACCOUNT_INFO);
        }

        return getVoMessage(sysParamVo);
    }

    @RequestMapping("/checkAliasName")
    @ResponseBody
    public boolean checkAliasName(@RequestParam("result.aliasName") String aliasName, @RequestParam("result.id") String id) {
        if (isBlank(aliasName)) {
            return false;
        }
        PayAccountListVo payAccountListVo = new PayAccountListVo();
        payAccountListVo.getQuery().setCriterions(new Criterion[]{new Criterion(PayAccount.PROP_ALIAS_NAME, Operator.EQ, aliasName), new Criterion(PayAccount.PROP_ID, Operator.NE, NumberTool.toInt(id))});
        return ServiceSiteTool.payAccountService().count(payAccountListVo) <= 0;
    }
    //endregion your codes 3

}
