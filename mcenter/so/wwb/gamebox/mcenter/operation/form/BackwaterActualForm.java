package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;
import so.wwb.gamebox.mcenter.operation.controller.BackwaterController;

import javax.validation.constraints.Pattern;


/**
 * 修改实付返水表单验证对象
 * <p/>
 * Created by cheery using soul-code-generator on 2015-7-13 11:09:02
 */
//region your codes 1
@Comment("修改实付返水表单验证")
public class BackwaterActualForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String result_remark;
    private String result_rakebackActual;

    @Comment("备注")
    @NotBlank(message = "operation.backwater.BackwaterActualForm.remarkContent.notBlank")
    @Length(message = "operation.backwater.BackwaterActualForm.remarkContent.maxLength", max = 200)
    public String getResult_remark() {
        return result_remark;
    }

    public void setResult_remark(String result_remark) {
        this.result_remark = result_remark;
    }

    @Comment("实付返水金额")
    @NotBlank
    @Pattern(message = "operation.backwater.BackwaterActualForm.backwaterActual.digits", regexp = FormValidRegExps.DECIMAL)
    @Remote(message = "operation.backwater.BackwaterActualForm.backwaterActual.max", checkClass = BackwaterController.class, checkMethod = "checkBackwaterActual", additionalProperties = {"rakebackTotal"})

    public String getResult_rakebackActual() {
        return result_rakebackActual;
    }

    public void setResult_rakebackActual(String result_rakebackActual) {
        this.result_rakebackActual = result_rakebackActual;
    }
    //endregion your codes 2

}