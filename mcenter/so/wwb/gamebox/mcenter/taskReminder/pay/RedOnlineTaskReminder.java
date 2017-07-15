package so.wwb.gamebox.mcenter.taskReminder.pay;

import so.wwb.gamebox.model.master.content.enums.WarningTypeEnumEnum;
import so.wwb.gamebox.model.master.fund.enums.RechargeTypeParentEnum;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;

/**
 * 线上支付-红色预警
 *
 * Created by bruce on 16-10-18.
 */
public class RedOnlineTaskReminder extends PayTaskReminder {

    @Override
    public void setTaskReminder(UserTaskReminder userTaskReminder) {
        filterPayWarning(WarningTypeEnumEnum.RED_WARNING.getCode(),RechargeTypeParentEnum.ONLINE_DEPOSIT.getCode(),
                userTaskReminder);
    }

    @Override
    public Integer countTask() {
        return 0;
    }
}
