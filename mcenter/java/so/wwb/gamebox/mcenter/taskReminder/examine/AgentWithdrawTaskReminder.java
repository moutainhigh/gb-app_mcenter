package so.wwb.gamebox.mcenter.taskReminder.examine;

import so.wwb.gamebox.mcenter.taskReminder.TaskReminder;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.master.fund.vo.AgentWithdrawOrderVo;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;

/**
 * 代理取款审批
 *
 * Created by bruce on 16-10-18.
 */
public class AgentWithdrawTaskReminder extends TaskReminder {

    @Override
    public void setTaskReminder(UserTaskReminder userTaskReminder) {
        userTaskReminder.setTaskNum(countTask());
    }

    @Override
    public Integer countTask() {
        return ServiceTool.agentWithdrawOrderService().countPendingWithdrawForAgent(new AgentWithdrawOrderVo());
    }
}
