package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;
import org.soul.commons.validation.form.constraints.Series;
import org.soul.commons.validation.form.support.SeriesType;
import org.soul.web.support.IForm;

import javax.validation.constraints.DecimalMax;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;


/**
 * 返水设置表表单验证对象
 *
 * @author loong
 * @time 2015-9-6 10:06:13
 */
//region your codes 1
public class RakebackSetForm implements IForm {
//endregion your codes 1

    //region your codes 2
    /*必填　１－２０字符*/
    private String result_name;
    /*1-99*/
    private BigDecimal result_auditNum;

    /*备注　非必填，1—200个字符，类型不限；*/
    private String result_remark;

    /*有效交易量　必填，仅支持数值在0—99,999，999（九千九百九十九万）范围内的正整数；*/
    private BigDecimal[] rakebackGrads$$_validValue;
    /*每期返水上限　非必填，仅支持数值在1—99,999，999（九千九百九十九万）范围内的正整数；*/
    private BigDecimal[] rakebackGrads$$_maxRakeback;

    /*api占比　必填，支持数值在0—100以内的正数和小数（可为0和100）；*/
    private BigDecimal rakebackGrads$$_rakebackGradsApis$$_ratio;

    @NotBlank()
    @Length(max = 20,min = 1)
    public String getResult_name() {
        return result_name;
    }

    public void setResult_name(String result_name) {
        this.result_name = result_name;
    }

    @Digits(integer = 3,fraction = 2,message = "setting.rakeback.edit.auditNum")
    @DecimalMin(value = "0.01",message = "setting.rakeback.edit.auditNum")
    @DecimalMax(value = "100",message = "setting.rakeback.edit.auditNum")
    public BigDecimal getResult_auditNum() {
        return result_auditNum;
    }

    public void setResult_auditNum(BigDecimal result_auditNum) {
        this.result_auditNum = result_auditNum;
    }

    @Length(min = 1,max = 200)
    public String getResult_remark() {
        return result_remark;
    }

    public void setResult_remark(String result_remark) {
        this.result_remark = result_remark;
    }

    @NotNull(message = "setting.rakeback.edit.validValueNotNull")
    @Range(max = 99999999,min = 0,message = "setting.rakeback.edit.validValueRange")
    @Digits(integer = 8,fraction = 0,message = "setting.rakeback.edit.validValueFormt")
    @Series(message = "setting.rakeback.edit.validValueSeries",type = SeriesType.INC)
    public BigDecimal[] getRakebackGrads$$_validValue() {
        return rakebackGrads$$_validValue;
    }
    public void setRakebackGrads$$_validValue(BigDecimal[] rakebackGrads$$_validValue) {
        this.rakebackGrads$$_validValue = rakebackGrads$$_validValue;
    }

    @Range(max = 99999999,min = 1,message = "setting.rakeback.edit.maxRakebackRange")
    @Digits(integer = 8,fraction = 0,message = "setting.rakeback.edit.maxRakebackFormt")
    public BigDecimal[] getRakebackGrads$$_maxRakeback() {
        return rakebackGrads$$_maxRakeback;
    }

    public void setRakebackGrads$$_maxRakeback(BigDecimal[] rakebackGrads$$_maxRakeback) {
        this.rakebackGrads$$_maxRakeback = rakebackGrads$$_maxRakeback;
    }

    @NotNull()
    @Range(max = 100,min = 0,message = "setting.rakeback.edit.ratioRange")
    @Digits(integer = 3,fraction = 2,message = "setting.rakeback.edit.ratioDigits")
    public BigDecimal getRakebackGrads$$_rakebackGradsApis$$_ratio() {
        return rakebackGrads$$_rakebackGradsApis$$_ratio;
    }

    public void setRakebackGrads$$_rakebackGradsApis$$_ratio(BigDecimal rakebackGrads$$_rakebackGradsApis$$_ratio) {
        this.rakebackGrads$$_rakebackGradsApis$$_ratio = rakebackGrads$$_rakebackGradsApis$$_ratio;
    }

    //endregion your codes 2

}