package so.wwb.gamebox.mcenter.fund.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;

import javax.validation.constraints.Pattern;


/**
 * 表单验证对象
 *
 * Created by orange using soul-code-generator on 2015-7-14 15:20:49
 */
//region your codes 1
public class VPlayerWithdrawForm implements IForm {

    /** 扣除优惠 */
    private Double $deductFavorable;
    /** 扣除行政费 */
    private Double $administrativeFee;

    @NotBlank
    @Comment("扣除优惠")
    @Pattern(regexp = "^[0-9]\\d*$", message = "fund.playerWithdrawForm.deductFavorable.notBlank")
    public Double get$deductFavorable() {
        return $deductFavorable;
    }

    public void set$deductFavorable(Double $deductFavorable) {
        this.$deductFavorable = $deductFavorable;
    }

    @NotBlank
    @Comment("扣除行政费")
    @Pattern(regexp = "^[0-9]\\d*$", message = "fund.playerWithdrawForm.administrativeFee.notBlank")
    public Double get$administrativeFee() {
        return $administrativeFee;
    }

    public void set$administrativeFee(Double $administrativeFee) {
        this.$administrativeFee = $administrativeFee;
    }
}