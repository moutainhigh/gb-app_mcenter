package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.content.controller.CttAnnouncementController;


/**
 * 内容管理-公告表表单验证对象
 *
 * @author snekey
 * @time 2015-8-19 14:25:39
 */
//region your codes 1
public class CttAnnouncementForm implements IForm {
//endregion your codes 1

    //region your codes 2
    //private String[]  result$$_title;
    private String[] result$$_content;
    private String $announcementType;
    private String $timing;
    private String $task;

    @Depends(property = "$task", operator = Operator.EQ, value = {"true"}, jsValueExp = "$(\"[name=\\'task\\']\").val()=='true'", message = "content_auto.请选择发送时间")
    @Remote(message = "content.payAccount.gtSysTime", checkClass = CttAnnouncementController.class, checkMethod = "checkTime", additionalProperties = {"$task"})
    public String get$timing() {
        return $timing;
    }

    /*   public void set$timing(String $timing) {
           this.$timing = $timing;
       }
       @NotBlank(message = "content.payAccount.title.noblank")
       @Length(max = 100)
       public String[] getResult$$_title() {
           return result$$_title;
       }

       public void setResult$$_title(String[] result$$_title) {
           this.result$$_title = result$$_title;
       }*/
    @NotBlank(message = "common.内容不能为空")
    @Length(max = 1000, min = 1)
    public String[] getResult$$_content() {
        return result$$_content;
    }

    public String get$task() {
        return $task;
    }

    public void set$task(String $task) {
        this.$task = $task;
    }

    public void setResult$$_content(String[] result$$_content) {
        this.result$$_content = result$$_content;
    }

    @NotBlank
    public String get$announcementType() {
        return $announcementType;
    }

    public void set$announcementType(String $announcementType) {
        this.$announcementType = $announcementType;
    }
    //endregion your codes 2

}