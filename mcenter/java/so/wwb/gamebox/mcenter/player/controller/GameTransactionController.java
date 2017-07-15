/*
package so.wwb.gamebox.mcenter.player.controller;


import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.query.sort.Direction;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.web.session.SessionManagerBase;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.site.report.IVPlayerGameOrderService;
import so.wwb.gamebox.mcenter.init.ConfigManager;
import so.wwb.gamebox.mcenter.player.form.VPlayerGameOrderForm;
import so.wwb.gamebox.mcenter.player.form.VPlayerGameOrderSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.company.enums.SiteStatusEnum;
import so.wwb.gamebox.model.company.setting.po.Game;
import so.wwb.gamebox.model.company.setting.po.SysExport;
import so.wwb.gamebox.model.company.setting.vo.ApiGametypeRelationListVo;
import so.wwb.gamebox.model.company.setting.vo.GameListVo;
import so.wwb.gamebox.model.company.setting.vo.SysExportVo;
import so.wwb.gamebox.model.company.site.po.SiteApi;
import so.wwb.gamebox.model.company.site.po.SiteApiTypeI18n;
import so.wwb.gamebox.model.company.site.po.SiteGame;
import so.wwb.gamebox.model.company.sys.po.VSysSiteUser;
import so.wwb.gamebox.model.master.enums.GameOrderStateEnum;
import so.wwb.gamebox.model.site.report.po.VPlayerGameOrder;
import so.wwb.gamebox.model.master.player.so.VPlayerGameOrderSo;
import so.wwb.gamebox.model.master.player.vo.VPlayerGameOrderListVo;
import so.wwb.gamebox.model.master.player.vo.VPlayerGameOrderVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.cache.ExportCriteriaTool;
import so.wwb.gamebox.web.common.tool.WeekTool;
import so.wwb.gamebox.web.report.controller.AbstractExportController;

import java.util.*;

*/
/**
 * 玩家游戏下单视图控制器
 *
 * @author catban
 * @time 2015-9-30 15:11:44
 *//*

@Controller
//region your codes 1
@RequestMapping("/report/gameTransaction")
public class GameTransactionController extends AbstractExportController<IVPlayerGameOrderService, VPlayerGameOrderListVo, VPlayerGameOrderVo, VPlayerGameOrderSearchForm, VPlayerGameOrderForm, VPlayerGameOrder, Integer> {

    private static final Log LOG = LogFactory.getLog(GameTransactionController.class);

//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/report/gameOrder/";
        //endregion your codes 2
    }

    //region your codes 3
    @Override
    protected void doInit(VPlayerGameOrderListVo listVo, Model model) {
        initGameOrder(listVo, model);
        super.doInit(listVo, model);
    }

    private void initGameOrder(VPlayerGameOrderListVo listVo, Model model) {
        // 前台判断 子账户/站长
        checkSysCode(listVo);

        // 首页经营概况链接
        initDate(listVo);
        listVo.setOrderStateMap(DictTool.get(DictEnum.GAME_ORDER_STATE));
        //添加下拉搜索　关键词切换
        model.addAttribute("searchKeys", initSearchKeys());
    }

    @Override
    protected VPlayerGameOrderListVo doList(VPlayerGameOrderListVo listVo, VPlayerGameOrderSearchForm form, BindingResult result, Model model) {
        setUserDatasource(listVo);


        // 前台判断 子账户/站长
        checkSysCode(listVo);

        // 首页经营概况链接
        initDate(listVo);

        if (StringTool.equals(listVo.getSearch().getSearchCondition(), "true")) {
            // 列表需要导出时要将查询条件转换为json串
            model.addAttribute("conditionJson", ExportCriteriaTool.criteriaToJson(listVo.getQuery().getCriteria()));

            listVo.getQuery().addOrder(VPlayerGameOrder.PROP_BET_TIME, Direction.DESC)
                    .addOrder(VPlayerGameOrder.PROP_ID, Direction.DESC);
            listVo = super.doList(listVo, form, result, model);
        }

        listVo.setOrderStateMap(DictTool.get(DictEnum.GAME_ORDER_STATE));
        //添加下拉搜索　关键词切换
        model.addAttribute("searchKeys", initSearchKeys());

        model.addAttribute("command", listVo);

        SessionManager.getSiteId();

        return listVo;
    }

    private void initDate(VPlayerGameOrderListVo listVo) {
        Integer outer = listVo.getOuter() == null ? 0 : listVo.getOuter();
        if (outer != 0) {
            listVo.getSearch().setSearchCondition("true");
            if (StringTool.isBlank(listVo.getSearch().getOrderState())) {
                listVo.getSearch().setOrderState(GameOrderStateEnum.SETTLE.getCode());
            }
            if (listVo.getSearch().getPayoutStart() != null && listVo.getSearch().getPayoutEnd() != null) {
                return;
            }
            Date today = SessionManager.getDate().getToday();
            Date now = SessionManager.getDate().getNow();
            Date weekStartDate = WeekTool.getWeekStartDate(today);
            Date monthStartDate = WeekTool.getMonthStartDate(today);
            switch (outer) {
                case 1: // 今日
                    listVo.getSearch().setPayoutStart(today);
                    listVo.getSearch().setPayoutEnd(now);
                    break;
                case 2: // 昨日
                case 11:
                    listVo.getSearch().setPayoutStart(SessionManager.getDate().getYestoday());
                    listVo.getSearch().setPayoutEnd(subtract1second(today));
                    break;
                case 3: // 本周
                    listVo.getSearch().setPayoutStart(weekStartDate);
                    listVo.getSearch().setPayoutEnd(subtract1second(today));
                    break;
                case 4: // 上周
                    listVo.getSearch().setPayoutStart(DateTool.addDays(weekStartDate, -7));
                    listVo.getSearch().setPayoutEnd(subtract1second(weekStartDate));
                    break;
                case 5: // 本月
                    listVo.getSearch().setPayoutStart(monthStartDate);
                    listVo.getSearch().setPayoutEnd(subtract1second(today));
                    break;
                case 6: // 上月
                    Date lastMonthFirstDay = SessionManager.getDate().getLastMonthFirstDay(SessionManager.getTimeZone());
                    listVo.getSearch().setPayoutStart(lastMonthFirstDay);
                    listVo.getSearch().setPayoutEnd(subtract1second(monthStartDate));
                    break;
                case 12: // 前天
                    listVo.getSearch().setPayoutStart(DateTool.addDays(today, -2));
                    listVo.getSearch().setPayoutEnd(subtract1second(SessionManager.getDate().getYestoday()));
                    break;
                case 13: // 大前天
                    listVo.getSearch().setPayoutStart(DateTool.addDays(today, -3));
                    listVo.getSearch().setPayoutEnd(subtract1second(DateTool.addDays(today, -2)));
                    break;
                case 14: // 大大前天
                    listVo.getSearch().setPayoutStart(DateTool.addDays(today, -4));
                    listVo.getSearch().setPayoutEnd(subtract1second(DateTool.addDays(today, -3)));
                    break;
                case 15: // 大大大前天
                    listVo.getSearch().setPayoutStart(DateTool.addDays(today, -5));
                    listVo.getSearch().setPayoutEnd(subtract1second(DateTool.addDays(today, -4)));
                    break;
                case 16: // 大大大大前天
                    listVo.getSearch().setPayoutStart(DateTool.addDays(today, -6));
                    listVo.getSearch().setPayoutEnd(subtract1second(DateTool.addDays(today, -5)));
                    break;
                case 17: // 大大大大大前天
                    listVo.getSearch().setPayoutStart(DateTool.addDays(today, -7));
                    listVo.getSearch().setPayoutEnd(subtract1second(DateTool.addDays(today, -6)));
                    break;
            }
        } else {
            // 初始化时间设置
            initDate(listVo.getSearch());
            listVo.setMaxDate(SessionManager.getDate().getNow());
        }
    }

    */
