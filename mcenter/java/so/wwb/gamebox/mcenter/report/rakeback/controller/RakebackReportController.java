package so.wwb.gamebox.mcenter.report.rakeback.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.net.ServletTool;
import org.soul.model.sys.vo.SysDictVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.operation.IRakebackBillService;
import so.wwb.gamebox.mcenter.init.ConfigManager;
import so.wwb.gamebox.mcenter.report.rakeback.form.RakebackBillForm;
import so.wwb.gamebox.mcenter.report.rakeback.form.RakebackBillSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.company.enums.SiteStatusEnum;
import so.wwb.gamebox.model.company.sys.po.VSysSiteUser;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.operation.po.RakebackBill;
import so.wwb.gamebox.model.master.operation.vo.RakebackBillListVo;
import so.wwb.gamebox.model.master.operation.vo.RakebackBillVo;
import so.wwb.gamebox.model.master.report.po.HighChart;
import so.wwb.gamebox.model.report.rakeback.vo.SiteRakebackPlayerVo;
import so.wwb.gamebox.web.cache.Cache;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 返水报表
 *
 * @author fly
 * @time 2015-11-13 14:09
 */
@Controller
@RequestMapping("/report/rakeback")
public class RakebackReportController extends BaseCrudController<IRakebackBillService, RakebackBillListVo, RakebackBillVo, RakebackBillSearchForm, RakebackBillForm, RakebackBill, Integer> {
    static int LIMIT_NUM = 11; // 限制展示数目

    @Override
    protected String getViewBasePath() {
        return "/report/rakeback/";
    }

    @RequestMapping("/rakebackIndex")
    public String rakebackReport(SiteRakebackPlayerVo superVo, RakebackBillVo subVo, Model model, HttpServletRequest request, @FormModel("search") @Valid RakebackBillSearchForm form, BindingResult result) {
        if (result.hasErrors()) {
            return null;
        }

        Map<String, SysDictVo> stateMap = DictTool.get(DictEnum.SETTLEMENT_STATE);
        model.addAttribute("states", stateMap);

        model.addAttribute("roles", subVo.getRoles());

        Integer siteId = superVo.getSearch().getSiteId();
        subVo._setDataSourceId(siteId);
        // 站长账号
        if (UserTypeEnum.MASTER.getCode().equals(SessionManager.getUserType().getCode()) && siteId == null) {
            superVo.setValidateRule(JsRuleCreator.create(RakebackBillSearchForm.class, "search"));
            model.addAttribute("sites", getSites());

            model.addAttribute("noSub", true);
            superVo.getSearch().setMasterId(SessionManager.getMasterUserId());
            superVo = ServiceTool.siteRakebackPlayerService().queryRakebackReport(superVo);
            // 格式化年
            superVo.setYearMap(fmtYear(superVo.getYears()));
            if(!superVo.getYearMap().isEmpty()){
                builMonthData(model);
            }
            // API转国际化名称
            superVo.setChartJson(api2Name(superVo.getCharts(), CommonContext.get().getSiteId()));
            model.addAttribute("command", superVo);
        } else { // 站长子账号
            subVo.setValidateRule(JsRuleCreator.create(RakebackBillSearchForm.class, "search"));
            subReport(subVo, model);
        }
        if (ServletTool.isAjaxSoulRequest(request)) {
            return this.getViewBasePath() + "IndexPartial";
        } else {
            return getViewBasePath() + "Index";
        }
    }

    private void builMonthData(Model model) {
        Map<Integer, String> monthMap = new LinkedHashMap<>();
        for (int i = 12; i > 0; i--)
            monthMap.put(i, i + i18nViews("common", "month"));
        model.addAttribute("months", monthMap);
    }

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

    /**
     * 子账号返水报表
     */
    private void subReport(RakebackBillVo subVo, Model model) {
        model.addAttribute("noSub", false);
        subVo = getService().queryRakebackReport(subVo);
        subVo.setYearMap(fmtYear(subVo.getYears()));
        if(!subVo.getYearMap().isEmpty()){
            builMonthData(model);
        }
        subVo.setChartJson(api2Name(subVo.getCharts(), subVo.getSearch().getSiteId()));
        model.addAttribute("command", subVo);
    }

    /**
     * 格式化年
     */
    private Map<String, Object> fmtYear(List<String> years) {
        Map<String, Object> yearMap = new LinkedHashMap<>();
        if (years != null) {
            for (String s : years)
                yearMap.put(s, s + i18nViews("common", "year"));
        }
        return yearMap;
    }

    /**
     * API转国际化名称
     */
    private String api2Name(List<HighChart> charts, Integer siteId) {
        charts = limitGame(charts);
        List<HighChart> temp = new ArrayList<>();
        if(siteId==null){
            siteId = SessionManager.getSiteId();
        }
        for (HighChart chart : charts) {
            chart.setName(getApiName(chart,siteId));
            chart.setDrilldown(Cache.getGameTypeName(chart.getDrilldown()));
            temp.add(chart);
        }
        return JsonTool.toJson(temp);
    }

    private String getApiName(HighChart chart,Integer siteId){
        String apiName = Cache.getSiteApiNameReturnNull(chart.getName(), siteId);
        //找不到自定义名称
        if(StringTool.isBlank(apiName)){
            apiName = Cache.getApiName(chart.getName());
        }
        return apiName;
    }

    private List<HighChart> limitGame(List<HighChart> highChartList) {
        // TODO 暂定11 个游戏明细，超过显示其他
        if (CollectionTool.isNotEmpty(highChartList) && highChartList.size() > LIMIT_NUM) {
            HighChart highChart = new HighChart();
            highChart.setName(LocaleTool.tranView("common", "other"));
            highChart.setDrilldown(highChart.getName());
            Double y = 0.0d;
            for (int i = 11; i < highChartList.size(); i++) {
                Double oY = Double.valueOf(StringTool.isNotEmpty(highChartList.get(i).getY()) ? highChartList.get(i).getY() : "0.0");
                y += oY;
            }
            highChart.setY(y + "");
            highChartList = highChartList.subList(0, 10);
            highChartList.add(highChart);
        }
        return highChartList;
    }

    private String i18nViews(String module, String text) {
        return I18nTool.getI18nMap(SessionManager.getLocale().toString()).get("views").get(module).get(text);
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

    /**
     * 获取期数
     */
    private List<RakebackBill> getPeriods(RakebackBillListVo listVo) {
        RakebackBillListVo billVo = new RakebackBillListVo();
        billVo.getSearch().setRakebackYear(listVo.getSearch().getRakebackYear());
        billVo.getSearch().setRakebackMonth(listVo.getSearch().getRakebackMonth());
        billVo._setDataSourceId(listVo.getSearch().getSiteId());
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
    private RakebackBill getPeriod(RakebackBillListVo listVo) {
        RakebackBillVo vo = new RakebackBillVo();
        vo._setDataSourceId(listVo.getSearch().getSiteId());
        vo.getSearch().setId(listVo.getSearch().getId());
        return ServiceTool.rakebackBillService().get(vo).getResult();
    }

}
