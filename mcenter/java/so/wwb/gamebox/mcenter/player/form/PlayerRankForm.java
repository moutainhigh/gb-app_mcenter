package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.NotBlank;
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
 * 玩家层级表表单验证对象
 * <p/>
 * Created by loong using soul-code-generator on 2015-7-14 15:40:56
 */
//region your codes 1
//@Compare(message = "msg", logic = CompareLogic.LT, property = "registerEndTime", anotherProperty = "registerStartTime")
public class PlayerRankForm implements IForm {
//endregion your codes 1

    /**
     * 提现 时限/小时
     */
    private String result_withdrawTimeLimit;
    /**
     * 免手续费次数
     */
    private String result_withdrawFreeCount;
    /**
     * 手续费上限
     */
    private Double result_withdrawMaxFee;

    /**
     * 是否启用取款限制
     */
    private String result_isWithdrawLimit;
    /** 24H内允许取款次数 */
    private String result_withdrawCount;

    /**
     * 普通提现
     */
    private String result_withdrawCheckStatus;
    /**
     * 超额提现
     */
    private String result_withdrawExcessCheckStatus;
    /**
     * 普通提现处理时间/小时
     */
    private String result_withdrawCheckTime;
    /**
     * 超额提现金额
     */
    private String result_withdrawExcessCheckNum;
    /**
     * 超额提现处理时间/小时
     */
    private String result_withdrawExcessCheckTime;
    /**
     * 提现单笔上限金额
     */
    private Integer result_withdrawMaxNum;
    /**
     * 提现单笔下限金额
     */
    private Integer result_withdrawMinNum;
    /**
     * 常态稽核
     */
    private String result_withdrawNormalAudit;
    /**
     * 行政费
     */
    private String withdrawAdminCost;
    /**
     * 提现稽核放宽额度
     */
    private String withdrawRelaxCredit;
    /**
     * 优惠余额稽核
     */
    //private String withdrawDiscountAudit;

    /**
     *
     */
    private String result_withdrawFeeType;
    /**
    * 按比例收费金额
    */
    private String $returnPercentageAmount;
    /**
     * 固定收费金额
     */
    private Double $returnFixedAmount;

    public String getResult_withdrawCheckStatus() {
        return result_withdrawCheckStatus;
    }

