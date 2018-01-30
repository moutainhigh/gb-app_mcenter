package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.collections.MapTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.locale.LocaleTool;
import org.soul.model.common.FieldProperty;
import org.soul.model.listop.po.SysListOperator;
import org.soul.model.security.privilege.po.SysUserStatus;
import org.soul.web.listop.ListOpTool;
import org.soul.web.session.SessionManagerBase;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.player.IVUserAgentManageService;
import so.wwb.gamebox.mcenter.enmus.ListOpEnum;
import so.wwb.gamebox.mcenter.player.form.VUserAgentManageForm;
import so.wwb.gamebox.mcenter.player.form.VUserAgentManageSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.share.form.SysListOperatorForm;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.WeekTool;
import so.wwb.gamebox.model.boss.enums.ExportFileTypeEnum;
import so.wwb.gamebox.model.company.setting.po.SysExport;
import so.wwb.gamebox.model.company.setting.vo.SysExportVo;
import so.wwb.gamebox.model.company.site.po.SiteCurrency;
import so.wwb.gamebox.model.company.sys.po.SysDomain;
import so.wwb.gamebox.model.company.sys.vo.SysDomainListVo;
import so.wwb.gamebox.model.listop.FilterRow;
import so.wwb.gamebox.model.listop.FilterSelectConstant;
import so.wwb.gamebox.model.listop.StatusEnum;
import so.wwb.gamebox.model.listop.TabTypeEnum;
import so.wwb.gamebox.model.master.player.po.PlayerRank;
import so.wwb.gamebox.model.master.player.po.VUserAgentManage;
import so.wwb.gamebox.model.master.player.vo.VUserAgentManageListVo;
import so.wwb.gamebox.model.master.player.vo.VUserAgentManageVo;
import so.wwb.gamebox.model.master.setting.po.RebateSet;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.cache.ExportCriteriaTool;
import so.wwb.gamebox.web.report.controller.AbstractExportController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Serializable;
import java.util.*;


/**
 * 代理（总代）管理控制器
 *
 * @author tom
 * @time 2015-9-9 14:22:44
 */
