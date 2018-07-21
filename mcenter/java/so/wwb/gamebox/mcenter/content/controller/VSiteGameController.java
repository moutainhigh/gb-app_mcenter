package so.wwb.gamebox.mcenter.content.controller;

import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.company.site.IVSiteGameService;
import so.wwb.gamebox.mcenter.content.form.VSiteGameForm;
import so.wwb.gamebox.mcenter.content.form.VSiteGameSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.company.enums.GameStatusEnum;
import so.wwb.gamebox.model.company.setting.po.ApiI18n;
import so.wwb.gamebox.model.company.setting.po.GameI18n;
import so.wwb.gamebox.model.company.setting.vo.ApiVo;
import so.wwb.gamebox.model.company.site.po.SiteApiI18n;
import so.wwb.gamebox.model.company.site.po.SiteGameI18n;
import so.wwb.gamebox.model.company.site.po.VSiteGame;
import so.wwb.gamebox.model.company.site.vo.*;
import so.wwb.gamebox.model.master.player.vo.PlayerApiListVo;
import so.wwb.gamebox.model.master.player.vo.PlayerGameLogVo;
import so.wwb.gamebox.model.master.player.vo.VPlayerApiListVo;
import so.wwb.gamebox.common.cache.Cache;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 控制器
 *
 * @author River
 * @time 2015-11-9 15:48:51
 */
@Controller
//region your codes 1
@RequestMapping("/vSiteGame")
public class VSiteGameController extends BaseCrudController<IVSiteGameService, VSiteGameListVo, VSiteGameVo, VSiteGameSearchForm, VSiteGameForm, VSiteGame, Integer> {

