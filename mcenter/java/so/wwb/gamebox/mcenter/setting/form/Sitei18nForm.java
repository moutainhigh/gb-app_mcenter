package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.web.support.IForm;

import java.util.Date;


/**
 *
 */
//region your codes 1
public class Sitei18nForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String[] sv$$_module;
    private String[] sv$$_type;
    private String[] sv$$_key;
    private String[] sv$$_value;
    private String $sysParam_paramValue;
    private Date $closeTime;
    private String result_paramCode;

    @NotBlank()
    public String[] getSv$$_module() {
        return sv$$_module;
    }

    @NotBlank()
    public String[] getSv$$_type() {
        return sv$$_type;
    }

    @NotBlank()
    public String[] getSv$$_key() {
        return sv$$_key;
    }
    @Depends(property = "result_paramCode",operator = Operator.EQ,value = "closure",message = "setting_auto.请选择")
    public String get$sysParam_paramValue() {
        return $sysParam_paramValue;
    }


    @NotBlank()
    @Length(min = 1,max = 200)
    public String[] getSv$$_value() {
        return sv$$_value;
    }

    @Depends(property = "$type",operator = Operator.EQ,value = "2",message = "setting_auto.时间不能为空")
    public Date get$closeTime() {
        return $closeTime;
    }

    public void setSv$$_module(String[] sv$$_module) {
        this.sv$$_module = sv$$_module;
    }

    public void setSv$$_type(String[] sv$$_type) {
        this.sv$$_type = sv$$_type;
    }

    public void setSv$$_key(String[] sv$$_key) {
        this.sv$$_key = sv$$_key;
    }

    public void setSv$$_value(String[] sv$$_value) {
        this.sv$$_value = sv$$_value;
    }

    public void set$closeTime(Date $closeTime) {
        this.$closeTime = $closeTime;
    }

    public void set$sysParam_paramValue(String $sysParam_paramValue) {
        this.$sysParam_paramValue = $sysParam_paramValue;
    }

    public String getResult_paramCode() {
        return result_paramCode;
    }

    public void setResult_paramCode(String result_paramCode) {
        this.result_paramCode = result_paramCode;
    }
    //endregion your codes 2

}