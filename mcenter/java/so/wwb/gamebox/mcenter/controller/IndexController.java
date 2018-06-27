package so.wwb.gamebox.mcenter.controller;

import org.json.JSONObject;
import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionQueryTool;
import org.soul.commons.collections.MapTool;
import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.SystemTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.math.NumberTool;
import org.soul.commons.query.sort.Order;
import org.soul.commons.tree.TreeNode;
import org.soul.model.msg.notice.po.VNoticeReceivedText;
import org.soul.model.msg.notice.vo.CometMsg;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.model.msg.notice.vo.VNoticeReceivedTextListVo;
import org.soul.model.security.privilege.po.VSysUserResource;
import org.soul.model.security.privilege.vo.SysResourceVo;
import org.soul.model.session.SessionKey;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.security.privilege.controller.SysResourceController;
import org.soul.web.session.SessionManagerBase;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.init.ConfigManager;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.taskReminder.TaskReminder;
import so.wwb.gamebox.mcenter.taskReminder.TaskReminderHelp;
import so.wwb.gamebox.model.*;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.company.credit.po.SysSiteCredit;
import so.wwb.gamebox.model.company.credit.vo.SysSiteCreditVo;
import so.wwb.gamebox.model.company.enums.DomainPageUrlEnum;
import so.wwb.gamebox.model.company.enums.SiteStatusEnum;
import so.wwb.gamebox.model.company.operator.po.VSystemAnnouncement;
import so.wwb.gamebox.model.company.operator.vo.VSystemAnnouncementListVo;
import so.wwb.gamebox.model.company.site.po.SiteI18n;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.company.sys.po.VSysSiteUser;
import so.wwb.gamebox.model.company.sys.vo.SysDomainListVo;
import so.wwb.gamebox.model.company.sys.vo.SysSiteVo;
import so.wwb.gamebox.model.company.sys.vo.VSysSiteUserListVo;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.gameapi.enums.ApiProviderEnum;
import so.wwb.gamebox.model.master.dataRight.DataRightModuleType;
import so.wwb.gamebox.model.master.dataRight.vo.SysUserDataRightVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerDepositVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerWithdrawListVo;
import so.wwb.gamebox.model.master.player.vo.PlayerGameOrderVo;
import so.wwb.gamebox.model.master.player.vo.VPayRankVo;
import so.wwb.gamebox.model.master.setting.po.VUserShortcutMenu;
import so.wwb.gamebox.model.master.setting.vo.VUserShortcutMenuListVo;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;
import so.wwb.gamebox.model.master.tasknotify.vo.UserTaskReminderListVo;
import so.wwb.gamebox.model.report.vo.OperationProfileVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.phoneapi.controller.BasePhoneApiController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * Created by tony on 15-4-29.
 */
@Controller
public class IndexController extends BasePhoneApiController {
    private static final String INDEX_URI = "index";
    private static final String INDEX_CONTENT_URI = "index.include/content";
    private static final String INDEX_MESSAGE_URI = "index.include/Message";
    private static final String INDEX_TASK_URI = "index.include/Task";
    private static final long ONE_MINUTE = 60000L;
    private static final long ONE_HOUR = 3600000L;
    private static final long ONE_DAY = 86400000L;
    private static final String ONE_SECOND_AGO = "@ONE_SECOND_AGO";//秒
    private static final String ONE_MINUTE_AGO = "@ONE_MINUTE_AGO";//分钟
    private static final String ONE_HOUR_AGO = "@ONE_HOUR_AGO";//小时
    private static final String ONE_DAY_AGO = "@ONE_DAY_AGO";//天
    private static final Log LOG = LogFactory.getLog(IndexController.class);

    @Override
    protected String content(Integer parentId, HttpServletRequest request, HttpServletResponse response, Model model) {
        SysResourceVo o = new SysResourceVo();
        UserTypeEnum userTypeEnum = UserTypeEnum.enumOf(SessionManager.getUser().getUserType());
        switch (userTypeEnum) {
            case MASTER_SUB:
            case TOP_AGENT_SUB:
            case AGENT_SUB:
                o.getSearch().setUserId(SessionManager.getUserId());
                break;
            default:
                break;
        }
        o.getSearch().setSubsysCode(ConfigManager.getConfigration().getSubsysCode());
        o.getSearch().setParentId(parentId);
        List<TreeNode<VSysUserResource>> menuNodeList = ServiceTool.sysResourceService().getSubMenus(o);
        SysResourceController.loadLocal(menuNodeList);
        model.addAttribute("command", menuNodeList);
        return INDEX_CONTENT_URI;
    }

