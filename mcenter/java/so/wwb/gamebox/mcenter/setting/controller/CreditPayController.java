package so.wwb.gamebox.mcenter.setting.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dubbo.DubboTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.math.NumberTool;
import org.soul.commons.net.ServletTool;
import org.soul.commons.spring.utils.SpringTool;
import org.soul.iservice.security.privilege.ISysUserRoleService;
import org.soul.model.comet.vo.MessageVo;
import org.soul.model.pay.enums.CommonFieldsConst;
import org.soul.model.pay.enums.PayApiTypeConst;
import org.soul.model.pay.vo.OnlinePayVo;
import org.soul.model.security.privilege.vo.SysUserRoleVo;
import org.soul.model.sys.po.SysParam;
import org.soul.web.session.SessionManagerBase;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.CreditRecordForm;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.BossParamEnum;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.TerminalEnum;
import so.wwb.gamebox.model.common.Const;
import so.wwb.gamebox.model.common.notice.enums.CometSubscribeType;
import so.wwb.gamebox.model.company.credit.po.CreditAccount;
import so.wwb.gamebox.model.company.credit.po.CreditRecord;
import so.wwb.gamebox.model.company.credit.vo.CreditAccountVo;
import so.wwb.gamebox.model.company.credit.vo.CreditRecordVo;
import so.wwb.gamebox.model.company.enums.CreditAccountPayTypeEnum;
import so.wwb.gamebox.model.company.enums.CreditRecordStatusEnum;
import so.wwb.gamebox.model.company.sys.po.SysSite;
import so.wwb.gamebox.model.company.sys.po.VSysSiteDomain;
import so.wwb.gamebox.model.company.sys.vo.SysSiteVo;
import so.wwb.gamebox.model.master.enums.CurrencyEnum;
import so.wwb.gamebox.web.ServiceToolBase;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;
import so.wwb.gamebox.web.credit.CreditHelper;

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
        //站点信息
        SysSiteVo sysSiteVo = new SysSiteVo();
        sysSiteVo.getSearch().setId(SessionManager.getSiteId());
        SysSite sysSite = ServiceToolBase.sysSiteService().get(sysSiteVo).getResult();
        model.addAttribute("profit", sysSite.getMaxProfit());
        model.addAttribute("defaultProfit", sysSite.getDefaultProfit());
        double transferOutSum = sysSite.getTransferOutSum() == null ? 0 : sysSite.getTransferOutSum();
        double transferIntoSum = sysSite.getTransferIntoSum() == null ? 0 : sysSite.getTransferIntoSum();
        //转入api余额扣除（转出到api金额-转入到钱包余额）
        model.addAttribute("transferLimit", transferOutSum - transferIntoSum);
        model.addAttribute("currentTransferLimit", sysSite.getCurrentTransferLimit());
        model.addAttribute("defaultTransferLimit", sysSite.getDefaultTransferLimit());
        Date profitTime = sysSite.getProfitTime();
        Date transferTime = sysSite.getTransferLimitTime();
        if (profitTime != null || transferTime != null) { //如果时间为空就说明还没有提醒无需显示倒计时
            Date time;
            if (profitTime == null || (transferTime != null && profitTime.getTime() >= transferTime.getTime())) {
                time = transferTime;
            } else {
                time = profitTime;
            }
            //默认剩余时间
            SysParam leftTimeParam = ParamTool.getSysParam(BossParamEnum.SETTING_CREDIT_PROFIT_LEFT_TIME);
            int leftTime = leftTimeParam != null && StringTool.isNotBlank(leftTimeParam.getParamValue()) && NumberTool.isNumber(leftTimeParam.getParamValue()) ? NumberTool.toInt(leftTimeParam.getParamValue()) : DEFAULT_LEFT_TIME;
            Date lastTime = DateTool.addHours(time, leftTime);
            //倒计时
            model.addAttribute("leftTime", DateTool.minutesBetween(lastTime, SessionManager.getDate().getNow()));
        }
        SysParam scaleParam = ParamTool.getSysParam(BossParamEnum.SETTING_CREDIT_SCALE);
        model.addAttribute("scaleParam", scaleParam);

        CreditAccountVo creditAccountVo = new CreditAccountVo();
        creditAccountVo.setCurrency(CurrencyEnum.CNY.getCode());
        model.addAttribute("accountMap", ServiceTool.creditAccountService().getBankAccount(creditAccountVo));
        model.addAttribute("validateRule", JsRuleCreator.create(CreditRecordForm.class));
        model.addAttribute("useProfit", CreditHelper.getProfit(SessionManager.getSiteId(), CommonContext.get().getSiteTimeZone()));
        model.addAttribute("disableTransfer", ParamTool.disableTransfer(SessionManager.getSiteId()));
        return CREDIT_PAY_URI;
    }

    @RequestMapping("/submit")
    @ResponseBody
    @Token(valid = true)
    public Map<String, Object> submit(CreditRecordVo creditRecordVo) {
        CreditRecord creditRecord = creditRecordVo.getResult();
        creditRecord.setIp(SessionManager.getIpDb().getIp());
        creditRecord.setIpDictCode(SessionManagerBase.getIpDictCode());
        //买分默认使用人民币 不区分站长的主货币是什么币种
        creditRecord.setCurrency(CurrencyEnum.CNY.getCode());
        SysParam scaleParam = ParamTool.getSysParam(BossParamEnum.SETTING_CREDIT_SCALE);
        if (scaleParam != null && StringTool.isNotBlank(scaleParam.getParamValue()) && NumberTool.isNumber(scaleParam.getParamValue())) {
            creditRecord.setPayScale(NumberTool.toDouble(scaleParam.getParamValue()));
        } else {
            creditRecord.setPayScale(DEFAULT_SCALE);
        }
        creditRecord.setPayUserId(SessionManager.getUserId());
        creditRecord.setSiteId(SessionManager.getSiteId());
        creditRecord.setPayUserName(SessionManager.getUserName());
        creditRecord.setPayType(CreditAccountPayTypeEnum.CASH_PLEDGE.getCode());
        creditRecordVo = ServiceTool.creditRecordService().saveCreditRecord(creditRecordVo);
        Map<String, Object> map = new HashMap<>(3, 1l);
        if (!creditRecordVo.isSuccess()) {
            map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
        } else {
            //通知boss用户
            sendMessage(creditRecord);
        }
        map.put("state", creditRecordVo.isSuccess());
        map.put("transactionNo", creditRecordVo.getResult().getTransactionNo());
        return map;
    }

    /**
     * 调用第三方接口
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
        VSysSiteDomain siteDomain = Cache.getSiteDomain().get(domain);
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
        List<Integer> userIdList = DubboTool.getService(ISysUserRoleService.class).findUserIdByUrl(sysUserRoleVo);
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
}
