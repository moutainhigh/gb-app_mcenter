package so.wwb.gamebox.mcenter.content.form;


import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;


/**
 * 站长域名表-修改完会替换 sys_domain表单验证对象
 *
 * @author jeff
 * @time 2015-8-20 9:21:53
 */
//region your codes 1
public class SysDomainMainManagerEditForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String result_name;

    @NotBlank
    @Length(message = "content.domain.nameLength",max = 10,min = 1)
    public String getResult_name() {
        return result_name;
    }

    public void setResult_name(String result_name) {
        this.result_name = result_name;
    }


}