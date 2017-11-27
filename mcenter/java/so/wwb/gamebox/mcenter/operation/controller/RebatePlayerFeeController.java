package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.operation.IRebatePlayerFeeService;
import so.wwb.gamebox.mcenter.operation.form.RebatePlayerFeeForm;
import so.wwb.gamebox.mcenter.operation.form.RebatePlayerFeeSearchForm;
import so.wwb.gamebox.model.master.operation.po.RebatePlayerFee;
import so.wwb.gamebox.model.master.operation.vo.RebatePlayerFeeListVo;
import so.wwb.gamebox.model.master.operation.vo.RebatePlayerFeeVo;


/**
 * 代理返佣_玩家费用控制器
 *
 * @author younger
 * @time 2017-8-7 16:32:34
 */
@Controller
//region your codes 1
@RequestMapping("/rebatePlayerFee")
public class RebatePlayerFeeController extends BaseCrudController<IRebatePlayerFeeService, RebatePlayerFeeListVo, RebatePlayerFeeVo, RebatePlayerFeeSearchForm, RebatePlayerFeeForm, RebatePlayerFee, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/";
        //endregion your codes 2
    }

    //region your codes 3

    //endregion your codes 3

}