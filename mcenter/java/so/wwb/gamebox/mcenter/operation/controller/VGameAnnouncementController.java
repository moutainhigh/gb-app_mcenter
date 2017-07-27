package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.net.ServletTool;
import org.soul.commons.support._Module;
import org.soul.model.msg.notice.vo.NoticeReceiveVo;
import org.soul.model.msg.notice.vo.VNoticeReceivedTextListVo;
import org.soul.model.msg.notice.vo.VNoticeReceivedTextVo;
import org.soul.model.security.privilege.po.SysUser;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.company.operator.ISystemAnnouncementService;
import so.wwb.gamebox.mcenter.operation.form.SystemAnnouncementForm;
import so.wwb.gamebox.mcenter.operation.form.SystemAnnouncementSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.company.operator.po.SystemAnnouncement;
import so.wwb.gamebox.model.company.operator.po.VSystemAnnouncement;
import so.wwb.gamebox.model.company.operator.vo.SystemAnnouncementListVo;
import so.wwb.gamebox.model.company.operator.vo.SystemAnnouncementVo;
import so.wwb.gamebox.model.company.operator.vo.VSystemAnnouncementListVo;
import so.wwb.gamebox.model.master.enums.AnnouncementTypeEnum;
import so.wwb.gamebox.model.master.player.enums.PlayerAdvisoryEnum;
import so.wwb.gamebox.model.master.player.po.PlayerAdvisory;
import so.wwb.gamebox.model.master.player.po.VPlayerAdvisory;
import so.wwb.gamebox.model.master.player.vo.PlayerAdvisoryVo;
import so.wwb.gamebox.model.master.player.vo.VPlayerAdvisoryListVo;
import so.wwb.gamebox.web.cache.Cache;

import javax.servlet.http.HttpServletRequest;
import java.util.*;


/**
 * 游戏公告视图控制器
 *
 * @author orange
 * @time 2015-10-22 16:29:08
 */
@Controller
@RequestMapping("/operation/announcementMessage")
public class VGameAnnouncementController extends BaseCrudController<ISystemAnnouncementService, SystemAnnouncementListVo, SystemAnnouncementVo, SystemAnnouncementSearchForm, SystemAnnouncementForm, SystemAnnouncement, Integer> {

    private static final String MESSAGE_INDEX_URL = "/operation/announcementMessage/Index";
    private static final String ANNOUNCEMENT_DETAIL_URL = "/operation/announcementMessage/AnnouncementDetail";
    private static final String ADVISORY_MESSAGE_URL = "/operation/announcementMessage/AdvisoryMessage";
    private static final String ADVISORY_MESSAGE_LIST_URL = "/operation/announcementMessage/advisory/AdvisoryList";
    private static final String MESSAGE_DETAIL_URL = "/operation/announcementMessage/MessageDetail";
    private static final String ANNOUNCEMENT_INDEX_URL = "/operation/announcementMessage/GameAnnouncement";
    //系统公告
    private static final String SYSTEM_NOTICE_HISTORY_URL = "/operation/announcementMessage/SystemNoticeHistory";
    //详情
    private static final String SYSTEM_NOTICE_DETAIL_URL = "/operation/announcementMessage/SystemNoticeDetail";
    //公告弹窗
    private static final String ANNOUNCEMENT_POPUP_URL = "/operation/announcementMessage/AnnouncementPopup";

    @Override
    protected String getViewBasePath() {
        return "/operation/announcementMessage/";
    }

