package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Digits;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;


/**
 * 优惠时间段表单验证对象
 *
 * @author Administrator
 * @time 2017-3-24 14:12:43
 */
//region your codes 1
public class ActivityMoneyConditionForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String[] moneyOpenPeriods$$_startTimeHour;
    private String[] moneyOpenPeriods$$_startTimeMinute;
    private String[] moneyOpenPeriods$$_endTimeHour;
    private String[] moneyOpenPeriods$$_endTimeMinute;

    private String[] moneyConditions$$_singleDepositAmount;
    private String[] moneyConditions$$_effectiveAmount;
    private String[] moneyConditions$$_betCount;

    private String[] moneyAwardsRules$$_amount;
    private String[] moneyAwardsRules$$_audit;
    private String[] moneyAwardsRules$$_quantity;
    private String[] moneyAwardsRules$$_probability;
    private String[] moneyAwardsRules$$_remainCount;

    private String activityRule_betCountMaxLimit;

    private Boolean activityRule_isAudit;

    private String rank;

    @NotBlank(message = "operation_auto.请选择参与层级")
    public String getRank() {
        return rank;
    }

    public void setRank(String rank) {
        this.rank = rank;
    }

    @Pattern(regexp = FormValidRegExps.DIGITS)
    @Max(value = 23)
    @Min(value = 0)
    public String[] getMoneyOpenPeriods$$_startTimeHour() {
        return moneyOpenPeriods$$_startTimeHour;
    }

    public void setMoneyOpenPeriods$$_startTimeHour(String[] moneyOpenPeriods$$_startTimeHour) {
        this.moneyOpenPeriods$$_startTimeHour = moneyOpenPeriods$$_startTimeHour;
    }
    @Pattern(regexp = FormValidRegExps.DIGITS)
    @Max(value = 59)
    @Min(value = 0)
    public String[] getMoneyOpenPeriods$$_startTimeMinute() {
        return moneyOpenPeriods$$_startTimeMinute;
    }

    public void setMoneyOpenPeriods$$_startTimeMinute(String[] moneyOpenPeriods$$_startTimeMinute) {
        this.moneyOpenPeriods$$_startTimeMinute = moneyOpenPeriods$$_startTimeMinute;
    }
    @Pattern(regexp = FormValidRegExps.DIGITS)
    @Max(value = 23)
    @Min(value = 0)
    public String[] getMoneyOpenPeriods$$_endTimeHour() {
        return moneyOpenPeriods$$_endTimeHour;
    }

    public void setMoneyOpenPeriods$$_endTimeHour(String[] moneyOpenPeriods$$_endTimeHour) {
        this.moneyOpenPeriods$$_endTimeHour = moneyOpenPeriods$$_endTimeHour;
    }
    @Pattern(regexp = FormValidRegExps.DIGITS)
    @Max(value = 59)
    @Min(value = 0)
    public String[] getMoneyOpenPeriods$$_endTimeMinute() {
        return moneyOpenPeriods$$_endTimeMinute;
    }

    public void setMoneyOpenPeriods$$_endTimeMinute(String[] moneyOpenPeriods$$_endTimeMinute) {
        this.moneyOpenPeriods$$_endTimeMinute = moneyOpenPeriods$$_endTimeMinute;
    }




    @Depends(property = "activityRule.conditionType",operator = Operator.EQ,value = {"true"},jsValueExp ="$(\"[name=\\'activityRule.conditionType\\']:checked\").val()!='3'")
    @Pattern(regexp = FormValidRegExps.DECIMAL,message = "operation_auto.请输入正数")
    @Digits(integer = 13,fraction = 2)
    @Max(value = 9999999999999L)
    public String[] getMoneyConditions$$_singleDepositAmount() {
        return moneyConditions$$_singleDepositAmount;
    }

    public void setMoneyConditions$$_singleDepositAmount(String[] moneyConditions$$_singleDepositAmount) {
        this.moneyConditions$$_singleDepositAmount = moneyConditions$$_singleDepositAmount;
    }
    @Depends(property = "activityRule.conditionType",operator = Operator.EQ,value = {"true"},jsValueExp ="$(\"[name=\\'activityRule.conditionType\\']:checked\").val()!='3'")
    @Pattern(regexp = FormValidRegExps.DECIMAL,message = "operation_auto.请输入正数")
    @Digits(integer = 13,fraction = 2)
    @Max(value = 9999999999999L)
    public String[] getMoneyConditions$$_effectiveAmount() {
        return moneyConditions$$_effectiveAmount;
    }

    public void setMoneyConditions$$_effectiveAmount(String[] moneyConditions$$_effectiveAmount) {
        this.moneyConditions$$_effectiveAmount = moneyConditions$$_effectiveAmount;
    }
    @Depends(property = "activityRule.conditionType",operator = Operator.EQ,value = {"true"},jsValueExp ="$(\"[name=\\'activityRule.conditionType\\']:checked\").val()!='3'")
    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE_INTEGER,message = "operation_auto.请输入正整数")
    @Max(value = 99999999)
    public String[] getMoneyConditions$$_betCount() {
        return moneyConditions$$_betCount;
    }

    public void setMoneyConditions$$_betCount(String[] moneyConditions$$_betCount) {
        this.moneyConditions$$_betCount = moneyConditions$$_betCount;
    }

    @NotBlank
    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "operation_auto.请输入正数")
    @Digits(integer = 13,fraction = 2)
    @Max(value = 9999999999999L)
    public String[] getMoneyAwardsRules$$_amount() {
        return moneyAwardsRules$$_amount;
    }

    public void setMoneyAwardsRules$$_amount(String[] moneyAwardsRules$$_amount) {
        this.moneyAwardsRules$$_amount = moneyAwardsRules$$_amount;
    }
    @NotBlank
    @Pattern(regexp = FormValidRegExps.DECIMAL,message = "operation_auto.请输入正数")
    @Digits(integer = 8,fraction = 2)
    @Max(value = 99999999)
    public String[] getMoneyAwardsRules$$_audit() {
        return moneyAwardsRules$$_audit;
    }

    public void setMoneyAwardsRules$$_audit(String[] moneyAwardsRules$$_audit) {
        this.moneyAwardsRules$$_audit = moneyAwardsRules$$_audit;
    }
    @NotBlank
    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE_INTEGER,message = "operation_auto.请输入正整数")
    @Max(value = 99999999)
    public String[] getMoneyAwardsRules$$_quantity() {
        return moneyAwardsRules$$_quantity;
    }

    public void setMoneyAwardsRules$$_quantity(String[] moneyAwardsRules$$_quantity) {
        this.moneyAwardsRules$$_quantity = moneyAwardsRules$$_quantity;
    }
    @NotBlank
    @Pattern(regexp = FormValidRegExps.DECIMAL,message = "operation_auto.请输入正数")
    @Digits(integer = 8,fraction = 2)
    @Max(value = 100)
    public String[] getMoneyAwardsRules$$_probability() {
        return moneyAwardsRules$$_probability;
    }

    public void setMoneyAwardsRules$$_probability(String[] moneyAwardsRules$$_probability) {
        this.moneyAwardsRules$$_probability = moneyAwardsRules$$_probability;
    }
    @NotBlank
    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE_INTEGER,message = "operation_auto.请输入正整数")
    @Max(value = 99999999)
    public String[] getMoneyAwardsRules$$_remainCount() {
        return moneyAwardsRules$$_remainCount;
    }

    public void setMoneyAwardsRules$$_remainCount(String[] moneyAwardsRules$$_remainCount) {
        this.moneyAwardsRules$$_remainCount = moneyAwardsRules$$_remainCount;
    }

    @Depends(property = "activityRule.conditionType",operator = Operator.EQ,value = {"true"},jsValueExp ="$(\"[name=\\'activityRule.conditionType\\']:checked\").val()=='3'")
    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE_INTEGER,message = "operation_auto.请输入正整数")
    @Min(value = 1)
    @Max(value = 99)
    public String getActivityRule_betCountMaxLimit() {
        return activityRule_betCountMaxLimit;
    }

    public void setActivityRule_betCountMaxLimit(String activityRule_betCountMaxLimit) {
        this.activityRule_betCountMaxLimit = activityRule_betCountMaxLimit;
    }
    @NotBlank
    public Boolean getActivityRule_isAudit() {
        return activityRule_isAudit;
    }

    public void setActivityRule_isAudit(Boolean activityRule_isAudit) {
        this.activityRule_isAudit = activityRule_isAudit;
    }

    //endregion your codes 2

}