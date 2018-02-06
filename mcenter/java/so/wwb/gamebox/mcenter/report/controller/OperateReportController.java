package so.wwb.gamebox.mcenter.report.controller;

import org.soul.commons.data.json.JsonTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.report.IOperateAgentService;
import so.wwb.gamebox.iservice.master.report.IOperatePlayerService;
import so.wwb.gamebox.iservice.master.report.IOperateTopagentService;
import so.wwb.gamebox.iservice.report.operate.ISiteOperateService;
import so.wwb.gamebox.mcenter.report.form.OperateReportSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.SubSysCodeEnum;
import so.wwb.gamebox.model.WeekTool;
import so.wwb.gamebox.model.boss.enums.ExportFileTypeEnum;
import so.wwb.gamebox.model.company.setting.po.SysExport;
import so.wwb.gamebox.model.company.setting.vo.SysExportVo;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.report.vo.OperateAgentListVo;
import so.wwb.gamebox.model.master.report.vo.OperatePlayerListVo;
import so.wwb.gamebox.model.master.report.vo.OperateTopagentListVo;
import so.wwb.gamebox.model.report.operate.vo.SiteOperateListVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.cache.ExportCriteriaTool;
import so.wwb.gamebox.web.report.controller.BaseOperateController;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

/**
 * 经营报表
 * Created by Fei on 15-11-30.
 */
@Controller
@RequestMapping("/report/operate")
public class OperateReportController extends BaseOperateController {

    protected String getViewBasePath() {
        return "/report/operate/";
    }

    private static final Log LOG = LogFactory.getLog(OperateReportController.class);

    @RequestMapping("/operateIndex")
    public String operateReport(OperatePlayerListVo listVo, Model model, @FormModel("search") @Valid OperateReportSearchForm form, BindingResult result) {
        if (result.hasErrors()) return null;
        if(StringTool.isBlank(listVo.getRoleName())){
            listVo.setRoleName("search.topagentName");
        }
        model.addAttribute("validateRule", JsRuleCreator.create(OperateReportSearchForm.class, "search"));

        // 取SubSysCode
        String subSysCode = getSubSysCode(listVo);
        // 设置默认日期
        initDate(listVo, model);

        if (listVo.getOuter() != null && listVo.getOuter() > 0) {
            subSysCode = SubSysCodeEnum.MCENTER_TOP_AGENT.getCode();
            listVo.getSearch().setSiteId(SessionManager.getSiteId());
            model.addAttribute("outApiTypeId", listVo.getSearch().getApiTypeId());
        }

        // 初始化ListVo
        initListVo(listVo);

        // 站长旗下站点报表
        if (subSysCode.equals(SubSysCodeEnum.MCENTER.getCode())) {
            operateSite(listVo, model);
        }
        // 站点旗下总代报表
        else if (subSysCode.equals(SubSysCodeEnum.MCENTER_TOP_AGENT.getCode())) {
            operateTopAgent(listVo, model);
        }
        // 总代旗下代理报表
        else if (subSysCode.equals(SubSysCodeEnum.MCENTER_AGENT.getCode())) {
            operateAgent(listVo, model);
        }
        // 代理旗下玩家报表
        else {
            operatePlayer(listVo, model);
        }
        model.addAttribute("subSysCode", subSysCode);
        model.addAttribute("outer",listVo.getOuter());
        return getViewBasePath() + "Index";
    }

    /**
     * 取SubSysCode
     */
    private String getSubSysCode(OperatePlayerListVo listVo) {
        String subSysCode = listVo.getSubSysCode();

        // 运营商旗下站长报表
        if (StringTool.isBlank(subSysCode)) {
            if (UserTypeEnum.MASTER.getCode().equals(SessionManager.getUserType().getCode())) {
                subSysCode = SubSysCodeEnum.MCENTER.getCode();
            } else {
                subSysCode = SubSysCodeEnum.MCENTER_TOP_AGENT.getCode();
            }
        }
        return subSysCode;
    }

