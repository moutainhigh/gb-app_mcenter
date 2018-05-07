package so.wwb.gamebox.mcenter.session;

import so.wwb.gamebox.mcenter.init.ConfigManager;
import so.wwb.gamebox.model.common.SessionKey;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.web.SessionManagerCommon;

/**
 * @author martin
 * @time 2018-4-10 20:28:52
 */
public class SessionManager extends SessionManagerCommon {

    private static String ssoMaster;

    /**
     * 人工存取token
     */
    private static final String SESSION_MANUAL_TOKEN = "SESSION_MANUAL_TOKEN";

    public static void setUserId(Integer userId) {
        setAttribute(SessionKey.S_USER_ID, userId);
    }

    /**
     * 站长中心子账号处理
     * @return
     */
    public static String getSubSysCode() {
        return ConfigManager.getConfigration().getSubsysCode();
    }

    /**
     * 存放站长用户在运营库里面的id
     * @param userId
     */
    public static void setMasterUserId(Integer userId) {
        setAttribute("masterUserId", userId);
    }

    public static Integer getMasterUserId() {
        return (Integer) getAttribute("masterUserId");
    }

    public void setSsoMaster(String sso) {
        ssoMaster = sso;
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

    public static String getLogoutUrl() {
        if (getUser() != null) {
            return "/passport/logout.html";
        } else {
            return "";
        }
    }
}
