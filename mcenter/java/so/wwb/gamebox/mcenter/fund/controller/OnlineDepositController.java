package so.wwb.gamebox.mcenter.fund.controller;


import org.soul.commons.collections.CollectionTool;
import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.ArrayTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateFormat;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.net.IpTool;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.model.sys.po.SysDict;
import org.soul.model.sys.po.SysParam;
import org.soul.web.session.SessionManagerBase;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.mcenter.enmus.ListOpEnum;
import so.wwb.gamebox.mcenter.fund.form.VPlayerDepositSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.CacheBase;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.boss.enums.TemplateCodeEnum;
import so.wwb.gamebox.model.company.setting.po.SysCurrency;
import so.wwb.gamebox.model.master.dataRight.DataRightModuleType;
import so.wwb.gamebox.model.master.fund.enums.RechargeTypeParentEnum;
import so.wwb.gamebox.model.master.fund.po.VPlayerDeposit;
import so.wwb.gamebox.model.master.fund.vo.PlayerRechargeVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerDepositListVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerDepositVo;
import so.wwb.gamebox.model.master.player.vo.PlayerRankVo;
import so.wwb.gamebox.web.IpRegionTool;
import so.wwb.gamebox.web.SessionManagerCommon;
import so.wwb.gamebox.web.cache.Cache;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.*;


/**
 * 线上支付列表控制器
 *
 * @author fei
 *         2016-7-6 11:36:16
 */
@Controller
@RequestMapping("/fund/deposit/online")
public class OnlineDepositController extends BaseDepositController {

    @Override
    protected String getViewBasePath() {
        return "/fund/deposit/online/";
    }

