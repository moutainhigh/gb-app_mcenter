package so.wwb.gamebox.mcenter.report.form;

import org.hibernate.validator.constraints.Range;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;

import javax.validation.constraints.Digits;


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
    private Double fundSearch_effectiveStartAmount;
    private Double fundSearch_effectiveEndAmount;

    /** 存款金额 */
    private Double fundSearch_depositStartAmount;
    private Double fundSearch_depositEndAmount;

    /** 取款金额 */
    private Double fundSearch_withdrawStartAmount;
    private Double fundSearch_withdrawEndAmount;

    /** 优惠 */
    private  Double fundSearch_favorableStartAmount;
    private  Double fundSearch_favorableEndAmount;

    /** 存款次数 */
    private  Integer fundSearch_depositStartNum;
    private  Integer fundSearch_depositEndNum;

    /** 取款次数 */
    private  Integer fundSearch_withdrawStartNum;
    private  Integer fundSearch_withdrawEndNum;

    /** 返水 */
    private  Double fundSearch_rakebackStartAmount;
    private  Double fundSearch_rakebackEndAmount;

    /** 损益 */
    private  Double fundSearch_profitLossStartAmount;
    private  Double fundSearch_profitLossEndAmount;

    @Range(min = 0, max = 99999999)
    public Double getFundSearch_rakebackStartAmount() {
        return fundSearch_rakebackStartAmount;
    }

    @Range(min = 0, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "fundSearch_rakebackStartAmount")
    public Double getFundSearch_rakebackEndAmount() {
        return fundSearch_rakebackEndAmount;
    }

    @Range(min = -99999999, max = 99999999)
    public Double getFundSearch_profitLossStartAmount() {
        return fundSearch_profitLossStartAmount;
    }

    @Range(min = -99999999, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "fundSearch_profitLossStartAmount")
    public Double getFundSearch_profitLossEndAmount() {
        return fundSearch_profitLossEndAmount;
    }

    @Range(min = 0, max = 99999999)
    public Double getFundSearch_effectiveStartAmount() {
        return fundSearch_effectiveStartAmount;
    }

    @Range(min = 0, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "fundSearch_effectiveStartAmount")
    public Double getFundSearch_effectiveEndAmount() {
        return fundSearch_effectiveEndAmount;
    }

    @Range(min = 0, max = 99999999)
    public Double getFundSearch_depositStartAmount() {
        return fundSearch_depositStartAmount;
    }

    @Range(min = 0, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "fundSearch_depositStartAmount")
    public Double getFundSearch_depositEndAmount() {
        return fundSearch_depositEndAmount;
    }

    @Range(min = 0, max = 99999999)
    public Double getFundSearch_withdrawStartAmount() {
        return fundSearch_withdrawStartAmount;
    }

    @Range(min = 0, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "fundSearch_withdrawStartAmount")
    public Double getFundSearch_withdrawEndAmount() {
        return fundSearch_withdrawEndAmount;
    }

    @Range(min = 0, max = 99999999)
    public Double getFundSearch_favorableStartAmount() {
        return fundSearch_favorableStartAmount;
    }

    @Range(min = 0, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "fundSearch_favorableStartAmount")
    public Double getFundSearch_favorableEndAmount() {
        return fundSearch_favorableEndAmount;
    }

    @Range(min = 0, max = 99999999)
    @Digits(integer = 8, fraction = 0,message = "请输入0或正整数")
    public Integer getFundSearch_depositStartNum() {
        return fundSearch_depositStartNum;
    }

    @Range(min = 0, max = 99999999)
    @Digits(integer = 8, fraction = 0,message = "请输入0或正整数")
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "fundSearch_depositStartNum")
    public Integer getFundSearch_depositEndNum() {
        return fundSearch_depositEndNum;
    }

    @Range(min = 0, max = 99999999)
    @Digits(integer = 8, fraction = 0,message = "请输入0或正整数")
    public Integer getFundSearch_withdrawStartNum() {
        return fundSearch_withdrawStartNum;
    }

    @Range(min = 0, max = 99999999)
    @Digits(integer = 8, fraction = 0,message = "请输入0或正整数")
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "fundSearch_withdrawStartNum")
    public Integer getFundSearch_withdrawEndNum() {
        return fundSearch_withdrawEndNum;
    }
    //endregion your codes 2

}