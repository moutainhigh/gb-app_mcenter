package so.wwb.gamebox.mcenter.taskReminder;

import org.soul.commons.collections.MapTool;
import org.soul.commons.spring.PropertiesLoader;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * Created by bruce on 16-10-18.
 */
public class TaskReminderHelp {

    private static Map<String, TaskReminder> taskReminderTypeMap = new HashMap<>();

    private TaskReminderHelp() {
    }

    static {
        PropertiesLoader propertiesLoader = new PropertiesLoader("/conf/app/taskReminder.properties");
        Set<Map.Entry<Object, Object>> entries = propertiesLoader.getProperties().entrySet();
        for (Map.Entry<Object, Object> entry : entries) {
            String key = (String) entry.getKey();
            try {
                taskReminderTypeMap.put(key, (TaskReminder) Class.forName((String) entry.getValue()).newInstance());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    public static TaskReminder getInstance(String taskRemindType) {
        return taskReminderTypeMap.get(taskRemindType);
    }

    public static Integer countTask() {
        Integer countTask = 0;
        Collection<TaskReminder> taskReminderCollection = taskReminderTypeMap.values();
        for (TaskReminder taskReminder : taskReminderCollection) {
            countTask += taskReminder.countTask();
        }
        return countTask;
    }

    /**
     * 返回当前任务情况
     *
     * @return
     */
    public static Map<String, Integer> taskSituation() {
        if (MapTool.isEmpty(taskReminderTypeMap)) {
            return new HashMap<>(0);
        }
        Map<String, Integer> taskMap = new HashMap<>(taskReminderTypeMap.size(), 1f);
        for (Map.Entry<String, TaskReminder> entry : taskReminderTypeMap.entrySet()) {
            taskMap.put(entry.getKey(), entry.getValue().countTask());
        }
        return taskMap;
    }
}