    private static final Log LOG = LogFactory.getLog(VSiteGameController.class);
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/gameManager/siteGame/";
        //endregion your codes 2
    }

    //region your codes 3
    private final static String ORDER_URL = "/content/gameManager/siteGame/OrderSiteGame";
    //两次刷新API余额
    private final static Integer BETWEEN_REFRESH_API_BALANCE_TIME = 20;

    @Override
    protected VSiteGameListVo doList(VSiteGameListVo listVo, VSiteGameSearchForm form, BindingResult result, Model model) {
        listVo = searchByGameName(listVo);
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo = super.doList(listVo, form, result, model);
        listVo = setCommonData(listVo);
        listVo = getApiStatus(listVo);
        setGameCache(model);
        return listVo;
    }

    private VSiteGameListVo searchByGameName(VSiteGameListVo listVo){
        if(StringTool.isBlank(listVo.getSearch().getSiteGameName())){
            return listVo;
        }
        SiteGameI18nListVo gameI18nListVo = new SiteGameI18nListVo();
        gameI18nListVo.getSearch().setName(listVo.getSearch().getSiteGameName());
        gameI18nListVo.setProperties(SiteGameI18n.PROP_GAME_ID);
        List<Integer> ids = ServiceTool.siteGameI18nService().searchProperty(gameI18nListVo);
        listVo.getSearch().setGameIds(ids);
        return listVo;
    }

    private VSiteGameListVo getApiStatus(VSiteGameListVo listVo) {
        if (listVo.getResult() == null) {
            return listVo;
        }
        for (VSiteGame vSiteGame : listVo.getResult()) {
            ApiVo apiVo = new ApiVo();
            apiVo.getSearch().setId(vSiteGame.getApiId());
            apiVo = ServiceTool.apiService().get(apiVo);
            if (apiVo.getResult() != null) {
                if (GameStatusEnum.MAINTAIN.getCode().equals(apiVo.getResult().getSystemStatus())) {
                    vSiteGame.setRealStatus(GameStatusEnum.MAINTAIN.getCode());
                    vSiteGame.setMaintainStartTime(apiVo.getResult().getMaintainStartTime());
                    vSiteGame.setMaintainEndTime(apiVo.getResult().getMaintainEndTime());
                } else {
                    vSiteGame.setRealStatus(vSiteGame.getSystemStatus());
                }
            }
        }
        return listVo;
    }

    private VSiteGameListVo setCommonData(VSiteGameListVo listVo) {
        VSiteApiVo vSiteApiVo = new VSiteApiVo();
        vSiteApiVo.getSearch().setApiId(listVo.getSearch().getApiId());
        vSiteApiVo.getSearch().setSiteId(SessionManager.getSiteId());
        vSiteApiVo = this.getService().fetchVSiteApiVo(vSiteApiVo);
        listVo.setSiteApi(vSiteApiVo.getResult());
        listVo = setApiBalanceData(listVo);
        listVo.setYesterdayPlayerCount(getYesterdayApiPlayerCount(listVo));
        if (listVo.getResult() != null && listVo.getResult().size() > 0) {
            for (VSiteGame game : listVo.getResult()) {
                Integer count = getYesterdayPlayerCount(game);
                game.setYesterdayCount(count);
                count = getPlayerCount(game);
                game.setPlayerCount(count);
            }
        }
        return listVo;
    }


    @RequestMapping("/orderSiteGame")
    public String orderSiteGame(VSiteGameListVo vSiteGameListVo, Model model) {
        setGameCache(model);
        vSiteGameListVo.getSearch().setSiteId(SessionManager.getSiteId());
        vSiteGameListVo.setPaging(null);
        vSiteGameListVo = this.getService().search(vSiteGameListVo);
        vSiteGameListVo = setCommonData(vSiteGameListVo);
        model.addAttribute("command", vSiteGameListVo);
        /*VSiteApiVo vSiteApiVo = new VSiteApiVo();
        vSiteApiVo.getSearch().setSiteId(SessionManager.getSiteId());
        vSiteApiVo.getSearch().setApiId(vSiteGameListVo.getSearch().getApiId());
        vSiteApiVo = this.getService().fetchVSiteApiVo(vSiteApiVo);
        vSiteGameListVo.setSiteApi(vSiteApiVo.getResult());*/
        return ORDER_URL;
    }

    @RequestMapping(value = "/saveSiteGameOrder", method = RequestMethod.POST, headers = {"Content-type=application/json"})
    @ResponseBody
    public boolean saveSiteGameOrder(@RequestBody VSiteGameVo vSiteGameVo, Model model) {
        this.getService().saveSiteGameOrder(vSiteGameVo);
        return true;
    }

    private void setGameCache(Model model) {
        Map<String, SiteGameI18n> siteGameI18nMap = Cache.getSiteGameI18n();
        Map<String, GameI18n> gameI18nMap = Cache.getGameI18n();
        model.addAttribute("game", gameI18nMap);
        model.addAttribute("siteGames", siteGameI18nMap);
        Map<String, SiteApiI18n> siteApiI18nMap = Cache.getSiteApiI18n();
        model.addAttribute("siteApis", siteApiI18nMap);
        Map<String, ApiI18n> apiI18nMap = Cache.getApiI18n();
        model.addAttribute("apis", apiI18nMap);
    }

    /**
     * 踢出
     *
     * @param siteApiVo
     * @param model
     * @return
     */
    @RequestMapping(value = "/kickoutApiPlayer")
    @ResponseBody
    public Map<String, Object> kickoutApiPlayer(SiteApiVo siteApiVo, Model model) {
        Map<String, Object> result = new HashMap<>();
        try {
            PlayerApiListVo listVo = new PlayerApiListVo();
            listVo.getSearch().setApiId(siteApiVo.getSearch().getApiId());
            listVo = ServiceSiteTool.playerApiService().kickoutApi(listVo);
            result.put("state", listVo.isSuccess());
        } catch (Exception ex) {
            result.put("state", false);
            LOG.error(ex);
        }
        return result;
    }

    private VSiteGameListVo setApiBalanceData(VSiteGameListVo vSiteGameListVo) {
        vSiteGameListVo.setApiBalance(getApiBalance(vSiteGameListVo));
        PlayerApiListVo playerApiListVo = new PlayerApiListVo();
        playerApiListVo.getSearch().setApiId(vSiteGameListVo.getSearch().getApiId());
        Date date = ServiceSiteTool.playerApiService().getLastRefreshTime(playerApiListVo);
        SessionManager.setLastRefreshApiBalanceTime(date);
        return vSiteGameListVo;
    }

    private double getApiBalance(VSiteGameListVo vSiteGameListVo) {
        VPlayerApiListVo playerApiListVo = new VPlayerApiListVo();
        playerApiListVo.getSearch().setApiId(vSiteGameListVo.getSearch().getApiId());
        Number number = ServiceSiteTool.playerApiService().queryApiSumMoney(playerApiListVo);
        if (number != null) {
            return number.doubleValue();
        }
        return 0d;
    }

    /**
     * 刷新余额
     *
     * @param vSiteGameListVo
     * @return
     */
    @RequestMapping(value = "/refreshApiBalance")
    @ResponseBody
    public Map<String, Object> refreshApiBalance(VSiteGameListVo vSiteGameListVo) {
        Map<String, Object> result = new HashMap<>();
        try {
            Date date = DateQuickPicker.getInstance().getNow();
            Date lastDate = SessionManager.getLastRefreshApiBalanceTime();
            if (lastDate != null && DateTool.minutesBetween(date, lastDate) < BETWEEN_REFRESH_API_BALANCE_TIME) {
                String msg = LocaleTool.tranMessage("content", "game.refreshApiTooFast");
                result.put("err", msg);
                return result;
            }
            String refreshTime = DateTool.formatDate(date, CommonContext.getDateFormat().getDAY_SECOND());
            SessionManager.setLastRefreshApiBalanceTime(date);
            result.put("refreshTime", refreshTime);
            PlayerApiListVo playerApiListVo = new PlayerApiListVo();
            playerApiListVo.getSearch().setApiId(vSiteGameListVo.getSearch().getApiId());
            playerApiListVo.setType(VPlayerApiListVo.REFRESH_SINGLE_API);
            //ShareController.fetchPlayerApiBalance(playerApiListVo);
            VPlayerApiListVo vPlayerApiListVo = new VPlayerApiListVo();
            vPlayerApiListVo.setType(vPlayerApiListVo.REFRESH_SINGLE_API);
            vPlayerApiListVo.setIp(SessionManager.getIpDb().getIp());
            vPlayerApiListVo.getSearch().setApiId(vSiteGameListVo.getSearch().getApiId());
            Number number = ServiceSiteTool.playerApiService().queryApiSumMoney(vPlayerApiListVo);
            if (number != null) {
                String balance = CurrencyTool.formatCurrency(number.doubleValue());
                result.put("balance", balance);
            }

        } catch (Exception ex) {
            String msg = LocaleTool.tranMessage("content", "game.refreshApiBalanceError");
            result.put("err", msg);
            LOG.error(ex);
        }


        return result;
    }

    /**
     * 资金回收
     *TODO：：隐藏回收单个api功能
     * @param vSiteGameListVo
     * @return
     */
   /* @RequestMapping(value = "/withdrawBalance")
    @ResponseBody
    public Map<String, Object> withdrawBalance(VSiteGameListVo vSiteGameListVo) {
        Map<String, Object> result = new HashMap<>();
        try {
            execRecovery(vSiteGameListVo);
            result.put("state", true);
        } catch (Exception ex) {
            result.put("state", false);
            ex.printStackTrace();
        }

        return result;
    }

    private void execRecovery(VSiteGameListVo vSiteGameListVo) {
        IApiFundRecoveryService apiFundRecoveryService = (IApiFundRecoveryService) SpringTool.getBean("apiFundRecoveryService");
        ApiFundRecoveryVo apiFundRecoveryVo = new ApiFundRecoveryVo();
        apiFundRecoveryVo.setSiteId(SessionManager.getSiteId());
        apiFundRecoveryVo.setApiId(vSiteGameListVo.getSearch().getApiId());
        apiFundRecoveryVo.setIp(SessionManager.getIpDb().getIp());
        apiFundRecoveryVo.setOperator(SessionManager.getUserName());
        apiFundRecoveryVo.setOperatorId(SessionManager.getUserId());
        try {
            apiFundRecoveryService.recovery(apiFundRecoveryVo);
        } catch (Exception e) {
            LOG.error(e, "发起API资金回收异常");
        }
    }*/

    private Integer getYesterdayApiPlayerCount(VSiteGameListVo vSiteGameListVo) {
        PlayerGameLogVo logVo = new PlayerGameLogVo();
        logVo.getSearch().setApiId(vSiteGameListVo.getSearch().getApiId());
        DateQuickPicker dp = SessionManager.getDate();
        Date now = dp.getToday();
        Date start = DateTool.addDays(now, -1);
        logVo.getSearch().setLoginEndTime(now);
        logVo.getSearch().setLoginStartTime(start);
        logVo._setDataSourceId(SessionManager.getSiteId());
        Integer playerCount = ServiceSiteTool.playerGameLogService().getPlayerCountBySiteApi(logVo);
        return playerCount;
    }

    private Integer getYesterdayPlayerCount(VSiteGame vSiteGame) {
        PlayerGameLogVo logVo = new PlayerGameLogVo();
        logVo.getSearch().setGameId(vSiteGame.getGameId());
        DateQuickPicker dp = SessionManager.getDate();
        Date now = dp.getToday();
        Date start = DateTool.addDays(now, -1);
        logVo.getSearch().setLoginEndTime(now);
        logVo.getSearch().setLoginStartTime(start);
        Integer playerCount = ServiceSiteTool.playerGameLogService().getPlayerCountByGame(logVo);
        return playerCount;
    }

    private Integer getPlayerCount(VSiteGame vSiteGame) {
        PlayerGameLogVo logVo = new PlayerGameLogVo();
        logVo.getSearch().setGameId(vSiteGame.getGameId());
        DateQuickPicker dp = SessionManager.getDate();
        Date now = dp.getToday();
        Date start = DateTool.addDays(now, -30);
        logVo.getSearch().setLoginEndTime(now);
        logVo.getSearch().setLoginStartTime(start);
        Integer playerCount = ServiceSiteTool.playerGameLogService().getPlayerCountByGame(logVo);
        return playerCount;
    }
    //endregion your codes 3

}
