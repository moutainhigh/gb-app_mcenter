package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;

import javax.validation.constraints.NotNull;


/**
 * 玩家返佣表表单验证对象
 *
 * @author shisongbin
 * @time 2015-9-14 11:35:46
 */
//region your codes 1
@Comment("修改实付佣金表单验证")
public class RebateAgentForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private Double result_rebateTotal;

    private Double result_rebateActual;

    private String result_remark;

    //,depends = @Depends(property={"result.rebateActual"}, operator = {Operator.EQ}, value = {"false"}, message = "实付金额必须大于等于应付金额")
//    @Digits(integer = 8,fraction = 2)
//    @Compare(message = "实付金额必须小于等于应付金额",logic = CompareLogic.LE,anotherProperty = "result_rebateTotal")
    @Range(min = -99999999,max = 99999999)
    @NotNull(message = "common.不能为空")
    @Comment("实付金额")
    public Double getResult_rebateActual() {
        return result_rebateActual;
    }

    public void setResult_rebateActual(Double result_rebateActual) {
        this.result_rebateActual = result_rebateActual;
    }

    public Double getResult_rebateTotal() {
        return result_rebateTotal;
    }

    public void setResult_rebateTotal(Double result_rebateTotal) {
        this.result_rebateTotal = result_rebateTotal;
    }

    @NotBlank(message = "common.不能为空")
    @Length(min = 1,max = 200,message = "operation_auto.不能超过200个字符")
    @Comment("备注")
    public String getResult_remark() {
        return result_remark;
    }

    public void setResult_remark(String result_remark) {
        this.result_remark = result_remark;
    }
    //endregion your codes 2

}