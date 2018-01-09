package so.wwb.gamebox.mcenter.report.rebate.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
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
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.operation.IRebateBillService;
import so.wwb.gamebox.mcenter.init.ConfigManager;
import so.wwb.gamebox.mcenter.report.rebate.form.RebateBillForm;
import so.wwb.gamebox.mcenter.report.rebate.form.RebateBillSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.company.enums.SiteStatusEnum;
import so.wwb.gamebox.model.company.sys.po.VSysSiteUser;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.operation.po.RebateBill;
import so.wwb.gamebox.model.master.operation.vo.RebateBillListVo;
import so.wwb.gamebox.model.master.operation.vo.RebateBillVo;
import so.wwb.gamebox.model.master.report.po.HighChart;
import so.wwb.gamebox.model.report.rebate.vo.SiteRebateVo;
import so.wwb.gamebox.web.cache.Cache;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 返佣报表
 *  todo::will delete
 * @author fly
 * @time 2015-11-13 14:09
 */
@Controller
@RequestMapping("/report/rebate")
public class RebateReportController extends BaseCrudController<IRebateBillService, RebateBillListVo, RebateBillVo, RebateBillSearchForm, RebateBillForm, RebateBill, Integer> {
    static int LIMIT_NUM = 11; // 限制展示数目

    @Override
    protected String getViewBasePath() {
        return "/report/rebate/";
    }

    @RequestMapping("/rebateIndex")
    public String rebateReport(SiteRebateVo superVo, RebateBillVo subVo, HttpServletRequest request, Model model, @FormModel("search") @Valid RebateBillSearchForm form, BindingResult result) {
        if (result.hasErrors()) {
            return null;
        }

        Integer siteId = superVo.getSearch().getSiteId();
        subVo._setDataSourceId(siteId);
        // 站长账号
        if (UserTypeEnum.MASTER.getCode().equals(SessionManager.getUserType().getCode()) && siteId == null) {
            superVo.setValidateRule(JsRuleCreator.create(RebateBillSearchForm.class, "search"));
            model.addAttribute("noSub", true);
            model.addAttribute("command", masterReport(superVo));
        } else { // 站长子账号
            subVo.setValidateRule(JsRuleCreator.create(RebateBillSearchForm.class, "search"));
            model.addAttribute("noSub", false);
            model.addAttribute("command", siteReport(subVo));
        }

        if (ServletTool.isAjaxSoulRequest(request)) {
            return this.getViewBasePath() + "IndexPartial";
        } else {
            return getViewBasePath() + "Index";
        }
    }

    /**
     * 站长报表
     */
    private SiteRebateVo masterReport(SiteRebateVo command) {
        // 设置结算状态
        Map<String, SysDictVo> stateMap = DictTool.get(DictEnum.SETTLEMENT_STATE);
        command.setStateMap(stateMap);
        // 设置角色
        command.setRoles(command.getRoles());
        // 设置站点
        command.setSites(getSites());
        // 设置站长ID
        command.getSearch().setMasterId(SessionManager.getMasterUserId());

        // 查询报表数据
        command = ServiceTool.siteRebateService().queryRebateReport(command);

        // 格式化年
        command.setYearMap(fmtYear(command.getYears()));
        // 格式化月
        command.setMonthMap(fmtMonth());
        // API转国际化名称
        command.setChartJson(api2Name(command.getCharts(), null));
        return command;
    }

    /**
     * 站点报表
     */
    private RebateBillVo siteReport(RebateBillVo command) {
        // 设置结算状态
        Map<String, SysDictVo> stateMap = DictTool.get(DictEnum.SETTLEMENT_STATE);
        command.setStateMap(stateMap);
        // 设置角色
        command.setRoles(command.getRoles());

        // 查询报表数据
        command = getService().queryRebateReport(command);

        // 格式化年
        command.setYearMap(fmtYear(command.getYears()));
        // 格式化月
        command.setMonthMap(fmtMonth());
        // API转国际化名称
        command.setChartJson(api2Name(command.getCharts(), command.getSearch().getSiteId()));
        return command;
    }

    /**
     * 获取站点
     */
    private List<VSysSiteUser> getSites() {
        Map<String,VSysSiteUser> map = Cache.getSysSiteUser();
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

    /** 格式化月 */
    private Map<String, Object> fmtMonth() {
        Map<String, Object> map = new LinkedHashMap<>();
        for (int i = 12; i > 0; i--) {
            map.put(i + "", String.format("%s%s", i < 10 ? "0" + i : "" + i, i18nViews("common", "month")));
        }
        return map;
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


    /**
     * 限制展示数目
     */
    private List<HighChart> limitGame(List<HighChart> charts) {
        // TODO 暂定11 个游戏明细，超过显示其他
        if (CollectionTool.isNotEmpty(charts) && charts.size() > LIMIT_NUM) {
            HighChart highChart = new HighChart();
            highChart.setName(LocaleTool.tranView("common", "other"));
            highChart.setDrilldown(highChart.getName());
            Double y = 0.0d;
            for (int i = 11; i < charts.size(); i++) {
                Double oY = Double.valueOf(StringTool.isNotEmpty(charts.get(i).getY()) ? charts.get(i).getY() : "0.0");
                y += oY;
            }
            highChart.setY(y + "");
            charts = charts.subList(0, 10);
            charts.add(highChart);
        }
        return charts;
    }

    private String i18nViews(String module, String text) {
        return I18nTool.getI18nMap(SessionManager.getLocale().toString()).get("views").get(module).get(text);
    }

    @RequestMapping("/ajaxPeriods")
    @ResponseBody
    public String ajaxPeriods(RebateBillVo vo) {
        return getService().ajaxPeriods(vo);
    }

}