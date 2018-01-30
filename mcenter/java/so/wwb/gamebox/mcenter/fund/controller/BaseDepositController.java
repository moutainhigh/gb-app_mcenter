package so.wwb.gamebox.mcenter.fund.controller;

import org.apache.commons.collections.Predicate;
import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.collections.MapTool;
import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.net.IpTool;
import org.soul.commons.query.Paging;
import org.soul.commons.support._Module;
import org.soul.model.listop.po.SysListOperator;
import org.soul.model.sys.po.SysDict;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.listop.ListOpTool;
import org.soul.web.session.SessionManagerBase;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import so.wwb.gamebox.common.dubbo.ServiceActivityTool;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.iservice.master.fund.IVPlayerDepositService;
import so.wwb.gamebox.mcenter.enmus.ListOpEnum;
import so.wwb.gamebox.mcenter.fund.form.DepositRemarkForm;
import so.wwb.gamebox.mcenter.fund.form.VPlayerDepositForm;
import so.wwb.gamebox.mcenter.fund.form.VPlayerDepositSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.*;
import so.wwb.gamebox.model.bitcoin.vo.PoloniexOrderResult;
import so.wwb.gamebox.model.boss.enums.TemplateCodeEnum;
import so.wwb.gamebox.model.company.setting.po.SysCurrency;
import so.wwb.gamebox.model.company.site.po.SiteCurrency;
import so.wwb.gamebox.model.currency.po.CurrencyRate;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.listop.FilterRow;
import so.wwb.gamebox.model.listop.FilterSelectConstant;
import so.wwb.gamebox.model.listop.TabTypeEnum;
import so.wwb.gamebox.model.master.dataRight.po.SysUserDataRight;
import so.wwb.gamebox.model.master.dataRight.vo.SysUserDataRightVo;
import so.wwb.gamebox.model.master.enums.ActivityApplyCheckStatusEnum;
import so.wwb.gamebox.model.master.fund.enums.RechargeStatusEnum;
import so.wwb.gamebox.model.master.fund.enums.RechargeTypeEnum;
import so.wwb.gamebox.model.master.fund.enums.RechargeTypeParentEnum;
import so.wwb.gamebox.model.master.fund.po.DigiccyRechargeResponseText;
import so.wwb.gamebox.model.master.fund.po.DigiccyTransaction;
import so.wwb.gamebox.model.master.fund.po.PlayerRecharge;
import so.wwb.gamebox.model.master.fund.po.VPlayerDeposit;
import so.wwb.gamebox.model.master.fund.so.VPlayerDepositSo;
import so.wwb.gamebox.model.master.fund.vo.*;
import so.wwb.gamebox.model.master.operation.po.ActivityPlayerApply;
import so.wwb.gamebox.model.master.operation.po.VActivityMessage;
import so.wwb.gamebox.model.master.operation.vo.ActivityPlayerApplyVo;
import so.wwb.gamebox.model.master.operation.vo.VActivityMessageListVo;
import so.wwb.gamebox.model.master.player.po.PlayerRank;
import so.wwb.gamebox.model.master.player.vo.PlayerRankListVo;
import so.wwb.gamebox.model.master.player.vo.PlayerRankVo;
import so.wwb.gamebox.web.cache.Cache;

import java.util.*;

/**
 * 玩家存款试图控制器
 *
 * @author fei
 *         2016-7-8 11:36:16
 */
@SuppressWarnings("all")
public abstract class BaseDepositController extends BaseCrudController<IVPlayerDepositService, VPlayerDepositListVo, VPlayerDepositVo, VPlayerDepositSearchForm, VPlayerDepositForm, VPlayerDeposit, Integer> {

    static final String FILTER_URL = "/share/ListFilters";

    private static final Log LOG = org.soul.commons.log.LogFactory.getLog(BaseDepositController.class);

    /**
     * 初始化筛选条件
     */
    protected abstract void initQuery(VPlayerDepositListVo listVo);

