package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;
import org.soul.commons.validation.form.constraints.Series;
import org.soul.commons.validation.form.support.SeriesType;
import org.soul.web.support.IForm;

import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;


/**
 * 返佣设置表表单验证对象
 *
 * @author loong
 * @time 2015-9-6 10:06:38
 */
//region your codes 1
public class RebateSetForm implements IForm {
//endregion your codes 1

    //region your codes 2

    //盈利总额 必填，仅支持数值在0—99,999,999（九千九百九十九万）范围内的正整数；
    private BigDecimal[] $rebateGrads$$_totalProfit;

    //有效玩家 必填，仅支持数值在0—999（九百九十九）范围内的正整数；
    private Integer[] $rebateGrads$$_validPlayerNum;
    private BigDecimal[] $rebateGrads$$_maxRebate;

    //有效玩家交易量
    private BigDecimal result_validValue;

    //各个游戏占成
    private BigDecimal[] rebateGrads$$_rebateGradsApis$$_ratio;

    //方案名称
    private String result_name;

    //备注
    private String result_remark;

    @NotNull(message = "setting.rebate.edit.totalProfitNotNull")
    @Range(max = 9999999999999L,min = -9999999999999L,message = "setting.rebate.edit.totalProfitRange")
    @Digits(integer = 13,fraction = 0,message = "setting.rebate.edit.totalProfitDigits")
    @Series(message = "setting.rebate.edit.totalProfitSeries",type = SeriesType.INC)
    public BigDecimal[] get$rebateGrads$$_totalProfit() {
        return $rebateGrads$$_totalProfit;
    }

    public void set$rebateGrads$$_totalProfit(BigDecimal[] $rebateGrads$$_totalProfit) {
        this.$rebateGrads$$_totalProfit = $rebateGrads$$_totalProfit;
    }


    @NotNull(message = "setting.rebate.edit.validPlayerNumNotNull")
    @Range(max = 99999999,min = 0,message = "setting.rebate.edit.validPlayerNumRange")
    @Digits(integer = 8,fraction = 0,message = "setting.rebate.edit.validPlayerNumDigits")
    @Series(message = "setting.rebate.edit.validPlayerNumSeries",type = SeriesType.INC_EQ)
    public Integer[] get$rebateGrads$$_validPlayerNum() {
        return $rebateGrads$$_validPlayerNum;
    }

    public void set$rebateGrads$$_validPlayerNum(Integer[] $rebateGrads$$_validPlayerNum) {
        this.$rebateGrads$$_validPlayerNum = $rebateGrads$$_validPlayerNum;
    }

    @NotNull(message = "setting.rebate.edit.validValueNotNull")
    @Range(max = 9999999999999L,min = 0,message = "setting.rebate.edit.validValueRange")
    @Digits(integer = 13,fraction = 0,message = "setting.rebate.edit.validValueRange")
    public BigDecimal getResult_validValue() {
        return result_validValue;
    }

    public void setResult_validValue(BigDecimal result_validValue) {
        this.result_validValue = result_validValue;
    }

    @NotNull()
    @Range(max = 100,min = 0,message = "setting.rakeback.edit.ratioRange")
    @Digits(integer = 3,fraction = 2,message = "setting.rakeback.edit.ratioDigits")
    public BigDecimal[] getRebateGrads$$_rebateGradsApis$$_ratio() {
        return rebateGrads$$_rebateGradsApis$$_ratio;
    }

    public void setRebateGrads$$_rebateGradsApis$$_ratio(BigDecimal[] rebateGrads$$_rebateGradsApis$$_ratio) {
        this.rebateGrads$$_rebateGradsApis$$_ratio = rebateGrads$$_rebateGradsApis$$_ratio;
    }

    @NotBlank()
    @Length(max = 20,min = 1)
    public String getResult_name() {
        return result_name;
    }

    public void setResult_name(String result_name) {
        this.result_name = result_name;
    }

    @Length(min = 1,max = 200)
    public String getResult_remark() {
        return result_remark;
    }

    public void setResult_remark(String result_remark) {
        this.result_remark = result_remark;
    }

    @Range(max = 9999999999999L,min = 1,message = "setting.rebate.edit.maxRakebackRange")
    @Digits(integer = 13,fraction = 0,message = "setting.rebate.edit.maxRakebackFormt")
    public BigDecimal[] get$rebateGrads$$_maxRebate() {
        return $rebateGrads$$_maxRebate;
    }

    public void set$rebateGrads$$_maxRebate(BigDecimal[] $rebateGrads$$_maxRebate) {
        this.$rebateGrads$$_maxRebate = $rebateGrads$$_maxRebate;
    }

    //endregion your codes 2

}