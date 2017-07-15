package so.wwb.gamebox.mcenter.share.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.web.support.IForm;

/**
 * Created by jeff on 15-12-22.
 */
public class AccountOptionForm implements IForm {

    private String $groupCode;
    private String $hasReason;

    //@NotBlank(message = "请选择原因！")
    @Depends(message = "share_auto.请选择原因",operator = Operator.IS_NOT_EMPTY,value = "",property = "$hasReason")
    public String get$groupCode() {
        return $groupCode;
    }

    public void set$groupCode(String $groupCode) {
        this.$groupCode = $groupCode;
    }

    public String get$hasReason() {
        return $hasReason;
    }

    public void set$hasReason(String $hasReason) {
        this.$hasReason = $hasReason;
    }
}
