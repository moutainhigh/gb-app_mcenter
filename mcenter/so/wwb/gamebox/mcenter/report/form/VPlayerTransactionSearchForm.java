package so.wwb.gamebox.mcenter.report.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.Range;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;


/**
 * 玩家交易视图-jeff查询表单验证对象
 *
 * @author catban
 * @time 2016-01-08 14:57:43
 */
//region your codes 1
public class VPlayerTransactionSearchForm implements IForm {
//endregion your codes 1

    //region your codes 2
    /** 账号 */
    private String search_username;
    private String search_agentname;
    private String search_topagentusername;
    /* 资金范围　*/
    private Double search_startMoney;
    private Double search_endMoney;


    @Length(min = 1, max = 20)
    public String getSearch_transactionNo() {
        return search_transactionNo;
    }


    public String getSearch_bankOrder() {
        return search_bankOrder;
    }

    /* 关键字搜索　*/
    private String search_transactionNo;
    private String search_bankOrder;


    @Pattern(regexp = FormValidRegExps.ACCOUNT,message = "common.valid.usernameFormat")
    public String getSearch_username() {
        return search_username;
    }

    @Pattern(regexp = FormValidRegExps.ACCOUNT,message = "common.valid.usernameFormat")
    public String getSearch_topagentusername() {
        return search_topagentusername;
    }

    @Range(min = 0,max =99999999 )
    public Double getSearch_startMoney() {
        return search_startMoney;
    }
    @Range(min = 0,max =99999999 )
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin",logic = CompareLogic.GE,anotherProperty = "search_startMoney")
    public Double getSearch_endMoney() {
        return search_endMoney;
    }

    @Pattern(regexp = FormValidRegExps.ACCOUNT,message = "common.valid.usernameFormat")
    public String getSearch_agentname() {
        return search_agentname;
    }

    public void setSearch_agentname(String search_agentname) {
        this.search_agentname = search_agentname;
    }

    public void setSearch_endMoney(Double search_endMoney) {
        this.search_endMoney = search_endMoney;
    }

    public void setSearch_username(String search_username) {
        this.search_username = search_username;
    }

    public void setSearch_startMoney(Double search_startMoney) {
        this.search_startMoney = search_startMoney;
    }

    public void setSearch_topagentusername(String search_topagentusername) {
        this.search_topagentusername = search_topagentusername;
    }
    public void setSearch_transactionNo(String search_transactionNo) {
        this.search_transactionNo = search_transactionNo;
    }

    public void setSearch_bankOrder(String search_bankOrder) {
        this.search_bankOrder = search_bankOrder;
    }


    //endregion your codes 2

}