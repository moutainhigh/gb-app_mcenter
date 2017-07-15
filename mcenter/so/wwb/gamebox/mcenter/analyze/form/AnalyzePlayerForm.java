package so.wwb.gamebox.mcenter.analyze.form;

import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;
import javax.validation.constraints.Pattern;

import org.soul.web.support.IForm;


/**
 * 玩家分析表单验证对象
 *
 * @author jerry
 * @time 2016-12-26 19:44:20
 */
//region your codes 1
public class AnalyzePlayerForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private  String depositTodayParam_paramValue;
    private  String effectiveTodayParam_paramValue;


    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER,message = "common.POSITIVE_INTEGER")
    public String getDepositTodayParam_paramValue() {
        return depositTodayParam_paramValue;
    }

    public void setDepositTodayParam_paramValue(String depositTodayParam_paramValue) {
        this.depositTodayParam_paramValue = depositTodayParam_paramValue;
    }
    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER,message = "common.POSITIVE_INTEGER")
    public String getEffectiveTodayParam_paramValue() {
        return effectiveTodayParam_paramValue;
    }

    public void setEffectiveTodayParam_paramValue(String effectiveTodayParam_paramValue) {
        this.effectiveTodayParam_paramValue = effectiveTodayParam_paramValue;
    }

    //endregion your codes 2

}