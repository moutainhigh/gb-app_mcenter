package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;
import so.wwb.gamebox.mcenter.player.controller.SimulationAccountController;

import javax.validation.constraints.Max;
import javax.validation.constraints.Pattern;


/**
 * 查询表单验证对象
 *
 * Created by snekey using soul-code-generator on 2015-6-19 13:51:46
 */
public class SimulationAddNewPlayerForm implements IForm {

    //region your codes

    private String sysUser_username;

    private String sysUser_password;

    private String result_walletBalance;

    @NotBlank(message = "common_auto.username.notBlank")
    @Pattern(regexp = FormValidRegExps.ACCOUNT,message = "common_auto.username.format")
    @Remote(message = "common_auto.username.exist",checkMethod = "checkUserNameExist",checkClass = SimulationAccountController.class,additionalProperties = "accountSiteId")
    public String getSysUser_username() {
        return sysUser_username;
    }

    public void setSysUser_username(String sysUser_username) {
        this.sysUser_username = sysUser_username;
    }

    @NotBlank(message = "common_auto.password.notBlank")
    @Remote(message = "common_auto.passport.tooEasy",checkClass = SimulationAccountController.class,checkMethod = "passwordNotWeak",additionalProperties = "sysUser.username")
    @Pattern(message = "common_auto.password.format",regexp = FormValidRegExps.LOGIN_PWD)
    public String getSysUser_password() {
        return sysUser_password;
    }

    public void setSysUser_password(String sysUser_password) {
        this.sysUser_password = sysUser_password;
    }

    @NotBlank(message = "fund.ManualDepositForm.rechargeAmount.notBlank")
    @Pattern(regexp = FormValidRegExps.MONEY, message = "fund_auto.金额格式不正确")
    @Max(value = 1000000, message = "fund.小于一百万")
    public String getResult_walletBalance() {
        return result_walletBalance;
    }

    public void setResult_walletBalance(String result_walletBalance) {
        this.result_walletBalance = result_walletBalance;
    }


    //endregion your codes

}