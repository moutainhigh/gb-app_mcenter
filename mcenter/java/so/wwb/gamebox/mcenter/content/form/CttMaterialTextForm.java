package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;

import javax.validation.constraints.Size;


/**
 * 推广素材文字表表单验证对象
 *
 * @author tom
 * @time 2015-10-29 11:32:15
 */
//region your codes 1
public class CttMaterialTextForm implements IForm {
//endregion your codes 1

    //region your codes 2
    /** 内容 */
    @NotBlank
    @Size(min = 1,max = 200)
    private String result_content;

    public String getResult_content() {
        return result_content;
    }

    public void setResult_content(String result_content) {
        this.result_content = result_content;
    }
    //endregion your codes 2

}