package so.wwb.gamebox.mcenter.fund.form;

import org.hibernate.validator.constraints.Length;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;

/**
 * Created by cherry on 16-9-7.
 */
@Comment("存款备注验证")
public class DepositRemarkForm implements IForm{
    private String result_checkRemark;

    @Length(max = 200)
    public String getResult_checkRemark() {
        return result_checkRemark;
    }

    public void setResult_checkRemark(String result_checkRemark) {
        this.result_checkRemark = result_checkRemark;
    }
}
