package so.wwb.gamebox.mcenter.report.rebate.controller;

import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.model.sys.vo.SysDictVo;
import org.soul.web.locale.DateQuickPicker;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.report.IVRebateReportService;
import so.wwb.gamebox.mcenter.init.ConfigManager;
import so.wwb.gamebox.mcenter.report.rebate.form.VRebateReportForm;
import so.wwb.gamebox.mcenter.report.rebate.form.VRebateReportSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.company.enums.SiteStatusEnum;
import so.wwb.gamebox.model.company.setting.po.SysExport;
import so.wwb.gamebox.model.company.setting.vo.SysExportVo;
import so.wwb.gamebox.model.company.sys.po.VSysSiteUser;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.operation.po.RebateBill;
import so.wwb.gamebox.model.master.operation.vo.RebateBillVo;
import so.wwb.gamebox.model.master.report.po.VRebateReport;
import so.wwb.gamebox.model.master.report.vo.VRebateReportListVo;
import so.wwb.gamebox.model.master.report.vo.VRebateReportVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.cache.ExportCriteriaTool;
import so.wwb.gamebox.web.report.controller.AbstractExportController;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


/**
 * 返佣统计详细视图控制器
 *
 * @author fly
 * @time 2015-11-16 12:38:53
 */
@Controller
//region your codes 1
@RequestMapping("/report/rebate/detail")
public class VRebateReportController extends AbstractExportController<IVRebateReportService, VRebateReportListVo, VRebateReportVo, VRebateReportSearchForm, VRebateReportForm, VRebateReport, Integer> {
//endregion your codes 1
private static final Log LOG = LogFactory.getLog(VRebateReportController.class);
    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/report/rebate/detail/";
        //endregion your codes 2
    }

    //region your codes 3
    static Map<String, SysDictVo> stateMap = null;
    static {
        stateMap = DictTool.get(DictEnum.SETTLEMENT_STATE);
    }

    @RequestMapping("/reportDetail")
    public String reportDetail(VRebateReportListVo listVo, HttpServletRequest request, Model model) {
        // 站长账号
        if (UserTypeEnum.MASTER.getCode().equals(SessionManager.getUserType().getCode())) {
            model.addAttribute("noSub", true);
            // 设置站点
            listVo.setSites(getSites());
        } else {
            model.addAttribute("noSub", false);
        }

        // 设置角色
        listVo.setRoles(listVo.getRoles());
        // 玩家结算状态
        listVo.setStateMap(stateMap);
        // 切换站点
        listVo._setDataSourceId(listVo.getSearch().getSiteId());
        // 查找期数
        listVo.setPeriods(getPeriods(listVo));
        // 查找具体期数
        listVo.setPeriod(getPeriod(listVo));

        // 查找数据
        listVo = ServiceTool.vRebateReportService().queryRebateReport(listVo);

        // 格式化年
        listVo.setYearMap(fmtYear(listVo.getYears()));
        // 格式化月
        listVo.setMonthMap(fmtMonth());

        model.addAttribute("command", listVo);

        // 列表需要导出时要将查询条件转换为json串 add by River
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

    /**
     * 获取期数
     */
    private List<RebateBill> getPeriods(VRebateReportListVo listVo) {
        RebateBillVo vo = new RebateBillVo();
        vo.getSearch().setRebateYear(listVo.getSearch().getRebateYear());
        vo.getSearch().setRebateMonth(listVo.getSearch().getRebateMonth());
        vo._setDataSourceId(listVo.getSearch().getSiteId());
        List<RebateBill> temp = ServiceTool.rebateBillService().queryPeriods(vo);
        List<RebateBill> periods = new ArrayList<>();
        if (temp != null && !temp.isEmpty()) {
            for (RebateBill bill : temp) {
                bill.setPeriodName(String.format("%s%s%s", bill.getPeriod(), i18nViews("common", "qi"), bill.getPeriodName()));
                periods.add(bill);
            }
        }
        return periods;
    }

    /**
     * 查找具体期数
     */
    private RebateBill getPeriod(VRebateReportListVo listVo) {
        RebateBillVo vo = new RebateBillVo();
        vo._setDataSourceId(listVo.getSearch().getSiteId());
        vo.getSearch().setId(listVo.getSearch().getId());
        return ServiceTool.rebateBillService().get(vo).getResult();
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


    private String i18nViews(String module, String text) {
        return I18nTool.getI18nMap(SessionManager.getLocale().toString()).get("views").get(module).get(text);
    }

    @RequestMapping("/ajaxPeriods")
    @ResponseBody
    public String ajaxPeriods(RebateBillVo vo) {
        vo._setDataSourceId(vo.getSiteId());
        return ServiceTool.rebateBillService().ajaxPeriods(vo);
    }

    @Override
    protected SysExportVo buildExportData(SysExportVo vo) {
        if (vo.getResult() == null) {
            vo.setResult(new SysExport());
        }
        vo.getResult().setService(IVRebateReportService.class.getName());
        vo.getResult().setMethod("searchRebateByCustomer");
        vo.getResult().setParam(VRebateReportListVo.class.getName());
        vo.getResult().setFileName(LocaleTool.tranView("export","rebate")+"-"+ DateTool.formatDate(DateQuickPicker.getInstance().getNow(), SessionManager.getLocale(),SessionManager.getTimeZone(),"yyyyMMddHHmmss"));
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