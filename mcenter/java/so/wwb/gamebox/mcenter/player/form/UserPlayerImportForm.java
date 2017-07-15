package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;


/**
 * 玩家导入记录表 by River表单验证对象
 *
 * @author River
 * @time 2015-12-28 16:29:59
 */
//region your codes 1
public class UserPlayerImportForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String fileName;
    @NotBlank
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    //endregion your codes 2

}