package so.wwb.gamebox.mcenter.content.form;

import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.AtLeast;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;

/**
 * Created by cj on 15-8-24.
 */
public class WarningOfUnusualForm implements IForm {
    private String[] pv$$_v1;
    private String[] pv$$_v2;
    private String[] pv$$_v3;
    private String[] pv$$_paramValue;

    private String p11_active;
    private String p12_active;

    @Comment("开启情况一时判断：时间")
    @Depends(property = "p11_active", operator = Operator.EQ, value = "true", jsValueExp = "$('[name=\"p11.active\"]:checked').val()=='true'", message = "content.floatPic.validate.singleLinkValue")
    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER)
    public String[] getPv$$_v1() {
        return pv$$_v1;
    }

    public void setPv$$_v1(String[] pv$$_v1) {
        this.pv$$_v1 = pv$$_v1;
    }

    @Comment("开启情况一时判断：玩家个数")
    @Depends(property = "p11_active", operator = Operator.EQ, value = "true", jsValueExp = "$('[name=\"p11.active\"]:checked').val()=='true'", message = "content.floatPic.validate.singleLinkValue")
    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER)
    public String[] getPv$$_v2() {
        return pv$$_v2;
    }

    public void setPv$$_v2(String[] pv$$_v2) {
        this.pv$$_v2 = pv$$_v2;
    }

    @Comment("开启情况一时判断：失败次数")
    @Depends(property = "p11_active", operator = Operator.EQ, value = "true", jsValueExp = "$('[name=\"p11.active\"]:checked').val()=='true'", message = "content.floatPic.validate.singleLinkValue")
    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER)
    public String[] getPv$$_v3() {
        return pv$$_v3;
    }

    public void setPv$$_v3(String[] pv$$_v3) {
        this.pv$$_v3 = pv$$_v3;
    }

    @Comment("开启情况一时判断：时间")
    @Depends(property = "p12_active", operator = Operator.EQ, value = "true", jsValueExp = "$('input[name=\"p12.active\"]:checked').val()=='true'", message = "content.floatPic.validate.singleLinkValue")
    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER)
    public String[] getPv$$_paramValue() {
        return pv$$_paramValue;
    }

    public void setPv$$_paramValue(String[] pv$$_paramValue) {
        this.pv$$_paramValue = pv$$_paramValue;
    }

    @AtLeast(groups =ValidActive.class,message = "content.payAccount.atLeastOneCase",jsValueExp = "$(\"input[name=\''p11.active\'']:checked\")")
    public String getP11_active() {
        return p11_active;
    }

    public void setP11_active(String p11_active) {
        this.p11_active = p11_active;
    }

    @AtLeast(groups =ValidActive.class,message = "content.payAccount.atLeastOneCase",jsValueExp = "$(\"input[name=\''p12.active\'']:checked\")")
    public String getP12_active() {
        return p12_active;
    }

    public void setP12_active(String p12_active) {
        this.p12_active = p12_active;
    }

    interface ValidActive{

    }
}