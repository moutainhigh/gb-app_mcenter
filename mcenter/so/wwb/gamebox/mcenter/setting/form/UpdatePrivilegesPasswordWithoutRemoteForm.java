package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.model.common.RegExpConstants;

import javax.validation.constraints.Pattern;

/**
 * Created by cj on 15-8-24.
 */
public class UpdatePrivilegesPasswordWithoutRemoteForm implements IForm {
    private String newPassword;
    private String newRePassword;

    @NotBlank
    @Pattern(regexp = RegExpConstants.SECURITY_PWD,message = "common.valid.securityPWDFormat")
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
