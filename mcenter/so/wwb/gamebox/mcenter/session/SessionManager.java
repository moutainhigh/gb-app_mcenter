package so.wwb.gamebox.mcenter.session;

import org.springframework.stereotype.Component;
import so.wwb.gamebox.model.common.SessionKey;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.content.vo.CttDocumentI18nVo;
import so.wwb.gamebox.web.SessionManagerCommon;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * Created by tony on 15-4-29.
 */
@Component
public class SessionManager extends SessionManagerCommon {
    //刷新API余额的最新时间
    public static final String SESSION_REFRESH_API_BALANCE_TIME = "SESSION_REFRESH_API_BALANCE_TIME";
    //刷新API余额的时间间隔
    public static final String SESSION_REFRESH_API_BALANCE_TIME_INTERVAL = "SESSION_REFRESH_API_BALANCE_TIME_INTERVAL";
    //TODO：：默认刷新api余额的时间间隔为15s，可修改
    public static final int REFRESH_API_BALANCE_DEFAULT_TIME_INTERVAL = 15;

    public static final String CTT_DOCUMENT_MESSAGE = "cttDocumentMessage";

    public static final String SESSION_COMPANY_VOICE_NOTICE = "SESSION_COMPANY_VOICE_NOTICE";
    public static final String SESSION_ONLINE_VOICE_NOTICE = "SESSION_ONLINE_VOICE_NOTICE";
    public static final String SESSION_WITHDRAW_NOTICE = "SESSION_WITHDRAW_NOTICE";
    public static final String SESSION_AGENT_WITHDRAW_NOTICE = "SESSION_AGENT_WITHDRAW_NOTICE";


    /**
     * 人工存取token
     */
    private static final String SESSION_MANUAL_TOKEN = "SESSION_MANUAL_TOKEN";

    public static void setSiteSwitchId(String siteId) {
        setAttribute("siteId", siteId);
    }

    public static String getSiteSwitchId() {
        return (String) getAttribute("siteId");
    }

    /**
     * 获取运营商Logo
     *
     * @return
     */
    public static String getCompanyLogo(HttpServletRequest request) {
        return SessionManager.getSiteDomain(request).getLogoPath();
    }

    /**
     * 是否已登录
     * 任务提醒要用
     *
     * @param isFirst
     */
    public static void setFirstLogin(boolean isFirst) {
        setAttribute("isFirst", isFirst);
    }

    /**
     * 获取是否已登录
     *
     * @return
     */
    public static boolean getFirstLogin() {
        if (getAttribute("isFirst") == null) {
            return true;
        }
        return !(boolean) getAttribute("isFirst");
    }

    /**
     * 刷新api时间
     *
     * @param date
     */
    public static void setLastRefreshApiBalanceTime(Date date) {
        if (date == null) {
            date = new Date();
        }
        setAttribute(SESSION_REFRESH_API_BALANCE_TIME, date);
    }

    public static Date getLastRefreshApiBalanceTime() {
        Object obj = getAttribute(SESSION_REFRESH_API_BALANCE_TIME);
        if (obj != null) {
            return (Date) obj;
        }
        return null;
    }

    //将文案信息保存
    public static void setCttDocument(CttDocumentI18nVo objectVo) {
        setAttribute(CTT_DOCUMENT_MESSAGE, objectVo);
    }

    public static CttDocumentI18nVo getCttDocument() {
        Object obj = getAttribute(CTT_DOCUMENT_MESSAGE);
        if (obj != null) {
            return (CttDocumentI18nVo) obj;
        }
        return null;
    }

    public static void setUserId(Integer userId) {
        setAttribute(SessionKey.S_USER_ID, userId);
    }

    /**
     * 存放站长用户在运营库里面的id
     *
     * @param userId
     */
    public static void setMasterUserId(Integer userId) {
        setAttribute("masterUserId", userId);
    }

    public static Integer getMasterUserId() {
        return (Integer) getAttribute("masterUserId");
    }

    private static String ssoMaster;

    public void setSsoMaster(String sso) {
        ssoMaster = sso;
    }

    public static String getLogoutUrl() {
        if (getUser() != null) {
            return getUserType() == UserTypeEnum.MASTER ? ssoMaster : "/passport/logout.html";
        } else {
            return "";
        }
    }

    public static Boolean getCompanyVoiceNotice() {
        Object flag = getAttribute(SESSION_COMPANY_VOICE_NOTICE);
        if (flag != null) {
            return (Boolean) flag;
        }
        return null;
    }

    public static void setCompanyVoiceNotice(String status) {
        if ("0".equals(status)) {
            setAttribute(SESSION_COMPANY_VOICE_NOTICE, true);
        } else {
            setAttribute(SESSION_COMPANY_VOICE_NOTICE, false);
        }
    }

    public static Boolean getOnlineVoiceNotice() {
        Object flag = getAttribute(SESSION_ONLINE_VOICE_NOTICE);
        if (flag != null) {
            return (Boolean) flag;
        }
        return null;
    }

    public static void setOnlineVoiceNotice(String status) {
        if ("0".equals(status)) {
            setAttribute(SESSION_ONLINE_VOICE_NOTICE, true);
        } else {
            setAttribute(SESSION_ONLINE_VOICE_NOTICE, false);
        }
    }

    public static void setWithdrawNotice(String status) {
        if ("0".equals(status)) {
            setAttribute(SESSION_WITHDRAW_NOTICE, true);
        } else {
            setAttribute(SESSION_WITHDRAW_NOTICE, false);
        }
    }

    public static Boolean getWithdrawNotice() {
        Object status = getAttribute(SESSION_WITHDRAW_NOTICE);

        if (status != null) {
            return (Boolean) status;
        }

        return null;
    }

    public static void setAgentWithdrawNotice(String status) {
        if ("0".equals(status)) {
            setAttribute(SESSION_AGENT_WITHDRAW_NOTICE, true);
        } else {
            setAttribute(SESSION_AGENT_WITHDRAW_NOTICE, false);
        }
    }

    public static Boolean getAgentWithdrawNotice() {
        Object status = getAttribute(SESSION_AGENT_WITHDRAW_NOTICE);

        if (status != null) {
            return (Boolean) status;
        }

        return null;
    }

    public static void setManualToken(String manualToken) {
        setAttribute(SESSION_MANUAL_TOKEN, manualToken);
    }

    public static String getManualToken() {
        return (String) getAttribute(SESSION_MANUAL_TOKEN);
    }

    public static void removeManualToken() {
        removeAttribute(SESSION_MANUAL_TOKEN);
    }

    /**
     * 统一获取审批用户帐号的方法，主要是处理站长虚拟账号的情况
     *
     * @return
     */
    public static String getAuditUserName() {
        if (getUser().getUserType().equals(UserTypeEnum.MASTER.getCode())) {
            return "—admin—";
        } else {
            return getUserName();
        }
    }
}
