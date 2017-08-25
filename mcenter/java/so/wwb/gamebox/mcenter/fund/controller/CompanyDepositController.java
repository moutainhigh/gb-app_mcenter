package so.wwb.gamebox.mcenter.fund.controller;


import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dubbo.DubboTool;
import org.soul.commons.lang.ArrayTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.query.sort.Direction;
import org.soul.model.sys.po.SysParam;
import org.soul.web.session.SessionManagerBase;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.currency.ICurrencyExchangeService;
import so.wwb.gamebox.iservice.master.fund.IPlayerRechargeService;
import so.wwb.gamebox.mcenter.enmus.ListOpEnum;
import so.wwb.gamebox.mcenter.fund.form.VPlayerDepositSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.CacheBase;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.boss.enums.TemplateCodeEnum;
import so.wwb.gamebox.model.company.setting.po.CurrencyExchangeRate;
import so.wwb.gamebox.model.company.setting.po.SysCurrency;
import so.wwb.gamebox.model.company.setting.vo.CurrencyExchangeRateVo;
import so.wwb.gamebox.model.currency.po.CurrencyRate;
import so.wwb.gamebox.model.master.dataRight.DataRightModuleType;
import so.wwb.gamebox.model.master.enums.CurrencyEnum;
import so.wwb.gamebox.model.master.fund.enums.RechargeStatusEnum;
import so.wwb.gamebox.model.master.fund.enums.RechargeTypeEnum;
import so.wwb.gamebox.model.master.fund.enums.RechargeTypeParentEnum;
import so.wwb.gamebox.model.master.fund.po.VPlayerDeposit;
import so.wwb.gamebox.model.master.fund.vo.PlayerRechargeVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerDepositListVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerDepositVo;
import so.wwb.gamebox.model.master.player.vo.PlayerTransactionVo;
import so.wwb.gamebox.web.cache.Cache;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


/**
 * 公司入款审核列表控制器
 *
 * @author fei
 *         2016-7-6 11:36:16
 */
@Controller
@RequestMapping("/fund/deposit/company")
public class CompanyDepositController extends BaseDepositController {
    private static Log LOG = LogFactory.getLog(CompanyDepositController.class);

    @Override
    protected String getViewBasePath() {
        return "/fund/deposit/company/";
    }

    @Override
    protected VPlayerDepositListVo doList(VPlayerDepositListVo listVo, VPlayerDepositSearchForm form, BindingResult result, Model model) {
        // 初始化筛选条件
        this.initQuery(listVo);
        // 初始化ListVo
        super.initListVo(listVo);
        // 公司入款声音参数
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DEPOSIT);
        model.addAttribute("realActive", sysParam.getActive());
        model.addAttribute("sysParam", sysParam);
        if (SessionManager.getCompanyVoiceNotice() != null) {
            sysParam.setActive(SessionManager.getCompanyVoiceNotice());
        }
        listVo.setTone(sysParam);
        getCurrencySign(model);

        String templateCode = TemplateCodeEnum.fund_deposit_company_check.getCode();
        model.addAttribute("searchTempCode", templateCode);
        model.addAttribute("searchTemplates", CacheBase.getSysSearchTempByCondition(SessionManagerBase.getUserId(), TemplateCodeEnum.fund_deposit_company_check.getCode()));

