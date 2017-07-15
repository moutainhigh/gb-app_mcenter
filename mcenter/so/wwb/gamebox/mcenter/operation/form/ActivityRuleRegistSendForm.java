package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.support.Comment;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.*;

/**
 * Created by eagle on 15-9-1.
 */
@Comment("活动规则注册送表单验证")
public class ActivityRuleRegistSendForm extends ActivityRuleForm {

    private Boolean activityRule_isAudit;
    private String activityRule_effectiveTime;
    private Double activityWayRelation_preferentialValue;
    private Double activityWayRelation_preferentialAudit;

//    private String activityRule_rank;

    @NotBlank(message = "operation_auto.请选择是否审核")
    @Comment("是否审核")
    public Boolean getActivityRule_isAudit() {
        return activityRule_isAudit;
    }

    public void setActivityRule_isAudit(Boolean activityRule_isAudit) {
        this.activityRule_isAudit = activityRule_isAudit;
    }

    @NotBlank(message = "operation_auto.请选择有效时间")
    @Comment("有效时间")
    public String getActivityRule_effectiveTime() {
        return activityRule_effectiveTime;
    }

    public void setActivityRule_effectiveTime(String activityRule_effectiveTime) {
        this.activityRule_effectiveTime = activityRule_effectiveTime;
    }

    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "operation_auto.请输入0")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "100")
    @Digits(integer = 3,fraction = 2)
    @Comment("优惠稽核")
    public Double getActivityWayRelation_preferentialAudit() {
        return activityWayRelation_preferentialAudit;
    }

    public void setActivityWayRelation_preferentialAudit(Double activityWayRelation_preferentialAudit) {
        this.activityWayRelation_preferentialAudit = activityWayRelation_preferentialAudit;
    }

    @NotBlank(message = "common.不能为空")
    @Pattern(regexp = FormValidRegExps.DECIMAL,message = "operation_auto.请输入0-99999999")
    @Min(value = 0)
    @DecimalMax(value = "99999999")
    @Digits(integer = 8,fraction = 2)
    @Comment("赠送彩金")
    public Double getActivityWayRelation_preferentialValue() {
        return activityWayRelation_preferentialValue;
    }

    public void setActivityWayRelation_preferentialValue(Double activityWayRelation_preferentialValue) {
        this.activityWayRelation_preferentialValue = activityWayRelation_preferentialValue;
    }

    /*@NotBlank(message = "请选择参与层级")
    public String getActivityRule_rank() {
        return activityRule_rank;
    }

    public void setActivityRule_rank(String activityRule_rank) {
        this.activityRule_rank = activityRule_rank;
    }*/
}
