package so.wwb.gamebox.mcenter.taskReminder.examine;

import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.taskReminder.TaskReminder;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.dataRight.DataRightModuleType;
import so.wwb.gamebox.model.master.dataRight.vo.SysUserDataRightVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerWithdrawListVo;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;

import java.util.List;

/**
 * 玩家取款审批
 *
 * Created by bruce on 16-10-18.
 */
public class PlayerWithdrawTaskReminder extends TaskReminder {

    @Override
    public void setTaskReminder(UserTaskReminder userTaskReminder) {
        userTaskReminder.setTaskNum(countTask());
    }

    @Override
    public Integer countTask() {

        VPlayerWithdrawListVo vPlayerWithdrawListVo = new VPlayerWithdrawListVo();

        if (UserTypeEnum.MASTER_SUB.getCode().equals(SessionManager.getUser().getUserType())) {
            SysUserDataRightVo sysUserDataRightVo = new SysUserDataRightVo();
            sysUserDataRightVo.getSearch().setUserId(SessionManager.getUserId());
            sysUserDataRightVo.getSearch().setModuleType(DataRightModuleType.PLAYERWITHDRAW.getCode());
            List entityIds = ServiceSiteTool.sysUserDataRightService().searchDataRightEntityId(sysUserDataRightVo);
            if (entityIds != null && entityIds.size() > 0) {
                vPlayerWithdrawListVo.getSearch().setRankIds(entityIds);
                return ServiceSiteTool.vPlayerWithdrawService().countPendingwithdrawForPlayer(vPlayerWithdrawListVo);
            }  else {
                return ServiceSiteTool.vPlayerWithdrawService().countPendingwithdrawForPlayer(vPlayerWithdrawListVo);
            }
        } else {
            return ServiceSiteTool.vPlayerWithdrawService().countPendingwithdrawForPlayer(vPlayerWithdrawListVo);
        }
    }
}
