package so.wwb.gamebox.mcenter.fund.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.query.enums.Operator;
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
    private String favorable_favorableTotalAmount;
    private String favorable_auditFavorableMultiple;

    @NotBlank(message = "fund.ManualDepositForm.userNames.notBlank")
    @Pattern(message = "fund.ManualDepositForm.userNames.Pattern", regexp = FormValidRegExps.ENGLISH_NUMBER_COMMA)
    public String get$userNames() {
        return $userNames;
    }

    public void set$userNames(String $userNames) {
        this.$userNames = $userNames;
    }

    @NotBlank(message = "fund.ManualDepositForm.rechargeAmount.notBlank")
    @Pattern(regexp = FormValidRegExps.MONEY, message = "fund_auto.金额格式不正确")
    @Max(value = 99999999, message = "fund.ManualDepositForm.rechargeAmount.Max")
    public String getResult_rechargeAmount() {
        return result_rechargeAmount;
    }

    public void setResult_rechargeAmount(String result_rechargeAmount) {
        this.result_rechargeAmount = result_rechargeAmount;
    }

    @Depends(message = "fund.ManualDepositForm.auditMultiple.notBlank", property = {"auditType"}, value = {"0"}, operator = {Operator.NE}, jsValueExp = "$(\"input[name=auditType]:checked\").val()")
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

    @Pattern(regexp = FormValidRegExps.MONEY, message = "fund_auto.金额格式不正确")
    public String getFavorable_favorableTotalAmount() {
        return favorable_favorableTotalAmount;
    }

    public void setFavorable_favorableTotalAmount(String favorable_favorableTotalAmount) {
        this.favorable_favorableTotalAmount = favorable_favorableTotalAmount;
    }

    @Digits(integer = 3,fraction = 2)
    @Max(value = 100)
    public String getFavorable_auditFavorableMultiple() {
        return favorable_auditFavorableMultiple;
    }

    public void setFavorable_auditFavorableMultiple(String favorable_auditFavorableMultiple) {
        this.favorable_auditFavorableMultiple = favorable_auditFavorableMultiple;
    }
}
