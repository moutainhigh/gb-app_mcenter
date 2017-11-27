package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionQueryTool;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.collections.MapTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.BooleanTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.model.msg.notice.enums.NoticePublishMethod;
import org.soul.model.msg.notice.enums.NoticeReceiverGroupType;
import org.soul.model.msg.notice.enums.NoticeRemindMethod;
import org.soul.model.msg.notice.enums.NoticeSendStatus;
import org.soul.model.msg.notice.po.NoticeContactWay;
import org.soul.model.msg.notice.po.VNoticeReceivedText;
import org.soul.model.msg.notice.po.VNoticeSendText;
import org.soul.model.msg.notice.vo.*;
import org.soul.model.security.privilege.po.SysUser;
import org.soul.model.security.privilege.po.SysUserStatus;
import org.soul.model.security.privilege.vo.SysUserListVo;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.web.listop.ListOpTool;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.enmus.ListOpEnum;
import so.wwb.gamebox.mcenter.operation.form.MassInformationForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.SiteI18nEnum;
import so.wwb.gamebox.model.common.notice.enums.CometSubscribeType;
import so.wwb.gamebox.model.common.notice.enums.ManualNoticeEvent;
import so.wwb.gamebox.model.company.enums.DomainPageUrlEnum;
import so.wwb.gamebox.model.company.enums.ResolveStatusEnum;
import so.wwb.gamebox.model.company.site.po.SiteI18n;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.company.site.vo.SiteLanguageListVo;
import so.wwb.gamebox.model.company.sys.po.VSysSiteDomain;
import so.wwb.gamebox.model.company.sys.vo.VSysSiteDomainListVo;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.enums.ContactWayTypeEnum;
import so.wwb.gamebox.model.master.enums.PlayerStatusEnum;
import so.wwb.gamebox.model.master.enums.PublishMethodEnum;
import so.wwb.gamebox.model.master.operation.vo.MassInformationVo;
import so.wwb.gamebox.model.master.player.po.*;
import so.wwb.gamebox.model.master.player.vo.*;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by suyj on 15-9-14.
 */
@Controller
@RequestMapping("/operation/massInformation")
public class MassInformationController {

    private static final Log LOG = LogFactory.getLog(MassInformationController.class);

    private static final String BASE_URL = "/operation/mass.information/";
    private static final String CHOOSER_MESSAGE_TYPE = BASE_URL + "chooseType";
    private static final String CHOOSE_USER = BASE_URL + "chooseUser";
    private static final String EDIT_CONTENT = BASE_URL + "editContent";
    private static final String SEND_PREVIEW = BASE_URL + "sendPreview";
    private static final String FINISH = BASE_URL + "finish";
    //历史消息群发记录页
    private static final String HISTORY = BASE_URL + "History";
    //信息详细页
    private static final String NOTICE_INFO = BASE_URL + "NoticeInfo";
    /**
     * 发送对象-玩家
     */
    private static final String SEND_OBJECT_PLAYER = "player";
    /**
     * 发送对象-代理
     */
    private static final String SEND_OBJECT_AGENT = "agent";

    /**
     * 发送类型-玩家-全局玩家
     */
    private static final String SEND_OBJECT_PLAYER_ALL = "allPlayer";
    /**
     * 发送类型-玩家-指定玩家
     */
    private static final String SEND_OBJECT_PLAYER_APPOINT = "appoint";
    /**
     * 发送类型-玩家-按条件选择玩家
     */
    private static final String SEND_OBJECT_PLAYER_CONDITION = "condition";

    /**
     * 发送类型-代理-全局代理
     */
    private static final String SEND_OBJECT_AGENT_ALL = "all";
    /**
     * 发送类型-代理-指定代理
     */
    private static final String SEND_OBJECT_AGENT_APPOINTAGENT = "appointAgent";
    /**
     * 发送类型-代理-总代及其代理
     */
    private static final String SEND_OBJECT_AGENT_MASTER = "master";

    /**
     * 推送方式-仅站内信
     */
    private static final String PUSH_MODE_ONLY = "only";
    /**
     * 推送方式-站内信并弹窗
     */
    private static final String PUSH_MODE_WINDOW = "window";


    @RequestMapping("/chooseType")
    public String chooseType(String sendType, Model model) {
        if (StringTool.isBlank(sendType)) {//默认选中的发送形式
            sendType = PublishMethodEnum.SITE_MSG.getCode();
        }
        model.addAttribute("sendType", sendType);
        return CHOOSER_MESSAGE_TYPE;
    }

    @RequestMapping("/chooseUser")
    public String chooseUser(MassInformationVo massInformationVo, Model model) {
        if (StringTool.isBlank(massInformationVo.getTargetUser())) {
            //设置默认选中的发送对象为'玩家'
            massInformationVo.setTargetUser(SEND_OBJECT_PLAYER);
            massInformationVo.setGroup(SEND_OBJECT_PLAYER_ALL);
        }
        if (StringTool.isBlank(massInformationVo.getPushMode())) {
            //设置默认推送方式
            massInformationVo.setPushMode(PUSH_MODE_ONLY);
        }
        //查询有效的层级
        PlayerRankVo playerRankVo = new PlayerRankVo();
        List<PlayerRank> rankList = ServiceTool.playerRankService().queryUsableList(playerRankVo);
        List<VPlayerTag> vPlayerTags = ServiceTool.vPlayerTagService().allSearch(new VPlayerTagListVo());
        queryMasterAndAgent(massInformationVo, model);
        model.addAttribute("rankList", rankList);
        model.addAttribute("vPlayerTags", vPlayerTags);
        model.addAttribute("massInformationVo", massInformationVo);
        model.addAttribute("validateRule", JsRuleCreator.create(MassInformationForm.class));
        return CHOOSE_USER;
    }

