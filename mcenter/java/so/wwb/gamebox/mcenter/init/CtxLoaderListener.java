package so.wwb.gamebox.mcenter.init;

import org.soul.web.init.BaseCtxLoaderListener;
import so.wwb.gamebox.web.init.CommonCtxLoaderListener;

import javax.servlet.ServletContextEvent;
import java.util.TimeZone;

/**
 * Created by Kevice on 2015/3/23 0023.`
 */
public class CtxLoaderListener extends CommonCtxLoaderListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        TimeZone.setDefault(TimeZone.getTimeZone("UTC")); // 设置JVM默认时区为０时区
        super.contextInitialized(event);
//        ITaskScheduleService taskScheduleService = ServiceTool.taskScheduleService();
////        ITaskRunRecordService taskRunRecordService = ServiceTool.taskRunRecordService();
//
//        try {
//
//            Scheduler scheduler = SpringTool.getBean(Scheduler.class);
//            TaskScheduleListVo taskScheduleListVo = new TaskScheduleListVo();
//            TaskRunRecordVo taskRunRecordVo = new TaskRunRecordVo();
//            //TODO MARK 此处暂时保存至master库，到时再改。
//            taskScheduleListVo._setMasterId(1);
//            taskRunRecordVo._setMasterId(1);
//             //系统启动时如果存在未执行完成的日志记录，则删除之。
////            taskRunRecordService.deleteDirtyData(taskRunRecordVo);
//
//            List<TaskSchedule> taskSchedules = taskScheduleService.allSearch(taskScheduleListVo);
//            ScheduleTool.init(scheduler, taskSchedules);
//        } catch (SchedulerException e) {
//            e.printStackTrace();
//        }
    }
}
