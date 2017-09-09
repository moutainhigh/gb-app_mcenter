package so.wwb.gamebox.mcenter.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dubbo.DubboTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.math.NumberTool;
import org.soul.commons.support._Module;
import org.soul.commons.tree.TreeNode;
import org.soul.iservice.security.privilege.ISysResourceService;
import org.soul.model.common.BaseVo;
import org.soul.model.security.privilege.po.VSysUserResource;
import org.soul.model.security.privilege.vo.SysResourceVo;
import org.soul.web.session.RedisSessionDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.mcenter.init.ConfigManager;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.WeekTool;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.company.setting.po.ApiType;
import so.wwb.gamebox.model.company.setting.po.ApiTypeI18n;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.gameapi.enums.ApiProviderEnum;
import so.wwb.gamebox.model.gameapi.enums.ApiTypeEnum;
import so.wwb.gamebox.model.master.player.vo.PlayerTransactionVo;
import so.wwb.gamebox.model.master.player.vo.UserPlayerVo;
import so.wwb.gamebox.model.master.player.vo.VPlayerOnlineListVo;
import so.wwb.gamebox.model.master.setting.po.VUserShortcutMenu;
import so.wwb.gamebox.model.master.setting.vo.UserShortcutMenuListVo;
import so.wwb.gamebox.model.master.setting.vo.VUserShortcutMenuListVo;
import so.wwb.gamebox.model.report.po.Chart;
import so.wwb.gamebox.model.report.po.OperationProfile;
import so.wwb.gamebox.model.report.vo.GameSurveyVo;
import so.wwb.gamebox.model.report.vo.OperationProfileVo;
import so.wwb.gamebox.web.cache.Cache;

import java.util.*;

import static so.wwb.gamebox.mcenter.tools.ServiceTool.gameSurveyService;

/**
 * 新版首页
 * Created by fei on 16-9-4.
 */
@Controller
@RequestMapping("/home")
public class HomeController {

    private static final String INDEX_URL = "/home/Index";
    // 报表数据
    private static final String TABLE_URL = "/home/include/Table";
    // 运营状况
    private static final String OPERATE_URL = "/home/include/Operate";
    //首页-新增菜单
    public static final String ADD_MENU_URI = "/home/AddMenu";
    private static final Log LOG = LogFactory.getLog(HomeController.class);
    //private static final String DATE_FMT_MM_DD = "MM月dd日";

    @Autowired
    private RedisSessionDao redisSessionDao;

    @RequestMapping("/homeIndex")
    public String home(Model model) {
        // 在线玩家数
        model.addAttribute("onlinePlayerNum", calcOnlinePlayerNum());
        // 今日活跃玩家
        model.addAttribute("activePlayerNum", calcActivePlayerNum());
        // 总资产
        model.addAttribute("assets", getAssets());
        // 更新时间
        model.addAttribute("updateTime", SessionManager.getDate().getNow());
        // 游戏盈亏日期
        model.addAttribute("days", getFmtDays());

        return INDEX_URL;
    }

    /**
     * 计算在线玩家数
     */
    private Long calcOnlinePlayerNum() {
        VPlayerOnlineListVo listVo = new VPlayerOnlineListVo();
        List<Integer> userIds = listVo.getSearch().getUserIds();
        List<String> keys = redisSessionDao.getUserTypeActiveSessions(UserTypeEnum.PLAYER.getCode());

        if (CollectionTool.isNotEmpty(keys)) {
            for (String key : keys) {
                String[] str = key.split(",");
                if (str.length == 3 && !userIds.contains(Integer.valueOf(str[1]))) {
                    userIds.add(Integer.valueOf(str[1]));
                    listVo.getSearch().getSessionKeys().add(str[2]);
                }
            }
            return ServiceTool.vPlayerOnlineService().count(listVo);
        }
        return 0L;
    }