    /**
     * 设置默认日期
     */
    private void initDate(OperatePlayerListVo listVo, Model model) {
        Integer outer = listVo.getOuter() == null ? 0 : listVo.getOuter();
        if (outer != 0) {
            Date today = SessionManager.getDate().getToday();
            Date weekStartDate = WeekTool.getWeekStartDate(today,null);
            Date monthStartDate = WeekTool.getMonthStartDate(today);
            Date tomorrow = DateQuickPicker.getInstance().getTomorrow();
            Date yestoday = DateQuickPicker.getInstance().getYestoday();
            switch (outer) {
                case 1: // 今日
                    String jr = getLocaleDate(today);
                    listVo.getSearch().setStartDate(jr);
                    String mr = getLocaleDate(tomorrow);
                    listVo.getSearch().setEndDate(mr);
                    break;
                case 2: // 昨日
                case 11:
                    String zr = getLocaleDate(DateTool.addDays(today, -1));
                    listVo.getSearch().setStartDate(zr);
                    jr = getLocaleDate(today);
                    listVo.getSearch().setEndDate(jr);
                    break;
                case 3: // 本周
                    listVo.getSearch().setStartDate(getLocaleDate(weekStartDate));
                    listVo.getSearch().setEndDate(getLocaleDate(tomorrow));
                    break;
                case 4: // 上周
                    listVo.getSearch().setStartDate(getLocaleDate(DateTool.addDays(weekStartDate, -7)));
                    listVo.getSearch().setEndDate(getLocaleDate(weekStartDate));
                    break;
                case 5: // 本月
                    listVo.getSearch().setStartDate(getLocaleDate(monthStartDate));
                    listVo.getSearch().setEndDate(getLocaleDate(tomorrow));
                    break;
                case 6: // 上月
                    Date lastMonthFirstDay = SessionManager.getDate().getLastMonthFirstDay(SessionManager.getTimeZone());
                    listVo.getSearch().setStartDate(getLocaleDate(lastMonthFirstDay));
                    listVo.getSearch().setEndDate(getLocaleDate(monthStartDate));
                    break;
                case 7: // 近7天
                    Date now = new Date();
                    listVo.getSearch().setStartDate(getLocaleDate(DateTool.addDays(now, -7)));
                    listVo.getSearch().setEndDate(getLocaleDate(tomorrow));
                    break;
                case 12: // 前天
                    listVo.getSearch().setStartDate(getLocaleDate(DateTool.addDays(today, -2)));
                    listVo.getSearch().setEndDate(getLocaleDate(yestoday));
                    break;
                case 13: // 大前天
                    listVo.getSearch().setStartDate(getLocaleDate(DateTool.addDays(today, -3)));
                    listVo.getSearch().setEndDate(getLocaleDate(DateTool.addDays(today, -2)));
                    break;
                case 14: // 大大前天
                    listVo.getSearch().setStartDate(getLocaleDate(DateTool.addDays(today, -4)));
                    listVo.getSearch().setEndDate(getLocaleDate(DateTool.addDays(today, -3)));
                    break;
                case 15: // 大大大前天
                    listVo.getSearch().setStartDate(getLocaleDate(DateTool.addDays(today, -5)));
                    listVo.getSearch().setEndDate(getLocaleDate(DateTool.addDays(today, -4)));
                    break;
                case 16: // 大大大大前天
                    listVo.getSearch().setStartDate(getLocaleDate(DateTool.addDays(today, -6)));
                    listVo.getSearch().setEndDate(getLocaleDate(DateTool.addDays(today, -5)));
                    break;
                case 17: // 大大大大大前天
                    listVo.getSearch().setStartDate(getLocaleDate(DateTool.addDays(today, -7)));
                    listVo.getSearch().setEndDate(getLocaleDate(DateTool.addDays(today, -6)));
                    break;
            }
        }

        DateVo dateVo = setDefaultData(model, listVo.getSearch().getStartDate(), listVo.getSearch().getEndDate());
        listVo.getSearch().setStartDate(dateVo.getStartDate());
        listVo.getSearch().setEndDate(dateVo.getEndDate());
    }
    private String getLocaleDate(Date date) {
        TimeZone timeZone = SessionManager.getTimeZone();
        return LocaleDateTool.formatDate(date, CommonContext.getDateFormat().getDAY(), timeZone);
    }

