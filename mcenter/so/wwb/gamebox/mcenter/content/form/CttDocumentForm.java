package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.Length;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.web.support.IForm;


/**
 * 表单验证对象
 *
 * @author River
 * @time 2015-11-12 16:19:11
 */
//region your codes 1
public class CttDocumentForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String[] documentI18ns$$_content;
    private String[] documentI18ns$$_contentText;
    private String parentVo_id;

    public String[] getDocumentI18ns$$_content() {
        return documentI18ns$$_content;
    }

    public void setDocumentI18ns$$_content(String[] documentI18ns$$_content) {
        this.documentI18ns$$_content = documentI18ns$$_content;
    }

    @Depends(property ={"parentVo_id"}, operator = {Operator.IS_NOT_EMPTY}, value = {""}, message = "common.不能为空")
    @Length(max = 20000)
    public String[] getDocumentI18ns$$_contentText() {
        return documentI18ns$$_contentText;
    }

    public void setDocumentI18ns$$_contentText(String[] documentI18ns$$_contentText) {
        this.documentI18ns$$_contentText = documentI18ns$$_contentText;
    }

    public String getParentVo_id() {
        return parentVo_id;
    }

    public void setParentVo_id(String parentVo_id) {
        this.parentVo_id = parentVo_id;
    }
    //endregion your codes 2

}