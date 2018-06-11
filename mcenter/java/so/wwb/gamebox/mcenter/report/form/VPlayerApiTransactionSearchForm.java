package so.wwb.gamebox.mcenter.report.form;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;
import java.math.BigDecimal;
import java.util.Date;


/**
 * 查询表单验证对象
 *
 * @author kobe
 * @time 2016-11-9 10:44:44
 */
//region your codes 1
public class VPlayerApiTransactionSearchForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private BigDecimal search_startMoney;

    private BigDecimal search_endMoney;

    //开始时间
    private Date search_startTime;
    private Date search_endTime;

    @NotBlank
    public Date getSearch_startTime() {
        return search_startTime;
    }

    @NotBlank
    public Date getSearch_endTime() {
        return search_endTime;
    }

    //交易号
    private  String search_transactionNo;

    @Range(min = -99999999,max =99999999 )
    public BigDecimal getSearch_startMoney() {
        return search_startMoney;
    }

    @Range(min = -99999999,max =99999999 )
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin",logic = CompareLogic.GE,anotherProperty = "search_startMoney")
    public BigDecimal getSearch_endMoney() {
        return search_endMoney;
    }

    @Pattern(regexp = FormValidRegExps.ENGLISH_NUMBER)
    public String getSearch_transactionNo() {
        return search_transactionNo;
    }

    public void setSearch_transactionNo(String search_transactionNo) {
        this.search_transactionNo = search_transactionNo;
    }

    interface StartBothNull {

    }
    //endregion your codes 2

}