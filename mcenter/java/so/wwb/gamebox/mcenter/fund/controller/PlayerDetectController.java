package so.wwb.gamebox.mcenter.fund.controller;

import org.soul.commons.collections.MapTool;
import org.soul.commons.init.context.Const;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.commons.security.CryptoTool;
import org.soul.commons.security.key.CryptoKey;
import org.soul.model.sys.po.SysAuditLog;
import org.soul.model.sys.so.SysAuditLogSo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.session.RedisSessionDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.player.IVUserPlayerService;
import so.wwb.gamebox.mcenter.player.form.VUserPlayerForm;
import so.wwb.gamebox.mcenter.player.form.VUserPlayerSearchForm;
import so.wwb.gamebox.mcenter.share.controller.ShareController;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.ModuleType;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.enums.CommonStatusEnum;
import so.wwb.gamebox.model.master.fund.enums.TransactionTypeEnum;
import so.wwb.gamebox.model.master.player.enums.UserBankcardTypeEnum;
import so.wwb.gamebox.model.master.player.po.VUserPlayer;
import so.wwb.gamebox.model.master.player.so.VUserPlayerSo;
import so.wwb.gamebox.model.master.player.vo.*;
import so.wwb.gamebox.model.master.report.vo.VPlayerTransactionListVo;
import so.wwb.gamebox.web.bank.BankHelper;
import so.wwb.gamebox.web.cache.Cache;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by suyj on 15-8-14.
 */
@Controller
@RequestMapping(value = "/fund/playerDetect")
public class PlayerDetectController extends BaseCrudController<IVUserPlayerService, VUserPlayerListVo, VUserPlayerVo, VUserPlayerSearchForm, VUserPlayerForm, VUserPlayer, Integer> {

    //region suyj code
    private static final Log LOG = LogFactory.getLog(PlayerDetectController.class);
    /**
     * 玩家检测页面
     */
    private static final String PLAYERDETECTION_INDEX_URI = "/fund/player.detect/Index";

    /**
     * 备注列表页面
     */
    private static final String REMARK_LIST_URI = "/fund/player.detect/RemarkList";

    /**
     * ip登录列表页面
     */
    private static final String LOGINIP_LIST_URI = "/fund/player.detect/LoginIpList";

    /**
     * 玩家检测-资金记录页面
     */
    private static final String FUND_RECORD_URI = "/fund/player.detect/FundRecord";
    public static final String FUND_PLAYER_DETECT_BANK_LIST = "/fund/player.detect/BankList";
    /**
     * 玩家检测-盈亏排行
     */
    private static final String GAME_ORDER_URI = "/fund/player.detect/GameOrder";
    /**
     * 玩家检测-优惠统计
     */
    private static final String SALE_URI = "/fund/player.detect/Sale";

    @Autowired
    private RedisSessionDao redisSessionDao;

    @Override
    protected String getViewBasePath() {
        return "/fund/player.detect/";
    }

    /**
     * 玩家账号详情
     *
     * @param objVo
     * @param model
     * @return
     */
    @RequestMapping("/userPlayView")
    public String userPlayView(VUserPlayerVo objVo, Model model, HttpServletRequest request) {
        VUserPlayerSo so = objVo.getSearch();
        if (StringTool.isBlank(so.getUsername())) {
            objVo = new VUserPlayerVo();
        } else {
            so.setUsername(so.getUsername().toLowerCase());
            objVo = getService().search(objVo);

            // 反水包含人工存入反水 bug-10207
            if (objVo != null && objVo.getResult() != null) {
                Double rakeback = ServiceTool.getPlayerTransactionService().queryManualRakeback(objVo);
                objVo.getResult().setRakeback(objVo.getResult().getRakeback() + (rakeback == null ? 0.0d : rakeback));
            }

            if (objVo.getResult() == null) {
                model.addAttribute("error", LocaleTool.tranMessage(Module.FUND, "fund.player.check"));
            } else {
                repeatNum(objVo);
                //playerApiList(objVo.getResult().getId(), model);
                //playerGameOrderList(objVo.getResult().getId(), model);
               /* playerTransactionMap(objVo.getResult().getId(), model);
                countPlayerFavorable(objVo.getResult().getId(), model);*/
                playerTransactionMap(objVo.getResult().getId(), model);
                try {
                    if (StringTool.isNotBlank(objVo.getResult().getRealName())) {
                        String convertRealName = URLEncoder.encode(URLEncoder.encode(objVo.getResult().getRealName(), Const.DEFAULT_CHARACTER), Const.DEFAULT_CHARACTER);
                        objVo.setConvertRealName(convertRealName);
                    }
                } catch (UnsupportedEncodingException e) {
                    LOG.error(e, "玩家检测--真实姓名转换错误");
                }
            }

        }
        if (objVo.getResult() != null) {
            objVo = fetchRakebackWithManual(objVo);
            //objVo.getResult().setOnLineId(redisSessionDao.getUserActiveSessions(UserTypeEnum.PLAYER.getCode(), objVo.getResult().getId()).size());
        }
        model.addAttribute("command1", objVo);
        if (objVo.getResult() != null) {
            model.addAttribute("playerMoneyData", queryPlayerMoney(objVo.getResult().getId()));
        }

        return ServletTool.isAjaxSoulRequest(request) ? PLAYERDETECTION_INDEX_URI + "Partial" : PLAYERDETECTION_INDEX_URI;
    }

