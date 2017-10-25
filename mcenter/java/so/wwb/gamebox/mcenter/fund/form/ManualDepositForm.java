package so.wwb.gamebox.mcenter.fund.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.AtLeast;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Digits;
import javax.validation.constraints.Max;
import javax.validation.constraints.Pattern;

/**
 * Created by cherry on 16-7-20.
 */
@Comment("手工存取验证")
public class ManualDepositForm implements IForm {
    private String $userNames;
    private String result_rechargeAmount;
    private String auditMultiple;
    private String result_checkRemark;
    private String playerFavorable_favorable;
    private String playerFavorable_auditFavorableMultiple;

    @NotBlank(message = "fund.ManualDepositForm.userNames.notBlank")
    @Pattern(message = "fund.ManualDepositForm.userNames.Pattern", regexp = FormValidRegExps.ENGLISH_NUMBER_COMMA)
    public String get$userNames() {
        return $userNames;
    }

    public void set$userNames(String $userNames) {
        this.$userNames = $userNames;
    }

    @AtLeast(message = "存款金额和优惠金额不能同时为空", groups = {rechargeFavorableAtLeast.class})
    @Pattern(regexp = FormValidRegExps.MONEY, message = "fund_auto.金额格式不正确")
    @Max(value = 99999999, message = "fund.ManualDepositForm.rechargeAmount.Max")
    public String getResult_rechargeAmount() {
        return result_rechargeAmount;
    }

    public void setResult_rechargeAmount(String result_rechargeAmount) {
        this.result_rechargeAmount = result_rechargeAmount;
    }

    @Depends(message = "fund.ManualDepositForm.auditMultiple.notBlank", property = {"result.isAuditRecharge", "result.rechargeAmount"}, value = {"true", ""}, operator = {Operator.EQ, Operator.IS_NOT_NULL}, jsValueExp = {"$(\"input[name='result.isAuditRecharge']:checked\").val()=='true'", "$(\"input[name='result.rechargeAmount']\").val()"})
    @Pattern(regexp = FormValidRegExps.MONEY, message = "fund.ManualDepositForm.auditMultiple.Pattern")
    @Max(value = 100, message = "fund.ManualDepositForm.auditMultiple.Pattern")
    public String getAuditMultiple() {
        return auditMultiple;
    }

    public void setAuditMultiple(String auditMultiple) {
        this.auditMultiple = auditMultiple;
    }

    @Length(max = 200, message = "fund.ManualDepositForm.checkRemark.length")
    public String getResult_checkRemark() {
        return result_checkRemark;
    }

    public void setResult_checkRemark(String result_checkRemark) {
        this.result_checkRemark = result_checkRemark;
    }

    @AtLeast(message = "存款金额和优惠金额不能同时为空", groups = {rechargeFavorableAtLeast.class})
    @Pattern(regexp = FormValidRegExps.MONEY, message = "fund_auto.金额格式不正确")
    @Max(value = 99999999)
    public String getPlayerFavorable_favorable() {
        return playerFavorable_favorable;
    }

    public void setPlayerFavorable_favorable(String playerFavorable_favorable) {
        this.playerFavorable_favorable = playerFavorable_favorable;
    }

    @Depends(property = {"playerFavorable.isAuditFavorable", "playerFavorable.favorable"}, value = {"true", ""}, operator = {Operator.EQ, Operator.IS_NOT_NULL}, jsValueExp = {"$(\"input[name='playerFavorable.isAuditFavorable']:checked\").val()=='true'", "$(\"input[name='playerFavorable.favorable']\").val()"})
    @Digits(integer = 3, fraction = 2)
    @Max(value = 100)
    public String getPlayerFavorable_auditFavorableMultiple() {
        return playerFavorable_auditFavorableMultiple;
    }

    public void setPlayerFavorable_auditFavorableMultiple(String playerFavorable_auditFavorableMultiple) {
        this.playerFavorable_auditFavorableMultiple = playerFavorable_auditFavorableMultiple;
    }

    interface rechargeFavorableAtLeast {

    }
}
