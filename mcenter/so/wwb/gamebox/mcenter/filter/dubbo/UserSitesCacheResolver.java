package so.wwb.gamebox.mcenter.filter.dubbo;

import org.soul.commons.collections.MapTool;
import org.soul.commons.dubbo.IUserSitesCacheResolver;
import org.soul.commons.init.context.ContextParam;
import so.wwb.gamebox.model.company.sys.po.VSysSiteUser;
import so.wwb.gamebox.web.cache.Cache;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by longer on 11/18/15.
 */
public class UserSitesCacheResolver implements IUserSitesCacheResolver {

    @Override
    public List<Integer> getSiteIds(ContextParam contextParam) {
        Map<String,VSysSiteUser> map = Cache.getSysSiteUser();
        if (MapTool.isEmpty(map)) {
            return null;
        }
        List<Integer> sites = new ArrayList<>();
        for (Map.Entry<String,VSysSiteUser> entry : map.entrySet()) {
            VSysSiteUser sysSiteUser = entry.getValue();
            //获取站长放下的站点ID
            if (sysSiteUser.getSysUserId().equals(contextParam.getSiteUserId())) {
                sites.add(sysSiteUser.getId());
            }
        }
        //站长需要访问mainsite
        sites.add(contextParam.getSiteParentId());
        return sites;
    }
}
