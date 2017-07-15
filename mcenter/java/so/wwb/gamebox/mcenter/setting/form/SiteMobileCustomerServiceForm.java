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
public class SiteMobileCustomerServiceForm implements IForm {
//endregion your codes 1

    //region your codes 2
    /**
     * 名称
     */
    private String mobile_name;

    /**
     * 在线客服参数
     */
    private String mobile_parameter;

    @NotBlank
    @Pattern(regexp = FormValidRegExps.CNANDEN_NUMBER,message = "setting.siteCustomerService.form.result.name")
    @Length(min = 1,max = 20,message = "setting.siteCustomerService.form.result.name")
    public String getMobile_name() {
        return mobile_name;
    }

    public void setMobile_name(String mobile_name) {
        this.mobile_name = mobile_name;
    }

    @NotBlank
    @Length(min = 1,max = 450)
    public String getMobile_parameter() {
        return mobile_parameter;
    }

    public void setMobile_parameter(String mobile_parameter) {
        this.mobile_parameter = mobile_parameter;
    }

    //endregion your codes 2

}