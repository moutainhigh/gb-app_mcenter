package so.wwb.gamebox.mcenter.setting.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import org.apache.commons.collections.map.HashedMap;
import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.math.NumberTool;
import org.soul.commons.net.ServletTool;
import org.soul.commons.spring.utils.SpringTool;
import org.soul.model.comet.vo.MessageVo;
import org.soul.model.log.audit.enums.OpType;
import org.soul.model.pay.enums.CommonFieldsConst;
import org.soul.model.pay.enums.PayApiTypeConst;
import org.soul.model.pay.vo.OnlinePayVo;
import org.soul.model.security.privilege.vo.SysUserRoleVo;
import org.soul.web.session.SessionManagerBase;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.CreditRecordForm;
import so.wwb.gamebox.model.*;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.common.Const;
import so.wwb.gamebox.model.common.notice.enums.CometSubscribeType;
import so.wwb.gamebox.model.company.credit.po.CreditAccount;
import so.wwb.gamebox.model.company.credit.po.CreditRecord;
import so.wwb.gamebox.model.company.credit.po.SysSiteCredit;
import so.wwb.gamebox.model.company.credit.po.VSysCredit;
import so.wwb.gamebox.model.company.credit.vo.CreditAccountVo;
import so.wwb.gamebox.model.company.credit.vo.CreditRecordVo;
import so.wwb.gamebox.model.company.credit.vo.SysSiteCreditVo;
import so.wwb.gamebox.model.company.credit.vo.VSysCreditVo;
import so.wwb.gamebox.model.company.enums.CreditAccountPayTypeEnum;
import so.wwb.gamebox.model.company.enums.CreditRecordStatusEnum;
import so.wwb.gamebox.model.company.setting.vo.CurrencyExchangeRateVo;
import so.wwb.gamebox.model.company.sys.po.VSysSiteDomain;
import so.wwb.gamebox.model.company.sys.vo.SysSiteVo;
import so.wwb.gamebox.model.master.enums.CurrencyEnum;
import so.wwb.gamebox.web.BussAuditLogTool;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by cherry on 17-8-12.
 */
@Controller
@RequestMapping("/credit/pay")
public class CreditPayController {
    private static final String CREDIT_PAY_URI = "/setting/credit/Pay";
    //默认剩余时间是24小时 以小时为单位
    private static final int DEFAULT_LEFT_TIME = 24;
    //默认比例
    private static final double DEFAULT_SCALE = 10d;

    private static final String CREDIT_RECORD_URL = "creditRecord/index.html";

    private static final Log LOG = LogFactory.getLog(CreditPayController.class);

