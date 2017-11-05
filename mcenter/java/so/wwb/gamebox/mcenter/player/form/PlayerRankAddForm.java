package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.player.controller.PlayerRankController;


/**
 * 玩家层级表表单验证对象
 * <p/>
 * Created by loong using soul-code-generator on 2015-7-14 15:40:56
 */
//region your codes 1
//@Compare(message = "msg", logic = CompareLogic.LT, property = "registerEndTime", anotherProperty = "registerStartTime")
public class PlayerRankAddForm implements IForm {
//endregion your codes 1
    /**
     * 层级名称
     */
    private String result_rankName;
    /**
     * 备注
     */
    private String result_remark;

    private String result_rakebackId;


    @NotBlank
    @Length(min = 1, max = 20)
    @Remote(message = "player_auto.bankName.exist",checkMethod = "checkUserNameExist",checkClass = PlayerRankController.class,additionalProperties = "result.id")
    public String getResult_rankName() {
        return result_rankName;
    }

    @Length(max = 200)
    public String getResult_remark() {
        return result_remark;
    }

    public void setResult_rankName(String result_rankName) {
        this.result_rankName = result_rankName;
    }

    public void setResult_remark(String result_remark) {
        this.result_remark = result_remark;
    }
    @NotBlank
    public String getResult_rakebackId() {
        return result_rakebackId;
    }

    public void setResult_rakebackId(String result_rakebackId) {
        this.result_rakebackId = result_rakebackId;
    }

//endregion your codes 2

}