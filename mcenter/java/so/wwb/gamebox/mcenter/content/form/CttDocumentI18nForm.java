package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.content.controller.CttDocumentI18nController;


/**
 * 表单验证对象
 *
 * @author River
 * @time 2015-11-12 16:19:41
 */
//region your codes 1
public class CttDocumentI18nForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String cttDocumentVo_code;
    private String[] documentI18ns$$_title;
    private String result_id;

    @NotBlank
    @Length(max = 20)
    @Remote(additionalProperties = {"id"}, jsValueExp = {"$(\"[name='documentId']\").val()"},
            message = "content.document.titleRepeat", checkMethod = "checkTitle", checkClass = CttDocumentI18nController.class)
    public String[] getDocumentI18ns$$_title() {
        return documentI18ns$$_title;
    }

    public void setDocumentI18ns$$_title(String[] documentI18ns$$_title) {
        this.documentI18ns$$_title = documentI18ns$$_title;
    }

    public String getResult_id() {
        return result_id;
    }

    public void setResult_id(String result_id) {
        this.result_id = result_id;
    }

    @Comment("文案code")
    @NotBlank
    @Remote(message = "content.document.codeRepeat", additionalProperties = {"result.id"}, jsValueExp = {"$(\"[name='documentId']\").val()"}, checkMethod = "checkCode", checkClass = CttDocumentI18nController.class)
    public String getCttDocumentVo_code() {
        return cttDocumentVo_code;
    }

    public void setCttDocumentVo_code(String cttDocumentVo_code) {
        this.cttDocumentVo_code = cttDocumentVo_code;
    }

//endregion your codes 2

}