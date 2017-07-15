package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.Range;
import org.soul.web.support.IForm;

import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;

/**
 * 设置代理存款取手续费比例.
 */
//region your codes 1
public class RebateSetFeeForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private Double[] sysParam$$_paramValue;

    private Integer sysParamLimit$$_paramValue;

    @NotNull
    @Range(max = 99999999, min = 1, message = "setting.rakeback.withdraw.limitRange")
    public Integer getSysParamLimit$$_paramValue() {
        return sysParamLimit$$_paramValue;
    }

    public void setSysParamLimit$$_paramValue(Integer sysParamLimit$$_paramValue) {
        this.sysParamLimit$$_paramValue = sysParamLimit$$_paramValue;
    }

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