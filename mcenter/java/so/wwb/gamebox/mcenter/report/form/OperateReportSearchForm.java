package so.wwb.gamebox.mcenter.report.form;

import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;


/**
 * 经营报表查询表单验证对象
 * create by Fei on 2016-06-15
 */
//region your codes 1
public class OperateReportSearchForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String search_agentName;
    private String search_topagentName;
    @Pattern(message = "report.valid.roleName", regexp = FormValidRegExps.ACCOUNT)
    public String getSearch_agentName() {
        return search_agentName;
    }

    public void setSearch_agentName(String search_agentName) {
        this.search_agentName = search_agentName;
    }

    @Pattern(message = "report.valid.roleName", regexp = FormValidRegExps.ACCOUNT)
    public String getSearch_topagentName() {
        return search_topagentName;
    }

    public void setSearch_topagentName(String search_topagentName) {
        this.search_topagentName = search_topagentName;
    }
    //endregion your codes 2

}