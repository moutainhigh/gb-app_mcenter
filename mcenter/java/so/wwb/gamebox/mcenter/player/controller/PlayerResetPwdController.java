
package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.collections.MapTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.string.RandomStringTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.log.LogFactory;
import org.soul.model.log.audit.enums.OpMode;
import org.soul.model.log.audit.enums.OpType;
import org.soul.model.log.audit.vo.BaseLog;
import org.soul.model.log.audit.vo.LogVo;
import org.soul.model.msg.notice.enums.NoticePublishMethod;
import org.soul.model.msg.notice.po.NoticeTmpl;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.model.sys.po.SysAuditLog;
import org.soul.model.sys.po.SysDict;
import org.soul.web.session.RedisSessionDao;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.player.form.ResetPwdForm;
import so.wwb.gamebox.mcenter.player.form.ResetSysUserPwdForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.ModuleType;
import so.wwb.gamebox.model.SiteI18nEnum;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.common.notice.enums.AutoNoticeEvent;
import so.wwb.gamebox.model.master.agent.vo.ResetSysUserPwdVo;
import so.wwb.gamebox.model.master.player.vo.ResetPwdVo;
import so.wwb.gamebox.model.master.player.vo.VUserPlayerVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.shiro.common.filter.KickoutFilter;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * Created by tony on 15-6-4.
 */
@Controller
@RequestMapping(value = "player/resetPwd")
public class PlayerResetPwdController {
    @Autowired
    private RedisSessionDao redisSessionDao;
    /**
     * TODO 发送消息,更改修改密码字段,邮箱状态
     */
    private static final String RESET_LOGIN_POPUP = "player/player/resetpassword/Index";
    private static final String RESET_LOGIN_BY_HAND = "player/player/resetpassword/ChangePassword";
    private static final String RESET_PWD_POPUP = "/player/agent/restpwd/ResetPwdIndex";
    private static final String RESET_PWD_EDIT_POPUP = "/player/agent/restpwd/ResetPwdEdit";
    private static final String RESET_TYPE_PAY_PWD = "payPwd";
    private static final String RESET_TYPE_LOGIN_PWD = "loginPwd";

    /**
     * 重置登录密码弹窗
     *
     * @param model
     * @param resetPwdVo
     * @return
     */
    @RequestMapping("/index")
    public String resetPwd(Model model, ResetPwdVo resetPwdVo) {
        model.addAttribute("resetPwdVo", ServiceSiteTool.userPlayerService().getResetPasswordInfo(resetPwdVo));
        return RESET_LOGIN_POPUP;
    }

    @RequestMapping("/isOnline")
    @ResponseBody
    public Map isOnline(ResetPwdVo resetPwdVo) {
        Map map = new HashMap();
        SysUserVo userVo = new SysUserVo();
        userVo.getResult().setId(resetPwdVo.getUserId());
        userVo = ServiceTool.sysUserService().get(userVo);
        Set<String> count = redisSessionDao.getUserActiveSessions(userVo.getResult().getUserType(), userVo.getResult().getId());
        map.put("state", (count.size() > 0));
        return map;
    }

    /**
     * 手动重置登录密码弹窗
     *
     * @param model
     * @param resetPwdVo
     * @return
     */
    @RequestMapping("/resetPwdByHand")
    public String loginPwdByHand(Model model, ResetPwdVo resetPwdVo) {
        SysUserVo userVo = new SysUserVo();
        userVo.getSearch().setId(resetPwdVo.getUserId());
        userVo = ServiceTool.sysUserService().get(userVo);
        Set<String> count = redisSessionDao.getUserActiveSessions(userVo.getResult().getUserType(), userVo.getResult().getId());
        model.addAttribute("isOnLine", (count.size() > 0));
        Map<String, SysDict> mailMobilePhoneStatus = DictTool.get(DictEnum.PLAYER_MAIL_MOBILEPHONE_STATUS);
        resetPwdVo.setMailMobilePhoneStatus(mailMobilePhoneStatus);
        resetPwdVo.setValidateRule(JsRuleCreator.create(ResetPwdForm.class));
        model.addAttribute("resetPwdVo", ServiceSiteTool.userPlayerService().getResetPasswordInfo(resetPwdVo));
        return RESET_LOGIN_BY_HAND;
    }

