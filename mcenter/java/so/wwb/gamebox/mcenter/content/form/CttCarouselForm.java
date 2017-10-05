package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.common.consts.FormValidRegExps;
import so.wwb.gamebox.mcenter.content.controller.CttCarouselController;

import javax.validation.constraints.Pattern;


/**
 * 内容管理-轮播广告表表单验证对象
 *
 * @author jeff
 * @time 2015-7-29 11:15:55
 */
//region your codes 1
//@Compare(message = "",property = "result_startTime",logic = CompareLogic.GT,anotherProperty = "result_endTime")
public class CttCarouselForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String result_startTime;
    private String result_endTime;
    private String result_link;
    private String result_type;
    private String result_url;
    private String[] cttCarouselI18n$$_name;
    private String[] cttCarouselI18n$$_cover;
    @NotBlank(message = "carousel.startTimeNotBlank")
    public String getResult_startTime() {
        return result_startTime;
    }

    public void setResult_startTime(String result_startTime) {
        this.result_startTime = result_startTime;
    }

    @NotBlank(message = "carousel.endTimeNotBlank")
    @Remote(message = "carousel.startTimeLEendTime",checkClass = CttCarouselController.class,checkMethod = "checkTime",additionalProperties = {"result_startTime"})
    public String getResult_endTime() {
        return result_endTime;
    }

    public void setResult_endTime(String result_endTime) {
        this.result_endTime = result_endTime;
    }


    //    @Max(value = 50L)
    public String getResult_link() {
        return result_link;
    }

    public void setResult_link(String result_link) {
        this.result_link = result_link;
    }

    @NotBlank()
    @Length(max = 40,min = 0)
    public String[] getCttCarouselI18n$$_name() {
        return cttCarouselI18n$$_name;
    }

    public void setCttCarouselI18n$$_name(String[] cttCarouselI18n$$_name) {
        this.cttCarouselI18n$$_name = cttCarouselI18n$$_name;
    }

    @NotBlank()
    public String getResult_type() {
        return result_type;
    }

    public void setResult_type(String result_type) {
        this.result_type = result_type;
    }
    @NotBlank()
    public String[] getCttCarouselI18n$$_cover() {
        return cttCarouselI18n$$_cover;
    }

    public void setCttCarouselI18n$$_cover(String[] cttCarouselI18n$$_cover) {
        this.cttCarouselI18n$$_cover = cttCarouselI18n$$_cover;
    }
    /*@Pattern(regexp = FormValidRegExps.URL)*/
    public String getResult_url() {
        return result_url;
    }

    public void setResult_url(String result_url) {
        this.result_url = result_url;
    }
    //endregion your codes 2

}