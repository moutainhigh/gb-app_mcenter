package so.wwb.gamebox.mcenter.report.betting.controller;

import org.soul.commons.collections.MapTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.iservice.site.report.IVPlayerGameOrderService;
import so.wwb.gamebox.model.ApiGameTool;
import so.wwb.gamebox.model.company.setting.po.ApiI18n;
import so.wwb.gamebox.model.company.setting.po.GameI18n;
import so.wwb.gamebox.model.company.site.po.SiteApiI18n;
import so.wwb.gamebox.model.company.site.po.SiteGameI18n;
import so.wwb.gamebox.model.site.report.po.VPlayerGameOrder;
import so.wwb.gamebox.model.site.report.vo.VPlayerGameOrderListVo;
import so.wwb.gamebox.model.site.report.vo.VPlayerGameOrderVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.report.betting.form.VPlayerGameOrderForm;
import so.wwb.gamebox.web.report.betting.form.VPlayerGameOrderSearchForm;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by linsen on 18-6-19.
 */
@Controller
@RequestMapping("/report/gameOrderLinkPopup")
public class GameOrderLinkPopupController extends BaseCrudController<IVPlayerGameOrderService, VPlayerGameOrderListVo, VPlayerGameOrderVo, VPlayerGameOrderSearchForm, VPlayerGameOrderForm, VPlayerGameOrder, Integer> {
    private static final Log LOG = LogFactory.getLog(GameOrderController.class);

    @Override
    protected String getViewBasePath() {
        return "/linkPopup/gameTransaction/";
    }

    /**
     * 玩家详细页面--有效投注额跳转
     *
     * @param listVo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/effectiveGameTransaction")
    public String linkPopupGameTransaction(VPlayerGameOrderListVo listVo, Model model, HttpServletRequest request) {
        listVo = ServiceSiteTool.vPlayerGameOrderService().queryEffectiveGameTransaction(listVo);
        listVo = setGameNameAndApiName(listVo);
        model.addAttribute("command",listVo);
        model.addAttribute("validateRule", JsRuleCreator.create(VPlayerGameOrderSearchForm.class));
        Map map = ServiceSiteTool.vPlayerGameOrderService().sumEffectiveGameTransaction(listVo);
        model.addAttribute("totalSingleAmount", MapTool.getString(map,"singleamount"));
        model.addAttribute("totalEffectiveTradeAmount", MapTool.getString(map,"effectivetradeamount"));
        model.addAttribute("totalProfitAmount", MapTool.getString(map,"profitamount"));

        if (ServletTool.isAjaxSoulRequest(request)) {
            return getViewBasePath() + "IndexPartial";
        } else {
            return getViewBasePath() + "Index";
        }
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
}
