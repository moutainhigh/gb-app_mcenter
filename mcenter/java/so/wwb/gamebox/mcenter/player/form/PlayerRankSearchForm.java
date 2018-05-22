package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.Range;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.support.Comment;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Digits;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;


/**
 * 玩家层级表查询表单验证对象
 * <p>
 * Created by loong using soul-code-generator on 2015-7-14 15:40:56
 */
//region your codes 1
public class PlayerRankSearchForm implements IForm {
//endregion your codes 1

    //region your codes 2
    /**
     * 下限金额
     */
    private Long onlinePayMin;
    /**
     * 上限金额
     */
    private Long onlinePayMax;
    /**
     * 手续费时限/小时
     */
    private String feeTime;
    /**
     * 免手续费次数
     */
    private String freeCount;
    /**
     * 手续费上限金额
     */
    private String maxFee;
    /**
     * 满存金额
     */
    private String reachMoney;
    /**
     * 返手续费上限金额
     */
    private String maxReturnFee;
    /**
     * 返手续费时限/小时
     */
    private String returnTime;
    /**
     * 返手续费次数
     */
    private String returnFeeCount;
    /**
     * 存款按比例收费金额
     */
    private String $percentageAmount;//
    /**
     * 存款固定收费金额
     */
    private Double $fixedAmount;//
    /**
     * 返手续费按比例收费金额
     */
    private String $returnPercentageAmount;//
    /**
     * 返手续费固定收费金额
     */
    private Double $returnFixedAmount;//
    /**
     * 是否需要验证标记
     */
    private String $isValid;

    /**
     * 优惠稽核
     */
    private String favorableAudit;

    @Depends(property = "isValid", operator = Operator.EQ, value = "false", message = "playerRank.notBlank", jsValueExp = "$(\"[name=\'isValid\']\").val()=='true'")
    @Digits(integer = 13, fraction = 0, message = "common.DIGITS_POSITIVE_INTEGER")
    @Max(9999999999999L)
    @Compare(message = "playerRank.must.more.than.min", logic = CompareLogic.GE, anotherProperty = "result_onlinePayMin")
    @Comment("充值单笔上限金额")
    public Long getOnlinePayMax() {
        return onlinePayMax;
    }

