package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.AtLeast;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.Comment;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;


/**
 * 表单验证对象
 * <p/>
 * Created by snekey using soul-code-generator on 2015-6-19 13:51:46
 */
@Comment("新增玩家")
public class UserPlayerForm implements IForm {

    //region your codes
    private String sysUser_password;
    private String $confirmpwd;
    private String $mail;
    private String mobilePhone;
    private String sysUser_username;
    private String $tel;
    private String realName;
    private String result_rankId;
    private String result_mail;
    //private String result_nickName;
    private String[] noticeContactWays$$_contactValue;

    /*@Length(message = "player.badFormat",min=3,max = 15)
    public String getResult_nickName() {
        return result_nickName;
    }

    public void setResult_nickName(String result_nickName) {
        this.result_nickName = result_nickName;
    }*/

    @AtLeast(groups = One.class, message = "player_auto.电话和邮箱至少填一个")
    @Email
    public String getResult_mail() {
        return result_mail;
    }

    public void setResult_mail(String result_mail) {
        this.result_mail = result_mail;
    }

    @NotBlank(message = "1111")
    public String getResult_rankId() {
        return result_rankId;
    }

    public void setResult_rankId(String result_rankId) {
        this.result_rankId = result_rankId;
    }

    @Compare(message = "player_auto.两次输入的密码不一致",logic = CompareLogic.EQ,anotherProperty = "sysUser_password")
    public String get$confirmpwd() {
        return $confirmpwd;
    }

    public void set$confirmpwd(String $confirmpwd) {
        this.$confirmpwd = $confirmpwd;
    }

    @AtLeast(groups = One.class, message = "player_auto.电话和邮箱至少填一个")
    @Pattern(message = "player.badFormat",regexp = FormValidRegExps.MOBILE)
    public String get$tel() {
        return $tel;
    }

    public void set$tel(String $tel) {
        this.$tel = $tel;
    }

    @Pattern(message = "common.valid.loginPWDFormat",regexp = FormValidRegExps.LOGIN_PWD)
    @NotBlank(message = "player.enterPWD")
    public String getSysUser_password() {
        return sysUser_password;
    }

    public void setSysUser_password(String sysUser_password) {
        this.sysUser_password = sysUser_password;
    }

    @NotBlank(message = "player.userNameEmpty")
    @Pattern(regexp = FormValidRegExps.ACCOUNT,message = "common.valid.usernameFormat")
    @Remote(message = "player_auto.用户名已存在",checkMethod = "checkUserName",checkClass = so.wwb.gamebox.mcenter.player.controller.UserPlayerController.class)
    public String getSysUser_username() {
        return sysUser_username;
    }

    public void setSysUser_username(String sysUser_username) {
        this.sysUser_username = sysUser_username;
    }

    @Length(message = "msg", max = 10)
    @Email
    public String get$mail() {
        return $mail;
    }

    public void set$mail(String $mail) {
        this.$mail = $mail;
    }

    @Pattern(regexp = "^\\+?[1-9][0-9]*$", message = "player.edit.form.mobilePhone")
    @Length(message = "player.edit.form.mobilePhoneMax", max = 20)
    public String getMobilePhone() {
        return mobilePhone;
    }

    @Length(message = "player.edit.form.maxChar", max = 10)
    public String getRealName() {
        return realName;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }
    @NotBlank
    public String[] getNoticeContactWays$$_contactValue() {
        return noticeContactWays$$_contactValue;
    }

    public void setNoticeContactWays$$_contactValue(String[] noticeContactWays$$_contactValue) {
        this.noticeContactWays$$_contactValue = noticeContactWays$$_contactValue;
    }
    //endregion your codes

    interface One{}

}