package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.BooleanTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.commons.spring.utils.SpringTool;
import org.soul.model.security.privilege.po.SysUser;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.player.IPlayerTransactionService;
import so.wwb.gamebox.mcenter.player.form.PlayerTransactionForm;
import so.wwb.gamebox.mcenter.player.form.PlayerTransactionSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.share.controller.ShareController;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.api.vo.ApiFundRecoveryVo;
import so.wwb.gamebox.model.company.site.po.SiteApi;
import so.wwb.gamebox.model.enums.ApiQueryTypeEnum;
import so.wwb.gamebox.model.master.player.po.PlayerApi;
import so.wwb.gamebox.model.master.player.po.PlayerApiAccount;
import so.wwb.gamebox.model.master.player.po.PlayerTransaction;
import so.wwb.gamebox.model.master.player.vo.*;
import so.wwb.gamebox.model.master.report.vo.VPlayerTransactionListVo;
import so.wwb.gamebox.web.api.IApiFundRecoveryService;
import so.wwb.gamebox.web.cache.Cache;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 玩家信息-资金
 * <p/>
 * Created by cheery on 15-6-23.
 */
@Controller
@RequestMapping("/playerFunds")
public class PlayerFundsController extends BaseCrudController<IPlayerTransactionService, PlayerTransactionListVo, PlayerTransactionVo, PlayerTransactionSearchForm, PlayerTransactionForm, PlayerTransaction, Integer> {
    private static final Log LOG = LogFactory.getLog(PlayerFundsController.class);
    private static final String FUNDS_URI = "/player/view.include/Funds";
    private static final String MORE_FUNDS_URI = "/player/funds/MoreFunds";
    private static final String FUNDS_PARTIAL_URI = "/player/funds/IndexPartial";
    private static final String FUNDS_API_SCARE_URI = "/player/funds/ApiScare";
    private static final String FUNDS_RECOVERY_FUNDS_URI = "/player/funds/recoveryFunds";

    @Override
    protected String getViewBasePath() {
        return null;
    }

    /**
     * 玩家信息-资金默认页面
     *
     * @param model
     * @param listVo
     * @param playerId
     * @return
     */
    @RequestMapping("/funds")
    protected String funds(Model model, PlayerTransactionListVo listVo, Integer playerId) {
        listVo.getSearch().setPlayerId(playerId);
        model.addAttribute("refreshType", "all");
        //交易记录
        queryTransaction(model, listVo);
        return FUNDS_URI;
    }

    @RequestMapping("/queryListByView")
    protected String queryListByView(VPlayerTransactionListVo listVo, Integer playerId, Model model) {
        listVo.getSearch().setPlayerId(playerId);
        model.addAttribute("refreshType", "all");
        queryList(listVo, model);
        PlayerTransactionListVo transactionListVo = new PlayerTransactionListVo();
        transactionListVo.getSearch().setPlayerId(playerId);
        Map map = getService().transactionTotal(transactionListVo);//交易总计
        model.addAttribute("transactionTotal", map);
        return FUNDS_URI;

    }

    private void queryList(VPlayerTransactionListVo listVo, Model model) {
        listVo.getQuery().getPageOrderMap();
        listVo = ServiceSiteTool.vPlayerTransactionService().search(listVo);//交易列表
        listVo.getQuery().getPageOrderMap();
         /*字典*/
        listVo.setDictCommonTransactionType(DictTool.get(DictEnum.COMMON_TRANSACTION_TYPE));

        listVo.setDictCommonStatus(DictTool.get(DictEnum.COMMON_STATUS));
        model.addAttribute("command", listVo);
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.setResult(new SysUser());
        sysUserVo.getSearch().setId(listVo.getSearch().getPlayerId());
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        model.addAttribute("sysUserVo", sysUserVo);
    }

    /**
     * 刷新
     *
     * @param model
     * @param listVo
     * @return
     */
    @RequestMapping("/refresh")
    protected String refresh(Model model, PlayerApiListVo listVo) {
        queryApiData(model, listVo);
        return FUNDS_API_SCARE_URI;
    }

    private void queryApiData(Model model, PlayerApiListVo listVo) {
        //查询玩家api数据
        VUserPlayerVo vo = new VUserPlayerVo();
        vo.getSearch().setId(listVo.getSearch().getPlayerId());
        vo = ServiceSiteTool.vUserPlayerService().get(vo);
        model.addAttribute("player", vo.getResult());
        //上次同步API余额时间
        PlayerApiListVo playerApiListVo = new PlayerApiListVo();
        playerApiListVo.getSearch().setPlayerId(listVo.getSearch().getPlayerId());
        playerApiListVo.setType(ApiQueryTypeEnum.ALL_API.getCode());
        ShareController.fetchPlayerApiBalanceByTimeLimit(vo.getResult().getSynchronizationTime(), playerApiListVo);

        refreshFunds(listVo.getSearch().getPlayerId(), model);
    }