    @RequestMapping("/autoResetPwd")
    @Audit(module = Module.PLAYER, moduleType = ModuleType.RESET_USER_PERMISSIONPWD, opType = OpType.UPDATE)
    public String autoResetPwd(ResetPwdVo resetPwdVo, Model model) {
        // 重置密码
        Map map = new HashMap();
        String newPwd = RandomStringTool.randomNumeric(6);
        if (resetPwdVo.getResetTypeLoginPwd().equals(resetPwdVo.getResetType())) {
            resetPwdVo.setPassword(newPwd);
            map = resetUserPwd(resetPwdVo);
            KickoutFilter.loginKickoutAll(resetPwdVo.getUserId(), OpMode.MANUAL, "站长中心重置玩家密码强制踢出");
        } else if (resetPwdVo.getResetTypePayPwd().equals(resetPwdVo.getResetType())) {
            resetPwdVo.setPermissionPwd(newPwd);
            Boolean isOk = ServiceSiteTool.userPlayerService().resetPassword(resetPwdVo);
            KickoutFilter.loginKickoutAll(resetPwdVo.getUserId(), OpMode.MANUAL, "站长中心重置玩家密码强制踢出");
            map.put("state", isOk);
        }
        sendNotice(resetPwdVo);
        map.put("newPwd", newPwd);
        model.addAttribute("newPwd", newPwd);
        model.addAttribute("player.resetPwd.resetPwdVo", resetPwdVo);
        addPlayerLog("player.resetPwd.autoResetPwd", resetPwdVo);
        return "player/player/resetpassword/SuccessPassword";
    }

    /**
     * 添加玩家修改日志
     */
    public void addPlayerLog(String description, ResetPwdVo resetPwdVo) {
        try {
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            VUserPlayerVo vUserPlayerVo = new VUserPlayerVo();
            vUserPlayerVo.getSearch().setId(resetPwdVo.getUserId());
            vUserPlayerVo = vUserPlayerVo = ServiceSiteTool.vUserPlayerService().get(vUserPlayerVo);
            addLog(description, vUserPlayerVo.getResult().getUsername());
        } catch (Exception ex) {

        }
    }

    /**
     * 发送邮件重置密码
     *
     * @param resetPwdVo
     * @return
     */
    @RequestMapping("/resetPwdByEmail")
    @ResponseBody
    @Audit(module = Module.PLAYER, moduleType = ModuleType.RESET_USER_PERMISSIONPWD, opType = OpType.UPDATE)
    public Map resetPwdByEmail(ResetPwdVo resetPwdVo) {
        NoticeVo notice = new NoticeVo();
        notice.setEventType(AutoNoticeEvent.RESET_LOGIN_PASSWORD_SUCCESS);
        notice.setActualReceivers(resetPwdVo.getMail());
        Map<NoticePublishMethod, Set<NoticeTmpl>> noticePublishMethodSetMap = ServiceTool.noticeService().fetchTmpls(notice);
        notice.setTmplMap(noticePublishMethodSetMap);
        notice._setDataSourceId(org.soul.commons.init.context.Const.BASE_DATASOURCE_ID);
        notice.addUserIds(resetPwdVo.getSysUser().getId());

        try {
            ServiceTool.noticeService().publish(notice);
        } catch (Exception ex) {
            LogFactory.getLog(this.getClass()).error(ex, "发布消息不成功");
        }
        KickoutFilter.loginKickoutAll(resetPwdVo.getUserId(), OpMode.MANUAL, "站长中心邮件重置玩家密码强制踢出");
        addPlayerLog("player.resetPwd.resetPwdByEmail", resetPwdVo);
        return MapTool.newHashMap(new Pair<Object, Object>("msg", "保存成功"), new Pair<Object, Object>("state", true));
    }

    @RequestMapping("/sendByEmail")
    @ResponseBody
    public Map sendByEmail(ResetPwdVo resetPwdVo) {
        Map map = new HashMap();
        try {
            Integer userId = resetPwdVo.getUserId();
            VUserPlayerVo userPlayerVo = new VUserPlayerVo();
            userPlayerVo.getSearch().setId(userId);
            userPlayerVo = ServiceSiteTool.vUserPlayerService().get(userPlayerVo);
            String mail = "";
            if (resetPwdVo.getInformType() != null) {
                if ("true".equals(resetPwdVo.getInformType())) {
                    mail = resetPwdVo.getMail();
                    if (StringTool.isBlank(mail)) {
                        if (userPlayerVo.getResult() == null || StringTool.isBlank(userPlayerVo.getResult().getMail())) {
                            map.put("state", false);
                            return map;
                        } else {
                            mail = userPlayerVo.getResult().getMail();
                        }
                    }
                } else {
                    //不用发邮件
                    return map;
                }

            } else {
                if (userPlayerVo.getResult() == null || StringTool.isBlank(userPlayerVo.getResult().getMail())) {
                    map.put("state", false);
                    return map;
                } else {
                    mail = userPlayerVo.getResult().getMail();
                }
            }
            sendMailNotice(resetPwdVo, userId, mail);
            map.put("state", true);
        } catch (Exception ex) {
            map.put("state", false);
        }


        return map;
    }

