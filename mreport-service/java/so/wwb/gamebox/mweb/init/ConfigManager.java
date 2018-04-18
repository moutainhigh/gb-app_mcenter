package so.wwb.gamebox.mweb.init;

import org.soul.commons.spring.utils.SpringTool;

/**
 * Created by tony on 15-4-28.
 */
public class ConfigManager {

    public static ServiceConf getConfigration() {
        return SpringTool.getBean(ServiceConf.class);
    }

}
