package so.wwb.gamebox.mcenter.report.rakeback.controller;

import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.model.sys.vo.SysDictVo;
import org.soul.web.locale.DateQuickPicker;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.report.IVRakebackReportService;
import so.wwb.gamebox.mcenter.init.ConfigManager;
import so.wwb.gamebox.mcenter.report.rakeback.form.RakebackBillSearchForm;
import so.wwb.gamebox.mcenter.report.rakeback.form.VRakebackReportForm;
import so.wwb.gamebox.mcenter.report.rakeback.form.VRakebackReportSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.company.enums.SiteStatusEnum;
import so.wwb.gamebox.model.company.setting.po.SysExport;
import so.wwb.gamebox.model.company.setting.vo.SysExportVo;
import so.wwb.gamebox.model.company.sys.po.VSysSiteUser;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.operation.po.RakebackBill;
import so.wwb.gamebox.model.master.operation.vo.RakebackBillListVo;
import so.wwb.gamebox.model.master.operation.vo.RakebackBillVo;
import so.wwb.gamebox.model.master.report.po.VRakebackReport;
import so.wwb.gamebox.model.master.report.vo.VRakebackReportListVo;
import so.wwb.gamebox.model.master.report.vo.VRakebackReportVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.cache.ExportCriteriaTool;
import so.wwb.gamebox.web.report.controller.AbstractExportController;

import javax.validation.Valid;
import java.util.*;


/**
 * 返水统计详细视图 - Fly控制器
 *
 * @author fly
 * @time 2015-12-30 16:20:20
 */
