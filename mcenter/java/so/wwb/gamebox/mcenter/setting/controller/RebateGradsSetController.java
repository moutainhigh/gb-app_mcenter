package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.web.controller.BaseCrudController;
import so.wwb.gamebox.iservice.master.setting.IRebateGradsSetService;
import so.wwb.gamebox.model.master.setting.po.RebateGradsSet;
import so.wwb.gamebox.model.master.setting.vo.RebateGradsSetListVo;
import so.wwb.gamebox.model.master.setting.vo.RebateGradsSetVo;
import so.wwb.gamebox.mcenter.setting.form.RebateGradsSetSearchForm;
import so.wwb.gamebox.mcenter.setting.form.RebateGradsSetForm;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * 返佣梯度方案控制器
 *
 * @author younger
 * @time 2017-7-29 17:12:36
 */
@Controller
//region your codes 1
@RequestMapping("/rebateGradsSet")
public class RebateGradsSetController extends BaseCrudController<IRebateGradsSetService, RebateGradsSetListVo, RebateGradsSetVo, RebateGradsSetSearchForm, RebateGradsSetForm, RebateGradsSet, Integer> {
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