    @RequestMapping("/pay")
    @Token(generate = true)
    public String pay(Model model) {
        addPayLog(null);
        //站点信息
        SysSiteCreditVo sysSiteCreditVo = new SysSiteCreditVo();
        sysSiteCreditVo.getSearch().setId(SessionManager.getSiteId());
        SysSiteCredit sysSiteCredit = ServiceTool.sysSiteCreditService().get(sysSiteCreditVo).getResult();
        if (sysSiteCredit.getCreditLine() == null) {
            sysSiteCredit.setCreditLine(0.0);
        }
        if (sysSiteCredit.getCreditLine() != null) {
            model.addAttribute("profit", sysSiteCredit.getMaxProfit() + sysSiteCredit.getCreditLine());
        } else {
            model.addAttribute("profit", sysSiteCredit.getMaxProfit());
        }
        model.addAttribute("creditLine", sysSiteCredit.getCreditLine());
        double defaultProfit = sysSiteCredit.getDefaultProfit() == null ? 0d : sysSiteCredit.getDefaultProfit();
        model.addAttribute("defaultProfit", defaultProfit / 10000);
        double transferOutSum = sysSiteCredit.getTransferOutSum() == null ? 0 : sysSiteCredit.getTransferOutSum();
        double transferIntoSum = sysSiteCredit.getTransferIntoSum() == null ? 0 : sysSiteCredit.getTransferIntoSum();
        //转入api余额扣除（转出到api金额-转入到钱包余额）
        model.addAttribute("transferLimit", transferOutSum - transferIntoSum);
        Double transferLimit = sysSiteCredit.getCurrentTransferLimit() == null ? 0d : sysSiteCredit.getCurrentTransferLimit();
        if (sysSiteCredit.getTransferLine() != null) {
            model.addAttribute("currentTransferLimit", transferLimit + sysSiteCredit.getTransferLine());
        } else {
            model.addAttribute("currentTransferLimit", transferLimit);
        }
        double defaultTransferLimit = sysSiteCredit.getDefaultTransferLimit() == null ? 0d : sysSiteCredit.getDefaultTransferLimit();
        model.addAttribute("defaultTransferLimit", defaultTransferLimit / 10000);
        Date profitTime = sysSiteCredit.getProfitTime();
        Date transferTime = sysSiteCredit.getTransferLimitTime();
        if (profitTime != null || transferTime != null) { //如果时间为空就说明还没有提醒无需显示倒计时
            Date time;
            if (profitTime == null || (transferTime != null && profitTime.getTime() >= transferTime.getTime())) {
                time = transferTime;
            } else {
                time = profitTime;
            }
            //倒计时
            model.addAttribute("leftTime", DateTool.secondsBetween(time, SessionManager.getDate().getNow()));
        }
        /*SysParam scaleParam = ParamTool.getSysParam(BossParamEnum.SETTING_CREDIT_SCALE);
        model.addAttribute("scaleParam", scaleParam);*/
        model.addAttribute("profitRatio", sysSiteCredit.getProfitRatio());
        model.addAttribute("transferRatio", sysSiteCredit.getTransferRatio());
        CreditAccountVo creditAccountVo = new CreditAccountVo();
        creditAccountVo.setCurrency(CurrencyEnum.CNY.getCode());
        creditAccountVo.getSearch().setUseSites(SessionManager.getSiteId().toString());
        getAuthorizeStatus(model);//获取授权状态
        model.addAttribute("accountMap", ServiceTool.creditAccountService().getBankAccount(creditAccountVo));
        model.addAttribute("validateRule", JsRuleCreator.create(CreditRecordForm.class));
        model.addAttribute("useProfit", sysSiteCredit.getHasUseProfit() == null ? 0d : sysSiteCredit.getHasUseProfit());//CreditHelper.getProfit(SessionManager.getSiteId(), CommonContext.get().getSiteTimeZone()));
        model.addAttribute("disableTransfer", ParamTool.disableTransfer(SessionManager.getSiteId()));
        model.addAttribute("PAY_LIMIT_PERSENT", VSysCredit.PAY_LIMIT_PERSENT);
        return CREDIT_PAY_URI;
    }

    private void getAuthorizeStatus(Model model) {
        VSysCreditVo vSysCreditVo = new VSysCreditVo();
        vSysCreditVo.getSearch().setId(SessionManager.getSiteId());
        vSysCreditVo = ServiceTool.vSysCreditService().get(vSysCreditVo);
        model.addAttribute("authorizeStatus", vSysCreditVo.getResult().getAuthorizeStatus());
    }

