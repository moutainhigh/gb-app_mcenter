package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;

/**
 * Created by catban on 15-11-5.
 */


//region your codes 1
public class MassInformationForm implements IForm {
//endregion your codes 1



    //region your codes 2
    private String content$$;
    private String appointPlayer;



    private String title$$;

    @NotBlank(message = "operation_auto.消息内容不能为空")
    @Length(min = 1,max = 1000)
    @Comment("消息内容")
    public String getContent$$() {
        return content$$;
    }

    public void setContent$$(String content$$) {
        this.content$$ = content$$;
    }

    @NotBlank(message = "operation_auto.标题不能为空")
    @Length(min = 1,max = 100)
    @Comment("消息标题")
    public String getTitle$$() {
        return title$$;
    }

    public void setTitle$$(String title$$) {
        this.title$$ = title$$;
    }

    public String getAppointPlayer() {
        return appointPlayer;
    }

    public void setAppointPlayer(String appointPlayer) {
        this.appointPlayer = appointPlayer;
    }


    //endregion your codes 2

}