package so.wwb.gamebox.mcenter.tools;

import org.soul.model.comet.vo.MessageVo;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.CompanyParamEnum;
import so.wwb.gamebox.model.common.notice.enums.CometSubscribeType;
import so.wwb.gamebox.model.master.enums.UserTaskEnum;
import so.wwb.gamebox.model.master.tasknotify.vo.UserTaskReminderVo;

/**
 * Created by Administrator on 2016/5/21.
 */
public class SendMessageTool {


	public static void sendAuditMessageToCcenter(){
		MessageVo messageVo = new MessageVo();
		messageVo.setSiteId(SessionManager.getSiteParentId());
		messageVo.setSubscribeType(CometSubscribeType.MCENTER_PLAYER_AUDIO.getCode());
		messageVo.setMsgBody(CompanyParamEnum.WARMING_TONE_AUDIT.getCode());
		messageVo.setSendToUser(true);
		ServiceTool.messageService().sendToCcenterMsg(messageVo);
	}

	public static void addTaskReminder(UserTaskEnum taskEnum){
		UserTaskReminderVo userTaskReminderVo = new UserTaskReminderVo();
		userTaskReminderVo.setTaskEnum(taskEnum);
		userTaskReminderVo._setDataSourceId(SessionManager.getSiteParentId());
		ServiceTool.userTaskReminderService().addTaskReminder(userTaskReminderVo);
	}
}
