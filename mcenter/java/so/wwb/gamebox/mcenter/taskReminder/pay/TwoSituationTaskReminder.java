package so.wwb.gamebox.mcenter.taskReminder.pay;

import org.soul.commons.data.json.JsonTool;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.model.master.content.po.PayAccount;
import so.wwb.gamebox.model.master.content.vo.PayAccountListVo;
import so.wwb.gamebox.model.master.fund.vo.PlayerRechargeVo;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 账户异常:情况二
 *
 * Created by bruce on 16-10-18.
 */
public class TwoSituationTaskReminder extends PayTaskReminder {

    @Override
    public void setTaskReminder(UserTaskReminder userTaskReminder) {
        Map map2 = countRechargeNoSuccessOfPayAccount();
        userTaskReminder.setTaskNum((Integer) map2.get("size"));
        userTaskReminder.setParamValue((String)map2.get("payAccount"));
    }

    private Map countRechargeNoSuccessOfPayAccount() {
        List<PayAccount> noSuccessRechargeOrder = new ArrayList<>();
        List<Integer> payAccountIds = ServiceSiteTool.playerRechargeService().searchRechargeSuccessOfPayAccount(new PlayerRechargeVo());
        if (payAccountIds != null && payAccountIds.size()>0) {
            List<PayAccount> payAccounts =  ServiceSiteTool.payAccountService().searchPayAccountByUsing(new PayAccountListVo());
            for (PayAccount payAccount : payAccounts) {
                for (Integer payAccountId : payAccountIds) {
                    if (payAccount.getId().equals(payAccountId)) {
                        noSuccessRechargeOrder.add(payAccount);
                    }
                }
            }
        }
        Map<String,Object> map = new HashMap<>();
        map.put("size",noSuccessRechargeOrder.size()>0?1:0);
        map.put("payAccount", JsonTool.toJson(noSuccessRechargeOrder));
        return map;
    }

    @Override
    public Integer countTask() {
        return (Integer) countRechargeNoSuccessOfPayAccount().get("size");
    }
}
