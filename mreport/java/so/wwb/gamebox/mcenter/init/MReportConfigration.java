package so.wwb.gamebox.mcenter.init;

import org.springframework.stereotype.Component;
import so.wwb.gamebox.web.init.ExtBaseWebConf;

/**
 * Created by Kevice on 2015/3/26 0026.
 */
@Component
public class MReportConfigration extends ExtBaseWebConf {
    /**
     * 总代理SubSysCode
     * @return
     */
    public String getTopAgentSubSysCode() {
        return this.getSubsysCode()+"TopAgent";
    }
    /**
     * 代理SubSysCode
     * @return
     */
    public String getAgentSubSysCode() {
        return this.getSubsysCode()+"Agent";
    }
}
