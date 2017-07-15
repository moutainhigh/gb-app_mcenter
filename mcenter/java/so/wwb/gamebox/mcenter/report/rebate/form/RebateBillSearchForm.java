package so.wwb.gamebox.mcenter.report.rebate.form;

import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;


/**
 * 返佣结算表查询表单验证对象
 *
 * @author shisongbin
 * @time 2015-9-9 17:37:32
 */
//region your codes 1
public class RebateBillSearchForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String search_playerName;
    private String search_agentName;
    private String search_topagentName;

    @Pattern(message = "report.valid.roleName", regexp = FormValidRegExps.ACCOUNT)
    public String getSearch_playerName() {
        return search_playerName;
    }

    public void setSearch_playerName(String search_playerName) {
        this.search_playerName = search_playerName;
    }

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