package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;


/**
 * 限制/允许访问站点/管理中心的IP表表单验证对象
 *
 * @author loong
 * @time 2015-8-11 11:18:00
 */
//region your codes 1
public class ServiceTermsForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String[] siteI18nList$$_value;

    private String[] orginContent$$_orginContent;
    @NotBlank
    public String[] getSiteI18nList$$_value() {
        return siteI18nList$$_value;
    }

    public void setSiteI18nList$$_value(String[] siteI18nList$$_value) {
        this.siteI18nList$$_value = siteI18nList$$_value;
    }
    @NotBlank
    @Length(min = 20,max = 20000,message = "setting.serviceTrems.lengthMsg")
    public String[] getOrginContent$$_orginContent() {
        return orginContent$$_orginContent;
    }

    public void setOrginContent$$_orginContent(String[] orginContent$$_orginContent) {
        this.orginContent$$_orginContent = orginContent$$_orginContent;
    }
    //endregion your codes 2

}