package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.Length;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;

import javax.validation.constraints.Pattern;


/**
 * 表单验证对象
 * <p/>
 * Created by snekey using soul-code-generator on 2015-6-19 13:51:46
 */
@Comment("新增玩家")
//@Compare(message = "11",logic = CompareLogic.EQ,property = "sysUser_password",anotherProperty = "confirmpwd")
//FIXME by cj 后面确认一下怎么验证
//FIXME by cj 按规范来，加上@Comment
//TODO 多表存储验证暂时无法实现
public class UserPlayerUpdateForm implements IForm {

    //region your codes
    private String mail;
    private String mobilePhone;
    private String realName;

    public String getMail() {
        return mail;
    }

    @Pattern(regexp = "^\\+?[1-9][0-9]*$", message = "player.edit.form.mobilePhone")
    @Length(message = "player.edit.form.mobilePhoneMax", max = 20)
    public String getMobilePhone() {
        return mobilePhone;
    }

    @Length(message = "player.edit.form.maxChar", max = 20)
    public String getRealName() {
        return realName;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }
    //endregion your codes

}