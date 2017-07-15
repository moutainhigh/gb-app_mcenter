package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.validation.form.constraints.Depends;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;

import javax.validation.constraints.Pattern;


/**
 * 内容管理-浮动图片表表单验证对象
 *
 * @author cj
 * @time 2015-7-28 9:46:06
 */
//region your codes 1
@Comment("浮动图新增、修改")
public class CttFloatPicForm implements IForm {


//endregion your codes 1

    //region your codes 2
    private String title;
    private String language;
    private String distanceSide;
    private String displayInPages;

    private String templateType;
    private String[] itemList$$_normalEffect;
    private String[] itemList$$_mouseInEffect;
    private String[] itemList$$_imgLinkType;
    private String[] itemList$$_imgLinkValue;

    private String distanceValue;

    @NotBlank
    @Length(min = 1, max = 20)
    @Comment("图片标题")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @NotBlank(message = "content.floatPic.validate.language")
    @Comment("语言")
    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    @NotBlank
    @Pattern(regexp = FormValidRegExps.POSITIVE_INTEGER, message = "content.floatPic.validate.POSITIVE_INTEGER")
    @Comment("浮动图标距离浏览器左侧或右侧的距离；必填；仅支持输入正整数；")
    public String getDistanceSide() {
        return distanceSide;
    }

    public void setDistanceSide(String distanceSide) {
        this.distanceSide = distanceSide;
    }

    @NotBlank(message = "content.floatPic.validate.displayInPages")
    @Comment("展示页面")
    public String getDisplayInPages() {
        return displayInPages;
    }

    public void setDisplayInPages(String displayInPages) {
        this.displayInPages = displayInPages;
    }

    /*@Depends(property ={"cttFloatPicTempVo.result.singleModeLinkType", "result.singleMode"}, operator = {Operator.EQ, Operator.EQ}, value = {"link", "true"},
            message = "content.floatPic.validate.singleLinkValue", jsValueExp = {"", "$(\"[name='result.singleMode']\").val() && !$(\"[name='cttFloatPicTempVo.result.singleModeLinkValue']\").is(\":hidden\")"})
    @Pattern(regexp = FormValidRegExps.URL_LASTPART, message = "content.floatPic.validate.link.format")
    @Comment("单图链接地址")
    public String get$cttFloatPicTempVo_result_singleModeLinkValue() {
        return $cttFloatPicTempVo_result_singleModeLinkValue;
    }

    public void set$cttFloatPicTempVo_result_singleModeLinkValue(String $cttFloatPicTempVo_result_singleModeLinkValue) {
        this.$cttFloatPicTempVo_result_singleModeLinkValue = $cttFloatPicTempVo_result_singleModeLinkValue;
    }

    @Depends(property ={"result.singleMode", "$chooseTemplate"}, operator = {Operator.EQ, Operator.EQ}, value = {"true", "false"}, jsValueExp = {"$(\"[name='result.singleMode']\").val() == 'true'", "$(\"[name=chooseTemplate]:checked\").val()=='true'"}, message = "carousel.uploadImageWarning")
    @Comment("单图自定义图片地址")
    public String get$cttFloatPicTempVo_result_defaultImgPath() {
        return $cttFloatPicTempVo_result_defaultImgPath;
    }

    public void set$cttFloatPicTempVo_result_defaultImgPath(String $cttFloatPicTempVo_result_defaultImgPath) {
        this.$cttFloatPicTempVo_result_defaultImgPath = $cttFloatPicTempVo_result_defaultImgPath;
    }

    @Depends(property ={"result.singleMode", "$chooseTemplate"}, operator = {Operator.EQ, Operator.EQ}, value = {"true", "false"}, jsValueExp = {"", "$(\"[name=chooseTemplate]:checked\").val()"}, message = "carousel.uploadImageWarning")
    @Comment("单图自定义鼠标移出效果图片地址")
    public String get$cttFloatPicTempVo_result_mouseOutImgPath() {
        return $cttFloatPicTempVo_result_mouseOutImgPath;
    }

    public void set$cttFloatPicTempVo_result_mouseOutImgPath(String $cttFloatPicTempVo_result_mouseOutImgPath) {
        this.$cttFloatPicTempVo_result_mouseOutImgPath = $cttFloatPicTempVo_result_mouseOutImgPath;
    }

    @Depends(property ={"result.singleMode"}, operator = {Operator.EQ}, value = {"false"}, jsValueExp = {"$(\"[name=\'result.singleMode\']\").val() == 'true'"},message = "carousel.uploadImageWarning")
    @Comment("列表中部图片地址，至少要求一个")
    public String get$cttFloatPicTempVo_result_middle1ImgPath() {
        return $cttFloatPicTempVo_result_middle1ImgPath;
    }

    public void set$cttFloatPicTempVo_result_middle1ImgPath(String $cttFloatPicTempVo_result_middle1ImgPath) {
        this.$cttFloatPicTempVo_result_middle1ImgPath = $cttFloatPicTempVo_result_middle1ImgPath;
    }*/
    @NotBlank
    public String getTemplateType() {
        return templateType;
    }

