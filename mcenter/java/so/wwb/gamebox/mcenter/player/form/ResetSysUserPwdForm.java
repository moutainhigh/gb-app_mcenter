package so.wwb.gamebox.mcenter.player.form;

import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;
import so.wwb.gamebox.model.master.agent.vo.ResetSysUserPwdVo;

import javax.validation.constraints.Pattern;


/**
 * 玩家交易表表单验证对象
 *
 * Created by cheery using soul-code-generator on 2015-6-23 11:41:43
 */
public class ResetSysUserPwdForm implements IForm {

    //region your codes
    /*登录密码*/
    private String newPwd;
    /*确认登录密码*/
    private String confirmNewPwd;
    /*安全密码*/
    private String newpermissionPwd;
    /*确认安全密码*/
    private String confirmNewPermissionPwd;
    private String mail;
    private String mobilePhone;

    @Pattern(message = "common.valid.loginPWDFormat",regexp = FormValidRegExps.LOGIN_PWD)
    @Depends(property = "$resetType", operator = Operator.EQ,value = ResetSysUserPwdVo.RESETTYPE_LOGINPWD)
    public String getNewPwd() {
        return newPwd;
    }

    public void setNewPwd(String newPwd) {
        this.newPwd = newPwd;
    }

    @Compare(logic = CompareLogic.EQ, anotherProperty = "newPwd",message = "playerResetPwd.pwdNeConfirmPwd")
    @Depends(property = "$resetType", operator = Operator.EQ,value =ResetSysUserPwdVo.RESETTYPE_LOGINPWD)
    public String getConfirmNewPwd() {
        return confirmNewPwd;
    }

    public void setConfirmNewPwd(String confirmNewPwd) {
        this.confirmNewPwd = confirmNewPwd;
    }


    @Pattern(message = "common.valid.securityPWDFormat",regexp = FormValidRegExps.SECURITY_PWD)
    @Depends(property = "$resetType", operator = Operator.EQ,value =ResetSysUserPwdVo.RESETTYPE_PERMISSIONPWD)
    public String getNewpermissionPwd() {
        return newpermissionPwd;
    }

    public void setNewpermissionPwd(String newpermissionPwd) {
        this.newpermissionPwd = newpermissionPwd;
    }

    @Compare(logic = CompareLogic.EQ, anotherProperty = "newpermissionPwd",message = "playerResetPwd.pwdNeConfirmPwd")
    @Depends(property = "$resetType", operator = Operator.EQ,value =ResetSysUserPwdVo.RESETTYPE_PERMISSIONPWD)
    public String getConfirmNewPermissionPwd() {
        return confirmNewPermissionPwd;
    }

    public void setConfirmNewPermissionPwd(String confirmNewPermissionPwd) {
        this.confirmNewPermissionPwd = confirmNewPermissionPwd;
    }

    @Pattern(message = "playerResetPwd.emailCorrectFormat",regexp = FormValidRegExps.EMAIL)
    //@NotBlank(message = "playerResetPwd.emailNotBlank")
    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

//    二期
//    @CellPhone(message = "playe
// rResetPwd.phoneCorrectFormat")
//    @NotBlank(message = "playerResetPwd.phoneNotBlank")
//    public String getMobilePhone() {
//        return mobilePhone;
//    }
//    public void setMobilePhone(String mobilePhone) {
//        this.mobilePhone = mobilePhone;
//    }
    //endregion your codes

}