    public Map queryPlayerMoney(Integer playerId) {
        Map map = new HashMap();
        if (playerId == null) {
            return map;
        }
        PlayerTransactionListVo playerTransactionListVo = new PlayerTransactionListVo();
        playerTransactionListVo.getSearch().setPlayerId(playerId);
        playerTransactionListVo.getSearch().setStatus(CommonStatusEnum.SUCCESS.getCode());
        map = ServiceTool.getPlayerTransactionService().queryPlayerAllSumMoney(playerTransactionListVo);
        return map;
    }

    @RequestMapping("/gameOrder")
    public String gameOrder(Model model, Integer playerId) {
        playerGameOrderList(playerId, model);
        return GAME_ORDER_URI;
    }

    @RequestMapping("/sale")
    public String sale(Model model, Integer playerId, String username, Double rakeback) {
        countPlayerFavorable(playerId, model);
        playerFavorableCount(playerId, model);
        model.addAttribute("username", username);
        model.addAttribute("rakeback", rakeback);
        return SALE_URI;
    }

    private VUserPlayerVo fetchRakebackWithManual(VUserPlayerVo vUserPlayerVo) {
        VPlayerTransactionListVo transactionListVo = new VPlayerTransactionListVo();
        transactionListVo.getSearch().setUsername(vUserPlayerVo.getResult().getUsername());
        Map<String, Object> stringObjectMap = ServiceTool.vPlayerTransactionService().queryPlayerRakebackAmount(transactionListVo);
        if (stringObjectMap.get("totalMoney") != null) {
            Double totalMoney = MapTool.getDouble(stringObjectMap, "totalMoney");
            vUserPlayerVo.getResult().setRakeback(totalMoney);
        }
        /*Double aDouble = getService().fetchRakebackWithManual(vUserPlayerVo);
        if(aDouble!=null){
            Double rakeback = vUserPlayerVo.getResult().getRakeback();
            if(rakeback!=null){
                rakeback += aDouble;
            }
            vUserPlayerVo.getResult().setRakeback(rakeback);
        }*/
        return vUserPlayerVo;
    }

