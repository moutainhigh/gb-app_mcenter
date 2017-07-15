package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;
import so.wwb.gamebox.mcenter.player.controller.PlayerController;

import javax.validation.constraints.Pattern;

/**
 * 用户银行卡验证
 */
//region your codes 1
@Comment("编辑银行卡")
public class UserBankcardForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String result_id;
    private String result_userId;
    private String result_bankcardMasterName;
    private String result_bankName;
    private String result_bankcardNumber;
    private String result_bankDeposit;

    public String getResult_id() {
        return result_id;
    }

    public void setResult_id(String result_id) {
        this.result_id = result_id;
    }

    //    @NotBlank
//    @Pattern(message = "player.bankCardCorrect",regexp = FormValidRegExps.DIGITS)
//    @Remote(message = "player.bankCardCorrect", checkClass = PlayerController.class, checkMethod = "checkBankcardNumber", additionalProperties = "result.bankName")

    @NotBlank(message = "player_auto.请输入10")
    @Length(min = 10,max = 25)
    @Pattern(message = "player_auto.银行卡格式错误",regexp = FormValidRegExps.BANK)
    @Remote(message = "player_auto.已存在相同银行卡号",checkMethod = "checkBankcardIsExist",checkClass = PlayerController.class,
            additionalProperties = {"result.id","result.bankName","result.userId"})
    @Comment("银行卡号")
    public String getResult_bankcardNumber() {
        return result_bankcardNumber;
    }

    public void setResult_bankcardNumber(String result_bankcardNumber) {
        this.result_bankcardNumber = result_bankcardNumber;
    }

    @NotBlank(message = "player_auto.请选择银行")
    public String getResult_bankName() {
        return result_bankName;
    }

    public void setResult_bankName(String result_bankName) {
        this.result_bankName = result_bankName;
    }

    @Depends(property ={"result_bankName"}, operator = {Operator.EQ}, value = {"other_bank"})
    @Length(max = 200)
    public String getResult_bankDeposit() {
        return result_bankDeposit;
    }

    public void setResult_bankDeposit(String result_bankDeposit) {
        this.result_bankDeposit = result_bankDeposit;
    }
    @NotBlank
    public String getResult_bankcardMasterName() {
        return result_bankcardMasterName;
    }

    public void setResult_bankcardMasterName(String result_bankcardMasterName) {
        this.result_bankcardMasterName = result_bankcardMasterName;
    }
    @NotBlank
    public String getResult_userId() {
        return result_userId;
    }

    public void setResult_userId(String result_userId) {
        this.result_userId = result_userId;
    }
//endregion your codes 2

}