        String moduleType = DataRightModuleType.COMPANYDEPOSIT.getCode();
        listVo = getPlayerDeposit(listVo, moduleType, form, result, model);
        return listVo;
    }

    /**
     * 获取货币形式
     *
     * @param model
     * @return
     */
    private String getCurrencySign(Model model) {
        Map<String, SysCurrency> sysCurrency1 = Cache.getSysCurrency();
        model.addAttribute("sysCurrency", sysCurrency1);
        return null;
    }

    @Override
    protected void initQuery(VPlayerDepositListVo listVo) {
        listVo.getSearch().setRechargeTypeParent(RechargeTypeParentEnum.COMPANY_DEPOSIT.getCode());
        if (listVo.getQuery().getCriterions().length > 0) {
            listVo.getQuery().setCriterions(ArrayTool.add(listVo.getQuery().getCriterions(),
                    new Criterion(VPlayerDeposit.PROP_RECHARGE_TYPE_PARENT, Operator.EQ, listVo.getSearch().getRechargeTypeParent())));
        }
    }

    /**
     * 启用停用声音提醒
     */
    @RequestMapping({"/toneSwitch"})
    @ResponseBody
    public Map<String, Object> toneSwitch(@RequestParam("paramVal") String paramVal) {
        SessionManager.setCompanyVoiceNotice(paramVal);
        Map<String, Object> map = new HashMap<>(1, 1f);
        map.put("state", true);
        return map;//toneSwitch(SiteParamEnum.WARMING_TONE_DEPOSIT);
    }

    /**
     * 公司入款详情
     */
    @Override
    protected VPlayerDepositVo doView(VPlayerDepositVo vo, Model model) {
        vo = queryView(vo, model);
        return vo;
    }

    /**
     * 公司入款详情（审核）
     */
    @RequestMapping("/check")
    public String check(VPlayerDepositVo vo, Model model) {
        vo = queryView(vo, model);
        model.addAttribute("command", vo);
        if (RechargeTypeEnum.BITCOIN_FAST.getCode().equals(vo.getResult().getRechargeType()) && !RechargeStatusEnum.EXCHANGE.getCode().equals(vo.getResult().getRechargeStatus())) {
            PlayerTransactionVo playerTransactionVo = new PlayerTransactionVo();
            playerTransactionVo.getSearch().setId(vo.getResult().getPlayerTransactionId());
            playerTransactionVo = ServiceTool.getPlayerTransactionService().get(playerTransactionVo);
            model.addAttribute("transactionData", JsonTool.fromJson(playerTransactionVo.getResult().getTransactionData(), Map.class));
        }
        return getViewBasePath() + "Check";
    }

    /**
     * 下一条
     */
    @RequestMapping("/nextCheck")
    @ResponseBody
    public Map<String, Object> nextCheck(VPlayerDepositVo vo) {
        vo.getSearch().setRechargeStatus(RechargeStatusEnum.DEAL.getCode());
        vo.getSearch().setRechargeTypeParent(RechargeTypeParentEnum.COMPANY_DEPOSIT.getCode());
        VPlayerDeposit vPlayerDeposit = getService().nextCheckRecharge(vo);
        Map<String, Object> map = new HashMap(2, 1f);
        if (vPlayerDeposit != null) {
            map.put("state", true);
            map.put("id", vPlayerDeposit.getId());
        } else {
            map.put("state", false);
            map.put("id", vo.getSearch().getId());
        }
        return map;
    }

    /**
     * 公司入款-筛选
     */
    @RequestMapping("/filter")
    public String filter(VPlayerDepositListVo listVo, Model model) {
        listVo.getSearch().setRechargeTypeParent(RechargeTypeParentEnum.COMPANY_DEPOSIT.getCode());

        listVo = initFilter(listVo);

        model.addAttribute("filters", listVo.getOperators());
        model.addAttribute("keyClassName", ListOpEnum.CompanyDepositListVo.getClassName());
        model.addAttribute("filterList", listVo.getFilterRows());
        model.addAttribute("jsonFilterList", JsonTool.toJson(listVo.getFilterRows()));
        model.addAttribute("goFilterUrl", getViewBasePath() + "list.html");

        return FILTER_URL;
    }

    /**
     * Modified  jerry  2016-12-11
     *
     * @param vo
     * @return
     */
    @RequestMapping("/confirmCheck")
    @ResponseBody
    public Map confirmCompanyCheck(PlayerRechargeVo vo) {
        Map map = confirmCheck(vo);
//        fundCheckReminder("fund/deposit/company/confirmCheck.html",vo.getSearch().getRechargeTypeParent());
        return map;
    }

    /**
     * 兑换
     *
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping(value = "/exchange", method = RequestMethod.GET)
    public String exchange(VPlayerDepositVo vo, Model model) {
        vo = getService().get(vo);
        model.addAttribute("command", vo);
        if (vo.getResult() != null && StringTool.isNotBlank(vo.getResult().getChannelJson())) {
            model.addAttribute("channelJson", JsonTool.fromJson(vo.getResult().getChannelJson(), Map.class));
        }
        return getViewBasePath() + "Exchange";
    }

    @RequestMapping(value = "/exchange", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> exchange(VPlayerDepositVo vo) {
        LOG.info("执行存款兑换,id:{0},user:{1}", vo.getSearch().getId(), SessionManager.getUserName());
        Map<String, Object> map = new HashMap<>();
        vo = getService().get(vo);
        VPlayerDeposit playerDeposit = vo.getResult();
        if (playerDeposit == null) {
            map.put("state", false);
            return map;
        }
        if (!RechargeStatusEnum.EXCHANGE.getCode().equals(playerDeposit.getRechargeStatus())) {
            map.put("state", false);
            map.put("hasExchange", true);
            return map;
        }
        IPlayerRechargeService playerRechargeService = ServiceTool.playerRechargeService();
        //验证订单状态
        if (!playerRechargeService.checkDepositStatus(vo)) {//查询不到订单状态
            map.put("state", false);
            map.put("depositStatus", true);
            if (StringTool.isNotBlank(vo.getCheckDepositJson())) {
                map.putAll(JsonTool.fromJson(vo.getCheckDepositJson(), Map.class));
            }
            return map;
        }
        if (!queryRate(vo)) {
            map.put("state", false);
            map.put("rate", true);
            return map;
        }
        try {
            vo.setOperator(SessionManager.getUserName());
            vo.setUserId(SessionManager.getUserId());
            map = playerRechargeService.exchangeBtc(vo);
        } catch (Exception e) {
            map.put("state", false);
            LOG.error(e);
        }
        return map;
    }

    private boolean queryRate(VPlayerDepositVo vo) {
        String depositCurrency = vo.getResult().getDefaultCurrency();
        CurrencyExchangeRateVo rateVo = new CurrencyExchangeRateVo();
        rateVo.getQuery().addOrder(CurrencyExchangeRate.PROP_UPDATE_TIME, Direction.DESC);
        rateVo.getQuery().setCriterions(new Criterion[]{new Criterion(CurrencyExchangeRate.PROP_IFROM_CURRENCY, Operator.EQ, CurrencyEnum.USD.getCode()), new Criterion(CurrencyExchangeRate.PROP_ITO_CURRENCY, Operator.EQ, depositCurrency)});
        rateVo = ServiceTool.getCurrencyExchangeRateService().search(rateVo);
        CurrencyExchangeRate currencyExchangeRate = rateVo.getResult();
        CurrencyRate rate = new CurrencyRate();
        if (currencyExchangeRate == null) {
            rate = DubboTool.getService(ICurrencyExchangeService.class).usdToCurrency(depositCurrency);
            saveRate(rate, depositCurrency);
        } else {
            rate.setRateTime(currencyExchangeRate.getUpdateTime());
            rate.setAskRate(new BigDecimal(String.valueOf(currencyExchangeRate.getRate())));
            rate.setQueryTime(SessionManager.getDate().getNow());
        }
        vo.setRate(rate);
        if (rate == null || rate.getAskRate() == null) {
            return false;
        }
        return true;
    }

    private void saveRate(CurrencyRate rate, String depositCurrency) {
        if (rate == null || rate.getAskRate() == null) {
            return;
        }
        try {
            CurrencyExchangeRate currencyExchangeRate = new CurrencyExchangeRate();
            currencyExchangeRate.setIfromCurrency(CurrencyEnum.USD.getCode());
            currencyExchangeRate.setItoCurrency(depositCurrency);
            currencyExchangeRate.setUpdateTime(SessionManager.getDate().getNow());
            currencyExchangeRate.setRate(rate.getAskRate().doubleValue());
            currencyExchangeRate.setUpdateUser(SessionManager.getUserId());
            CurrencyExchangeRateVo rateVo = new CurrencyExchangeRateVo();
            rateVo.setResult(currencyExchangeRate);
            ServiceTool.getCurrencyExchangeRateService().insert(rateVo);
        } catch (Exception e) {
            LOG.error(e);
        }

    }
}