    /**
     * 今日活跃玩家
     */
    private Long calcActivePlayerNum() {
        Date day = DateQuickPicker.getInstance().getDay(SessionManager.getTimeZone());
        UserPlayerVo userPlayerVo = new UserPlayerVo();
        userPlayerVo.setStartTime(day);
        userPlayerVo.setEndTime(DateQuickPicker.getInstance().getNow());
        return ServiceTool.userPlayerService().queryActivePlayer(userPlayerVo);
    }

    /**
     * 查找站点资产(钱包余额 + API余额 + 冻结余额）
     */
    private Map<String, Object> getAssets() {
        return ServiceTool.userPlayerService().queryAssets(new UserPlayerVo());
    }

    /**
     * 站点概况, 玩家概况
     */
    @RequestMapping("/siteData")
    @ResponseBody
    public Map<String, Object> siteData() {
        Map<String, Object> map = new HashMap<>(6, 1f);
        List<Chart> charts = getSiteData();
        if (CollectionTool.isNotEmpty(charts)) {
            Integer size = charts.size();
            String[] dates = new String[size];
            Double[] profits = new Double[size];
            Double[] payouts = new Double[size];
            Integer[] players = new Integer[size];
            Integer[] deposits = new Integer[size];
            Integer[] bets = new Integer[size];
            Integer[] depoistPlayer = new Integer[size];
            for (int i = 0; i < size; i++) {
                Chart chart = charts.get(i);
                dates[i] = chart.getDate();
                profits[i] = chart.getProfit() == null ? 0.0d : chart.getProfit();
                payouts[i] = chart.getPayout() == null ? 0.0d : chart.getPayout();
                players[i] = chart.getPlayer() == null ? 0 : chart.getPlayer();
                deposits[i] = chart.getDeposit() == null ? 0 : chart.getDeposit();
                bets[i] = chart.getBet() == null ? 0 : chart.getBet();
                depoistPlayer[i] = chart.getDepositPlayer() == null ? 0 : chart.getDepositPlayer();
            }
            map.put("date", dates);
            map.put("profit", profits);
            map.put("payout", payouts);
            map.put("player", players);
            map.put("deposit", deposits);
            map.put("bet", bets);
            map.put("depoistPlayer", depoistPlayer);
        }
        return map;
    }

    /**
     * 获取站点盈利
     */
    private List<Chart> getSiteData() {
        OperationProfileVo vo = new OperationProfileVo();

        Date today = getToday();
        vo.getSearch().setStartTime(DateTool.addDays(today, -7));
        vo.getSearch().setEndTime(today);
        vo.getSearch().setSiteId(SessionManager.getSiteId());

        List<Chart> temp = ServiceTool.operationProfileService().querySiteData(vo);
        List<Chart> charts = new ArrayList<>();
        List<Date> dates = getRecently7Days();

        for (Date date : dates) {
            for (Chart chart : temp) {
                //String fmtDate =DateTool.formatDate(chart.getStatDate(),SessionManager.getLocale(),SessionManager.getTimeZone(),LocaleDateTool.getFormat("DAY")); //LocaleDateTool.formatDate(chart.getStatDate(), LocaleDateTool.getFormat("DAY"), SessionManager.getTimeZone());
                Date chartDate = chart.getStatDate(); //LocaleDateTool.parse(fmtDate);
                if (date == null || chartDate == null) {
                    continue;
                }
                if (date.compareTo(chartDate) == 0) {
                    String key = getKey(chart);

                    chart.setDate(key);
                    if (charts.contains(chart)) {
                        charts.remove(chart);
                    }
                    charts.add(chart);
                    break;
                } else {
                    Chart repair = new Chart();
                    String day = DateTool.formatDate(date, SessionManager.getLocale(), SessionManager.getTimeZone(), LocaleDateTool.getFormat("MONTH_DAY"));
                    repair.setDate(day);
                    if (!charts.contains(repair)) {
                        charts.add(repair);
                    }
                }
            }
        }

        return charts;
    }

