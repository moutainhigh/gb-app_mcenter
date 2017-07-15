package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Series;
import org.soul.commons.validation.form.support.Comment;
import org.soul.commons.validation.form.support.SeriesType;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.*;

/**
 * Created by eagle on 15-9-1.
 */
@Comment("活动规则盈亏返利表单验证")
public class ActivityRuleProfitLossForm extends ActivityRuleForm {

    private Boolean activityRule_isAudit;
    private String activityRule_effectiveTime;
    private String activityRule_claimPeriod;

    private Double[] profit$$_preferentialValue;
    private Double[] regularHandsel$$_preferentialValue;
    private Double[] preferentialAudits$$_preferentialAudit;
    private Double[] loss$$_preferentialValue;
    private Double[] regularHandsel2$$_preferentialValue;
    private Double[] preferentialAudits2$$_preferentialAudit;

//    private String activityRule_rank;

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

    @NotBlank(message = "operation_auto.请选择有效时间")
    @Comment("有效时间")
    public String getActivityRule_effectiveTime() {
        return activityRule_effectiveTime;
    }

    public void setActivityRule_effectiveTime(String activityRule_effectiveTime) {
        this.activityRule_effectiveTime = activityRule_effectiveTime;
    }

    @NotNull(message = "common.不能为空")
    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "operation_auto.请输入")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "99999999")
    @Digits(integer = 8,fraction = 2)
    @Series(message = "operation_auto.下一梯度要大于上一梯度",type = SeriesType.INC)
    @Comment("亏损")
    public Double[] getLoss$$_preferentialValue() {
        return loss$$_preferentialValue;
    }

    public void setLoss$$_preferentialValue(Double[] loss$$_preferentialValue) {
        this.loss$$_preferentialValue = loss$$_preferentialValue;
    }

    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "operation_auto.请输入0")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "100")
    @Digits(integer = 3,fraction = 2)
    @Comment("盈利优惠稽核")
    public Double[] getPreferentialAudits$$_preferentialAudit() {
        return preferentialAudits$$_preferentialAudit;
    }

    public void setPreferentialAudits$$_preferentialAudit(Double[] preferentialAudits$$_preferentialAudit) {
        this.preferentialAudits$$_preferentialAudit = preferentialAudits$$_preferentialAudit;
    }

    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "operation_auto.请输入0")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "100")
    @Digits(integer = 3,fraction = 2)
    @Comment("亏损优惠稽核")
    public Double[] getPreferentialAudits2$$_preferentialAudit() {
        return preferentialAudits2$$_preferentialAudit;
    }

    public void setPreferentialAudits2$$_preferentialAudit(Double[] preferentialAudits2$$_preferentialAudit) {
        this.preferentialAudits2$$_preferentialAudit = preferentialAudits2$$_preferentialAudit;
    }

    @NotNull(message = "common.不能为空")
    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "operation_auto.请输入")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "99999999")
    @Digits(integer = 8,fraction = 2)
    @Series(message = "operation_auto.下一梯度要大于上一梯度",type = SeriesType.INC)
    @Comment("盈利")
    public Double[] getProfit$$_preferentialValue() {
        return profit$$_preferentialValue;
    }

    public void setProfit$$_preferentialValue(Double[] profit$$_preferentialValue) {
        this.profit$$_preferentialValue = profit$$_preferentialValue;
    }

    @NotNull(message = "common.不能为空")
    @Pattern(regexp = FormValidRegExps.DECIMAL,message = "operation_auto.请输入0-99999999")
    @Min(value = 0)
    @DecimalMax(value = "99999999")
    @Digits(integer = 8,fraction = 2)
//    @Series(message = "下一梯度要大于上一梯度",type = SeriesType.INC)
    @Comment("盈利固定彩金")
    public Double[] getRegularHandsel$$_preferentialValue() {
        return regularHandsel$$_preferentialValue;
    }

    public void setRegularHandsel$$_preferentialValue(Double[] regularHandsel$$_preferentialValue) {
        this.regularHandsel$$_preferentialValue = regularHandsel$$_preferentialValue;
    }

    @NotNull(message = "common.不能为空")
    @Pattern(regexp = FormValidRegExps.DECIMAL,message = "operation_auto.请输入0-99999999")
    @Min(value = 0)
    @DecimalMax(value = "99999999")
    @Digits(integer = 8,fraction = 2)
//    @Series(message = "下一梯度要大于上一梯度",type = SeriesType.INC)
    @Comment("亏损固定彩金")
    public Double[] getRegularHandsel2$$_preferentialValue() {
        return regularHandsel2$$_preferentialValue;
    }

    public void setRegularHandsel2$$_preferentialValue(Double[] regularHandsel2$$_preferentialValue) {
        this.regularHandsel2$$_preferentialValue = regularHandsel2$$_preferentialValue;
    }

    /*@NotBlank(message = "请选择参与层级")
    public String getActivityRule_rank() {
        return activityRule_rank;
    }

    public void setActivityRule_rank(String activityRule_rank) {
        this.activityRule_rank = activityRule_rank;
    }*/
}
