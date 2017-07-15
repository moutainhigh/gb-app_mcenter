package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.NotBlank;
import org.soul.web.support.IForm;

import javax.validation.constraints.Size;


/**
 * 推广素材表表单验证对象
 *
 * @author tom
 * @time 2015-10-29 11:22:14
 */
//region your codes 1
public class CttMaterialPicForm implements IForm {
//endregion your codes 1

    //region your codes 2
    // 标题
    private String[] cttMaterialPicList$$_title;
    // 图片
    private String[] cttMaterialPicList$$_pic;

    @NotBlank(message = "content_auto.名称不能为空")
    @Size(min = 1,max = 20)
    public String[] getCttMaterialPicList$$_title() {
        return cttMaterialPicList$$_title;
    }

    public void setCttMaterialPicList$$_title(String[] cttMaterialPicList$$_title) {
        this.cttMaterialPicList$$_title = cttMaterialPicList$$_title;
    }

    @NotBlank(message = "content_auto.图片不能为空")
    public String[] getCttMaterialPicList$$_pic() {
        return cttMaterialPicList$$_pic;
    }

    public void setCttMaterialPicList$$_pic(String[] cttMaterialPicList$$_pic) {
        this.cttMaterialPicList$$_pic = cttMaterialPicList$$_pic;
    }

    //endregion your codes 2

}