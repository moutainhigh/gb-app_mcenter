package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;

import javax.validation.constraints.Max;
import javax.validation.constraints.Pattern;


/**
 * 玩家层级表表单验证对象
 * <p/>
 * Created by loong using soul-code-generator on 2015-7-14 15:40:56
 */
//region your codes 1
//@Compare(message = "msg", logic = CompareLogic.LT, property = "registerEndTime", anotherProperty = "registerStartTime")
public class PlayerRankWithdrawLimitForm implements IForm {
//endregion your codes 1

    /** 提现 时限/小时 */
    private Integer txTimeLimit;
    /** 免手续费次数 */
    private Integer txFreeCount;
    /** 手续费上限 */
    private String txMaxFee;
    /** 提现手续费类型（1按比例收费；2固定收费） */
    private String txFeeType;
    /** 手续费金额 */
    private String txFeeNum;
    /** 普通提现处理时间/小时 */
    private String txCheckTime;
    /** 超额提现金额 */
    private String txExcessCheckNum;
    /** 超额提现处理时间/小时 */
    private String txExcessCheckTime;
    /** 提现单笔上限金额 */
    private String txMaxNum;
    /** 提现单笔下限金额 */
    private String txMinNum;
    /** 常态稽核 */
    private String txNormalAudit;
    /** 行政费 */
    private String txAdminCost;
    /** 提现稽核放宽额度 */
    private String txRelaxCredit;
    /** 优惠余额稽核 */
    private String txDiscountAudit;
    @Max(message = "playerRank.add.txTimeLimitFormMsg",value = 720)
    @Comment("提现 时限/小时")
    public Integer getTxTimeLimit() {
        return txTimeLimit;
    }
    @Max(message ="ayerRank.add.txFreeCountFormMsg",value = 1500)
    @Comment("免手续费次数")
    public Integer getTxFreeCount() {
        return txFreeCount;
    }

    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Comment("手续费上限")
    public String getTxMaxFee() {
        return txMaxFee;
    }

    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Comment("提现手续费类型（1按比例收费；2固定收费）")
    public String getTxFeeType() {
        return txFeeType;
    }

    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Comment("手续费金额")
    public String getTxFeeNum() {
        return txFeeNum;
    }

    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Comment("普通提现处理时间/小时")
    public String getTxCheckTime() {
        return txCheckTime;
    }

    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Comment("超额提现金额")
    public String getTxExcessCheckNum() {
        return txExcessCheckNum;
    }

    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Comment("超额提现处理时间/小时")
    public String getTxExcessCheckTime() {
        return txExcessCheckTime;
    }

    @NotBlank(message = "playerRank.withdrawlimit.txMaxNum.notBlank")
    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Comment("提现单笔上限金额")
    public String getTxMaxNum() {
        return txMaxNum;
    }

    @NotBlank(message = "playerRank.withdrawlimit.txMinNum.notBlank")
    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Comment("提现单笔下限金额")
    public String getTxMinNum() {
        return txMinNum;
    }

    @NotBlank(message = "playerRank.withdrawlimit.txNormalAudit.notBlank")
    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Max(message = "playerRank.withdrawlimit.maxInteger",value = 100)
    @Comment("常态稽核")
    public String getTxNormalAudit() {
        return txNormalAudit;
    }

    @NotBlank(message = "playerRank.withdrawlimit.txAdminCost.notBlank")
    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Max(message = "playerRank.withdrawlimit.maxInteger",value = 100)
    @Comment("行政费")
    public String getTxAdminCost() {
        return txAdminCost;
    }

    @NotBlank(message = "playerRank.withdrawlimit.txRelaxCredit.notBlank")
    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Comment("提现稽核放宽额度")
    public String getTxRelaxCredit() {
        return txRelaxCredit;
    }

    @NotBlank(message = "playerRank.withdrawlimit.txDiscountAudit.notBlank")
    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Max(message = "playerRank.withdrawlimit.maxInteger",value = 100)
    @Comment("优惠余额稽核")
    public String getTxDiscountAudit() {
        return txDiscountAudit;
    }

    public void setTxTimeLimit(Integer txTimeLimit) {
        this.txTimeLimit = txTimeLimit;
    }

    public void setTxFreeCount(Integer txFreeCount) {
        this.txFreeCount = txFreeCount;
    }

    public void setTxMaxFee(String txMaxFee) {
        this.txMaxFee = txMaxFee;
    }

    public void setTxFeeType(String txFeeType) {
        this.txFeeType = txFeeType;
    }

    public void setTxFeeNum(String txFeeNum) {
        this.txFeeNum = txFeeNum;
    }

    public void setTxCheckTime(String txCheckTime) {
        this.txCheckTime = txCheckTime;
    }

    public void setTxExcessCheckNum(String txExcessCheckNum) {
        this.txExcessCheckNum = txExcessCheckNum;
    }

    public void setTxExcessCheckTime(String txExcessCheckTime) {
        this.txExcessCheckTime = txExcessCheckTime;
    }

    public void setTxMaxNum(String txMaxNum) {
        this.txMaxNum = txMaxNum;
    }

    public void setTxMinNum(String txMinNum) {
        this.txMinNum = txMinNum;
    }

    public void setTxNormalAudit(String txNormalAudit) {
        this.txNormalAudit = txNormalAudit;
    }

    public void setTxAdminCost(String txAdminCost) {
        this.txAdminCost = txAdminCost;
    }

    public void setTxRelaxCredit(String txRelaxCredit) {
        this.txRelaxCredit = txRelaxCredit;
    }

    public void setTxDiscountAudit(String txDiscountAudit) {
        this.txDiscountAudit = txDiscountAudit;
    }
    //endregion your codes 2

}