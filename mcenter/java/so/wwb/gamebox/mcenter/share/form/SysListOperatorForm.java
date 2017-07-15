package so.wwb.gamebox.mcenter.share.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;

/**
 * 用户自定义查询条件，列表显示保存表表单验证对象
 *
 * Created by tom using soul-code-generator on 2015-6-1 9:15:39
 */
public class SysListOperatorForm implements IForm {

    private String $description;

    @Length(message = "share.description.max.length", max = 100)
    @NotBlank
    public String get$description() {
        return $description;
    }

    public void set$description(String $description) {
        this.$description = $description;
    }
}