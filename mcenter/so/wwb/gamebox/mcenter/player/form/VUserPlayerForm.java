package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.support.AndOr;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;


/**
 * 表单验证对象
 * <p/>
 * Created by ke using soul-code-generator on 2015-6-30 10:24:49
 */
//region your codes 1
public class VUserPlayerForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String sysUser_realName;
    private String sysUser_sex;
    private String sysUser_country;
    private String sysUser_region;
    private String sysUser_city;
    private String sysUser_defaultLocale;

    private String sysUser_birthday;
    private String result_phoneCode;
    private String result_rankId;


    //联系方式验证
    private String $qq_contactValue;
    private String $msn_contactValue;
    private String $email_contactValue;
    private String $skype_contactValue;
    private String $phone_contactValue;
    private String $weixin_contactValue;

    private String sysUserProtection_question1;
    private String sysUserProtection_answer1;

    @Length(max = 20)
    @Depends(property = "$required", operator = Operator.IN, value = "sex")
    public String getSysUser_sex() {
        return sysUser_sex;
    }
    @Length(max = 20)
    @Depends(property = "$required", operator = Operator.IN, value = "country")
    public String getSysUser_country() {
        return sysUser_country;
    }
    @Length(max = 20)
    @Depends(property = {"$required","sysUser.country","sysUser.city"}, operator = {Operator.IN,Operator.IS_NOT_EMPTY,Operator.IS_NOT_EMPTY}, value = {"region","",""},andOr = AndOr.OR)
    public String getSysUser_region() {
        return sysUser_region;
    }
    @Length(max = 20)
    @Depends(property = {"$required","sysUser.country","sysUser.city"}, operator = {Operator.IN,Operator.IS_NOT_EMPTY,Operator.IS_NOT_EMPTY}, value = {"city","",""},andOr = AndOr.OR)
    public String getSysUser_city() {
        return sysUser_city;
    }
    @Length(max = 20)
    @Depends(property = "$required", operator = Operator.IN, value = "defaultLocale")
    public String getSysUser_defaultLocale() {
        return sysUser_defaultLocale;
    }
    @Length(max = 20)
    @Depends(property = "$required", operator = Operator.IN, value = "birthday")
    public String getSysUser_birthday() {
        return sysUser_birthday;
    }
    @Length(max = 20)
    @Depends(property = "$required", operator = Operator.IN, value = "110")
    public String getResult_phoneCode() {
        return result_phoneCode;
    }
    @NotBlank
    public String getResult_rankId() {
        return result_rankId;
    }

    @Length(max = 20)
    //@Depends(property = "$required", operator = Operator.IN, value = "realName")
    @Comment("真实姓名")
    public String getSysUser_realName() {
        return sysUser_realName;
    }

    /*联系方式 验证*/

    @Pattern(regexp = FormValidRegExps.QQ)
    //@Depends(property = "$required", operator = Operator.IN, value = "301")
    public String get$qq_contactValue() {
        return $qq_contactValue;
    }

    public void set$qq_contactValue(String $qq_contactValue) {
        this.$qq_contactValue = $qq_contactValue;
    }

    @Email
    //@Depends(property = "$required", operator = Operator.IN, value = "302")
    public String get$msn_contactValue() {
        return $msn_contactValue;
    }

    public void set$msn_contactValue(String $msn_contactValue) {
        this.$msn_contactValue = $msn_contactValue;
    }

    @Email
    //@Depends(property = "$required", operator = Operator.IN, value = "201")
    public String get$email_contactValue() {
        return $email_contactValue;
    }

    public void set$email_contactValue(String $email_contactValue) {
        this.$email_contactValue = $email_contactValue;
    }

    @Pattern(regexp = FormValidRegExps.SKYPE)
    //@Depends(property = "$required", operator = Operator.IN, value = "303")
    public String get$skype_contactValue() {
        return $skype_contactValue;
    }

    public void set$skype_contactValue(String $skype_contactValue) {
        this.$skype_contactValue = $skype_contactValue;
    }

    @Pattern(regexp = FormValidRegExps.NUMBER_PHONE,message = "player_auto.格式不正确")
    //@Depends(property = "$required", operator = Operator.IN, value = "110")
    public String get$phone_contactValue() {
        return $phone_contactValue;
    }

    @Length(min = 2,max = 20,message = "player_auto.微信号格式不对")
    //@Depends(property = "$required", operator = Operator.IN, value = "304")
    public String get$weixin_contactValue() {
        return $weixin_contactValue;
    }

    public void set$weixin_contactValue(String $weixin_contactValue) {
        this.$weixin_contactValue = $weixin_contactValue;
    }

    @Depends(property = {"sysUserProtection.question1"}, operator = {Operator.IS_NOT_EMPTY}, value = {""})
    @Length(min = 1,max = 30)
    public String getSysUserProtection_answer1() {
        return sysUserProtection_answer1;
    }

    public void setSysUserProtection_answer1(String sysUserProtection_answer1) {
        this.sysUserProtection_answer1 = sysUserProtection_answer1;
    }

    public String getSysUserProtection_question1() {
        return sysUserProtection_question1;
    }

    public void setSysUserProtection_question1(String sysUserProtection_question1) {
        this.sysUserProtection_question1 = sysUserProtection_question1;
    }
    //endregion your codes 2

}