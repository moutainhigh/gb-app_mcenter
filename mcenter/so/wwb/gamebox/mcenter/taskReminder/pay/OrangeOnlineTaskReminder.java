package so.wwb.gamebox.mcenter.taskReminder.pay;

import org.soul.web.locale.DateQuickPicker;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.master.content.enums.WarningTypeEnumEnum;
import so.wwb.gamebox.model.master.content.vo.PayWarningVo;
import so.wwb.gamebox.model.master.fund.enums.RechargeTypeParentEnum;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;

/**
 * 线上支付-橙色预警
 *
 * Created by bruce on 16-10-18.
 */
public class OrangeOnlineTaskReminder extends PayTaskReminder {

    @Override
    public void setTaskReminder(UserTaskReminder userTaskReminder) {
        filterPayWarning(WarningTypeEnumEnum.ORANGE_WARNING.getCode(),RechargeTypeParentEnum.ONLINE_DEPOSIT.getCode(),
                userTaskReminder);
    }

    @Override
    public Integer countTask() {
        PayWarningVo payWarningVo = new PayWarningVo();
        payWarningVo.setStartTime(DateQuickPicker.getInstance().getToday());
        payWarningVo.setEndTime(DateQuickPicker.getInstance().getTomorrow());
        return ServiceTool.payWarningService().countOrangeOrRedPayWarning(payWarningVo);
    }
}
