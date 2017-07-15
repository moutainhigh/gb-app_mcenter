package so.wwb.gamebox.mcenter.taskReminder.pay;

import so.wwb.gamebox.model.master.content.enums.WarningTypeEnumEnum;
import so.wwb.gamebox.model.master.fund.enums.RechargeTypeParentEnum;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;

/**
 * 公司入款-橙色预警
 *
 * Created by bruce on 16-10-18.
 */
public class OrangeTaskReminder extends PayTaskReminder {

    @Override
    public void setTaskReminder(UserTaskReminder userTaskReminder) {
        filterPayWarning(WarningTypeEnumEnum.ORANGE_WARNING.getCode(),RechargeTypeParentEnum.COMPANY_DEPOSIT.getCode(),
                userTaskReminder);
    }

    @Override
    public Integer countTask() {
        return 0;
    }
}
