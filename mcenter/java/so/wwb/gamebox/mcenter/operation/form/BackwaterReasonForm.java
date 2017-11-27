package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.Length;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;

/**
 * 原因验证表单
 */
@Comment("原因验证表单")
public class BackwaterReasonForm implements IForm {
    private String $reasonContent;

    private String $hasRason;

    @Comment("失败原因内容")
    @Depends(message = "operation.backwater.FailureReasonForm.content.notBlank",operator = Operator.IS_NOT_EMPTY,value = "",property = "$hasReason")
    //@NotBlank(message = "operation.backwater.FailureReasonForm.content.notBlank")
    @Length(message = "operation.backwater.FailureReasonForm.content.length",max = 1000)
    public String get$reasonContent() {
        return $reasonContent;
    }

    public void set$reasonContent(String $reasonContent) {
        this.$reasonContent = $reasonContent;
    }

    public String get$hasRason() {
        return $hasRason;
    }

    public void set$hasRason(String $hasRason) {
        this.$hasRason = $hasRason;
    }
}
