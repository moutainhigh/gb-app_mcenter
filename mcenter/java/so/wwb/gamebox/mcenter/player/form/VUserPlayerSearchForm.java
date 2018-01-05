package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.Range;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;
import so.wwb.gamebox.mcenter.player.controller.PlayerController;

import javax.validation.constraints.Digits;
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

    /** 存款次数 */
    private  Integer search_rechargeCountBegin;
    private  Integer search_rechargeCountEnd;

    /** 取款次数 */
    private  Integer search_txCountBegin;
    private  Integer search_txCountEnd;

    /*登录IP*/
    private  String search_lastLoginIpv4;
    /*注册IP*/
    private  String search_registerIpv4;
    /*注册URL*/
    private  String search_registerSite;
    /*银行卡*/
    private  String search_bankcardNumber;

    @Pattern(message = "passport.edit.info.bank.card.format.error",regexp = FormValidRegExps.BANK)
    @Length(min = 10,max = 25)
    public String getSearch_bankcardNumber(){return search_bankcardNumber;}

    //@Pattern(regexp = FormValidRegExps.IP)
    @Remote(message = "登录IP不合法",checkMethod = "checkLoginIp",checkClass = PlayerController.class)
    public String getSearch_lastLoginIpv4(){return search_lastLoginIpv4;}

    //@Pattern(regexp = FormValidRegExps.IP)
    @Remote(message = "注册IP不合法",checkMethod = "checkRegIp",checkClass = PlayerController.class)
    public String getSearch_registerIpv4(){return search_registerIpv4;}

    @Pattern(regexp = FormValidRegExps.PREFIX_LINK)
    public String getSearch_registerSite(){return search_registerSite;}


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

    @Range(min = 0, max = 99999999)
    @Digits(integer = 8, fraction = 0,message = "请输入0或正整数")
    public Integer getSearch_rechargeCountBegin() {
        return search_rechargeCountBegin;
    }

    @Range(min = 0, max = 99999999)
    @Digits(integer = 8, fraction = 0,message = "请输入0或正整数")
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "search_rechargeCountBegin")
    public Integer getSearch_rechargeCountEnd() {
        return search_rechargeCountEnd;
    }

    @Range(min = 0, max = 99999999)
    @Digits(integer = 8, fraction = 0,message = "请输入0或正整数")
    public Integer getSearch_txCountBegin() {
        return search_txCountBegin;
    }

    @Range(min = 0, max = 99999999)
    @Digits(integer = 8, fraction = 0,message = "请输入0或正整数")
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin", logic = CompareLogic.GE, anotherProperty = "search_txCountBegin")
    public Integer getSearch_txCountEnd() {
        return search_txCountEnd;
    }
    //endregion your codes 2

}