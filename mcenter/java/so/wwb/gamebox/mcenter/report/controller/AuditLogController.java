package so.wwb.gamebox.mcenter.report.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.dict.DictTool;
import org.soul.commons.enums.EnumTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.net.ServletTool;
import org.soul.commons.query.Criteria;
import org.soul.model.log.audit.vo.BaseLog;
import org.soul.model.log.audit.vo.LogVo;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.model.sys.po.SysAuditLog;
import org.soul.model.sys.vo.SysAuditLogListVo;
import org.soul.model.sys.vo.SysAuditLogVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.report.IAuditLogService;
import so.wwb.gamebox.iservice.master.report.IVRakebackReportService;
import so.wwb.gamebox.mcenter.report.form.SysAuditLogForm;
import so.wwb.gamebox.mcenter.report.form.SysAuditLogSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.SysExportForm;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.ModuleType;
import so.wwb.gamebox.model.company.setting.po.SysExport;
import so.wwb.gamebox.model.company.setting.vo.SysExportVo;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.agent.enums.SysUserTypeEnum;
import so.wwb.gamebox.model.master.player.vo.PlayerRankVo;
import so.wwb.gamebox.model.master.player.vo.VUserPlayerVo;
import so.wwb.gamebox.model.master.setting.vo.RakebackSetVo;
import so.wwb.gamebox.model.report.vo.AddLogVo;
import so.wwb.gamebox.web.cache.ExportCriteriaTool;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.util.*;

/**
 * @author fly
 * @time 2015-11-06 11:02
 */
@Controller
@RequestMapping("/report/log")
public class AuditLogController extends BaseCrudController<IAuditLogService, SysAuditLogListVo, SysAuditLogVo, SysAuditLogSearchForm, SysAuditLogForm, SysAuditLog, String> {
    private static final String EXPORT_RECORDS_URI = "/setting/exports/ReportExport";
    @Override
    protected String getViewBasePath() {
        return "/report/log/";
    }

    @RequestMapping("/logList")
    protected String logList(SysAuditLogListVo listVo, Model model, HttpServletRequest request) {
        DictTool.refresh(DictEnum.Search_Keyword);


        List<Pair> keys = new ArrayList<>();
        keys.add(new Pair("search.operator", LocaleTool.tranDict(DictEnum.Search_Keyword,"sole")));
        keys.add(new Pair("search.ip", LocaleTool.tranDict(DictEnum.Search_Keyword,"ip")));

        model.addAttribute("opType", DictTool.get(DictEnum.Log_OpType));//操作类型
        model.addAttribute("moduleTypes", DictTool.get(DictEnum.Log_Type));
        model.addAttribute("now", SessionManager.getDate().getNow());
        model.addAttribute("keys", keys);
        model.addAttribute("hasReturnhasReturn", request.getParameter("hasReturn"));
        String searchKey = request.getParameter("keys");
        if(StringTool.isNotBlank(searchKey)){
            model.addAttribute("searchKey",searchKey);
        }else {
            model.addAttribute("searchKey","search.operator");
        }

        if (UserTypeEnum.MASTER_SUB.getCode().equals(SessionManager.getUserType().getCode())) {
            listVo.getSearch().setOperatorId(SessionManager.getUser().getOwnerId());
        }
        beforeQuery(listVo,model);
        listVo = getService().queryLogs(listVo);
        Criteria sysAuditLogCriteria = getService().getSysAuditLogCriteria(listVo);
        String s = ExportCriteriaTool.criteriaToJson(sysAuditLogCriteria);
        model.addAttribute("conditionJson", s);
        if(listVo.getSearch().getEntityUserId()!=null){
            SysUserVo userVo = new SysUserVo();
            userVo.getSearch().setId(listVo.getSearch().getEntityUserId());
            userVo = ServiceTool.sysUserService().get(userVo);
            if(userVo.getResult()!=null){
                listVo.getSearch().setOperator(userVo.getResult().getUsername());
            }
        }
        model.addAttribute("command", listVo);

        if (ServletTool.isAjaxSoulRequest(request)) {
            return getViewBasePath() + "IndexPartial";
        } else {
            return getViewBasePath() + "Index";
        }
    }

