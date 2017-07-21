package so.wwb.gamebox.mcenter.fund.rebate.controller;

import org.apache.commons.collections.map.HashedMap;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.fund.rebate.IAgentRebateService;
import so.wwb.gamebox.mcenter.fund.rebate.form.AgentRebateForm;
import so.wwb.gamebox.mcenter.fund.rebate.form.AgentRebateSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.master.fund.rebate.RebateStatusEnum;
import so.wwb.gamebox.model.master.fund.rebate.po.AgentRebate;
import so.wwb.gamebox.model.master.fund.rebate.vo.AgentRebateListVo;
import so.wwb.gamebox.model.master.fund.rebate.vo.AgentRebateVo;
import so.wwb.gamebox.web.common.token.Token;

import javax.validation.Valid;
import java.io.Serializable;
import java.util.*;


/**
 * 代理返佣账单控制器
 *
 * @author bruce
 * @time 2017-3-4 14:47:34
 */
@Controller
//region your codes 1
@RequestMapping("/fund/rebate")
public class AgentRebateController extends BaseCrudController<IAgentRebateService, AgentRebateListVo, AgentRebateVo,
        AgentRebateSearchForm, AgentRebateForm, AgentRebate, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/fund/rebate/";
        //endregion your codes 2
    }

    //region your codes 3

    /**
     * 默认查询把当前年月作为期数
     *
     * @param listVo
     * @param form
     * @param result
     * @param model
     * @return
     */
    @Override
    protected AgentRebateListVo doList(AgentRebateListVo listVo, AgentRebateSearchForm form, BindingResult result, Model model) {
        initNumberOfPeriods(listVo);
        paresNumberOfPeriods(listVo);

        Map<String, Serializable> rebateStatus = DictTool.get(DictEnum.REBATE_STATUS);
        model.addAttribute("rebateStatus", rebateStatus);

        /*listVo = super.doList(listVo, form, result, model);
        Collections.sort(listVo.getResult(), new Comparator<AgentRebate>() {
            @Override
            public int compare(AgentRebate o1, AgentRebate o2) {
                return Double.compare(o2.getPayoutAmount() + o2.getPayoutAmountHistory(),o1.getPayoutAmount() + o1.getPayoutAmountHistory());
            }
        });*/

        return super.doList(listVo, form, result, model);
    }

    private void initNumberOfPeriods(AgentRebateListVo listVo) {
        Calendar c = Calendar.getInstance();
        String yearmonth = listVo.getSearch().getYearmonth();
        List<Map<String, String>> yearMonths = getService().yearMonth(listVo);
        if (yearMonths != null && yearMonths.size() > 0) {
            listVo.setNumberOfPeriods(yearMonths);
              if (StringTool.isBlank(yearmonth)) {
                  listVo.getSearch().setYearmonth(yearMonths.get(0).get("yearmonth"));
              }
        } else {
            //第一次没有返佣数据
            setDefaultNumberOfPeriod(listVo, c);
            yearMonths = new ArrayList<>();
            Map<String, String> map = new HashMap<>(1);
            map.put("yearmonth", listVo.getSearch().getYearmonth());
            yearMonths.add(map);
            listVo.setNumberOfPeriods(yearMonths);
        }
    }

    private void setDefaultNumberOfPeriod(AgentRebateListVo listVo,Calendar c) {
        listVo.getSearch().setYearmonth(spliceYearAndMonth(c));
    }

    private String spliceYearAndMonth(Calendar c) {
        return String.valueOf(c.get(Calendar.YEAR)) + "-" + String.valueOf(String.valueOf(c.get(Calendar.MONTH) + 1));
    }

    private void paresNumberOfPeriods(AgentRebateListVo listVo) {
        String numberOfPeriods = listVo.getSearch().getYearmonth();
        if (StringTool.isNotBlank(numberOfPeriods)) {
            String[] strs = numberOfPeriods.split("-");
            listVo.getSearch().setRebateYear(Integer.valueOf(strs[0]));
            listVo.getSearch().setRebateMonth(Integer.valueOf(strs[1]));
        }

    }

    /**
     * 清除:从未处理变更为清除
     *
     * @param agentRebateVo
     * @return
     */
    @RequestMapping("/cleared/{type}")
    @ResponseBody
    public Map clearedFromUntreated(AgentRebateVo agentRebateVo, @PathVariable String type) {
        if (agentRebateVo.getSearch().getId() == null) {
            return getErrorMessage();
        }
        agentRebateVo = getService().get(agentRebateVo);
        agentRebateVo.setUserId(SessionManager.getUserId());
        agentRebateVo.setUserName(SessionManager.getUserName());
        if ("untreated".equals(type)) {
            //从未处理变更为清除
            agentRebateVo = getService().clearedFromUntreated(agentRebateVo);
        } else if ("notreached".equals(type)) {
            //从未达到门坎变更为清除
            agentRebateVo = getService().clearedFromNotreached(agentRebateVo);
        }

        if (agentRebateVo.isSuccess()) {
            return getSuccessMessage();
        } else {
            return getErrorMessage();
        }
    }

    /***
     * 调转到结算窗口
     *
     * @param agentRebateVo
     * @param model
     * @return
     */
    @RequestMapping("/toSettled")
    @Token(generate = true)
    public String toSettled(AgentRebateVo agentRebateVo, Model model) {
        model.addAttribute("validateRule", JsRuleCreator.create(AgentRebateForm.class));
        model.addAttribute("command", getService().get(agentRebateVo));
        return getViewBasePath() + "Settled";
    }

    /**
     * 代理可获返佣结算
     *
     * @param agentRebateVo
     * @return
     */
    @RequestMapping("/settled")
    @ResponseBody
    @Token(valid = true)
    public Map settled(AgentRebateVo agentRebateVo, @Valid @FormModel AgentRebateForm form, BindingResult result) {
        if (result.hasErrors()) {
            return getErrorMessage();
        }

        agentRebateVo.setUserId(SessionManager.getUserId());
        agentRebateVo.setUserName(SessionManager.getUserName());
        agentRebateVo = getService().settled(agentRebateVo);
        if (agentRebateVo.isSuccess()) {
            return getSuccessMessage();
        } else {
            return getErrorMessage();
        }
    }
    @RequestMapping("/signBill")
    @ResponseBody
    public Map signBill(Integer id){
        Map resMap = new HashedMap(2);
        resMap.put("state",true);
        if(id==null){
            resMap.put("state",false);
            return resMap;
        }
        AgentRebateVo rebateVo = new AgentRebateVo();
        rebateVo.getSearch().setId(id);
        rebateVo = getService().get(rebateVo);
        if(rebateVo.getResult()==null){
            resMap.put("state",false);
            return resMap;
        }
        AgentRebate result = rebateVo.getResult();
        if(!RebateStatusEnum.NOTREACHED.getCode().equals(result.getRebateStatus())
                &&!RebateStatusEnum.NOTREACHED.getCode().equals(result.getRebateStatus())){
            resMap.put("state",false);
            return resMap;
        }
        result.setRebateStatus(RebateStatusEnum.SIGNBILL.getCode());
        rebateVo.setProperties(AgentRebate.PROP_REBATE_STATUS);
        rebateVo = getService().updateOnly(rebateVo);
        resMap.putAll(getVoMessage(rebateVo));
        return resMap;
    }

    //endregion your codes 3

}