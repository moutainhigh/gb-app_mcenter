package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.constraints.Series;
import org.soul.commons.validation.form.support.SeriesType;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.*;
import java.math.BigDecimal;

/**
 * Created by ke on 15-9-16.
 */
public class RecommendedForm implements IForm {
    //region your codes 1
    /**
     * 推荐设置：优惠稽核
     */
    private String $audit_paramValue;
    /**
     * 推荐设置：推荐奖励方式：存款金额满
     */
    private String $rewardTheWay_paramValue;
    /**
     * 推荐设置：奖励金额
     */
    private String $rewardMoney_paramValue;
    /**
     * 推荐设置：有效玩家交易量
     */
    private String $bonusTrading_paramValue;
    /**
     *推荐设置：红利上限
     */
    private String $bonusBonusMax_paramValue;
    /**
     * 红利:优惠稽核
     */
    private String $bonusAudit_paramValue;


    /**
     * 推荐内容
     */
    private String[] siteI18nContentList$$_value;
    /**
     * 推荐规则
     */
    private String[] siteI18nRuleList$$_value;

    private Integer[] gradientTempList$$_playerNum;
    private BigDecimal[] gradientTempList$$_proportion;

    private String $isReward_active;

    private String $bonus_active;

    @NotNull(message = "common.不能为空")
    @Digits(integer = 3,fraction = 4,message = "setting.recommended.isinteger")
    @Range(max = 100,min = 0,message = "setting.recommended.max100")
    @Series(message = "setting.recommended.必须大于上一梯度",type = SeriesType.INC)
    public BigDecimal[] getGradientTempList$$_proportion() {
        return gradientTempList$$_proportion;
    }

    //@Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER,message = "setting.recommended.playerNum.POSITIVE_INTEGER")
    @NotNull(message = "common.不能为空")
    @Range(max = 999,min = 1,message = "setting.recommended.playerNum.POSITIVE_INTEGER")
    @Digits(integer = 3,fraction = 0,message = "setting.rebate.edit.validPlayerNumDigits")
    @Series(message = "setting.recommended.必须大于上一梯度",type = SeriesType.INC)
    public Integer[] getGradientTempList$$_playerNum() {
        return gradientTempList$$_playerNum;
    }

    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "setting.recommended.audit")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "100")
    @Digits(integer = 3,fraction = 2)
    public String get$audit_paramValue() {
        return $audit_paramValue;
    }


    public String get$isReward_active() {
        return $isReward_active;
    }

    public String get$bonus_active() {
        return $bonus_active;
    }

    @Depends(property ={"isReward.active"}, operator = {Operator.EQ}, value = {"true"}, jsValueExp ={"$(\"[name=\\'isReward.active\\']\").val()=='true'"})
    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE_INTEGER,message = "common.POSITIVE_INTEGER")
    @Min(1)
    @Max(99999999)
    public String get$rewardTheWay_paramValue() {
        return $rewardTheWay_paramValue;
    }

    @Depends(property ={"isReward.active"}, operator = {Operator.EQ}, value = {"true"}, jsValueExp ={"$(\"[name=\\'isReward.active\\']\").val()=='true'"})
    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "setting.recommended.moneyRange")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "99999999")
    @Digits(integer = 8,fraction = 2)
    public String get$rewardMoney_paramValue() {
        return $rewardMoney_paramValue;
    }




    @Depends(property ={"bonus.active"}, operator = {Operator.EQ}, value = {"true"}, jsValueExp ={"$(\"[name=\\'bonus.active\\']\").val()=='true'"})
    //@NotNull(message = "不能为空")
    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "setting.recommended.moneyRange")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "99999999")
    @Digits(integer = 8,fraction = 2)
    public String get$bonusTrading_paramValue() {
        return $bonusTrading_paramValue;
    }
    @Depends(property ={"bonus.active"}, operator = {Operator.EQ}, value = {"true"}, jsValueExp ={"$(\"[name=\\'bonus.active\\']\").val()=='true'"})
    //@NotNull(message = "不能为空")
    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "setting.recommended.moneyRange")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "99999999")
    @Digits(integer = 8,fraction = 2)
    public String get$bonusBonusMax_paramValue() {
        return $bonusBonusMax_paramValue;
    }

    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "setting.recommended.audit")
    @DecimalMin(value = "0.01")
    @DecimalMax(value = "100")
    @Digits(integer = 3,fraction = 2)
    public String get$bonusAudit_paramValue() {
        return $bonusAudit_paramValue;
    }

    @NotBlank
    @Length(max = 200)
    public String[] getSiteI18nContentList$$_value() {
        return siteI18nContentList$$_value;
    }
    @NotBlank
    @Length(max = 1000)
    public String[] getSiteI18nRuleList$$_value() {
        return siteI18nRuleList$$_value;
    }

    public void set$audit_paramValue(String $audit_paramValue) {
        this.$audit_paramValue = $audit_paramValue;
    }

    public void set$rewardTheWay_paramValue(String $rewardTheWay_paramValue) {
        this.$rewardTheWay_paramValue = $rewardTheWay_paramValue;
    }

    public void set$rewardMoney_paramValue(String $rewardMoney_paramValue) {
        this.$rewardMoney_paramValue = $rewardMoney_paramValue;
    }

    public void set$bonusTrading_paramValue(String $bonusTrading_paramValue) {
        this.$bonusTrading_paramValue = $bonusTrading_paramValue;
    }

    public void set$bonusBonusMax_paramValue(String $bonusBonusMax_paramValue) {
        this.$bonusBonusMax_paramValue = $bonusBonusMax_paramValue;
    }

    public void setSiteI18nContentList$$_value(String[] siteI18nContentList$$_value) {
        this.siteI18nContentList$$_value = siteI18nContentList$$_value;
    }

    public void set$isReward_active(String $isReward_active) {
        this.$isReward_active = $isReward_active;
    }

    public void set$bonus_active(String $bonus_active) {
        this.$bonus_active = $bonus_active;
    }

    public void setSiteI18nRuleList$$_value(String[] siteI18nRuleList$$_value) {
        this.siteI18nRuleList$$_value = siteI18nRuleList$$_value;
    }

    public void setGradientTempList$$_playerNum(Integer[] gradientTempList$$_playerNum) {
        this.gradientTempList$$_playerNum = gradientTempList$$_playerNum;
    }

    public void set$bonusAudit_paramValue(String $bonusAudit_paramValue) {
        this.$bonusAudit_paramValue = $bonusAudit_paramValue;
    }

    public void setGradientTempList$$_proportion(BigDecimal[] gradientTempList$$_proportion) {
        this.gradientTempList$$_proportion = gradientTempList$$_proportion;
    }
    //end region your codes 1
}
