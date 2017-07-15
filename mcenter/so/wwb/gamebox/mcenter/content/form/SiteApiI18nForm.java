package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;


/**
 * site_api_i18n表表单验证对象
 *
 * @author River
 * @time 2015-11-6 15:31:37
 */
//region your codes 1
public class SiteApiI18nForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String[] siteApiI18ns$$_name;
    private String[] siteApiI18ns$$_cover;
    @NotBlank(message = "content.game.valid.titleNoBlank")
    @Length(min = 1,max = 50)
    public String[] getSiteApiI18ns$$_name() {
        return siteApiI18ns$$_name;
    }

    public void setSiteApiI18ns$$_name(String[] siteApiI18ns$$_name) {
        this.siteApiI18ns$$_name = siteApiI18ns$$_name;
    }
    /*@NotBlank(message = "content.game.valid.coverNoBlank")*/
    public String[] getSiteApiI18ns$$_cover() {
        return siteApiI18ns$$_cover;
    }

    public void setSiteApiI18ns$$_cover(String[] siteApiI18ns$$_cover) {
        this.siteApiI18ns$$_cover = siteApiI18ns$$_cover;
    }

    //endregion your codes 2

}