@Controller
//region your codes 1
@RequestMapping("/vUserAgentManage")
public class VUserAgentManageController extends AbstractExportController<IVUserAgentManageService, VUserAgentManageListVo, VUserAgentManageVo, VUserAgentManageSearchForm, VUserAgentManageForm, VUserAgentManage, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/player/agent/agentmanage/";
        //endregion your codes 2
    }

    //region your codes 3

    /**
     * 查询列表
     * @return
     */
    @Override
    protected VUserAgentManageListVo doList(VUserAgentManageListVo listVo, VUserAgentManageSearchForm form, BindingResult result, Model model) {
        /** 首页链接 */
        initDate(listVo);

        listVo = ServiceSiteTool.vUserAgentManageService().searchByCustom(listVo);
        Map allListFields = ListOpTool.getFields(ListOpEnum.VUserAgentManageListVo);
        listVo.setAllFieldLists(allListFields);

        if (allListFields != null) {
            model.addAttribute("list", allListFields.values());
        }

        Map<String, Serializable> status = DictTool.get(DictEnum.USER_STATUS);
        status.remove(SysUserStatus.AUDIT_FAIL.getCode());
        model.addAttribute("status", status);
        String params = ExportCriteriaTool.criteriaToJson(listVo.getQuery().getCriteria());
        model.addAttribute("params",params);
        model.addAttribute("hasReturn",listVo.getSearch().isHasReturn());
        return listVo;
    }

    private void initDate(VUserAgentManageListVo listVo) {
        Integer outer = listVo.getOuter() == null ? 0 : listVo.getOuter();
        if (outer != 0) {
            Date today = SessionManager.getDate().getToday();
            Date now = SessionManager.getDate().getNow();
            Date weekStartDate = WeekTool.getWeekStartDate(today);
            Date monthStartDate = WeekTool.getMonthStartDate(today);
            switch (outer) {
                case 1: // 今日
                    listVo.getSearch().setStartTime(today);
                    listVo.getSearch().setEndTime(now);
                    break;
                case 2: // 昨日
                    listVo.getSearch().setStartTime(SessionManager.getDate().getYestoday());
                    listVo.getSearch().setEndTime(today);
                    break;
                case 3: // 本周
                    listVo.getSearch().setStartTime(weekStartDate);
                    listVo.getSearch().setEndTime(today);
                    break;
                case 4: // 上周
                    listVo.getSearch().setStartTime(DateTool.addDays(weekStartDate, -7));
                    listVo.getSearch().setEndTime(weekStartDate);
                    break;
                case 5: // 本月
                    listVo.getSearch().setStartTime(monthStartDate);
                    listVo.getSearch().setEndTime(today);
                    break;
                case 6: // 上月
                    Date lastMonthFirstDay = SessionManager.getDate().getLastMonthFirstDay(SessionManager.getTimeZone());
                    listVo.getSearch().setStartTime(lastMonthFirstDay);
                    listVo.getSearch().setEndTime(monthStartDate);
                    break;
            }
            List<String> statuses = new ArrayList<>();
            statuses.add(StatusEnum.LIMIT.getCode());
            statuses.add(StatusEnum.AUDITFAIL.getCode());
            listVo.getSearch().setStatuses(statuses);
        }
    }

    private void queryAgentLinks(VUserAgentManageListVo listVo) {
        if (StringTool.isNotBlank(listVo.getSearch().getAgentLink())) {
            SysDomainListVo domainListVo = new SysDomainListVo();
            domainListVo.getSearch().setSiteId(SessionManager.getSiteId());
            domainListVo.getSearch().setDomain(listVo.getSearch().getAgentLink());
            List<SysDomain> sysDomains = ServiceTool.sysDomainService().queryByDomain(domainListVo);
            CollectionTool.extractToString(sysDomains, SysDomain.PROP_AGENT_ID, ",");
        }
    }

    /**
     * 更多数据
     *
     * @return
     */
    @RequestMapping(value = "/columns")
    public String indexOp(HttpServletRequest request, HttpServletResponse response, Model model) {
        VUserAgentManageListVo vo = new VUserAgentManageListVo();
        Map<String, FieldProperty> fieldPropertyMap = vo.getDefaultFields();

        Map<String, Boolean> hasFields = new HashMap();
        ListOpTool.refreshFields(ListOpEnum.VUserAgentManageListVo);
        Map listOp = ListOpTool.getFields(ListOpEnum.VUserAgentManageListVo);
        Map map = new TreeMap(new Comparator() {
            @Override
            public int compare(Object o1, Object o2) {
                return ((Integer) o1) - ((Integer) o2);
            }
        });
        if (listOp != null) {
            map.putAll(listOp);
        }
        for (Object o : listOp.keySet()) {
            SysListOperator tem = (SysListOperator) listOp.get(o);
            ArrayList<Map<String, String>> tt = JsonTool.fromJson(tem.getContent(), ArrayList.class);
            for (Map<String, String> stringStringMap : tt) {
                for (String s : stringStringMap.keySet()) {
                    hasFields.put(stringStringMap.get("name"), true);
                }
            }
            tem.setMapContent(tt);
        }

        model.addAttribute("keyClassName", ListOpEnum.VUserAgentManageListVo.getClassName());
        model.addAttribute("defaultFeilds", fieldPropertyMap);
        model.addAttribute("lists", map);
        model.addAttribute("hasFeilds", hasFields);

        return "share/ListColumns";
    }

    /**
     * 筛选管理
     *
     * @param model
     * @return
     */
    @RequestMapping({"/filters"})
    public String list(Model model) {

        Map<String, SysListOperator> listOp = ListOpTool.getFilter(ListOpEnum.VUserAgentManageListVo);
        if (listOp != null && listOp.size() > 0) {
            model.addAttribute("filters", listOp.values());
        }
        //region Filter Conditions
        String vUserAgentManager = VUserAgentManage.class.getSimpleName();
        List<FilterRow> filterRowList = new ArrayList<>();

        filterRowList.add(new FilterRow(VUserAgentManage.PROP_PLAYER_NUM, LocaleTool.tranView("column", vUserAgentManager + "." + VUserAgentManage.PROP_PLAYER_NUM),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        Map<String, List<Pair>> agentFilter = ServiceSiteTool.vUserAgentManageService().searchAgentFilter(new VUserAgentManageListVo());
        if (MapTool.isNotEmpty(agentFilter)) {
            List<Pair> playerRankList = agentFilter.get(PlayerRank.class.getName());
            filterRowList.add(new FilterRow(VUserAgentManage.PROP_PLAYER_RANK_ID, LocaleTool.tranView("column", vUserAgentManager + "." + VUserAgentManage.PROP_PLAYER_RANK_ID),
                    FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, playerRankList));

            List<Pair> rebateSetList = agentFilter.get(RebateSet.class.getName());
            filterRowList.add(new FilterRow(VUserAgentManage.PROP_REBATE_ID, LocaleTool.tranView("column", vUserAgentManager + "." + VUserAgentManage.PROP_REBATE_NAME),
                    FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, rebateSetList));

           /* List<Pair> rakebackSetList = agentFilter.get(RakebackSet.class.getName());
            filterRowList.add(new FilterRow(VUserAgentManage.PROP_RAKEBACK_ID, LocaleTool.tranView("column", vUserAgentManager + "." + VUserAgentManage.PROP_RAKEBACK_NAME),
                    FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, rakebackSetList));*/

            List<Pair> currencys = new ArrayList<>();
            Map<String, SiteCurrency> currencyList = Cache.getSiteCurrency();
            Map<String, String> curencyI18nMap = I18nTool.getDictsMap(SessionManagerBase.getLocale().toString()).get(Module.COMMON.getCode()).get(DictEnum.COMMON_CURRENCY.getType());
            for (SiteCurrency currency : currencyList.values()) {
                currencys.add(new Pair(currency.getCode(), curencyI18nMap.get(currency.getCode())));
            }
            filterRowList.add(new FilterRow(VUserAgentManage.PROP_DEFAULT_CURRENCY, LocaleTool.tranView("column", vUserAgentManager + "." + VUserAgentManage.PROP_DEFAULT_CURRENCY),
                    FilterSelectConstant.equal, TabTypeEnum.SELECT, currencys));
        }
        filterRowList.add(new FilterRow(VUserAgentManage.PROP_TOTAL_REBATE, LocaleTool.tranView("column", vUserAgentManager + "." + VUserAgentManage.PROP_TOTAL_REBATE),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        filterRowList.add(new FilterRow(VUserAgentManage.PROP_ACCOUNT_BALANCE, LocaleTool.tranView("column", vUserAgentManager + "." + VUserAgentManage.PROP_ACCOUNT_BALANCE),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        // TODO 国家地区联动
        /*filterRowList.add(new FilterRow(VUserAgentManage.PROP_COUNTRY, LocaleTool.tranView("column", vUserAgentManager + "." + VUserAgentManage.PROP_COUNTRY),
                FilterSelectConstant.contain, TabTypeEnum.TEXT, null));*/
        filterRowList.add(new FilterRow(VUserAgentManage.PROP_SEX, LocaleTool.tranView("column", vUserAgentManager + "." + VUserAgentManage.PROP_SEX),
                FilterSelectConstant.equal, TabTypeEnum.SELECT, FilterSelectConstant.sex));
        filterRowList.add(new FilterRow(VUserAgentManage.PROP_BIRTHDAY, LocaleTool.tranView("column", vUserAgentManager + "." + VUserAgentManage.PROP_BIRTHDAY),
                FilterSelectConstant.greatAndLess, TabTypeEnum.DATE, null));
        filterRowList.add(new FilterRow(VUserAgentManage.PROP_CREATE_TIME, LocaleTool.tranView("column", vUserAgentManager + "." + VUserAgentManage.PROP_CREATE_TIME),
                FilterSelectConstant.greatAndLess, TabTypeEnum.DATE, null));
        filterRowList.add(new FilterRow(VUserAgentManage.PROP_LAST_LOGIN_TIME, LocaleTool.tranView("column", vUserAgentManager + "." + VUserAgentManage.PROP_LAST_LOGIN_TIME),
                FilterSelectConstant.greatAndLess, TabTypeEnum.DATE, null));
        List<Pair> userStatus = new ArrayList<>();
        userStatus.add(new Pair(SysUserStatus.INACTIVE.getCode(), LocaleTool.tranView("common", "SysUserStatus." + SysUserStatus.INACTIVE.getCode())));// 待审核/正常/账号停用/账号冻结（可多选）。
        userStatus.add(new Pair(SysUserStatus.NORMAL.getCode(), LocaleTool.tranView("common", "SysUserStatus." + SysUserStatus.NORMAL.getCode())));
        userStatus.add(new Pair(SysUserStatus.DISABLED.getCode(), LocaleTool.tranView("common", "SysUserStatus." + SysUserStatus.DISABLED.getCode())));
        userStatus.add(new Pair(SysUserStatus.LOCKED.getCode(), LocaleTool.tranView("common", "SysUserStatus." + SysUserStatus.LOCKED.getCode())));
        filterRowList.add(new FilterRow(VUserAgentManage.PROP_STATUS, LocaleTool.tranView("column", vUserAgentManager + "." + VUserAgentManage.PROP_STATUS),
                FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, FilterSelectConstant.status));

        model.addAttribute("validateRule", JsRuleCreator.create(SysListOperatorForm.class, ""));
        model.addAttribute("filterList", filterRowList);
        model.addAttribute("keyClassName", ListOpEnum.VUserAgentManageListVo.getClassName());
        model.addAttribute("jsonFilterList", JsonTool.toJson(filterRowList));
        model.addAttribute("goFilterUrl", "/vUserAgentManage/index.html");

        return "/share/ListFilters";
    }

    @Override
    protected SysExportVo buildExportData(SysExportVo vo) {
        if (vo.getResult() == null) {
            vo.setResult(new SysExport());
        }
        vo.getResult().setService(IVUserAgentManageService.class.getName());
        vo.getResult().setMethod("searchByCustom");
        vo.setExportFileType(ExportFileTypeEnum.AGENT_MANAGE.getCode());
        vo.setExportLocale(SessionManager.getLocale().toString());
        vo.getResult().setParam(VUserAgentManageListVo.class.getName());
        vo.getResult().setUsername(SessionManager.getUserName());
        vo.getResult().setExportUserId(SessionManager.getUserId());
        vo.getResult().setExportUserSiteId(SessionManager.getSiteId());
        if(vo.getResult().getSiteId()==null){
            vo.getResult().setSiteId(SessionManager.getSiteId());
        }
        vo.getResult().setFileName(LocaleTool.tranView("export","agent_manage")+"-"
                + DateTool.formatDate(DateQuickPicker.getInstance().getNow(), SessionManager.getLocale(),SessionManager.getTimeZone(),"yyyyMMddHHmmss"));
        return vo;
    }

    //endregion your codes 3

}