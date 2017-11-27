package so.wwb.gamebox.mcenter.content.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.constraints.Compare;
import org.soul.commons.validation.form.constraints.Remote;
import org.soul.commons.validation.form.support.CompareLogic;
import org.soul.web.support.IForm;
import so.wwb.gamebox.mcenter.content.controller.CttLogoController;


/**
 * 内容管理-LOGO表表单验证对象
 *
 * @author snekey
 * @time 2015-8-3 9:56:48
 */
//region your codes 1
public class CttLogoForm implements IForm {
//endregion your codes 1

    //region your codes 2
    private String result_id;
    private String result_startTime;
    private String result_endTime;
    private String result_name;
    private String result_path;

    private String result_flashLogoPath;

    @NotBlank
    @Length(max = 20)
    public String getResult_name() {
        return result_name;
    }

    public void setResult_name(String result_name) {
        this.result_name = result_name;
    }

    @NotBlank(message = "carousel.startTimeNotBlank")
    @Remote(message = "content.minimumTime",checkClass = CttLogoController.class,checkMethod = "checkStartTime",additionalProperties = {"result_endTime","result_id"})
    public String getResult_startTime() {
        return result_startTime;
    }

    public void setResult_startTime(String result_startTime) {
        this.result_startTime = result_startTime;
    }
    @NotBlank(message = "carousel.endTimeNotBlank")
    @Remote(message = "content.minimumTime",checkClass = CttLogoController.class,checkMethod = "checkEndTime",additionalProperties = {"result_startTime","result_id"})
    @Compare(message = "content.payAccount.singleDepositMaxGTsingleDepositMin",logic = CompareLogic.GT,anotherProperty = "result_startTime")
    public String getResult_endTime() {
        return result_endTime;
    }

    public void setResult_endTime(String result_endTime) {
        this.result_endTime = result_endTime;
    }

    public String getResult_id() {
        return result_id;
    }

    public void setResult_id(String result_id) {
        this.result_id = result_id;
    }

    //@Depends(property = "result.flashLogoPath",operator = Operator.EQ,value = "true",jsValueExp = {"$(\"[id='flash_file_path']\").val()==''&&$(\"[name='result.flashLogoPath']\").val()==''"})
    @NotBlank
    public String getResult_path() {
        return result_path;
    }

    public void setResult_path(String result_path) {
        this.result_path = result_path;
    }

    public String getResult_flashLogoPath() {
        return result_flashLogoPath;
    }

    public void setResult_flashLogoPath(String result_flashLogoPath) {
        this.result_flashLogoPath = result_flashLogoPath;
    }

    //endregion your codes 2

}