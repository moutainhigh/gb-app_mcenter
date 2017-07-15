package so.wwb.gamebox.mcenter.fund.rebate.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.fund.rebate.IAgentRebateGradsService;
import so.wwb.gamebox.mcenter.fund.rebate.form.AgentRebateGradsForm;
import so.wwb.gamebox.mcenter.fund.rebate.form.AgentRebateGradsSearchForm;
import so.wwb.gamebox.model.CacheBase;
import so.wwb.gamebox.model.company.site.po.SiteApiTypeRelationI18n;
import so.wwb.gamebox.model.master.fund.rebate.po.AgentRebateGrads;
import so.wwb.gamebox.model.master.fund.rebate.vo.AgentRebateGradsListVo;
import so.wwb.gamebox.model.master.fund.rebate.vo.AgentRebateGradsVo;

import java.util.Map;


/**
 * 代理返佣_玩家明细控制器
 *
 * @author bruce
 * @time 2017-3-4 15:07:30
 */
@Controller
//region your codes 1
@RequestMapping("/fund/rebate/agent/grads")
public class AgentRebateGradsController extends BaseCrudController<IAgentRebateGradsService, AgentRebateGradsListVo,
        AgentRebateGradsVo, AgentRebateGradsSearchForm, AgentRebateGradsForm, AgentRebateGrads, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/fund/rebate/";
        //endregion your codes 2
    }

    //region your codes 3

    /**
     * 损益明细
     *
     * @param listVo
     * @param model
     * @return
     */
    @RequestMapping("/payOut")
    public String getPayOut(AgentRebateGradsListVo listVo, Model model) {
        searchAgentRebateGrads(listVo, model);
        return getViewBasePath() + "PayoutDetail";
    }

    private void searchAgentRebateGrads(AgentRebateGradsListVo listVo, Model model) {
        listVo.setPaging(null);
        listVo = getService().search(listVo);
        Map<String, SiteApiTypeRelationI18n> siteApiTypeRelactionI18nMap = CacheBase.getSiteApiTypeRelactionI18n(listVo._getSiteId());
        for (AgentRebateGrads agentRebateGrads : listVo.getResult()) {
            for (Map.Entry<String, SiteApiTypeRelationI18n> entry : siteApiTypeRelactionI18nMap.entrySet()) {
                SiteApiTypeRelationI18n siteApiTypeRelationI18n = entry.getValue();
                if (siteApiTypeRelationI18n.getApiId().equals(agentRebateGrads.getApiId()) && siteApiTypeRelationI18n.getApiTypeId().equals(agentRebateGrads.getApiTypeId())) {
                    agentRebateGrads.setApiName(entry.getValue().getName());
                    break;
                }
            }
        }
        model.addAttribute("command", listVo);
    }

    /**
     * 可退返佣明细
     *
     * @param listVo
     * @return
     */
    @RequestMapping("/retrunRebateDetail")
    public String getReturnRebateDetail(AgentRebateGradsListVo listVo, Model model) {
        searchAgentRebateGrads(listVo, model);
        return getViewBasePath() + "ReturnRebate";
    }

    //endregion your codes 3

}