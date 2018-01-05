package so.wwb.gamebox.mcenter.operation.controller;

import org.apache.commons.collections.map.HashedMap;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.model.log.audit.enums.ParamType;
import org.soul.model.log.audit.vo.BaseLog;
import org.soul.model.log.audit.vo.LogVo;
import org.soul.model.log.audit.vo.Param;
import org.soul.model.sys.po.SysAuditLog;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.mcenter.operation.form.RebateAgentForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.master.operation.po.RebateAgent;
import so.wwb.gamebox.model.master.operation.vo.RebateAgentVo;
import so.wwb.gamebox.model.master.operation.vo.RebateBillVo;
import so.wwb.gamebox.model.report.enums.SettlementStateEnum;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;
import so.wwb.gamebox.web.fund.controller.BaseRebateAgentController;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.*;


/**
 * 玩家返佣表控制器
 *
 * @author younger
 * @time 2017-08-08 11:35:46
 */
@Controller
//region your codes 1
@RequestMapping("/rebateAgent")
public class RebateAgentController extends BaseRebateAgentController{

    private static final Log LOG = LogFactory.getLog(RebateAgentController.class);
    //endregion your codes 1

    @Override
    protected String getViewBasePath() {
        return "/operation/rebateAgent/";
    }


    //region your codes 3

    /***
     * 调转到结算窗口
     *
     * @param rebateAgentVo
     * @param model
     * @return
     */
    @RequestMapping("/toSettled")
    @Token(generate = true)
    public String toSettled(RebateAgentVo rebateAgentVo, Model model) {
        model.addAttribute("validateRule", JsRuleCreator.create(RebateAgentForm.class));
        model.addAttribute("command", getService().get(rebateAgentVo));
        return getViewBasePath() + "Settled";
    }
    @RequestMapping("/settled")
    @ResponseBody
    @Token(valid = true)
    public Map settled(RebateAgentVo rebateAgentVo,@FormModel("result") @Valid RebateAgentForm form, BindingResult result,HttpServletRequest request){
        Map resMap = new HashMap(3,1f);
        if(result.hasErrors()){
            resMap.put("state",false);
            resMap.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
            return resMap;
        }
        if(rebateAgentVo.getResult()==null||rebateAgentVo.getResult().getId()==null){
            resMap.put("state",false);
            resMap.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
            return resMap;
        }
        try{
            rebateAgentVo = getRebateAgentVo(rebateAgentVo, SettlementStateEnum.LSSUING.getCode());
            resMap = getVoMessage(rebateAgentVo);
            List<String> agentName = new ArrayList<>();
            agentName.add(rebateAgentVo.getResult().getAgentName());
            logging(rebateAgentVo.getResult().getId(),"结算返佣金额",request,agentName);
        }catch (Exception ex){
            resMap.put("state",false);
            resMap.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
            LOG.error(ex,"代理返佣结算出错:{0}",ex.getMessage());
        }

        return resMap;
    }

    @RequestMapping("/batchSettled")
    @ResponseBody
    public Map batchSettled(RebateAgentVo rebateAgentVo){
        Map resMap = new HashMap(3,1f);
        try {
            List<Integer> ids = rebateAgentVo.getIds();
            if(ids!=null && ids.size()>0){
                for (Integer id : ids){
                    RebateAgentVo vo = new RebateAgentVo();
                    vo.getSearch().setId(id);
                    vo = getService().get(vo);
                    vo.getResult().setRebateActual(vo.getResult().getRebateTotal());
                    getRebateAgentVo(vo, SettlementStateEnum.LSSUING.getCode());
                }
            }
        }catch (Exception ex){
            resMap.put("state",false);
        }
        resMap.put("state",true);
        return resMap;
    }

    private RebateAgentVo getRebateAgentVo(RebateAgentVo rebateAgentVo, String code) {
        rebateAgentVo.getResult().setOperateUserId(SessionManager.getUserId());
        rebateAgentVo.getResult().setOperateUsername(SessionManager.getUserName());
        rebateAgentVo.getResult().setSettlementTime(new Date());
        rebateAgentVo.getResult().setSettlementState(code);
        rebateAgentVo.setProperties(RebateAgent.PROP_REBATE_ACTUAL, RebateAgent.PROP_SETTLEMENT_STATE, RebateAgent.PROP_OPERATE_USER_ID, RebateAgent.PROP_OPERATE_USERNAME,
                RebateAgent.PROP_SETTLEMENT_TIME);
        rebateAgentVo = getService().settled(rebateAgentVo);
        return rebateAgentVo;
    }

    /**
     * 记录日志
     *
     * @param id         settlement_rebate主键
     * @param request
     * @param agentNames
     */
    private void logging(Integer id, String desc, HttpServletRequest request, List<String> agentNames) {
        LogVo logVo = new LogVo();
        BaseLog baseLog = logVo.addBussLog();
        baseLog.setDescription(desc);
        baseLog.setEntityId(id);//此处id是主表settlement_rebate上的id
        baseLog.addParam("date", new Param("date", SessionManager.getDate().getNow(), ParamType.DATE.getCode()));
        baseLog.addParam(SessionManager.getUserName()).addParam(StringTool.join(",", agentNames));
        request.setAttribute(SysAuditLog.AUDIT_LOG, logVo);
    }