    @RequestMapping("/depositData")
    @ResponseBody
    public Map<String, Object> depositData() {
        Map<String, Object> map = new HashMap<>(4, 1f);
        List<Chart> charts = getDepositData();
        if (CollectionTool.isNotEmpty(charts)) {
            Integer size = charts.size();
            String[] dates = new String[size];
            Double[] onlines = new Double[size];
            Double[] companies = new Double[size];
            Double[] mobiles = new Double[size];
            Double[] manualDeposit = new Double[size];
            for (int i = 0; i < size; i++) {
                Chart chart = charts.get(i);
                dates[i] = chart.getDate();
                onlines[i] = chart.getOnline() == null ? 0 : chart.getOnline();
                companies[i] = chart.getCompany() == null ? 0 : chart.getCompany();
                mobiles[i] = chart.getMobile() == null ? 0 : chart.getMobile();
                manualDeposit[i] = chart.getManualDeposit() == null ? 0 : chart.getManualDeposit();
            }
            map.put("date", dates);
            map.put("online", onlines);
            map.put("company", companies);
            map.put("mobile", mobiles);
            map.put("manualDeposit", manualDeposit);
        }
        return map;
    }

    private List<Chart> getDepositData() {
        PlayerTransactionVo vo = new PlayerTransactionVo();
        Date today = getToday();
        vo.getSearch().setStartTime(DateTool.addDays(today, -7));
        vo.getSearch().setEndTime(today);
        vo.getSearch().setTimeZone(WeekTool.getTimeZoneInterval());
        // 最近7天日期
        vo.setStatDates(getRecently7DaysFormat());
        List<Chart> charts = ServiceTool.getPlayerTransactionService().queryDeposit(vo);
        for (Chart chart : charts) {
            Date statDate = chart.getStatDate();
            String day = DateTool.formatDate(statDate, LocaleDateTool.getFormat("MONTH_DAY"));
            chart.setDate(day);

        }

        return charts;
    }

    private List<Date> getRecently7DaysFormat() {
        Date today = getToday();

        List<Date> dates = new ArrayList<>();
        for (int i = 7; i > 0; i--) {
            Date date = DateTool.addDays(today, -i);
            String dateFormat = DateTool.formatDate(date, CommonContext.get().getLocale(), CommonContext.get().getTimeZone(), DateTool.yyyy_MM_dd);
            date = DateTool.parseDate(dateFormat, DateTool.yyyy_MM_dd);
            dates.add(date);
        }
        return dates;
    }

    private List<Date> getRecently7Days() {
        Date today = getToday();

        List<Date> dates = new ArrayList<>();
        for (int i = 7; i > 0; i--) {
            Date date = DateTool.addDays(today, -i);
            dates.add(date);
        }
        return dates;
    }

    private List<String> toDisplayDay() {
        List<Date> recently7Days = getRecently7Days();
        List<String> dates = new ArrayList<>();
        for (int i = recently7Days.size() - 1; i >= 0; i--) {
            String s = DateTool.formatDate(recently7Days.get(i), LocaleDateTool.getFormat("MONTH_DAY"));
            dates.add(s);
        }
        /*for (Date d : recently7Days) {
            String s = DateTool.formatDate(d, DATE_FMT_MM_DD);
            dates.add(s);
            //dates.add(DateTool.parseDate(fmtDate, DateTool.yyyy_MM_dd));
        }*/
        return dates;
    }

