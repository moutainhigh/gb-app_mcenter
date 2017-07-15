package so.wwb.gamebox.mcenter.content.form;

import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.web.support.IForm;


/**
 * 收款账户表单验证对象
 *
 * @author Jeff
 * @time 2015-8-31 11:20:22
 */
//region your codes 1
public class VPayAccountHideSettingForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String[] $siteI18ns$$_value;
    //TODO Map 表单验证
    private String[] $handleCustomerService_paramValue;

    @Depends(property = "$isShow", operator = Operator.EQ,value ="false",message = "content.payAccount.hideSetting.titleNotBlank")
    public String[] get$siteI18ns$$_value() {
        return $siteI18ns$$_value;
    }

    public void set$siteI18ns$$_value(String[] $siteI18ns$$_value) {
        this.$siteI18ns$$_value = $siteI18ns$$_value;
    }

    @Depends(property = "$isShow", operator = Operator.EQ,value ="false",message = "content.payAccount.hideSetting.serviceNotBlank")
    public String[] get$handleCustomerService_paramValue() {
        return $handleCustomerService_paramValue;
    }

    public void set$handleCustomerService_paramValue(String[] $handleCustomerService_paramValue) {
        this.$handleCustomerService_paramValue = $handleCustomerService_paramValue;
    }
//endregion your codes 2

}