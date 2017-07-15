package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.support.RegExpConstants;
import org.soul.web.support.IForm;

import javax.validation.constraints.Pattern;


/**
 * 红包内定表表单验证对象
 *
 * @author Administrator
 * @time 2017-3-29 9:08:44
 */
//region your codes 1
public class ActivityMoneyDefaultWinForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String $usernames;

    private String result_activityMoneyAwardsRulesId;

    private String result_winCount;

    @NotBlank
    public String get$usernames() {
        return $usernames;
    }

    public void set$usernames(String $usernames) {
        this.$usernames = $usernames;
    }
    @NotBlank
    public String getResult_activityMoneyAwardsRulesId() {
        return result_activityMoneyAwardsRulesId;
    }

    public void setResult_activityMoneyAwardsRulesId(String result_activityMoneyAwardsRulesId) {
        this.result_activityMoneyAwardsRulesId = result_activityMoneyAwardsRulesId;
    }
    @NotBlank
    @Pattern(regexp = RegExpConstants.POSITIVE_INTEGER,message = "common.POSITIVE_INTEGER")
    public String getResult_winCount() {
        return result_winCount;
    }

    public void setResult_winCount(String result_winCount) {
        this.result_winCount = result_winCount;
    }

    //endregion your codes 2

}