    public void setTemplateType(String templateType) {
        this.templateType = templateType;
    }

    //$('input[name="radioName"]:checked').val()
    @Depends(property = {"result.singleMode"}, operator = {Operator.EQ}, value = {"false"}, jsValueExp = {"$(\"input[name=\'result.singleMode\']:checked\").val() == 'true'"}, message = "carousel.uploadImageWarning")
    public String[] getItemList$$_normalEffect() {
        return itemList$$_normalEffect;
    }

    public void setItemList$$_normalEffect(String[] itemList$$_normalEffect) {
        this.itemList$$_normalEffect = itemList$$_normalEffect;
    }

    @Depends(property = {"result.singleMode", "mouseInEffect"}, operator = {Operator.EQ, Operator.EQ}, value = {"false", "true"}, jsValueExp = {"$(\"input[name=\'result.singleMode\']:checked\").val() == 'true'","$(\"input[name=mouseInEffect]:checked\").val()"}, message = "carousel.uploadImageWarning")
    public String[] getItemList$$_mouseInEffect() {
        return itemList$$_mouseInEffect;
    }

    public void setItemList$$_mouseInEffect(String[] itemList$$_mouseInEffect) {
        this.itemList$$_mouseInEffect = itemList$$_mouseInEffect;
    }

    public String[] getItemList$$_imgLinkType() {
        return itemList$$_imgLinkType;
    }

    public void setItemList$$_imgLinkType(String[] itemList$$_imgLinkType) {
        this.itemList$$_imgLinkType = itemList$$_imgLinkType;
    }

    @Depends(property = {"floatPicItem.imgLinkType", "result.singleMode"}, operator = {Operator.EQ, Operator.EQ}, value = {"link", "true"},
            message = "content.floatPic.validate.singleLinkValue",
            jsValueExp = {"", "$(\"input[name='result.singleMode']:checked\").val() && !$(\"[name='imgLinkTypeValue']\").is(\":hidden\")"})
    //@Pattern(regexp = FormValidRegExps.URL_LASTPART, message = "content.floatPic.validate.link.format")
    public String[] getItemList$$_imgLinkValue() {
        return itemList$$_imgLinkValue;
    }

    public void setItemList$$_imgLinkValue(String[] itemList$$_imgLinkValue) {
        this.itemList$$_imgLinkValue = itemList$$_imgLinkValue;
    }

    @NotBlank
    @Pattern(regexp = FormValidRegExps.ALL_NUMBER, message = "content.floatPic.validate.POSITIVE_INTEGER")
    @Comment("必填；仅支持输入正整数；")
    public String getDistanceValue() {
        return distanceValue;
    }

    public void setDistanceValue(String distanceValue) {
        this.distanceValue = distanceValue;
    }

    //endregion your codes 2

}