    @Audit(module = Module.MASTER_INDEX, moduleType = ModuleType.PASSPORT_LOGIN, desc = "刷新首页面")
    @RequestMapping(value = "index")
    protected String index(HttpServletRequest request, Model model) {
         /* 获取当前用户未接收的站内信 */
        if (SessionManager.getFirstLogin()) {
            ServiceTool.noticeService().fetchUnReceivedMsgs(new NoticeVo());
        }
        UserTaskReminderListVo listVo = new UserTaskReminderListVo();
        /*listVo.setPropertyName(UserTaskReminder.PROP_TASK_NUM);
        Number unReadTaskCount = ServiceTool.userTaskReminderService().sum(listVo);//未读任务数量*/
        model.addAttribute("unReadTaskCount", 0);
        model.addAttribute("isReminderTask", SessionManager.getIsReminderTask());

        model.addAttribute("unReadCount", unReadMagNum());
        model.addAttribute("isReminderMsg", SessionManager.getIsReminderMsg());
        model.addAttribute("userTimeZoneDate", SessionManager.getUserDate());


        if (SessionManager.isCurrentSiteMaster()) {
            //域名是不是默认
            SysDomainListVo sysDomainListVo = new SysDomainListVo();
            sysDomainListVo.getSearch().setSiteId(SessionManager.getSiteId());
            LOG.debug("用户ID:{0}", SessionManager.getMasterUserId());
            LOG.debug("站点ID:{0}", SessionManager.getSiteId());
            sysDomainListVo.getSearch().setPageUrl(DomainPageUrlEnum.INDEX.getCode());
            sysDomainListVo.getSearch().setIsTemp(false);
            sysDomainListVo.getSearch().setBuildIn(false);

            long count = ServiceTool.sysDomainService().count(sysDomainListVo);
            model.addAttribute("indexDomainTemp", count < 1 && UserTypeEnum.MASTER.equals(SessionManager.getUserType()));
            LOG.debug("站长已设置{0}个站点域名!", count);
            sysDomainListVo.getSearch().setPageUrl(DomainPageUrlEnum.MANAGER.getCode());
            sysDomainListVo.getSearch().setSiteId(null);
            sysDomainListVo.getSearch().setSysUserId(SessionManager.getMasterUserId());
            count = ServiceTool.sysDomainService().count(sysDomainListVo);
            LOG.debug("站长已设置{0}个管理域名!", count);
            model.addAttribute("managerDomainTemp", count < 1 && UserTypeEnum.MASTER.equals(SessionManager.getUserType()));
            if (SessionManager.getFirstLogin()) {
                //任务提醒
                List<Object> objects = new ArrayList<>();
                UserTaskReminderListVo search = ServiceSiteTool.userTaskReminderService().search(listVo);//未读任务
                for (UserTaskReminder taskReminder : search.getResult()) {
                    HashMap<Object, Object> map = new HashMap<>();
                    map.put("id", taskReminder.getId());
                    map.put("dictCode", taskReminder.getDictCode());
                    map.put("toneType", taskReminder.getToneType());
                    map.put("paramValue", taskReminder.getParamValue());
                    objects.add(map);
                }
                Map<String, Object> media = new HashMap<>();
                List<CometMsg> cometMsgs = ServiceTool.noticeService().fetchUnReceivedMsgs(new NoticeVo());
                if (cometMsgs.size() > 0) {
                    media.put("toneType", "notice");
                    objects.add(media);
                }
//                rankInadequate(objects);
                model.addAttribute("unTaskList", JsonTool.toJson(objects));
            }
            //站点名称列表
            model.addAttribute("siteId", StringTool.isNotBlank(SessionManager.getSiteSwitchId()) ? Integer.valueOf(SessionManager.getSiteSwitchId()) : SessionManager.getSiteId());
            //如果是站长获取所有站点信息
            model.addAttribute("sites", getSites());
            Map siteNameMap = new HashMap();
            for (VSysSiteUser sys : getSites()) {
                SiteI18n i18n = Cache.getSiteI18n(SiteI18nEnum.SETTING_SITE_NAME, sys.getId()).get(SessionManager.getLocale().toString());
                if (i18n == null) {
                    continue;
                }
                siteNameMap.put(sys.getId(), i18n.getValue());
            }
            model.addAttribute("siteNames", siteNameMap);
        }
        SessionManager.setFirstLogin(true);
        model.addAttribute("isMaster", SessionManager.isCurrentSiteMaster());
        fetchShortCutMenu(model);

        //顶部任务
        //收款账户 的提示类型（任务，任务+弹窗）
        model.addAttribute("company_deposit", JsonTool.toJson(ParamTool.getSysParams(SiteParamEnum.CONTENT_DEPOSIT_ACCOUNT_WARNING_FREEZE_TYPE)));
        model.addAttribute("online_deposit", JsonTool.toJson(ParamTool.getSysParams(SiteParamEnum.CONTENT_PAY_ACCOUNT_WARNING_ORANGE_TYPE)));
        model.addAttribute("isDebug", SystemTool.isDebug());
        return INDEX_URI;
    }

