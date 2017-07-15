package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.setting.IRakebackGradsService;
import so.wwb.gamebox.mcenter.setting.form.RakebackGradsForm;
import so.wwb.gamebox.mcenter.setting.form.RakebackGradsSearchForm;
import so.wwb.gamebox.model.master.setting.po.RakebackGrads;
import so.wwb.gamebox.model.master.setting.vo.RakebackGradsListVo;
import so.wwb.gamebox.model.master.setting.vo.RakebackGradsVo;


/**
 * 返水设置梯度表控制器
 *
 * @author jeff
 * @time 2015-9-17 9:15:03
 */
@Controller
//region your codes 1
@RequestMapping("/rakebackGrads")
public class RakebackGradsController extends BaseCrudController<IRakebackGradsService, RakebackGradsListVo, RakebackGradsVo, RakebackGradsSearchForm, RakebackGradsForm, RakebackGrads, Integer> {
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