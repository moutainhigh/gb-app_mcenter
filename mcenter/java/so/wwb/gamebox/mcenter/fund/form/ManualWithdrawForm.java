package so.wwb.gamebox.mcenter.fund.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;
import so.wwb.gamebox.mcenter.fund.controller.ManualController;

import javax.validation.constraints.Max;
import javax.validation.constraints.Pattern;

/**
 * Created by cherry on 16-7-20.
 */
@Comment("人工取款验证")
public class ManualWithdrawForm implements IForm {
    private String username;
    private String result_withdrawAmount;
    private String result_checkRemark;

    @NotBlank(message = "fund.ManualWithdrawForm.username.notBlank")
    @Pattern(regexp = FormValidRegExps.ACCOUNT, message = "")
    @Remote(message = "fund.ManualWithdrawForm.username.remote", checkClass = ManualController.class, checkMethod = "checkUserName")
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @NotBlank(message = "fund.ManualWithdrawForm.withdrawAmount.notBlank")
    @Pattern(regexp = FormValidRegExps.MONEY, message = "fund.ManualWithdrawForm.withdrawAmount.Pattern")
    @Max(value = 99999999, message = "fund.ManualWithdrawForm.withdrawAmount.Max")
    @Remote(message = "fund.ManualWithdrawForm.withdrawAmount.Remote", checkClass = ManualController.class, checkMethod = "checkMoney", additionalProperties = {"username"})
    public String getResult_withdrawAmount() {
        return result_withdrawAmount;
    }

    public void setResult_withdrawAmount(String result_withdrawAmount) {
        this.result_withdrawAmount = result_withdrawAmount;
    }

    @Length(max = 200, message = "fund.ManualWithdrawForm.checkRemark.length")
    public String getResult_checkRemark() {
        return result_checkRemark;
    }

    public void setResult_checkRemark(String result_checkRemark) {
        this.result_checkRemark = result_checkRemark;
    }
}