    protected VPlayerDepositListVo doList(VPlayerDepositListVo listVo,String moduleType,  VPlayerDepositSearchForm form, BindingResult result, Model model) {
        initQuery(listVo);
        // 初始化ListVo
        initListVo(listVo);
        //用于查询模板
        String templateCode = TemplateCodeEnum.fund_deposit_company_check.getCode();
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
        model.addAttribute("searchTempCode", templateCode);
        model.addAttribute("searchTemplates", CacheBase.getSysSearchTempByCondition(SessionManagerBase.getUserId(), TemplateCodeEnum.fund_deposit_company_check.getCode()));
        List<SysUserDataRight> sysUserDataRights = getSysUserDataRights(moduleType);
        masterSubSearch(listVo,moduleType,sysUserDataRights);
        buildPlayerRankData(model,sysUserDataRights);
        return listVo;
    }

    public String count(VPlayerDepositListVo listVo,String moduleType, Model model, String isCounter) {
        // 初始化筛选条件
        initQuery(listVo);
        initListVo(listVo);
        listVo = doCount(listVo, moduleType, isCounter);
        listVo.getPaging().cal();
        model.addAttribute("command", listVo);
        return getViewBasePath() + "IndexPagination";
    }

    public VPlayerDepositListVo doCount(VPlayerDepositListVo listVo, String moduleType,String isCounter) {
        if (StringTool.isBlank(isCounter)) {
            if (UserTypeEnum.MASTER_SUB.getCode().equals(SessionManager.getUser().getUserType())) {
                //获取子账号查询条件
                List<SysUserDataRight> sysUserDataRights = getSysUserDataRights(moduleType);
                if (sysUserDataRights != null && sysUserDataRights.size() > 0) {
                    masterSubSearch(listVo,moduleType,sysUserDataRights);
                    Paging paging = listVo.getPaging();
                    paging.setTotalCount(ServiceSiteTool.vPlayerDepositService().countPlayerDeposit(listVo));
                    paging.cal();
                    listVo = ServiceSiteTool.vPlayerDepositService().searchPlayerDeposit(listVo);
                } else {
                    long count = ServiceSiteTool.vPlayerDepositService().count(listVo);
                    listVo.getPaging().setTotalCount(count);
                }
            } else {
                long count = ServiceSiteTool.vPlayerDepositService().count(listVo);
                listVo.getPaging().setTotalCount(count);
            }
        }
        return listVo;
    }

    /**
     * 初始化ListVo
     */
    void initListVo(VPlayerDepositListVo listVo) {

        //转义搜索条件中的_
        VPlayerDepositSo search = listVo.getSearch();

        //默认搜索3天内的数据
        if (search.getCreateStart()==null&&search.getCreateEnd()==null&&search.getCheckTimeStart()==null&&search.getCheckTimeEnd()==null){
            Date now = new Date();
            Date sevenDaysAgo = DateTool.addDays(now,-3);
            search.setCreateStart(sevenDaysAgo);
        }

        if (StringTool.isNotBlank(search.getUsername())) {
            String[] split = search.getUsername().split(",");
            if (split.length == 1) {
                search.setUsername(search.getUsername().replaceAll("_", "\\\\_"));
            }
        }
        if (StringTool.isNotBlank(search.getPayName())) {
            search.setPayName(search.getPayName().replaceAll("_", "\\\\_"));
        }
        if (StringTool.isNotBlank(search.getAccount())) {
            search.setAccount(search.getAccount().replaceAll("_", "\\\\_"));
        }
        if (StringTool.isNotBlank(search.getNewUserName())) {
            search.setNewUserName(search.getNewUserName().replaceAll("_", "\\\\_"));
        }
        if (StringTool.isNotBlank(search.getFullName())) {
            search.setFullName(search.getFullName().replaceAll("_", "\\\\_"));
        }
        listVo.setSearch(search);
        String typeParent = listVo.getSearch().getRechargeTypeParent();
        // 右侧搜索类型
        listVo.setSearchType(listVo.getSearchType(typeParent));
        // 高级搜索
        listVo.setSeniorSearch(listVo.getSeniorSearch(typeParent));
        // 存款类型
        listVo.setRechargeType(listVo.getRechargeType(typeParent));
        // 审核状态
        listVo.setRechargeStatus(listVo.getRechargeStatus(typeParent));
        listVo.setOrderStateMap(DictTool.get(DictEnum.GAME_ORDER_STATE));
        listVo.setCheckStatusDict(DictTool.get(DictEnum.FUND_CHECK_STATUS));
        //ip转义
        String ipStr = listVo.getSearch().getIpStr();
        listVo.getSearch().setIpDeposit(StringTool.isBlank(ipStr) ? null : IpTool.ipv4StringToLong(listVo.getSearch().getIpStr()));
    }