    /**
     * 初始化ListVo
     */
    private void initListVo(OperatePlayerListVo listVo) {
        if (UserTypeEnum.MASTER.getCode().equals(SessionManager.getUserType().getCode())) {
            listVo.setSites(querySites(SessionManager.getMasterUserId()));
        } else {
            listVo.getSearch().setSiteId(SessionManager.getSiteId());
        }
        listVo.setRoles(listVo.getRoles());

        Integer siteId = listVo.getSearch().getSiteId();
        if (siteId != null) {
            listVo.setSite(querySite(siteId));
            // 设置数据源
            listVo._setDataSourceId(siteId);
            listVo.setApis(Cache.getSiteApiI18n(siteId));
            listVo.setApiTypes(Cache.getSiteApiTypeI18n(siteId));
            listVo.setGameTypes(Cache.getApiGameType(siteId));

            // 查找总代
            setTopAgent(listVo);
            // 查找代理
            setAgent(listVo);
        }
    }

    /**
     * 查找总代信息
     */
    private void setTopAgent(OperatePlayerListVo listVo) {
        if (listVo.getSearch().getTopagentId() != null) {
            listVo.setUserTop(queryAgent(listVo.getSearch().getSiteId(), listVo.getSearch().getTopagentId()));
        } else if (StringTool.isNotBlank(listVo.getSearch().getTopagentName())) {
            listVo.setUserTop(ServiceSiteTool.operatePlayerService().queryTopAgentByTopAgentName(listVo));
        } else if (StringTool.isNotBlank(listVo.getSearch().getAgentName())) {
            listVo.setUserTop(ServiceSiteTool.operatePlayerService().queryTopagentByAgentName(listVo));
        }
    }

    /**
     * 查找代理信息
     */
    private void setAgent(OperatePlayerListVo listVo) {
        if (listVo.getSearch().getAgentId() != null) {
            listVo.setUserAgent(queryAgent(listVo.getSearch().getSiteId(), listVo.getSearch().getAgentId()));
        } else if (StringTool.isNotBlank(listVo.getSearch().getAgentName())) {
            listVo.setUserAgent(ServiceSiteTool.operatePlayerService().queryAgentByAgentName(listVo));
        }
    }

    /**
     * 站长旗下站点报表
     */
    private void operateSite(OperatePlayerListVo listVo, Model model) {
        listVo.getSearch().setMasterId(SessionManager.getMasterUserId());
        SiteOperateListVo command = ServiceTool.siteOperateService().queryOperateReport(listVo);
        command.setRoleName(listVo.getRoleName());
        model.addAttribute("conditionJson", ExportCriteriaTool.criteriaToJson(command.getExportJsonCondition()));
        model.addAttribute("command", command);
    }

    /**
     * 站点旗下总代报表
     */
    private void operateTopAgent(OperatePlayerListVo listVo, Model model) {
        OperateTopagentListVo command = ServiceSiteTool.operateTopagentService().queryOperateReport(listVo);
        command.setRoleName(listVo.getRoleName());
        model.addAttribute("conditionJson", ExportCriteriaTool.criteriaToJson(command.getExportJsonCondition()));
        model.addAttribute("command", command);
    }

    /**
     * 总代旗下代理报表
     */
    private void operateAgent(OperatePlayerListVo listVo, Model model) {
        OperateAgentListVo command = ServiceSiteTool.operateAgentService().queryOperateReport(listVo);
        command.setRoleName(listVo.getRoleName());
        model.addAttribute("conditionJson", ExportCriteriaTool.criteriaToJson(command.getExportJsonCondition()));
        model.addAttribute("command", command);
    }

    /**
     * 代理旗下玩家报表
     */
    private void operatePlayer(OperatePlayerListVo listVo, Model model) {
        listVo = ServiceSiteTool.operatePlayerService().queryOperateReport(listVo);
        model.addAttribute("conditionJson", ExportCriteriaTool.criteriaToJson(listVo.getExportJsonCondition()));
        model.addAttribute("command", listVo);
    }

