package so.wwb.gamebox.mcenter.report.form;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;
import java.util.Date;


/**
 * 查询表单验证对象
 *
 * @author faker
 * @time 2016-11-9 10:52:15
 */
//region your codes 1
public class VPlayerFundsRecordSearchForm implements IForm {
//endregion your codes 1

    //region your codes 2
    //金额
    private Double search_startMoney;
    private Double search_endMoney;
    //用户名
    private String search_usernames;
    //交易号
    private  String search_transactionNo;

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

    @Range(min = -99999999, max = 99999999)
    public Double getSearch_startMoney() {
        return search_startMoney;
    }

    @Range(min = -99999999, max = 99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "search_startMoney")
    public Double getSearch_endMoney() {
        return search_endMoney;
    }

    @Pattern(regexp = FormValidRegExps.ACCOUNT_COMMA,message="report_auto.账号由英文字母下划线")
    public String getSearch_usernames() {
        return search_usernames;
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