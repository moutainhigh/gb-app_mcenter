package so.wwb.gamebox.mcenter.taskReminder.pay;

import org.soul.commons.collections.CollectionQueryTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.query.Criteria;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.query.sort.Order;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.mcenter.taskReminder.TaskReminder;
import so.wwb.gamebox.model.master.content.po.PayWarning;
import so.wwb.gamebox.model.master.content.vo.PayAccountVo;
import so.wwb.gamebox.model.master.content.vo.PayWarningVo;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;

import java.util.List;
import java.util.Map;

/**
 * 账户异常提醒
 *
 * Created by bruce on 16-10-19.
 */
public abstract class PayTaskReminder extends TaskReminder {

    protected static Map<String, Object> countFreezePayAccount(String accountType) {
        PayAccountVo payAccountVo = new PayAccountVo();
        payAccountVo.setType(accountType);
        payAccountVo.setStartTime(DateQuickPicker.getInstance().getToday());
        payAccountVo.setEndTime(DateQuickPicker.getInstance().getTomorrow());
        return ServiceSiteTool.payAccountService().countFreezePayAccount(payAccountVo);
    }

    private List<PayWarning> countOrangeAndRedPayAccount(String accountType) {
        PayWarningVo payWarningVo = new PayWarningVo();
        payWarningVo.setAccountType(accountType);
        payWarningVo.setStartTime(DateQuickPicker.getInstance().getToday());
        payWarningVo.setEndTime(DateQuickPicker.getInstance().getTomorrow());
        return ServiceSiteTool.payWarningService().countOrangeAndRedPayAccount(payWarningVo);
    }

    private List<PayWarning> filterPayWarningsByWarningType(String warningType,String accountType) {
        List<PayWarning> payWarnings = countOrangeAndRedPayAccount(accountType);
        payWarnings = CollectionQueryTool.query(payWarnings, Criteria.add(PayWarning.PROP_WARNING_TYPE, Operator.EQ,warningType),
                Order.desc(PayWarning.PROP_WARNING_TIME));
        return payWarnings;
    }

    void filterPayWarning(String warningType, String accountType, UserTaskReminder userTaskReminder) {
        List<PayWarning> payWarnings = filterPayWarningsByWarningType(warningType,accountType);
        if (payWarnings != null && payWarnings.size() > 0 ) {
            userTaskReminder.setTaskNum(payWarnings.size());
            userTaskReminder.setUpdateTime(payWarnings.get(0).getWarningTime());
            List accounts = CollectionQueryTool.queryProperty(payWarnings,PayWarning.PROP_ACCOUNT);
            userTaskReminder.setTaskUrl(userTaskReminder.getTaskUrl()+"&search.accounts="+ StringTool.join(accounts,","));
        } else {
            userTaskReminder.setTaskNum(0);
        }
    }

}
