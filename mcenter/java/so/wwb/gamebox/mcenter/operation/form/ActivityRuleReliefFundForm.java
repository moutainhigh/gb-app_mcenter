package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.constraints.Series;
import org.soul.commons.validation.form.support.Comment;
import org.soul.commons.validation.form.support.SeriesType;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.*;

/**
 * Created by eagle on 15-9-1.
 */
@Comment("活动规则救济金表单验证")
public class ActivityRuleReliefFundForm extends ActivityRuleForm {

    private Integer activityRule_placesNumber;
    private Boolean activityRule_isAudit;
    private String activityRule_claimPeriod;
    private Double[] effectiveTransactionGe$$_preferentialValue;
    private Double[] totalAssetsLe$$_preferentialValue;
    private Double[] regularHandsel$$_preferentialValue;
    private Double[] preferentialAudits$$_preferentialAudit;
    private Double[] lossAmount$$_preferentialValue;
    private String placesNumber;

//    private String activityRule_rank;


    @Depends(property = "placesNumber",operator = Operator.EQ,value = {"false"},jsValueExp ="$(\"[name=\'placesNumber\']\").val()=='true'",message = "common.不能为空")
    @Range(min = 1,max = 99999,message = "operation_auto.请输入1-99999")
    @Digits(integer = 5,fraction = 0)
//    @Pattern(message = "请输入1-99999的正整数数字",regexp = FormValidRegExps.DIGITS)
    @Comment("优惠名额数量")
    public Integer getActivityRule_placesNumber() {
        return activityRule_placesNumber;
    }

    public void setActivityRule_placesNumber(Integer activityRule_placesNumber) {
        this.activityRule_placesNumber = activityRule_placesNumber;
    }

    @NotNull(message = "operation_auto.请选择是否审核")
    @Comment("是否审核")
    public Boolean getActivityRule_isAudit() {
        return activityRule_isAudit;
    }

    public void setActivityRule_isAudit(Boolean activityRule_isAudit) {
        this.activityRule_isAudit = activityRule_isAudit;
    }

    @NotBlank(message = "operation_auto.请选择申领周期")
    @Comment("申领周期")
    public String getActivityRule_claimPeriod() {
        return activityRule_claimPeriod;
    }

    public void setActivityRule_claimPeriod(String activityRule_claimPeriod) {
        this.activityRule_claimPeriod = activityRule_claimPeriod;
    }

    @NotNull(message = "common.不能为空")
    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "operation_auto.请输入")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "99999999")
    @Digits(integer = 8,fraction = 2)
    @Series(message = "operation_auto.下一梯度要大于上一梯度",type = SeriesType.INC)
    @Comment("有效交易量")
    public Double[] getEffectiveTransactionGe$$_preferentialValue() {
        return effectiveTransactionGe$$_preferentialValue;
    }

    public void setEffectiveTransactionGe$$_preferentialValue(Double[] effectiveTransactionGe$$_preferentialValue) {
        this.effectiveTransactionGe$$_preferentialValue = effectiveTransactionGe$$_preferentialValue;
    }

    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "operation_auto.请输入0")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "100")
    @Digits(integer = 3,fraction = 2)
    @Comment("优惠稽核")
    public Double[] getPreferentialAudits$$_preferentialAudit() {
        return preferentialAudits$$_preferentialAudit;
    }

    public void setPreferentialAudits$$_preferentialAudit(Double[] preferentialAudits$$_preferentialAudit) {
        this.preferentialAudits$$_preferentialAudit = preferentialAudits$$_preferentialAudit;
    }

    @NotNull(message = "common.不能为空")
    @Pattern(regexp = FormValidRegExps.DECIMAL,message = "operation_auto.请输入0-99999999")
    @Min(value = 0)
    @DecimalMax(value = "99999999")
    @Digits(integer = 8,fraction = 2)
//    @Series(message = "下一梯度要大于上一梯度",type = SeriesType.INC)
    @Comment("赠送固定彩金")
    public Double[] getRegularHandsel$$_preferentialValue() {
        return regularHandsel$$_preferentialValue;
    }

    public void setRegularHandsel$$_preferentialValue(Double[] regularHandsel$$_preferentialValue) {
        this.regularHandsel$$_preferentialValue = regularHandsel$$_preferentialValue;
    }

    @NotNull(message = "common.不能为空")
    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "operation_auto.请输入")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "99999999")
    @Digits(integer = 8,fraction = 2)
    @Series(message = "operation_auto.下一梯度要大于上一梯度",type = SeriesType.INC)
    @Comment("总资产")
    public Double[] getTotalAssetsLe$$_preferentialValue() {
        return totalAssetsLe$$_preferentialValue;
    }

    public void setTotalAssetsLe$$_preferentialValue(Double[] totalAssetsLe$$_preferentialValue) {
        this.totalAssetsLe$$_preferentialValue = totalAssetsLe$$_preferentialValue;
    }

    @NotNull(message = "common.不能为空")
    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "operation_auto.请输入")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "99999999")
    @Digits(integer = 8,fraction = 2)
    @Series(message = "operation_auto.下一梯度要大于上一梯度",type = SeriesType.INC)
    @Comment("亏损额度")
    public Double[] getLossAmount$$_preferentialValue() {
        return lossAmount$$_preferentialValue;
    }

    public void setLossAmount$$_preferentialValue(Double[] lossAmount$$_preferentialValue) {
        this.lossAmount$$_preferentialValue = lossAmount$$_preferentialValue;
    }

    public String getPlacesNumber() {
        return placesNumber;
    }

    public void setPlacesNumber(String placesNumber) {
        this.placesNumber = placesNumber;
    }

    /*@NotBlank(message = "请选择参与层级")
    public String getActivityRule_rank() {
        return activityRule_rank;
    }

    public void setActivityRule_rank(String activityRule_rank) {
        this.activityRule_rank = activityRule_rank;
    }*/
}