    @RequestMapping("/gameData")
    @ResponseBody
    public Map<String, Object> gameData(Integer num) {
        Map<String, Object> map = new HashMap<>(3, 1f);

        Map<String, ApiTypeI18n> typeMap = Cache.getApiTypeI18n();
        List<Chart> charts = getGameData(num);

        if (CollectionTool.isNotEmpty(charts)) {
            List<String> types = new ArrayList<>();
            List<Double> amounts = new ArrayList<>();
            List<Double> payouts = new ArrayList<>();

            Map<String, ApiType> apiTyp = Cache.getApiType();
            for (String id : apiTyp.keySet()) {
                for (Chart chart : charts) {
                    String typeId = String.valueOf(chart.getApiTypeId());
                    ApiTypeI18n typeI18n = typeMap.get(typeId);
                    if (typeI18n != null) {
                        String typeName = typeI18n.getName();
                        if (id.equals(typeId)) {
                            if (types.contains(typeName)) {
                                types.remove(typeName);
                            }
                            types.add(typeMap.get(typeId).getName());
                            amounts.add(chart.getEffeAmount() == null ? 0.0d : chart.getEffeAmount());
                            payouts.add(chart.getPayout() == null ? 0.0d : chart.getPayout());
                        }
                    }

                }

                String tName = typeMap.get(id).getName();
                if (!types.contains(tName)) {
                    types.add(typeMap.get(id).getName());
                    amounts.add(0.0d);
                    payouts.add(0.0d);
                }
            }

            map.put("apiType", types.toArray());
            map.put("amount", amounts.toArray());
            map.put("payout", payouts.toArray());
        } else {
            List<String> apiTypes = new ArrayList<>();
            if (ParamTool.isLotterySite()) {
                apiTypes.add(typeMap.get(String.valueOf(ApiTypeEnum.LOTTERY.getCode())).getName());
                map.put("amount", new Double[]{0.0d});
                map.put("payout", new Double[]{0.0d});
            } else {
                for (String id : typeMap.keySet()) {
                    apiTypes.add(typeMap.get(id).getName());
                }
                map.put("amount", new Double[]{0.0d, 0.0d, 0.0d, 0.0d});
                map.put("payout", new Double[]{0.0d, 0.0d, 0.0d, 0.0d});
            }
            map.put("apiType", apiTypes.toArray());
        }
        return map;
    }

    private List<String> getFmtDays() {
        List<Date> dates = getRecently7Days();
        List<String> days = new ArrayList<>();
        for (Date date : dates) {
            String day = DateTool.formatDate(date, SessionManager.getLocale(), SessionManager.getTimeZone(), LocaleDateTool.getFormat("MONTH_DAY"));
            days.add(day);
        }
        return days;
    }

    private List<Chart> getGameData(Integer num) {
        if (num == null) num = -1;
        Date date = DateTool.addDays(getToday(), num);
        GameSurveyVo vo = new GameSurveyVo();
        vo.getSearch().setStaticTime(date);
        vo.getSearch().setSiteId(SessionManager.getSiteId());
        if (ParamTool.isLotterySite()) {
            vo.getSearch().setApiId(NumberTool.toInt(ApiProviderEnum.PL.getCode()));
        }
        return gameSurveyService().queryGameData(vo);
    }

    /**
     * 报表数据
     */
    @RequestMapping("/tableData")
    public String tableData(Model model) {
        // 报表数据
        model.addAttribute("tables", getTableData());
        // 游戏报表数据（API_TYPE）
        model.addAttribute("gameTables", getGameTableData());
        // 游戏报表数据（API）
        model.addAttribute("apiTables", getGameTableApiData());

        model.addAttribute("listDateDay", toDisplayDay());
        return TABLE_URL;
    }

    /**
     * 报表数据
     */
    private List<Chart> getTableData() {
        List<Chart> tables = new ArrayList<>();

        List<Chart> sites = getSiteData();
        List<Chart> deposits = getDepositData();
        if (sites != null && sites.size() > 0) {
            for (Chart site : sites) {
                for (Chart deposit : deposits) {
                    if (StringTool.equals(site.getDate(), deposit.getDate())) {
                        site.setOnline(deposit.getOnline());
                        site.setCompany(deposit.getCompany());
                        site.setMobile(deposit.getMobile());
                        site.setManualDeposit(deposit.getManualDeposit());
                        break;
                    }
                }
                tables.add(site);
            }
        } else {
            for (Chart deposit : deposits) {
                Chart site = new Chart();
                site.setDate(deposit.getDate());
                site.setOnline(deposit.getOnline());
                site.setCompany(deposit.getCompany());
                site.setMobile(deposit.getMobile());
                site.setManualDeposit(deposit.getManualDeposit());
                tables.add(site);
            }

        }

        Collections.reverse(tables);
        return tables;
    }