    //层级不足处理
    private void rankInadequate(List<Object> objects) {
        HashMap<Object, Object> map = new HashMap<>();
        map.put("dictCode", "rankInadequate");
        map.put("paramValue", ServiceSiteTool.vPayRankService().rankInadequate(new VPayRankVo()));
        map.put("toneType", "warm");
        objects.add(map);
    }

    private void fetchShortCutMenu(Model model) {
        //左侧菜单栏
        VUserShortcutMenuListVo menuListVo = new VUserShortcutMenuListVo();
        if (UserTypeEnum.MASTER.getCode().equals(SessionManager.getUserType().getCode())) {
            menuListVo.getSearch().setUserId(SessionManager.getMasterUserId());
        } else {
            menuListVo.getSearch().setUserId(SessionManager.getUserId());
        }
        List<VUserShortcutMenu> vUserShortcutMenus = ServiceSiteTool.vUserShortcutMenuService().queryShortMenuByUser(menuListVo);
        menuListVo.setResult(vUserShortcutMenus);
        filterSubAccountMenu(menuListVo);
        model.addAttribute("menuListVo", menuListVo);
    }

    private void filterSubAccountMenu(VUserShortcutMenuListVo menuListVo) {
        List<VUserShortcutMenu> menuList = new ArrayList<>();
        for (VUserShortcutMenu menu : menuListVo.getResult()) {
            if (StringTool.equals(SessionManager.getUserType().getCode(), UserTypeEnum.MASTER_SUB.getCode()) && StringTool.equals(menu.getResourceId().toString(), "703")) {
                continue;
            }
            //是否有快捷菜单的权限
            boolean hasMenu = hasPermission(menu.getUrl());
            if(!hasMenu){
                continue;
            }
            menuList.add(menu);
        }
        menuListVo.setResult(menuList);
    }

    /**
     * 如果是站长活取子站点信息
     *
     * @return
     */
    private List<VSysSiteUser> getSites() {
        if (SessionManager.isCurrentSiteMaster()) {
            VSysSiteUserListVo vSysSiteUserListVo = new VSysSiteUserListVo();
            vSysSiteUserListVo.getSearch().setSysUserId(SessionManager.getMasterUserId());
            vSysSiteUserListVo.getSearch().setStatus(SiteStatusEnum.NORMAL.getCode());
            vSysSiteUserListVo = ServiceTool.vSysSiteUserService().search(vSysSiteUserListVo);
            return vSysSiteUserListVo.getResult();
        }
        return null;
    }

    /**
     * 未读消息数量
     *
     * @return
     */
    @RequestMapping(value = "/index/unReadMagNum")
    @ResponseBody
    public Integer unReadMagNum() {
        return this.getSiteMsg().size();
    }

    /**
     * 更新首页未读数量
     *
     * @return
     */
    @RequestMapping(value = "/unReadMag")
    @ResponseBody
    private List<VSystemAnnouncement> unReadMag() {
        //获取最新公告
        List<VSystemAnnouncement> vSystemAnnouncements = getvSystemAnnouncements();
        List<VSystemAnnouncement> siteMsg = getSiteMsg();
        if (vSystemAnnouncements != null && vSystemAnnouncements.size() > 0) {
            if (siteMsg != null && siteMsg.size() > 0) {
                vSystemAnnouncements.addAll(siteMsg);
            }
        } else {
            if (siteMsg != null && siteMsg.size() > 0) {
                vSystemAnnouncements = siteMsg;
            }
        }
        vSystemAnnouncements = CollectionQueryTool.sort(vSystemAnnouncements, Order.desc(VSystemAnnouncement.PROP_PUBLISH_TIME));
        return vSystemAnnouncements;
    }

    private List<VSystemAnnouncement> getSiteMsg() {
        //获取站内信-未读数量
        //判断是否是站长
        List<VSystemAnnouncement> vSystemAnnouncements = new ArrayList<>();
        VNoticeReceivedTextListVo vNoticeReceivedTextListVo = new VNoticeReceivedTextListVo();
        List<VNoticeReceivedText> vNoticeReceivedTexts = ServiceTool.noticeService().fetchUnclaimedMsgs(vNoticeReceivedTextListVo);
        for (VNoticeReceivedText text : vNoticeReceivedTexts) {
            VSystemAnnouncement vSystemAnnouncement = new VSystemAnnouncement();
            vSystemAnnouncement.setTitle(text.getTitle());
            vSystemAnnouncement.setPublishTime(text.getReceiveTime());
            vSystemAnnouncement.setContent(text.getContent());
            vSystemAnnouncement.setAnnouncementType("system_msg");
            //站内信id，用于跳转到详情使用
            vSystemAnnouncement.setId(text.getId());
            vSystemAnnouncement.setOperateTime(text.getReceiveTime());
            vSystemAnnouncements.add(vSystemAnnouncement);
        }
        return vSystemAnnouncements;
    }

