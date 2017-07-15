package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;


/**
 * 系统公告表单验证对象
 *
 * @author orange
 * @time 2015-11-17 14:57:54
 */
//region your codes 1
public class SystemAnnouncementForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String result_language;
    @NotBlank(message = "common.pleaseSelect")
    public String getResult_language() {
        return result_language;
    }

    public void setResult_language(String result_language) {
        this.result_language = result_language;
    }
    //endregion your codes 2

}