package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;

/**
 * 验证数字货币帐号
 * Created by cherry on 17-10-10.
 */
@Comment("验证数字货币帐号")
public class DigiccyAccountForm implements IForm {
    /**
     * 数字货币账号(或者是邮箱帐号，现在暂且用邮箱账号注册)
     */
    private String $account;
    /**
     * 密码
     */
    private String $pwd;
    /**
     * 渠道
     */
    private String $code;
    /**
     * 状态
     */
    private String $status;

    @NotBlank
    @Comment("账号")
    public String get$account() {
        return $account;
    }

    public void set$account(String $account) {
        this.$account = $account;
    }

    @NotBlank
    @Comment("密码")
    public String get$pwd() {
        return $pwd;
    }

    public void set$pwd(String $pwd) {
        this.$pwd = $pwd;
    }

    @NotBlank
    @Comment("渠道")
    public String get$code() {
        return $code;
    }

    public void set$code(String $code) {
        this.$code = $code;
    }

    @NotBlank
    @Comment("状态")
    public String get$status() {
        return $status;
    }

    public void set$status(String $status) {
        this.$status = $status;
    }
}