    @RequestMapping("/submit")
    @ResponseBody
    @Token(valid = true)
    @Audit(module = Module.MASTER_SETTING, moduleType = ModuleType.MASTER_SETTING_CREDITPAY_SUCCESS, opType = OpType.UPDATE)
    public Map<String, Object> submit(HttpServletRequest request, CreditRecordVo creditRecordVo) {
        CreditRecord creditRecord = creditRecordVo.getResult();
        creditRecord.setIp(SessionManager.getIpDb().getIp());
        creditRecord.setIpDictCode(SessionManagerBase.getIpDictCode());
        //买分默认使用人民币 不区分站长的主货币是什么币种
        creditRecord.setCurrency(CurrencyEnum.CNY.getCode());
        /*SysParam scaleParam = ParamTool.getSysParam(BossParamEnum.SETTING_CREDIT_SCALE);
        if (scaleParam != null && StringTool.isNotBlank(scaleParam.getParamValue()) && NumberTool.isNumber(scaleParam.getParamValue())) {
            creditRecord.setPayScale(NumberTool.toDouble(scaleParam.getParamValue()));
        } else {
            creditRecord.setPayScale(DEFAULT_SCALE);
        }*/
        SysSiteCreditVo sysSiteCreditVo = new SysSiteCreditVo();
        sysSiteCreditVo.getSearch().setId(SessionManager.getSiteId());
        sysSiteCreditVo = ServiceTool.sysSiteCreditService().get(sysSiteCreditVo);
        SysSiteCredit sysSiteCredit = sysSiteCreditVo.getResult();
        if (sysSiteCredit.getProfitRatio() != null) {
            creditRecord.setPayScale(sysSiteCredit.getProfitRatio());
        } else {
            creditRecord.setPayScale(DEFAULT_SCALE);
        }
        if (sysSiteCredit.getTransferRatio() != null) {
            creditRecord.setTransferScale(sysSiteCredit.getTransferRatio());
        } else {
            creditRecord.setTransferScale(20d);
        }
        creditRecord.setPayUserId(SessionManager.getUserId());
        creditRecord.setSiteId(SessionManager.getSiteId());
        creditRecord.setPayUserName(SessionManager.getUserName());
        creditRecord.setPayType(CreditAccountPayTypeEnum.CASH_PLEDGE.getCode());
        setExchangeRate(creditRecord);
        creditRecordVo = ServiceTool.creditRecordService().saveCreditRecord(creditRecordVo);
        Map<String, Object> map = new HashMap<>(3, 1l);
        if (!creditRecordVo.isSuccess()) {
            map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
        } else {
            //通知boss用户
            sendMessage(creditRecord);
            String creditPayUrl = creditPayUrl(request, creditRecordVo.getCreditAccount(), creditRecordVo);
            map.put("payUrl", creditPayUrl);
        }
        map.put("state", creditRecordVo.isSuccess());
        map.put("transactionNo", creditRecordVo.getResult().getTransactionNo());
        //日志
        addPayLog(creditRecordVo);
        return map;
    }

    /**
     * 　充值记录日志
     *
     * @param creditRecordVo
     */
    private void addPayLog(CreditRecordVo creditRecordVo) {
        LOG.info("进入额度充值日志方法addPayLog");
        String bankCode = "";
        Double amount = 0D;
        try {
            if (creditRecordVo.isSuccess() && creditRecordVo.getResult() != null) {
                bankCode = creditRecordVo.getResult().getBankName();
                amount = creditRecordVo.getResult().getPayAmount();
                Map<String, String> dictMapByEnum = I18nTool.getDictMapByEnum(SessionManager.getLocale(), DictEnum.BANKNAME);
                if (dictMapByEnum != null && dictMapByEnum.get(bankCode) != null) {
                    BussAuditLogTool.addLog("MASTER_SETTING_CREDITPAY_SUCCESS",
                            dictMapByEnum.get(bankCode), amount.toString());
                }
            }
        } catch (Exception ex) {
            LOG.info("添加额度充值日志报错:bankCode:{0},金额：{1}", bankCode, amount);
        }
    }

    /**
     * 设置汇率
     */
    private void setExchangeRate(CreditRecord creditRecord) {
        SysSiteVo sysSiteVo = new SysSiteVo();
        sysSiteVo.getSearch().setId(creditRecord.getSiteId());
        sysSiteVo = ServiceTool.sysSiteService().get(sysSiteVo);
        String mainCurrency = sysSiteVo.getResult().getMainCurrency();
        //如果是日语站的话,设置汇率
        if (CurrencyEnum.JPY.getCode().equals(mainCurrency)) {
            CurrencyExchangeRateVo currencyExchangeRateVo = new CurrencyExchangeRateVo();
            currencyExchangeRateVo.getSearch().setIfromCurrency(CurrencyEnum.CNY.getCode());
            currencyExchangeRateVo.getSearch().setItoCurrency(CurrencyEnum.JPY.getCode());
            currencyExchangeRateVo = ServiceTool.getCurrencyExchangeRateService().getExchangeRate(currencyExchangeRateVo);
            creditRecord.setExchangeRate(currencyExchangeRateVo.getResult().getRate());
        }
        return;
    }