    /**
     * 计算重复个数
     *
     * @param objVo
     */
    private void repeatNum(VUserPlayerVo objVo) {

        Map<String, Integer> repeatMap = new HashMap<String, Integer>();
        VUserPlayer vUserPlayer = objVo.getResult();
        String realName = vUserPlayer.getRealName();
        String mail = vUserPlayer.getMail();
        String phone = vUserPlayer.getMobilePhone();
        Long registerIp = vUserPlayer.getRegisterIp();

        //查询真实名字的重复个数
        if (StringTool.isBlank(realName)) {
            repeatMap.put(VUserPlayer.PROP_REAL_NAME, 0);
        } else {
            Map<String, Object> realNameMap = new HashMap<String, Object>();
            realNameMap.put(VUserPlayer.PROP_ID, vUserPlayer.getId());
            realNameMap.put(VUserPlayer.PROP_REAL_NAME, realName);
            objVo.setRepeatNumMap(realNameMap);
            Map<String, Object> realNameNumMap = ServiceTool.vUserPlayerService().countRepeat(objVo);
            repeatMap.put(VUserPlayer.PROP_REAL_NAME, realNameNumMap.get("repeatnum") != null ? Integer.valueOf(realNameNumMap.get("repeatnum").toString()) : 0);
        }

        //查询邮箱的重复个数
        if (StringTool.isBlank(mail)) {
            repeatMap.put(VUserPlayer.PROP_MAIL, 0);
        } else {
            Map<String, Object> mailMap = new HashMap<String, Object>();
            String email = CryptoTool.aesEncrypt(mail, CryptoKey.KEY_NOTICE_CONTACT_WAY);
            mailMap.put(VUserPlayer.PROP_MAIL, email);
            mailMap.put(VUserPlayer.PROP_ID, vUserPlayer.getId());
            objVo.setRepeatNumMap(mailMap);
            Map<String, Object> mailNumMap = ServiceTool.vUserPlayerService().countRepeat(objVo);
            repeatMap.put(VUserPlayer.PROP_MAIL, mailNumMap.get("repeatnum") != null ? Integer.valueOf(mailNumMap.get("repeatnum").toString()) : 0);
        }

        //查询手机的重复个数
        if (StringTool.isBlank(phone)) {
            repeatMap.put(VUserPlayer.PROP_MOBILE_PHONE, 0);
        } else {
            Map<String, Object> mobilePhoneMap = new HashMap<String, Object>();
            String cellPhone = CryptoTool.aesEncrypt(phone, CryptoKey.KEY_NOTICE_CONTACT_WAY);
            mobilePhoneMap.put(VUserPlayer.PROP_MOBILE_PHONE, cellPhone);
            mobilePhoneMap.put(VUserPlayer.PROP_ID, vUserPlayer.getId());
            objVo.setRepeatNumMap(mobilePhoneMap);
            Map<String, Object> mobilePhoneNumMap = ServiceTool.vUserPlayerService().countRepeat(objVo);
            repeatMap.put(VUserPlayer.PROP_MOBILE_PHONE, mobilePhoneNumMap.get("repeatnum") != null ? Integer.valueOf(mobilePhoneNumMap.get("repeatnum").toString()) : 0);
        }

        //查询注册IP一样的玩家个数
        if (registerIp == null) {
            repeatMap.put(VUserPlayer.PROP_REGISTER_IP, 0);
        } else {
            Map<String, Object> iPMap = new HashMap<String, Object>();
            iPMap.put(VUserPlayer.PROP_REGISTER_IP, registerIp);
            iPMap.put(VUserPlayer.PROP_ID, vUserPlayer.getId());
            objVo.setRepeatNumMap(iPMap);
            Map<String, Object> iPNumMap = ServiceTool.vUserPlayerService().countRepeat(objVo);
            repeatMap.put(VUserPlayer.PROP_REGISTER_IP, iPNumMap.get("repeatnum") != null ? Integer.valueOf(iPNumMap.get("repeatnum").toString()) : 0);
        }
        objVo.setRepeatMap(repeatMap);
    }

    /**
     * 获取该玩家的API信息
     *
     * @param playerId
     * @param model
     */
    private void playerApiList(Integer playerId, Model model) {
        PlayerApiListVo playerApiListVo = new PlayerApiListVo();
        playerApiListVo.getSearch().setPlayerId(playerId);
        playerApiListVo.setSiteGame(Cache.getSiteGame());
        playerApiListVo = ServiceTool.playerApiService().calculateScale(playerApiListVo);
        model.addAttribute("apiList", playerApiListVo);
    }

    /**
     * 获取该玩家的交易记录
     *
     * @param playerId
     * @param model
     */
    private void playerGameOrderList(Integer playerId, Model model) {
        PlayerGameOrderListVo playerGameOrderListVo = new PlayerGameOrderListVo();
        playerGameOrderListVo.getSearch().setPlayerId(playerId);
        Map<String, Object> gameOrderMap = ServiceTool.playerGameOrderService().searchTotal(playerGameOrderListVo);
        model.addAttribute("gameOrderMap", gameOrderMap);
    }

    /**
     * 获取该玩家的存取款信息
     *
     * @param playerId
     * @param model
     */
    private void playerTransactionMap(Integer playerId, Model model) {
        PlayerTransactionListVo playerTransactionListVo = new PlayerTransactionListVo();
        playerTransactionListVo.getSearch().setPlayerId(playerId);
        Map<String, Object> transactionMap = ServiceTool.getPlayerTransactionService().searchLastTime(playerTransactionListVo);

        if (transactionMap == null) {
            transactionMap = new HashMap<>();
        }
        model.addAttribute("transactionMap", transactionMap);
    }


    /**
     * 查询该玩家的所有备注信息
     *
     * @param playerId
     * @param model
     * @return
     */
    @RequestMapping(value = "/remarkList")
    public String remarkList(String playerId, Model model, RemarkListVo remarkListVo) {
        //备注记录
        remarkListVo.getSearch().setEntityUserId(Integer.parseInt(playerId));
        remarkListVo = ServiceTool.getRemarkService().search(remarkListVo);
        model.addAttribute("command", remarkListVo);
        return REMARK_LIST_URI;
    }

