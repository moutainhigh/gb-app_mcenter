package so.wwb.gamebox.mcenter.report.controller;

import org.soul.commons.bean.IEntity;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.model.taskschedule.po.TaskSchedule;
import org.soul.model.taskschedule.vo.TaskScheduleVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceScheduleTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.report.operate.ISiteJackpotService;
import so.wwb.gamebox.mcenter.report.form.SiteJackpotForm;
import so.wwb.gamebox.mcenter.report.form.SiteJackpotSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.company.setting.po.SysExport;
import so.wwb.gamebox.model.company.setting.vo.SysExportVo;
import so.wwb.gamebox.model.report.operate.po.SiteJackpot;
import so.wwb.gamebox.model.report.operate.vo.SiteJackpotListVo;
import so.wwb.gamebox.model.report.operate.vo.SiteJackpotVo;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;


/**
 * 站点彩池贡献金统计控制器
 *
 * @author linsen
 * @time 2018-1-18 21:41:59
 */
@Controller
//region your codes 1
@RequestMapping("/siteJackpot")
public class SiteJackpotController extends BaseCrudController<ISiteJackpotService, SiteJackpotListVo, SiteJackpotVo, SiteJackpotSearchForm, SiteJackpotForm, SiteJackpot, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/report/siteJackpot/";
        //endregion your codes 2
    }

    //region your codes 3

    @RequestMapping("/jackpotSite")
    public String jackpotSite(SiteJackpotListVo listVo, SiteJackpotSearchForm form, Model model, HttpServletRequest request) {
        Integer siteId = SessionManager.getSiteId();
        if (siteId != null) {
            listVo.getSearch().setSiteId(siteId);
            listVo = getService().queryJackpotSite(listVo);
            String queryParamsJson = JsonTool.toJson(listVo.getSearch());
            model.addAttribute("queryParamsJson", queryParamsJson);
        }
        model.addAttribute("validateRule",JsRuleCreator.create(SiteJackpotSearchForm.class));
        model.addAttribute("command", listVo);
        if (ServletTool.isAjaxSoulRequest(request)) {
            return getViewBasePath() + "IndexPartial";
        } else {
            return getViewBasePath() + "Index";
        }
    }


    @RequestMapping("/exportRecords")
    @ResponseBody
    public Map exportRecords(SiteJackpotVo siteJackpotVo, SysExportVo vo, Model model) {
        Map result = new HashMap();
        try {
            if ("site".equals(siteJackpotVo.getExportType())) {
                vo = buildSiteExportData(vo);
            } else {
                //未知类型
                result.put("state", false);
                return result;
            }
            if (StringTool.isNotBlank(vo.getQueryParamsJson())) {
                //这里是查询后是固定了查询条件，不会因为条件改变而改变
                IEntity exportObject = JsonTool.fromJson(vo.getQueryParamsJson(), siteJackpotVo.getSearch().getClass());
                vo.setExportObject(exportObject);
            } else {
                //如果没有根据sysExportVo.getQueryParamsJson()查询，那有可能导出的数据和列表数据不对。
                //如果列表修改了条件，但是没有点搜索，直接导出就会有该问题。
                vo.setExportObject(siteJackpotVo.getSearch());
            }
            if (vo == null || vo.getResult() == null) {
                result.put("state", false);
                return result;
            }
            vo = ServiceTool.sysExportService().doExport(vo);
            if (vo.isSuccess()) {
                TaskScheduleVo taskScheduleVo = new TaskScheduleVo();
                taskScheduleVo.setResult(new TaskSchedule(SysExportVo.EXPORT_SCHEDULE_CODE));
                ServiceScheduleTool.getTaskScheduleService().runOnceTask(taskScheduleVo, vo);
            }
            result.put("state", vo.isSuccess());
        } catch (Exception ex) {
            LogFactory.getLog(this.getClass()).error(ex, "导出失败");
            result.put("state", false);
        }
        return result;
    }

    private SysExportVo buildSiteExportData(SysExportVo vo) {
        if (vo.getResult() == null) {
            vo.setResult(new SysExport());
        }
        vo.setConfigKey("SiteApiJackpotForMaster");
        vo.getResult().setService(ISiteJackpotService.class.getName());
        vo.getResult().setMethod("queryJackpotSite");
        vo.getResult().setParam(SiteJackpotListVo.class.getName());
        vo.getResult().setUsername(SessionManager.getUserName());
        vo.getResult().setExportUserId(SessionManager.getUserId());
        vo.getResult().setExportUserSiteId(SessionManager.getSiteId());
        if (vo.getResult().getSiteId() == null) {
            vo.getResult().setSiteId(SessionManager.getSiteId());
        }
        String module = LocaleTool.tranView("export", "site_jackpot_site");
        vo.getResult().setFileName( module + "-" + DateTool.formatDate(DateQuickPicker.getInstance().getNow(), SessionManager.getTimeZone(), DateTool.yyyyMMddHHmmss));
        return vo;
    }
    //endregion your codes 3

}