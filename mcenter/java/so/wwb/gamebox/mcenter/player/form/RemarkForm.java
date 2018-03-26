package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;


/**
 * 玩家备注表表单验证对象
 *
 * Created by cheery using soul-code-generator on 2015-7-28 13:58:02
 */
//region your codes 1
public class RemarkForm implements IForm {

    private String result_remarkTitle;
    private String result_remarkContent;
    @Comment("备注标题")
    @NotBlank(message = "fund.fund.playerRemarkForm.remarkTitle.notBlank")
    public String getResult_remarkTitle() {
        return result_remarkTitle;
    }

    public void setResult_remarkTitle(String result_remarkTitle) {
        this.result_remarkTitle = result_remarkTitle;
    }




    @Comment("备注内容")
    @NotBlank(message = "fund.fund.playerRemarkForm.remarkContent.notBlank")
    public String getResult_remarkContent() {
        return result_remarkContent;
    }

    public void setResult_remarkContent(String result_remarkContent) {
        this.result_remarkContent = result_remarkContent;
    }
}