package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.content.controller.WithdrawAccountController;


/**
 * 出款(代付)账户表表单验证对象
 *
 * @author linsen
 * @time 2018-8-10 14:57:24
 */
//region your codes 1
public class WithdrawAccountForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String result_id;
    /**
     * 账户名称
     */
    private String result_withdrawName;
    /**
     * 账号
     */
    private String result_account;
    /**
     * 渠道(bank表的bank_name）
     */
    private String result_bankCode;
    /**
     * 第三方接口的参数json[{column:"字段",value:"值"}]
     */
    private String $channelJson;
    private String $onLinePay;


    @NotBlank
    @Length(min = 1, max = 20)
    @Remote(message = "content.payaccount.name.exist", checkClass = WithdrawAccountController.class, checkMethod = "checkWithdrawName", additionalProperties = {"result.id", "result.bankCode"})
    public String getResult_withdrawName() {
        return result_withdrawName;
    }

    @NotBlank
    @Length(min = 1, max = 40)
    @Remote(checkClass = WithdrawAccountController.class, checkMethod = "checkChannel", additionalProperties = {"result.bankCode", "result.account", "result.id"}, message = "content_auto.该渠道的账号已存在")
    public String getResult_account() {
        return result_account;
    }


    @NotBlank(message = "content.payAccount.selectOne")
    public String getResult_bankCode() {
        return result_bankCode;
    }

    @NotBlank
    public String get$channelJson() {
        return $channelJson;
    }

    public String get$onLinePay() {
        return $onLinePay;
    }

    public void set$channelJson(String $channelJson) {
        this.$channelJson = $channelJson;
    }

    public void setResult_withdrawName(String result_withdrawName) {
        this.result_withdrawName = result_withdrawName;
    }

    public void setResult_account(String result_account) {
        this.result_account = result_account;
    }

    public void setResult_bankCode(String result_bankCode) {
        this.result_bankCode = result_bankCode;
    }

    public void set$onLinePay(String $onLinePay) {
        this.$onLinePay = $onLinePay;
    }

    public String getResult_id() {
        return result_id;
    }

    public void setResult_id(String result_id) {
        this.result_id = result_id;
    }
    //endregion your codes 2

}