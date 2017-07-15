package so.wwb.gamebox.mcenter.taskReminder.examine;

import so.wwb.gamebox.mcenter.taskReminder.TaskReminder;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.master.player.vo.VUserAgentManageVo;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;

/**
 * 代理注册审批
 *
 * Created by bruce on 16-10-18.
 */
public class AgentRegTaskReminder extends TaskReminder {

    @Override
    public void setTaskReminder(UserTaskReminder userTaskReminder) {
        userTaskReminder.setTaskNum(countTask());
    }

    @Override
    public Integer countTask() {
        return ServiceTool.vUserAgentManageService().countPendingAgent(new VUserAgentManageVo());
    }
}