    /**
     * 声音开关
     */
    Map<String, Object> toneSwitch(SiteParamEnum paramEnum) {
        Map<String, Object> map = new HashMap<>(1,1f);
        SysParam param = ParamTool.getSysParam(paramEnum);
        if (param != null) {
            if (param.getActive()) {
                param.setActive(false);
            } else {
                param.setActive(true);
            }
            // 更新参数设置
            updateParam(param);
            // 刷新参数缓存
            ParamTool.refresh(paramEnum);
            map.put("state", true);
        }
        return map;
    }

    /**
     * 更新参数设置
     */
    private void updateParam(SysParam param) {
        SysParamVo vo = new SysParamVo();
        vo.setResult(param);
        vo.setProperties(SysParam.PROP_ACTIVE);
        ServiceSiteTool.siteSysParamService().updateOnly(vo);
    }

    /**
     * 初始化筛选参数
     */
    VPlayerDepositListVo initFilter(VPlayerDepositListVo listVo) {
        List<FilterRow> rows = new ArrayList<>();

        // 初始化货币
//        rows.add(initCurrencies());
        // 初始化层级
        rows.add(initRanks());
        // 存款金额：大于等于/等于/小于等于
        rows.add(new FilterRow(VPlayerDeposit.PROP_RECHARGE_AMOUNT, getI18nName(VPlayerDeposit.PROP_RECHARGE_AMOUNT), FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        // 订单提交时间：大于等于/等于/小于等于
        rows.add(new FilterRow(VPlayerDeposit.PROP_CREATE_TIME, getI18nName(VPlayerDeposit.PROP_CREATE_TIME), FilterSelectConstant.equalRange, TabTypeEnum.DATE, null));

        // 状态包含/不包含（公司入款与线上支付状态不一致）
        Map<String, Map<String, String>> i18nMap = I18nTool.getDictsMap(SessionManagerBase.getLocale().toString()).get(Module.FUND.getCode());
        // 初始化公司入款方式和已保存的筛选条件
        initRechargeTypeAndOperateMap(listVo, rows, i18nMap);
        // 存款状态
        rows.add(initRechargeStatus(listVo, i18nMap));

        listVo.setFilterRows(rows);

        return listVo;
    }

    /**
     * 初始化货币
     * TODO 目前只有软妹币，暂时不用
     */
    private FilterRow initCurrencies() {
        List<Pair> currencies = new ArrayList<>();
        Map<String, SiteCurrency> map = Cache.getSiteCurrency();
        Map<String, String> currencyI18nMap = I18nTool.getDictsMap(
                SessionManagerBase.getLocale().toString()).get(Module.COMMON.getCode()).get(DictEnum.COMMON_CURRENCY.getType());
        for (SiteCurrency currency : map.values()) {
            currencies.add(new Pair(currency.getCode(), currencyI18nMap.get(currency.getCode())));
        }

        return new FilterRow(VPlayerDeposit.PROP_DEFAULT_CURRENCY,
                getI18nName(VPlayerDeposit.PROP_DEFAULT_CURRENCY),
                FilterSelectConstant.equal, TabTypeEnum.SELECT, currencies);
    }

    /**
     * 层级:包含/不包含
     */
    private FilterRow initRanks() {
        List<PlayerRank> playerRanks = ServiceSiteTool.playerRankService().allSearch(new PlayerRankListVo());
        List<Pair> rankPairs = new ArrayList<>();
        for (PlayerRank playerRank : playerRanks) {
            rankPairs.add(new Pair(playerRank.getId(), playerRank.getRankName()));
        }
        return new FilterRow(VPlayerDeposit.PROP_RANK_ID, getI18nName(VPlayerDeposit.PROP_RANK_NAME), FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, rankPairs);
    }

    /**
     * 初始化存款类型
     */
    private FilterRow initRechargeType(VPlayerDepositListVo listVo, Map<String, Map<String, String>> i18nMap) {
        Map<String, SysDict> map = DictTool.get(DictEnum.FUND_RECHARGE_TYPE);
        Map<String, String> typeMap = i18nMap.get(DictEnum.FUND_RECHARGE_TYPE.getType());

        List<Pair> rechargeTypes = new ArrayList<>();
        Collection<SysDict> rt = listVo.getType(map);
        for (SysDict dict : rt) {
            rechargeTypes.add(new Pair(dict.getDictCode(), typeMap.get(dict.getDictCode())));
        }

        return new FilterRow(VPlayerDeposit.PROP_RECHARGE_TYPE,
                getI18nName(VPlayerDeposit.PROP_RECHARGE_TYPE),
                FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, rechargeTypes);
    }

    /**
     * 初始化公司入款方式和已保存的筛选条件
     */
    private void initRechargeTypeAndOperateMap(VPlayerDepositListVo listVo, List<FilterRow> rows, Map<String, Map<String, String>> i18nMap) {
        // 已保存的筛选条件
        Map<String, SysListOperator> map;

        if (RechargeTypeParentEnum.COMPANY_DEPOSIT.getCode().equals(listVo.getSearch().getRechargeTypeParent())) {
            // 只有公司入款才要存款类型
            rows.add(initRechargeType(listVo, i18nMap));
            map = ListOpTool.getFilter(ListOpEnum.CompanyDepositListVo);
        } else {
            rows.add(onlineDepositWay());
            map = ListOpTool.getFilter(ListOpEnum.OnlineDepositListVo);
        }

        if (!map.isEmpty()) {
            listVo.setOperators(map.values());
        }
    }

    /**
     * 初始化存款状态
     */
    private FilterRow initRechargeStatus(VPlayerDepositListVo listVo, Map<String, Map<String, String>> i18nMap) {
        Collection<SysDict> rechargeStatus;

        if (RechargeTypeParentEnum.COMPANY_DEPOSIT.getCode().equals(listVo.getSearch().getRechargeTypeParent())) {
            rechargeStatus = listVo.getCompanyStatus();
        } else {
            rechargeStatus = listVo.getOnlineStatus();
        }

        Map<String, String> typeMap = i18nMap.get(DictEnum.FUND_RECHARGE_STATUS.getType());
        List<Pair> checkStatus = new ArrayList<>();
        for (SysDict dict : rechargeStatus) {
            checkStatus.add(new Pair(dict.getDictCode(), typeMap.get(dict.getDictCode())));
        }

        return new FilterRow(VPlayerDeposit.PROP_RECHARGE_STATUS,
                getI18nName(VPlayerDeposit.PROP_RECHARGE_STATUS),
                FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, checkStatus);
    }

    private String getI18nName(String i18nKey) {
        return LocaleTool.tranView("column", VPlayerDeposit.class.getSimpleName() + "." + i18nKey);
    }

    /**
     * 查找详情
     */
    VPlayerDepositVo queryView(VPlayerDepositVo vo, Model model) {
        vo = getService().get(vo);
        vo.getResult().setCurrencySign(getCurrencySign(vo.getResult().getDefaultCurrency()));
        String rechargeStatus = vo.getResult().getRechargeStatus();
        model.addAttribute("validateRule", JsRuleCreator.create(DepositRemarkForm.class));
        if(vo.getResult() == null) {
            return vo;
        }
        if (RechargeTypeEnum.BITCOIN_FAST.getCode().equals(vo.getResult().getRechargeType()) && !RechargeStatusEnum.EXCHANGE.getCode().equals(vo.getResult().getRechargeStatus())) {
            DigiccyTransactionVo digiccyTransactionVo = new DigiccyTransactionVo();
            digiccyTransactionVo.getSearch().setTransactionNo(vo.getResult().getTransactionNo());
            digiccyTransactionVo = ServiceSiteTool.digiccyTransactionService().search(digiccyTransactionVo);
            DigiccyTransaction digiccyTransaction = digiccyTransactionVo.getResult();
            if (digiccyTransaction != null) {
                DigiccyRechargeResponseText responseText = JsonTool.fromJson(digiccyTransaction.getResponseText(), DigiccyRechargeResponseText.class);
                if (StringTool.isNotBlank(responseText.getRate())) {
                    model.addAttribute("rate", JsonTool.fromJson(responseText.getRate(), CurrencyRate.class));
                }
                if (StringTool.isNotBlank(responseText.getResultJson())) {
                    model.addAttribute("poloniexResult", JsonTool.fromJson(responseText.getResultJson(), PoloniexOrderResult.class));
                }
            }

        }
        if (RechargeStatusEnum.EXCHANGE.getCode().equals(rechargeStatus) || RechargeStatusEnum.FAIL.getCode().equals(rechargeStatus) || RechargeStatusEnum.ONLINE_FAIL.getCode().equals(rechargeStatus) || vo.getResult().getFavorableTotalAmount() == null || vo.getResult().getFavorableTotalAmount() <= 0) {
            return vo;
        }

        ActivityPlayerApplyVo applyVo = new ActivityPlayerApplyVo();
        applyVo.getSearch().setPlayerRechargeId(vo.getResult().getId());
        applyVo = ServiceActivityTool.activityPlayerApplyService().search(applyVo);
        if (applyVo.getResult() == null) {
            return vo;
        }
        vo.setActivityId(applyVo.getResult().getActivityMessageId());
        vo.setActivityStatus(applyVo.getResult().getCheckState());
        if (vo.getActivityId() != null) {
            searchActivity(vo);
            searchFavorableTransactionId(vo, applyVo.getResult());
        }
        return vo;
    }

    /**
     * 查询优惠活动名称和优惠是否审核
     *
     * @param vo
     */
    private void searchActivity(VPlayerDepositVo vo) {
        VActivityMessageListVo messageListVo = new VActivityMessageListVo();
        messageListVo.getSearch().setActivityVersion(SessionManager.getLocale().toString());
        messageListVo.getSearch().setId(vo.getActivityId());
        messageListVo.setProperties(VActivityMessage.PROP_ACTIVITY_NAME, VActivityMessage.PROP_IS_AUDIT);
        List<Map<String, Object>> list = ServiceActivityTool.vActivityMessageService().searchProperties(messageListVo);
        if (CollectionTool.isNotEmpty(list)) {
            vo.setActivityName(MapTool.getString(list.get(0), VActivityMessage.PROP_ACTIVITY_NAME));
            vo.setActivityAudit(MapTool.getBoolean(list.get(0), VActivityMessage.PROP_IS_AUDIT));
        }
    }

    /**
     * 查询优惠交易记录id
     *
     * @param vo
     * @param activityPlayerApply
     */
    private void searchFavorableTransactionId(VPlayerDepositVo vo, ActivityPlayerApply activityPlayerApply) {
        if (ActivityApplyCheckStatusEnum.SUCCESS.getCode().equals(activityPlayerApply.getCheckState())) {
            PlayerFavorableVo playerFavorableVo = new PlayerFavorableVo();
            playerFavorableVo.getSearch().setPlayerRechargeId(vo.getResult().getId());
            playerFavorableVo.getSearch().setActivityMessageId(activityPlayerApply.getActivityMessageId());
            playerFavorableVo = ServiceSiteTool.playerFavorableService().search(playerFavorableVo);
            vo.setFavorableTransactionId(playerFavorableVo.getResult().getPlayerTransactionId());
        }
    }

    /**
     * 获取货币标志
     */
    String getCurrencySign(String defaultCurrency) {
        if (StringTool.isNotBlank(defaultCurrency)) {
            SysCurrency sysCurrency = Cache.getSysCurrency().get(defaultCurrency);
            if (sysCurrency != null) {
                return sysCurrency.getCurrencySign();
            }
        }
        return "";
    }

    private FilterRow onlineDepositWay() {
        //存款方式:包含/不包含
        DictEnum dictEnum = DictEnum.FUND_RECHARGE_TYPE;
        Map<String, SysDict> rechargeWayMap = DictTool.get(dictEnum);
        Map rechargeWayDictMap = I18nTool.getDictsMap(SessionManagerBase.getLocale().toString())
                .get(Module.FUND.getCode()).get(dictEnum.getType());
        List<Pair> rechargeWays = new ArrayList<>();
        /*for (String key : rechargeWayMap.keySet()) {
            if (RechargeTypeEnum.ONLINE_DEPOSIT.getCode().equals(key)
                    || RechargeTypeEnum.ALIPAY_SCAN.getCode().equals(key)
                    || RechargeTypeEnum.WECHATPAY_SCAN.getCode().equals(key)) {
                String i18n = rechargeWayDictMap.get((rechargeWayMap.get(key)).getDictCode()).toString();
                rechargeWays.add(new Pair(key,i18n));
            }
        }*/
        Collection<SysDict> sysDicts = CollectionTool.filter(rechargeWayMap.values(), new Predicate() {
            @Override
            public boolean evaluate(Object object) {
                return RechargeTypeParentEnum.ONLINE_DEPOSIT.getCode().equals(((SysDict) object).getParentCode());
            }
        });

        for (SysDict sysDict : sysDicts) {
            rechargeWays.add(new Pair(sysDict.getDictCode(), rechargeWayDictMap.get(sysDict.getDictCode())));
        }
        return new FilterRow(VPlayerDeposit.PROP_RECHARGE_TYPE, getI18nName(VPlayerDeposit.PROP_RECHARGE_TYPE),
                FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, rechargeWays);
    }

    /**
     * 子账号查询的层级权限
     * @param model
     * @param sysUserDataRights
     */
    private void buildPlayerRankData(Model model, List<SysUserDataRight> sysUserDataRights) {
        List<Integer> rankIds = CollectionTool.extractToList(sysUserDataRights,SysUserDataRight.PROP_ENTITY_ID);
        PlayerRankVo rankVo = new PlayerRankVo();
        rankVo.getSearch().setIds(rankIds);
        model.addAttribute("playerRanks", ServiceSiteTool.playerRankService().queryUsableList(rankVo));
    }

    protected VPlayerDepositListVo getPlayerDeposit(VPlayerDepositListVo listVo, String moduleType,
                                                    VPlayerDepositSearchForm form, BindingResult result, Model model) {
        if (UserTypeEnum.MASTER_SUB.getCode().equals(SessionManager.getUser().getUserType())) {
            List<SysUserDataRight> sysUserDataRights = getSysUserDataRights(moduleType);
            if (sysUserDataRights != null && sysUserDataRights.size() > 0) {
                masterSubSearch(listVo, moduleType,sysUserDataRights);
                buildPlayerRankData(model,sysUserDataRights);
                listVo = ServiceSiteTool.vPlayerDepositService().searchPlayerDeposit(listVo);
            } else {
                listVo = getDeposit(listVo, form, result, model);
                buildPlayerRankData(model,sysUserDataRights);
            }
        } else {
            listVo = getDeposit(listVo, form, result, model);
            buildPlayerRankData(model,null);
        }
        //转义搜索条件中的_
        VPlayerDepositSo search = listVo.getSearch();
        if (StringTool.isNotBlank(search.getUsername())) {
            search.setUsername(search.getUsername().replaceAll("\\\\", ""));
        }
        if (StringTool.isNotBlank(search.getPayName())) {
            search.setPayName(search.getPayName().replaceAll("\\\\", ""));
        }
        if (StringTool.isNotBlank(search.getAccount())) {
            search.setAccount(search.getAccount().replaceAll("\\\\", ""));
        }
        if (StringTool.isNotBlank(search.getNewUserName())) {
            search.setNewUserName(search.getNewUserName().replaceAll("\\\\", ""));
        }
        if (StringTool.isNotBlank(search.getFullName())) {
            search.setFullName(search.getFullName().replaceAll("\\\\", ""));
        }
        listVo.setSearch(search);
        return listVo;
    }

    /**
     * 获取统计数据
     * @param listVo
     * @param moduleType
     * @param form
     * @param result
     * @param model
     * @return
     */
    protected VPlayerDepositListVo getStatistics(VPlayerDepositListVo listVo, String moduleType,
                                                    VPlayerDepositSearchForm form, BindingResult result, Model model) {
        if (UserTypeEnum.MASTER_SUB.getCode().equals(SessionManager.getUser().getUserType())) {
            List<SysUserDataRight> sysUserDataRights = getSysUserDataRights(moduleType);
            if (sysUserDataRights != null && sysUserDataRights.size() > 0) {
                masterSubSearch(listVo, moduleType,sysUserDataRights);
                if (listVo.getSearch().isTodaySales()) {
                    //今日成功统计--jerry
                    VPlayerDepositListVo vPlayerDepositListVo = isTodayBaseSearch(listVo);
                    vPlayerDepositListVo.getSearch().setModuleType(listVo.getSearch().getModuleType());
                    vPlayerDepositListVo.getSearch().setDataRightUserId(SessionManager.getUserId());
                    Double sum = ServiceSiteTool.vPlayerDepositService().sumPlayerDeposit(vPlayerDepositListVo);
                    listVo.setTodayTotal(CurrencyTool.formatCurrency(sum == null ? 0 : sum));
                } else {
                    Double sum = ServiceSiteTool.vPlayerDepositService().sumPlayerDeposit(listVo);
                    listVo.setTotalSum(CurrencyTool.CURRENCY.format(sum == null ? 0 : sum));
                }
            } else {
                getStatistics(listVo);
            }
        } else {
            getStatistics(listVo);
        }
        return listVo;
    }

    /**
     * 统计数据
     * @param listVo
     */
    private void getStatistics(VPlayerDepositListVo listVo) {
        if (listVo.getSearch().isTodaySales()) {
            //今日成功统计--jerry
            VPlayerDepositListVo vPlayerDepositListVo = isTodayBaseSearch(listVo);
            vPlayerDepositListVo.setPropertyName(VPlayerDeposit.PROP_RECHARGE_AMOUNT);
            Number sum = this.getService().sum(vPlayerDepositListVo);
            listVo.setTodayTotal(CurrencyTool.formatCurrency(sum == null ? 0 : sum));
        } else {
            listVo.setPropertyName(VPlayerDeposit.PROP_RECHARGE_AMOUNT);
            Number sum = this.getService().sum(listVo);
            listVo.setTotalSum(CurrencyTool.CURRENCY.format(sum == null ? 0 : sum.doubleValue()));
        }
    }

    /**
     * 今日统计条件
     * @param listVo
     * @return
     */
    private VPlayerDepositListVo isTodayBaseSearch(VPlayerDepositListVo listVo) {
        VPlayerDepositListVo vPlayerDepositListVo = new VPlayerDepositListVo();
        vPlayerDepositListVo._setContextParam(listVo._getContextParam());
        Date today = SessionManager.getDate().getToday();
        Date todayEnd = DateTool.addDays(SessionManager.getDate().getToday(), 1);
        vPlayerDepositListVo.getSearch().setCheckTimeStart(today);
        vPlayerDepositListVo.getSearch().setCheckTimeEnd(todayEnd);
        if (listVo.getSearch().getRechargeTypeParent().equals(RechargeTypeParentEnum.COMPANY_DEPOSIT.getCode())) {
            vPlayerDepositListVo.getSearch().setRechargeStatus(RechargeStatusEnum.SUCCESS.getCode());
        } else {
            vPlayerDepositListVo.getSearch().setRechargeStatus(RechargeStatusEnum.ONLINE_SUCCESS.getCode());
        }
        vPlayerDepositListVo.getSearch().setRechargeTypeParent(listVo.getSearch().getRechargeTypeParent());
        return vPlayerDepositListVo;
    }

    /**
     * 根据模块以及用户获取对应菜单权限
     * @param moduleType
     * @return
     */
    private List<SysUserDataRight> getSysUserDataRights(String moduleType) {
        SysUserDataRightVo sysUserDataRightVo = new SysUserDataRightVo();
        sysUserDataRightVo.getSearch().setUserId(SessionManager.getUserId());
        sysUserDataRightVo.getSearch().setModuleType(moduleType);
        return ServiceSiteTool.sysUserDataRightService().searchDataRightsByUserId(sysUserDataRightVo);
    }

    /**
     * 获取子账号的查询条件
     * @param listVo
     * @param moduleType
     */
    private void masterSubSearch(VPlayerDepositListVo listVo, String moduleType, List<SysUserDataRight> sysUserDataRights) {
        if (UserTypeEnum.MASTER_SUB.getCode().equals(SessionManager.getUser().getUserType())) {
            if (CollectionTool.isNotEmpty(sysUserDataRights)) {
                listVo.getSearch().setDataRightUserId(SessionManager.getUserId());
                listVo.getSearch().setModuleType(moduleType);
                if (StringTool.isNotEmpty(listVo.getSearch().getUsername())) {
                    String username = listVo.getSearch().getUsername().toLowerCase();
                    String[] names = username.split(",");
                    if (names.length == 1) {
                        listVo.getSearch().setNewUserName(names[0]);
                    } else if (names.length>1) {
                        listVo.getSearch().setAccountNames(names);
                    }
                }
            }
        }
    }

    private VPlayerDepositListVo getDeposit(VPlayerDepositListVo listVo, VPlayerDepositSearchForm form, BindingResult result, Model model) {
        listVo = super.doList(listVo, form, result, model);
        return listVo;
    }


    /**
     * 存款审核：确定更新审核状态
     */
    public Map confirmCheck(PlayerRechargeVo vo) {
        LOG.info("账号【{0}】审核存款交易号【{1}】", SessionManager.getUserName(), vo.getSearch().getTransactionNo());
        // 更新订单状态
        vo = updateRechargeStatus(vo);

        HashMap<String, Object> map = new HashMap<>(2,1f);
        // 订单是否存在
        if (orderIsNull(vo, map)) return map;
        // 订单是否已审核
        if (orderIsAudit(vo, map)) return map;
        // 审核结果处理
        if (vo.getResult() == null) {
            vo.setResult(new PlayerRecharge());
        }
        // 最终状态
        putState(vo, map);
        return map;
    }

    /**
     * 更新订单状态
     */
    private PlayerRechargeVo updateRechargeStatus(PlayerRechargeVo vo) {
        vo.setTimeZone(SessionManager.getTimeZone());
        vo.getSearch().setCheckUserId(SessionManager.getUserId());
        //备注长度限制在200以内
        if (StringTool.length(vo.getSearch().getCheckRemark()) > 200) {
            vo.getSearch().setCheckRemark(StringTool.substring(vo.getSearch().getCheckRemark(), 0, 200));
        }
        if (StringTool.isNotBlank(vo.getSearch().getFailureTitle())) {
            vo.getSearch().setFailureTitle(vo.getSearch().getFailureTitle().replace("${customer}", LocaleTool.tranMessage(_Module.COMMON, "contactCustomerService")));
        }
        vo.getSearch().setCheckUsername(SessionManager.getAuditUserName());
        // 更新审核状态和任务数
        return ServiceSiteTool.playerRechargeService().rechargeCheck(vo);
    }

    /**
     * 订单是否存在
     */
    private boolean orderIsNull(PlayerRechargeVo vo, HashMap<String, Object> map) {
        if (!vo.isSuccess() && vo.getResult() == null) {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, "notOrder"));
            map.put("state", true);
            return true;
        }
        return false;
    }

