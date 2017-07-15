package so.wwb.gamebox.mcenter.fund.rebate.form;

import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.support.Comment;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;


/**
 * 代理返佣账单表单验证对象
 *
 * @author bruce
 * @time 2017-3-4 14:47:34
 */
//region your codes 1
@Comment("修改代理可获返佣金额")
public class AgentRebateForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private Double result_rebateAmount;

    private Double result_rebateAmountActual;

    public Double getResult_rebateAmount() {
        return result_rebateAmount;
    }

    public void setResult_rebateAmount(Double result_rebateAmount) {
        this.result_rebateAmount = result_rebateAmount;
    }

    @Compare(message = "不能大于可获返佣金额", isNumber = "true", logic = CompareLogic.LE, anotherProperty = "result_rebateAmount")
    @Comment("实际可获返佣金额")
    public Double getResult_rebateAmountActual() {
        return result_rebateAmountActual;
    }

    public void setResult_rebateAmountActual(Double result_rebateAmountActual) {
        this.result_rebateAmountActual = result_rebateAmountActual;
    }


    //endregion your codes 2

}