/**
     * 减去1秒
     *//*

    private Date subtract1second(Date date) {
        return DateTool.addSeconds(date, -1);
    }

    private void checkSysCode(VPlayerGameOrderListVo listVo) {
        boolean isMaster = SessionManager.isCurrentSiteMaster();
        listVo.setIsMaster(isMaster);
        if (isMaster) {
            listVo.setSites(getSites());
        }
    }

    */
/**
     * 初始化时间设置
     *
     * @param so VPlayerGameOrderSo
     *//*

    private void initDate(VPlayerGameOrderSo so) {
        if (so.getCreateStart() == null && so.getCreateEnd() == null) {
            so.setCreateEnd(SessionManager.getDate().getNow());
            so.setCreateStart(SessionManager.getDate().addDays(-40));
            so.setSearchCondition("true");
        } else {
            if (so.getCreateStart() != null && so.getCreateEnd() != null && so.getCreateStart().compareTo(so.getCreateEnd()) == 0) {
                so.setCreateEnd(DateTool.addSeconds(DateTool.addDays(so.getCreateStart(), 1), -1));
            } else if (so.getOuter() != null && so.getOuter() == 7) {
                so.setCreateEnd(DateTool.addSeconds(DateTool.addDays(so.getCreateStart(), 1), -1));
            }
        }
    }

    @RequestMapping("/statisticalData")
    @ResponseBody
    private Map statisticalData(VPlayerGameOrderListVo listVo) {
        Map map = new HashMap(4);
        // 统计数据
        if (listVo.getPaging().getTotalCount() != 0) {
            initDate(listVo);
            try {
                map = getService().queryTotalPayoutAndEffect(listVo);
            } catch (Exception e) {
                LOG.error(e, "统计-注单数据超时");
            }
        } else {
            map.put("profit", 0);
            map.put("effective", 0);
            map.put("winning", 0);
        }
        map.put("listCount", listVo.getPaging().getTotalCount());
        return map;
    }

    private void setUserDatasource(VPlayerGameOrderListVo listVo) {
        if (listVo.getSearch().getSiteId() != null) {
            listVo._setDataSourceId(listVo.getSearch().getSiteId());
        } else {
            listVo._setDataSourceId(SessionManagerBase.getSiteId());
            listVo.getSearch().setSiteId(listVo._getDataSourceId());
        }
    }


    @Override
    protected SysExportVo buildExportData(SysExportVo vo) {
        if (vo.getResult() == null) {
            vo.setResult(new SysExport());
        }
        vo.getResult().setService(IVPlayerGameOrderService.class.getName());
        vo.getResult().setMethod("searchGameOrderByCustom");
        vo.getResult().setParam(VPlayerGameOrderListVo.class.getName());
        vo.getResult().setUsername(SessionManager.getUserName());
        vo.getResult().setExportUserId(SessionManager.getUserId());
        vo.getResult().setExportUserSiteId(SessionManager.getSiteId());
        if (vo.getResult().getSiteId() == null) {
            vo.getResult().setSiteId(SessionManager.getSiteId());
        }
        vo.getResult().setFileName(LocaleTool.tranView("export", "game_order") + "-"
                + DateTool.formatDate(DateQuickPicker.getInstance().getNow(), SessionManager.getLocale(), SessionManager.getTimeZone(), "yyyyMMddHHmmss"));

        return vo;
    }

    private List<Pair> initSearchKeys() {
        */