    /**
     * 游戏报表数据（API_TYPE）
     */
    private LinkedHashMap<String, LinkedHashMap<String, Object>> getGameTableData() {
        GameSurveyVo vo = initGameSurveyVo();

        List<Chart> charts = ServiceTool.gameSurveyService().query7DaysData(vo);
        LinkedHashMap<String, LinkedHashMap<String, Object>> map = new LinkedHashMap<>(7, 1f);
        Map<String, ApiType> typeMap = Cache.getApiType();

        List<Date> dates = getRecently7Days();
        Collections.reverse(dates);
        for (Date date : dates) {
            String day = DateTool.formatDate(date, SessionManager.getLocale(), SessionManager.getTimeZone(), LocaleDateTool.getFormat("MONTH_DAY"));
            map.put(day, null);
        }

        for (Chart chart : charts) {
            String key = getKey(chart);

            LinkedHashMap<String, Object> subMap;
            if (map.containsKey(key) && map.get(key) != null) {
                subMap = map.get(key);
            } else {
                subMap = new LinkedHashMap<>(4, 1f);
                // 填充空的子map
                for (String id : typeMap.keySet()) {
                    Chart c = new Chart();
                    c.setApiTypeId(Integer.valueOf(id));
                    c.setDate(key);
                    subMap.put(id, c);
                }
                map.put(key, subMap);
            }
            subMap.put(String.valueOf(chart.getApiTypeId()), chart);
            if (!map.containsKey(key)) {
                map.put(key, subMap);
            }
        }

        // 填充空的key
        for (String key : map.keySet()) {
            if (map.get(key) == null) {
                LinkedHashMap<String, Object> subMap = new LinkedHashMap<>(4, 1f);
                for (String id : typeMap.keySet()) {
                    Chart c = new Chart();
                    c.setApiTypeId(Integer.valueOf(id));
                    c.setDate(key);
                    subMap.put(id, c);
                }
                map.put(key, subMap);
            }
        }

        return map;
    }

    /**
     * 格式化日期（key）
     *
     * @param chart Chart
     * @return key
     */
    private String getKey(Chart chart) {
        String localeDate = DateTool.formatDate(chart.getStatDate(), SessionManager.getLocale(), SessionManager.getTimeZone(), LocaleDateTool.getFormat("MONTH_DAY")); //LocaleDateTool.formatDate(chart.getStatDate(), LocaleDateTool.getFormat("DAY"), SessionManager.getTimeZone());
        return localeDate;
        // TODO 由于日期格式暂不支持 MM-dd, 故此处暂时固定
        //return DateTool.formatDate(DateTool.parseDate(localeDate, LocaleDateTool.getFormat("DAY")), LocaleDateTool.getFormat("DAY"));
    }

    /**
     * 游戏报表数据（API）
     */
    private LinkedHashMap<String, LinkedHashMap<String, Map<String, Object>>> getGameTableApiData() {
        GameSurveyVo vo = initGameSurveyVo();
        Map<String, ApiType> typeMap = Cache.getApiType();
        LinkedHashMap<String, LinkedHashMap<String, Map<String, Object>>> map = new LinkedHashMap<>();
        for (String id : typeMap.keySet()) {
            vo.getSearch().setApiTypeId(Integer.valueOf(id));
            List<Chart> charts = ServiceTool.gameSurveyService().query7DaysApiData(vo);
            LinkedHashMap<String, Map<String, Object>> secondMap = new LinkedHashMap<>(7, 1f);

            for (Chart chart : charts) {
                Map<String, Object> thirdMap = new HashMap<>();
                String key = getKey(chart);
                if (secondMap.containsKey(key)) {
                    thirdMap = secondMap.get(key);
                }
                thirdMap.put(String.valueOf(chart.getApiId()), chart);

                if (!secondMap.containsKey(key)) {
                    secondMap.put(key, thirdMap);
                }
            }
            map.put(id, secondMap);
        }
        return map;
    }

    private GameSurveyVo initGameSurveyVo() {
        GameSurveyVo vo = new GameSurveyVo();
        Date today = getToday();
        vo.getSearch().setStartTime(DateTool.addDays(today, -7));
        vo.getSearch().setEndTime(today);
        vo.getSearch().setSiteId(SessionManager.getSiteId());
        return vo;
    }

