package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;

/**
 * Created by bruce on 16-4-26.
 */
public class ActivityRuleForm implements IForm{

    private String rank;

    @NotBlank(message = "operation_auto.请选择参与层级")
    public String getRank() {
        return rank;
    }

    public void setRank(String rank) {
        this.rank = rank;
    }
}
