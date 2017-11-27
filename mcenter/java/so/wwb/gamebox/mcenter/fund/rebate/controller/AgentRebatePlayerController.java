package so.wwb.gamebox.mcenter.fund.rebate.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.fund.rebate.IAgentRebatePlayerService;
import so.wwb.gamebox.mcenter.fund.rebate.form.AgentRebatePlayerForm;
import so.wwb.gamebox.mcenter.fund.rebate.form.AgentRebatePlayerSearchForm;
import so.wwb.gamebox.model.master.fund.rebate.po.AgentRebatePlayer;
import so.wwb.gamebox.model.master.fund.rebate.vo.AgentRebatePlayerListVo;
import so.wwb.gamebox.model.master.fund.rebate.vo.AgentRebatePlayerVo;
import so.wwb.gamebox.model.master.fund.rebate.vo.AgentRebateVo;


/**
 * 代理返佣_玩家明细控制器
 *
 * @author bruce
 * @time 2017-3-4 15:08:46
 */
@Controller
//region your codes 1
@RequestMapping("/fund/rebate/agent")
public class AgentRebatePlayerController extends BaseCrudController<IAgentRebatePlayerService, AgentRebatePlayerListVo,
        AgentRebatePlayerVo, AgentRebatePlayerSearchForm, AgentRebatePlayerForm, AgentRebatePlayer, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/fund/rebate/agent/";
        //endregion your codes 2
    }

    //region your codes 3

    @Override
    protected AgentRebatePlayerListVo doList(AgentRebatePlayerListVo listVo, AgentRebatePlayerSearchForm form, BindingResult result, Model model) {
        AgentRebateVo agentRebateVo = new AgentRebateVo();
        agentRebateVo.getSearch().setAgentId(listVo.getSearch().getAgentId());
        agentRebateVo.getSearch().setRebateYear(listVo.getSearch().getRebateYear());
        agentRebateVo.getSearch().setRebateMonth(listVo.getSearch().getRebateMonth());
        agentRebateVo = ServiceTool.agentRebateService().search(agentRebateVo);
        model.addAttribute("agentRebateVo", agentRebateVo);
        return super.doList(listVo, form, result, model);
    }

    //endregion your codes 3

}