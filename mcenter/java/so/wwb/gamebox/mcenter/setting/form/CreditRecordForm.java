package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.setting.controller.CreditPayController;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Digits;


/**
 * 买分记录表单验证对象
 *
 * @author kobe
 * @time 2017-8-10 15:52:14
 */
//region your codes 1
public class CreditRecordForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String result_bankName;
    private String result_payAmount;

    @NotBlank
    @Digits(integer = 8, fraction = 0)
    @DecimalMin(value = "1")
    @Remote(message="",checkMethod = "checkPayAmount",checkClass = CreditPayController.class,additionalProperties = "result.bankName",jsValueExp = "$(\"input[name='result.bankName']:checked\").val()")
    public String getResult_payAmount() {
        return result_payAmount;
    }

    public void setResult_payAmount(String result_payAmount) {
        this.result_payAmount = result_payAmount;
    }

    @NotBlank(message = "请选择存款渠道")
    public String getResult_bankName() {
        return result_bankName;
    }

    public void setResult_bankName(String result_bankName) {
        this.result_bankName = result_bankName;
    }
    //endregion your codes 2

}