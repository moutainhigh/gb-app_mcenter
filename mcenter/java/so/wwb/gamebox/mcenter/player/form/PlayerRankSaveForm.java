package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;

import javax.validation.constraints.Pattern;
import java.util.Date;


/**
 * 玩家层级表表单验证对象
 * <p/>
 * Created by loong using soul-code-generator on 2015-7-14 15:40:56
 */
//region your codes 1
//@Compare(message = "msg", logic = CompareLogic.LT, property = "registerEndTime", anotherProperty = "registerStartTime")
public class PlayerRankSaveForm implements IForm {
//endregion your codes 1

    //region your codes 2
    /**
     * 层级名称
     */
    private String rankName;
    /**
     * 注册开始时间
     */
    private Date registerStartTime;
    /**
     * 注册结束时间
     */
    private Date registerEndTime;
    /**
     * 充值次数
     */
    private String czCount;
    /**
     * 充值总额
     */
    private String czTotal;
    /**
     * 最大充值金额
     */
    private String czMaxNum;
    /**
     * 提现次数
     */
    private String txCount;
    /**
     * 提现总额
     */
    private String txTotal;

    private String remark;


    @NotBlank(message = "playerRank.add.rankNameFormMsg")
    @Comment("层级名称")
    public String getRankName() {
        return rankName;
    }

    public Date getRegisterStartTime() {
        return registerStartTime;
    }

    public Date getRegisterEndTime() {
        return registerEndTime;
    }


    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Length(message = "playerRank.add.maxChar",max = 10)
    @Comment("充值次数")
    public String getCzCount() {
        return czCount;
    }


    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Length(message = "playerRank.add.maxChar",max = 10)
    @Comment("充值总额")
    public String getCzTotal() {
        return czTotal;
    }


    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Length(message = "",max = 10)
    @Comment("最大充值金额")
    public String getCzMaxNum() {
        return czMaxNum;
    }


    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Length(message = "",max = 10)
    @Comment("提现次数")
    public String getTxCount() {
        return txCount;
    }

    @Pattern(regexp = "^[1-9]*\\d*$", message = "playerRank.add.isNum")
    @Length(message = "",max = 10)
    @Comment("提现总额")
    public String getTxTotal() {
        return txTotal;
    }

    public String getRemark() {
        return remark;
    }

    public void setRankName(String rankName) {
        this.rankName = rankName;
    }

    public void setRegisterStartTime(Date registerStartTime) {
        this.registerStartTime = registerStartTime;
    }

    public void setRegisterEndTime(Date registerEndTime) {
        this.registerEndTime = registerEndTime;
    }

    public void setCzCount(String czCount) {
        this.czCount = czCount;
    }

    public void setCzTotal(String czTotal) {
        this.czTotal = czTotal;
    }

    public void setCzMaxNum(String czMaxNum) {
        this.czMaxNum = czMaxNum;
    }

    public void setTxCount(String txCount) {
        this.txCount = txCount;
    }

    public void setTxTotal(String txTotal) {
        this.txTotal = txTotal;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
    //endregion your codes 2

}