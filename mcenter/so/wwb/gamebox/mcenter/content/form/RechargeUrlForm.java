package so.wwb.gamebox.mcenter.content.form;

import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;

/**
 * Created by cherry on 17-4-14.
 */
@Comment("快速充值链接验证")
public class RechargeUrlForm implements IForm {
    private String $paramValue;

    @Pattern(message = "content.rechargeUlrForm.paramValue.pattern", regexp = FormValidRegExps.PREFIX_LINK)
    public String get$paramValue() {
        return $paramValue;
    }

    public void set$paramValue(String $paramValue) {
        this.$paramValue = $paramValue;
    }
}