    private List<VSystemAnnouncement> getvSystemAnnouncements() {
        VSystemAnnouncementListVo vSystemAnnouncementListVo = new VSystemAnnouncementListVo();
        vSystemAnnouncementListVo.setIsAgent("true");
        Date lastLogoutTime = SessionManager.getUser().getLastLogoutTime();
        if (lastLogoutTime == null) {
            lastLogoutTime = DateTool.addDays(SessionManager.getDate().getNow(), -7);
        }
        vSystemAnnouncementListVo.getSearch().setStartTime(lastLogoutTime);
        vSystemAnnouncementListVo.getSearch().setEndTime(SessionManager.getDate().getNow());
        vSystemAnnouncementListVo.getSearch().setLocal(SessionManager.getLocale().toString());
        vSystemAnnouncementListVo.getSearch().setPublishTime(SessionManager.getUser().getCreateTime());
        if (ParamTool.isLotterySite()) {
            vSystemAnnouncementListVo.getSearch().setApiId(NumberTool.toInt(ApiProviderEnum.PL.getCode()));
        }
        vSystemAnnouncementListVo = ServiceTool.vSystemAnnouncementService().searchMasterSystemNotice(vSystemAnnouncementListVo);
        return vSystemAnnouncementListVo.getResult();
    }

    /**
     * 更新首页未读数量
     *
     * @return
     */
    @RequestMapping(value = "/unReadNotice")
    @ResponseBody
    public String unReadNotice() {
        return unReadMag().size() + "";
    }

    /**
     * 头部：消息下拉框
     *
     * @return
     */
    @RequestMapping(value = "/index/message")
    protected String message(HttpServletRequest request, Model model) {
        List<VSystemAnnouncement> unReadMsgCount = unReadMag();
        for (VSystemAnnouncement vSystemAnnouncement : unReadMsgCount) {
            vSystemAnnouncement.setContent(StringTool.replaceHtml(vSystemAnnouncement.getContent()));
        }
        model.addAttribute("unReadCount", unReadMsgCount.size());
        model.addAttribute("msg", unReadMsgCount);
        return INDEX_MESSAGE_URI;
    }

    /**
     * 头部：任务提醒下拉框
     *
     * @return
     */
    @RequestMapping(value = "/index/task")
    public String tasks(Model model) {
        UserTaskReminderListVo taskListVo = new UserTaskReminderListVo();
        List<UserTaskReminder> userTaskReminderList = ServiceSiteTool.userTaskReminderService().unResdTask(taskListVo);
        for (UserTaskReminder userTaskReminder : userTaskReminderList) {
            String dictCode = userTaskReminder.getDictCode();
            TaskReminder taskReminder = TaskReminderHelp.getInstance(dictCode);
            if (taskReminder != null) {
                taskReminder.setTaskReminder(userTaskReminder);
            } else {
                userTaskReminder.setTaskNum(0);
                //LOG.debug(dictCode + "任务提醒类型没有启用");
            }

        }
        //根据时间重新排序任务
        userTaskReminderList = CollectionQueryTool.sort(userTaskReminderList, Order.desc(UserTaskReminder.PROP_UPDATE_TIME));
        model.addAttribute("userTaskReminderList", userTaskReminderList);
        return INDEX_TASK_URI;
    }

    /**
     * 更新是否提示消息session
     */
    @RequestMapping(value = "/index/updateIsReminderMsg")
    @ResponseBody
    protected void updateIsReminderMsg() {
        if (SessionManager.getIsReminderMsg()) {
            SessionManager.setIsReminderMsg(false);
        }
    }

    /**
     * 更新是否任务提示消息session
     */
    @RequestMapping(value = "/index/updateIsReminderTask")
    @ResponseBody
    protected void updateIsReminderTask() {
        if (SessionManager.getIsReminderTask()) {
            SessionManager.setIsReminderTask(false);
        }
    }

