package so.wwb.gamebox.mcenter.taskReminder.examine;

import so.wwb.gamebox.mcenter.taskReminder.TaskReminder;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.master.operation.vo.ActivityPlayerApplyVo;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;

import java.util.Date;
import java.util.Map;

/**
 * 优惠申请审批
 *
 * Created by bruce on 16-10-18.
 */
public class PreferentialTaskReminder extends TaskReminder {

    @Override
    public void setTaskReminder(UserTaskReminder userTaskReminder) {
        userTaskReminder.setTaskNum(countTask());
        userTaskReminder.setUpdateTime((Date)getPreferentialData().get("applytime"));
    }

    @Override
    public Integer countTask() {
        return ((Long) getPreferentialData().get("pcount")).intValue();

    }

    private Map getPreferentialData() {
        return ServiceTool.activityPlayerApplyService().countPendingPlayers(new ActivityPlayerApplyVo());
    }
}
