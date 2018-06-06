package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.content.controller.CttCarouselController;


/**
 * 内容管理-轮播广告表表单验证对象
 *
 * @author jeff
 * @time 2015-7-29 11:15:55
 */
//region your codes 1
//@Compare(message = "",property = "result_startTime",logic = CompareLogic.GT,anotherProperty = "result_endTime")
public class CttCarouselAppStartPageForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String result_startTime;
    private String result_endTime;
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

    @Length(max = 40,min = 0)
    @NotBlank
    public String[] getCttCarouselI18n$$_name() {
        return cttCarouselI18n$$_name;
    }

    public void setCttCarouselI18n$$_name(String[] cttCarouselI18n$$_name) {
        this.cttCarouselI18n$$_name = cttCarouselI18n$$_name;
    }
    @NotBlank
    public String[] getCttCarouselI18n$$_cover() {
        return cttCarouselI18n$$_cover;
    }

    public void setCttCarouselI18n$$_cover(String[] cttCarouselI18n$$_cover) {
        this.cttCarouselI18n$$_cover = cttCarouselI18n$$_cover;
    }
    //endregion your codes 2

}