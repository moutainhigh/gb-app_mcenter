package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;

/**
 * Created by cj on 15-9-16.
 */
@Comment("分摊设置")
public class ApportionForm implements IForm {

    private String[] pv$$_paramValue;

    @Comment("非空&正数或小数")
    @NotBlank(message = "setting.apportion.number.notBlank")
    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE, message = "setting.apportion.number.positive")
    public String[] getPv$$_paramValue() {
        return pv$$_paramValue;
    }

    public void setPv$$_paramValue(String[] pv$$_paramValue) {
        this.pv$$_paramValue = pv$$_paramValue;
    }
}