    @RequestMapping("/batchSignBill")
    @ResponseBody
    public Map batchSignBill(RebateAgentVo rebateAgentVo){
        Map resMap = new HashedMap(2,1f);
        resMap.put("state",true);
        List<Integer> ids = rebateAgentVo.getIds();
        if(ids==null){
            resMap.put("state",false);
            return resMap;
        }
        for (Integer id : ids){
            RebateAgentVo vo = new RebateAgentVo();
            vo.getSearch().setId(id);
            vo = getService().get(vo);
            if(vo.getResult()==null){
                continue;
            }
            if(!SettlementStateEnum.PENDING_LSSUING.getCode().equals(vo.getResult().getSettlementState())){
                continue;
            }
            if(hasNextPeriod(vo)){
                continue;
            }

            vo.setProperties(RebateAgent.PROP_SETTLEMENT_STATE);
            vo.getResult().setSettlementState(SettlementStateEnum.NEXT_LSSUING.getCode());
            getService().updateOnly(vo);
        }
        return resMap;
    }

    @RequestMapping("/signBill")
    @ResponseBody
    public Map signBill(Integer id){
        Map resMap = new HashedMap(2,1f);
        resMap.put("state",true);
        if(id==null){
            resMap.put("state",false);
            return resMap;
        }
        RebateAgentVo rebateAgentVo = new RebateAgentVo();
        rebateAgentVo.getSearch().setId(id);
        rebateAgentVo = getService().get(rebateAgentVo);
        if(rebateAgentVo.getResult()==null){
            resMap.put("state",false);
            String msg = LocaleTool.tranMessage(Module.MASTER_OPERATION.getCode(), MessageI18nConst.OPERATION_REBATE_NORECORD);
            resMap.put("msg",msg);
            return resMap;
        }
        if(!SettlementStateEnum.PENDING_LSSUING.getCode().equals(rebateAgentVo.getResult().getSettlementState())){
            String msg = LocaleTool.tranMessage(Module.MASTER_OPERATION.getCode(), MessageI18nConst.OPERATION_REBATE_ERRORSTATUS);
            resMap.put("msg",msg);
            resMap.put("state",false);
            return resMap;
        }
        if(hasNextPeriod(rebateAgentVo)){
            String msg = LocaleTool.tranMessage(Module.MASTER_OPERATION.getCode(), MessageI18nConst.OPERATION_REBATE_HASNEXTBILL);
            resMap.put("msg",msg);
            resMap.put("state",false);
            return resMap;
        }

        rebateAgentVo.setProperties(RebateAgent.PROP_SETTLEMENT_STATE);
        rebateAgentVo.getResult().setSettlementState(SettlementStateEnum.NEXT_LSSUING.getCode());
        rebateAgentVo = getService().updateOnly(rebateAgentVo);
        resMap = getVoMessage(rebateAgentVo);
        return resMap;
    }

    private boolean hasNextPeriod(RebateAgentVo rebateAgentVo){
        RebateBillVo rebateBillVo = new RebateBillVo();
        rebateBillVo.getSearch().setId(rebateAgentVo.getResult().getRebateBillId());
        rebateBillVo = ServiceSiteTool.rebateBillService().get(rebateBillVo);
        if(rebateAgentVo.getResult()!=null){
            String period = rebateBillVo.getResult().getPeriod();
            Date date = DateTool.parseDate(period, "yyyy-MM");
            Date nextMonth = DateTool.addMonths(date, 1);
            String formatDate = DateTool.formatDate(nextMonth, "yyyy-MM");
            rebateBillVo = new RebateBillVo();
            rebateBillVo.getSearch().setPeriod(formatDate);
            rebateBillVo = ServiceSiteTool.rebateBillService().search(rebateBillVo);
            if(rebateBillVo.getResult()!=null){
                return true;
            }
        }
        return false;
    }

    @RequestMapping("/batchClear")
    @ResponseBody
    public Map batchClear(RebateAgentVo rebateAgentVo){
        Map resMap = new HashedMap(2,1f);
        try {
            List<Integer> ids = rebateAgentVo.getIds();
            if(ids!=null && ids.size()>0){
                for (Integer id : ids){
                    RebateAgentVo vo = new RebateAgentVo();
                    vo.getSearch().setId(id);
                    vo = getService().get(vo);
                    if(vo.getResult()==null){
                        continue;
                    }
                    if(!SettlementStateEnum.PENDING_LSSUING.getCode().equals(vo.getResult().getSettlementState())){
                        continue;
                    }
                    vo.getResult().setRebateActual(0d);
                    getRebateAgentVo(vo, SettlementStateEnum.REJECT_LSSUING.getCode());
                }
            }
        }catch (Exception ex){
            resMap.put("state",false);
        }
        resMap.put("state",true);
        return resMap;
    }

    @RequestMapping("/clear")
    @ResponseBody
    public Map clear(Integer id){
        Map resMap = new HashedMap(2,1f);
        resMap.put("state",true);
        if(id==null){
            resMap.put("state",false);
            return resMap;
        }
        RebateAgentVo rebateAgentVo = new RebateAgentVo();
        rebateAgentVo.getSearch().setId(id);
        rebateAgentVo = getService().get(rebateAgentVo);
        if(rebateAgentVo.getResult()==null){
            resMap.put("state",false);
            return resMap;
        }
        if(!SettlementStateEnum.PENDING_LSSUING.getCode().equals(rebateAgentVo.getResult().getSettlementState())){
            resMap.put("state",false);
            return resMap;
        }
        try{
            rebateAgentVo.getResult().setRebateActual(0d);
            rebateAgentVo = getRebateAgentVo(rebateAgentVo, SettlementStateEnum.REJECT_LSSUING.getCode());
            resMap = getVoMessage(rebateAgentVo);
        }catch (Exception ex){
            resMap.put("state",false);
            LOG.error(ex,"代理返佣清除出错:{0}",ex.getMessage());
        }

        return resMap;
    }
    //endregion your codes 3

}