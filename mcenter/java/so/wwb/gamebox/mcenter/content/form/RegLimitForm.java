package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.Range;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;


/**
 * 内容管理-LOGO表表单验证对象
 *
 * @author snekey
 * @time 2015-8-3 9:56:48
 */
//region your codes 1
public class RegLimitForm implements IForm {
//endregion your codes 1

    //region your codes 2
    //ip注册间隔时间限制
    private String $ipRegIntervalParam_paramValue;
    //同一 IP 在 24 小时允许注册的最大次数
    private String $ipDayMaxRegNumParam_paramValue;
    //注册地址
    private String $regAddress;

    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE,message = "common.ZERO_POSITIVE")
    @Length(max=4)
    @Range(max = 24,min = 0,message = "setting.playerSetting.0-24")
    public String get$ipRegIntervalParam_paramValue() {
        return $ipRegIntervalParam_paramValue;
    }
    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE_INTEGER,message = "common.ZERO_POSITIVE_INTEGER")
    @Range(min = 0,max = 99999999)
    public String get$ipDayMaxRegNumParam_paramValue() {
        return $ipDayMaxRegNumParam_paramValue;
    }
    public String get$regAddress() {
        return $regAddress;
    }

    public void set$ipRegIntervalParam_paramValue(String $ipRegIntervalParam_paramValue) {
        this.$ipRegIntervalParam_paramValue = $ipRegIntervalParam_paramValue;
    }

    public void set$ipDayMaxRegNumParam_paramValue(String $ipDayMaxRegNumParam_paramValue) {
        this.$ipDayMaxRegNumParam_paramValue = $ipDayMaxRegNumParam_paramValue;
    }

    public void set$regAddress(String $regAddress) {
        this.$regAddress = $regAddress;
    }
    //endregion your codes 2

}