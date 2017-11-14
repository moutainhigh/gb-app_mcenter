package so.wwb.gamebox.mcenter.lottery.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.lottery.controller.SiteLotteryOddsController;

import javax.validation.constraints.*;

/**
 * Created by fei on 17-4-7.
 */
public class SiteLotteryOddsForm implements IForm {
    private String[] lotteryOdds$$_odd;
    private String[] lotteryOdds$$_rebate;

    @NotBlank(message = "common.赔率不能为空")
    @Min(message = "赔率不能小于1", value = 1)
    @Pattern(message = "格式错误", regexp = "^[0-9]\\d*(\\.\\d{1,3})?$")
    @Digits(integer = 7,fraction = 3)
    public String[] getLotteryOdds$$_odd() {
        return lotteryOdds$$_odd;
    }

    public void setLotteryOdds$$_odd(String[] lotteryOdds$$_odd) {
        this.lotteryOdds$$_odd = lotteryOdds$$_odd;
    }

    @NotBlank(message = "common.赔率不能为空")
    @Pattern(message = "格式错误", regexp = "^[0-9]\\d*(\\.\\d{1,3})?$")
    @Digits(integer = 1,fraction = 3)
    public String[] getLotteryOdds$$_rebate() {
        return lotteryOdds$$_rebate;
    }

    public void setLotteryOdds$$_rebate(String[] lotteryOdds$$_rebate) {
        this.lotteryOdds$$_rebate = lotteryOdds$$_rebate;
    }
}