    /**
     * 用户所在时区时间
     */
    @RequestMapping(value = "/index/getUserTimeZoneDate")
    @ResponseBody
    public String getUserTimeZoneDate(HttpServletRequest request) {
        SysSiteVo sysSiteVo = new SysSiteVo();
        sysSiteVo.getSearch().setId(SessionManager.getSiteId());
        sysSiteVo = ServiceTool.sysSiteService().get(sysSiteVo);
        Map<String, String> map = new HashMap<>(2, 1f);
        map.put("dateTimeFromat", CommonContext.getDateFormat().getDAY_SECOND());
        map.put("dateTime", SessionManager.getUserDate(CommonContext.getDateFormat().getDAY_SECOND()));
        map.put("dateTime", DateTool.formatDate(new Date(), SessionManagerBase.getLocale(), TimeZone.getTimeZone(sysSiteVo.getResult().getTimezone()), CommonContext.getDateFormat().getDAY_SECOND()));
        map.put("time", String.valueOf(new Date().getTime()));
        return JsonTool.toJson(map);
    }

    public static String format(Date date) {
        SimpleDateFormat format = new SimpleDateFormat(CommonContext.getDateFormat().getDAY());
        long delta = new Date().getTime() - date.getTime();
        if (delta < ONE_MINUTE) {
            return LocaleTool.tranView(Module.MASTER_TASK_REMINDER, "just");
        } else if (delta < 60L * ONE_MINUTE) {
            long minutes = toMinutes(delta);
            return (minutes <= 0 ? 1 : minutes) + LocaleTool.tranView(Module.MASTER_TASK_REMINDER, ONE_MINUTE_AGO);
        } else if (delta < 24L * ONE_HOUR) {
            long hours = toHours(delta);
            return (hours <= 0 ? 1 : hours) + LocaleTool.tranView(Module.MASTER_TASK_REMINDER, ONE_HOUR_AGO);
        } else if (delta < 7L * ONE_DAY) {
            long days = toDays(delta);
            return (days <= 0 ? 1 : days) + LocaleTool.tranView(Module.MASTER_TASK_REMINDER, ONE_DAY_AGO);
        } else {
            return format.format(date);
        }
    }

    private static long toSeconds(long date) {
        return date / 1000L;
    }

    private static long toMinutes(long date) {
        return toSeconds(date) / 60L;
    }

    private static long toHours(long date) {
        return toMinutes(date) / 60L;
    }

    private static long toDays(long date) {
        return toHours(date) / 24L;
    }

    private static long toMonths(long date) {
        return toDays(date) / 30L;
    }

    private static long toYears(long date) {
        return toMonths(date) / 365L;
    }

    @RequestMapping("/index/switchSite")
    @ResponseBody
    public String switchSite(String siteId) {
        List<String> list = new ArrayList<>();
        list.add(siteId);
        List<VSysSiteUser> vSysSiteUsers = CollectionQueryTool.inQuery(getSites(), VSysSiteUser.PROP_ID, list);
        if (vSysSiteUsers.size() == 0) {
            return "false";
        }
        SessionManager.setSwitchSiteId(Integer.parseInt(siteId));
        return "true";
    }

    /**
     * 查出站长设置的声音
     *
     * @return
     */
    @RequestMapping({"/index/queryTones"})
    @ResponseBody
    public Collection<SysParam> queryTones() {
        Collection<SysParam> sysParams = ParamTool.getSysParams(SiteParamEnum.WARMING_TONE_DEPOSIT);
        for (SysParam param : sysParams) {
            //如果参数设置不启用，则不启用
            if (!param.getActive()) {
                continue;
            }
            if (SiteParamEnum.WARMING_TONE_DEPOSIT.getCode().equals(param.getParamCode()) && SessionManager.getCompanyVoiceNotice() != null) {
                param.setActive(SessionManager.getCompanyVoiceNotice());
            }
            if (SiteParamEnum.WARMING_TONE_ONLINEPAY.getCode().equals(param.getParamCode()) && SessionManager.getOnlineVoiceNotice() != null) {
                param.setActive(SessionManager.getOnlineVoiceNotice());
            }
            if (SiteParamEnum.WARMING_TONE_DRAW.getCode().equals(param.getParamCode())) {
                if (SessionManager.getWithdrawNotice() != null) {
                    param.setActive(SessionManager.getWithdrawNotice());
                } else if (SessionManager.getAgentWithdrawNotice() != null) {
                    param.setActive(SessionManager.getAgentWithdrawNotice());
                }

            }
        }
        return sysParams;
    }

    @Override
    protected String language() {
        JSONObject jb = new JSONObject();
        String languageCurrent = CommonContext.get().getLocale().toString();
        Map<String, SiteLanguage> availableSiteLanguage = Cache.getAvailableSiteLanguage();
        Map<String, Map<String, Map<String, String>>> dicts = I18nTool.getDictsMap(languageCurrent);
        jb.put("languageCurrent", languageCurrent);
        jb.put("languageDicts", availableSiteLanguage);
        Map<String, Map<String, String>> stringMapMap = dicts.get("common");
        if (stringMapMap != null) {
            jb.put("languageI18n", stringMapMap.get("language"));
        }
        return jb.toString();
    }