    /**
     * 查找站点API
     */
    @RequestMapping("/queryApis")
    @ResponseBody
    public String queryApis(Integer siteId) {
        return JsonTool.toJson(queryApi(siteId));
    }



    /**
     * 从API分类列表的记录按钮链接而来。by river
     */
    @RequestMapping("/fromGameManage")
    public String fromGameManage(OperatePlayerListVo listVo, Model model) {
        initListVo(listVo);
        List<Integer> apiIds = new ArrayList<>(1);
        if(listVo.getSearch().getApiId()!=null){
            apiIds.add(0, listVo.getSearch().getApiId());
            listVo.getSearch().setApiIds(apiIds);
        }

        List<Integer> apiTypeIds = new ArrayList<>(1);
        if(listVo.getSearch().getApiTypeId()!=null){
            apiIds.add(0, listVo.getSearch().getApiTypeId());
            listVo.getSearch().setApiTypeIds(apiTypeIds);
        }

        Date now = new Date();
        Date startDate = DateTool.addDays(now, -7);
        Date endDate = DateTool.addDays(now, -1);
        listVo.getSearch().setStartDate(LocaleDateTool.formatDate(startDate, CommonContext.getDateFormat().getDAY(),SessionManager.getTimeZone()));
        listVo.getSearch().setEndDate(LocaleDateTool.formatDate(endDate, CommonContext.getDateFormat().getDAY(),SessionManager.getTimeZone()));

        initDate(listVo, model);

        if (UserTypeEnum.MASTER.getCode().equals(SessionManager.getUserType().getCode())) {
            operateSite(listVo, model);
        } else {
            operateTopAgent(listVo, model);
        }
        return getViewBasePath() + "Index";
    }


    @Override
    protected SysExportVo buildExportData(SysExportVo vo) {
        if (vo.getResult() == null) {
            vo.setResult(new SysExport());
        }
        if(SubSysCodeEnum.MCENTER.getCode().equals(vo.getSubSysCode())){
            vo.getResult().setService(ISiteOperateService.class.getName());
            vo.getResult().setParam(SiteOperateListVo.class.getName());
            vo.setExportFileType(ExportFileTypeEnum.MASTER_OPERATE_REPORT.getCode());

        }else if(SubSysCodeEnum.MCENTER_TOP_AGENT.getCode().equals(vo.getSubSysCode())){
            vo.getResult().setService(IOperateTopagentService.class.getName());
            vo.getResult().setParam(OperateTopagentListVo.class.getName());
            vo.setExportFileType(ExportFileTypeEnum.TOPAGENT_OPERATE_REPORT.getCode());
        }else if(SubSysCodeEnum.MCENTER_AGENT.getCode().equals(vo.getSubSysCode())){
            vo.getResult().setService(IOperateAgentService.class.getName());
            vo.getResult().setParam(OperateAgentListVo.class.getName());
            vo.setExportFileType(ExportFileTypeEnum.AGENT_OPERATE_REPORT.getCode());
        }else if(SubSysCodeEnum.PCENTER.getCode().equals(vo.getSubSysCode())){
            vo.getResult().setService(IOperatePlayerService.class.getName());
            vo.getResult().setParam(OperatePlayerListVo.class.getName());
            vo.setExportFileType(ExportFileTypeEnum.PLAYER_OPERATE_REPORT.getCode());
        }
        vo.setExportLocale(SessionManager.getLocale().toString());
        vo.getResult().setFileName(LocaleTool.tranView("export","operate_report")+"-"+ DateTool.formatDate(DateQuickPicker.getInstance().getNow(), SessionManager.getLocale(),SessionManager.getTimeZone(),"yyyyMMddHHmmss"));
        vo.getResult().setMethod("queryOperateReportByCustomer");
        vo.getResult().setUsername(SessionManager.getUserName());
        vo.getResult().setExportUserId(SessionManager.getUserId());
        vo.getResult().setExportUserSiteId(SessionManager.getSiteId());
        if(vo.getResult().getSiteId()==null){
            vo.getResult().setSiteId(SessionManager.getSiteId());
        }
        return vo;
    }
}