    /**
     * 选择时间范围、状态、类型查询交易列表
     *
     * @param listVo
     * @param model
     * @return
     */
    @RequestMapping("/transactionList")
    protected String transactionList(VPlayerTransactionListVo listVo, Model model) {
        //queryTransaction(model, listVo);
        queryList(listVo, model);
        return FUNDS_PARTIAL_URI;
    }

    /**
     * 查看更多
     *
     * @param listVo
     * @param playerId
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/moreFunds")
    protected String moreFunds(PlayerTransactionListVo listVo, Integer playerId, Model model, HttpServletRequest request) {
        listVo.getSearch().setPlayerId(playerId);
        Date endTime = DateTool.truncate(SessionManager.getDate().getToday(), Calendar.DAY_OF_MONTH);
        //默认显示近90天
        if (listVo.getSearch().getBeginCreateTime() == null) {
            listVo.getSearch().setBeginCreateTime(DateTool.addDays(endTime, -90));
        }
        if (listVo.getSearch().getEndCreateTime() == null) {
            listVo.getSearch().setEndCreateTime(SessionManager.getDate().getToday());
        }
        listVo = getService().search(listVo);
        model.addAttribute("command", listVo);
        return ServletTool.isAjaxSoulRequest(request) ? MORE_FUNDS_URI + "Partial" : MORE_FUNDS_URI;
    }

    /**
     * 查询总资产、钱包余额以及各个游戏金额
     *
     * @param playerId
     * @param model
     */
    protected void refreshFunds(Integer playerId, Model model) {
        //玩家api占比金额
        PlayerApiListVo listVo = new PlayerApiListVo();
        listVo.getSearch().setPlayerId(playerId);
        listVo.setSiteGame(Cache.getSiteGame());
        listVo = ServiceSiteTool.playerApiService().calculateScale(listVo);
        model.addAttribute("listVo", listVo);
    }

    /**
     * 查询交易记录
     *
     * @param model
     */
    protected void queryTransaction(Model model, PlayerTransactionListVo listVo) {
        listVo.getQuery().getPageOrderMap();
        listVo = getService().search(listVo);//交易列表
        listVo.getQuery().getPageOrderMap();
         /*字典*/
        listVo.setDictCommonTransactionType(DictTool.get(DictEnum.COMMON_TRANSACTION_TYPE));

        listVo.setDictCommonStatus(DictTool.get(DictEnum.COMMON_STATUS));
        model.addAttribute("command", listVo);
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.setResult(new SysUser());
        sysUserVo.getSearch().setId(listVo.getSearch().getPlayerId());
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        model.addAttribute("sysUserVo", sysUserVo);
        Map map = getService().transactionTotal(listVo);//交易总计
        model.addAttribute("transactionTotal", map);
    }

    /**
     * 跳转至回收资金
     *
     * @param listVo VPlayerApiListVo
     * @param model  Model
     * @return url
     */
    @RequestMapping("/recoveryFunds")
    protected String recoveryFunds(VPlayerApiListVo listVo, Model model) {
        Integer userId = listVo.getSearch().getUserId();
        // 查询玩家api
        model.addAttribute("apis", getPlayerApiByUser(userId));
        // 查询玩家
        model.addAttribute("player", getSysUser(userId));
        return FUNDS_RECOVERY_FUNDS_URI;
    }

    /**
     * 查询玩家信息
     *
     * @param userId Integer
     * @return SysUser
     */
    private SysUser getSysUser(Integer userId) {
        SysUserVo userVo = new SysUserVo();
        userVo.getSearch().setId(userId);
        userVo = ServiceTool.sysUserService().get(userVo);
        return userVo.getResult();
    }

    /**
     * 查询玩家API
     *
     * @param userId Integer
     * @return List<VPlayerApi>
     */
    private List<PlayerApi> getPlayerApiByUser(Integer userId) {
        PlayerApiVo playerApiVo = new PlayerApiVo();
        playerApiVo.getSearch().setPlayerId(userId);
        return ServiceSiteTool.playerApiService().queryPlayerApi(playerApiVo);
    }

    /**
     * 确定回收资金
     *
     * @param playerApiVo PlayerApiVo
     * @return Map
     */
    @RequestMapping("/recovery")
    @ResponseBody
    protected Map recovery(PlayerApiVo playerApiVo) {
        execRecovery(playerApiVo);
        return showMap(playerApiVo);
    }


