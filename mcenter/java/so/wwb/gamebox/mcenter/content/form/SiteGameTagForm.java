package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;


/**
 * 游戏标签表 by River表单验证对象
 *
 * @author River
 * @time 2015-12-17 12:01:07
 */
//region your codes 1
public class SiteGameTagForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String[] gruop$$_locale$$; //obj[0].value[0]

    @NotBlank
    @Length(min = 1,max = 20)
    @Pattern(regexp = FormValidRegExps.CNANDEN_NUMBER_SAPCING,message = "content.game.gametag.namevalidate")
    //@Remote(additionalProperties = {"id","key"},jsValueExp = {"$(\"[name='gruop[\"+page.rowIndex+\"].id[\"+page.rowIndex+\"]']\").val()","$(\"[name='gruop[\"+page.rowIndex+\"].key[\"+page.rowIndex+\"]']\").val()"},message = "content.document.titleRepeat",checkMethod = "checkTitle",checkClass = SiteGameTagController.class)
    public String[] getGruop$$_locale$$() {
        return gruop$$_locale$$;
    }

    public void setGruop$$_locale$$(String[] gruop$$_locale$$) {
        this.gruop$$_locale$$ = gruop$$_locale$$;
    }
    //endregion your codes 2
//
    //$("[name='gruop['+rowIndex+'].id['+rowIndex+']']").val()
}