package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.Email;
import org.soul.commons.validation.form.constraints.CellPhone;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;


/**
 * 站长子账号表表单验证对象
 *
 * @author cj
 * @time 2015-8-25 14:46:59
 */
//region your codes 1
@Comment("站长子账号表单验证")
public class MyAccountForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String sex;
    private String phone;
    private String email;
    private String skype_contactValue;
    private String msn_contactValue;
    private String qq_contactValue;

    @Comment("性别")
    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @CellPhone
    @Comment("手机号")
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Email
    @Comment("邮箱")
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    @Comment("skype")
    @Pattern(message = "common.myAccountForm.skype.correct", regexp = FormValidRegExps.SKYPE)
    public String getSkype_contactValue() {
        return skype_contactValue;
    }

    public void setSkype_contactValue(String skype_contactValue) {
        this.skype_contactValue = skype_contactValue;
    }

    @Comment("msn")
    @Email(message = "common.myAccountForm.msn.correct")
    public String getMsn_contactValue() {
        return msn_contactValue;
    }

    public void setMsn_contactValue(String msn_contactValue) {
        this.msn_contactValue = msn_contactValue;
    }

    @Comment("qq")
    @Pattern(message = "common.myAccountForm.qq.correct", regexp = FormValidRegExps.QQ)
    public String getQq_contactValue() {
        return qq_contactValue;
    }

    public void setQq_contactValue(String qq_contactValue) {
        this.qq_contactValue = qq_contactValue;
    }



    //endregion your codes 2

}