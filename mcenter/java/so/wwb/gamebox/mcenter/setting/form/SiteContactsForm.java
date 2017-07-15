package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;


/**
 * 系统联系人表表单验证对象
 *
 * @author loong
 * @time 2015-8-11 11:18:15
 */
//region your codes 1
public class SiteContactsForm implements IForm {
//endregion your codes 1

    //region your codes 2
    /** 姓名 */
    private String name;
    /** 邮箱 */
    private String mail;
    /** 手机号 */
    private String phone;
    /** 职位表id（sys_contacts_position） */
    private String positionId;
    /** 性别 */
    private String sex;

    @NotBlank()
    @Length(min = 1,max = 10)
    public String getName() {
        return name;
    }
    @NotBlank()
    @Pattern(regexp = FormValidRegExps.EMAIL)
    @Length(min = 1,max = 50)
    public String getMail() {
        return mail;
    }
    @NotBlank()
    @Pattern(regexp = FormValidRegExps.NUMBER_PHONE)
    public String getPhone() {
        return phone;
    }
    @NotBlank()
    public String getPositionId() {
        return positionId;
    }

    public String getSex() {
        return sex;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setPositionId(String positionId) {
        this.positionId = positionId;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }
//endregion your codes 2

}