    private String creditPayUrl(HttpServletRequest request, CreditAccount creditAccount, CreditRecordVo creditRecordVo) {
        List<Map<String, String>> accountJson = JsonTool.fromJson(creditAccount.getChannelJson(), new TypeReference<ArrayList<Map<String, String>>>() {
        });
        String domain = ServletTool.getDomainPath(request);
        for (Map<String, String> map : accountJson) {
            if (map.get("column").equals(CommonFieldsConst.PAYDOMAIN)) {
                domain = map.get("value");
                break;
            }
        }
        String url = "";
        if (domain != null) {
            CreditRecord creditRecord = creditRecordVo.getResult();
            String uri = "/creditPay/toPay.html?search.transactionNo=" + creditRecord.getTransactionNo() + "&origin=" + TerminalEnum.PC.getCode();
            domain = getDomain(domain, creditAccount);
            url = domain + uri;
            //添加支付网址
            creditRecord.setPayUrl(domain);
            creditRecordVo.setProperties(CreditRecord.PROP_PAY_URL);
            ServiceTool.creditRecordService().updateOnly(creditRecordVo);
        }
        return url;
    }

    /**
     * 调用第三方接口
     * todo::by cherry will to del
     *
     * @param creditRecordVo
     * @param response
     * @param request
     */
    @RequestMapping("/callOnline")
    public void callOnline(CreditRecordVo creditRecordVo, HttpServletResponse response, HttpServletRequest request) {
        if (StringTool.isBlank(creditRecordVo.getSearch().getTransactionNo())) {
            return;
        }
        try {
            CreditRecord creditRecord = ServiceTool.creditRecordService().queryCreditRecord(creditRecordVo);
            creditRecordVo.setResult(creditRecord);
            CreditAccount creditAccount = getCreditAccount(creditRecord.getCredictAccountId());
            List<Map<String, String>> accountJson = JsonTool.fromJson(creditAccount.getChannelJson(), new TypeReference<ArrayList<Map<String, String>>>() {
            });

            String domain = ServletTool.getDomainPath(request);
            for (Map<String, String> map : accountJson) {
                if (map.get("column").equals(CommonFieldsConst.PAYDOMAIN)) {
                    domain = map.get("value");
                    break;
                }
            }

            if (domain != null && CreditRecordStatusEnum.DEAL.getCode().equals(creditRecord.getStatus())) {
                String uri = "/creditPay/toPay.html?search.transactionNo=" + creditRecord.getTransactionNo() + "&origin=" + TerminalEnum.PC.getCode();
                domain = getDomain(domain, creditAccount);
                String url = domain + uri;
                //添加支付网址
                creditRecord.setPayUrl(domain);
                creditRecordVo.setProperties(CreditRecord.PROP_PAY_URL);
                ServiceTool.creditRecordService().updateOnly(creditRecordVo);
                response.sendRedirect(url);
            }
        } catch (Exception e) {
            LOG.error(e);
        }
    }

    public String getDomain(String domain, CreditAccount creditAccount) {
        domain = domain.replace("http://", "");
        VSysSiteDomain siteDomain = Cache.getSiteDomain(domain);
        Boolean sslEnabled = false;
        if (siteDomain != null && siteDomain.getSslEnabled() != null && siteDomain.getSslEnabled()) {
            sslEnabled = true;
        }
        String sslDomain = "https://" + domain;
        String notSslDomain = "http://" + domain;
        ;
        if (!sslEnabled) {
            return notSslDomain;
        }
        try {
            OnlinePayVo onlinePayVo = new OnlinePayVo();
            onlinePayVo.setChannelCode(creditAccount.getBankCode());
            onlinePayVo.setApiType(PayApiTypeConst.PAY_SSL_ENABLE);
            sslEnabled = ServiceTool.onlinePayService().getSslEnabled(onlinePayVo);
        } catch (Exception e) {
            LOG.error(e);
        }
        if (sslEnabled) {
            return sslDomain;
        }
        return notSslDomain;
    }

