package so.wwb.gamebox.mcenter.content.form;


import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.content.controller.SysDomainController;

import javax.validation.constraints.Pattern;


/**
 * 站长域名表-修改完会替换 sys_domain表单验证对象
 *
 * @author jeff
 * @time 2015-8-20 9:21:53
 */
//region your codes 1
public class SysDomainDefaultForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String result_id;
    private String $indexName;
    private String $indexPageUrl;
    private String $indexDomain;

    private String $managerName;
    private String $managerPageUrl;
    private String $managerDomain;
    @NotBlank
    @Length(max = 15)
    public String get$indexName() {
        return $indexName;
    }

    public void set$indexName(String $indexName) {
        this.$indexName = $indexName;
    }
    @NotBlank
    @Length(max = 15)
    public String get$managerName() {
        return $managerName;
    }

    public void set$managerName(String $managerName) {
        this.$managerName = $managerName;
    }
    @NotBlank(message="content.domain.addressNotBlank")
    @Pattern(regexp = "^(?=^.{3,255}$)[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+$", message = "content.domainType.linkAddressFormat")
    @Remote(message = "content.sysdomain.domain.exist",checkClass = SysDomainController.class,checkMethod = "checkIndexDomain",additionalProperties = "result_id")
    public String get$indexDomain() {
        return $indexDomain;
    }

    public void set$indexDomain(String $indexDomain) {
        this.$indexDomain = $indexDomain;
    }
    @NotBlank(message="content.domain.addressNotBlank")
    @Pattern(regexp = "^(?=^.{3,255}$)[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+$", message = "content.domainType.linkAddressFormat")
    @Compare(message = "content_auto.不能跟主域名相同", logic = CompareLogic.NE, anotherProperty = "indexDomain")
    @Remote(message = "content.sysdomain.domain.exist",checkClass = SysDomainController.class,checkMethod = "checkManagerDomain",additionalProperties = "result_id")
    public String get$managerDomain() {
        return $managerDomain;
    }

    public void set$managerDomain(String $managerDomain) {
        this.$managerDomain = $managerDomain;
    }
    @NotBlank
    public String get$indexPageUrl() {
        return $indexPageUrl;
    }

    public void set$indexPageUrl(String $indexPageUrl) {
        this.$indexPageUrl = $indexPageUrl;
    }
    @NotBlank
    public String get$managerPageUrl() {
        return $managerPageUrl;
    }

    public void set$managerPageUrl(String $managerPageUrl) {
        this.$managerPageUrl = $managerPageUrl;
    }

    public String getResult_id() {
        return result_id;
    }

    public void setResult_id(String result_id) {
        this.result_id = result_id;
    }
    //endregion your codes 2

}