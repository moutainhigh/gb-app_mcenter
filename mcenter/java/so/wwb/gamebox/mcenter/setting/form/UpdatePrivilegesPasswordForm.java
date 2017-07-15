package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;
import so.wwb.gamebox.mcenter.setting.controller.MyAccountController;

import javax.validation.constraints.Pattern;

/**
 * Created by cj on 15-8-24.
 */
public class UpdatePrivilegesPasswordForm implements IForm {
    private String password;
    private String newPassword;
    private String newRePassword;

    @NotBlank
    @Remote(checkClass = MyAccountController.class, checkMethod = "checkPrivilegePassword", additionalProperties = {"password"}, message = "setting.myAccount.updatePassword.error")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @NotBlank
    @Pattern(message = "common.valid.securityPWDFormat",regexp = FormValidRegExps.SECURITY_PWD)
    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    @NotBlank
    @Compare(message = "playerResetPwd.pwdNeConfirmPwd", logic = CompareLogic.EQ, anotherProperty = "newPassword")
    public String getNewRePassword() {
        return newRePassword;
    }

    public void setNewRePassword(String newRePassword) {
        this.newRePassword = newRePassword;
    }
}