    @RequestMapping("/index/taskNum")
    @ResponseBody
    public Integer getTaskNum() {
        return TaskReminderHelp.countTask();
    }

    @RequestMapping("/index/timingCountTask")
    @ResponseBody
    public Map<String, Object> timingCountTask() {
        Map<String, Integer> taskSituationMap = TaskReminderHelp.taskSituation();
        Map<String, Object> map = new HashMap<>();
        int taskCount = 0;
        for (Integer count : taskSituationMap.values()) {
            taskCount = taskCount + count;
        }
        //任务数量
        map.put("taskCount", taskCount);
        map.put("tasks", taskSituationMap);
        return map;
    }

    @RequestMapping("/index/countPendingRecord")
    @ResponseBody
    public Map countPendingRecord() {
        Map result = new HashMap();

        Collection<SysParam> sysParams = ParamTool.getSysParams(SiteParamEnum.WARMING_TONE_AUDIT);
        String depositVoice = "";
        String withdrawVoice = "";
        boolean isActiviteDeposit = true;
        boolean isActiviteDraw = true;
        for (SysParam sysParam : sysParams) {
            if ("deposit".equals(sysParam.getParamCode())) {
                depositVoice = sysParam.getParamValue();
                isActiviteDeposit = sysParam.getActive();
            } else if ("draw".equals(sysParam.getParamCode())) {
                withdrawVoice = sysParam.getParamValue();
                isActiviteDraw = sysParam.getActive();
            }
        }

        if (isActiviteDeposit) {
            if (hasPermission("fund/deposit/company/list.html") && (SessionManager.getCompanyVoiceNotice() == null || SessionManager.getCompanyVoiceNotice())) {
                Integer count = 0;
                VPlayerDepositVo vPlayerDepositVo = new VPlayerDepositVo();
                if (UserTypeEnum.MASTER_SUB.getCode().equals(SessionManager.getUser().getUserType())) {
                    SysUserDataRightVo sysUserDataRightVo = new SysUserDataRightVo();
                    sysUserDataRightVo.getSearch().setUserId(SessionManager.getUserId());
                    sysUserDataRightVo.getSearch().setModuleType(DataRightModuleType.COMPANYDEPOSIT.getCode());
                    List entityIds = ServiceSiteTool.sysUserDataRightService().searchDataRightEntityId(sysUserDataRightVo);
                    if (entityIds != null && entityIds.size() > 0) {
                        vPlayerDepositVo.getSearch().setRankIds(entityIds);
                        count = ServiceSiteTool.vPlayerDepositService().countCompanyDeposit(vPlayerDepositVo);
                    } else {
                        count = ServiceSiteTool.vPlayerDepositService().countCompanyDeposit(vPlayerDepositVo);
                    }
                } else {
                    count = ServiceSiteTool.vPlayerDepositService().countCompanyDeposit(vPlayerDepositVo);
                }

                result.put("companyDepositCount", count);
                result.put("depositVoice", depositVoice);
            }
        }

        if (isActiviteDraw) {
            if (hasPermission("fund/withdraw/withdrawAuditView.html") && (SessionManager.getWithdrawNotice() == null || SessionManager.getWithdrawNotice())) {
                Integer withdrawCount = 0;
                VPlayerWithdrawListVo vPlayerWithdrawListVo = new VPlayerWithdrawListVo();
                if (UserTypeEnum.MASTER_SUB.getCode().equals(SessionManager.getUser().getUserType())) {
                    SysUserDataRightVo sysUserDataRightVo = new SysUserDataRightVo();
                    sysUserDataRightVo.getSearch().setUserId(SessionManager.getUserId());
                    sysUserDataRightVo.getSearch().setModuleType(DataRightModuleType.PLAYERWITHDRAW.getCode());
                    List entityIds = ServiceSiteTool.sysUserDataRightService().searchDataRightEntityId(sysUserDataRightVo);
                    if (entityIds != null && entityIds.size() > 0) {
                        vPlayerWithdrawListVo.getSearch().setRankIds(entityIds);
                        withdrawCount = ServiceSiteTool.vPlayerWithdrawService().unlockPendingWithdraw(vPlayerWithdrawListVo);
                    } else {
                        withdrawCount = ServiceSiteTool.vPlayerWithdrawService().unlockPendingWithdraw(vPlayerWithdrawListVo);
                    }
                } else {
                    withdrawCount = ServiceSiteTool.vPlayerWithdrawService().unlockPendingWithdraw(vPlayerWithdrawListVo);
                }

                result.put("playerWithdrawCount", withdrawCount);
                result.put("withdrawVoice", withdrawVoice);
            }

        }


        return result;
    }

