package so.wwb.gamebox.mcenter.setting.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;


/**
 * 表格导出记录表单验证对象
 *
 * Created by cj using soul-code-generator on 2015-6-19 11:46:14
 */
//region your codes 1
@Comment("导出")
public class SysExportForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String fileName;

    public SysExportForm() {
    }

    @NotBlank(message = "share.export.validate.fileName.blank")
    @Length(min = 1, max = 50, message = "share.export.validate.fileName.length")
    @Comment("文件名")
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    //endregion your codes 2

}