    /**
     * 查询该玩家的ip登录信息
     *
     * @param playerId
     * @param model
     * @return
     */
    @RequestMapping(value = "/loginIpList")
    public String loginIpList(String playerId, Model model, String username) {

        SysAuditLogSo sysAuditLogSo = new SysAuditLogSo();
        sysAuditLogSo.setModuleType(ModuleType.PASSPORT_LOGIN.getCode());
        sysAuditLogSo.setOperator(username);
        sysAuditLogSo.setOperatorUserType(UserTypeEnum.PLAYER.getCode());
        List<SysAuditLog> sysAuditLogs = ServiceTool.userPlayerService().queryWithOtherUserCount(sysAuditLogSo);
        List<SysAuditLog> sysAuditLogsExc = new ArrayList<>();
        for (SysAuditLog sysAuditLog : sysAuditLogs) {
            if (sysAuditLog.getOtherUserLoginCount() != 0) {
                sysAuditLogsExc.add(sysAuditLog);
            }
        }
        model.addAttribute("loginIpList", sysAuditLogs);
        model.addAttribute("loginIpListExc", sysAuditLogsExc);
        model.addAttribute("username", username);
        return LOGINIP_LIST_URI;
    }

    @RequestMapping("/fundRecord")
    public String fundRecord(PlayerApiListVo listVo, Model model) {
        //同步玩家api余额
        ShareController.fetchPlayerApiBalance(listVo);

        //查询玩家api余额
        Integer playerId = listVo.getSearch().getPlayerId();
        VUserPlayerVo objVo = new VUserPlayerVo();
        objVo.getSearch().setId(playerId);
        objVo = getService().get(objVo);
        playerApiList(playerId, model);
        model.addAttribute("command", objVo);
        return FUND_RECORD_URI;
    }

    /**
     * 玩家绑定银行卡记录
     *
     * @param playerId
     * @param model
     * @param userBankcardListVo
     * @return
     */
    @RequestMapping(value = "/bankList")
    public String bankList(String playerId, UserBankcardListVo userBankcardListVo, Model model) {
        Integer userId = Integer.parseInt(playerId);
        model.addAttribute("bankcards", BankHelper.queryUserBanksByUserId(userId, UserBankcardTypeEnum.TYPE_BANK, null));
        model.addAttribute("btnBanks", BankHelper.queryUserBanksByUserId(userId, UserBankcardTypeEnum.TYPE_BTC, null));
        return FUND_PLAYER_DETECT_BANK_LIST;
    }

    /**
     * 玩家获得的优惠总额(不包括返水)
     *
     * @param playerId
     * @param model
     */
    private void countPlayerFavorable(Integer playerId, Model model) {
        /*PlayerFavorableListVo playerFavorableListVo = new PlayerFavorableListVo();
        playerFavorableListVo.getSearch().setPlayerId(playerId);
        playerFavorableListVo.setPropertyName(PlayerFavorable.PROP_FAVORABLE);
        Number favorableVal = ServiceTool.playerFavorableService().sum(playerFavorableListVo);
        Double favorableValue = favorableVal == null ?0:favorableVal.doubleValue();*/
        PlayerTransactionListVo playerTransactionListVo = new PlayerTransactionListVo();
        playerTransactionListVo.getSearch().setPlayerId(playerId);
        Double favorableValue = ServiceTool.getPlayerTransactionService().countPlayerFavorable(playerTransactionListVo);
        model.addAttribute("favorableVal", favorableValue);
    }

    private void playerFavorableCount(Integer playerId, Model model) {
        //统计优惠次数
        PlayerTransactionListVo playerTransactionListVo = new PlayerTransactionListVo();
        List<String> transactionTypes = new ArrayList<>();
        transactionTypes.add(TransactionTypeEnum.FAVORABLE.getCode());
        transactionTypes.add(TransactionTypeEnum.RECOMMEND.getCode());
        playerTransactionListVo.getSearch().setPlayerId(playerId);
        playerTransactionListVo.getSearch().setStatus(CommonStatusEnum.SUCCESS.getCode());
        playerTransactionListVo.getSearch().setTransactionTypes(transactionTypes);
        long count = ServiceTool.getPlayerTransactionService().countFavorable(playerTransactionListVo);
        model.addAttribute("favorableCount", count);
    }
    //endregion

}
