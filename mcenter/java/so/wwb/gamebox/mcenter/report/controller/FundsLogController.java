package so.wwb.gamebox.mcenter.report.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.report.IVPlayerTransactionService;
import so.wwb.gamebox.mcenter.report.form.VPlayerTransactionForm;
import so.wwb.gamebox.mcenter.report.form.VPlayerTransactionSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.SiteI18nEnum;
import so.wwb.gamebox.model.WeekTool;
import so.wwb.gamebox.model.company.enums.SiteStatusEnum;
import so.wwb.gamebox.model.company.setting.po.SysExport;
import so.wwb.gamebox.model.company.setting.vo.SysExportVo;
import so.wwb.gamebox.model.company.sys.po.SysSite;
import so.wwb.gamebox.model.company.sys.vo.SysSiteListVo;
import so.wwb.gamebox.model.master.enums.CommonStatusEnum;
import so.wwb.gamebox.model.master.fund.enums.TransactionTypeEnum;
import so.wwb.gamebox.model.master.fund.vo.PlayerFavorableVo;
import so.wwb.gamebox.model.master.report.po.VPlayerTransaction;
import so.wwb.gamebox.model.master.report.vo.VPlayerTransactionListVo;
import so.wwb.gamebox.model.master.report.vo.VPlayerTransactionVo;
import so.wwb.gamebox.common.cache.Cache;
import so.wwb.gamebox.common.cache.ExportCriteriaTool;
import so.wwb.gamebox.web.report.controller.AbstractExportController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.*;


/**
 * 玩家交易视图-jeff控制器
 *
 * @author jeff
 * @time 2015-11-12 14:57:43
 */
@Controller
//region your codes 1
@RequestMapping("/report/fundsLog")
public class FundsLogController extends AbstractExportController<IVPlayerTransactionService, VPlayerTransactionListVo, VPlayerTransactionVo, VPlayerTransactionSearchForm, VPlayerTransactionForm, VPlayerTransaction, Integer> {

