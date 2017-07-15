package so.wwb.gamebox.mcenter.content.form;


import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.Comment;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;
import so.wwb.gamebox.mcenter.content.controller.PayAccountController;

import javax.validation.constraints.Digits;
import javax.validation.constraints.Max;
import javax.validation.constraints.Pattern;


/**
 * 收款账户表表单验证对象
 * <p/>
 * Created by loong using soul-code-generator on 2015-7-27 15:22:07
 */
//region your codes 1
public class PayAccountCompanyEditForm implements IForm {
//endregion your codes 1

    //region your codes 2
    /** 账户名称 */
    private String result_payName;
    /** 停用金额 */
    private String result_disableAmount;

    /** 累计入款次数 */
    private String result_depositDefaultCount;
    /** 累计入款金额 */
    private String result_depositDefaultTotal;
    /** 单笔存款最小值 */
    private Integer result_singleDepositMin;
    /** 单笔存款最大值 */
    private Integer result_singleDepositMax;
    /** 有效分钟数 */
    private String effectiveMinutes;
    /** 开户行 */
    private String result_openAcountName;

    @Length(min = 2 ,max = 30)
    @Pattern(regexp = FormValidRegExps.CNANDEN ,message = "common.ACCOUNT_NAME_CHECk")
    public String getResult_openAcountName() {
        return result_openAcountName;
    }

    public void setResult_openAcountName(String result_openAcountName) {
        this.result_openAcountName = result_openAcountName;
    }

    @NotBlank
    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER,message = "common.POSITIVE_INTEGER")
    @Max(99999999)
    public String getResult_disableAmount() {
        return result_disableAmount;
    }
    /** 货币字符串**/
    private String $currencyStr;
    /** 层级字符串**/
    private String $rankStr;

    private String result_fullRank;

    @NotBlank
    @Length(min = 1,max = 20)
    @Remote(message = "content.payaccount.name.exist",checkClass = PayAccountController.class,checkMethod = "checkPayName",additionalProperties ={"result.id","result.accountType","result.bankCode"} )
    public String getResult_payName() {
        return result_payName;
    }

    @NotBlank(message = "content.payAccount.selectOne")
    public String get$currencyStr() {
        return $currencyStr;
    }


    @Depends(property ={"result_fullRank"}, message = "content.payAccount.selectOne", operator = {Operator.NE}, value = {"true"}, jsValueExp ={"$(\"[name=\\'result.fullRank\\']\").val()=='true'"})
    public String get$rankStr() {
        return $rankStr;
    }


    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE,message = "common.ZERO_POSITIVE")
    @Max(99999999)
    public String getResult_depositDefaultTotal() {
        return result_depositDefaultTotal;
    }


    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE_INTEGER,message = "common.ZERO_POSITIVE_INTEGER")
    @Max(99999999)
    public String getResult_depositDefaultCount() {
        return result_depositDefaultCount;
    }

    @Comment("单笔存款最小值")
    @Range(min = 0 ,max = 99999999)
    @Digits( integer = 8,fraction = 0)
    public Integer getResult_singleDepositMin() {
        return result_singleDepositMin;
    }



    @Comment("单笔存款最大值")
    @Range(min = 0 ,max = 99999999)
    @Digits( integer = 8,fraction = 0)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin",logic = CompareLogic.GT,anotherProperty = "result_singleDepositMin")
    public Integer getResult_singleDepositMax() {
        return result_singleDepositMax;
    }


    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER,message = "common.POSITIVE_INTEGER")
    @Max(99999999)
    @Comment("有效分钟数")
    public String getEffectiveMinutes() {
        return effectiveMinutes;
    }


    @Comment("全部层级")
    public String getResult_fullRank() {
        return result_fullRank;
    }

    public void setResult_fullRank(String result_fullRank) {
        this.result_fullRank = result_fullRank;
    }

    public void set$rankStr(String $rankStr) {
        this.$rankStr = $rankStr;
    }

    public void setResult_payName(String result_payName) {
        this.result_payName = result_payName;
    }

    public void set$currencyStr(String $currencyStr) {
        this.$currencyStr = $currencyStr;
    }

    public void setResult_disableAmount(String result_disableAmount) {
        this.result_disableAmount = result_disableAmount;
    }

    public void setResult_depositDefaultTotal(String result_depositDefaultTotal) {
        this.result_depositDefaultTotal = result_depositDefaultTotal;
    }

    public void setResult_depositDefaultCount(String result_depositDefaultCount) {
        this.result_depositDefaultCount = result_depositDefaultCount;
    }

    public void setResult_singleDepositMin(Integer result_singleDepositMin) {
        this.result_singleDepositMin = result_singleDepositMin;
    }

    public void setResult_singleDepositMax(Integer result_singleDepositMax) {
        this.result_singleDepositMax = result_singleDepositMax;
    }

    public void setEffectiveMinutes(String effectiveMinutes) {
        this.effectiveMinutes = effectiveMinutes;
    }

//endregion your codes 2

}