package so.wwb.gamebox.mcenter.operation.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.soul.commons.validation.form.support.Comment;
import org.soul.web.support.IForm;


/**
 * 优惠活动分类
 * <p/>
 * Created by cheery using soul-code-generator on 2015-7-13 11:09:02
 */
//region your codes 1
@Comment("编辑活动分类")
public class ClassficationForm implements IForm {
//endregion your codes 1

    //region your codes 2
    //private String[][] command$$$$_value;

    private String[] gruop$$_locale$$; //obj[0].value[0]

  /*  @Comment("活动分类value值")
    @NotNull(message = "operation.classification.notBlank")
    public String[][] getCommand$$$$_value() {
        return command$$$$_value;
    }

    public void setCommand$$$$_value(String[][] command$$$$_value) {
        this.command$$$$_value = command$$$$_value;
    }*/


    @NotBlank(message = "operation.classification.notBlank")
    @Length(min = 1,max = 20)
    @Comment("活动分类value值")
    public String[] getGruop$$_locale$$() {
        return gruop$$_locale$$;
    }

    public void setGruop$$_locale$$(String[] gruop$$_locale$$) {
        this.gruop$$_locale$$ = gruop$$_locale$$;
    }

    //endregion your codes 2

}