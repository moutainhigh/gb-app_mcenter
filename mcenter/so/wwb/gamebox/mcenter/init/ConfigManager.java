package so.wwb.gamebox.mcenter.init;

import org.soul.commons.spring.utils.SpringTool;
import org.soul.web.init.BaseConfigManager;
import so.wwb.gamebox.web.init.ExtBaseConfigManager;

/**
 * Created by tony on 15-4-28.
 * 配置信息管理对象
 */
public class ConfigManager extends ExtBaseConfigManager {

    /**
     * MCenter配置信息
     * @return
     */
    public static MCenterConfigration getConfigration() {
        return SpringTool.getBean(MCenterConfigration.class);
    }

}