@Controller
//region your codes 1
@RequestMapping("/report/rakeback/detail")
public class VRakebackReportController extends AbstractExportController<IVRakebackReportService, VRakebackReportListVo, VRakebackReportVo, VRakebackReportSearchForm, VRakebackReportForm, VRakebackReport, Integer> {
//endregion your codes 1
    private static final Log LOG = LogFactory.getLog(VRakebackReportController.class);
    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/report/rakeback/detail/";
        //endregion your codes 2
    }

    //region your codes 3
    private static Map<String, SysDictVo> stateMap = null;
    static {
        stateMap = DictTool.get(DictEnum.SETTLEMENT_STATE);
    }

    @RequestMapping("/reportDetail")
    public String reportDetail(VRakebackReportListVo listVo, Model model, @FormModel("search") @Valid RakebackBillSearchForm form, BindingResult result) {
        if (result.hasErrors()) {
            return null;
        }
        listVo.setValidateRule(JsRuleCreator.create(RakebackBillSearchForm.class, "search"));
        // 站长账号
        if (UserTypeEnum.MASTER.getCode().equals(SessionManager.getUserType().getCode())) {
            model.addAttribute("noSub", true);
            // 站点
            listVo.setSites(getSites());
        } else {
            model.addAttribute("noSub", false);
        }

        // 角色
        listVo.setRoles(listVo.getRoles());
        // 玩家结算状态
        listVo.setStateMap(stateMap);
        // 切换站点
        listVo._setDataSourceId(listVo.getSearch().getSiteId());
        // 期数
        listVo.setPeriods(getPeriods(listVo));
        // 查找具体期数
        listVo.setPeriod(getPeriod(listVo));

        // 查找数据
        listVo = ServiceTool.vRakebackReportService().queryRakebackReport(listVo);

        // 格式化年
        listVo.setYearMap(fmtYear(listVo.getYears()));
        // 格式化月
        listVo.setMonthMap(fmtMonth(listVo.getSearch().getRakebackYear()));

        model.addAttribute("command", listVo);

        // add by River
        model.addAttribute("conditionJson",ExportCriteriaTool.criteriaToJson(listVo.getQuery().getCriteria()));

        return getViewBasePath() + "Index";
    }

    /**
     * 获取站长站点
     */
    private List<VSysSiteUser> getSites() {
        Map<String, VSysSiteUser> map = Cache.getSysSiteUser();
        List<VSysSiteUser> sites = new ArrayList<>();
        for (VSysSiteUser site : map.values()) {
            if ((ConfigManager.getConfigration().getSubsysCode()).equals(site.getSubsysCode())
                    && SessionManager.getMasterUserId().intValue() == site.getSysUserId().intValue()
                    && SiteStatusEnum.NORMAL.getCode().equals(site.getStatus())) {
                sites.add(site);
            }
        }
        return sites;
    }

    /** 格式化年 */
    private Map<String, Object> fmtYear(List<String> years) {
        Map<String, Object> yearMap = new LinkedHashMap<>();
        if (years != null) {
            for (String s : years)
                yearMap.put(s, s + i18nViews("common", "year"));
        }
        return yearMap;
    }

    /** 格式化月 */
    private Map<String, Object> fmtMonth(Integer year) {
        String thisYear = DateTool.formatDate(new Date(), "yyyy");
        if (year != null) {
            thisYear = year.toString();
        }
        int max = 12;
        if (DateTool.formatDate(new Date(), "yyyy").equals(thisYear)) {
            max = Integer.parseInt(DateTool.formatDate(new Date(), "M"));
        }
        Map<String, Object> map = new LinkedHashMap<>();
        for (int i = max; i > 0; i--) {
            map.put(i + "", String.format("%s%s", i < 10 ? "0" + i : "" + i, i18nViews("common", "month")));
        }
        return map;
    }

    private String i18nViews(String module, String text) {
        return I18nTool.getI18nMap(SessionManager.getLocale().toString()).get("views").get(module).get(text);
    }

    /**
     * 年份切换
     */
    @RequestMapping("/getMonth")
    @ResponseBody
    public String getMonth(Integer year) {
        Map<String, Object> data = new HashMap<>();
        data.put("size", fmtMonth(year).size());
        data.put("month", fmtMonth(year));
        return JsonTool.toJson(data);
    }

    /**
     * 获取期数
     */
    private List<RakebackBill> getPeriods(VRakebackReportListVo listVo) {
        RakebackBillListVo billVo = new RakebackBillListVo();
        billVo.getSearch().setRakebackYear(listVo.getSearch().getRakebackYear());
        billVo.getSearch().setRakebackMonth(listVo.getSearch().getRakebackMonth());
        billVo._setDataSourceId(billVo.getSearch().getSiteId());
        List<RakebackBill> temp = ServiceTool.rakebackBillService().queryPeriods(billVo);
        List<RakebackBill> periods = new ArrayList<>();
        if (temp != null && !temp.isEmpty()) {
            for (RakebackBill bill : temp) {
                bill.setPeriodName(String.format("%s%s%s", bill.getPeriod(), i18nViews("common", "qi"), bill.getPeriodName()));
                periods.add(bill);
            }
        }
        return periods;
    }

    /**
     * 查找具体期数
     */
    private RakebackBill getPeriod(VRakebackReportListVo listVo) {
        RakebackBillVo vo = new RakebackBillVo();
        vo._setDataSourceId(listVo.getSearch().getSiteId());
        vo.getSearch().setId(listVo.getSearch().getId());
        return ServiceTool.rakebackBillService().get(vo).getResult();
    }

    @RequestMapping("/ajaxYears")
    @ResponseBody
    public String ajaxYears(RakebackBillListVo vo) {
        vo._setDataSourceId(vo.getSiteId());
        return ServiceTool.rakebackBillService().ajaxYears(vo);
    }

    @RequestMapping("/ajaxPeriods")
    @ResponseBody
    public String ajaxPeriods(RakebackBillListVo vo) {
        vo._setDataSourceId(vo.getSiteId());
        return ServiceTool.rakebackBillService().ajaxPeriods(vo);
    }

    @Override
    protected SysExportVo buildExportData(SysExportVo vo) {
        if (vo.getResult() == null) {
            vo.setResult(new SysExport());
        }
        vo.getResult().setService(IVRakebackReportService.class.getName());
        vo.getResult().setMethod("searchRakebackByCustom");
        vo.getResult().setParam(VRakebackReportListVo.class.getName());
        vo.getResult().setFileName(LocaleTool.tranView("export","rakeback")+"-"+ DateTool.formatDate(DateQuickPicker.getInstance().getNow(), SessionManager.getLocale(),SessionManager.getTimeZone(),"yyyyMMddHHmmss"));
        vo.getResult().setUsername(SessionManager.getUserName());
        vo.getResult().setExportUserId(SessionManager.getUserId());
        vo.getResult().setExportUserSiteId(SessionManager.getSiteId());
        if(vo.getResult().getSiteId()==null){
            vo.getResult().setSiteId(SessionManager.getSiteId());
        }
        return vo;
    }

    //endregion your codes 3

}