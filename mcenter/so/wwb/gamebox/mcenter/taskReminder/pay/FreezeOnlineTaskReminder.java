package so.wwb.gamebox.mcenter.taskReminder.pay;

import so.wwb.gamebox.model.master.enums.PayAccountType;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;

import java.util.Date;
import java.util.Map;

/**
 * 线上支付-冻结
 *
 * Created by bruce on 16-10-18.
 */
public class FreezeOnlineTaskReminder extends PayTaskReminder {

    @Override
    public void setTaskReminder(UserTaskReminder userTaskReminder) {
        Map<String,Object> freezePayAccountForOnline = countFreezePayAccount(PayAccountType.ONLINE_ACCOUNT.getCode());
        userTaskReminder.setTaskNum(((Long) freezePayAccountForOnline.get("paycount")).intValue());
        userTaskReminder.setUpdateTime((Date)freezePayAccountForOnline.get("frozentime"));
    }

    @Override
    public Integer countTask() {
        return ((Long) countFreezePayAccount(
                PayAccountType.ONLINE_ACCOUNT.getCode()).get("paycount")).intValue();
    }
}
