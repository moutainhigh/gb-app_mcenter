package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;
import so.wwb.gamebox.mcenter.fund.controller.WithdrawController;

import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;


/**
 * 玩家交易表表单验证对象
 *
 * Created by cheery using soul-code-generator on 2015-6-23 11:41:43
 */
public class PlayerTransactionForm implements IForm {

    //region your codes
    private Integer[] feeList$$_id;
    private Double[] feeList$$_administrativeFee;
    private Double[] feeList$$_maxAdministrativeFee;

    private Double[] feeList$$_deductFavorable;
    private Double[] feeList$$_maxDeductFavorable;
    private String $remarkContent;

    @NotBlank
    @Pattern(regexp = FormValidRegExps.DECIMAL)
    @Remote(additionalProperties = {"id","maxValue"},jsValueExp = {"$(\"[name='feeList[\"+page.rowIndex+\"].id']\").val()","$(\"[name='feeList[\"+page.rowIndex+\"].maxAdministrativeFee']\").val()"},
            message = "player_auto.不能超过最大值",checkMethod = "checkMaxValue",checkClass = WithdrawController.class)
    @Min(value = 0)
    public Double[] getFeeList$$_administrativeFee() {
        return feeList$$_administrativeFee;
    }

    public void setFeeList$$_administrativeFee(Double[] feeList$$_administrativeFee) {
        this.feeList$$_administrativeFee = feeList$$_administrativeFee;
    }

    public Double[] getFeeList$$_maxAdministrativeFee() {
        return feeList$$_maxAdministrativeFee;
    }

    public void setFeeList$$_maxAdministrativeFee(Double[] feeList$$_maxAdministrativeFee) {
        this.feeList$$_maxAdministrativeFee = feeList$$_maxAdministrativeFee;
    }

    @NotBlank
    @Pattern(regexp = FormValidRegExps.DECIMAL)
    @Remote(additionalProperties = {"id","maxValue"},jsValueExp = {"$(\"[name='feeList[\"+page.rowIndex+\"].id']\").val()","$(\"[name='feeList[\"+page.rowIndex+\"].maxDeductFavorable']\").val()"},
            message = "player_auto.不能超过最大值",checkMethod = "checkMaxValue",checkClass = WithdrawController.class)
    @Min(value = 0)
    public Double[] getFeeList$$_deductFavorable() {
        return feeList$$_deductFavorable;
    }

    public void setFeeList$$_deductFavorable(Double[] feeList$$_deductFavorable) {
        this.feeList$$_deductFavorable = feeList$$_deductFavorable;
    }

    public Double[] getFeeList$$_maxDeductFavorable() {
        return feeList$$_maxDeductFavorable;
    }

    public void setFeeList$$_maxDeductFavorable(Double[] feeList$$_maxDeductFavorable) {
        this.feeList$$_maxDeductFavorable = feeList$$_maxDeductFavorable;
    }

    public Integer[] getFeeList$$_id() {
        return feeList$$_id;
    }

    public void setFeeList$$_id(Integer[] feeList$$_id) {
        this.feeList$$_id = feeList$$_id;
    }

    @Comment("备注")
    @Length(max = 200)
    public String get$remarkContent() {
        return $remarkContent;
    }

    public void set$remarkContent(String $remarkContent) {
        this.$remarkContent = $remarkContent;
    }

    //endregion your codes

}