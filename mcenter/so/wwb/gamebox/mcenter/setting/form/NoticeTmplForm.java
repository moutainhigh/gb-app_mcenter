package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;


/**
 * 通知模板表单验证对象
 *
 * @author tom
 * @time 2015-8-21 14:03:05
 */
//region your codes 1
public class NoticeTmplForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String result_eventType;

    private String result_title;

    private String result_publishMethod;

    @NotBlank
    public String getResult_eventType() {
        return result_eventType;
    }

    public void setResult_eventType(String result_eventType) {
        this.result_eventType = result_eventType;
    }

    @Length(message = "setting_auto.不能超过100个字符",max = 100,min = 1)
    public String getResult_title() {
        return result_title;
    }

    public void setResult_title(String result_title) {
        this.result_title = result_title;
    }

    @NotBlank
    public String getResult_publishMethod() {
        return result_publishMethod;
    }

    public void setResult_publishMethod(String result_publishMethod) {
        this.result_publishMethod = result_publishMethod;
    }

    //endregion your codes 2

}