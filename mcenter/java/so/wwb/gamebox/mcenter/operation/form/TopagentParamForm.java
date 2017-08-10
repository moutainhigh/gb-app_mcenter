package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.Range;
import org.soul.web.support.IForm;

import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;

/**
 * 设置代理存款取手续费比例.
 */
//region your codes 1
public class TopagentParamForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private Double[] sysParam$$_paramValue;

    @NotNull
    @Range(max = 100, min = 0, message = "setting.rakeback.edit.ratioRange")
    @Digits(integer = 3, fraction = 2, message = "setting.rakeback.edit.ratioDigits")
    public Double[] getSysParam$$_paramValue() {
        return sysParam$$_paramValue;
    }

    public void setSysParam$$_paramValue(Double[] sysParam$$_paramValue) {
        this.sysParam$$_paramValue = sysParam$$_paramValue;
    }
    //endregion your codes 2

}