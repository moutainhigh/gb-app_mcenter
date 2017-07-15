package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.Length;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;

/**
 * Created by bruce on 16-12-17.
 */
@Comment("站点参数验证码表单验证")
public class CaptchaForm implements IForm {

    private String $exclusionsValue;

    @Pattern(message = "setting_auto.请输入英文字母和数字",regexp = FormValidRegExps.ENGLISH_NUMBER)
    @Length(max = 34,message = "setting_auto.请勿把所有的字母和数字都排除掉")
    @Comment("验证码")
    public String get$exclusionsValue() {
        return $exclusionsValue;
    }

    public void set$exclusionsValue(String $exclusionsValue) {
        this.$exclusionsValue = $exclusionsValue;
    }
}