    @Override
    protected VPlayerDepositListVo doList(VPlayerDepositListVo listVo, VPlayerDepositSearchForm form, BindingResult result, Model model) {
        this.initQuery(listVo);
        // 初始化ListVo
        initListVo(listVo);

        // 线上支付声音参数
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_ONLINEPAY);
        model.addAttribute("sysParam", sysParam);
        String templateCode = TemplateCodeEnum.fund_deposit_online_check.getCode();
        model.addAttribute("searchTempCode", templateCode);
        model.addAttribute("searchTemplates", CacheBase.getSysSearchTempByCondition(SessionManagerBase.getUserId(), TemplateCodeEnum.fund_deposit_online_check.getCode()));
        if (SessionManager.getOnlineVoiceNotice() != null) {
            sysParam.setActive(SessionManager.getOnlineVoiceNotice());
        }
        listVo.setTone(sysParam);
        listVo.setRechargeType(onlineRechargeType());
        //层级
        model.addAttribute("playerRanks", ServiceSiteTool.playerRankService().queryUsableList(new PlayerRankVo()));
        return listVo;
    }

    @RequestMapping("/doData")
    @ResponseBody
    protected VPlayerDepositListVo doData(VPlayerDepositListVo listVo, VPlayerDepositSearchForm form, BindingResult result, Model model) {

        // 初始化筛选条件
        this.initQuery(listVo);
        // 初始化ListVo
        super.initListVo(listVo);
        /*// 线上支付声音参数
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_ONLINEPAY);
        model.addAttribute("sysParam", sysParam);
        String templateCode = TemplateCodeEnum.fund_deposit_online_check.getCode();
        model.addAttribute("searchTempCode", templateCode);
        model.addAttribute("searchTemplates", CacheBase.getSysSearchTempByCondition(SessionManagerBase.getUserId(), TemplateCodeEnum.fund_deposit_online_check.getCode()));
        if (SessionManager.getOnlineVoiceNotice() != null) {
            sysParam.setActive(SessionManager.getOnlineVoiceNotice());
        }
        listVo.setTone(sysParam);
        listVo.setRechargeType(onlineRechargeType());*/

        String moduleType = DataRightModuleType.ONLINEDEPOSIT.getCode();
        listVo = getPlayerDeposit(listVo, moduleType, form, result, model);
        // 查询结果

        handleTempleData(listVo);
        return listVo;
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
            Map<String, Map<String, Map<String, String>>> dictsMap = I18nTool.getDictsMap(SessionManagerCommon.getLocale().toString());
            Map<String, SysCurrency> sysCurrencys = Cache.getSysCurrency();
            for (VPlayerDeposit deposit : result) {

                deposit.set_soulFn_formatDateTz_createTime(LocaleDateTool.formatDate(deposit.getCreateTime(), dateFormat.getDAY_SECOND(),timeZone));
                deposit.set_soulFn_formatTimeMemo_createTime(LocaleDateTool.formatTimeMemo(deposit.getCreateTime(), locale));
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
                deposit.set_soulFn_formatDateTz_checkTime(LocaleDateTool.formatDate(deposit.getCheckTime(), dateFormat.getDAY_SECOND(),timeZone));
                deposit.set_soulFn_formatTimeMemo_checkTime(LocaleDateTool.formatTimeMemo(deposit.getCheckTime(), locale));
                deposit.set_dicts_common_currency_symbol(dictsMap.get("common").get("currency_symbol").get(deposit.getPayerBank()));
                deposit.set_ipDeposit_ipv4LongToString(IpTool.ipv4LongToString(deposit.getIpDeposit()));
                deposit.set_gbFn_getIpRegion_ipDictCode(IpRegionTool.getIpRegion(deposit.getIpDictCode()));
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

    /*
    * 计算分页
    *
    * */
    @RequestMapping("/count")
    public String count(VPlayerDepositListVo listVo,Model model, String isCounter) {
        String moduleType = DataRightModuleType.ONLINEDEPOSIT.getCode();
        return super.count(listVo, moduleType, model, isCounter);
    }

    /*
    * 统计金额
    *
    * */
    @RequestMapping("/doStatistics")
    @ResponseBody
    protected VPlayerDepositListVo doStatistics(VPlayerDepositListVo listVo, VPlayerDepositSearchForm form, BindingResult result, Model model) {
        // 初始化筛选条件
        this.initQuery(listVo);
        initListVo(listVo);
        String moduleType = DataRightModuleType.ONLINEDEPOSIT.getCode();
        listVo = getStatistics(listVo, moduleType, form, result, model);
        return listVo;
    }

    @Override
    protected void initQuery(VPlayerDepositListVo listVo) {
        listVo.getSearch().setRechargeTypeParent(RechargeTypeParentEnum.ONLINE_DEPOSIT.getCode());
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
        SessionManager.setOnlineVoiceNotice(paramVal);
        Map<String, Object> map = new HashMap<>(1,1f);
        map.put("state", true);
        return map;//toneSwitch(SiteParamEnum.WARMING_TONE_ONLINEPAY);
    }

    /**
     * 线上支付详情
     */
    @Override
    protected VPlayerDepositVo doView(VPlayerDepositVo vo, Model model) {
        return queryView(vo, model);
    }

    /**
     * 线上支付-筛选
     */
    @RequestMapping("/filter")
    public String filter(VPlayerDepositListVo listVo, Model model) {
        listVo.getSearch().setRechargeTypeParent(RechargeTypeParentEnum.ONLINE_DEPOSIT.getCode());

        listVo = initFilter(listVo);

        model.addAttribute("filters", listVo.getOperators());
        model.addAttribute("keyClassName", ListOpEnum.OnlineDepositListVo.getClassName());
        model.addAttribute("filterList", listVo.getFilterRows());
        model.addAttribute("jsonFilterList", JsonTool.toJson(listVo.getFilterRows()));
        model.addAttribute("goFilterUrl", getViewBasePath() + "list.html");

        return FILTER_URL;
    }

    /**
     * 查询人工存入类型
     *
     * @return
     */
    private Map<Object, SysDict> onlineRechargeType() {
        Map<String, SysDict> rechargeTypeMap = DictTool.get(so.wwb.gamebox.model.DictEnum.FUND_RECHARGE_TYPE);
        Map<Object, SysDict> manualRechargeTypeList = new HashMap<>();
        String rechargeTypeParent = RechargeTypeParentEnum.ONLINE_DEPOSIT.getCode();
        for (String key : rechargeTypeMap.keySet()) {

            if (rechargeTypeParent.equals(rechargeTypeMap.get(key).getParentCode())) {
                manualRechargeTypeList.put(key, rechargeTypeMap.get(key));
            }
        }
        return manualRechargeTypeList;
    }

    @RequestMapping("/confirmCheck")
    @ResponseBody
    public Map confirmOnlineCheck(PlayerRechargeVo vo) {
//        fundCheckReminder("fund/deposit/online/confirmCheck.html",vo.getSearch().getRechargeTypeParent());
        return confirmCheck(vo);
    }


}