package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.Length;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.AndOr;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.DecimalMax;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Digits;
import javax.validation.constraints.Pattern;
import java.math.BigDecimal;


/**
 * 代理子账号表单验证对象
 *
 * @author loong
 * @time 2015-9-6 9:48:09
 */
//region your codes 1
public class UserAgentForm implements IForm {
//endregion your codes 1


    /*新增，编辑 代理验证*/

    //联系方式验证
    private String $qq_contactValue;
    private String $email_contactValue;
    private String $phone_contactValue;
    private String $weixin_contactValue;

    /*sys_user */
    private String sysUser_defaultTimezone;
    private String sysUser_countryCity;
    private String sysUser_permissionPwd;
    private String sysUser_defaultLocale;
    private String sysUser_mainCurrency;
    /*private String sysUser_nickname;*/
    private String sysUser_sex;
    private String sysUser_birthday;
    /*主货币*/
    private String sysUser_defaultCurrency;
    private String userAgentRebate_rebateId;
    private String sysUserProtection_question1;
    private String sysUserProtection_answer1;
    private String $agentUserId;

    private String result_playerRankId;
    private String result_registCode;
    /*推广资源*/
    private String result_promotionResources;
    /*新增，编辑 代理验证 结束*/

    /*总代 验证*/
    /*,andOr = AndOr.OR*/
//    userAgentRakebacks[16].rakebackId
    /*方案*/
    private String $rebateIds;
    /*总代 验证结束*/

    /*共用验证*/
    private String sysUser_username;
    private String sysUser_password;
    private String $confirmPassword;
    private String sysUser_realName;
    /*共用验证结束*/

    /*占成验证*/
    private BigDecimal userAgentApis$$_ratio;
    private BigDecimal $batchSetInput;
    /*占成验证结束*/

    @Depends(property = "result.id", operator = Operator.IS_NULL,value ="password")
    @Compare(logic = CompareLogic.EQ, anotherProperty = "sysUser.password",message = "player.PWDNotMatch")
    public String get$confirmPassword() {
        return $confirmPassword;
    }

    public void set$confirmPassword(String $confirmPassword) {
        this.$confirmPassword = $confirmPassword;
    }

    @Depends(property = {"$editType","result.id"}, operator = {Operator.IN,Operator.IS_NULL},value ={"['agent','subAgent']","password"})
    public String getResult_registCode() {
        return result_registCode;
    }

    public void setResult_registCode(String result_registCode) {
        this.result_registCode = result_registCode;
    }

//    @NotBlank()
    @Depends(property = "result.id", operator = Operator.IS_NULL,value ="password")
    @Pattern(regexp = FormValidRegExps.ACCOUNT,message = "common.valid.usernameFormat")
    @Remote(message = "player.agent.edit.userNameExist",checkMethod = "checkAgentName",checkClass = so.wwb.gamebox.mcenter.player.controller.UserAgentController.class,additionalProperties = {"$editType"})
    public String getSysUser_username() {
        return sysUser_username;
    }

    public void setSysUser_username(String sysUser_username) {
        this.sysUser_username = sysUser_username;
    }

    @Depends(property = "result.id", operator = Operator.IS_NULL,value ="password")
    @Pattern(message = "common.valid.loginPWDFormat",regexp = FormValidRegExps.LOGIN_PWD)
    public String getSysUser_password() {
        return sysUser_password;
    }

    public void setSysUser_password(String sysUser_password) {
        this.sysUser_password = sysUser_password;
    }

    @Depends(property = "result.id", operator = Operator.IS_NULL,value ="")
    public String getSysUser_defaultTimezone() {
        return sysUser_defaultTimezone;
    }

    public void setSysUser_defaultTimezone(String sysUser_defaultTimezone) {
        this.sysUser_defaultTimezone = sysUser_defaultTimezone;
    }

    @Depends(property = "$required", operator = Operator.IN,value ="countryCity")
    public String getSysUser_countryCity() {
        return sysUser_countryCity;
    }

    public void setSysUser_countryCity(String sysUser_countryCity) {
        this.sysUser_countryCity = sysUser_countryCity;
    }

    @Depends(property = {"result.id","$editType","$required"}, operator = {Operator.IS_NULL,Operator.IN,Operator.IN},value ={"password","['agent','subAgent']","paymentPassword"})
    @Pattern(message = "common.valid.securityPWDFormat",regexp = FormValidRegExps.SECURITY_PWD)
    public String getSysUser_permissionPwd() {
        return sysUser_permissionPwd;
    }

