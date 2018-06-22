package so.wwb.gamebox.mcenter.share.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.spring.utils.SpringTool;
import org.soul.model.msg.notice.vo.NoticeLocaleTmpl;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.api.vo.ApiBalanceVo;
import so.wwb.gamebox.model.enums.ApiQueryTypeEnum;
import so.wwb.gamebox.model.master.player.po.PlayerApi;
import so.wwb.gamebox.model.master.player.po.UserPlayer;
import so.wwb.gamebox.model.master.player.vo.PlayerApiListVo;
import so.wwb.gamebox.model.master.player.vo.UserPlayerVo;
import so.wwb.gamebox.web.api.IApiBalanceService;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by cheery on 15-6-16.
 */
@Controller
@RequestMapping(value = "/share")
public class ShareController {

    private static final Log LOG = LogFactory.getLog(ShareController.class);
    private static final String SEND_GROUP_INFO_TYPE_URI = "/share/SendGroupInfoType";
    private static final String SEND_GROUP_INFO_URI = "/share/SendGroupInfo";
    private static final String RESET_PLAYER_PWD_TYPE_URI = "/share/ResetPlayerPwdType";
    private static final String RESET_PLAYER_PWD_URI = "/share/ResetPlayerPwd";
    private static final long TEN_MINUTE_TO_MS = 10 * 60 * 1000;
    //原因选择预览更多页面
    private static final String RESON_PREVIEW_MORE_URI = "/share/ReasonPreviewMore";

    /**
     * 群发信息方式
     *
     * @return
     */
    @RequestMapping("/sendGroupInfoType")
    public String sendGroupInfoType() {
        return SEND_GROUP_INFO_TYPE_URI;
    }

    /**
     * 群发信息
     *
     * @return
     */
    @RequestMapping("/sendGroupInfo")
    public String sendGroupInfo() {
        return SEND_GROUP_INFO_URI;
    }

    /**
     * 重置密码方式
     *
     * @return
     */
    @RequestMapping("/resetPlayerPwdType")
    public String resetPlayerPwdType() {
        return RESET_PLAYER_PWD_TYPE_URI;
    }

    /**
     * 手动重置密码
     *
     * @return
     */
    @RequestMapping("/resetPlayerPwd")
    public String resetPlayerPwd() {
        return RESET_PLAYER_PWD_URI;
    }

    /**
     * 拒绝原因预览更多
     *
     * @param vo
     * @return
     */
    @RequestMapping("/reasonPreviewMore")
    protected String reasonPreviewMore(NoticeVo vo, Model model) {
        Map<String, Map<String, NoticeLocaleTmpl>> stringMapMap = ServiceTool.noticeService().previewTmplsByGroupCode(vo);
        model.addAttribute("command", stringMapMap);
        return RESON_PREVIEW_MORE_URI;
    }

    /**
     * 判断上次同步api时间是否在10分钟前
     */
    public static void lastSynchroApiCash(UserPlayerVo userPlayerVo, PlayerApiListVo playerApiListVo) {
        Date transactionSynTime = userPlayerVo.getResult().getTransactionSynTime();
        Date nowTime = SessionManager.getDate().getNow();
        if (transactionSynTime == null || DateTool.minutesBetween(nowTime, transactionSynTime) > TEN_MINUTE_TO_MS) {
            ShareController.fetchPlayerApiBalance(playerApiListVo);
        }
    }

    /**
     * 同步玩家api余额
     *
     * @param listVo
     */
    public static void fetchPlayerApiBalance(PlayerApiListVo listVo) {
        IApiBalanceService apiBalanceService = (IApiBalanceService) SpringTool.getBean("apiBalanceService");
        if (ApiQueryTypeEnum.ALL_API.getCode().equals(listVo.getType()) && listVo.getSearch().getPlayerId() != null) {
            listVo = ServiceSiteTool.playerApiService().search(listVo);
            List<PlayerApi> playerApis = listVo.getResult();
            if (CollectionTool.isEmpty(playerApis)) {
                return;
            }
            for (PlayerApi playerApi : playerApis) {
                listVo.getSearch().setApiId(playerApi.getApiId());
                fetchApiBalance(listVo, apiBalanceService);
            }
            UserPlayerVo userPlayerVo = new UserPlayerVo();
            UserPlayer userPlayer = new UserPlayer();
            userPlayer.setId(listVo.getSearch().getPlayerId());
            userPlayer.setSynchronizationTime(new Date());
            userPlayerVo.setResult(userPlayer);
            userPlayerVo.setProperties(UserPlayer.PROP_SYNCHRONIZATION_TIME);
            ServiceSiteTool.userPlayerService().updateOnly(userPlayerVo);
        } else if (listVo.getSearch().getApiId() != null) {
            fetchApiBalance(listVo, apiBalanceService);
        }
    }

    private static void fetchApiBalance(PlayerApiListVo listVo, IApiBalanceService apiBalanceService) {
        ApiBalanceVo apiBalanceVo = new ApiBalanceVo();
        apiBalanceVo.setSiteId(SessionManager.getSiteId());
        apiBalanceVo.setPlayerId(listVo.getSearch().getPlayerId());
        apiBalanceVo.setApiId(listVo.getSearch().getApiId());
        apiBalanceVo.setIp(SessionManager.getIpDb().getIp());
        apiBalanceVo.setQueryType(listVo.getType());
        apiBalanceVo.setSynchronizationTime(SessionManager.getDate().getNow());
        try {
            apiBalanceService.fetchApiBalance(apiBalanceVo);
        } catch (Exception e) {
            LOG.error(e, "发起API余额查询异常");
        }
    }
}
