package so.wwb.gamebox.mcenter.taskReminder.pay;

import so.wwb.gamebox.model.master.enums.PayAccountType;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;

import java.util.Date;
import java.util.Map;

/**
 * 公司入款-冻结
 *
 * Created by bruce on 16-10-18.
 */
public class FreezeTaskReminder extends PayTaskReminder {

    @Override
    public void setTaskReminder(UserTaskReminder userTaskReminder) {
        Map<String,Object> freezePayAccountForCompany = countFreezePayAccount(PayAccountType.COMPANY_ACCOUNT.getCode());
        userTaskReminder.setTaskNum(((Long) freezePayAccountForCompany.get("paycount")).intValue());
        userTaskReminder.setUpdateTime((Date)freezePayAccountForCompany.get("frozentime"));
    }

    @Override
    public Integer countTask() {
        return ((Long) countFreezePayAccount(
                PayAccountType.COMPANY_ACCOUNT.getCode()).get("paycount")).intValue();
    }
}
