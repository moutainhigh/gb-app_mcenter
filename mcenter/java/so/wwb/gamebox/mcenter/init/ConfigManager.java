package so.wwb.gamebox.mcenter.init;

import org.soul.commons.spring.utils.SpringTool;
import org.springframework.stereotype.Component;
import so.wwb.gamebox.web.init.ConfigBase;

/**
 * Created by Kevice on 2015/3/26 0026.
 */
@Component
public class ConfigManager extends ConfigBase {
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
    public static ConfigManager get() {
        return SpringTool.getBean(ConfigManager.class);
    }
}
