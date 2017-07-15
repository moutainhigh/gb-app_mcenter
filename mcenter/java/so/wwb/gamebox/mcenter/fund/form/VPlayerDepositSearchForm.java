package so.wwb.gamebox.mcenter.fund.form;

import org.hibernate.validator.constraints.Range;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;


/**
 * Fei - 玩家存款列表视图查询表单验证对象
 *
 * @author fei
 * @time 2016-7-7 9:18:05
 */
//region your codes 1
public class VPlayerDepositSearchForm implements IForm {
//endregion your codes 1

    //region your codes 2

    private Double search_beginAmount;
    private Double search_endAmount;

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


    //endregion your codes 2

}