/**
         * 列表搜索栏[关键字]下拉切换
         *//*

        List<Pair> searchKeys;
        searchKeys = new ArrayList<>();
        searchKeys.add(new Pair("search.username", LocaleTool.tranView(Module.COLUMN.getCode(), "playerAccount")));
        searchKeys.add(new Pair("search.agentusername", LocaleTool.tranView(Module.COLUMN.getCode(), "agentAccount")));
        searchKeys.add(new Pair("search.topagentusername", LocaleTool.tranView(Module.COLUMN.getCode(), "agentTopAccount")));
        return searchKeys;
    }

    */
/**
     * 获取站点
     *//*

    private List<VSysSiteUser> getSites() {
        Map<String, VSysSiteUser> map = Cache.getSysSiteUser();
        List<VSysSiteUser> sites = new ArrayList<>();
        for (VSysSiteUser site : map.values()) {
            if ((ConfigManager.getConfigration().getSubsysCode()).equals(site.getSubsysCode())
                    && SessionManager.getMasterUserId().intValue() == site.getSysUserId().intValue()
                    && SiteStatusEnum.NORMAL.getCode().equals(site.getStatus())) {
                sites.add(site);
            }
        }
        return sites;
    }

    @RequestMapping({"/Choose"})
    public String getAllApi(VPlayerGameOrderListVo listVo, GameListVo gameListVo, Model model) {
        List<SiteApi> allApis = new ArrayList<>();
        List<SiteGame> allGames = new ArrayList<>();

        allApis.addAll(Cache.getSiteApi().values());
        Map<Integer, List<SiteGame>> groupByApi = CollectionTool.groupByProperty(Cache.getSiteGame().values(), SiteGame.PROP_API_ID, Integer.class);
        for (Integer apiId : groupByApi.keySet()) {
            Map<String, List<SiteGame>> groupByGameType = CollectionTool.groupByProperty(groupByApi.get(apiId), SiteGame.PROP_GAME_TYPE, String.class);
            for (String gameType : groupByGameType.keySet()) {
                List<SiteGame> gamesInGameType = groupByGameType.get(gameType);
                allGames.add(gamesInGameType.get(0));
            }
        }

        Map<String, SiteApiTypeI18n> siteApiTypeI18n = Cache.getSiteApiTypeI18n();

        listVo.setGameList(ServiceTool.gameService().allSearch(gameListVo));
        DictTool.refresh(DictEnum.GAME_TYPE);
        model.addAttribute("command", listVo);
        model.addAttribute("allApis", allApis);
        model.addAttribute("apiList", getApiGametype());
        model.addAttribute("allGames", allGames);
        model.addAttribute("apiTypes", getSiteApiType());
        return "/report/gameOrder/Choose";
    }

    private List<Map<Integer, List>> getApiGametype() {
        Collection<SiteApi> values = Cache.getSiteApi().values();
        List<Map<Integer, List>> types = new ArrayList<>();
        for (SiteApi api : values) {
            Map<Integer, List> map = new HashMap<>();
            ApiGametypeRelationListVo listVo = new ApiGametypeRelationListVo();
            listVo.setPaging(null);
            listVo.getSearch().setApiId(api.getApiId());
            listVo = ServiceTool.apiGametypeRelationService().search(listVo);
            map.put(api.getApiId(), listVo.getResult());
            types.add(map);
        }
        return types;
    }

    private List<Map<String, Object>> getSiteApiType() {
        Map<String, SiteApiTypeI18n> siteApiTypeI18n = Cache.getSiteApiTypeI18n();
        Iterator<String> iter = siteApiTypeI18n.keySet().iterator();
        List<Map<String, Object>> apiTypes = new ArrayList<>();
        while (iter.hasNext()) {
            String apiTypeId = iter.next();
            SiteApiTypeI18n apiTypeI18n = siteApiTypeI18n.get(apiTypeId);
            GameListVo gameListVo = new GameListVo();
            gameListVo.getSearch().setApiTypeId(apiTypeI18n.getApiTypeId());
            List<Game> gameList = ServiceTool.gameService().findGameTypeByApiType(gameListVo);
            Map<String, Object> map = new HashMap<>();
            map.put("apiTypeId", apiTypeId);
            map.put("apiTypeName", apiTypeI18n.getName());
            map.put("gameTypes", setApiIds(gameList));
            apiTypes.add(map);
        }
        return apiTypes;
    }

    private String setApiIds(List<Game> list) {
        String ids = "";
        if (list == null || list.size() == 0) {
            return ids;
        }
        for (Game game : list) {
            ids = ids + game.getGameType() + ",";
        }
        if (ids.length() > 0) {
            ids = ids.substring(0, ids.length() - 1);
        }
        return ids;
    }

    @RequestMapping({"/Details"})
    public String Details(VPlayerGameOrderVo vPlayerGameOrderVo, Model model) {
        vPlayerGameOrderVo = super.doEdit(vPlayerGameOrderVo, model);
        model.addAttribute("command", vPlayerGameOrderVo);

        //API详情JSON转换
        List<Map> resultArray = (List<Map>) JsonTool.fromJson(vPlayerGameOrderVo.getResult().getResultJson(), JsonTool.createCollectionType(ArrayList.class, Map.class));
        model.addAttribute("resultArray", resultArray);
        return "/report/gameOrder/Details";
    }
    //endregion your codes 3

}*/