    @RequestMapping("/queryPlayerSiteMsg")
    public String queryPlayerSiteMsg(VNoticeReceivedTextListVo listVo, Model model, HttpServletRequest request) {
        if (listVo.getSearch().getReceiverId() != null) {
            if (listVo.getSearch().getReceiveStatus() == null) {
                listVo = ServiceTool.noticeService().fetchReceivedSiteMsg(listVo);
            } else {
                listVo.setSearchUserId(listVo.getSearch().getReceiverId());
                List<VNoticeReceivedText> vNoticeReceivedTexts = ServiceTool.noticeService().fetchUnclaimedMsgs(listVo);
                listVo.getPaging().setTotalCount(vNoticeReceivedTexts.size());
                listVo.getPaging().cal();
                vNoticeReceivedTexts = CollectionQueryTool.pagingQuery(vNoticeReceivedTexts, null, listVo.getPaging().getPageNumber(), listVo.getPaging().getPageSize());
                listVo.setResult(vNoticeReceivedTexts);
            }

        }
        model.addAttribute("command", listVo);
        //return BASE_URL + "SiteMsgList";
        return ServletTool.isAjaxSoulRequest(request) ? BASE_URL + "SiteMsgListPartial" : BASE_URL + "SiteMsgList";
    }

    @RequestMapping("/playerSiteMsgDetail")
    public String playerSiteMsgDetail(VNoticeReceivedTextVo textVo, Model model) {
        if (textVo.getSearch().getId() != null) {
            textVo = ServiceTool.noticeService().fetchReceivedSiteMsgDetail(textVo);
        }
        model.addAttribute("textVo", textVo);
        return BASE_URL + "SiteMsgDetail";
    }

