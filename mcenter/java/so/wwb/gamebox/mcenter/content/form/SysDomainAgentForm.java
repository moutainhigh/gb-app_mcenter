package so.wwb.gamebox.mcenter.content.form;


import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
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
public class SysDomainAgentForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String result_id;
    private String result_domain;
    private String $agentUserName;
    @NotBlank
    /*@Pattern(regexp = "^(?=^.{3,255}$)[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+$", message = "content.domainType.linkAddressFormat")*/
    @Remote(message = "content.sysdomain.domain.exist",checkClass = SysDomainController.class,checkMethod = "checkDomain",additionalProperties = "result_id")
    public String getResult_domain() {
        return result_domain;
    }

    public void setResult_domain(String result_domain) {
        this.result_domain = result_domain;
    }

    @NotBlank
    @Remote(message = "player.topAgent.edit.accountNotExist",checkClass = SysDomainController.class,checkMethod = "checkAgentUserName")
    @Length(max = 15)
    public String get$agentUserName() {
        return $agentUserName;
    }

    public void set$agentUserName(String $agentUserName) {
        this.$agentUserName = $agentUserName;
    }

    public String getResult_id() {
        return result_id;
    }

    public void setResult_id(String result_id) {
        this.result_id = result_id;
    }
    //endregion your codes 2

}