    private void beforeQuery(SysAuditLogListVo listVo,Model model) {
        List<Pair> roleKeys = new ArrayList<>();
        if (listVo.getSearch().getRoleType()==null || StringTool.equals(listVo.getSearch().getRoleType(), "master")){
            listVo.getSearch().setRoleType("master");
            roleKeys.add(new Pair(UserTypeEnum.MASTER.getCode(), LocaleTool.tranView("report_auto","站长")));
            roleKeys.add(new Pair(UserTypeEnum.MASTER_SUB.getCode(),LocaleTool.tranView("report_auto","站长-子账号")));
        }else if (StringTool.equals(listVo.getSearch().getRoleType(), SysUserTypeEnum.AGENT.getCode())){
            roleKeys.add(new Pair(UserTypeEnum.AGENT.getCode(),LocaleTool.tranView("report_auto","代理")));
            roleKeys.add(new Pair(UserTypeEnum.AGENT_SUB.getCode(),LocaleTool.tranView("report_auto","代理-子账号")));
        }else if (StringTool.equals(listVo.getSearch().getRoleType(),SysUserTypeEnum.TOP_AGENT.getCode())){
            roleKeys.add(new Pair(UserTypeEnum.TOP_AGENT.getCode(),LocaleTool.tranView("report_auto","总代")));
            roleKeys.add(new Pair(UserTypeEnum.TOP_AGENT_SUB.getCode(),LocaleTool.tranView("report_auto","总代-子账号")));
        }
        if(listVo.getSearch().getOperatorBegin()==null&&listVo.getSearch().getOperatorEnd()==null) {
            listVo.getSearch().setOperatorEnd(new Date());
            listVo.getSearch().setOperatorBegin(SessionManager.getDate().addDays(-7));
        }
        /* 清除下拉筛选角色时，多次赋值*//*
        if (listVo.getSearch().getOperatorUserType().split(",").length>1){
            listVo.getSearch().setOperatorUserType(listVo.getSearch().getOperatorUserType().split(",")[1]);
        }*/

        model.addAttribute("roleKeys",roleKeys);
    }

    /**
     * 导出
     * @author river
     */
    @RequestMapping("/exportRecords")
    public String exportRecords(SysExportVo vo, Model model) {
        if (vo.getResult() == null) {
            vo.setResult(new SysExport());
        }
        vo.getResult().setExportType(SysAuditLogListVo.class.getName());
        vo.getResult().setService(IAuditLogService.class.getName());
        vo.getResult().setMethod("searchAuditListByCustom");
        vo.setConfigKey("siteSysAuditLog");
        vo.getResult().setParam(SysAuditLogListVo.class.getName());
        vo.setValidateRule(JsRuleCreator.create(SysExportForm.class, "result"));
        model.addAttribute("command", vo);
        return EXPORT_RECORDS_URI;
    }

    /**
     * common日志接口
     * @param request
     * @param description 日志描述
     * @param addLogVo 日志参数vo
     */
    public static void addLog(HttpServletRequest request, String description, AddLogVo addLogVo) {
        LogVo logVo = new LogVo();
        BaseLog baseLog = logVo.addBussLog();
        baseLog.setDescription(description);
        if(addLogVo.getResult().getEntityId()!=null){
            baseLog.setEntityId(addLogVo.getResult().getEntityId());
            baseLog.setEntityUserId(addLogVo.getResult().getEntityUserId());
            baseLog.setEntityUsername(addLogVo.getResult().getEntityUsername());
        }
        for(String param:addLogVo.getList()){
            baseLog.addParam(param);
        }
        request.setAttribute(SysAuditLog.AUDIT_LOG, logVo);
    }
}
