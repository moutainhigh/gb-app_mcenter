package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;


/**
 * 表单验证对象
 *
 * Created by orange using soul-code-generator on 2015-6-30 17:04:53
 */
@Comment("咨询提交校验")
public class PlayerAdvisoryForm implements IForm {

    private String $name;

    private String $replyTitle;

    private String $replyContent;

    @Comment("咨询回复标题")
    @NotBlank(message = "fund.fund.playerAdvisoryForm.replyTitle.notBlank")
//    @Remote(message = "fund.artificialForm.username.remote",checkClass = so.wwb.gamebox.mcenter.player.controller.PlayerController.class,checkMethod = "addChooseCheck")
    public String get$replyTitle() {
        return $replyTitle;
    }

    public void set$replyTitle(String $replyTitle) {
        this.$replyTitle = $replyTitle;
    }

    @Comment("咨询回复内容")
    @NotBlank(message = "fund.fund.playerAdvisoryForm.replyContent.notBlank")
//    @Remote(message = "fund.artificialForm.username.remote",checkClass = so.wwb.gamebox.mcenter.player.controller.PlayerController.class,checkMethod = "addChooseCheck")
    public String get$replyContent() {
        return $replyContent;
    }

    public void set$replyContent(String $replyContent) {
        this.$replyContent = $replyContent;
    }

    @NotBlank(message = "common.notBlank.kk.ll")
    @Comment("角色名称")
    public String get$name() {
        return $name;
    }

    public void set$name(String $name) {
        this.$name = $name;
    }






}