    private static final Log LOG = LogFactory.getLog(FundsLogController.class);
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/report/fund/";
        //endregion your codes 2
    }

    //region your codes 3
    @Override
    public String list(VPlayerTransactionListVo listVo, @FormModel("search") @Valid VPlayerTransactionSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        String queryString = request.getQueryString();
        model.addAttribute("queryString",queryString);
        return super.list(listVo, form, result, model, request, response);
    }

    @Override
    protected VPlayerTransactionListVo doList(VPlayerTransactionListVo listVo, VPlayerTransactionSearchForm form, BindingResult result, Model model) {

        /* 前台判断是否子账户　*/
        boolean isMaster = SessionManager.isCurrentSiteMaster();
       // List<Pair> searchKeys = initSearchKeys();
        List<Pair> userTypeSearchKeys = initUserTypeSearchKeys();
        if(isMaster){
             if(listVo.getSiteId()!=null){
                listVo._setDataSourceId(listVo.getSiteId());
            }else {
                 listVo._setDataSourceId(SessionManager.getSiteId());
                 listVo.setSiteId(SessionManager.getSiteId() );
             }
            SysSiteListVo sysSiteListVo = new SysSiteListVo();
            sysSiteListVo.setResult(findSites());
            listVo.setSysSiteListVo(sysSiteListVo);
        }else{
            listVo.setSiteId(SessionManager.getSiteId());
        }



        listVo.setIsMaster(isMaster);

        // 首页运营概况链接
        initDate(listVo, model);
        Integer comp = listVo.getComp();
        if (comp != null && comp == 1) {
            int rawOffset = SessionManager.getTimeZone().getRawOffset();
            int hour = rawOffset/1000/3600;
            listVo.getSearch().setTimeZoneInterval(hour);
            listVo = ServiceSiteTool.vPlayerTransactionService().queryPlayerTransactionOutLink(listVo);
        }else if("playerRakeback".equals(listVo.getSearch().getType())){
            listVo = ServiceSiteTool.vPlayerTransactionService().queryPlayerRakeback(listVo);
        } else {
            listVo = super.doList(listVo, form, result, model);
        }
        /*类别字典*/
        listVo.setDictFundType(DictTool.get(DictEnum.COMMON_FUND_TYPE));
        /*状态字典*/
        listVo.setDictCommonStatus(DictTool.get(DictEnum.COMMON_STATUS));
       // model.addAttribute("searchKeys", searchKeys);
        model.addAttribute("userTypeSearchKeys", userTypeSearchKeys);

        //列表需要导出时要将查询条件转换为json串
        String conditionJson = ExportCriteriaTool.criteriaToJson(listVo.getQuery().getCriteria());
        model.addAttribute("conditionJson",conditionJson);
        model.addAttribute("maxDate",new Date());
        return listVo;
    }

    private void initDate(VPlayerTransactionListVo listVo, Model model) {
        if (listVo.getSearch().getStatus() == null) {
            listVo.getSearch().setStatus(CommonStatusEnum.SUCCESS.getCode());
        }
        Integer outer = listVo.getOuter() == null ? 0 : listVo.getOuter();
        model.addAttribute("outer", outer);
        if (outer != 0) {
            if(listVo.getSearch().getStartTime()!=null&&listVo.getSearch().getEndTime()!=null){
                return;
            }
            Date today = SessionManager.getDate().getToday();
            Date now = SessionManager.getDate().getNow();
            Date weekStartDate = WeekTool.getWeekStartDate(today,null);
            Date monthStartDate = WeekTool.getMonthStartDate(today);
            switch (outer) {
                case 1: // 今日
                    listVo.getSearch().setStartTime(today);
                    listVo.getSearch().setEndTime(now);
                    break;
                case 2: // 昨日
                case 11:
                    listVo.getSearch().setStartTime(SessionManager.getDate().getYestoday());
                    listVo.getSearch().setEndTime(subtract1second(today));
                    break;
                case 3: // 本周
                    listVo.getSearch().setStartTime(weekStartDate);
                    listVo.getSearch().setEndTime(subtract1second(today));
                    break;
                case 4: // 上周
                    listVo.getSearch().setStartTime(DateTool.addDays(weekStartDate, -7));
                    listVo.getSearch().setEndTime(subtract1second(weekStartDate));
                    break;
                case 5: // 本月
                    listVo.getSearch().setStartTime(monthStartDate);
                    listVo.getSearch().setEndTime(subtract1second(today));
                    break;
                case 6: // 上月
                    Date lastMonthDay = DateTool.addMonths(today,-1);
                    Date lastMonthFirstDay = WeekTool.getMonthStartDate(lastMonthDay);
                    listVo.getSearch().setStartTime(lastMonthFirstDay);
                    listVo.getSearch().setEndTime(subtract1second(monthStartDate));
                    break;
                case 12: // 前天
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -2));
                    listVo.getSearch().setEndTime(subtract1second(SessionManager.getDate().getYestoday()));
                    break;
                case 13: // 大前天
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -3));
                    listVo.getSearch().setEndTime(subtract1second(DateTool.addDays(today, -2)));
                    break;
                case 14: // 大大前天
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -4));
                    listVo.getSearch().setEndTime(subtract1second(DateTool.addDays(today, -3)));
                    break;
                case 15: // 大大大前天
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -5));
                    listVo.getSearch().setEndTime(subtract1second(DateTool.addDays(today, -4)));
                    break;
                case 16: // 大大大大前天
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -6));
                    listVo.getSearch().setEndTime(subtract1second(DateTool.addDays(today, -5)));
                    break;
                case 17: // 大大大大大前天
                    listVo.getSearch().setStartTime(DateTool.addDays(today, -7));
                    listVo.getSearch().setEndTime(subtract1second(DateTool.addDays(today, -6)));
                    break;
            }
        }else{
            if(listVo.getSearch().getBeginCreateTime()==null && listVo.getSearch().getEndCreateTime()==null){
                listVo.getSearch().setBeginCreateTime(SessionManager.getDate().addDays(-6));
                listVo.getSearch().setEndCreateTime(new Date());
            }
        }
    }

    /**
     * 减去1秒
     */
    private Date subtract1second(Date date) {
        return DateTool.addSeconds(date, -1);
    }

    @RequestMapping("/showFromDeposit")
    public String showFromDeposit(VPlayerTransactionListVo listVo, VPlayerTransactionSearchForm form, BindingResult result, Model model){
        List<String> fundsType = new ArrayList<>();
        fundsType.add("company_deposit");
        fundsType.add("artificial_deposit");
        fundsType.add("online_deposit");
        fundsType.add("wechatpay_scan");
        fundsType.add("alipay_scan");
        fundsType.add("wechatpay_fast");
        fundsType.add("alipay_fast");
        listVo.getSearch().setFundTypes(fundsType);
        listVo = doList(listVo,form,result,model);
        model.addAttribute("command",listVo);
        return getViewBasePath() +"Index";
    }

    private List<SysSite> findSites() {
        List<SysSite> sites = new ArrayList();
        findMasterSysSites(sites);
        return sites;
    }

    private void findMasterSysSites(List<SysSite> sites) {
        SysSiteListVo listVo = new SysSiteListVo();
        if(SessionManager.isCurrentSiteMaster()){
            listVo.getSearch().setSysUserId(SessionManager.getMasterUserId());
        }else {
            listVo.getSearch().setSysUserId(SessionManager.getUserId());
        }
        List<SysSite> temp = ServiceTool.sysSiteService().bySysUserId(listVo).getResult();
        for (SysSite site:temp){
            //if (StringTool.equals(site.getStatus(), SiteStatusEnum.NORMAL.getCode())){
            if(!SiteStatusEnum.DISABLED.getCode().equals(site.getStatus())&&!SiteStatusEnum.UN_BUILD.getCode().equals(site.getStatus())){
                String siteLocaleName = "";
                if (Cache.getSiteI18n(SiteI18nEnum.SETTING_SITE_NAME, site.getId())!=null) {
                    siteLocaleName = Cache.getSiteI18n(SiteI18nEnum.SETTING_SITE_NAME, site.getId()).get(SessionManager.getLocale().toString()).getValue();
                }
                if (siteLocaleName!=""){
                    site.setName(siteLocaleName);
                }else {
                    LOG.debug("站点[{0}]没有SiteI18n国际化名称，取sys_site站点名称",site.getId());
                }
                sites.add(site);
            }
        }
    }



    private List<Pair> initUserTypeSearchKeys() {
        /**
         * 列表搜索栏[关键字]下拉切换
         */
        List<Pair> searchKeys;
        searchKeys = new ArrayList<>();
        searchKeys.add(new Pair("search.username", LocaleTool.tranView(Module.COLUMN.getCode(), "playerAccount")));
        searchKeys.add(new Pair("search.agentname", LocaleTool.tranView(Module.COLUMN.getCode(), "agentAccount")));
        searchKeys.add(new Pair("search.topagentusername", LocaleTool.tranView(Module.COLUMN.getCode(), "agentTopAccount")));
        return searchKeys;
    }

    /**
     * 统计金额
     * @param listVo
     * @return
     */
    @RequestMapping("/totalMoney")
    @ResponseBody
    public Map totalMoney(VPlayerTransactionListVo listVo){
        Map<String, Object> map = new HashMap<>(2,1f);
        Integer comp = listVo.getComp();
        if (comp != null && comp == 1) {
            int rawOffset = SessionManager.getTimeZone().getRawOffset();
            int hour = rawOffset/1000/3600;
            listVo.getSearch().setTimeZoneInterval(hour);
            Map<String, Object> resultMap = getService().queryPlayerOutLinkAmount(listVo);
            map.put("totalMoney", resultMap.get("totalmoney"));
            map.put("totalCount", resultMap.get("totalcount"));
        }else if("playerRakeback".equals(listVo.getSearch().getType())){
            map = getService().queryPlayerRakebackAmount(listVo);
        } else {
            map = getService().totalMoney(listVo);
        }
        return map;
    }

    @Override
    protected VPlayerTransactionVo doView(VPlayerTransactionVo objectVo, Model model) {
        objectVo = getService().get(objectVo);
        Integer sourceId = objectVo.getResult().getSourceId();
        String transactionType = objectVo.getResult().getTransactionType();
        VPlayerTransactionVo vo = super.doView(objectVo, model);
        SysUserVo operator = new SysUserVo();

        if (StringTool.equals(transactionType, TransactionTypeEnum.FAVORABLE.getCode())){
            PlayerFavorableVo playerFavorableVo = new PlayerFavorableVo();
            playerFavorableVo.getSearch().setId(sourceId);
            playerFavorableVo = getViewBySourceId(playerFavorableVo);
            operator.getSearch().setId(playerFavorableVo.getResult().getOperatorId());
            if (ServiceTool.sysUserService().get(operator).getResult()!=null) {
                vo.setOperator((ServiceTool.sysUserService().get(operator)).getResult().getUsername());
            }
        }

        return vo;
    }

    private <T> T getViewBySourceId(T vo){
        if (vo instanceof PlayerFavorableVo){
            vo = (T)ServiceSiteTool.playerFavorableService().get((PlayerFavorableVo)vo);
        }

        return  vo;
    }

    @Override
    protected SysExportVo buildExportData(SysExportVo vo) {
        if (vo.getResult() == null) {
            vo.setResult(new SysExport());
        }
        vo.getResult().setService(IVPlayerTransactionService.class.getName());
        if("playerRakeback".equals(vo.getExportType())){
            vo.getResult().setMethod("searchPlayerRakeback");
        }else{
            vo.getResult().setMethod("searchTransactionByCustom");
        }
        vo.getResult().setFileName(LocaleTool.tranView("export","fund_report")+"-"+ DateTool.formatDate(DateQuickPicker.getInstance().getNow(), SessionManager.getLocale(),SessionManager.getTimeZone(),"yyyyMMddHHmmss"));
        vo.getResult().setParam(VPlayerTransactionListVo.class.getName());
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
