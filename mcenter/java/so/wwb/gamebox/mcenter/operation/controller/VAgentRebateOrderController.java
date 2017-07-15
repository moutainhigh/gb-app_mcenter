package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.operation.IVAgentRebateOrderService;
import so.wwb.gamebox.mcenter.operation.form.VAgentRebateOrderForm;
import so.wwb.gamebox.mcenter.operation.form.VAgentRebateOrderSearchForm;
import so.wwb.gamebox.model.master.operation.po.VAgentRebateOrder;
import so.wwb.gamebox.model.master.operation.vo.VAgentRebateOrderListVo;
import so.wwb.gamebox.model.master.operation.vo.VAgentRebateOrderVo;


/**
 * 代理返佣订单视图控制器
 *
 * @author eagle
 * @time 2015-12-22 17:25:16
 */
@Controller
//region your codes 1
@RequestMapping("/vAgentRebateOrder")
public class VAgentRebateOrderController extends BaseCrudController<IVAgentRebateOrderService, VAgentRebateOrderListVo, VAgentRebateOrderVo, VAgentRebateOrderSearchForm, VAgentRebateOrderForm, VAgentRebateOrder, Integer> {
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