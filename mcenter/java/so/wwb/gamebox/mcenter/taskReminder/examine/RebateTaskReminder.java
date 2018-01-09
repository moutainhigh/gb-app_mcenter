package so.wwb.gamebox.mcenter.taskReminder.examine;

import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.mcenter.taskReminder.TaskReminder;
import so.wwb.gamebox.model.master.operation.vo.RebateBillVo;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;

/**
 * 返佣结算审批
 *
 * Created by bruce on 16-10-18.
 */
public class RebateTaskReminder extends TaskReminder {

    @Override
    public void setTaskReminder(UserTaskReminder userTaskReminder) {
        userTaskReminder.setTaskNum(countTask());
    }

    @Override
    public Integer countTask() {
        return ServiceSiteTool.rebateBillService().countPendingAndPartPayForRebate(new RebateBillVo());
    }
}
