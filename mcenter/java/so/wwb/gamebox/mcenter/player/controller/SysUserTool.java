package so.wwb.gamebox.mcenter.player.controller;

import org.soul.model.security.privilege.vo.SysUserVo;

import java.util.Date;

/**
 * Created by orange on 16-3-7.
 */
public class SysUserTool {

    private static final String PLAYER_STATUS_BALANCEFREEZE = "4";
    private static final String PLAYER_STATUS_ACCOUNTFREEZE = "3";
    private static final String PLAYER_STATUS_DISABLED = "2";
    private static final String PLAYER_STATUS_ENABLE = "1";

    /**
     * 自定义判断状态类型
     * @param sysUserVo
     */
    public static SysUserVo replaceStatus(SysUserVo sysUserVo){
        if (sysUserVo.getResult().getFreezeStartTime() != null && sysUserVo.getResult().getFreezeEndTime() != null) {
            Date now = new Date();
            if (sysUserVo.getResult().getFreezeEndTime().after(now) && sysUserVo.getResult().getFreezeStartTime().before(now)) {
                if (PLAYER_STATUS_DISABLED.equals(sysUserVo.getResult().getStatus())) {
                    sysUserVo.getResult().setStatus(PLAYER_STATUS_DISABLED);
                    return sysUserVo;
                }else{
                    sysUserVo.getResult().setStatus(PLAYER_STATUS_ACCOUNTFREEZE);
                    return sysUserVo;
                }
            }
        }
        if (sysUserVo.getResult().getStatus() == null) {
            sysUserVo.getResult().setStatus(PLAYER_STATUS_ENABLE);
            return sysUserVo;
        }
        if (PLAYER_STATUS_ENABLE.equals(sysUserVo.getResult().getStatus())) {
            sysUserVo.getResult().setStatus(PLAYER_STATUS_ENABLE);
            return sysUserVo;
        } else if (PLAYER_STATUS_DISABLED.equals(sysUserVo.getResult().getStatus())) {
            sysUserVo.getResult().setStatus(PLAYER_STATUS_DISABLED);
            return sysUserVo;
        }

        return sysUserVo;
    }
}
