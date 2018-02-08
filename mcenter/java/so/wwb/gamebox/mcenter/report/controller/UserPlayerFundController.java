package so.wwb.gamebox.mcenter.report.controller;

import net.sf.jxls.transformer.XLSTransformer;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.soul.commons.bean.Pair;
import org.soul.commons.collections.MapTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.http.HttpClient;
import org.soul.commons.http.PostParameter;
import org.soul.commons.http.Response;
import org.soul.commons.lang.DateTool;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.commons.query.sort.Direction;
import org.soul.iservice.taskschedule.ITaskScheduleService;
import org.soul.model.common.BaseListVo;
import org.soul.model.sys.po.SysParam;
import org.soul.model.taskschedule.po.TaskSchedule;
import org.soul.model.taskschedule.vo.TaskScheduleVo;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceScheduleTool;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.report.IVPlayerFundsRecordService;
import so.wwb.gamebox.mcenter.report.form.UserPlayerFundSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.CacheBase;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.boss.enums.ExportFileTypeEnum;
import so.wwb.gamebox.model.boss.enums.TemplateCodeEnum;
import so.wwb.gamebox.model.company.setting.po.SysExport;
import so.wwb.gamebox.model.company.setting.vo.SysExportVo;
import so.wwb.gamebox.model.master.report.vo.UserPlayerFund;
import so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordListVo;
import so.wwb.gamebox.web.report.controller.AbstractExportController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;


/**
 * 控制器
 *
 * @author younger
 * @time 2018-1-7 14:42:07
 */
@Controller
//region your codes 1
@RequestMapping("/userPlayerFund")
public class UserPlayerFundController{
//endregion your codes 1

    private final static Log LOG = LogFactory.getLog(UserPlayerFundController.class);

    @RequestMapping(value = "search")
    public String search(VPlayerFundsRecordListVo listVo, Model model, HttpServletRequest request){
        String templateCode = TemplateCodeEnum.USER_PLAYER_FUND.getCode();
        model.addAttribute("searchTempCode", templateCode);
        model.addAttribute("searchTemplates", CacheBase.getSysSearchTempByCondition(SessionManager.getUserId(), templateCode));
        List<Pair> userTypeSearchKeys = initUserTypeSearchKeys();
        model.addAttribute("userTypeSearchKeys", userTypeSearchKeys);
        String queryParamsJson = JsonTool.toJson(listVo.getSearch());
        model.addAttribute("queryParamsJson", queryParamsJson);
        model.addAttribute("validateRule", JsRuleCreator.create(UserPlayerFundSearchForm.class));
        Date today = DateQuickPicker.getInstance().getTomorrow();
        if(listVo.getSearch().getFundSearch().getSearchStartDate()==null){
            Date startDate = DateTool.addDays(today, -7);
            listVo.getSearch().getFundSearch().setSearchStartDate(startDate);
        }
        if(listVo.getSearch().getFundSearch().getSearchEndDate()==null){
            listVo.getSearch().getFundSearch().setSearchEndDate(today);
        }
        listVo.getQuery().addOrder(UserPlayerFund.PROP_CREATE_TIME, Direction.DESC);
        listVo = ServiceSiteTool.vPlayerFundsRecordService().queryUserPlayerFund(listVo);
        model.addAttribute("command",listVo);
        if(!ServletTool.isAjaxSoulRequest(request)){
            return "/report/playerFund/Index";
        }else{
            return "/report/playerFund/IndexPartial";
        }

    }

    private List<Pair> initUserTypeSearchKeys() {
        List<Pair> searchKeys;
        searchKeys = new ArrayList<>();
        searchKeys.add(new Pair("search.fundSearch.playerName", LocaleTool.tranView(Module.COLUMN.getCode(), "playerAccount")));
        searchKeys.add(new Pair("search.fundSearch.agentName", LocaleTool.tranView(Module.COLUMN.getCode(), "agentAccount")));
        searchKeys.add(new Pair("search.fundSearch.topagentName", LocaleTool.tranView(Module.COLUMN.getCode(), "agentTopAccount")));
        return searchKeys;
    }

    @RequestMapping(value = "export")
    @ResponseBody
    public Map export(VPlayerFundsRecordListVo listVo, SysExportVo sysExportVo, HttpServletRequest request) {
        listVo.getQuery().addOrder(UserPlayerFund.PROP_CREATE_TIME, Direction.DESC);
        Map param = listVo.getQueryParams();
        listVo.getSearch().getFundSearch().setOrderSql(MapTool.getString(param,"sort"));
        sysExportVo.setExportObject(listVo.getSearch());
        return doExport(sysExportVo);
    }
    protected Map doExport(SysExportVo vo){
        Map result = new HashMap();
        try {
            vo = buildExportData(vo);
            vo = ServiceTool.sysExportService().doExport(vo);
            if(vo.isSuccess()){
                TaskScheduleVo taskScheduleVo = new TaskScheduleVo();
                taskScheduleVo.setResult(new TaskSchedule(SysExportVo.EXPORT_SCHEDULE_CODE));
                ITaskScheduleService taskScheduleService = ServiceScheduleTool.getTaskScheduleService();
                taskScheduleService.runOnceTask(taskScheduleVo, vo);
            }
            result.put("state",vo.isSuccess());
        }catch (Exception ex){
            LogFactory.getLog(this.getClass()).error(ex,"导出失败");
            result.put("state",false);
        }
        return result;
    }


    protected SysExportVo buildExportData(SysExportVo vo) {
        if (vo.getResult() == null) {
            vo.setResult(new SysExport());
        }
        vo.getResult().setService(IVPlayerFundsRecordService.class.getName());

        vo.getResult().setMethod("queryExportData");
        vo.getResult().setParam(VPlayerFundsRecordListVo.class.getName());
        vo.getResult().setUsername(SessionManager.getUserName());
        vo.getResult().setExportUserId(SessionManager.getUserId());
        vo.getResult().setExportUserSiteId(SessionManager.getSiteId());
        vo.setExportFileType(ExportFileTypeEnum.USER_PLAYER_FUND.getCode());
        vo.setExportLocale(SessionManager.getLocale().toString());
        if (vo.getResult().getSiteId() == null) {
            vo.getResult().setSiteId(SessionManager.getSiteId());
        }
        String module = LocaleTool.tranView("export", "user_player_fund");
        vo.getResult().setFileName(module + "-" + DateTool.formatDate(DateQuickPicker.getInstance().getNow(), SessionManager.getTimeZone(), DateTool.yyyyMMddHHmmss));
        return vo;
    }
}