    /**
     * 执行回收任务
     *
     * @param apiVo PlayerApiVo
     */
    private void execRecovery(PlayerApiVo apiVo) {
        IApiFundRecoveryService apiFundRecoveryService = (IApiFundRecoveryService) SpringTool.getBean("apiFundRecoveryService");
        ApiFundRecoveryVo apiFundRecoveryVo = new ApiFundRecoveryVo();
        apiFundRecoveryVo.setSiteId(SessionManager.getSiteId());
        apiFundRecoveryVo.setApiId(apiVo.getSearch().getApiId());
        apiFundRecoveryVo.setUserId(apiVo.getSearch().getPlayerId());
        apiFundRecoveryVo.setIp(SessionManager.getIpDb().getIp());
        apiFundRecoveryVo.setOperator(SessionManager.getUserName());
        apiFundRecoveryVo.setOperatorId(SessionManager.getUserId());
        try {
            apiFundRecoveryService.recovery(apiFundRecoveryVo);
        } catch (Exception e) {
            LOG.error(e, "发起API资金回收异常");
        }
    }

    /**
     * 显示执行提示信息
     *
     * @param apiVo PlayerApiVo
     * @return Map
     */
    private Map showMap(PlayerApiVo apiVo) {
        Map<String, Object> map = new HashMap<>(2, 1f);
        //map.put("msg", LocaleTool.tranMessage(_Module.COMMON, "recovery.process"));
        map.put("state", apiVo.isSuccess());
        return map;
    }

    @RequestMapping("/queryApiFundsRecord")
    public String queryApiFundsRecord(PlayerApiListVo listVo, Model model) {
        queryApiData(model, listVo);

        Map<String, SiteApi> siteApi = Cache.getSiteApi();
        model.addAttribute("allApiMap", siteApi);
        Map<Integer, PlayerApiAccount> apiAccountMap = queryApiUserName(listVo.getSearch().getPlayerId());
        model.addAttribute("apiAccountMap", apiAccountMap);
        Map<Integer, PlayerApi> playerApiMap = searchRecoveryStatus(listVo.getSearch().getPlayerId());
        model.addAttribute("playerApiMap", playerApiMap);

        model.addAttribute("apiTotalBalance", fetchAllApiBalance(listVo.getSearch().getPlayerId()));
        model.addAttribute("allIsNormal", allIsNormal(listVo.getSearch().getPlayerId()));
        return "/player/view.include/ApiData";
    }

    private Map<Integer, PlayerApiAccount> queryApiUserName(Integer userId) {
        PlayerApiAccountListVo apiAccountListVo = new PlayerApiAccountListVo();
        apiAccountListVo.getSearch().setUserId(userId);
        apiAccountListVo.setPaging(null);
        apiAccountListVo = ServiceSiteTool.playerApiAccountService().search(apiAccountListVo);
        Map<Integer, PlayerApiAccount> apiAccountMap = new HashMap<>();
        if (apiAccountListVo.getResult() != null) {
            for (PlayerApiAccount account : apiAccountListVo.getResult()) {
                apiAccountMap.put(account.getApiId(), account);
            }
        }
        return apiAccountMap;
    }

    private Double fetchAllApiBalance(Integer userId) {
        List<PlayerApi> playerApiByUser = getPlayerApiByUser(userId);
        Double balance = 0d;
        if (playerApiByUser != null && playerApiByUser.size() > 0) {
            for (PlayerApi playerApi : playerApiByUser) {
                if (playerApi.getMoney() != null) {
                    balance += playerApi.getMoney();
                }
            }
        }
        return balance;
    }

    private Map<Integer, PlayerApi> searchRecoveryStatus(Integer userId) {
        List<PlayerApi> playerApiByUser = getPlayerApiByUser(userId);
        Map<Integer, PlayerApi> playerApiMap = new HashMap<>();
        if (playerApiByUser != null && playerApiByUser.size() > 0) {
            for (PlayerApi playerApi : playerApiByUser) {
                playerApiMap.put(playerApi.getApiId(), playerApi);
            }
        }
        return playerApiMap;
    }

    private boolean allIsNormal(Integer userId) {
        boolean flag = true;
        List<PlayerApi> playerApiByUser = getPlayerApiByUser(userId);
        if (playerApiByUser != null && playerApiByUser.size() > 0) {
            for (PlayerApi playerApi : playerApiByUser) {
                if (BooleanTool.isTrue(playerApi.getTaskStatus())) {
                    flag = false;
                }
            }
        } else {
            return flag;
        }
        return flag;
    }

    @RequestMapping("/refreshSingleApi")
    @ResponseBody
    public PlayerApi refreshSingleApi(PlayerApiListVo listVo) {
        if (listVo.getSearch().getApiId() == null || listVo.getSearch().getPlayerId() == null) {
            return new PlayerApi();
        }
        //同步玩家api余额
        ShareController.fetchPlayerApiBalance(listVo);
        Map<Integer, PlayerApi> playerApiMap = searchRecoveryStatus(listVo.getSearch().getPlayerId());
        PlayerApi playerApi = playerApiMap.get(listVo.getSearch().getApiId());
        if (playerApi != null) {
            return playerApi;
        }
        return new PlayerApi();
    }


}
