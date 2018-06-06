package so.wwb.gamebox.mcenter.report.form;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;

import javax.validation.constraints.Digits;
import java.util.Date;


/**
 * 查询表单验证对象
 *
 * @author younger
 * @time 2018-1-7 14:42:07
 */
//region your codes 1
public class UserPlayerFundSearchForm implements IForm {
//endregion your codes 1

    //region your codes 2

    /** 有效投注额 */
    private Double search_fundSearch_effectiveStartAmount;
    private Double search_fundSearch_effectiveEndAmount;

    /** 存款金额 */
    private Double search_fundSearch_depositStartAmount;
    private Double search_fundSearch_depositEndAmount;

    /** 取款金额 */
    private Double search_fundSearch_withdrawStartAmount;
    private Double search_fundSearch_withdrawEndAmount;

    /** 优惠 */
    private  Double search_fundSearch_favorableStartAmount;
    private  Double search_fundSearch_favorableEndAmount;

    /** 存款次数 */
    private  Integer search_fundSearch_depositStartNum;
    private  Integer search_fundSearch_depositEndNum;

    /** 取款次数 */
    private  Integer search_fundSearch_withdrawStartNum;
    private  Integer search_fundSearch_withdrawEndNum;

    /** 返水 */
    private  Double search_fundSearch_rakebackStartAmount;
    private  Double search_fundSearch_rakebackEndAmount;

    /** 损益 */
    private  Double search_fundSearch_profitLossStartAmount;
    private  Double search_fundSearch_profitLossEndAmount;

    //开始时间
    private Date search_fundSearch_searchStartDate;

    @NotBlank
    public Date getSearch_fundSearch_searchStartDate() {
        return search_fundSearch_searchStartDate;
    }

    @Range(min = 0, max = 99999999)
    public Double getSearch_fundSearch_rakebackStartAmount() {
        return search_fundSearch_rakebackStartAmount;
    }

    @Range(min = 0, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "search_fundSearch_rakebackStartAmount")
    public Double getSearch_fundSearch_rakebackEndAmount() {
        return search_fundSearch_rakebackEndAmount;
    }

    @Range(min = -99999999, max = 99999999)
    public Double getSearch_fundSearch_profitLossStartAmount() {
        return search_fundSearch_profitLossStartAmount;
    }

    @Range(min = -99999999, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "search_fundSearch_profitLossStartAmount")
    public Double getSearch_fundSearch_profitLossEndAmount() {
        return search_fundSearch_profitLossEndAmount;
    }

    @Range(min = 0, max = 99999999)
    public Double getSearch_fundSearch_effectiveStartAmount() {
        return search_fundSearch_effectiveStartAmount;
    }

    @Range(min = 0, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "search_fundSearch_effectiveStartAmount")
    public Double getSearch_fundSearch_effectiveEndAmount() {
        return search_fundSearch_effectiveEndAmount;
    }

    @Range(min = 0, max = 99999999)
    public Double getSearch_fundSearch_depositStartAmount() {
        return search_fundSearch_depositStartAmount;
    }

    @Range(min = 0, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "search_fundSearch_depositStartAmount")
    public Double getSearch_fundSearch_depositEndAmount() {
        return search_fundSearch_depositEndAmount;
    }

    @Range(min = 0, max = 99999999)
    public Double getSearch_fundSearch_withdrawStartAmount() {
        return search_fundSearch_withdrawStartAmount;
    }

    @Range(min = 0, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "search_fundSearch_withdrawStartAmount")
    public Double getSearch_fundSearch_withdrawEndAmount() {
        return search_fundSearch_withdrawEndAmount;
    }

    @Range(min = 0, max = 99999999)
    public Double getSearch_fundSearch_favorableStartAmount() {
        return search_fundSearch_favorableStartAmount;
    }

    @Range(min = 0, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "search_fundSearch_favorableStartAmount")
    public Double getSearch_fundSearch_favorableEndAmount() {
        return search_fundSearch_favorableEndAmount;
    }

    @Range(min = 0, max = 99999999)
    @Digits(integer = 8, fraction = 0,message = "请输入0或正整数")
    public Integer getSearch_fundSearch_depositStartNum() {
        return search_fundSearch_depositStartNum;
    }

    @Range(min = 0, max = 99999999)
    @Digits(integer = 8, fraction = 0,message = "请输入0或正整数")
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "search_fundSearch_depositStartNum")
    public Integer getSearch_fundSearch_depositEndNum() {
        return search_fundSearch_depositEndNum;
    }

    @Range(min = 0, max = 99999999)
    @Digits(integer = 8, fraction = 0,message = "请输入0或正整数")
    public Integer getSearch_fundSearch_withdrawStartNum() {
        return search_fundSearch_withdrawStartNum;
    }

    @Range(min = 0, max = 99999999)
    @Digits(integer = 8, fraction = 0,message = "请输入0或正整数")
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "search_fundSearch_withdrawStartNum")
    public Integer getSearch_fundSearch_withdrawEndNum() {
        return search_fundSearch_withdrawEndNum;
    }
    //endregion your codes 2

}