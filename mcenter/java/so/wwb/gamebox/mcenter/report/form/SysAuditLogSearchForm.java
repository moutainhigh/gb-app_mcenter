package so.wwb.gamebox.mcenter.report.form;

import org.soul.web.support.IForm;

import java.util.Date;

/**
 * @author fly
 * @time 2015-11-06 11:04
 */
public class SysAuditLogSearchForm implements IForm {

    //开始时间
    private Date search_operatorBegin;
    private Date search_operatorEnd;
    public Date getSearch_operatorBegin() {
        return search_operatorBegin;
    }
    public Date getSearch_operatorEnd() {
        return search_operatorEnd;
    }

    public void setSearch_operatorBegin(Date search_operatorBegin) {
        this.search_operatorBegin = search_operatorBegin;
    }
}
