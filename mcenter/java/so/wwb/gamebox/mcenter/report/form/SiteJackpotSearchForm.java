package so.wwb.gamebox.mcenter.report.form;

import org.soul.web.support.IForm;

import javax.validation.constraints.Pattern;
import java.util.Date;


/**
 * 站点彩池贡献金统计查询表单验证对象
 *
 * @author linsen
 * @time 2018-1-18 21:41:59
 */
//region your codes 1
public class SiteJackpotSearchForm implements IForm {
//endregion your codes 1

    private Date search_staticMonth;
    //region your codes 2

    @Pattern(regexp = "^\\d{4}\\-0[1-9]|1[0-2]$")
    public Date getSearch_staticMonth() {
        return search_staticMonth;
    }

    public void setSearch_staticMonth(Date search_staticMonth) {
        this.search_staticMonth = search_staticMonth;
    }
    //endregion your codes 2

}