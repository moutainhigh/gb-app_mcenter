package so.wwb.gamebox.mcenter.taskReminder;

import org.soul.commons.spring.PropertiesLoader;
import so.wwb.gamebox.mcenter.taskReminder.consultation.PlayerConsultationTaskReminder;
import so.wwb.gamebox.mcenter.taskReminder.examine.*;
import so.wwb.gamebox.mcenter.taskReminder.pay.FreezeOnlineTaskReminder;
import so.wwb.gamebox.mcenter.taskReminder.pay.FreezeTaskReminder;
import so.wwb.gamebox.mcenter.taskReminder.pay.PayTaskReminder;
import so.wwb.gamebox.mcenter.taskReminder.pay.TwoSituationTaskReminder;
import so.wwb.gamebox.model.master.enums.PayAccountType;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * Created by bruce on 16-10-18.
 */
public class TaskReminderHelp {

    private static Map<String,TaskReminder> taskReminderTypeMap = new HashMap<>();

    private TaskReminderHelp() {}

    static {
        PropertiesLoader propertiesLoader = new PropertiesLoader("/conf/app/taskReminder.properties");
        Set<Map.Entry<Object, Object>> entries = propertiesLoader.getProperties().entrySet();
        for (Map.Entry<Object, Object> entry : entries) {
            String key = (String) entry.getKey();
            try {
                taskReminderTypeMap.put(key,(TaskReminder)Class.forName((String) entry.getValue()).newInstance());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    public static TaskReminder getInstance(String taskRemindType) {
        return  taskReminderTypeMap.get(taskRemindType);
    }

    public static Integer countTask() {
        Integer countTask = 0;
        Collection<TaskReminder> taskReminderCollection = taskReminderTypeMap.values();
        for (TaskReminder taskReminder : taskReminderCollection) {
            countTask += taskReminder.countTask();
        }
        return countTask;
    }
}
