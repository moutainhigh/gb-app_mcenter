package so.wwb.gamebox.mcenter.player.form;

import org.soul.web.support.IForm;

import javax.validation.constraints.DecimalMax;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;


/**
 * 总代API占成表表单验证对象
 *
 * @author loong
 * @time 2015-9-6 9:25:05
 */
//region your codes 1
public class UserAgentApiForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private BigDecimal userAgentApis$$_ratio;
    private BigDecimal $batchSetInput;

    @Digits(integer = 100,fraction = 2,message = "player.topAgent.ratio.digits")
    @DecimalMax(value = "100",message = "player.topAgent.ratio.max")
    @DecimalMin(value = "0",message = "player.topAgent.ratio.min")
    @NotNull()
    public BigDecimal getUserAgentApis$$_ratio() {
        return userAgentApis$$_ratio;
    }

    public void setUserAgentApis$$_ratio(BigDecimal userAgentApis$$_ratio) {
        this.userAgentApis$$_ratio = userAgentApis$$_ratio;
    }

    @Digits(integer = 100,fraction = 2,message = "player.topAgent.ratio.digits")
    @DecimalMax(value = "100",message = "player.topAgent.ratio.max")
    @DecimalMin(value = "0",message = "player.topAgent.ratio.min")
//    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "请输入正确格式的占成")
    public BigDecimal get$batchSetInput() {
        return $batchSetInput;
    }

    public void set$batchSetInput(BigDecimal $batchSetInput) {
        this.$batchSetInput = $batchSetInput;
    }
    //endregion your codes 2

}