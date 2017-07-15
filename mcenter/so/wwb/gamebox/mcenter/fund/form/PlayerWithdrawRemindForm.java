package so.wwb.gamebox.mcenter.fund.form;

import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;


/**
 *
 */
//region your codes 1
public class PlayerWithdrawRemindForm implements IForm {
//endregion your codes 1

    //region your codes 2
	private String $active;
	private String $paramValue;

	public String get$active() {
		return $active;
	}

	public void set$active(String $active) {
		this.$active = $active;
	}

	@Depends(property = "$active", operator = Operator.EQ, value = {"true"}, jsValueExp = "$(\"[name=\\'active\\']\").val()=='true'", message = "fund_auto.提醒倍数不能为空")
	@Pattern(regexp = FormValidRegExps.POSITIVE,message = "fund_auto.仅限输入纯数字")
	@Min(value = 1,message = "fund_auto.仅限输入纯数字")
	@Max(value = 100,message = "fund_auto.仅限输入纯数字")
	public String get$paramValue() {
		return $paramValue;
	}

	public void set$paramValue(String $paramValue) {
		this.$paramValue = $paramValue;
	}
	//endregion your codes 2

}