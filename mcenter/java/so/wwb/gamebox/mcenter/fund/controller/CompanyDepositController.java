package so.wwb.gamebox.mcenter.fund.controller;


import org.soul.commons.collections.CollectionTool;
import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.lang.ArrayTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateFormat;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.IpTool;
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
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.fund.IPlayerRechargeService;
import so.wwb.gamebox.mcenter.enmus.ListOpEnum;
import so.wwb.gamebox.mcenter.fund.form.VPlayerDepositSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
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
import so.wwb.gamebox.model.master.enums.DepositWayEnum;
import so.wwb.gamebox.model.master.fund.enums.RechargeStatusEnum;
import so.wwb.gamebox.model.master.fund.enums.RechargeTypeEnum;
import so.wwb.gamebox.model.master.fund.enums.RechargeTypeParentEnum;
import so.wwb.gamebox.model.master.fund.po.VPlayerDeposit;
import so.wwb.gamebox.model.master.fund.vo.PlayerRechargeVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerDepositListVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerDepositVo;
import so.wwb.gamebox.model.master.player.vo.PlayerTransactionVo;
import so.wwb.gamebox.web.IpRegionTool;
import so.wwb.gamebox.web.SessionManagerCommon;
import so.wwb.gamebox.web.cache.Cache;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.*;


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

    @RequestMapping("/doData")
    @ResponseBody
    protected VPlayerDepositListVo doData(VPlayerDepositListVo listVo, VPlayerDepositSearchForm form, BindingResult result, Model model) {
        // 初始化筛选条件
        this.initQuery(listVo);
        this.initListVo(listVo);
        // 公司入款声音参数
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DEPOSIT);
        if(sysParam!=null){
            model.addAttribute("realActive", sysParam.getActive());
            model.addAttribute("sysParam", sysParam);
            if (SessionManager.getCompanyVoiceNotice() != null) {
                sysParam.setActive(SessionManager.getCompanyVoiceNotice());
            }
            listVo.setTone(sysParam);

        }
        getCurrencySign(model);
        String moduleType = DataRightModuleType.COMPANYDEPOSIT.getCode();
        listVo = getPlayerDeposit(listVo, moduleType, form, result, model);
        handleTempleData(listVo);
        return listVo;
    }

    protected VPlayerDepositListVo doList(VPlayerDepositListVo listVo, VPlayerDepositSearchForm form, BindingResult result, Model model) {
        String moduleType = DataRightModuleType.COMPANYDEPOSIT.getCode();
        return super.doList(listVo, moduleType, form, result, model);
    }

    /**
     * 处理页面模板化数据
     * @param listVo
     */
    private void handleTempleData(VPlayerDepositListVo listVo) {
        if (CollectionTool.isNotEmpty(listVo.getResult())) {
            List<VPlayerDeposit> result = listVo.getResult();
            DateFormat dateFormat = new DateFormat();
            TimeZone timeZone = SessionManagerCommon.getTimeZone();
            Locale locale = SessionManagerCommon.getLocale();
            Map<String, Map<String, String>> views = I18nTool.getI18nMap(SessionManagerCommon.getLocale().toString()).get("views");
            Map<String, Map<String, Map<String, String>>> dictsMap = I18nTool.getDictsMap(SessionManagerCommon.getLocale().toString());
            Map<String, SysCurrency> sysCurrencys = Cache.getSysCurrency();
            for (VPlayerDeposit deposit : result) {
                String url = RechargeStatusEnum.DEAL.getCode().equals(deposit.getRechargeStatus()) ?
                        "/fund/deposit/company/check.html?search.id=" + deposit.getId() : "/fund/deposit/company/view.html?search.id=" + deposit.getId();
                deposit.set_url(url);
                deposit.set_soulFn_formatDateTz_createTime(LocaleDateTool.formatDate(deposit.getCreateTime(), dateFormat.getDAY_SECOND(),timeZone));
                deposit.set_soulFn_formatTimeMemo_createTime(LocaleDateTool.formatTimeMemo(deposit.getCreateTime(), locale));
                deposit.set_soulFn_formatDateTz_checkTime(LocaleDateTool.formatDate(deposit.getCheckTime(), dateFormat.getDAY_SECOND(),timeZone));
                deposit.set_soulFn_formatTimeMemo_checkTime(LocaleDateTool.formatTimeMemo(deposit.getCheckTime(), locale));
                deposit.set_dicts_common_bankname_bankCode(dictsMap.get("common").get("bankname").get(deposit.getBankCode()));
                String rechargeType = deposit.getRechargeType();
                deposit.set_recharge_type_dict(dictsMap.get("fund").get("recharge_type").get(rechargeType));
                String fundAutoData = getFundAutoData(deposit,views);
                if(StringTool.isNotBlank(deposit.getBankOrder())&& !DepositWayEnum.BITCOIN_FAST.getCode().equals(rechargeType)){
                    if(DepositWayEnum.ALIPAY_FAST.getCode().equals(rechargeType)||DepositWayEnum.WECHATPAY_FAST.getCode().equals(rechargeType)||
                            DepositWayEnum.QQWALLET_FAST.getCode().equals(rechargeType)||
                            DepositWayEnum.JDWALLET_FAST.getCode().equals(rechargeType)||DepositWayEnum.BDWALLET_FAST.getCode().equals(rechargeType)||
                            DepositWayEnum.ONECODEPAY_FAST.getCode().equals(rechargeType)||DepositWayEnum.OTHER_FAST.getCode().equals(rechargeType)){
                        String data = views.get("fund_auto").get("订单尾号");
                        deposit.set_bankOrder_data(data);
                    }
                }
                deposit.set_fund_auto_data(fundAutoData);
                SysCurrency sysCurrency = sysCurrencys.get(deposit.getDefaultCurrency());
                String currencySign = (sysCurrency!=null)?sysCurrency.getCurrencySign():"";
                deposit.set_currencySign(currencySign);
                deposit.set_soulFn_formatInteger_favorableTotalAmount(CurrencyTool.formatInteger(deposit.getFavorableTotalAmount()));
                deposit.set_soulFn_formatDecimals_favorableTotalAmount(CurrencyTool.formatDecimals(deposit.getFavorableTotalAmount()));
                deposit.set_soulFn_formatInteger_counterFee(CurrencyTool.formatInteger(deposit.getCounterFee()));
                deposit.set_soulFn_formatDecimals_counterFee(CurrencyTool.formatDecimals(deposit.getCounterFee()));
                deposit.set_soulFn_formatInteger_rechargeAmount(CurrencyTool.formatInteger(deposit.getRechargeAmount()));
                deposit.set_soulFn_formatDecimals_rechargeAmount(CurrencyTool.formatDecimals(deposit.getRechargeAmount()));
                deposit.set_bitAmount_formatNumber(getBitFormat(deposit));
                deposit.set_recharge_status_dicts(dictsMap.get("fund").get("recharge_status").get(deposit.getRechargeStatus()));
                deposit.set_ipDeposit_ipv4LongToString(IpTool.ipv4LongToString(deposit.getIpDeposit()));
                String ipDictCode = deposit.getIpDictCode();
                if(StringTool.isNotBlank(ipDictCode)){
                    deposit.set_gbFn_getIpRegion_ipDictCode(IpRegionTool.getIpRegion(ipDictCode));
                }
                String checkRemark = deposit.getCheckRemark();
                if(StringTool.isNotBlank(checkRemark)){
                    deposit.set_checkRemark_length(StringTool.length(checkRemark));
                    if(checkRemark.length()>20){
                        deposit.set_checkRemark_sub(checkRemark.substring(0,20));
                    }
                }
            }
        }
    }

    /**
     * 获取bition的格式
     * @param deposit
     * @return
     */
    private String getBitFormat(VPlayerDeposit deposit) {
        DecimalFormat BONUS = new DecimalFormat("#.########");
        Double bitAmount = deposit.getBitAmount();
        String format ="0.0";
        if(bitAmount!=null){
            BigDecimal bd = new BigDecimal(String.valueOf(bitAmount));
            format= BONUS.format(bd.setScale(8, BigDecimal.ROUND_DOWN));
        }
        return format;
    }

    /**
     * 获取资金类型翻译
     * @param deposit
     * @param views
     * @return
     */
    private String getFundAutoData(VPlayerDeposit deposit, Map<String, Map<String, String>> views) {
        String rechargeType = deposit.getRechargeType();
        Map<String, String> fund_auto = views.get("fund_auto");
        switch (rechargeType){
            case "wechatpay_fast":
                return fund_auto.get("微信账号");
            case "alipay_fast":
                return fund_auto.get("支付宝账号");
            case "qqwallet_fast":
                return fund_auto.get("QQ钱包账号");
            case "jdwallet_fast":
                return fund_auto.get("京东钱包账号");
            case "bdwallet_fast":
                return fund_auto.get("百度钱包账号");
            case "onecodepay_fast":
                return fund_auto.get("一码付账号");
            case "other_fast":
                return fund_auto.get("其他电子账号");
            case "bitcoin_fast":
                return fund_auto.get("比特币地址");
        }

        return rechargeType;
    }

    @RequestMapping("/count")
    public String count(VPlayerDepositListVo listVo,Model model, String isCounter) {
        String moduleType = DataRightModuleType.COMPANYDEPOSIT.getCode();
        return super.count(listVo, moduleType, model, isCounter);
    }

    /**
     * 获取货币形式
     *
     * @param model
     * @return
     */
    private void getCurrencySign(Model model) {
        Map<String, SysCurrency> sysCurrency1 = Cache.getSysCurrency();
        model.addAttribute("sysCurrency", sysCurrency1);
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
        vo.setAcbKeyParam(ParamTool.getSysParam(SiteParamEnum.SITE_PAY_KEY));
        Map map = confirmCheck(vo);
//        fundCheckReminder("fund/deposit/company/confirmCheck.html",vo.getSearch().getRechargeTypeParent());
        //取消上分订单
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
        CurrencyRate rate = queryRate(vo);
        if (rate == null || rate.getAskRate() == null) {
            map.put("state", false);
            map.put("rate", true);
            return map;
        }
        vo.setRate(rate);
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

    private CurrencyRate queryRate(VPlayerDepositVo vo) {
        String depositCurrency = vo.getResult().getDefaultCurrency();
        CurrencyExchangeRateVo rateVo = new CurrencyExchangeRateVo();
        rateVo.getQuery().addOrder(CurrencyExchangeRate.PROP_UPDATE_TIME, Direction.DESC);
        rateVo.getQuery().setCriterions(new Criterion[]{new Criterion(CurrencyExchangeRate.PROP_IFROM_CURRENCY, Operator.EQ, CurrencyEnum.USD.getCode()), new Criterion(CurrencyExchangeRate.PROP_ITO_CURRENCY, Operator.EQ, depositCurrency)});
        rateVo = ServiceTool.getCurrencyExchangeRateService().search(rateVo);
        CurrencyExchangeRate currencyExchangeRate = rateVo.getResult();
        CurrencyRate rate = new CurrencyRate();
        if (currencyExchangeRate == null) {
            rate = ServiceTool.currencyExchangeService().usdToCurrency(depositCurrency);
            saveRate(currencyExchangeRate, rate, depositCurrency);
        } else if (currencyExchangeRate.getUpdateTime().getTime() < SessionManager.getDate().getToday().getTime()) {
            rate = ServiceTool.currencyExchangeService().usdToCurrency(depositCurrency);
            if (rate == null) {
                LOG.info("更新汇率失败,用数据库原有汇率{0}", vo.getResult().getTransactionNo());
                rate = new CurrencyRate();
                rate.setRateTime(currencyExchangeRate.getUpdateTime());
                rate.setAskRate(new BigDecimal(String.valueOf(currencyExchangeRate.getRate())));
                rate.setQueryTime(SessionManager.getDate().getNow());
            } else {
                saveRate(currencyExchangeRate, rate, depositCurrency);
            }
        } else {
            rate.setRateTime(currencyExchangeRate.getUpdateTime());
            rate.setAskRate(new BigDecimal(String.valueOf(currencyExchangeRate.getRate())));
            rate.setQueryTime(SessionManager.getDate().getNow());
        }
        return rate;
    }

    private void saveRate(CurrencyExchangeRate currencyExchangeRate, CurrencyRate rate, String depositCurrency) {
        if (rate == null || rate.getAskRate() == null) {
            return;
        }
        if (currencyExchangeRate == null) {
            currencyExchangeRate = new CurrencyExchangeRate();
        }
        try {
            currencyExchangeRate.setIfromCurrency(CurrencyEnum.USD.getCode());
            currencyExchangeRate.setItoCurrency(depositCurrency);
            currencyExchangeRate.setUpdateUser(SessionManager.getUserId());
            CurrencyExchangeRateVo rateVo = new CurrencyExchangeRateVo();
            rateVo.setResult(currencyExchangeRate);
            rateVo.setRate(rate);
            ServiceTool.getCurrencyExchangeRateService().saveOrUpdateRate(rateVo);
        } catch (Exception e) {
            LOG.error(e);
        }
    }
}