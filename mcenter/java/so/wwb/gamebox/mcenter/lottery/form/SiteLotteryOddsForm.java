package so.wwb.gamebox.mcenter.lottery.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.lottery.controller.SiteLotteryOddsController;

import javax.validation.constraints.Digits;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;

/**
 * Created by fei on 17-4-7.
 */
public class SiteLotteryOddsForm implements IForm {
    private String[] lotteryOdds$$_odd;
    private String[] lotteryOdds$$_rebate;

    @NotBlank(message = "common.赔率不能为空")
//    @Pattern(message = "player_auto.请输入数字", regexp = "^[1-9]\\d*(\\.\\d+)?$")
//    @Min(message = "player_auto.请输入数字", value = 1)
    @Digits(integer = 7,fraction = 3)
    public String[] getLotteryOdds$$_odd() {
        return lotteryOdds$$_odd;
    }

    public void setLotteryOdds$$_odd(String[] lotteryOdds$$_odd) {
        this.lotteryOdds$$_odd = lotteryOdds$$_odd;
    }

    @NotBlank(message = "common.赔率不能为空")
//    @Pattern(message = "player_auto.请输入数字", regexp = "^[1-9]\\d*(\\.\\d+)?$")
//    @Min(message = "player_auto.请输入数字", value = 1)
    @Digits(integer = 7,fraction = 3)
    public String[] getLotteryOdds$$_rebate() {
        return lotteryOdds$$_rebate;
    }

    public void setLotteryOdds$$_rebate(String[] lotteryOdds$$_rebate) {
        this.lotteryOdds$$_rebate = lotteryOdds$$_rebate;
    }
}
