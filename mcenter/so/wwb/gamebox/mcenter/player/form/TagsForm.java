package so.wwb.gamebox.mcenter.player.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.web.support.IForm;


/**
 * 表单验证对象
 *
 * Created by jeff using soul-code-generator on 2015-6-29 14:26:35
 */
//region your codes 1
public class TagsForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String id;
    private String tagName;
    private String tagDescribe;
    private String $max50Tags;
    @Remote(message = "playerTag.tagNameExist",checkMethod = "checkTagName",checkClass = so.wwb.gamebox.mcenter.player.controller.TagsController.class,additionalProperties = {"id"})
    @NotBlank(message ="playerTag.tagNameNotBlank")
    @Length(max=20,min=1,message = "playerTag.tagNameMax20Len")
    public String getTagName() {
        return tagName;
    }

    public void setTagName(String tagName) {
        this.tagName = tagName;
    }

    @Length(max=100,min=1,message = "playerTag.tagDescribeMax100Len")
    public String getTagDescribe() {

        return tagDescribe;
    }

    public void setTagDescribe(String tagDescribe) {
        this.tagDescribe = tagDescribe;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }


    @Remote(message = "playerTag.tagsMax50",checkMethod = "checkMax50Tag",checkClass = so.wwb.gamebox.mcenter.player.controller.TagsController.class,additionalProperties = {"tagType","id"})
    public String get$max50Tags() {
        return $max50Tags;
    }

    public void set$max50Tags(String $max50Tags) {
        this.$max50Tags = $max50Tags;
    }
    //endregion your codes 2

}