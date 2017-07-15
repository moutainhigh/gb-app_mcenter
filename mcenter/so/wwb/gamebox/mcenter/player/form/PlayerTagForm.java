package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;


/**
 * 玩家标签 关联表表单验证对象
 *
 * Created by jeff using soul-code-generator on 2015-6-29 14:26:58
 */
//region your codes 1
public class PlayerTagForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String tagsIdStr;

    @NotBlank(message = "player_auto.请选择标签")
    public String getTagsIdStr() {
        return tagsIdStr;
    }

    public void setTagsIdStr(String tagsIdStr) {
        this.tagsIdStr = tagsIdStr;
    }

    //endregion your codes 2

}