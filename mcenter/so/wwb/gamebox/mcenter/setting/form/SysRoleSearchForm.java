package so.wwb.gamebox.mcenter.setting.form;


import org.soul.web.support.IForm;


/**
 * 系统角色查询表单验证对象
 *
 * @author by tom
 * @date 2015-7-10 16:37:31
 */
public class SysRoleSearchForm implements IForm {
    private String name;

    public SysRoleSearchForm() {
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

}