package so.wwb.gamebox.mcenter.setting.form;


import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.setting.controller.MSysRoleController;


/**
 * 系统角色表单验证对象
 *
 * Created by tom using soul-code-generator on 2015-7-10 16:37:31
 */
//region your codes 1
public class SysRoleForm implements IForm {
//endregion your codes 1

    //region your codes 2
    /** 角色名称 */
    private String result_name;

    /** 角色编号 */
    private String result_code;

    @NotBlank(message = "setting_auto.角色名称不能为空")
    @Length(min = 1,max = 10,message = "setting_auto.角色名称长度1-10个字符")
    @Comment("角色名称")
    @Remote(message = "setting_auto.角色名称已经存在",checkClass = MSysRoleController.class,checkMethod = "checkSameRoleName")
    public String getResult_name() {
        return result_name;
    }

    public void setResult_name(String result_name) {
        this.result_name = result_name;
    }

    public String getResult_code() {
        return result_code;
    }

    public void setResult_code(String result_code) {
        this.result_code = result_code;
    }

    //endregion your codes 2

}