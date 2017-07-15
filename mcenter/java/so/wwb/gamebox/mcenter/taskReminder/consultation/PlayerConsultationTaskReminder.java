package so.wwb.gamebox.mcenter.taskReminder.consultation;

import org.soul.commons.lang.DateTool;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.taskReminder.TaskReminder;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.master.player.enums.PlayerAdvisoryEnum;
import so.wwb.gamebox.model.master.player.po.VPlayerAdvisory;
import so.wwb.gamebox.model.master.player.vo.VPlayerAdvisoryListVo;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;

import java.util.Date;

/**
 * 玩家咨询
 *
 * Created by bruce on 16-10-18.
 */
public class PlayerConsultationTaskReminder extends TaskReminder {

    @Override
    public void setTaskReminder(UserTaskReminder userTaskReminder) {
        userTaskReminder.setTaskNum(countTask());
    }

    @Override
    public Integer countTask() {
        VPlayerAdvisoryListVo aListVo = new VPlayerAdvisoryListVo();
        aListVo.getSearch().setAdvisoryTime(DateTool.addDays(new Date(), -30));
        aListVo.getSearch().setQuestionType(PlayerAdvisoryEnum.QUESTION.getCode());
        aListVo.setPaging(null);
        aListVo = ServiceTool.vPlayerAdvisoryService().search(aListVo);
        aListVo.changeReadState(SessionManager.getUserId());//判断是否已读
        Integer advisoryUnReadCount = 0;
        for (VPlayerAdvisory obj : aListVo.getResult()) {
            if (!obj.getRead()) {
                advisoryUnReadCount++;
            }
        }
        return advisoryUnReadCount;
    }
}
