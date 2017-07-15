package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;


/**
 * site_api_type_i18n表单验证对象
 *
 * @author River
 * @time 2015-11-5 10:10:12
 */
//region your codes 1
public class SiteApiTypeI18nForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String[] apiTypeI18ns$$_name;
    private String[] apiTypeI18ns$$_cover;

    @NotBlank(message = "content.game.valid.titleNoBlank")
    @Length(min = 1,max = 50)
    public String[] getApiTypeI18ns$$_name() {
        return apiTypeI18ns$$_name;
    }

    public void setApiTypeI18ns$$_name(String[] apiTypeI18ns$$_name) {
        this.apiTypeI18ns$$_name = apiTypeI18ns$$_name;
    }
    public String[] getApiTypeI18ns$$_cover() {
        return apiTypeI18ns$$_cover;
    }

    public void setApiTypeI18ns$$_cover(String[] apiTypeI18ns$$_cover) {
        this.apiTypeI18ns$$_cover = apiTypeI18ns$$_cover;
    }
    //endregion your codes 2

}