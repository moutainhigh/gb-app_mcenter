package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.NotBlank;
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
@Comment("活动规则首存送表单验证")
public class ActivityRuleFirstDepositForm extends ActivityRuleForm {

    private Double activityRule_preferentialAmountLimit;
    private Boolean activityRule_isAudit;
    private Double[] depositAmountGe$$_preferentialValue;
    private Double[] percentageHandsel$$_preferentialValue;
    private Double[] regularHandsel$$_preferentialValue;
    private Double[] preferentialAudits$$_preferentialAudit;
    private Boolean $ｍosaicGold;
//    private String activityRule_rank;
    private String activityRule_depositWay;

    @NotNull(message = "operation_auto.赠送彩金上限不能为空")
    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "operation_auto.请输入")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "99999999")
    @Digits(integer = 8,fraction = 2)
    @Depends(property = "$ｍosaicGold",operator = Operator.EQ,value = {"true"},jsValueExp ="$(\"[name=\\'ｍosaicGold\\']:checked\").val()=='true'")
    @Comment("赠送彩金上限")
    public Double getActivityRule_preferentialAmountLimit() {
        return activityRule_preferentialAmountLimit;
    }

    public void setActivityRule_preferentialAmountLimit(Double activityRule_preferentialAmountLimit) {
        this.activityRule_preferentialAmountLimit = activityRule_preferentialAmountLimit;
    }

    @NotNull(message = "operation_auto.请选择是否审核")
    @Comment("是否审核")
    public Boolean getActivityRule_isAudit() {
        return activityRule_isAudit;
    }

    public void setActivityRule_isAudit(Boolean activityRule_isAudit) {
        this.activityRule_isAudit = activityRule_isAudit;
    }

    @NotNull(message = "common.不能为空")
    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "operation_auto.请输入")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "99999999")
    @Digits(integer = 8,fraction = 2)
    @Series(message = "operation_auto.下一梯度要大于上一梯度",type = SeriesType.INC)
    @Comment("存款金额")
    public Double[] getDepositAmountGe$$_preferentialValue() {
        return depositAmountGe$$_preferentialValue;
    }

    public void setDepositAmountGe$$_preferentialValue(Double[] depositAmountGe$$_preferentialValue) {
        this.depositAmountGe$$_preferentialValue = depositAmountGe$$_preferentialValue;
    }

    @NotNull(message = "common.不能为空")
    @Pattern(regexp = FormValidRegExps.DECIMAL,message = "operation_auto.请输入0")
    @Min(value = 0)
    @DecimalMax(value = "100")
    @Digits(integer = 3,fraction = 2)
//    @Series(message = "下一梯度要大于上一梯度",type = SeriesType.INC)
    @Comment("按比例赠送彩金")
    public Double[] getPercentageHandsel$$_preferentialValue() {
        return percentageHandsel$$_preferentialValue;
    }

    public void setPercentageHandsel$$_preferentialValue(Double[] percentageHandsel$$_preferentialValue) {
        this.percentageHandsel$$_preferentialValue = percentageHandsel$$_preferentialValue;
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
    @Comment("固定赠送彩金")
    public Double[] getRegularHandsel$$_preferentialValue() {
        return regularHandsel$$_preferentialValue;
    }

    public void setRegularHandsel$$_preferentialValue(Double[] regularHandsel$$_preferentialValue) {
        this.regularHandsel$$_preferentialValue = regularHandsel$$_preferentialValue;
    }

    public Boolean get$ｍosaicGold() {
        return $ｍosaicGold;
    }

    public void set$ｍosaicGold(Boolean $ｍosaicGold) {
        this.$ｍosaicGold = $ｍosaicGold;
    }

    /*@NotBlank(message = "请选择参与层级")
    public String getActivityRule_rank() {
        return activityRule_rank;
    }

    public void setActivityRule_rank(String activityRule_rank) {
        this.activityRule_rank = activityRule_rank;
    }*/

    @NotBlank(message = "operation_auto.请选择存款方式")
    public String getActivityRule_depositWay() {
        return activityRule_depositWay;
    }

    public void setActivityRule_depositWay(String activityRule_depositWay) {
        this.activityRule_depositWay = activityRule_depositWay;
    }
}
