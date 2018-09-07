package so.wwb.gamebox.mweb.init;

import org.soul.commons.spring.utils.SpringTool;
import org.soul.commons.support.CommonConf;
import org.springframework.beans.factory.annotation.Value;


/**
 * Created by Kevice on 2015/3/25 0025.
 */
public class ConfigManager extends CommonConf {

    @Value("${filesite.uri}")
    private String fileRoot;
    @Value("${exportFile.catePath}")
    private String catePath;
    public ConfigManager(String dubboApplicationName, String version){
        super(dubboApplicationName,version);
    }
    /**
     *
     * @return 站点文件根URL
     */
    public String getFileRoot() {
        return fileRoot;
    }

    /**
     *
     * @return 导出组件导出的文件存储在文件服务器上的目录名
     */
    public String getCatePath() {
        return catePath;
    }
    public static ConfigManager get() {
        return SpringTool.getBean(ConfigManager.class);
    }

}
