package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.Length;
import org.soul.web.support.IForm;


/**
 * 限制访问站点的地区表表单验证对象
 *
 * @author loong
 * @time 2015-8-11 11:17:30
 */
//region your codes 1
public class TrafficStatisticsForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String result_trafficStatistics;
    @Length(max = 1000)
    public String getResult_trafficStatistics() {
        return result_trafficStatistics;
    }

    public void setResult_trafficStatistics(String result_trafficStatistics) {
        this.result_trafficStatistics = result_trafficStatistics;
    }
    //endregion your codes 2
}