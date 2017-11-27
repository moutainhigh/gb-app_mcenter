package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;
import so.wwb.gamebox.mcenter.player.controller.PlayerController;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;


/**
 * 查询表单验证对象
 *
 * Created by snekey using soul-code-generator on 2015-6-19 13:51:46
 */
public class AddNewPlayerForm implements IForm {

    //region your codes

    private String result_username;

    private String result_password;

    private Integer result_agentId;

    private Integer result_rankId;

    @NotBlank(message = "common_auto.username.notBlank")
    @Pattern(regexp = FormValidRegExps.ACCOUNT,message = "common_auto.username.format")
    @Remote(message = "common_auto.username.exist",checkMethod = "checkUserNameExist",checkClass = PlayerController.class)
    public String getResult_username() {
        return result_username;
    }

    public void setResult_username(String result_username) {
        this.result_username = result_username;
    }

    @NotBlank(message = "common_auto.password.notBlank")
    @Remote(message = "common_auto.passport.tooEasy",checkClass = PlayerController.class,checkMethod = "passwordNotWeak",additionalProperties = "result.username")
    @Pattern(message = "common_auto.password.format",regexp = FormValidRegExps.LOGIN_PWD)
    public String getResult_password() {
        return result_password;
    }

    public void setResult_password(String result_password) {
        this.result_password = result_password;
    }

    @NotNull
    public Integer getResult_agentId() {
        return result_agentId;
    }

    public void setResult_agentId(Integer result_agentId) {
        this.result_agentId = result_agentId;
    }

    @NotNull
    public Integer getResult_rankId() {
        return result_rankId;
    }

    public void setResult_rankId(Integer result_rankId) {
        this.result_rankId = result_rankId;
    }

    //endregion your codes

}