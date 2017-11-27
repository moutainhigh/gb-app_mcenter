package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;


/**
 * 预警设置表表单验证对象
 *
 * @author loong
 * @time 2015-7-30 9:54:36
 */
//region your codes 1
@Comment("预警设置表表单验证")
public class WarningSettingsForm implements IForm {
//endregion your codes 1

    //region your codes 2
    //层级账号不足个数
    private String inadequateCount_paramValue;


    @Range(min = 1, max = 10)
    @NotBlank
    public String getInadequateCount_paramValue() {
        return inadequateCount_paramValue;
    }

    public void setInadequateCount_paramValue(String inadequateCount_paramValue) {
        this.inadequateCount_paramValue = inadequateCount_paramValue;
    }
    //endregion your codes 2

}