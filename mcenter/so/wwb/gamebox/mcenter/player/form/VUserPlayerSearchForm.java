package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.Range;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Max;
import javax.validation.constraints.Pattern;


/**
 * 查询表单验证对象
 *
 * Created by ke using soul-code-generator on 2015-6-30 10:24:49
 */
//region your codes 1
public class VUserPlayerSearchForm implements IForm {
//endregion your codes 1

    //region your codes 2

    private String search_noLoginTime;

    /** 总资产 */
    private Double search_totalAssetsBegin;
    private Double search_totalAssetsEnd;

    /** 存款总额 */
    private Double search_rechargeTotalBegin;
    private Double search_rechargeTotalEnd;

    /** 取款总额 */
    private Double search_txTotalBegin;
    private Double search_txTotalEnd;

    /** 钱包余额 */
    private  Double search_walletBalanceBegin;
    private  Double search_walletBalanceEnd;

    @Pattern(regexp = FormValidRegExps.ZERO_POSITIVE_INTEGER,message = "common.ZERO_POSITIVE_INTEGER")
    @Max(9999)
    public String getSearch_noLoginTime() {
        return search_noLoginTime;
    }

    @Range(min = 0, max = 99999999)
    public Double getSearch_totalAssetsBegin() {
        return search_totalAssetsBegin;
    }

    @Range(min = 0, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "search_totalAssetsBegin")
    public Double getSearch_totalAssetsEnd() {
        return search_totalAssetsEnd;
    }

    @Range(min = 0, max = 99999999)
    public Double getSearch_rechargeTotalBegin() {
        return search_rechargeTotalBegin;
    }

    @Range(min = 0, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "search_rechargeTotalBegin")
    public Double getSearch_rechargeTotalEnd() {
        return search_rechargeTotalEnd;
    }

    @Range(min = 0, max = 99999999)
    public Double getSearch_txTotalBegin() {
        return search_txTotalBegin;
    }

    @Range(min = 0, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "search_txTotalBegin")
    public Double getSearch_txTotalEnd() {
        return search_txTotalEnd;
    }

    @Range(min = 0, max = 99999999)
    public Double getSearch_walletBalanceBegin() {
        return search_walletBalanceBegin;
    }

    @Range(min = 0, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "search_walletBalanceBegin")
    public Double getSearch_walletBalanceEnd() {
        return search_walletBalanceEnd;
    }


    //endregion your codes 2

}