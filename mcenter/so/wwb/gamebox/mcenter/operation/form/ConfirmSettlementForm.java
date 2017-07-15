package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;


/**
 * 玩家返佣表表单验证对象
 *
 * @author shisongbin
 * @time 2015-9-14 11:35:46
 */
//region your codes 1
@Comment("拒绝结算表单验证")
public class ConfirmSettlementForm implements IForm {
//endregion your codes 1

    //region your codes 2

    private String $reasonTitle;

    private String $reasonContent;

    @NotBlank(message = "operation_auto.内容不能为空")
    @Length(max = 1000)
    @Comment("内容")
    public String get$reasonContent() {
        return $reasonContent;
    }

    public void set$reasonContent(String $reasonContent) {
        this.$reasonContent = $reasonContent;
    }

//    @NotBlank(message = "请选择失败原因")
    @Comment("失败原因")
    public String get$reasonTitle() {
        return $reasonTitle;
    }

    public void set$reasonTitle(String $reasonTitle) {
        this.$reasonTitle = $reasonTitle;
    }

    //endregion your codes 2

}