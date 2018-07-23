package so.wwb.gamebox.mcenter.chess.controller;

import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.commons.support._Module;
import org.soul.model.common.BaseVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.cache.Cache;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.chess.form.VSiteGameSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.company.site.po.SiteGame;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.company.site.vo.SiteGameVo;
import so.wwb.gamebox.model.company.site.vo.SiteLanguageListVo;
import so.wwb.gamebox.model.company.site.vo.VSiteGameListVo;
import so.wwb.gamebox.model.company.site.vo.VSiteGameVo;
import so.wwb.gamebox.model.gameapi.enums.ApiTypeEnum;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 控制器
 *
 * @author linsen
 * @time 2018-7-12 15:08:52
 */
@Controller
//region your codes 1
@RequestMapping("/chessSiteGame")
public class ChessSiteGameController {
    //endregion your codes 1
    private static final Log LOG = LogFactory.getLog(ChessSiteGameController.class);
    //region your codes 2
    private final static String ORDER_URL = "/chess/gameManager/OrderSiteGame";

    //endregion your codes 2
    //region your codes 3
    @RequestMapping(value = "gameManager")
    public String chessSiteGame(VSiteGameListVo listVo, VSiteGameSearchForm form, BindingResult result, Model model, HttpServletRequest request) {
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        //手机端棋牌
        listVo = ServiceTool.vSiteGameService().searchChessSiteGameOfMobile(listVo);
        model.addAttribute("command", listVo);
        if (ServletTool.isAjaxSoulRequest(request)) {
            return "/chess/gameManager/IndexPartial";
        } else {
            return "/chess/gameManager/Index";
        }
    }


    /**
     * 更新站点API状态
     *
     * @param siteGameVo
     * @return
     */
    @RequestMapping("/updateStatus")
    @ResponseBody
    private Map<String, Object> updateStatus(SiteGameVo siteGameVo) {
        Integer siteId = SessionManager.getSiteId();
        Integer gameId = siteGameVo.getSearch().getGameId();
        Integer apiId = siteGameVo.getSearch().getApiId();
        Integer apiTypeId = ApiTypeEnum.CHESS.getCode();
        if (siteId == null || gameId == null || apiId == null || apiTypeId == null) {
            LOG.error("参数缺失：siteId={0}，gameId={1}，apiId={2}，apiTypeId={3}", siteId, gameId, apiId, apiTypeId);
            siteGameVo.setSuccess(false);
            return getVoMessage(siteGameVo);
        }
        SiteGame siteGame = ServiceTool.siteGameService().getSiteGame(siteGameVo);
        if (siteGame == null) {
            LOG.error("获取站点游戏为空");
            siteGameVo.setSuccess(false);
            return getVoMessage(siteGameVo);
        }
        siteGame.setStatus(siteGameVo.getSearch().getStatus());
        siteGameVo.setResult(siteGame);
        siteGameVo.setProperties(SiteGame.PROP_STATUS);
        siteGameVo = ServiceTool.siteGameService().updateOnly(siteGameVo);
        if (siteGameVo.isSuccess()) {
            //刷新站点手机端棋牌游戏
            refreshSiteGameCache(siteId,apiTypeId);
        }
        return getVoMessage(siteGameVo);
    }

    /**
     * 刷新手机端游戏缓存
     *
     * @param siteId
     * @param apiTypeId
     */
    private void refreshSiteGameCache(Integer siteId,Integer apiTypeId) {
        Cache.refreshSiteGame(siteId);
        Cache.refreshVSiteGame(siteId);

        SiteLanguageListVo siteLanguageListVo = new SiteLanguageListVo();
        siteLanguageListVo.getSearch().setSiteId(siteId);
        List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageListVo);
        for (SiteLanguage language : languageList) {
            Cache.refreshMobileGameCacheEntity(String.valueOf(siteId), language.getLanguage(), String.valueOf(apiTypeId));
            Cache.refreshMobileGameByApiType(String.valueOf(siteId), language.getLanguage(), String.valueOf(apiTypeId));
        }
    }

    private Map getVoMessage(BaseVo baseVo) {
        HashMap map = new HashMap(2, 1.0F);
        if (baseVo.isSuccess() && StringTool.isBlank(baseVo.getOkMsg())) {
            baseVo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "save.success", new Object[0]));
        } else if (!baseVo.isSuccess() && StringTool.isBlank(baseVo.getErrMsg())) {
            baseVo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "save.failed", new Object[0]));
        }

        map.put("msg", StringTool.isNotBlank(baseVo.getOkMsg()) ? baseVo.getOkMsg() : baseVo.getErrMsg());
        map.put("state", Boolean.valueOf(baseVo.isSuccess()));
        return map;
    }

    /**
     * 手机端棋牌游戏排序
     *
     * @param vSiteGameListVo
     * @param model
     * @return
     */
    @RequestMapping("/orderSiteGame")
    public String orderSiteGame(VSiteGameListVo vSiteGameListVo, Model model) {
        vSiteGameListVo.getSearch().setSiteId(SessionManager.getSiteId());
        vSiteGameListVo.setPaging(null);
        vSiteGameListVo = ServiceTool.vSiteGameService().getChessSiteGameOrderOfMobile(vSiteGameListVo);
        model.addAttribute("command", vSiteGameListVo);
        return ORDER_URL;
    }

    /**
     * 保存手机端棋牌游戏排序
     *
     * @param vSiteGameVo
     * @return
     */
    @RequestMapping(value = "/saveSiteGameOrder", method = RequestMethod.POST, headers = {"Content-type=application/json"})
    @ResponseBody
    public boolean saveSiteGameOrder(@RequestBody VSiteGameVo vSiteGameVo) {
        ServiceTool.vSiteGameService().saveSiteGameOrder(vSiteGameVo);
        //刷新站点手机端棋牌游戏
        refreshSiteGameCache(SessionManager.getSiteId(), ApiTypeEnum.CHESS.getCode());
        return true;
    }
    //endregion your codes 3

}
