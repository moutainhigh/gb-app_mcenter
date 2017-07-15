package so.wwb.gamebox.mcenter.taskReminder;

import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;

/**
 * Created by bruce on 16-10-18.
 */
public abstract class TaskReminder {

    /**
     * 设置任务信息
     *
     * @param userTaskReminder
     */
    public abstract void setTaskReminder(UserTaskReminder userTaskReminder);

    /**
     * 统计任务数
     * @return
     */
    public abstract Integer countTask();
}