    public void setSysUser_permissionPwd(String sysUser_permissionPwd) {
        this.sysUser_permissionPwd = sysUser_permissionPwd;
    }

    @Depends(property = {"$editType","$required"}, operator = {Operator.IN,Operator.IN},value ={"['agent','subAgent']","defaultLocale"})
    public String getSysUser_defaultLocale() {
        return sysUser_defaultLocale;
    }

    public void setSysUser_defaultLocale(String sysUser_defaultLocale) {
        this.sysUser_defaultLocale = sysUser_defaultLocale;
    }
    /*required qq,mainCurrency,msn,ww,*/
    @Depends(property = {"$editType","$required"}, operator = {Operator.IN,Operator.IN},value ={"['agent','subAgent']","mainCurrency"})
    public String getSysUser_mainCurrency() {
        return sysUser_mainCurrency;
    }

    public void setSysUser_mainCurrency(String sysUser_mainCurrency) {
        this.sysUser_mainCurrency = sysUser_mainCurrency;
    }


    /*@Depends(property = {"$editType","$required"}, operator = {Operator.EQ,Operator.IN},value ={"agent","nickName"})
    @Pattern(message = "common.valid.nickName",regexp = RegExpConstants.NICK_NAME)
    public String getSysUser_nickname() {
        return sysUser_nickname;
    }

    public void setSysUser_nickname(String sysUser_nickname) {
        this.sysUser_nickname = sysUser_nickname;
    }*/

    @Depends(property = {"$editType","$required"}, operator = {Operator.IN,Operator.IN},value ={"['agent','subAgent']","sex"})
    public String getSysUser_sex() {
        return sysUser_sex;
    }

    public void setSysUser_sex(String sysUser_sex) {
        this.sysUser_sex = sysUser_sex;
    }




    @Depends(property = {"$editType","$required"}, operator = {Operator.IN,Operator.IN},value ={"['agent','subAgent']","birthday"})
    public String getSysUser_birthday() {
        return sysUser_birthday;
    }

    public void setSysUser_birthday(String sysUser_birthday) {
        this.sysUser_birthday = sysUser_birthday;
    }


    @Depends(property = {"$editType","$required"}, operator = {Operator.EQ,Operator.IN},value ={"topAgent","realName"},andOr = AndOr.OR)
    @Length(max = 30,min = 0,message = "player.agent.edit.realName")
    public String getSysUser_realName() {
        return sysUser_realName;
    }

    public void setSysUser_realName(String sysUser_realName) {
        this.sysUser_realName = sysUser_realName;
    }


//    @Depends(property = "$required", operator = Operator.IN,value ="serviceTerms")
//    public String getSysUser_serviceTerms() {
//        return sysUser_serviceTerms;
//    }
//
//    public void setSysUser_serviceTerms(String sysUser_serviceTerms) {
//        this.sysUser_serviceTerms = sysUser_serviceTerms;
//    }

    @Depends(property = {"$editType"}, operator = {Operator.IN},value ={"['agent','subAgent']"})
    public String get$agentUserId() {
        return $agentUserId;
    }

    public void set$agentUserId(String $agentUserId) {
        this.$agentUserId = $agentUserId;
    }


    @Depends(property = "$editType", operator = Operator.IN,value = "['agent','subAgent']")
    public String getUserAgentRebate_rebateId() {
        return userAgentRebate_rebateId;
    }

    public void setUserAgentRebate_rebateId(String userAgentRebate_rebateId) {
        this.userAgentRebate_rebateId = userAgentRebate_rebateId;
    }


    @Depends(property = {"$editType","$required"}, operator = {Operator.IN,Operator.IN},value ={"['agent','subAgent']","securityIssues"})
    public String getSysUserProtection_question1() {
        return sysUserProtection_question1;
    }

    public void setSysUserProtection_question1(String sysUserProtection_question1) {
        this.sysUserProtection_question1 = sysUserProtection_question1;
    }

    @Depends(property = {"$required","sysUserProtection.question1"}, operator = {Operator.IN,Operator.IS_NOT_NULL},value ={"securityIssues",""})
    public String getSysUserProtection_answer1() {
        return sysUserProtection_answer1;
    }