    /**
     * 获取站点所在零时区时间
     */
    private Date getToday() {
        return SessionManager.getDate().getToday();
    }

    /**
     * 运营数据
     */
    @RequestMapping("/operateData")
    public String operateData(Model model) {
        TreeMap<String, List<OperationProfile>> map = new TreeMap<>();

        OperationProfileVo vo = new OperationProfileVo();
        vo.getSearch().setSiteId(SessionManager.getSiteId());

        Date today = getToday();
        Date now = SessionManager.getDate().getNow();

        // 今日数据
        vo.getSearch().setStartTime(today);
        vo.getSearch().setEndTime(now);
        List<OperationProfile> todayData = this.queryTodayData(vo);
        map.put("day.1", todayData);

        // 昨日数据
        vo.getSearch().setStartTime(DateTool.addDays(today, -1));
        vo.getSearch().setEndTime(today);
        map.put("day.2", ServiceTool.operationProfileService().queryYesterdayData(vo));

        // 本周数据
        Date weekStartDate = WeekTool.getWeekStartDate(today);
        vo.getSearch().setStartTime(weekStartDate);
        vo.getSearch().setEndTime(today);
        map.put("day.3", ServiceTool.operationProfileService().queryThisWeekData(vo));
//        map.put("day.3", this.queryThisWeekData(vo, todayData));

        // 上周数据
        vo.getSearch().setStartTime(DateTool.addDays(weekStartDate, -7));
        vo.getSearch().setEndTime(weekStartDate);
        map.put("day.4", ServiceTool.operationProfileService().queryLastWeekData(vo));

        // 本月数据
        Date monthStartDate = WeekTool.getMonthStartDate(today);
        vo.getSearch().setStartTime(monthStartDate);
        vo.getSearch().setEndTime(today);
        map.put("day.5", ServiceTool.operationProfileService().queryThisMonthData(vo));
//        map.put("day.5", this.queryThisMonthData(vo, todayData));

        // 上月数据
        Date lastMonthFirstDay = DateQuickPicker.getInstance().getLastMonthFirstDay(SessionManager.getTimeZone());
        vo.getSearch().setStartTime(lastMonthFirstDay);
        Date monthFirstDay = DateQuickPicker.getInstance().getMonthFirstDay(SessionManager.getTimeZone());
        vo.getSearch().setEndTime(monthFirstDay);
        map.put("day.6", ServiceTool.operationProfileService().queryLastMonthData(vo));

        model.addAttribute("profiles", map);

        return OPERATE_URL;
    }


    /**
     * 有效交易量
     */
    @RequestMapping("/effectiveData")
    public String effectiveData(Model model) {
        OperationProfileVo vo = new OperationProfileVo();
        vo.getSearch().setSiteId(SessionManager.getSiteId());

        Date today = getToday();
        Date now = SessionManager.getDate().getNow();
        // 今日数据
        vo.getSearch().setStartTime(today);
        vo.getSearch().setEndTime(now);
        Map<String, Double> stringStringTreeMap = ServiceTool.userPlayerService().queryEffectiveTodayData(vo);
        model.addAttribute("effectiveTd", stringStringTreeMap);
        return "/home/include/EffectiveTd";
    }

    /**
     * 统计今日运营数据
     */
    private List<OperationProfile> queryTodayData(OperationProfileVo vo) {
        List<OperationProfile> todayData = new ArrayList<>();

        List<OperationProfile> temp = ServiceTool.userPlayerService().queryTodayData(vo);
        if (CollectionTool.isNotEmpty(temp)) {
            OperationProfile data = temp.get(0);
            data.setExpenditure(data.getRakebackAmount() + data.getRebateAmount()
                    + data.getFavorableAmount() + data.getRecommendAmount() + data.getRefundAmount());
            todayData.add(data);
        }

        return todayData;
    }

