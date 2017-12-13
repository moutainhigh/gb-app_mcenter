package so.wwb.gamebox.mcenter.fund.form;

import org.hibernate.validator.constraints.Range;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;


/**
 * 查询表单验证对象
 *
 * @author orange
 * @time 2015-9-17 15:05:28
 */
//region your codes 1
public class VAgentWithdrawOrderSearchForm implements IForm {
//endregion your codes 1

    //region your codes 2
    //交易金额
    private Double search_beginAmount;
    private Double search_endAmount;

    /*IP*/
    private String search_ipStr;
    /*交易号*/
    private String search_transactionNo;


    @Range(min = 0,max =99999999 )
    public Double getSearch_beginAmount() {
        return search_beginAmount;
    }

    public void setSearch_beginAmount(Double search_beginAmount) {
        this.search_beginAmount = search_beginAmount;
    }

    @Range(min = 0,max =99999999 )
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin",logic = CompareLogic.GE,anotherProperty = "search_beginAmount")
    public Double getSearch_endAmount() {
        return search_endAmount;
    }

    public void setSearch_endAmount(Double search_endAmount) {
        this.search_endAmount = search_endAmount;
    }

    @Pattern(regexp = FormValidRegExps.IP)
    public String getSearch_ipStr() {
        return search_ipStr;
    }

    public void setSearch_ipStr(String search_ipStr) {
        this.search_ipStr = search_ipStr;
    }

    @Pattern(regexp = FormValidRegExps.ENGLISH_NUMBER)
    public String getSearch_transactionNo() {
        return search_transactionNo;
    }

    public void setSearch_transactionNo(String search_transactionNo) {
        this.search_transactionNo = search_transactionNo;
    }
    //endregion your codes 2

}