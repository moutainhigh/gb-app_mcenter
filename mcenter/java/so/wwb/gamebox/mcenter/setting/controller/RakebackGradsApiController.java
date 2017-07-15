package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.setting.IRakebackGradsApiService;
import so.wwb.gamebox.mcenter.setting.form.RakebackGradsApiForm;
import so.wwb.gamebox.mcenter.setting.form.RakebackGradsApiSearchForm;
import so.wwb.gamebox.model.master.setting.po.RakebackGradsApi;
import so.wwb.gamebox.model.master.setting.vo.RakebackGradsApiListVo;
import so.wwb.gamebox.model.master.setting.vo.RakebackGradsApiVo;


/**
 * 返水设置梯度API比例表控制器
 *
 * @author jeff
 * @time 2015-9-17 9:15:16
 */
@Controller
//region your codes 1
@RequestMapping("/rakebackGradsApi")
public class RakebackGradsApiController extends BaseCrudController<IRakebackGradsApiService, RakebackGradsApiListVo, RakebackGradsApiVo, RakebackGradsApiSearchForm, RakebackGradsApiForm, RakebackGradsApi, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/";
        //endregion your codes 2
    }

    //region your codes 3

    //endregion your codes 3

}