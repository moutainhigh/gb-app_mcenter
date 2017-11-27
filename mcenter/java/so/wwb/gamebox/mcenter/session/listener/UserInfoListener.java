package so.wwb.gamebox.mcenter.session.listener;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.model.passport.vo.PassportVo;
import org.soul.model.security.privilege.po.SysUser;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.web.shiro.common.delegate.PassportEvent;
import org.soul.web.shiro.common.delegate.PassportListenerAdapter;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.common.Const;
import so.wwb.gamebox.model.company.sys.po.SysSite;
import so.wwb.gamebox.model.company.sys.vo.SysSiteListVo;

import java.util.List;

/**
 * Created by longer on 6/18/15.
 */
public class UserInfoListener extends PassportListenerAdapter {

    private Log log = LogFactory.getLog(UserInfoListener.class);

    @Override
    public void onLoginSuccess(PassportEvent passportEvent) {
        SysUser sysUser = passportEvent.getSysUser();
        log.debug( "站长中心登录成功:{0}-{1}-{2}" ,sysUser.getUserType(),sysUser.getId(),sysUser.getUsername());
        SysUserVo mastervo = new SysUserVo();
        mastervo._setDataSourceId(SessionManager.getSiteParentId());
        mastervo.getSearch().setId(SessionManager.getSiteUserId());
        mastervo = ServiceTool.sysUserService().get(mastervo);
        SessionManager.setMasterInfo(mastervo.getResult());

        if (String.valueOf(PassportVo.MASTER).equals(SessionManager.getEntrance())) {
            //站长登录
            //查询站长拥有的站点信息列表
            SysSiteListVo listVo = new SysSiteListVo();
            listVo.getSearch().setSysUserId(sysUser.getId());
            listVo = ServiceTool.sysSiteService().bySysUserId(listVo);
            List<SysSite> sysSite = listVo.getResult();
            List<Integer> siteIds = CollectionTool.extractToList(sysSite, SysSite.PROP_ID);
            SessionManager.setUserOwnSites(siteIds);
            SysUser user = SessionManager.getUser();
            SessionManager.setMasterUserId(user.getId());
            user.setId(Const.MASTER_BUILT_IN_ID);
            SessionManager.setUser(user);
            SessionManager.setUserId(Const.MASTER_BUILT_IN_ID);
        }else{
            if(mastervo.getResult()!=null){
                SessionManager.setMasterUserId(mastervo.getResult().getId());
            }

        }

        //是否提醒消息session标识
        SessionManager.setIsReminderMsg(true);
    }

}
