package so.wwb.gamebox.mcenter.analyze.form;

import org.hibernate.validator.constraints.Range;
import org.soul.web.support.IForm;


/**
 * 玩家分析表单验证对象
 *
 * @author jerry
 * @time 2016-12-6 20:57:42
 */
//region your codes 1
public class AnalyzeParamForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private  String depositCountParam_paramValue;
    private  String depositParam_paramValue;
    private  String effectiveParam_paramValue;


    @Range(min = 0, max = 99999999)
    public String getDepositCountParam_paramValue() {
        return depositCountParam_paramValue;
    }

    public void setDepositCountParam_paramValue(String depositCountParam_paramValue) {
        this.depositCountParam_paramValue = depositCountParam_paramValue;
    }

    @Range(min = 0, max = 99999999)
    public String getDepositParam_paramValue() {
        return depositParam_paramValue;
    }

    public void setDepositParam_paramValue(String depositParam_paramValue) {
        this.depositParam_paramValue = depositParam_paramValue;
    }
    @Range(min = 0, max = 99999999)
    public String getEffectiveParam_paramValue() {
        return effectiveParam_paramValue;
    }

    public void setEffectiveParam_paramValue(String effectiveParam_paramValue) {
        this.effectiveParam_paramValue = effectiveParam_paramValue;
    }

    //endregion your codes 2

}