package so.wwb.gamebox.mcenter.report.betting.controller;

import org.soul.commons.collections.CollectionQueryTool;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.collections.MapTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.cache.Cache;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.iservice.site.report.IVPlayerGameOrderService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.ApiGameTool;
import so.wwb.gamebox.model.company.setting.po.ApiGametypeRelation;
import so.wwb.gamebox.model.company.setting.po.ApiI18n;
import so.wwb.gamebox.model.company.setting.po.GameI18n;
import so.wwb.gamebox.model.company.site.po.SiteApiI18n;
import so.wwb.gamebox.model.company.site.po.SiteGameI18n;
import so.wwb.gamebox.model.site.report.po.VPlayerGameOrder;
import so.wwb.gamebox.model.site.report.so.VPlayerGameOrderSo;
import so.wwb.gamebox.model.site.report.vo.VPlayerGameOrderListVo;
import so.wwb.gamebox.model.site.report.vo.VPlayerGameOrderVo;
import so.wwb.gamebox.web.report.betting.form.VPlayerGameOrderForm;
import so.wwb.gamebox.web.report.betting.form.VPlayerGameOrderSearchForm;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by linsen on 18-6-19.
 */
@Controller
@RequestMapping("/report/gameOrderLinkPopup")
public class GameOrderLinkPopupController extends BaseCrudController<IVPlayerGameOrderService, VPlayerGameOrderListVo, VPlayerGameOrderVo, VPlayerGameOrderSearchForm, VPlayerGameOrderForm, VPlayerGameOrder, Integer> {
    private static final Log LOG = LogFactory.getLog(GameOrderLinkPopupController.class);

    @Override
    protected String getViewBasePath() {
        return "/linkPopup/gameTransaction/";
    }

    @RequestMapping("/gameTransaction")
    public String gameTransaction(VPlayerGameOrderListVo listVo, Model model, HttpServletRequest request) {
        String linkType = listVo.getLinkType();
        LOG.info("站点：{0}，链接弹窗类型：linkType={1}", SessionManager.getSiteId(), linkType);
        if ("byPlayerDetail".equals(linkType)) {//玩家详细页
            byPlayerDetail(listVo, model);
        } else if ("byOperate".equals(linkType)) {//经营报表
            byOperate(listVo, model,request);
        } else {
            model.addAttribute("command", listVo);
        }
        if (ServletTool.isAjaxSoulRequest(request)) {
            return getViewBasePath() + "IndexPartial";
        } else {
            return getViewBasePath() + "Index";
        }
    }

    /**
     * 玩家详细页面--有效投注额跳转
     *
     * @param listVo
     * @param model
     * @return
     */
    private void byPlayerDetail(VPlayerGameOrderListVo listVo, Model model) {
        model.addAttribute("linkType", listVo.getLinkType());
        listVo = ServiceSiteTool.vPlayerGameOrderService().queryEffectiveGameTransaction(listVo);
        listVo = setGameNameAndApiName(listVo);
        model.addAttribute("command", listVo);
        model.addAttribute("validateRule", JsRuleCreator.create(VPlayerGameOrderSearchForm.class));
        Map map = ServiceSiteTool.vPlayerGameOrderService().sumEffectiveGameTransaction(listVo);
        model.addAttribute("totalSingleAmount", MapTool.getString(map, "singleamount"));
        model.addAttribute("totalEffectiveTradeAmount", MapTool.getString(map, "effectivetradeamount"));
        model.addAttribute("totalProfitAmount", MapTool.getString(map, "profitamount"));
    }

    /**
     * 经营报表页面跳转弹窗
     *
     * @param listVo
     * @param model
     * @return
     */
    private void byOperate(VPlayerGameOrderListVo listVo, Model model,HttpServletRequest request) {
        model.addAttribute("linkType", listVo.getLinkType());
        getGameList(listVo.getSearch());
        if (!ServletTool.isAjaxSoulRequest(request)) {
            listVo = setGameTypeList(listVo);
        }
        listVo = ServiceSiteTool.vPlayerGameOrderService().search(listVo);
        listVo = setGameNameAndApiName(listVo);
        model.addAttribute("command", listVo);
        model.addAttribute("validateRule", JsRuleCreator.create(VPlayerGameOrderSearchForm.class));
        Map map = ServiceSiteTool.vPlayerGameOrderService().queryTotalPayoutAndEffect(listVo);
        model.addAttribute("totalSingleAmount", MapTool.getString(map, "single"));
        model.addAttribute("totalEffectiveTradeAmount", MapTool.getString(map, "effective"));
        model.addAttribute("totalProfitAmount", MapTool.getString(map, "profit"));
    }

    /**
     * 获取游戏名称
     *
     * @param listVo
     * @return
     */

