package so.wwb.gamebox.mcenter.lottery.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;

import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;


/**
 * 限额设置查询表单验证对象
 *
 * @author admin
 * @time 2017-4-11 19:24:18
 */
//region your codes 1
public class SiteLotteryQuotaSearchForm implements IForm {
    //endregion your codes 1
    private String[] quotaList$$_numQuota;
    private String[] quotaList$$_betQuota;
    private String[] quotaList$$_playQuota;
    //region your codes 2

    @NotBlank(message = "common.不能为空")
    @Pattern(message = "operation_auto.请输入正整数", regexp = "^\\d+(\\.0)?$")
    @Min(message = "operation_auto.请输入正整数", value = 1)
    public String[] getQuotaList$$_numQuota() {
        return quotaList$$_numQuota;
    }

    public void setQuotaList$$_numQuota(String[] quotaList$$_numQuota) {
        this.quotaList$$_numQuota = quotaList$$_numQuota;
    }

    @NotBlank(message = "common.不能为空")
    @Pattern(message = "operation_auto.请输入正整数", regexp = "^\\d+(\\.0)?$")
    @Min(message = "operation_auto.请输入正整数", value = 1)
    public String[] getQuotaList$$_betQuota() {
        return quotaList$$_betQuota;
    }

    public void setQuotaList$$_betQuota(String[] quotaList$$_betQuota) {
        this.quotaList$$_betQuota = quotaList$$_betQuota;
    }

    @NotBlank(message = "common.不能为空")
    @Pattern(message = "operation_auto.请输入正整数", regexp = "^\\d+(\\.0)?$")
    @Min(message = "operation_auto.请输入正整数", value = 1)
    public String[] getQuotaList$$_playQuota() {
        return quotaList$$_playQuota;
    }

    public void setQuotaList$$_playQuota(String[] quotaList$$_playQuota) {
        this.quotaList$$_playQuota = quotaList$$_playQuota;
    }

    //endregion your codes 2

}