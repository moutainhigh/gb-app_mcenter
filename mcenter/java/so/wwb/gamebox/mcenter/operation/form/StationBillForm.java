package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.Range;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;

import javax.validation.constraints.Digits;


/**
 * 站务账单表表单验证对象
 *
 * @author shisongbin
 * @time 2015-9-7 19:49:30
 */
//region your codes 1
@Comment("结算账单表单修改")
public class StationBillForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private Double result_amountActual;

    private String result_remark;

    @Range(min = -99999999,max = 99999999)
    @Digits(integer =8, fraction = 2)
    @Comment("实付金额")
    public Double getResult_amountActual() {
        return result_amountActual;
    }

    public void setResult_amountActual(Double result_amountActual) {
        this.result_amountActual = result_amountActual;
    }

    @Length(max = 200)
    @Comment("备注")
    public String getResult_remark() {
        return result_remark;
    }

    public void setResult_remark(String result_remark) {
        this.result_remark = result_remark;
    }

    //endregion your codes 2

}