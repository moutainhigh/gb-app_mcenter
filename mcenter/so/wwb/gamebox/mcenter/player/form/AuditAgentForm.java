package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;

/**
 * Created by River on 2016/3/21.
 * 代理审核表单验证form
 */
public class AuditAgentForm implements IForm {
//    private

    private String userAgentRebate_rebateId;
    private String result_playerRankId;
    @NotBlank
    public String getUserAgentRebate_rebateId() {
        return userAgentRebate_rebateId;
    }

    public void setUserAgentRebate_rebateId(String userAgentRebate_rebateId) {
        this.userAgentRebate_rebateId = userAgentRebate_rebateId;
    }
    @NotBlank
    public String getResult_playerRankId() {
        return result_playerRankId;
    }

    public void setResult_playerRankId(String result_playerRankId) {
        this.result_playerRankId = result_playerRankId;
    }
}
