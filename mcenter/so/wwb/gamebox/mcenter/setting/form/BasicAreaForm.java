package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;


/**
 * 限制访问站点的地区表表单验证对象
 *
 * @author loong
 * @time 2015-8-11 11:17:30
 */
//region your codes 1
public class BasicAreaForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String result_code;
    @NotBlank
    public String getResult_code() {
        return result_code;
    }

    public void setResult_code(String result_code) {
        this.result_code = result_code;
    }
    //endregion your codes 2
}