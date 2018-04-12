package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.content.controller.CttCarouselController;
import so.wwb.gamebox.mcenter.operation.controller.ActivityTypeController;

/**
 * Created by eagle on 15-9-1.
 */
@Comment("活动内容表单验证")
public class ActivityContentStepForm implements IForm {

    private String activityMessage_startTime;
    private String activityMessage_endTime;
    private String activityMessage_activityClassifyKey;
    private String activityMessageI18ns$$_activityName;
    private String activityMessageI18ns$$_activityDescription;
    private String activityMessageI18ns$$_activityCover;
//    private String activityMessageI18ns$$_activityOverview;
    private String activityRule_rank;
    private String activityMessageI18ns$$_activityAffiliated;

    @NotBlank(message = "operation_auto.结束时间不能为空")
    @Comment("结束时间")
    @Remote(message = "operation_auto.结束时间需大于开始时间",checkClass = ActivityTypeController.class,checkMethod = "checkTime",additionalProperties = {"activityMessage_startTime"})
    public String getActivityMessage_endTime() {
        return activityMessage_endTime;
    }

    public void setActivityMessage_endTime(String activityMessage_endTime) {
        this.activityMessage_endTime = activityMessage_endTime;
    }

    @NotBlank(message = "operation_auto.开始时间不能为空")
//    @Remote(checkClass = VActivityMessageController.class,checkMethod = "checkStartDate",additionalProperties = {"activityMessage_startTime"},message = "开始时间不得小于当前时间")
    @Comment("开始时间")
    public String getActivityMessage_startTime() {
        return activityMessage_startTime;
    }

    public void setActivityMessage_startTime(String activityMessage_startTime) {
        this.activityMessage_startTime = activityMessage_startTime;
    }

    @NotBlank(message = "operation_auto.活动说明不能为空")
//    @Length(max = 2000)
    @Comment("活动说明")
    public String getActivityMessageI18ns$$_activityDescription() {
        return activityMessageI18ns$$_activityDescription;
    }

    public void setActivityMessageI18ns$$_activityDescription(String activityMessageI18ns$$_activityDescription) {
        this.activityMessageI18ns$$_activityDescription = activityMessageI18ns$$_activityDescription;
    }

    @NotBlank(message = "operation_auto.活动名称不能为空")
    @Length(max = 50)
    @Comment("活动名称")
    public String getActivityMessageI18ns$$_activityName() {
        return activityMessageI18ns$$_activityName;
    }

    public void setActivityMessageI18ns$$_activityName(String activityMessageI18ns$$_activityName) {
        this.activityMessageI18ns$$_activityName = activityMessageI18ns$$_activityName;
    }

    @NotBlank(message = "operation_auto.请选择分类")
    @Comment("活动分类")
    public String getActivityMessage_activityClassifyKey() {
        return activityMessage_activityClassifyKey;
    }

    public void setActivityMessage_activityClassifyKey(String activityMessage_activityClassifyKey) {
        this.activityMessage_activityClassifyKey = activityMessage_activityClassifyKey;
    }

    @NotBlank(message = "活动封面不能为空")
    @Comment("活动附图")
    public String getActivityMessageI18ns$$_activityCover() {
        return activityMessageI18ns$$_activityCover;
    }

    public void setActivityMessageI18ns$$_activityCover(String activityMessageI18ns$$_activityCover) {
        this.activityMessageI18ns$$_activityCover = activityMessageI18ns$$_activityCover;
    }

    /*@NotBlank(message = "活动概述不能为空")
    @Length(max = 500)
    @Comment("活动概述")
    public String getActivityMessageI18ns$$_activityOverview() {
        return activityMessageI18ns$$_activityOverview;
    }

    public void setActivityMessageI18ns$$_activityOverview(String activityMessageI18ns$$_activityOverview) {
        this.activityMessageI18ns$$_activityOverview = activityMessageI18ns$$_activityOverview;
    }*/

    @Depends(property = "activityRule_rank",operator = Operator.EQ,value = {"true"},
            jsValueExp ="$(\"[name=\\'result.code\\']\").val()=='content'",message = "operation_auto.请选择参与层级")
    @Comment("参与层级")
    public String getActivityRule_rank() {
        return activityRule_rank;
    }

    public void setActivityRule_rank(String activityRule_rank) {
        this.activityRule_rank = activityRule_rank;
    }

    @NotBlank(message = "operation_auto.活动附图不能为空")
    @Comment("活动封面")
    public String getActivityMessageI18ns$$_activityAffiliated() {
        return activityMessageI18ns$$_activityAffiliated;
    }

    public void setActivityMessageI18ns$$_activityAffiliated(String activityMessageI18ns$$_activityAffiliated) {
        this.activityMessageI18ns$$_activityAffiliated = activityMessageI18ns$$_activityAffiliated;
    }
}