    private boolean hasPermission(String url) {
        Map<String, Pair<String, Boolean>> per = (Map) SessionManager.getAttribute(SessionKey.S_USER_PERMISSIONS);
        if (SessionManager.isCurrentSiteMaster() || per.containsKey(url)) {
            return true;
        }
        return false;
    }

    @RequestMapping("/index/showPop")
    @ResponseBody
    public Map showPop(HttpServletRequest request) {
        Map result = new HashMap();
        SysParamVo sysParamVo = getSysParamVo();
        String content = request.getParameter("content");
        if (sysParamVo.getResult() == null) {
            insertPersonParam(sysParamVo);
            result.put("isShow", "true");
        } else {
            result.put("isShow", sysParamVo.getResult().getParamValue());
        }

        return result;
    }

    private void insertPersonParam(SysParamVo sysParamVo) {
        SysParam sysParam = new SysParam();
        sysParam.setModule(Module.MASTER_SETTING.getCode());
        sysParam.setParamType(SiteParamEnum.SETTING_SHOWPOP.getType());
        sysParam.setParamCode(SessionManager.getUserId().toString());
        if (StringTool.isBlank(sysParamVo.getSearch().getParamValue())) {
            sysParam.setParamValue("true");
        } else {
            sysParam.setParamValue(sysParamVo.getSearch().getParamValue());
        }

        sysParam.setDefaultValue("true");
        sysParam.setActive(true);
        sysParam.setRemark("是否弹窗提醒");
        sysParamVo.setResult(sysParam);
        ServiceSiteTool.siteSysParamService().insert(sysParamVo);
    }

    private SysParamVo getSysParamVo() {
        SysParamVo sysParamVo = new SysParamVo();
        sysParamVo.getSearch().setModule(Module.MASTER_SETTING.getCode());
        sysParamVo.getSearch().setParamType(SiteParamEnum.SETTING_SHOWPOP.getType());
        sysParamVo.getSearch().setParamCode(SessionManager.getUserId().toString());
        sysParamVo = ServiceSiteTool.siteSysParamService().searchByModuleTypeCode(sysParamVo);
        return sysParamVo;
    }

    @RequestMapping("/index/savePersonShowpop")
    @ResponseBody
    public Map savePersonShowpop(String isShow) {
        Map result = new HashMap();
        try {
            SysParamVo sysParamVo = getSysParamVo();
            if (sysParamVo.getResult() == null) {
                sysParamVo.getSearch().setParamValue(isShow);
                insertPersonParam(sysParamVo);
            } else {
                sysParamVo.getResult().setParamValue(isShow);
                sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE);
                ServiceSiteTool.siteSysParamService().updateOnly(sysParamVo);
            }
            result.put("state", true);
        } catch (Exception ex) {
            result.put("state", false);
        }