    private void sendMailNotice(ResetPwdVo resetPwdVo, Integer userId, String mail) {
        NoticeVo notice = new NoticeVo();
        notice.setPublishMethod(NoticePublishMethod.EMAIL);
        if (resetPwdVo.getResetType().equals(resetPwdVo.getResetTypePayPwd())) {
            notice.setEventType(AutoNoticeEvent.RESET_PERMISSION_PWD_SUCCESS);
        } else {
            notice.setEventType(AutoNoticeEvent.RESET_LOGIN_PASSWORD_SUCCESS);
        }

        notice.setActualReceivers(mail);

        Map<NoticePublishMethod, Set<NoticeTmpl>> noticePublishMethodSetMap = ServiceTool.noticeService().fetchTmpls(notice);
        notice.setTmplMap(noticePublishMethodSetMap);
        notice.addUserIds(userId);
        try {
            ServiceTool.noticeService().publish(notice);
        } catch (Exception ex) {
            LogFactory.getLog(this.getClass()).error(ex, "发布消息不成功");
        }
    }

    /**
     * 手动重置密码
     */
    @RequestMapping("/toResetPwdByHand")
    @ResponseBody

    public Map resetPwdByHand(ResetPwdVo resetPwdVo) {
        // 重置密码
        Map map = new HashMap();
        if (StringTool.isNotBlank(resetPwdVo.getPassword())) {
            map = resetUserPwd(resetPwdVo);
            KickoutFilter.loginKickoutAll(resetPwdVo.getUserId(), OpMode.MANUAL, "站长中心手动重置玩家密码强制踢出");
        } else if (StringTool.isNotBlank(resetPwdVo.getPermissionPwd())) {
            Boolean isOk = ServiceSiteTool.userPlayerService().resetPassword(resetPwdVo);
            KickoutFilter.loginKickoutAll(resetPwdVo.getUserId(), OpMode.MANUAL, "站长中心手动重置玩家密码强制踢出");
            map.put("state", isOk);
        } else {
            return sendByEmail(resetPwdVo);
        }
        sendNotice(resetPwdVo);
        return map;

    }

    /**
     * 重置密码
     *
     * @param resetPwdVo
     * @return
     */
    private Map resetUserPwd(ResetPwdVo resetPwdVo) {
        Map map = new HashMap();
        Boolean isOk = ServiceSiteTool.userPlayerService().resetPassword(resetPwdVo);
        map.put("state", isOk);
        if (StringTool.isBlank(resetPwdVo.getInformType())) {
            resetPwdVo.setInformType("false");
        } else {
            resetPwdVo.setInformType("true");
        }
        Map mailMap = sendByEmail(resetPwdVo);
        map.put("mailstate", mailMap.get("state"));
        return map;
    }

    /**
     * 修改密码后发送通知消息
     */
    private void sendNotice(ResetPwdVo resetPwdVo) {
        NoticeVo notice = new NoticeVo();
        if (resetPwdVo.getResetType().equals(resetPwdVo.getResetTypeLoginPwd())) {
            notice.setEventType(AutoNoticeEvent.RESET_LOGIN_PASSWORD_SUCCESS);
        } else {
            notice.setEventType(AutoNoticeEvent.RESET_PERMISSION_PWD_SUCCESS);
        }
        notice.setActualReceivers(resetPwdVo.getMail());

        notice.addParams(new Pair<String, String>("GameBox", Cache.getSiteI18n(SiteI18nEnum.SETTING_SITE_NAME).get(SessionManager.getLocale().toString()).getValue()));
        Map<NoticePublishMethod, Set<NoticeTmpl>> noticePublishMethodSetMap = ServiceTool.noticeService().fetchTmpls(notice);
        notice.setTmplMap(noticePublishMethodSetMap);
        notice._setDataSourceId(SessionManager.getSiteId());
        notice.addUserIds(resetPwdVo.getUserId());
        try {
            ServiceTool.noticeService().publish(notice);
        } catch (Exception ex) {
            LogFactory.getLog(this.getClass()).error(ex, "发布消息不成功");
        }
    }


    /**
     * 重置登录密码弹窗
     * by cogo
     *
     * @param model
     * @param resetSysUserPwdVo
     * @return
     */
    @RequestMapping("/goRestUserPwd")
    public String goRestUserPwd(Model model, ResetSysUserPwdVo resetSysUserPwdVo) {
        resetSysUserPwdVo = ServiceSiteTool.userAgentService().getResetSysUserPwdInfo(resetSysUserPwdVo);
        model.addAttribute("resetPwdVo", resetSysUserPwdVo);
        return RESET_PWD_POPUP;
    }