    @Depends(property = "$isValid", operator = Operator.EQ, value = "false", message = "playerRank.notBlank", jsValueExp = "$(\"[name=\'isValid\']\").val()=='true'")
    @Digits(integer = 13, fraction = 0, message = "common.POSITIVE_INTEGER")
    @Range(min = 0, max = 9999999999999L)
    //@Compare(message = "playerRank.must.lower.than.max",logic = CompareLogic.LE,anotherProperty = "result_onlinePayMax")
    @Comment("充值单笔下限金额")
    public Long getOnlinePayMin() {
        return onlinePayMin;
    }

    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER, message = "common.POSITIVE_INTEGER")
    @Min(1)
    @Max(720)
    @Comment("手续费时限/小时")
    public String getFeeTime() {
        return feeTime;
    }

    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER, message = "common.POSITIVE_INTEGER")
    @Min(1)
    @Max(1500)
    @Comment("免手续费次数")
    public String getFreeCount() {
        return freeCount;
    }

    @Depends(property = "isFee", operator = Operator.EQ, value = "true", message = "playerRank.notBlank", jsValueExp = "$(\"[name=\\'result.isFee\\']\").val()=='true'")
    @Pattern(regexp = FormValidRegExps.POSITIVE, message = "common.POSITIVE")
    @Range(min = 1, max = 99999999)
    @Comment("手续费上限金额")
    public String getMaxFee() {
        return maxFee;
    }

    @Depends(property = "isReturnFee", operator = Operator.EQ, value = "true", message = "playerRank.notBlank", jsValueExp = "$(\"[name=\\'result.isReturnFee\\']\").val()=='true'")
    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER, message = "common.POSITIVE_INTEGER")
    @Max(99999999)
    @Comment("满存金额")
    public String getReachMoney() {
        return reachMoney;
    }

    @Depends(property = "isReturnFee", operator = Operator.EQ, value = "true", message = "playerRank.notBlank", jsValueExp = "$(\"[name=\\'result.isReturnFee\\']\").val()=='true'")
    @Pattern(regexp = FormValidRegExps.POSITIVE, message = "common.POSITIVE")
    @Max(99999999)
    @Comment("返手续费上限金额")
    public String getMaxReturnFee() {
        return maxReturnFee;
    }

    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER, message = "common.POSITIVE_INTEGER")
    @Min(message = "playerRank.lower.than.minimum", value = 1)
    @Max(message = "playerRank.more.than.maxmum", value = 720)
    @Comment("返手续费时限/小时")
    public String getReturnTime() {
        return returnTime;
    }

    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER, message = "common.POSITIVE_INTEGER")
    @Min(message = "playerRank.lower.than.minimum", value = 1)
    @Max(message = "playerRank.more.than.maxmum", value = 1500)
    @Comment("返手续费次数")
    public String getReturnFeeCount() {
        return returnFeeCount;
    }


    @Depends(property = {"isFee", "feeType"}, operator = {Operator.EQ, Operator.EQ}, value = {"true", "1"}, jsValueExp = {"$(\"[name=\\'result.isReturnFee\\']\").val()=='true'"}, message = "playerRank.notBlank")
    @Pattern(regexp = FormValidRegExps.POSITIVE, message = "common.POSITIVE")
    @Max(value = 100)
    @Comment("存款按比例收费金额")
    public String get$percentageAmount() {
        return $percentageAmount;
    }

    @Depends(property = {"isFee", "feeType"}, operator = {Operator.EQ, Operator.EQ}, value = {"true", "2"}, jsValueExp = {"$(\"[name=\\'result.isReturnFee\\']\").val()=='true'"}, message = "playerRank.notBlank")
    @Digits(integer = 8, fraction = 2, message = "common.POSITIVE")
    @Compare(message = "playerRank.must.lower.than.max", logic = CompareLogic.LE, anotherProperty = "result_maxFee")
    @Comment("存款固定收费金额")
    public Double get$fixedAmount() {
        return $fixedAmount;
    }


    @Depends(property = {"isReturnFee", "returnType"}, operator = {Operator.EQ, Operator.EQ}, value = {"true", "1"}, jsValueExp = "$(\"[name=\\'result.isReturnFee\\']\").val()=='true'", message = "playerRank.notBlank")
    @Pattern(regexp = FormValidRegExps.POSITIVE, message = "common.POSITIVE")
    @Max(value = 100)
    @Comment("按比例返还手续费")
    public String get$returnPercentageAmount() {
        return $returnPercentageAmount;
    }


    @Depends(property = {"isReturnFee", "returnType"}, operator = {Operator.EQ, Operator.EQ}, value = {"true", "2"}, jsValueExp = "$(\"[name=\\'result.isReturnFee\\']\").val()=='true'", message = "playerRank.notBlank")
    @Compare(message = "playerRank.must.lower.than.max", logic = CompareLogic.LE, anotherProperty = "result_maxReturnFee")
    @Digits(integer = 8, fraction = 2, message = "common.POSITIVE")
    @Comment("固定返还手续费")
    public Double get$returnFixedAmount() {
        return $returnFixedAmount;
    }

    public void setOnlinePayMin(Long onlinePayMin) {
        this.onlinePayMin = onlinePayMin;
    }

    public void setOnlinePayMax(Long onlinePayMax) {
        this.onlinePayMax = onlinePayMax;
    }

    public void setFeeTime(String feeTime) {
        this.feeTime = feeTime;
    }

    public void setFreeCount(String freeCount) {
        this.freeCount = freeCount;
    }

    public void setMaxFee(String maxFee) {
        this.maxFee = maxFee;
    }

    public void setReachMoney(String reachMoney) {
        this.reachMoney = reachMoney;
    }

    public void setMaxReturnFee(String maxReturnFee) {
        this.maxReturnFee = maxReturnFee;
    }

    public void setReturnTime(String returnTime) {
        this.returnTime = returnTime;
    }

    public void setReturnFeeCount(String returnFeeCount) {
        this.returnFeeCount = returnFeeCount;
    }

    public void set$percentageAmount(String $percentageAmount) {
        this.$percentageAmount = $percentageAmount;
    }

    public void set$fixedAmount(Double $fixedAmount) {
        this.$fixedAmount = $fixedAmount;
    }

    public void set$returnPercentageAmount(String $returnPercentageAmount) {
        this.$returnPercentageAmount = $returnPercentageAmount;
    }

    public void set$returnFixedAmount(Double $returnFixedAmount) {
        this.$returnFixedAmount = $returnFixedAmount;
    }

    public String get$isValid() {
        return $isValid;
    }

    public void set$isValid(String $isValid) {
        this.$isValid = $isValid;
    }

    @Depends(property = {"isReturnFee"}, operator = {Operator.EQ}, value = {"true"}, jsValueExp = "$(\"[name=\\'result.isReturnFee\\']\").val()=='true'")
    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE_INTEGER, message = "common.ZERO_POSITIVE_INTEGER")
    @Max(99999999)
    @Comment("优惠稽核")
    public String getFavorableAudit() {
        return favorableAudit;
    }

    public void setFavorableAudit(String favorableAudit) {
        this.favorableAudit = favorableAudit;
    }

//endregion your codes 2

}