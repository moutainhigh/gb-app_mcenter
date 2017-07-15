package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.Range;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Max;
import javax.validation.constraints.Pattern;


/**
 * 玩家游戏下单视图查询表单验证对象
 *
 * @author jerry
 * @time 2015-10-8 9:13:01
 */
//region your codes 1
public class VPlayerGameOrderSearchForm implements IForm {
//endregion your codes 1

    //region your codes 2
    /** 账号 */
    private String search_username;
    private String search_agentusername;

    //交易量区间

    private Double  search_beginSingleAmount;
    private Double  search_endSingleAmount;
    //有效交易量
    private Double  search_beginEffectiveTradeAmount;
    private Double  search_endEffectiveTradeAmount;
    //派彩金额
    private Double  search_beginProfitAmount;
    private Double  search_endProfitAmount;


    private String search_orderNo;
    private String search_innings;
    @Pattern(regexp = FormValidRegExps.ACCOUNT,message = "common.valid.usernameFormat")
    public String getSearch_username() {
        return search_username;
    }
    @Pattern(regexp = FormValidRegExps.ACCOUNT,message = "common.valid.usernameFormat")
    public String getSearch_agentusername() {
        return search_agentusername;
    }

    @Range(min = 0,max =99999999 )
    public Double getSearch_beginSingleAmount() {
        return search_beginSingleAmount;
    }

    @Range(min = 0,max =99999999 )
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin",logic = CompareLogic.GE,anotherProperty = "search_beginSingleAmount")
    public Double getSearch_endSingleAmount() {
        return search_endSingleAmount;
    }

    @Range(min = 0,max =99999999 )
    public Double getSearch_beginEffectiveTradeAmount() {
        return search_beginEffectiveTradeAmount;
    }

    @Range(min = 0,max =99999999 )
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin",logic = CompareLogic.GE,anotherProperty = "search_beginEffectiveTradeAmount")
    public Double getSearch_endEffectiveTradeAmount() {
        return search_endEffectiveTradeAmount;
    }

    @Max(99999999)
    public Double getSearch_beginProfitAmount() {
        return search_beginProfitAmount;
    }

    @Max(99999999)
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin",logic = CompareLogic.GE,anotherProperty = "search_beginProfitAmount")
    public Double getSearch_endProfitAmount() {
        return search_endProfitAmount;
    }

    @Length(min = 1,max = 20)
    public String getSearch_orderNo() {
        return search_orderNo;
    }

    public String getSearch_innings() {
        return search_innings;
    }

    public void setSearch_orderNo(String search_orderNo) {
        this.search_orderNo = search_orderNo;
    }

    public void setSearch_innings(String search_innings) {
        this.search_innings = search_innings;
    }

    public void setSearch_username(String search_username) {
        this.search_username = search_username;
    }

    public void setSearch_beginSingleAmount(Double search_beginSingleAmount) {
        this.search_beginSingleAmount = search_beginSingleAmount;
    }

    public void setSearch_endSingleAmount(Double search_endSingleAmount) {
        this.search_endSingleAmount = search_endSingleAmount;
    }

    public void setSearch_beginEffectiveTradeAmount(Double search_beginEffectiveTradeAmount) {
        this.search_beginEffectiveTradeAmount = search_beginEffectiveTradeAmount;
    }

    public void setSearch_endEffectiveTradeAmount(Double search_endEffectiveTradeAmount) {
        this.search_endEffectiveTradeAmount = search_endEffectiveTradeAmount;
    }

    public void setSearch_beginProfitAmount(Double search_beginProfitAmount) {
        this.search_beginProfitAmount = search_beginProfitAmount;
    }

    public void setSearch_endProfitAmount(Double search_endProfitAmount) {
        this.search_endProfitAmount = search_endProfitAmount;
    }

    public void setSearch_agentusername(String search_agentusername) {
        this.search_agentusername = search_agentusername;
    }
    //endregion your codes 2

}