        return result;
    }

    @RequestMapping("/index/profitLimit")
    @ResponseBody
    public Map<String, Object> profitLimit() {
        Map<String, Object> map = new HashMap<>(3, 1f);
        boolean isMaster = SessionManager.isCurrentSiteMaster();
        map.put("isMaster", isMaster);
        //站长账号显示盈利上限，非站长账号不显示
        if (isMaster) {
            Double creditLine = getProfitLimit().getCreditLine();
            if (creditLine != null) {
                map.put("profitLimit", getProfitLimit().getMaxProfit() + getProfitLimit().getCreditLine());//额度上限值
            } else {
                map.put("profitLimit", getProfitLimit().getMaxProfit());
            }
            //统一一个地方
            Double profit = fetchSiteHasUseProfit();//CreditHelper.getProfit(SessionManager.getSiteId(), CommonContext.get().getSiteTimeZone());
            map.put("profit", profit);//本月使用额度值
            map.put("profitCur", CurrencyTool.formatCurrency(profit));
            Double transferLimit = getProfitLimit().getCurrentTransferLimit() == null ? 0d : getProfitLimit().getCurrentTransferLimit();
            if (getProfitLimit().getTransferLine()!=null){
                map.put("transferLimit", transferLimit + getProfitLimit().getTransferLine());//转账上限值
            }else {
                map.put("transferLimit", transferLimit);//转账上限值
            }
            double transferOutSum = getProfitLimit().getTransferOutSum() == null ? 0 : getProfitLimit().getTransferOutSum();
            double transferIntoSum = getProfitLimit().getTransferIntoSum() == null ? 0 : getProfitLimit().getTransferIntoSum();
            double currentProfit = transferOutSum - transferIntoSum;
            map.put("currentProfit", CurrencyTool.formatCurrency(currentProfit));
            map.put("currentProfitNumber", currentProfit);
        }
        return map;
    }

    /**
     * 查询额度
     *
     * @return
     */
    @RequestMapping("/index/profitLimitDialog")
    @ResponseBody
    public Map<String, Object> profitLimitDialog() {
        Map<String, Object> map = new HashMap<>(2, 1f);
        SysSiteCreditVo sysSiteCreditVo = new SysSiteCreditVo();
        sysSiteCreditVo.getSearch().setId(SessionManager.getSiteId());
        double creditLine = 0.0;
        sysSiteCreditVo = ServiceTool.sysSiteCreditService().get(sysSiteCreditVo);
        if (sysSiteCreditVo.getResult() != null) {
            creditLine = sysSiteCreditVo.getResult().getCreditLine() != null ? sysSiteCreditVo.getResult().getCreditLine() : 0;
        }
        Double profit = fetchSiteHasUseProfit();
        map.put("profit", profit);//本月使用额度值
        map.put("profitLimit", getProfitLimit().getMaxProfit() + creditLine);//额度上限值
        Date profitTime = getProfitLimit().getProfitTime();
        if (profitTime != null) {
            Date time = new Date();
            map.put("leftTime", DateTool.secondsBetween(time, SessionManager.getDate().getNow()));//倒计时
        }
        return map;
    }

    /**
     * 已使用额度
     *
     * @return
     */
    private double fetchSiteHasUseProfit() {
        SysSiteCreditVo sysSiteCreditVo = new SysSiteCreditVo();
        sysSiteCreditVo.getSearch().setId(SessionManager.getSiteId());
        sysSiteCreditVo = ServiceTool.sysSiteCreditService().get(sysSiteCreditVo);
        if (sysSiteCreditVo.getResult() != null) {
            return sysSiteCreditVo.getResult().getHasUseProfit() == null ? 0d : sysSiteCreditVo.getResult().getHasUseProfit();
        }
        return 0d;
    }

    /**
     * 获取盈利上限值
     *
     * @return
     */
    private SysSiteCredit getProfitLimit() {
        SysSiteCreditVo sysSiteCreditVo = new SysSiteCreditVo();
        sysSiteCreditVo.getSearch().setId(SessionManager.getSiteId());
        sysSiteCreditVo = ServiceTool.sysSiteCreditService().get(sysSiteCreditVo);
        SysSiteCredit sysSiteCredit = sysSiteCreditVo.getResult();
        if (sysSiteCredit == null) {
            LOG.info("查不到该站点,siteId:{0}", SessionManager.getSiteId());
            return null;
        }
        return sysSiteCredit;
    }

    /**
     * 查询本月1号到昨日的数据从统计库获取
     *
     * @return
     */
    private Double getMonthProfit() {
        OperationProfileVo operationProfileVo = new OperationProfileVo();
        operationProfileVo.getSearch().setSiteId(SessionManager.getSiteId());
        operationProfileVo.getSearch().setStartTime(SessionManager.getDate().getMonthFirstDay(SessionManager.getTimeZone()));
        operationProfileVo.getSearch().setEndTime(SessionManager.getDate().getToday());
        Double monthProfit = ServiceTool.operationProfileService().queryProfit(operationProfileVo);
        return monthProfit == null ? 0d : -monthProfit;
    }

    /**
     * 今日盈利从player_game_order里查询
     *
     * @return
     */
    private Double getTodayProfit() {
        Date today = SessionManager.getDate().getToday();
        PlayerGameOrderVo playerGameOrderVo = new PlayerGameOrderVo();
        playerGameOrderVo.getSearch().setBeginPayoutTime(today);
        playerGameOrderVo.getSearch().setEndPayoutTime(DateTool.addDays(today, 1));
        Double todayProfit = ServiceSiteTool.playerGameOrderService().queryProfit(playerGameOrderVo);
        return todayProfit == null ? 0d : -todayProfit;
    }

    @RequestMapping("/printPlayLog")
    @ResponseBody
    public Map printPlayLog(HttpServletRequest request){
        Map<String, String[]> parameterMap = request.getParameterMap();
        if(MapTool.isNotEmpty(parameterMap)){
            for (String paramter : parameterMap.keySet()) {
                LOG.info("播放声音参数:{0}--{1}",paramter,parameterMap.get(paramter));
            }
        }
        return parameterMap;
    }

    @Override
    protected String fetchExtNo() {
        return SessionManager.getUser().getIdcard();
    }
}
