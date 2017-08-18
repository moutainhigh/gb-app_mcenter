package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.math.NumberTool;
import org.soul.model.sys.po.SysParam;
import org.soul.web.session.SessionManagerBase;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.BossParamEnum;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.company.credit.po.CreditRecord;
import so.wwb.gamebox.model.company.credit.vo.CreditAccountVo;
import so.wwb.gamebox.model.company.credit.vo.CreditRecordVo;
import so.wwb.gamebox.model.company.enums.CreditAccountPayTypeEnum;
import so.wwb.gamebox.model.company.sys.po.SysSite;
import so.wwb.gamebox.model.company.sys.vo.SysSiteVo;
import so.wwb.gamebox.model.master.enums.CurrencyEnum;
import so.wwb.gamebox.web.ServiceToolBase;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by cherry on 17-8-12.
 */
@Controller
@RequestMapping("/credit/pay")
public class CreditPayController {
    private static final String CREDIT_PAY_URI = "/setting/credit/Pay";
    //默认剩余时间是24小时 以小时为单位
    public static final int DEFAULT_LEFT_TIME = 24;
    //默认比例
    public static final double DEFAULT_SCALE = 10d;

    @RequestMapping("/pay")
    public String pay(Model model) {
        //站点信息
        SysSiteVo sysSiteVo = new SysSiteVo();
        sysSiteVo.getSearch().setId(SessionManager.getSiteId());
        SysSite sysSite = ServiceToolBase.sysSiteService().get(sysSiteVo).getResult();
        model.addAttribute("profit", sysSite.getMaxProfit());
        model.addAttribute("defaultProfit", sysSite.getDefaultProfit());
        Date profitTime = sysSite.getProfitTime();
        if (profitTime != null) { //如果时间为空就说明还没有提醒无需显示倒计时
            //默认剩余时间
            SysParam leftTimeParam = ParamTool.getSysParam(BossParamEnum.SETTING_CREDIT_PROFIT_LEFT_TIME);
            int leftTime = leftTimeParam != null && StringTool.isNotBlank(leftTimeParam.getParamValue()) && NumberTool.isNumber(leftTimeParam.getParamValue()) ? NumberTool.toInt(leftTimeParam.getParamValue()) : DEFAULT_LEFT_TIME;
            Date lastTime = DateTool.addHours(profitTime, leftTime);
            //倒计时
            model.addAttribute("leftTime", DateTool.minutesBetween(lastTime, profitTime));
        }
        SysParam scaleParam = ParamTool.getSysParam(BossParamEnum.SETTING_CREDIT_SCALE);
        model.addAttribute("scaleParam", scaleParam);

        CreditAccountVo creditAccountVo = new CreditAccountVo();
        creditAccountVo.setCurrency(CurrencyEnum.CNY.getCode());
        model.addAttribute("accountMap", ServiceTool.creditAccountService().getBankAccount(creditAccountVo));
        return CREDIT_PAY_URI;
    }

    @RequestMapping("/submit")
    @ResponseBody
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
        Map<String, Object> map = new HashMap<>(1);
        map.put("state", creditRecordVo.isSuccess());
        map.put("transactionNo", creditRecordVo.getResult().getTransactionNo());
        return map;
    }

}
