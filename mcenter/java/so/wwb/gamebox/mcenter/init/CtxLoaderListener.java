package so.wwb.gamebox.mcenter.init;

import org.soul.web.init.BaseCtxLoaderListener;
import so.wwb.gamebox.web.init.CommonCtxLoaderListener;

import javax.servlet.ServletContextEvent;
import java.util.TimeZone;

/**
 * Created by Kevice on 2015/3/23 0023.`
 */
public class CtxLoaderListener extends CommonCtxLoaderListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        TimeZone.setDefault(TimeZone.getTimeZone("UTC")); // 设置JVM默认时区为０时区
        super.contextInitialized(event);
    }
}
