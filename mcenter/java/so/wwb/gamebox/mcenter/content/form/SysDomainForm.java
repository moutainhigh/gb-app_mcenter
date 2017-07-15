package so.wwb.gamebox.mcenter.content.form;


import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.content.controller.SysDomainController;


/**
 * 站长域名表-修改完会替换 sys_domain表单验证对象
 *
 * @author jeff
 * @time 2015-8-20 9:21:53
 */
//region your codes 1
public class SysDomainForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String result_id;
    private String result_pageUrl;
    private String result_domain;
    private String result_name;
    private String $rankIds;
    @Depends(property = {"result_pageUrl","result_pageUrl","result_pageUrl","result_pageUrl","result_pageUrl"},
            operator = {Operator.NE,Operator.NE,Operator.NE,Operator.NE,Operator.NE},
            value = {"/mcenter/passport/login.html","/onLinePay","/passport/login.html","/tcenter/passport/login.html","/acenter/passport/login.html"},
            message = "content.domain.rankSubHadChoose")
    public String get$rankIds() {
        return $rankIds;
    }

    public void set$rankIds(String $rankIds) {
        this.$rankIds = $rankIds;
    }

    @NotBlank(message = "content.domain.rankTypeHadChoose")
    public String getResult_pageUrl() {
        return result_pageUrl;
    }

    public void setResult_pageUrl(String result_pageUrl) {
        this.result_pageUrl = result_pageUrl;
    }

    @NotBlank(message="content.domain.addressNotBlank")
    //@Pattern(regexp = "^(?=^.{3,255}$)[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+$", message = "content.domainType.linkAddressFormat")
    @Remote(message = "content.sysdomain.domain.exist",checkClass = SysDomainController.class,checkMethod = "checkDomain",additionalProperties = "result_id")
    public String getResult_domain() {
        return result_domain;
    }

    public void setResult_domain(String result_domain) {
        this.result_domain = result_domain;
    }

    @NotBlank
    @Length(message = "content.domain.nameLength",max = 10,min = 1)
    public String getResult_name() {
        return result_name;
    }

    public void setResult_name(String result_name) {
        this.result_name = result_name;
    }

    public String getResult_id() {
        return result_id;
    }

    public void setResult_id(String result_id) {
        this.result_id = result_id;
    }
    //endregion your codes 2

}