    /**
     * 手动重置登录密码弹窗
     * by cogo
     *
     * @param model
     * @param resetPwdVo
     * @return
     */
    @RequestMapping("/goRestUserPwdEdit")
    public String goRestUserPwdEdit(Model model, ResetSysUserPwdVo resetPwdVo) {
        Map<String, SysDict> mailMobilePhoneStatus = DictTool.get(DictEnum.PLAYER_MAIL_MOBILEPHONE_STATUS);
        resetPwdVo.setMailMobilePhoneStatus(mailMobilePhoneStatus);
        resetPwdVo.setValidateRule(JsRuleCreator.create(ResetSysUserPwdForm.class));
        resetPwdVo = ServiceSiteTool.userAgentService().getResetSysUserPwdInfo(resetPwdVo);
        model.addAttribute("resetPwdVo", resetPwdVo);
        return RESET_PWD_EDIT_POPUP;
    }


    @RequestMapping("/doRestUserPwd")
    @ResponseBody
    public Map doRestUserPwd(ResetSysUserPwdVo resetPwdVo) {
        sendNotice(resetPwdVo.getResetType(), resetPwdVo.getResult().getMail(), resetPwdVo.getResult().getId());
        KickoutFilter.loginKickoutAll(resetPwdVo.getResult().getId(), OpMode.MANUAL, "站长中心自动重置玩家密码强制踢出");
        return MapTool.newHashMap(new Pair<Object, Object>("msg", "保存成功"), new Pair<Object, Object>("state", true));
    }

    /**
     * 手动重置密码
     * by cogo
     */
    @RequestMapping("/doRestUserPwdByHand")
    @ResponseBody
    @Audit(module = Module.PLAYER, moduleType = ModuleType.RESET_USER_PERMISSIONPWD, opType = OpType.UPDATE)
    public Boolean doRestUserPwdByHand(ResetSysUserPwdVo resetPwdVo, String mail) {
        // 重置密码
        Boolean isOk = ServiceSiteTool.userAgentService().resetSysUserPwd(resetPwdVo);
        if (isOk) {
            // 发送消息
            if (StringTool.isNotBlank(mail)) {
                sendNotice(resetPwdVo.getResetType(), mail, resetPwdVo.getResult().getId());
            }
            if (resetPwdVo.isLogin()) {
                Integer userId = resetPwdVo.getUserId();
                if (userId == null) {
                    userId = resetPwdVo.getResult().getId();
                }
                KickoutFilter.loginKickoutAll(userId, OpMode.MANUAL, "站长中心手动重置玩家密码强制踢出");
            }
            addAgentLog("player.resetPwd.doRestUserPwdByHand", resetPwdVo);
        }
        return resetPwdVo.isSuccess();
    }

    /**
     * 代理添加修改日志
     */
    public void addAgentLog(String description, ResetSysUserPwdVo resetPwdVo) {
        try {
            SysUserVo sysUserVo = new SysUserVo();
            sysUserVo.getSearch().setId(resetPwdVo.getResult().getId());
            sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
            addLog(description, sysUserVo.getResult().getUsername());
        } catch (Exception ex) {

        }

    }

    /**
     * 添加修改日志
     */
    public static void addLog(String description, String name) {
        try {
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            LogVo logVo = new LogVo();
            BaseLog baseLog = logVo.addBussLog();
            baseLog.setDescription(description);
            baseLog.addParam(name);
            request.setAttribute(SysAuditLog.AUDIT_LOG, logVo);
        } catch (Exception ex) {

        }
    }


    /**
     * 重写发送通知
     * by cogo
     *
     * @param resetType
     * @param mail
     * @param userId
     */
    private void sendNotice(String resetType, String mail, Integer userId) {
        NoticeVo notice = new NoticeVo();
        if (ResetSysUserPwdVo.RESETTYPE_LOGINPWD.equals(resetType)) {
            notice.setEventType(AutoNoticeEvent.RESET_LOGIN_PASSWORD_SUCCESS);
        } else {
            notice.setEventType(AutoNoticeEvent.RESET_PERMISSION_PWD_SUCCESS);
        }
        notice.setActualReceivers(mail);
        Map<NoticePublishMethod, Set<NoticeTmpl>> noticePublishMethodSetMap = ServiceTool.noticeService().fetchTmpls(notice);
        notice.setTmplMap(noticePublishMethodSetMap);
        notice._setDataSourceId(SessionManager.getSiteId());
        notice.addUserIds(userId);
        notice.addParams(new Pair<String, String>("GameBox", Cache.getSiteI18n(SiteI18nEnum.SETTING_SITE_NAME).get(SessionManager.getLocale().toString()).getValue()));
        try {
            ServiceTool.noticeService().publish(notice);
        } catch (Exception ex) {
            LogFactory.getLog(this.getClass()).error(ex, "发布消息不成功");
        }
    }

}