    /**
     * 本周数据（包含今天）
     * 需求变更：本周数据不包含今日数据，此方法作废
     *
     * @param todayData 今日数据
     */
    private List<OperationProfile> queryThisWeekData(OperationProfileVo vo, List<OperationProfile> todayData) {
        List<OperationProfile> thisWeekData = ServiceTool.operationProfileService().queryThisWeekData(vo);
        return setOperateData(thisWeekData, todayData);
    }

    /**
     * 本月数据（包含今天）
     * 需求变更：本月数据不包含今日数据，此方法作废
     *
     * @param todayData 今日数据
     */
    private List<OperationProfile> queryThisMonthData(OperationProfileVo vo, List<OperationProfile> todayData) {
        List<OperationProfile> thisMonthData = ServiceTool.operationProfileService().queryThisMonthData(vo);
        return setOperateData(thisMonthData, todayData);
    }

    /**
     * 加上今日数据
     *
     * @param todayData 今日数据
     */
    private List<OperationProfile> setOperateData(List<OperationProfile> operationData, List<OperationProfile> todayData) {
        List<OperationProfile> profiles = new ArrayList<>();

        if (CollectionTool.isNotEmpty(operationData)) {
            OperationProfile profile = new OperationProfile();
            OperationProfile op1 = operationData.get(0);
            if (CollectionTool.isNotEmpty(todayData)) {
                OperationProfile op2 = todayData.get(0);

                profile.setNewAgent(op1.getNewAgent() + op2.getNewAgent());
                profile.setNewPlayer(op1.getNewPlayer() + op2.getNewPlayer());
                profile.setNewPlayerDeposit(op1.getNewPlayerDeposit() + op2.getNewPlayerDeposit());
                profile.setDepositNewPlayer(op1.getDepositNewPlayer() + op2.getDepositNewPlayer());
                profile.setDepositPlayer(op1.getDepositPlayer() + op2.getDepositPlayer());
                profile.setDepositAmount(op1.getDepositAmount() + op2.getDepositAmount());
                profile.setWithdrawalAmount(op1.getWithdrawalAmount() + op2.getWithdrawalAmount());
                profile.setRakebackPlayer(op1.getRakebackPlayer() + op2.getRakebackPlayer());
                profile.setRakebackAmount(op1.getRakebackAmount() + op2.getRakebackAmount());
                profile.setRebatePlayer(op1.getRebatePlayer() + op2.getRebatePlayer());
                profile.setRebateAmount(op1.getRebateAmount() + op2.getRebateAmount());
                profile.setFavorablePlayer(op1.getFavorablePlayer() + op2.getFavorablePlayer());
                profile.setFavorableAmount(op1.getFavorableAmount() + op2.getFavorableAmount());
                profile.setRecommendPlayer(op1.getRecommendPlayer() + op2.getRecommendPlayer());
                profile.setRecommendAmount(op1.getRecommendAmount() + op2.getRecommendAmount());
                profile.setRefundPlayer(op1.getRefundPlayer() + op2.getRefundPlayer());
                profile.setRefundAmount(op1.getRefundAmount() + op2.getRefundAmount());
                profile.setTransactionPlayer(op1.getTransactionPlayer() + op2.getTransactionPlayer());
                profile.setExpenditure(op1.getExpenditure() + op2.getExpenditure());
                profile.setTransactionProfitLoss(op1.getTransactionProfitLoss() + op2.getTransactionProfitLoss());
                profile.setEffectiveTransactionVolume(op1.getEffectiveTransactionVolume() + op2.getEffectiveTransactionVolume());
            } else {
                profile = op1;
            }
            profiles.add(profile);
        }

        return profiles;
    }

