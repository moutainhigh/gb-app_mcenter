package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.operation.IRebateAgentApiNosettledService;
import so.wwb.gamebox.mcenter.operation.form.RebateAgentApiNosettledForm;
import so.wwb.gamebox.mcenter.operation.form.RebateAgentApiNosettledSearchForm;
import so.wwb.gamebox.model.master.operation.po.RebateAgentApiNosettled;
import so.wwb.gamebox.model.master.operation.vo.RebateAgentApiNosettledListVo;
import so.wwb.gamebox.model.master.operation.vo.RebateAgentApiNosettledVo;


/**
 * 代理API返佣控制器
 *
 * @author younger
 * @time 2017-8-8 17:21:40
 */
@Controller
//region your codes 1
@RequestMapping("/rebateAgentApiNosettled")
public class RebateAgentApiNosettledController extends BaseCrudController<IRebateAgentApiNosettledService, RebateAgentApiNosettledListVo, RebateAgentApiNosettledVo, RebateAgentApiNosettledSearchForm, RebateAgentApiNosettledForm, RebateAgentApiNosettled, Integer> {
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