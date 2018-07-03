package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.Comment;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.player.controller.PlayerController;
import so.wwb.gamebox.model.common.RegExpConstants;

import javax.validation.constraints.Pattern;


/**
 * 表单验证对象
 *
 * Created by orange using soul-code-generator on 2015-6-30 17:04:53
 */
@Comment("玩家真实姓名")
public class PlayerRealNameForm implements IForm {

    private String result_realName;
    private String result_newRealName;

    @Comment("玩家真实姓名")
    @NotBlank(message = "player.realName.notBlank")
    @Pattern(message = "player.realName.length", regexp = RegExpConstants.REALNAME)
    /*@Remote(message = "player.realName.exist",checkMethod = "checkRealNameExist",checkClass = PlayerController.class)*/
    public String getResult_realName() {
        return result_realName;
    }

    public void setResult_realName(String result_realName) {
        this.result_realName = result_realName;
    }

    @NotBlank(message = "player.realName.notBlank")
    @Compare(message = "player.realName.nameNotConsistent", logic = CompareLogic.EQ, anotherProperty = "result.realName")
    public String getResult_newRealName() {
        return result_newRealName;
    }

    public void setResult_newRealName(String result_newRealName) {
        this.result_newRealName = result_newRealName;
    }

}