    /**
     * 如果充值订单已审核，跳过审核，提示用户已审核
     */
    private boolean orderIsAudit(PlayerRechargeVo vo, HashMap<String, Object> map) {
        if (!vo.isSuccess() && vo.getResult() != null) {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, "audited"));
            map.put("state", true);
            return true;
        }
        return false;
    }

    /**
     * 最终状态
     */
    private void putState(PlayerRechargeVo vo, HashMap<String, Object> map) {
        map.put("msg", StringTool.isNotBlank(vo.getOkMsg()) ? vo.getOkMsg() : vo.getErrMsg());
        map.put("state", vo.isSuccess());
    }

//    /**
//     * 存款审核完,推送审核结果个各个子账号和站长
//     * Modified  jerry  2016-12-11
//     *
//     * @param roleUrl
//     */
//    public void fundCheckReminder(String roleUrl,String type) {
//        //推送消息给前端
//        MessageVo message = new MessageVo();
//        message.setSubscribeType(CometSubscribeType.MCENTER_RECHARGE_CHECK_REMINDER.getCode());
//        message.setSendToUser(true);
//        message.setCcenterId(SessionManager.getSiteParentId());
//        message.setSiteId(SessionManager.getSiteId());
//        message.setMasterId(SessionManager.getSiteUserId());
//        SysResourceListVo sysResourceListVo = new SysResourceListVo();
//        sysResourceListVo.getSearch().setUrl(roleUrl);
//        List<Integer> userIdByUrl = ServiceSiteTool.playerRechargeService().findUserIdByUrl(sysResourceListVo);
//        userIdByUrl.add(Const.MASTER_BUILT_IN_ID);
//        //自已会刷新，不发给自己
//        if(userIdByUrl.contains(SessionManager.getUserId())){
//            userIdByUrl.remove(SessionManager.getUserId());
//        }
//        message.addUserIds(userIdByUrl);
//        message.setMsgBody(type);
////        ServiceTool.messageService().sendToMcenterMsg(message);
//    }

}
