package so.wwb.gamebox.mcenter.taskReminder.examine;

import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.taskReminder.TaskReminder;
import so.wwb.gamebox.model.master.operation.vo.RakebackBillVo;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;

/**
 * 返水结算审批
 *
 * Created by bruce on 16-10-18.
 */
public class RakebackTaskReminder extends TaskReminder {

    @Override
    public void setTaskReminder(UserTaskReminder userTaskReminder) {
        userTaskReminder.setTaskNum(countTask());
    }

    @Override
    public Integer countTask() {
        return ServiceTool.rakebackBillService().countPendingAndPartPayForRakeback(new RakebackBillVo());
    }
}
