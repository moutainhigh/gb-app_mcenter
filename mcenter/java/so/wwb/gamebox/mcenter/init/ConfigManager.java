package so.wwb.gamebox.mcenter.init;

import org.soul.commons.spring.utils.SpringTool;

/**
 * Created by tony on 15-4-28.
 * 配置信息管理对象
 */
public class ConfigManager extends so.wwb.gamebox.web.init.ConfigBase {

    /**
     * MCenter配置信息
     * @return
     */
    public static MCenterConfigration get() {
        return SpringTool.getBean(MCenterConfigration.class);
    }

}
