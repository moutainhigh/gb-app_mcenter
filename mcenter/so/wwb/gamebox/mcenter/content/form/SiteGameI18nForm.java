package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.web.support.IForm;


/**
 * site_game_i18n表单验证对象
 *
 * @author River
 * @time 2015-11-9 16:29:24
 */
//region your codes 1
public class SiteGameI18nForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String[] siteGameI18ns$$_name;
    private String[] siteGameI18ns$$_cover;
    private String[] siteGameI18ns$$_introduceStatus;
    private String[] siteGameI18ns$$_gameIntroduce;

    @NotBlank(message = "content.game.valid.titleNoBlank")
    @Length(min = 1,max = 50)
    public String[] getSiteGameI18ns$$_name() {
        return siteGameI18ns$$_name;
    }

    public void setSiteGameI18ns$$_name(String[] siteGameI18ns$$_name) {
        this.siteGameI18ns$$_name = siteGameI18ns$$_name;
    }

    public String[] getSiteGameI18ns$$_cover() {
        return siteGameI18ns$$_cover;
    }

    public void setSiteGameI18ns$$_cover(String[] siteGameI18ns$$_cover) {
        this.siteGameI18ns$$_cover = siteGameI18ns$$_cover;
    }
    @Depends(property ={"siteGameI18ns$$_introduceStatus"}, operator = {Operator.EQ}, value = {"normal"},
            jsValueExp = {"$(\"[name='siteGameI18ns[\"+page.rowIndex+\"].introduceStatus']\").val()"})
    public String[] getSiteGameI18ns$$_gameIntroduce() {
        return siteGameI18ns$$_gameIntroduce;
    }

    public void setSiteGameI18ns$$_gameIntroduce(String[] siteGameI18ns$$_gameIntroduce) {
        this.siteGameI18ns$$_gameIntroduce = siteGameI18ns$$_gameIntroduce;
    }

    public String[] getSiteGameI18ns$$_introduceStatus() {
        return siteGameI18ns$$_introduceStatus;
    }

    public void setSiteGameI18ns$$_introduceStatus(String[] siteGameI18ns$$_introduceStatus) {
        this.siteGameI18ns$$_introduceStatus = siteGameI18ns$$_introduceStatus;
    }
//endregion your codes 2

}