    public VPlayerGameOrderListVo setGameNameAndApiName(VPlayerGameOrderListVo listVo) {
        Map<Integer, Map<Integer, String>> apiNameGroupByApiType = ApiGameTool.getSiteApiNameByApiType(Cache.getSiteApiTypeRelactionI18n());
        Map<String, SiteApiI18n> siteApiI18nMap = Cache.getSiteApiI18n();
        Map<String, ApiI18n> apiI18nMap = Cache.getApiI18n();
        Map<String, SiteGameI18n> siteGameI18nMap = Cache.getSiteGameI18n();
        Map<String, GameI18n> gameI18nMap = Cache.getGameI18n();
        Integer gameId;
        for (VPlayerGameOrder vPlayerGameOrder : listVo.getResult()) {
            vPlayerGameOrder.setApiName(ApiGameTool.getSiteApiName(apiNameGroupByApiType, siteApiI18nMap, apiI18nMap, vPlayerGameOrder.getApiId(), vPlayerGameOrder.getApiTypeId()));
            gameId = vPlayerGameOrder.getGameId();
            if (gameId != null && gameId != 0) {
                vPlayerGameOrder.setGameName(ApiGameTool.getSiteGameName(siteGameI18nMap, gameI18nMap, String.valueOf(gameId)));
            }
        }
        return listVo;
    }

    /**
     * 获取游戏名称（查询的游戏id为空，直接返回空记录）
     *
     * @param so
     */
    private void getGameList(VPlayerGameOrderSo so) {
        //游戏名称
        if (StringTool.isNotBlank(so.getSearchGame())) {
            Integer siteId = SessionManager.getSiteId();
            Map<String, SiteGameI18n> gameI18nMap = Cache.getSiteGameI18n(siteId);
            Collection gameI18ns = gameI18nMap.values();
            String sql = "select gameId from so.wwb.gamebox.model.company.site.po.SiteGameI18n where  name like '%" + so.getSearchGame() + "%'";
            List gameIds = CollectionQueryTool.queryBySql(gameI18ns, sql);
            so.setGameIdList(CollectionTool.linearizeNestedCollection(gameIds));
        }
    }

    /**
     * 获取经营报表链接过来的API查询条件
     *
     * @param listVo
     * @return
     */
    private VPlayerGameOrderListVo setGameTypeList(VPlayerGameOrderListVo listVo) {
        VPlayerGameOrderSo so = listVo.getSearch();
        List<Integer> apiIds = so.getApiIds();
        List<String> gameTypes = so.getHideGameTypes();

        if (CollectionTool.isNotEmpty(gameTypes) && CollectionTool.isNotEmpty(apiIds)) {
            return listVo;
        }
        //遍历gameTypes
        Map<Object, List> gameMap = new HashMap<>();
        if (CollectionTool.isNotEmpty(gameTypes)) {
            for (String str : gameTypes) {
                String[] strList = str.split("-");
                if (gameMap.get(strList[0]) != null) {
                    gameMap.get(strList[0]).add(strList[1]);
                } else {
                    List<String> gameList = new ArrayList<>();
                    gameList.add(strList[1]);
                    gameMap.put(strList[0], gameList);
                }
            }
        }
        //遍历apiIds
        Map<Object, List> gameMap2 = new HashMap<>();
        if (CollectionTool.isNotEmpty(apiIds)) {
            Map<String, ApiGametypeRelation> apiGametypeRelationMap = Cache.getApiGameTypeRelation();
            for (Integer itemId : apiIds) {
                for (Map.Entry<String, ApiGametypeRelation> relationEntry : apiGametypeRelationMap.entrySet()) {
                    if (relationEntry.getValue().getApiId().equals(itemId)) {
                        if (gameMap2.get(itemId) != null) {
                            gameMap2.get(itemId).add(relationEntry.getValue().getGameType());
                        } else {
                            List<String> gameList = new ArrayList<>();
                            gameList.add(relationEntry.getValue().getGameType());
                            gameMap2.put(itemId, gameList);
                        }
                    }
                }
            }
        }
        if (MapTool.isNotEmpty(gameMap2)) {
            gameMap.putAll(gameMap2);
        }
        //组装apiTypeList
        List<Object> apiTypeList = new ArrayList<>();
        for (Map.Entry<Object, List> entry : gameMap.entrySet()) {
            Map map = new TreeMap();
            map.put("apiId", entry.getKey());
            map.put("gameType", entry.getValue());
            apiTypeList.add(JsonTool.toJson(map));
        }
        String apiTypeListString = apiTypeList.toString();
        listVo.getSearch().setApiTypeList(apiTypeListString);
        return listVo;
    }
}