    public void setSysUserProtection_answer1(String sysUserProtection_answer1) {
        this.sysUserProtection_answer1 = sysUserProtection_answer1;
    }

    @Depends(property = "$editType", operator = Operator.IN,value = "['agent','subAgent']")
    public String getResult_playerRankId() {
        return result_playerRankId;
    }

    public void setResult_playerRankId(String result_playerRankId) {
        this.result_playerRankId = result_playerRankId;
    }


    @Depends(property = "$editType", operator = Operator.EQ,value = "topAgent",message = "player.topAgent.edit.rebateNotblank")
    public String get$rebateIds() {
        return $rebateIds;
    }

    public void set$rebateIds(String $rebateIds) {
        this.$rebateIds = $rebateIds;
    }

    /*占成验证*/
    @Digits(integer = 100,fraction = 2,message = "player.topAgent.ratio.digits")
    @DecimalMax(value = "100",message = "player.topAgent.ratio.max")
    @DecimalMin(value = "0",message = "player.topAgent.ratio.min")
    @Depends(property = {"$editType","result.id","$validateRatio"}, operator = {Operator.EQ,Operator.IS_NULL,Operator.EQ},value ={"topAgent","countryCity","true"},message = "player.topAgent.ratio.ratioNotBlank")
    public BigDecimal getUserAgentApis$$_ratio() {
        return userAgentApis$$_ratio;
    }

    public void setUserAgentApis$$_ratio(BigDecimal userAgentApis$$_ratio) {
        this.userAgentApis$$_ratio = userAgentApis$$_ratio;
    }

    @Digits(integer = 100,fraction = 2,message = "player.topAgent.ratio.digits")
    @DecimalMax(value = "100",message = "player.topAgent.ratio.max")
    @DecimalMin(value = "0",message = "player.topAgent.ratio.min")
    public BigDecimal get$batchSetInput() {
        return $batchSetInput;
    }

    public void set$batchSetInput(BigDecimal $batchSetInput) {
        this.$batchSetInput = $batchSetInput;
    }
    /*占成验证结束*/

    /*联系方式 验证*/

    @Pattern(regexp = FormValidRegExps.QQ)
    @Depends(property = {"$editType","$required"}, operator = {Operator.IN,Operator.IN},value ={"['agent','subAgent']","301"})
    public String get$qq_contactValue() {
        return $qq_contactValue;
    }

    public void set$qq_contactValue(String $qq_contactValue) {
        this.$qq_contactValue = $qq_contactValue;
    }
    @Pattern(regexp = FormValidRegExps.EMAIL)
    @Depends(property = {"$editType","$required"}, operator = {Operator.IN,Operator.IN},value ={"['agent','subAgent']","201"})
    public String get$email_contactValue() {
        return $email_contactValue;
    }

    public void set$email_contactValue(String $email_contactValue) {
        this.$email_contactValue = $email_contactValue;
    }
    @Pattern(regexp = FormValidRegExps.NUMBER_PHONE,message = "格式错误，请输入纯数字")
    @Depends(property = {"$editType","$required"}, operator = {Operator.IN,Operator.IN},value ={"['agent','subAgent']","110"})
    public String get$phone_contactValue() {
        return $phone_contactValue;
    }

    public void set$phone_contactValue(String $phone_contactValue) {
        this.$phone_contactValue = $phone_contactValue;
    }

    /*联系方式 验证 结束*/
    @Length(min = 4,max = 100)
    public String getResult_promotionResources() {
        return result_promotionResources;
    }

    public void setResult_promotionResources(String result_promotionResources) {
        this.result_promotionResources = result_promotionResources;
    }


    @Depends(property = {"$editType","result.id"}, operator = {Operator.EQ,Operator.IS_NULL},value ={"topAgent",""})
    public String getSysUser_defaultCurrency() {
        return sysUser_defaultCurrency;
    }

    public void setSysUser_defaultCurrency(String sysUser_defaultCurrency) {
        this.sysUser_defaultCurrency = sysUser_defaultCurrency;
    }
    @Length(min = 2,max = 20,message = "微信号格式不对，2-20个字符，类型不限")
    @Depends(property = "$required", operator = Operator.IN, value = "304")
    public String get$weixin_contactValue() {
        return $weixin_contactValue;
    }

    public void set$weixin_contactValue(String $weixin_contactValue) {
        this.$weixin_contactValue = $weixin_contactValue;
    }
//endregion your codes 2

}