    /**
     * 新增菜单
     */
    @RequestMapping("/addMenu")
    public String addMenu(Model model) {
        SysResourceVo o = new SysResourceVo();
        switch (UserTypeEnum.enumOf(SessionManager.getUser().getUserType())) {
            case MASTER_SUB:
                o.getSearch().setUserId(SessionManager.getUserId());
                break;
            case TOP_AGENT:
            case TOP_AGENT_SUB:
            case AGENT:
            case AGENT_SUB:
                if (SessionManager.getUser().getOwnerId() != null) {
                    o.getSearch().setUserId(SessionManager.getUserId());
                }
                break;
        }

        o.getSearch().setSubsysCode(ConfigManager.getConfigration().getSubsysCode());
        List<TreeNode<VSysUserResource>> menus = DubboTool.getService(ISysResourceService.class).getAllMenus(o);
        model.addAttribute("menus", menus);
        //左侧菜单栏
        VUserShortcutMenuListVo menuListVo = new VUserShortcutMenuListVo();
        menuListVo.getSearch().setUserId(SessionManager.getUserId());
        List<VUserShortcutMenu> vUserShortcutMenus = ServiceTool.vUserShortcutMenuService().queryShortMenuByUser(menuListVo);
        menuListVo.setResult(vUserShortcutMenus);
        //menuListVo = ServiceTool.vUserShortcutMenuService().search(menuListVo);
        model.addAttribute("menuListVo", menuListVo);
        return ADD_MENU_URI;
    }

    /**
     * 确认菜单
     *
     * @param menus 选中菜单的json
     */
    @RequestMapping("/confirmMenu")
    @ResponseBody
    public Map confirmMenu(String menus) {
        List<Integer> resourceIds = JsonTool.fromJson(menus, new TypeReference<ArrayList<Integer>>() {
        });//选中的菜单id集合

        return addMenu(resourceIds);
    }

    /**
     * 恢复默认菜单
     */
    @RequestMapping("/recoveryDefault")
    @ResponseBody()
    public Map recoveryDefault() {
        // 查询默认菜单
        UserShortcutMenuListVo userShortcutMenuListVo = new UserShortcutMenuListVo();
        if (UserTypeEnum.MASTER.getCode().equals(SessionManager.getUserType().getCode())) {
            userShortcutMenuListVo.getSearch().setUserId(SessionManager.getMasterUserId());
        } else {
            userShortcutMenuListVo.getSearch().setUserId(SessionManager.getUserId());
        }
        userShortcutMenuListVo = ServiceTool.userShortcutMenuService().revertDefaultMenu(userShortcutMenuListVo);
        return getVoMessage(userShortcutMenuListVo);
    }

    /**
     * 新增菜单公共方法
     *
     * @param resourceIds 新增菜单的resourceId集合
     */
    private Map addMenu(List<Integer> resourceIds) {
        UserShortcutMenuListVo userShortcutMenuListVo = new UserShortcutMenuListVo();
        if (UserTypeEnum.MASTER.getCode().equals(SessionManager.getUserType().getCode())) {
            userShortcutMenuListVo.getSearch().setUserId(SessionManager.getMasterUserId());
        } else {
            userShortcutMenuListVo.getSearch().setUserId(SessionManager.getUserId());
        }
        userShortcutMenuListVo.setResourceIds(resourceIds);
        userShortcutMenuListVo = ServiceTool.userShortcutMenuService().saveLeftMenu(userShortcutMenuListVo);
        return getVoMessage(userShortcutMenuListVo);
    }

    private Map getVoMessage(BaseVo baseVo) {
        Map<String, Object> map = new HashMap<>(2, 1f);
        if (baseVo.isSuccess() && StringTool.isBlank(baseVo.getOkMsg())) {
            baseVo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_SUCCESS));

        } else if (!baseVo.isSuccess() && StringTool.isBlank(baseVo.getErrMsg())) {
            baseVo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_FAILED));
        }
        map.put("msg", StringTool.isNotBlank(baseVo.getOkMsg()) ? baseVo.getOkMsg() : baseVo.getErrMsg());
        map.put("state", baseVo.isSuccess());
        return map;
    }

    @RequestMapping("/playerNum")
    @ResponseBody
    public Map playerNum() {
        Map<String, Long> objectObjectHashMap = new HashMap<>();
        // 在线玩家数
        objectObjectHashMap.put("onlinePlayerNum", calcOnlinePlayerNum());
        // 今日活跃玩家
        objectObjectHashMap.put("activePlayerNum", calcActivePlayerNum());
        return objectObjectHashMap;
    }

}