    /**
     * 查询总代和代理信息
     *
     * @param massInformationVo
     * @param model
     */
    private void queryMasterAndAgent(MassInformationVo massInformationVo, Model model) {
        VUserAgentListVo vUserAgentListVo = new VUserAgentListVo();
        vUserAgentListVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(VUserAgent.PROP_STATUS, Operator.LG, '2'),
                new Criterion(VUserAgent.PROP_USER_TYPE, Operator.IN, new ArrayList(Arrays.asList("22", "221"))),
                new Criterion(VUserAgent.PROP_STATUS, Operator.IS_NOT_NULL, null)
        });
        vUserAgentListVo.setPaging(null);
        VUserAgentListVo master = ServiceTool.vUserAgentService().search(vUserAgentListVo);
        vUserAgentListVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(VUserAgent.PROP_STATUS, Operator.LG, '2'),
                new Criterion(VUserAgent.PROP_USER_TYPE, Operator.IN, new ArrayList(Arrays.asList("23", "231"))),
                new Criterion(VUserAgent.PROP_STATUS, Operator.IS_NOT_NULL, null)
        });
        VUserAgentListVo agent = ServiceTool.vUserAgentService().search(vUserAgentListVo);
        List<VUserAgent> allMaster = master.getResult();
        List<VUserAgent> allAgent = agent.getResult();
        List<VUserAgent> selectedMaster = new ArrayList<>();
        List<VUserAgent> selectedAgent = new ArrayList<>();
        if (SEND_OBJECT_AGENT.equals(massInformationVo.getTargetUser())) {//发送对象为代理的回显
            switch (massInformationVo.getGroup()) {
                case SEND_OBJECT_AGENT_APPOINTAGENT:
                    List<Integer> masterList = massInformationVo.getMaster();
                    List<Integer> agentList = massInformationVo.getAgent();
                    for (Integer masterId : masterList) {
                        for (VUserAgent userAgent : allMaster) {
                            if (userAgent.getId().equals(masterId)) {
                                selectedMaster.add(userAgent);
                                break;
                            }
                        }
                    }
                    for (Integer agentId : agentList) {
                        for (VUserAgent userAgent : allAgent) {
                            if (userAgent.getId().equals(agentId)) {
                                selectedAgent.add(userAgent);
                                break;
                            }
                        }
                    }
                    break;
                case SEND_OBJECT_AGENT_MASTER:
                    List<Integer> masterAndAgentList = massInformationVo.getMasterAndAgent();
                    for (Integer masterId : masterAndAgentList) {
                        for (VUserAgent userAgent : allMaster) {
                            if (masterId.equals(userAgent.getId())) {
                                selectedMaster.add(userAgent);
                            }
                        }
                    }
                    break;
                default:
                    LOG.debug("找不到指定的发送对象类型!");
            }
        }
        allMaster.removeAll(selectedMaster);
        allAgent.removeAll(selectedAgent);
        model.addAttribute("master", allMaster);
        model.addAttribute("agent", allAgent);
        model.addAttribute("selectedMaster", selectedMaster);
        model.addAttribute("selectedAgent", selectedAgent);
    }

    /**
     * 校验输入的玩家是否存在 且存在的玩家账号状态不为停用
     *
     * @param appointPlayer 多个账号用逗号隔开
     * @return {"effectPlayer":"","invalidNum":""}
     */
    @RequestMapping("/checkUser")
    @ResponseBody
    public String checkUser(String appointPlayer) {
        String[] playerArray = appointPlayer.split(",");
        playerArray = clearRepeatPlayer(playerArray);
        //有效玩家
        List<String> effectiveList = new ArrayList<>();
        //有效玩家去除停用
        List<String> excludeDisablePlayer = new ArrayList<>();
        //无效的玩家
        List<String> unEffectiveList = new ArrayList<>();
        //停用状态的玩家
        List<String> disabledList = new ArrayList<>();
        List<String> playerList = new ArrayList<>();
        UserPlayerVo userPlayerVo = new UserPlayerVo();
        userPlayerVo.setProperties(playerArray);
        List<SysUser> existUser = ServiceTool.userPlayerService().queryUserNamesExists(userPlayerVo);
        String disableStatus = PlayerStatusEnum.DISABLE.getCode();
        for (SysUser sysUser : existUser) {
            if (StringTool.equals(sysUser.getStatus(), disableStatus)) {
                disabledList.add(sysUser.getUsername());
            } else {
                excludeDisablePlayer.add(sysUser.getUsername());
            }
            effectiveList.add(sysUser.getUsername());
        }
        for (String player : playerArray) {
            if (StringTool.isBlank(player)) {
                continue;
            }
            playerList.add(player);
            if (!effectiveList.contains(player)) {
                unEffectiveList.add(player);
            }
        }
        Map<String, String> jsonMap = new HashMap<>();
        jsonMap.put("effectPlayer", StringTool.join(",", effectiveList.toArray()));
        jsonMap.put("excludeDisablePlayer", StringTool.join(",", excludeDisablePlayer.toArray()));
        jsonMap.put("unEffectivePlayer", StringTool.join(",", unEffectiveList.toArray()));
        jsonMap.put("invalidNum", String.valueOf(playerList.size() - effectiveList.size()));
        jsonMap.put("disabledPlayer", StringTool.join(",", disabledList.toArray()));
        jsonMap.put("totalNum", String.valueOf(playerList.size()));
        return JsonTool.toJson(jsonMap);
    }

    private String[] clearRepeatPlayer(String[] playerArray) {
        Set<String> playerSet = new HashSet<>();
        for (String player : playerArray) {
            playerSet.add(player);
        }
        return playerSet.toArray(new String[playerSet.size()]);
    }


    /**
     * 编辑要发送的信息
     *
     * @param massInformationVo
     * @param model
     * @return
     */
    @RequestMapping("/editContent")
    public String editContent(MassInformationVo massInformationVo, Model model, HttpServletRequest request) {
        escapeContent(massInformationVo);
        SiteLanguageListVo siteLanguageListVo = new SiteLanguageListVo();
        siteLanguageListVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageListVo);
        List<VPlayerTag> vPlayerTags = ServiceTool.vPlayerTagService().allSearch(new VPlayerTagListVo());
        model.addAttribute("massInformationVo", massInformationVo);
        model.addAttribute("languageList", languageList);
        model.addAttribute("vPlayerTags", vPlayerTags);
        model.addAttribute("validateRule", JsRuleCreator.create(MassInformationForm.class));
        String hasReturn = request.getParameter("hasReturn");
        if (StringTool.isNotBlank(hasReturn)) {
            model.addAttribute("hasReturn", true);
        }
        return EDIT_CONTENT;
    }

    /**
     * 发送预览
     *
     * @param massInformationVo
     * @param model
     * @return
     */
    @RequestMapping("/sendPreview")
    @Token(generate = true)
    public String sendPreview(MassInformationVo massInformationVo, Model model) {
        escapeContent(massInformationVo);
        if (StringTool.isNotBlank(massInformationVo.getGroup())) {
            createSelectedValue(massInformationVo);
        }
        if (massInformationVo.getTiming() != null && DateTool.truncatedCompareTo(massInformationVo.getTiming(), SessionManager.getDate().getNow(), Calendar.SECOND) < 0) {
            //设置的时间已经小于当前时间,则改为立即发送,定时发送无效
            massInformationVo.setTiming(null);
        }
        model.addAttribute("massInformationVo", massInformationVo);
        return EDIT_CONTENT;
    }

    private void escapeContent(MassInformationVo massInformationVo) {
        if (massInformationVo.getTitle() != null) {
            String[] contentUnEscape = new String[massInformationVo.getContent().length];
            for (int i = 0; i < massInformationVo.getContent().length; i++) {
                // contentEscape[i] = HtmlUtils.htmlEscape(massInformationVo.getContent()[i]);
                contentUnEscape[i] = HtmlUtils.htmlUnescape(massInformationVo.getContent()[i]);
            }
            massInformationVo.setContentUnEscape(contentUnEscape);
        }
    }

    /**
     * 根据页面填写的用户信息,拼装页面的'已选择'文本信息
     *
     * @param massInformationVo
     */
    private void createSelectedValue(MassInformationVo massInformationVo) {
        long count = 0;
        long enableContactCount = 0;
        long disableContactCount = 0;
        List<Integer> enableContactUsers = findenableContactWayUsers(massInformationVo.getSendType());
        switch (massInformationVo.getGroup()) {
            case SEND_OBJECT_PLAYER_ALL: {
                VUserPlayerListVo vUserPlayerListVo = new VUserPlayerListVo();
                vUserPlayerListVo.setProperties(VUserPlayer.PROP_ID);
                vUserPlayerListVo.getQuery().setCriterions(new Criterion[]{new Criterion(VUserPlayer.PROP_STATUS, Operator.LG, "2")});
                List<Integer> userIds = ServiceTool.vUserPlayerService().searchProperty(vUserPlayerListVo);
                if (massInformationVo.getSendType().equals(PublishMethodEnum.EMAIL.getCode())) {
                    enableContactCount = CollectionTool.intersection(enableContactUsers, userIds).size();
                    disableContactCount = userIds.size() - enableContactCount;
                }
                StringBuffer info = new StringBuffer(LocaleTool.tranMessage("operation_auto", "全局玩家").replace("{0}", new Long(userIds.size()) + ""));
                if (disableContactCount > 0 && StringTool.equals(massInformationVo.getSendType(), PublishMethodEnum.EMAIL.getCode())) {
                    info.append(LocaleTool.tranMessage("operation_auto", "其中").replace("{0}", disableContactCount + ""));
                }
                massInformationVo.setSelected(info.toString());
            }
            break;
            case SEND_OBJECT_PLAYER_APPOINT: {
                String[] player = massInformationVo.getAppointPlayer().split(",");
                SysUserListVo sysUserListVo = new SysUserListVo();
                sysUserListVo.getQuery().setCriterions(new Criterion[]{
                        new Criterion(SysUser.PROP_USERNAME, Operator.IN, player),
                        new Criterion(SysUser.PROP_USER_TYPE, Operator.EQ, UserTypeEnum.PLAYER.getCode())
                });
                sysUserListVo.setProperties(SysUser.PROP_ID);
                List<Integer> userIds = ServiceTool.sysUserService().searchProperty(sysUserListVo);
                if (massInformationVo.getSendType().equals(PublishMethodEnum.EMAIL.getCode())) {
                    enableContactCount = CollectionTool.intersection(enableContactUsers, userIds).size();
                    disableContactCount = userIds.size() - enableContactCount;
                }
                Map<String, String> checkResult = JsonTool.fromJson(this.checkUser(massInformationVo.getAppointPlayer()), Map.class);
                int effectNum = (checkResult.get("excludeDisablePlayer").split(",")).length;
                StringBuffer info = new StringBuffer(LocaleTool.tranMessage("operation_auto", "指定玩家").replace("{0}", Integer.parseInt(checkResult.get("totalNum")) + "").replace("{1}", effectNum + ""));
                if (disableContactCount > 0 && StringTool.equals(massInformationVo.getSendType(), PublishMethodEnum.EMAIL.getCode())) {
                    info.append(LocaleTool.tranMessage("operation_auto", "其中").replace("{0}", disableContactCount + ""));
                }
                massInformationVo.setSelected(info.toString());
            }
            break;
            case SEND_OBJECT_PLAYER_CONDITION: {
                List<Integer> rankIdList = new ArrayList<>();
                for (Integer rankId : massInformationVo.getRank()) {
                    if (rankId != null) {
                        rankIdList.add(rankId);
                    }
                }
                List<Integer> tagIdList = new ArrayList<>();
                for (Integer tagId : massInformationVo.getTags()) {
                    if (tagId != null) {
                        tagIdList.add(tagId);
                    }
                }
                /*符合层级条件的所有玩家id*/
                List<Integer> rankUserIds = new ArrayList<>();
                /*符合tag条件的所有玩家id*/
                List<Integer> tagUserIds = new ArrayList<>();

                UserPlayerListVo userPlayerListVo = new UserPlayerListVo();
                VPlayerTagAllListVo vplayerTagAllListVo = new VPlayerTagAllListVo();
                if (rankIdList.size() > 0) {
                    userPlayerListVo.setRankIds(rankIdList);
                    rankUserIds = ServiceTool.userPlayerService().countAppointRankUser(userPlayerListVo);
                    enableContactCount = CollectionTool.intersection(enableContactUsers, rankUserIds).size();
                    disableContactCount = rankUserIds.size() - enableContactCount;
                }
                if (tagIdList.size() > 0) {
                    vplayerTagAllListVo.getQuery().setCriterions(new Criterion[]{new Criterion(VPlayerTagAll.PROP_TAG_ID, Operator.IN, tagIdList), new Criterion(VPlayerTagAll.PROP_STATUS, Operator.NE, PlayerStatusEnum.DISABLE.getCode())});
                    vplayerTagAllListVo.setProperties(VPlayerTagAll.PROP_PLAYER_ID);
                    tagUserIds = ServiceTool.vPlayerTagAllService().searchProperty(vplayerTagAllListVo);
                    enableContactCount = CollectionTool.intersection(enableContactUsers, tagUserIds).size();
                    disableContactCount = tagUserIds.size() - enableContactCount;
                }
                StringBuffer info = new StringBuffer(LocaleTool.tranMessage("operation_auto", "层级").replace("{0}", rankIdList.size() + "").replace("{1}", tagIdList.size() + "").replace("{2}", new Long(CollectionTool.union(rankUserIds, tagUserIds).size()) + ""));
                if (disableContactCount > 0 && StringTool.equals(massInformationVo.getSendType(), PublishMethodEnum.EMAIL.getCode())) {
                    info.append(LocaleTool.tranMessage("operation_auto", "其中").replace("{0}", disableContactCount + ""));
                }
                massInformationVo.setSelected(info.toString());
            }
            break;
            case SEND_OBJECT_AGENT_ALL: {
                SysUserListVo sysUserListVo = new SysUserListVo();
                sysUserListVo.setProperties(SysUser.PROP_ID);
                sysUserListVo.getQuery().setCriterions(new Criterion[]{
                        new Criterion(SysUser.PROP_STATUS, Operator.LG, SysUserStatus.DISABLED.getCode()),
                        new Criterion(SysUser.PROP_USER_TYPE, Operator.IN, new ArrayList(Arrays.asList(UserTypeEnum.AGENT.getCode(), UserTypeEnum.TOP_AGENT.getCode())))
                });
                List<Integer> userIds = ServiceTool.sysUserService().searchProperty(sysUserListVo);
                if (massInformationVo.getSendType().equals(PublishMethodEnum.EMAIL.getCode())) {
                    enableContactCount = CollectionTool.intersection(enableContactUsers, userIds).size();
                    disableContactCount = userIds.size() - enableContactCount;
                }
                StringBuffer info = new StringBuffer(LocaleTool.tranMessage("operation_auto", "全局代理商").replace("{0}", new Long(userIds.size()) + ""));
                if (disableContactCount > 0 && StringTool.equals(massInformationVo.getSendType(), PublishMethodEnum.EMAIL.getCode())) {
                    info.append(LocaleTool.tranMessage("operation_auto", "其中").replace("{0}", disableContactCount + ""));
                }
                massInformationVo.setSelected(info.toString());
            }
            break;
            case SEND_OBJECT_AGENT_APPOINTAGENT: {
                int masterSize = massInformationVo.getMaster().size();
                int agentSize = massInformationVo.getAgent().size();
                count = masterSize + agentSize;
                enableContactCount = CollectionTool.intersection(enableContactUsers, massInformationVo.getMaster()).size() + CollectionTool.intersection(enableContactUsers, massInformationVo.getAgent()).size();
                disableContactCount = agentSize + masterSize - enableContactCount;
                StringBuffer info = new StringBuffer(LocaleTool.tranMessage("operation_auto", "总代").replace("{0}", masterSize + "").replace("{1}", agentSize + "").replace("{2}", (count) + ""));
                if (disableContactCount > 0 && StringTool.equals(massInformationVo.getSendType(), PublishMethodEnum.EMAIL.getCode())) {
                    info.append(LocaleTool.tranMessage("operation_auto", "其中").replace("{0}", disableContactCount + ""));
                }
                massInformationVo.setSelected(info.toString());
            }
            break;
            case SEND_OBJECT_AGENT_MASTER: {
                int masterSize = massInformationVo.getMasterAndAgent().size();
                VUserAgentListVo userAgentListVo = new VUserAgentListVo();
                userAgentListVo.setProperties(VUserAgent.PROP_ID);
                userAgentListVo.getQuery().setCriterions(new Criterion[]{
                        new Criterion(VUserAgent.PROP_PARENT_ID, Operator.IN, massInformationVo.getMasterAndAgent()),
                        new Criterion(VUserAgent.PROP_STATUS, Operator.NE, PlayerStatusEnum.DISABLE.getCode()),
                        new Criterion(VUserAgent.PROP_USER_TYPE, Operator.EQ, UserTypeEnum.AGENT.getCode())
                });
                List<Integer> userIds = ServiceTool.vUserAgentService().searchProperty(userAgentListVo);
                enableContactCount = CollectionTool.intersection(enableContactUsers, userIds).size() + CollectionTool.intersection(enableContactUsers, massInformationVo.getMasterAndAgent()).size();
                disableContactCount = userIds.size() + masterSize - enableContactCount;
                StringBuffer info = new StringBuffer(LocaleTool.tranMessage("operation_auto", "总代及其代理").replace("{0}", masterSize + "").replace("{1}", new Long(masterSize + userIds.size()) + ""));
                if (disableContactCount > 0 && StringTool.equals(massInformationVo.getSendType(), PublishMethodEnum.EMAIL.getCode())) {
                    info.append(LocaleTool.tranMessage("operation_auto", "其中").replace("{0}", disableContactCount + ""));
                }
                massInformationVo.setSelected(info.toString());
            }
            break;
        }
    }

    private List<Integer> findenableContactWayUsers(String sendType) {
        NoticeContactWayListVo noticeContactWayListVo = new NoticeContactWayListVo();
        noticeContactWayListVo.setProperties(NoticeContactWay.PROP_USER_ID);
        List<Integer> enableContactUser = new ArrayList<>();
        if (StringTool.equals(sendType, PublishMethodEnum.EMAIL.getCode())) {
            noticeContactWayListVo.getQuery().setCriterions(new Criterion[]{
                    new Criterion(NoticeContactWay.PROP_CONTACT_TYPE, Operator.EQ, ContactWayTypeEnum.EMAIL.getCode()),
                    new Criterion(NoticeContactWay.PROP_CONTACT_VALUE, Operator.IS_NOT_EMPTY, null)
            });
            noticeContactWayListVo.setPaging(null);
            NoticeContactWayListVo emailListVo = ServiceTool.noticeContactWayService().search(noticeContactWayListVo);
            enableContactUser = CollectionQueryTool.queryProperty(emailListVo.getResult(), NoticeContactWay.PROP_USER_ID);
        }
        return enableContactUser;
    }


    @RequestMapping("/finish")
    @Token(valid = true)
    public String finish(MassInformationVo massInformationVo, HttpServletRequest request) {
        NoticeVo noticeVo = new NoticeVo();
        //构造发送方式
        NoticePublishMethod noticePublishMethod = NoticePublishMethod.enumOf(massInformationVo.getSendType());
        noticeVo.setPublishMethod(noticePublishMethod);
        //设置提醒方式
        if (StringTool.equals(massInformationVo.getPushMode(), PUSH_MODE_WINDOW)) {
            noticeVo.setRemindMethod(NoticeRemindMethod.NUM_POPUP_SOUND);
            noticeVo.setSubscribeType(CometSubscribeType.SYS_ANN);
        } else {
            noticeVo.setSubscribeType(CometSubscribeType.READ_COUNT);
        }
        //发送对象为玩家时
        createUserNoticeVo(massInformationVo, noticeVo);
        //发送对象为代理时
        createAgentNoticeVo(massInformationVo, noticeVo);
        //发送内容<语言,<标题,内容>>
        createNoticeTmpl(massInformationVo, noticeVo, request);
        noticeVo.setEventType(ManualNoticeEvent.GROUP_SEND);
        if (massInformationVo.isTimingFlag()) {
            noticeVo.setCronExp(DateTool.toCronExp(massInformationVo.getTiming()));
        }
        try {
            if (noticeVo.getUserIds().size() > 0) {
                //TODO::如果替换user标签，修改为一条一条发送，防止发送消息不对问题
                boolean isReplace = false;
                for (Pair<String, String> pair : noticeVo.getLocaleTmplMap().values()) {
                    if (pair.getValue().contains("${user}") || pair.getKey().contains("${user}")) {
                        isReplace = true;
                        break;
                    }
                }
                if (isReplace) {
                    for (Integer userId : noticeVo.getUserIds()) {
                        SysUserVo sysUserVo = new SysUserVo();
                        sysUserVo.setResult(new SysUser());
                        sysUserVo.getSearch().setId(userId);
                        SysUserVo obj = ServiceTool.sysUserService().get(sysUserVo);
                        Map<String, Pair<String, String>> localeTmplMap = new HashMap<>();
                        for (Map.Entry<String, Pair<String, String>> entry : noticeVo.getLocaleTmplMap().entrySet()) {
                            String val = entry.getValue().getValue().replace("${user}", obj.getResult().getUsername());
                            String title = entry.getValue().getKey().replace("${user}", obj.getResult().getUsername());
                            localeTmplMap.put(entry.getKey(), new Pair<String, String>(title, val));
                        }
                        NoticeVo _noticeVo = new NoticeVo();
                        _noticeVo.addUserIds(userId);
                        _noticeVo.setLocaleTmplMap(localeTmplMap);
                        _noticeVo.setEventType(noticeVo.getEventType());
                        _noticeVo.setPublishMethod(noticeVo.getPublishMethod());
                        _noticeVo.setRemindMethod(noticeVo.getRemindMethod());
                        _noticeVo.setCronExp(noticeVo.getCronExp());
                        _noticeVo.setSubscribeType(noticeVo.getSubscribeType());
                        ServiceTool.noticeService().publish(_noticeVo);
                    }

                } else {
                    ServiceTool.noticeService().publish(noticeVo);
                }
            } else {
                ServiceTool.noticeService().publish(noticeVo);
            }
        } catch (Exception ex) {
            LogFactory.getLog(this.getClass()).error(ex, "发布消息不成功");
        }
        return FINISH;
    }

    /**
     * 构造通知模板
     *
     * @param massInformationVo
     * @param noticeVo
     */
    private void createNoticeTmpl(MassInformationVo massInformationVo, NoticeVo noticeVo, HttpServletRequest request) {
        HashMap<String, Pair<String, String>> localTempMap = new HashMap();
        String[] lanuages = massInformationVo.getLanguage();
        for (int i = 0; i < lanuages.length; i++) {
            Map<String, String> replaceMap = replaceMap(request, lanuages[i]);
            Pair<String, String> pair = new Pair<>(replaceVarTags(massInformationVo.getTitle()[i], replaceMap), replaceVarTags(massInformationVo.getContent()[i], replaceMap));
            localTempMap.put(lanuages[i], pair);
        }
        noticeVo.setLocaleTmplMap(localTempMap);
    }


    private Map<String, String> replaceMap(HttpServletRequest request, String lanuages) {
        /* 信息群发用到的标签 ${user} ${sitename} ${customer} ${website} ${year} ${month} ${day}*/
        String cus = "<a href='javascript:void(0)'>联系客服</a>";
        String url = Cache.getDefaultCustomerService().getParameter();
        if (StringTool.isNotBlank(url)) {
            if (!url.startsWith("http")) {
                url = "http://" + url;
            }
            cus = "<a target='_blank' href='" + url + "'>联系客服</a>";
        }
        Map<String, SiteI18n> siteNameMap = Cache.getSiteI18n(SiteI18nEnum.SETTING_SITE_NAME);
        String siteName = "";
        if (siteNameMap.containsKey(lanuages)) {
            siteName = siteNameMap.get(lanuages).getValue();
        } else {
            siteName = SessionManager.getSiteName(request);
        }
        Date date = SessionManager.getDate().getNow();
        TimeZone timeZone = SessionManager.getTimeZone();
        SimpleDateFormat outDateFormat = new SimpleDateFormat("dd");
        outDateFormat.setTimeZone(timeZone);
        VSysSiteDomainListVo vSysSiteDomainListVo=new VSysSiteDomainListVo();
        vSysSiteDomainListVo.getSearch().setSiteId(CommonContext.get().getSiteId());
        List<VSysSiteDomain> domainList= ServiceTool.vSysSiteDomainService().loadSiteDomain(vSysSiteDomainListVo);

        String webSite = "";
        Integer siteId = SessionManager.getSiteId();
        for (VSysSiteDomain domain : domainList) {
            if (siteId.intValue() == domain.getSiteId() && ResolveStatusEnum.SUCCESS.getCode().equals(domain.getResolveStatus()) && DomainPageUrlEnum.INDEX.getCode().equals(domain.getPageUrl()) && domain.getIsDeleted() != null && !domain.getIsDeleted() && domain.getAgentId()==null) {
                if (BooleanTool.isTrue(domain.getSslEnabled())) {
                    webSite = "https://" + domain.getDomain();
                } else {
                    webSite = "http://" + domain.getDomain();
                }
                break;
            }
        }

        return MapTool.newHashMap(
                /*${user}在前台进行替换*/
                new Pair<String, String>("sitename", siteName),
                new Pair<String, String>("customer", cus),
                new Pair<String, String>("website", "<a target='_blank' href='" + webSite + "'>" + webSite + "</a>"),
                new Pair<String, String>("year", LocaleDateTool.formatDate(date, CommonContext.getDateFormat().getYEAR(), timeZone)),
                new Pair<String, String>("month", LocaleDateTool.formatDate(date, CommonContext.getDateFormat().getMONTH(), timeZone)),
                new Pair<String, String>("day", outDateFormat.format(date)));
    }

    private String replaceVarTags(String content, Map<String, String> replaceMap) {
        /* 信息群发用到的标签 ${user} ${sitename} ${customer} ${website} ${year} ${month} ${day}*/
        String afterRe = StringTool.fillTemplate(content, replaceMap);
        return afterRe;

    }

    /**
     * 构造代理的通知vo
     *
     * @param massInformationVo
     * @param noticeVo
     */
    private void createAgentNoticeVo(MassInformationVo massInformationVo, NoticeVo noticeVo) {
        if (massInformationVo.getTargetUser().equals(SEND_OBJECT_AGENT)) {
            List<Integer> master = massInformationVo.getMaster();
            List<Integer> agent = massInformationVo.getAgent();
            UserAgentListVo userAgentListVo = new UserAgentListVo();
            VUserAgentListVo vUserAgentListVo = new VUserAgentListVo();
            switch (massInformationVo.getGroup()) {
                case SEND_OBJECT_AGENT_ALL:
                    userAgentListVo.setProperties(UserAgent.PROP_ID);
                    agent = ServiceTool.userAgentService().searchProperty(userAgentListVo);
                    noticeVo.addUserIds(agent.toArray(new Integer[agent.size()]));
                    break;
                case SEND_OBJECT_AGENT_APPOINTAGENT:
                    noticeVo.addUserIds(master.toArray(new Integer[master.size()]));
                    noticeVo.addUserIds(agent.toArray(new Integer[agent.size()]));
                    break;
                case SEND_OBJECT_AGENT_MASTER:
                    List<Integer> masterAndAgent = massInformationVo.getMasterAndAgent();
                    vUserAgentListVo.setProperties(VUserAgent.PROP_ID);
                    vUserAgentListVo.getQuery().setCriterions(new Criterion[]{
                            new Criterion(VUserAgent.PROP_PARENT_ID, Operator.IN, masterAndAgent),
                            new Criterion(VUserAgent.PROP_STATUS, Operator.NE, PlayerStatusEnum.DISABLE.getCode()),
                            new Criterion(VUserAgent.PROP_USER_TYPE, Operator.EQ, UserTypeEnum.AGENT.getCode())
                    });
                    agent = ServiceTool.vUserAgentService().searchProperty(vUserAgentListVo);
                    noticeVo.addUserIds(masterAndAgent.toArray(new Integer[masterAndAgent.size()]));
                    noticeVo.addUserIds(agent.toArray(new Integer[agent.size()]));
                    break;
                default:
                    LOG.debug("未指定要发送的代理范围!");
            }
        }
    }

    /**
     * 构造玩家的通知vo
     *
     * @param massInformationVo
     * @param noticeVo
     */
    private void createUserNoticeVo(MassInformationVo massInformationVo, NoticeVo noticeVo) {
        if (massInformationVo.getTargetUser().equals(SEND_OBJECT_PLAYER)) {
            switch (massInformationVo.getGroup()) {
                case SEND_OBJECT_PLAYER_ALL:
                    noticeVo.addReceiverGroup(NoticeReceiverGroupType.ALL_FRONT);
                    break;
                case SEND_OBJECT_PLAYER_APPOINT:
                    if (StringTool.isNotBlank(massInformationVo.getAppointPlayer())) {
                        Map<String, String> resultMap = JsonTool.fromJson(this.checkUser(massInformationVo.getAppointPlayer()), Map.class);
                        String[] usernames = resultMap.get("excludeDisablePlayer").split(",");
                        SysUserListVo sysUserListVo = new SysUserListVo();
                        sysUserListVo.getQuery().setCriterions(
                                new Criterion[]{new Criterion(SysUser.PROP_USERNAME, Operator.IN, usernames),
                                        new Criterion(SysUser.PROP_USER_TYPE, Operator.EQ, UserTypeEnum.PLAYER.getCode()),
                                        new Criterion(SysUser.PROP_STATUS, Operator.NE, SysUserStatus.DISABLED.getCode())
                                });
                        sysUserListVo.setProperties(SysUser.PROP_ID);
                        List<Integer> userIds = ServiceTool.sysUserService().searchProperty(sysUserListVo);
                        noticeVo.addUserIds(userIds.toArray(new Integer[userIds.size()]));
                    }
                    break;
                case SEND_OBJECT_PLAYER_CONDITION:
                    HashMap<NoticeReceiverGroupType, Set<Integer>> receiverGroupTypeSetHashMap = new HashMap();
                    List<Integer> rankIdList = new ArrayList<>();
                    for (Integer rankId : massInformationVo.getRank()) {
                        if (rankId != null) {
                            rankIdList.add(rankId);
                        }
                    }
                    List<Integer> tagIdList = new ArrayList<>();
                    for (Integer tagId : massInformationVo.getTags()) {
                        if (tagId != null) {
                            tagIdList.add(tagId);
                        }
                    }
                    receiverGroupTypeSetHashMap.put(NoticeReceiverGroupType.RANK, new HashSet<>(rankIdList));
                    receiverGroupTypeSetHashMap.put(NoticeReceiverGroupType.TAG, new HashSet<>(tagIdList));
                    noticeVo.addReceiverGroups(receiverGroupTypeSetHashMap);
                    break;
                default:
                    LOG.debug("未指定要发送的玩家范围!");
            }
        }
    }

    /**
     * 消息历史记录
     *
     * @param model
     * @param request
     * @param listVo
     * @return
     */
    @RequestMapping("/history")
    protected String history(Model model, HttpServletRequest request, VNoticeSendTextListVo listVo) {
        calPaging(listVo);
        listVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(VNoticeSendText.PROP_EVENT_TYPE, Operator.EQ, ManualNoticeEvent.GROUP_SEND.getCode()),
                new Criterion(VNoticeSendText.PROP_STATUS, Operator.NE, NoticeSendStatus.CANCEL.getCode()),
                new Criterion(VNoticeSendText.PROP_LOCALE, Operator.EQ, StringTool.isBlank(SessionManager.getUser().getDefaultLocale()) ? SessionManager.getSiteLocale().toString() : SessionManager.getUser().getDefaultLocale()),
                new Criterion(VNoticeSendText.PROP_CREATE_USER, Operator.NE, NoticeVo.SEND_USER_ID),
                new Criterion(VNoticeSendText.PROP_RECEIVER_GROUP_ID, Operator.EQ, listVo.getSearch().getReceiverGroupId())

        });
        listVo = ServiceTool.noticeService().fetchPublishHistory(listVo);

        //把虚拟账号的操作人换成站长账号信息,数据库还是虚拟账号  add by bruce
        /*List<VNoticeSendText> vNoticeSendTexts = listVo.getResult();
        if (vNoticeSendTexts != null && vNoticeSendTexts.size()>0) {
            for (VNoticeSendText vNoticeSendText : vNoticeSendTexts) {
                if (vNoticeSendText.getCreateUser().equals(0)) {//虚拟账号的id为0
                    vNoticeSendText.setCreateUsername(SessionManager.getUserName());
                }
            }
        }*/

        model.addAttribute("command", listVo);
        return ServletTool.isAjaxSoulRequest(request) ? HISTORY + "Partial" : HISTORY;
    }

    private void calPaging(VNoticeSendTextListVo listVo) {
        if (listVo.getPaging() == null) {
            return;
        }
        int pageNumber = listVo.getPaging().getPageNumber();
        int lastPageNumber = listVo.getPaging().getLastPageNumber();
        if (pageNumber >= lastPageNumber) {
            listVo.getPaging().setPageNumber(lastPageNumber);
        }
    }

    /**
     * 消息详情
     *
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping("/noticeInfo")
    protected String view(Model model, VNoticeSendTextVo vo) {
        model.addAttribute("command", ServiceTool.noticeService().fetchPublishHistoryDetail(vo));
        model.addAttribute("siteLang", siteLang());//所有语言版本
        //获取站长的语言版本
        String locale = new String();
        if (StringTool.isBlank(locale)) {
            locale = CommonContext.get().getLocale().toString();
        }
        model.addAttribute("locale", locale);
        return NOTICE_INFO;
    }

    @RequestMapping("/cancelPublish")
    @ResponseBody
    public Map<String, Object> cancelPublish(VNoticeSendTextVo vo) {
        boolean success = ServiceTool.noticeService().cancelPublishJob(vo);
        Map<String, Object> map = new HashMap<>(2, 1f);
        map.put("state", success);
        map.put("msg", success ? LocaleTool.tranMessage(Module.MASTER_OPERATION.getCode(), "mass.info.cancelPublishSuccess") : LocaleTool.tranMessage(Module.MASTER_OPERATION.getCode(), "mass.info.cancelPublishFail"));
        return map;
    }

    @RequestMapping("/getPublishFailUsers")
    public String getPublishFailUsers(VNoticeSendTextVo vo, Model model) {
//        1.根据textId取到对应的send
//        2.根据send中的receiver_group_type 分辨跳转地址
//        (1) user --> 查user类型 agent / topagent /player
//        (2) all_front -->player
//        (3) tag -->player
//        (4) rank -->player
        String returnUrl;
        String userType = "";
        String receiverGroupType = fetchNoticeReceiverGroupType(vo);
        List<Integer> ids = new ArrayList<>(ServiceTool.noticeService().fetchPublishFailUserIds(vo));
        if (CollectionTool.isNotEmpty(ids)) {
            userType = noticeReceiverUserType(receiverGroupType, ids.get(0));
        }

        Map allListFields = ListOpTool.getFields(ListOpEnum.VUserPlayerListVo);
        if (allListFields != null) {
            model.addAttribute("list", allListFields.values());
        }
        Map<String, Serializable> status = DictTool.get(DictEnum.PLAYER_STATUS);
        if (StringTool.equals(userType, UserTypeEnum.AGENT.getCode()) || StringTool.equals(userType, UserTypeEnum.AGENT_SUB.getCode())) {
            VUserAgentManageListVo listVo = new VUserAgentManageListVo();
            if (CollectionTool.isNotEmpty(ids)) {
                listVo.getSearch().setIds(ids);
                listVo = ServiceTool.vUserAgentManageService().searchByCustom(listVo);
            }
            status.remove(SysUserStatus.AUDIT_FAIL.getCode());
            returnUrl = "/player/agent/agentmanage/Index";
            model.addAttribute("command", listVo);
        } else if (StringTool.equals(userType, UserTypeEnum.TOP_AGENT.getCode()) || StringTool.equals(userType, UserTypeEnum.TOP_AGENT_SUB.getCode())) {
            VUserTopAgentManageListVo listVo = new VUserTopAgentManageListVo();
            if (CollectionTool.isNotEmpty(ids)) {
                listVo.getSearch().setIds(ids);
                listVo = ServiceTool.vUserTopAgentManageService().searchByCustom(listVo);
            }
            status.remove(SysUserStatus.AUDIT_FAIL.getCode());
            status.remove(SysUserStatus.INACTIVE.getCode());
            returnUrl = "/player/agent/topagentmanage/Index";
            model.addAttribute("command", listVo);
        } else {
            returnUrl = "/player/Index";
            VUserPlayerListVo listVo = new VUserPlayerListVo();
            if (CollectionTool.isNotEmpty(ids)) {
                listVo.getSearch().setIds(ids);
                listVo = ServiceTool.vUserPlayerService().searchByCustom(listVo);
            }
            listVo.setAllFieldLists(allListFields);
            model.addAttribute("command", listVo);
        }
        model.addAttribute("playerStatus", status);

        return returnUrl;
    }

    private String noticeReceiverUserType(String receiverGroupType, Integer userId) {
        if (StringTool.equals(receiverGroupType, NoticeReceiverGroupType.USER.getCode())) {
            SysUserVo userVo = new SysUserVo();
            userVo.getSearch().setId(userId);
            return ServiceTool.sysUserService().get(userVo).getResult().getUserType();
        }
        return "";
    }

    private String fetchNoticeReceiverGroupType(VNoticeSendTextVo vo) {
        String receiverType = ServiceTool.noticeService().fetchPublishHistoryDetail(vo).getGroupTypes();
        Map<String, String> i18nMap = I18nTool.getDictsMap(SessionManager.getLocale().toString()).get(DictEnum.NOTICE_PUBLISH_METHOD.getModule().getCode()).get("receiver_group_type");
        for (Map.Entry<String, String> entry : i18nMap.entrySet()) {
            if (StringTool.equals(receiverType, entry.getValue())) {
                return entry.getKey();
            }
        }

        return "";
    }

    /**
     * 获取可使用的语言
     *
     * @return
     */
    private List<SiteLanguage> siteLang() {
        SiteLanguageListVo vo = new SiteLanguageListVo();
        vo.getSearch().setSiteId(SessionManager.getSiteId());
        return ServiceTool.siteLanguageService().availableLanguage(vo);
    }
}