    /**
     * 存款消息提醒发送消息给前端
     *
     * @param creditRecord
     */
    private void sendMessage(CreditRecord creditRecord) {
        if (creditRecord == null || creditRecord.getId() == null) {
            return;
        }
        //推送消息给前端
        MessageVo message = new MessageVo();
        message.setSubscribeType(CometSubscribeType.BOSS_CREDIT_PAY_REMINDER.getCode());
        Map<String, Object> map = new HashMap<>(3, 1f);
        map.put("date", creditRecord.getCreateTime() == null ? new Date() : creditRecord.getCreateTime());
        map.put("amount", CurrencyTool.formatCurrency(creditRecord.getPayAmount()));
        map.put("transactionNo", creditRecord.getTransactionNo());
        map.put("siteId", SessionManager.getSiteId());
        map.put("siteName", SessionManager.getSiteName(SpringTool.getRequest()));
        message.setMsgBody(JsonTool.toJson(map));
        message.setSendToUser(true);
        message.setSiteId(Const.BOSS_DATASOURCE_ID);
        message.setUserIdList(findUserIdByUrl());
        ServiceTool.messageService().sendToBossMsg(message);
    }

    private List<String> findUserIdByUrl() {
        SysUserRoleVo sysUserRoleVo = new SysUserRoleVo();
        sysUserRoleVo.setUrl(CREDIT_RECORD_URL);
        sysUserRoleVo._setDataSourceId(Const.BOSS_DATASOURCE_ID);
        List<Integer> userIdList = ServiceTool.sysUserRoleService().findUserIdByUrl(sysUserRoleVo);
        List<String> userIds = new ArrayList<>();
        for (Integer id : userIdList) {
            if (id != null) {
                userIds.add(String.valueOf(id));
            }
        }
        userIds.add(String.valueOf(Const.MASTER_BUILT_IN_ID));
        return userIds;
    }

    private CreditAccount getCreditAccount(Integer id) {
        CreditAccountVo creditAccountVo = new CreditAccountVo();
        creditAccountVo.getSearch().setId(id);
        creditAccountVo = ServiceTool.creditAccountService().get(creditAccountVo);
        return creditAccountVo.getResult();
    }

    /**
     * 验证支付金额
     *
     * @param resultPayAmount
     * @param bankName
     * @return
     */
    @RequestMapping("/checkPayAmount")
    @ResponseBody
    public boolean checkPayAmount(@RequestParam("result.payAmount") String resultPayAmount, @RequestParam("result.bankName") String bankName) {
        if (StringTool.isBlank(resultPayAmount) || !NumberTool.isNumber(resultPayAmount)) {
            return false;
        }
        CreditAccountVo creditAccountVo = new CreditAccountVo();
        creditAccountVo.setCurrency(CurrencyEnum.CNY.getCode());
        creditAccountVo.setBankCode(bankName);
        creditAccountVo.getSearch().setUseSites(SessionManager.getSiteId().toString());
        CreditAccount creditAccount = ServiceTool.creditAccountService().getCreditPayAccount(creditAccountVo);
        if (creditAccount == null) {
            return false;
        }
        Double payAmount = NumberTool.toDouble(resultPayAmount);
        if (creditAccount.getSingleDepositMin() != null && creditAccount.getSingleDepositMin() > payAmount) {
            return false;
        }
        if (creditAccount.getSingleDepositMax() != null && creditAccount.getSingleDepositMax() < payAmount) {
            return false;
        }
        return true;
    }

    @RequestMapping(value = "disableTransfer")
    @ResponseBody
    public Map disableTransfer(SysSiteCreditVo sysSiteCreditVo) {
        Map resMap = new HashedMap(2, 1f);
        try {
            Integer siteId = SessionManager.getSiteId();
            sysSiteCreditVo.getSearch().setId(siteId);
            sysSiteCreditVo = ServiceTool.sysSiteCreditService().openDisableTransfer(sysSiteCreditVo);
            resMap.put("state", sysSiteCreditVo.isSuccess());
            if (!sysSiteCreditVo.isSuccess()) {
                resMap.put("msg", "开启禁用转账功能失败");
            }
        } catch (Exception ex) {
            resMap.put("state", false);
            resMap.put("msg", "开启禁用转账功能异常");
            LOG.error(ex, "开启禁用转账功能异常");
        }

        return resMap;
    }
}
