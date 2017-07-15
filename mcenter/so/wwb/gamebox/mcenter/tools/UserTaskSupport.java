package so.wwb.gamebox.mcenter.tools;

import org.soul.commons.data.json.JsonTool;
import org.soul.commons.locale.LocaleTool;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.master.enums.UserTaskEnum;
import so.wwb.gamebox.model.master.enums.UserTaskParentCodeEnum;
import so.wwb.gamebox.model.master.fund.vo.VPlayerDepositVo;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by younger on 2016/9/28.
 */
public class UserTaskSupport {

	public static String buildTaskReminder(UserTaskReminder userTaskReminder){
		String str="";
		if(UserTaskParentCodeEnum.EXAMINE.getCode().equals(userTaskReminder.getParentCode())){
			Integer taskNum = userTaskReminder.getTaskNum();
			if(UserTaskEnum.RECHARGE.getCode().equals(userTaskReminder.getDictCode())){
				taskNum = ServiceTool.vPlayerDepositService().countCompanyDeposit(new VPlayerDepositVo());
			}
			if(taskNum!=null&&taskNum>0){
				str = LocaleTool.tranView(Module.MASTER_TASK_REMINDER, userTaskReminder.getDictCode(), userTaskReminder.getTaskUrl(),
						userTaskReminder.getTaskNum()+"",UserTaskReminder.format(userTaskReminder.getUpdateTime()));
			}

		}else if(UserTaskParentCodeEnum.PAY.getCode().equals(userTaskReminder.getParentCode())){
			switch (userTaskReminder.getDictCode()){
				case "orange":str = LocaleTool.tranView(Module.MASTER_TASK_REMINDER, userTaskReminder.getDictCode(), userTaskReminder.getTaskUrl(),
						userTaskReminder.getTaskNum()+"",UserTaskReminder.format(userTaskReminder.getUpdateTime()));
					break;
				case "red":str = LocaleTool.tranView(Module.MASTER_TASK_REMINDER, userTaskReminder.getDictCode(), userTaskReminder.getTaskNum()+"",
						UserTaskReminder.format(userTaskReminder.getUpdateTime()),userTaskReminder.getTaskUrl());
					break;
				case "freeze":str = LocaleTool.tranView(Module.MASTER_TASK_REMINDER, userTaskReminder.getDictCode(), userTaskReminder.getTaskNum()+"",
						UserTaskReminder.format(userTaskReminder.getUpdateTime()),userTaskReminder.getTaskUrl());
					break;
				case "oneSituation":
					Map<String,String> one= JsonTool.fromJson(userTaskReminder.getParamValue(), HashMap.class);
					str = LocaleTool.tranView(Module.MASTER_TASK_REMINDER, userTaskReminder.getDictCode(), one.get("payName"),one.get("payAccount"),
							one.get("hourNum"),one.get("playerNum"),one.get("times"));
					break;
				case "twoSituation":
					Map<String,String> two=JsonTool.fromJson(userTaskReminder.getParamValue(), Map.class);
					str = LocaleTool.tranView(Module.MASTER_TASK_REMINDER, userTaskReminder.getDictCode(), userTaskReminder.getTaskUrl(),
							two.get("payName"),two.get("payAccount"),two.get("hourNum"));
					break;
			}
		}else if(UserTaskParentCodeEnum.CONSULTATION.getCode().equals(userTaskReminder.getParentCode())){
			str = LocaleTool.tranView(Module.MASTER_TASK_REMINDER, userTaskReminder.getDictCode(), userTaskReminder.getTaskUrl(), userTaskReminder.getTaskNum()+"",
					UserTaskReminder.format(userTaskReminder.getUpdateTime()));
		}else if(UserTaskParentCodeEnum.BILL.getCode().equals(userTaskReminder.getParentCode())){
			//TODO:账单任务提醒
		}
		return str;
	}
}