    public String getResult_withdrawExcessCheckStatus() {
        return result_withdrawExcessCheckStatus;
    }

    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER,message = "common.POSITIVE_INTEGER")
    @Max(720)
    @Comment("提现 时限/小时")
    public String getResult_withdrawTimeLimit() {
        return result_withdrawTimeLimit;
    }
    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER,message = "common.POSITIVE_INTEGER")
    @Max(1500)
    @Comment("免手续费次数")
    public String getResult_withdrawFreeCount() {
        return result_withdrawFreeCount;
    }
    @Digits(integer = 8,fraction = 2,message = "common.POSITIVE")
    @Min(value = 1,message = "player_auto.请输入大于0的正数")
    @Max(99999999)
    @Comment("手续费上限")
    public Double getResult_withdrawMaxFee() {
        return result_withdrawMaxFee;
    }

    public String getResult_withdrawFeeType() {
        return result_withdrawFeeType;
    }

    @Pattern(regexp = FormValidRegExps.POSITIVE,message = "player_auto.请输入正数和小数")
    @Max(100)
    public String get$returnPercentageAmount() {
        return $returnPercentageAmount;
    }

    @Digits(integer = 8,fraction = 2,message = "player_auto.请输入正数和小数")
    @Compare(message = "playerRank.withdrawLimit.le.withdrawMaxFee",logic = CompareLogic.LE,anotherProperty = "result_withdrawMaxFee")
    @Comment("手续费上限金额")
    public Double get$returnFixedAmount() {
        return $returnFixedAmount;
    }



    public String getResult_isWithdrawLimit() {
        return result_isWithdrawLimit;
    }

    @Depends(property ={"isWithdrawLimit"}, operator = {Operator.EQ}, value = {"true"}, jsValueExp ={"$(\"[name=\\'result.isWithdrawLimit\\']\").val()=='true'"})
    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER,message = "common.POSITIVE_INTEGER")
    @Max(1500)
    @Comment("24H内允许取款次数")
    public String getResult_withdrawCount() {
        return result_withdrawCount;
    }


    @Depends(property ={"withdrawCheckStatus"}, operator = {Operator.EQ}, value = {"true"}, jsValueExp ={"$(\"[name=\\'result.withdrawCheckStatus\\']\").val()=='true'"})
    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER,message = "common.POSITIVE_INTEGER")
    @Max(4320)
    @Comment("普通提现处理时间/小时")
    public String getResult_withdrawCheckTime() {
        return result_withdrawCheckTime;
    }

    @Depends(property ={"withdrawExcessCheckStatus"}, operator = {Operator.EQ}, value = {"true"}, jsValueExp ={"$(\"[name=\\'result.withdrawExcessCheckStatus\\']\").val()=='true'"})
    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER,message = "common.POSITIVE_INTEGER")
    @Max(4320)
    @Comment("超额提现处理时间/小时")
    public String getResult_withdrawExcessCheckTime() {
        return result_withdrawExcessCheckTime;
    }

    @Depends(property ={"withdrawExcessCheckStatus"}, operator = {Operator.EQ}, value = {"true"}, jsValueExp ={"$(\"[name=\\'result.withdrawExcessCheckStatus\\']\").val()=='true'"})
    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER,message = "common.POSITIVE_INTEGER")
    @Max(99999999)
    @Comment("超额提现金额")
    public String getResult_withdrawExcessCheckNum() {
        return result_withdrawExcessCheckNum;
    }

    @NotBlank
    @Digits(integer = 8,fraction = 0,message = "common.DIGITS_POSITIVE_INTEGER")
    @Compare(message = "playerRank.withdrawLimit.gt.withdrawMinNum", logic = CompareLogic.GT, anotherProperty = "result_withdrawMinNum")
    @Comment("提现单笔上限金额")
    public Integer getResult_withdrawMaxNum() {
        return result_withdrawMaxNum;
    }

    @NotBlank
    @Digits(integer = 8,fraction = 0,message = "common.POSITIVE_INTEGER")
    @Compare(message = "playerRank.withdrawLimit.lt.withdrawMaxNum", logic = CompareLogic.LT, anotherProperty = "result_withdrawMaxNum")
    @Range(min = 1,max = 99999999)
    @Comment("提现单笔下限金额")
    public Integer getResult_withdrawMinNum() {
        return result_withdrawMinNum;
    }

    @NotBlank
    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE,message = "common.ZERO_POSITIVE")
    @Max(5)
    @Comment("常态稽核")
    public String getResult_withdrawNormalAudit() {
        return result_withdrawNormalAudit;
    }

    @NotBlank
    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE,message = "common.ZERO_POSITIVE")
    @Max(100)
    @Comment("行政费")
    public String getWithdrawAdminCost() {
        return withdrawAdminCost;
    }

    @NotBlank
    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE_INTEGER,message = "common.ZERO_POSITIVE_INTEGER")
    @Max(99999999)
    @Comment("提现稽核放宽额度")
    public String getWithdrawRelaxCredit() {
        return withdrawRelaxCredit;
    }

   /* @NotBlank
    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE_INTEGER,message = "common.ZERO_POSITIVE_INTEGER")
    @Max(99999999)
    @Comment("优惠余额稽核")
    public String getWithdrawDiscountAudit() {
        return withdrawDiscountAudit;
    }*/

    public void setResult_withdrawCheckStatus(String result_withdrawCheckStatus) {
        this.result_withdrawCheckStatus = result_withdrawCheckStatus;
    }

    public void setResult_withdrawExcessCheckStatus(String result_withdrawExcessCheckStatus) {
        this.result_withdrawExcessCheckStatus = result_withdrawExcessCheckStatus;
    }

    public void setWithdrawRelaxCredit(String withdrawRelaxCredit) {
        this.withdrawRelaxCredit = withdrawRelaxCredit;
    }

    public void setResult_withdrawTimeLimit(String result_withdrawTimeLimit) {
        this.result_withdrawTimeLimit = result_withdrawTimeLimit;
    }

    public void setResult_withdrawFreeCount(String result_withdrawFreeCount) {
        this.result_withdrawFreeCount = result_withdrawFreeCount;
    }

    public void setResult_withdrawMaxFee(Double result_withdrawMaxFee) {
        this.result_withdrawMaxFee = result_withdrawMaxFee;
    }

    public void setResult_withdrawCheckTime(String result_withdrawCheckTime) {
        this.result_withdrawCheckTime = result_withdrawCheckTime;
    }

    public void setResult_withdrawExcessCheckNum(String result_withdrawExcessCheckNum) {
        this.result_withdrawExcessCheckNum = result_withdrawExcessCheckNum;
    }

    public void setResult_withdrawExcessCheckTime(String result_withdrawExcessCheckTime) {
        this.result_withdrawExcessCheckTime = result_withdrawExcessCheckTime;
    }

    public void setResult_withdrawMaxNum(Integer result_withdrawMaxNum) {
        this.result_withdrawMaxNum = result_withdrawMaxNum;
    }

    public void setResult_withdrawMinNum(Integer result_withdrawMinNum) {
        this.result_withdrawMinNum = result_withdrawMinNum;
    }

    public void setResult_withdrawCount(String result_withdrawCount) {
        this.result_withdrawCount = result_withdrawCount;
    }

    public void setResult_withdrawNormalAudit(String result_withdrawNormalAudit) {
        this.result_withdrawNormalAudit = result_withdrawNormalAudit;
    }

    public void setWithdrawAdminCost(String withdrawAdminCost) {
        this.withdrawAdminCost = withdrawAdminCost;
    }

  /*  public void setWithdrawDiscountAudit(String withdrawDiscountAudit) {
        this.withdrawDiscountAudit = withdrawDiscountAudit;
    }*/

    public void setResult_isWithdrawLimit(String result_isWithdrawLimit) {
        this.result_isWithdrawLimit = result_isWithdrawLimit;
    }

    public void setResult_withdrawFeeType(String result_withdrawFeeType) {
        this.result_withdrawFeeType = result_withdrawFeeType;
    }

    public void set$returnPercentageAmount(String $returnPercentageAmount) {
        this.$returnPercentageAmount = $returnPercentageAmount;
    }

    public void set$returnFixedAmount(Double $returnFixedAmount) {
        this.$returnFixedAmount = $returnFixedAmount;
    }
//endregion your codes 2

}