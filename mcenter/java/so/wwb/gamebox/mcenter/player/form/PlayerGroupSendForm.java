package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;

/**
 * Created by bruce on 16-9-18.
 */
public class PlayerGroupSendForm implements IForm {

    private String ids;

    private String[] $sendContent;

    @NotBlank(message = "player_auto.收件人不能为空")
    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    @NotBlank(message = "common.不能为空")
    public String[] get$sendContent() {
        return $sendContent;
    }

    public void set$sendContent(String[] $sendContent) {
        this.$sendContent = $sendContent;
    }
}
