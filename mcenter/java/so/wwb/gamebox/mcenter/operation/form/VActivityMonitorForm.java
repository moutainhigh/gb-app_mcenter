package so.wwb.gamebox.mcenter.operation.form;

import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;


/**
 * 活动效果监控视图表单验证对象
 *
 * @author steffan
 * @time 2018-3-18 11:13:42
 */
//region your codes 1
public class VActivityMonitorForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String search_ipApplyStr;

    @Pattern(regexp = FormValidRegExps.IP)
    public String getSearch_ipApplyStr() {
        return search_ipApplyStr;
    }

    public void setSearch_ipApplyStr(String search_ipApplyStr) {
        this.search_ipApplyStr = search_ipApplyStr;
    }
    //endregion your codes 2

}