    /**
     * -系统消息-显示
     *
     * @param listVo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/messageList")
    public String messageList(VNoticeReceivedTextListVo listVo, VPlayerAdvisoryListVo aListVo, Model model, HttpServletRequest request) {
        //判断是否是站长
        listVo.getSearch().setReceiverId(SessionManager.getUserId());
        listVo = ServiceTool.noticeService().fetchReceivedSiteMsg(listVo);
        model.addAttribute("command", listVo);
        //未读数量
        this.unReadCount(aListVo, model);

        return ServletTool.isAjaxSoulRequest(request) ? MESSAGE_INDEX_URL + "Partial" : MESSAGE_INDEX_URL;
    }

    private void unReadCount(VPlayerAdvisoryListVo aListVo, Model model) {

        //系统消息-未读数量
        VNoticeReceivedTextVo vNoticeReceivedTextVo = new VNoticeReceivedTextVo();
        Long length = ServiceTool.noticeService().fetchUnclaimedMsgCount(vNoticeReceivedTextVo);
        model.addAttribute("length", length);
        //系统公告-新增数量
        SysUser user = SessionManager.getUser();
        SystemAnnouncementVo systemVo = new SystemAnnouncementVo();
        systemVo.setResult(new SystemAnnouncement());
        Date startTime = user.getLastLogoutTime() == null ? user.getLastLoginTime() : user.getLastLogoutTime();
        Date endTime = user.getLoginTime() == null ? new Date() : user.getLoginTime();
        systemVo.setStartTime(startTime == null ? user.getCreateTime() : startTime);
        systemVo.setEndTime(endTime);
        systemVo.getSearch().setAnnouncementType(AnnouncementTypeEnum.SYSTEM.getCode());
        Long systemUnReadCount = ServiceTool.systemAnnouncementService().searchSystemAnnouncementUnreadCount(systemVo);
        model.addAttribute("systemUnReadCount", systemUnReadCount);
        //游戏公告-新增数量
        SystemAnnouncementVo gameVo = new SystemAnnouncementVo();
        gameVo.setResult(new SystemAnnouncement());
        gameVo.setStartTime(startTime == null ? user.getCreateTime() : startTime);
        gameVo.setEndTime(endTime);
        gameVo.getSearch().setAnnouncementType(AnnouncementTypeEnum.GAME.getCode());
        Long gameUnReadCount = ServiceTool.systemAnnouncementService().searchSystemAnnouncementUnreadCount(gameVo);
        model.addAttribute("gameUnReadCount", gameUnReadCount);
        //玩家咨询-未读数量
        aListVo.getSearch().setAdvisoryTime(DateTool.addDays(new Date(), -30));
        aListVo.getSearch().setQuestionType(PlayerAdvisoryEnum.QUESTION.getCode());
        aListVo.setPaging(null);
        aListVo = ServiceTool.vPlayerAdvisoryService().search(aListVo);
        aListVo.changeReadState(SessionManager.getUserId());//判断是否已读
        Integer advisoryUnReadCount = 0;
        for (VPlayerAdvisory obj : aListVo.getResult()) {
            if (obj.getRead() == false) {
                advisoryUnReadCount++;
            }
        }
        model.addAttribute("advisoryUnReadCount", advisoryUnReadCount);
    }

    /**
     * 运营管理-系统消息详细
     *
     * @param vo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/announcementDetail")
    public String announcementDetail(VNoticeReceivedTextVo vo, NoticeReceiveVo noticeReceiveVo, Model model, HttpServletRequest request) {
        List list = new ArrayList();
        list.add(noticeReceiveVo.getSearch().getId());
        noticeReceiveVo.setIds(list);
        boolean read = ServiceTool.noticeService().markSiteMsg(noticeReceiveVo);

        vo = ServiceTool.noticeService().fetchReceivedSiteMsgDetail(vo);
        /*替换内容包含${user}的内容 */
        if(vo.getResult().getContent().contains("${user}")){
            String replace = vo.getResult().getContent().replace("${user}",SessionManager.getUserName());
            vo.getResult().setContent(replace);
        }
        model.addAttribute("command", vo);
        model.addAttribute("read", read);
        return ANNOUNCEMENT_DETAIL_URL;
    }

    /**
     * 运营管理-消息公告-标记已读
     *
     * @param ids
     * @param model
     * @return
     */
    @RequestMapping("/messageEditStatus")
    @ResponseBody
    public Map messageEditStatus(NoticeReceiveVo noticeReceiveVo, String ids, Model model) {
        String[] idArray = ids.split(",");
        List<Integer> list = new ArrayList();
        for (String id : idArray) {
            list.add(Integer.valueOf(id));
        }
        noticeReceiveVo.setIds(list);
        boolean b = ServiceTool.noticeService().markSiteMsg(noticeReceiveVo);

        if (b) {
            noticeReceiveVo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "update.success"));
        } else {
            noticeReceiveVo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "update.failed"));
        }
        HashMap map = new HashMap(2,1f);
        map.put("msg", StringTool.isNotBlank(noticeReceiveVo.getOkMsg()) ? noticeReceiveVo.getOkMsg() : noticeReceiveVo.getErrMsg());
        map.put("state", Boolean.valueOf(b));
        return map;
    }

    /**
     * 运营管理-消息公告-删除系统消息
     *
     * @param vo
     * @param ids
     * @return
     */
    @RequestMapping("/deleteNoticeReceived")
    @ResponseBody
    public Map deleteNoticeReceived(NoticeReceiveVo vo, String ids) {
        String[] idArray = ids.split(",");
        List<Integer> list = new ArrayList();
        for (String id : idArray) {
            list.add(Integer.valueOf(id));
        }
        vo.setIds(list);
        boolean bool = ServiceTool.noticeService().deleteSiteMsg(vo);

        if (bool) {
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "delete.success"));
        } else {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "delete.failed"));
        }
        HashMap map = new HashMap(2,1f);
        map.put("msg", StringTool.isNotBlank(vo.getOkMsg()) ? vo.getOkMsg() : vo.getErrMsg());
        map.put("state", Boolean.valueOf(vo.isSuccess()));
        return map;
    }

    /**
     * 系统公告
     *
     * @param request
     * @param vListVo
     * @param model
     * @return
     */
    @RequestMapping("/systemNoticeHistory")
    public String systemNoticeHistory(HttpServletRequest request, VPlayerAdvisoryListVo aListVo, VSystemAnnouncementListVo vListVo, Model model) {
        if(vListVo.getSearch().getStartTime()==null && vListVo.getSearch().getEndTime()==null){
            vListVo.getSearch().setStartTime(DateTool.addMonths(SessionManager.getDate().getNow(), -1));
            vListVo.getSearch().setEndTime(SessionManager.getDate().getNow());
        }
        vListVo.setIsAgent("true");
        vListVo.getSearch().setLocal(SessionManager.getLocale().toString());
        vListVo.getSearch().setPublishTime(SessionManager.getUser().getCreateTime());
        vListVo = ServiceTool.vSystemAnnouncementService().searchMasterSystemNotice(vListVo);
        model.addAttribute("command", vListVo);
        model.addAttribute("maxDate", new Date());
        //未读数量
        this.unReadCount(aListVo, model);

        return ServletTool.isAjaxSoulRequest(request) ? SYSTEM_NOTICE_HISTORY_URL + "Partial" : SYSTEM_NOTICE_HISTORY_URL;
    }

    /**
     * 系统公告详细
     *
     * @param model
     * @param vSystemAnnouncementListVo
     * @return
     */
    @RequestMapping("/systemNoticeDetail")
    public String systemNoticeDetail(Model model, VSystemAnnouncementListVo vSystemAnnouncementListVo) {
        vSystemAnnouncementListVo.getSearch().setLocal(SessionManager.getLocale().toString());
        vSystemAnnouncementListVo = ServiceTool.vSystemAnnouncementService().search(vSystemAnnouncementListVo);
        model.addAttribute("vSystemAnnouncementListVo", vSystemAnnouncementListVo);
        return SYSTEM_NOTICE_DETAIL_URL;
    }

    /**
     * 运营商-系统公告-发布信息-展示弹窗
     *
     * @param model
     * @param vSystemAnnouncementListVo
     * @return
     */
    @RequestMapping("/announcementPopup")
    public String announcementPopup(Model model, VSystemAnnouncementListVo vSystemAnnouncementListVo) {
        vSystemAnnouncementListVo.getSearch().setLocal(SessionManager.getLocale().toString());
        vSystemAnnouncementListVo = ServiceTool.vSystemAnnouncementService().search(vSystemAnnouncementListVo);
        model.addAttribute("vSystemAnnouncementListVo", vSystemAnnouncementListVo);
        return ANNOUNCEMENT_POPUP_URL;
    }

    /**
     * 运营管理-游戏公告
     *
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/gameAnnouncement")
    public String gameAnnouncement(VSystemAnnouncementListVo listVo, VPlayerAdvisoryListVo aListVo, Model model, HttpServletRequest request) {
        if(listVo.getSearch().getStartTime()==null && listVo.getSearch().getEndTime()==null){
            listVo.getSearch().setStartTime(DateTool.addMonths(SessionManager.getDate().getNow(), -1));
            listVo.getSearch().setEndTime(SessionManager.getDate().getNow());
        }
        listVo.getSearch().setLocal(SessionManager.getLocale().toString());
        listVo.getSearch().setAnnouncementType(AnnouncementTypeEnum.GAME.getCode());
        listVo.getSearch().setPublishTime(SessionManager.getUser().getCreateTime());
        listVo = ServiceTool.vSystemAnnouncementService().searchMasterSystemNotice(listVo);
        for (VSystemAnnouncement vSystemAnnouncement : listVo.getResult()) {
            vSystemAnnouncement.setContent(StringTool.replaceHtml(vSystemAnnouncement.getContent()));
        }
        model.addAttribute("command", listVo);

        Map apiMap = Cache.getSiteApiI18n();
        model.addAttribute("apiMap", apiMap);
        model.addAttribute("maxDate", new Date());
        //未读数量
        this.unReadCount(aListVo, model);

        return ServletTool.isAjaxSoulRequest(request) ? ANNOUNCEMENT_INDEX_URL + "Partial" : ANNOUNCEMENT_INDEX_URL;
    }
    @RequestMapping("/advisoryList")
    public String advisoryList(VPlayerAdvisoryListVo listVo, VPlayerAdvisoryListVo aListVo, Model model, HttpServletRequest request){
        //查询时间加一秒
        if(listVo.getSearch().getAdvisoryTimeEnd()!=null) {
            Date advisoryTimeEnd = listVo.getSearch().getAdvisoryTimeEnd();
            advisoryTimeEnd.setSeconds(advisoryTimeEnd.getSeconds() + 1);
            listVo.getSearch().setAdvisoryTimeEnd(advisoryTimeEnd);
        }
        listVo = getvPlayerAdvisoryListVo(listVo);
        model.addAttribute("advisoryType", DictTool.get(DictEnum.ADVISORY_TYPE));
        model.addAttribute("command", listVo);
        String hasReturn = request.getParameter("hasReturn");
        if(StringTool.isNotBlank(hasReturn)){
            model.addAttribute("hasReturn",true);
        }
        return ServletTool.isAjaxSoulRequest(request) ? ADVISORY_MESSAGE_LIST_URL + "Partial" : ADVISORY_MESSAGE_LIST_URL;
    }

    /**
     * 站长-运营-消息公告-玩家咨询
     *
     * @param listVo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/advisoryMessage")
    public String advisoryMessage(VPlayerAdvisoryListVo listVo, VPlayerAdvisoryListVo aListVo, Model model, HttpServletRequest request) {
        listVo = getvPlayerAdvisoryListVo(listVo);
        model.addAttribute("command", listVo);
        //未读数量
        this.unReadCount(aListVo, model);
        return ServletTool.isAjaxSoulRequest(request) ? ADVISORY_MESSAGE_URL + "Partial" : ADVISORY_MESSAGE_URL;
    }

    private VPlayerAdvisoryListVo getvPlayerAdvisoryListVo(VPlayerAdvisoryListVo listVo) {
        //提问内容
        if(listVo.getSearch().getAdvisoryTimeBegin() == null && listVo.getSearch().getAdvisoryTimeEnd() == null){
            listVo.getSearch().setAdvisoryTime(DateTool.addMonths(SessionManager.getDate().getNow(), -1));
        }
        listVo = ServiceTool.vPlayerAdvisoryService().search(listVo);
        listVo.changeReadState(SessionManager.getUserId());
        //获取全部的追问咨询是否已读
        List<VPlayerAdvisory> list = new ArrayList();
        for(VPlayerAdvisory vp:listVo.getResult()){
            if(PlayerAdvisoryEnum.PUMP.getCode().equals(vp.getQuestionType())){
                VPlayerAdvisory vPlayerAdvisory = new VPlayerAdvisory();
                vPlayerAdvisory.setContinueQuizId(vp.getContinueQuizId());
                vPlayerAdvisory.setRead(vp.getRead());
                list.add(vPlayerAdvisory);
            }
        }
        //把未读的追问咨询同步到他的父类咨询问题
        for(VPlayerAdvisory advisory:listVo.getResult()){
            if(PlayerAdvisoryEnum.QUESTION.getCode().equals(advisory.getQuestionType())){
                for(VPlayerAdvisory obj:list){
                    if(advisory.getId().equals(obj.getContinueQuizId()) && obj.getRead()==false){
                        advisory.setRead(false);
                    }
                }
            }
        }
        return listVo;
    }

    /**
     * 运营管理-消息公告-游戏消息详细显示
     *
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping("/messageDetail")
    public String messageDetail(VSystemAnnouncementListVo vo, Model model) {
        vo.getSearch().setLocal(SessionManager.getLocale().toString());
        vo = ServiceTool.vSystemAnnouncementService().search(vo);
        model.addAttribute("command", vo);
        return MESSAGE_DETAIL_URL;
    }

    /**
     * 运营管理-消息公告-咨询消息-删除
     *
     * @param vo
     * @param ids
     * @param model
     * @return
     */
    @RequestMapping("/deleteAdvisoryMessage")
    @ResponseBody
    public Map deleteAdvisoryMessage(PlayerAdvisoryVo vo, String ids, Model model) {
        String[] id = ids.split(",");
        for (String messageId : id) {
            vo.setSuccess(false);
            vo.setResult(new PlayerAdvisory());
            vo.getResult().setId(Integer.valueOf(messageId));
            vo.getResult().setStatus(true);
            vo.setProperties(PlayerAdvisory.PROP_STATUS);
            vo = ServiceTool.playerAdvisoryService().updateOnly(vo);
        }
        if (vo.isSuccess()) {
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "delete.success"));
        } else {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "delete.failed"));
        }
        HashMap map = new HashMap(2,1f);
        map.put("msg", StringTool.isNotBlank(vo.getOkMsg()) ? vo.getOkMsg() : vo.getErrMsg());
        map.put("state", Boolean.valueOf(vo.isSuccess()));
        return map;
    }


}