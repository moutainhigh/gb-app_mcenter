package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;


/**
 * 客服设置表表单验证对象
 *
 * @author loong
 * @time 2015-8-12 16:25:57
 */
//region your codes 1
public class SiteCustomerServiceForm implements IForm {
//endregion your codes 1

    //region your codes 2
    /**
     * 名称
     */
    private String name;

    private String type;

    /**
     * 在线客服参数
     */
    private String parameter;

    @NotBlank()
    @Pattern(regexp = FormValidRegExps.CNANDEN_NUMBER,message = "setting.siteCustomerService.form.result.name")
    @Length(min = 1,max = 20,message = "setting.siteCustomerService.form.result.name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @NotBlank()
    @Length(min = 1,max = 450)
    public String getParameter() {
        return parameter;
    }

    public void setParameter(String parameter) {
        this.parameter = parameter;
    }

    @NotBlank(message = "setting_auto.请选择类型")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    //endregion your codes 2

}