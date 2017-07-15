package so.wwb.gamebox.mcenter.setting.form;


import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;
import so.wwb.gamebox.mcenter.setting.controller.VNoticeEmailInterfaceController;

import javax.validation.constraints.Pattern;


/**
 * 邮件接口视图表单验证对象
 *
 * @author loong
 * @time 2015-8-26 15:07:58
 */
//region your codes 1
public class NoticeEmailInterfaceForm implements IForm {
//endregion your codes 1

    //region your codes 2
    /** 发送邮件服务器地址(SMTP) */
    private String serverAddress;
    /** 服务器端口 */
    private String serverPort;
    /** 邮件发送账号 */
    private String emailAccount;
    /** 账号密码 */
    private String accountPassword;
    /**
     * 原来的的账号
     */
    private String original;


    @NotBlank()
    @Length(min = 1,max = 100)
    public String getServerAddress() {
        return serverAddress;
    }

    @NotBlank()
    @Length(min = 1,max = 5)
    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE_INTEGER)
    public String getServerPort() {
        return serverPort;
    }

    @NotBlank()
    @Length(min = 1,max = 64)
    @Email
    @Remote(message = "setting.noticeEmail.emailAccount.exist",checkClass = VNoticeEmailInterfaceController.class,checkMethod = "checkEmailAccount",additionalProperties = {"emailAccount","original"})
    public String getEmailAccount() {
        return emailAccount;
    }

    @NotBlank()
    @Length(min = 1,max = 30)
    public String getAccountPassword() {
        return accountPassword;
    }
/*   @Length(min = 1,max = 64)
    public String getReplyEmailAccount() {
        return replyEmailAccount;
    }

    @Length(min = 1,max = 64)
    public String getTestEmailAccount() {
        return testEmailAccount;
    }*/



    public void setServerAddress(String serverAddress) {
        this.serverAddress = serverAddress;
    }

    public void setServerPort(String serverPort) {
        this.serverPort = serverPort;
    }

    public void setEmailAccount(String emailAccount) {
        this.emailAccount = emailAccount;
    }

    public void setAccountPassword(String accountPassword) {
        this.accountPassword = accountPassword;
    }

    public String getOriginal() {
        return original;
    }

    public void setOriginal(String original) {
        this.original = original;
    }
/*    public void setReplyEmailAccount(String replyEmailAccount) {
        this.replyEmailAccount = replyEmailAccount;
    }

    public void setTestEmailAccount(String testEmailAccount) {
        this.testEmailAccount = testEmailAccount;
    }*/
//endregion your codes 2

}