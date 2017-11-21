package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;


/**
 * 充值记录查询视图表单验证对象
 *
 * @author leo
 * @time 2017-11-15 20:19:43
 */
//region your codes 1
public class VCreditRecordForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String reslut_path;
    @NotBlank
    public String getReslut_path() {
        return reslut_path;
    }

    public void setReslut_path(String reslut_path) {
        this.reslut_path = reslut_path;
    }
    //endregion your codes 2

}