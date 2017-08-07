package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.commons.query.sort.Direction;
import org.soul.commons.support._Module;
import org.soul.model.msg.notice.enums.NoticePublishMethod;
import org.soul.model.msg.notice.po.NoticeTmpl;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.report.operation.IStationBillService;
import so.wwb.gamebox.mcenter.operation.form.StationBillForm;
import so.wwb.gamebox.mcenter.operation.form.StationBillSearchForm;
import so.wwb.gamebox.mcenter.operation.form.TopagentParamForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.RebateSetFeeForm;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.CacheBase;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteI18nEnum;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.common.notice.enums.AutoNoticeEvent;
import so.wwb.gamebox.model.common.notice.enums.CometSubscribeType;
import so.wwb.gamebox.model.company.platform.vo.VContractSchemeVo;
import so.wwb.gamebox.model.company.scheme.po.ContractApi;
import so.wwb.gamebox.model.company.site.po.SiteI18n;
import so.wwb.gamebox.model.company.sys.po.SysSite;
import so.wwb.gamebox.model.company.sys.vo.SysSiteVo;
import so.wwb.gamebox.model.master.enums.BillTypeEnum;
import so.wwb.gamebox.model.report.operation.po.StationBill;
import so.wwb.gamebox.model.report.operation.po.StationBillOther;
import so.wwb.gamebox.model.report.operation.po.StationProfitLoss;
import so.wwb.gamebox.model.report.operation.vo.StationBillListVo;
import so.wwb.gamebox.model.report.operation.vo.StationBillOtherListVo;
import so.wwb.gamebox.model.report.operation.vo.StationBillVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.stationbill.controller.StationBillController;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.*;


/**
 * 站务账单表控制器
 *
 * @author eagle
 * @time 2015-9-7 19:49:30
 */
@Controller
//region your codes 1
@RequestMapping("/operation/stationbill")
public class StationBillToMCenterController extends StationBillController<IStationBillService, StationBillListVo, StationBillVo, StationBillSearchForm, StationBillForm, StationBill, Integer> {

    private static final Log LOG = LogFactory.getLog(StationBillToMCenterController.class);

    //endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/stationBill/";
        //endregion your codes 2
    }

    //region your codes 3
    private static final String OPERATION_STATION_BILL_UPDATE_AMOUNT_PAYABLE = "operation/stationBill/UpdateAmountPayable";
    private static final String OPERATION_STATION_BILL_DISTRIBUTOR_INDEX_PARTIAL = "/operation/stationBill/distributor/IndexPartial";
    private static final String OPERATION_STATION_BILL_DISTRIBUTOR_INDEX = "/operation/stationBill/distributor/Index";
    private static final String OPERATION_STATION_BILL_DISTRIBUTOR_VIEW = "/operation/stationBill/distributor/View";
    private static final String OPERATION_STATION_BILL_VIEW_CONTRACT_SCHEME = "/operation/stationBill/ViewContractScheme";

    /**
     * 站务账单列表显示
     *
     * @param listVo
     * @param form
     * @param result
     * @param model
     * @return
     */
    @Override
    protected StationBillListVo doList(StationBillListVo listVo, StationBillSearchForm form, BindingResult result, Model model) {
        listVo.getSearch().setCenterId(getSysSite().getSysUserId());
        listVo.getSearch().setMasterId(SessionManager.getSiteUserId());
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo.getSearch().setBillType(BillTypeEnum.STATION.getCode());
        listVo = getService().search(listVo);
        return listVo;
    }

    private SysSite getSysSite() {
        SysSiteVo vo = new SysSiteVo();
        vo.getSearch().setId(SessionManager.getSiteParentId());
        vo = ServiceTool.sysSiteService().get(vo);
        return vo.getResult() == null ? new SysSite() : vo.getResult();
    }

    /**ser
     * 站务账单详细页面展现
     *
     * @param objectVo
     * @param model
     * @return
     */
    @Override
    protected StationBillVo doView(StationBillVo objectVo, Model model) {

        objectVo = getService().get(objectVo);

        //获得站点名称
        SysSiteVo sysSiteVo = getSysSiteVo(objectVo);
        model.addAttribute("sysSiteVo", sysSiteVo);
        Map<String,SiteI18n> siteNameMap = Cache.getSiteI18n(SiteI18nEnum.SETTING_SITE_NAME);
        model.addAttribute("siteName",siteNameMap.get(SessionManager.getLocale().toString()).getValue());
        Map<String,SiteI18n> centerNameMap = Cache.getSiteI18n(SiteI18nEnum.SETTING_SITE_NAME,SessionManager.getSiteParentId());
        model.addAttribute("centerName",centerNameMap.get(SessionManager.getLocale().toString()).getValue());

        //包网方案
        Map<Integer, ContractApi> contractApiMap = getContractApiMap(sysSiteVo);
        model.addAttribute("contractApiMap", contractApiMap);

        //游戏盈亏项
        Map listtomap = getStationProfitLoss(objectVo);
        model.addAttribute("listtomap", listtomap);
        Map<String, List<StationProfitLoss>> apiType = getApiType(objectVo);
        model.addAttribute("objMap",apiType);

        //api 二级分类
        Map<String, SiteI18n> gameTypeFilterByLocal = getAvailableGameType(0);
        model.addAttribute("gameTypeMap", gameTypeFilterByLocal);

        //站务账单详细页其他项目
        List<StationBillOther> stationBillOthers = getStationBillOthers(objectVo);

        model.addAttribute("stationBillOtherListVo", stationBillOthers);
        model.addAttribute("objectVo", objectVo);
        return objectVo;
    }

    /**
     * 跳转到修改页面
     *
     * @param stationBillVo
     * @param model
     * @return
     */
    @RequestMapping("/toUpdateAmountPayable")
    @Token(generate = true)
    public String toUpdateAmountPayable(StationBillVo stationBillVo, Model model) {
        stationBillVo = ServiceTool.stationBillService().get(stationBillVo);
        model.addAttribute("command", stationBillVo);
        model.addAttribute("validateRule", JsRuleCreator.create(StationBillForm.class));

        return OPERATION_STATION_BILL_UPDATE_AMOUNT_PAYABLE;
    }

    /**
     * 修改应付金额
     *
     * @param stationBillVo
     * @return
     */
    @RequestMapping("/updateAmountPayable")
    @ResponseBody
    @Token(valid = true)
    public Map updateAmountPayable(StationBillVo stationBillVo) {
        stationBillVo.getResult().setOperateUserId(SessionManager.getUserId());
        stationBillVo.getResult().setOperateUserName(SessionManager.getUserName());
        stationBillVo.getResult().setLastOperateTime(SessionManager.getDate().getNow());

        stationBillVo = ServiceTool.stationBillService().updateAmount(stationBillVo);
        Map map = new HashMap();
        map.put("state", stationBillVo.isSuccess());
        if (stationBillVo.isSuccess()) {
            //修改成功后发送站内信给所属运营商
            sendSiteMsg(stationBillVo);
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, "save.success"));
        } else {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, "save.failed"));
        }
        return map;
    }

    /**
     * 总代账单列表
     * @param listVo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/generalBill")
    public String generalBill(StationBillListVo listVo,Model model,HttpServletRequest request) {

        listVo.getSearch().setCenterId(getSysSite().getSysUserId());
        listVo.getSearch().setMasterId(SessionManager.getSiteUserId());
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo.getSearch().setBillType(BillTypeEnum.TOPAGENT_STATION.getCode());
        listVo.getSearch().setTopagentName(listVo.getSearch().getTopagentName());

        Map<String, String> pageOrderMap = listVo.getQuery().getPageOrderMap();
        if (StringTool.isBlank(pageOrderMap.get("amountPayable"))) {
            listVo.getQuery().addOrder(StationBill.PROP_AMOUNT_PAYABLE, Direction.ASC);
        }

        if (listVo.getYear() != null && listVo.getMonth() != null) {
            listVo.getSearch().setBillYear(listVo.getYear());
            listVo.getSearch().setBillMonth(listVo.getMonth());
        } else {
            Calendar c = Calendar.getInstance();
            c.add(Calendar.MONTH, -1);
            model.addAttribute("year",c.get(Calendar.YEAR));
            model.addAttribute("month",c.get(Calendar.MONTH)+1);
            listVo.getSearch().setBillYear(c.get(Calendar.YEAR));
            listVo.getSearch().setBillMonth(c.get(Calendar.MONTH)+1);
            calYearAndMonth(c,model);
        }


        listVo = getService().search(listVo);
        model.addAttribute("command",listVo);

        if (ServletTool.isAjaxSoulRequest(request)) {
            return OPERATION_STATION_BILL_DISTRIBUTOR_INDEX_PARTIAL;
        } else {
            return OPERATION_STATION_BILL_DISTRIBUTOR_INDEX;
        }
    }

    /**
     * 总代账单详细页
     * @param objectVo
     * @param model
     * @return
     */
    @RequestMapping("/generalBillView")
    public String generalBillView(StationBillVo objectVo, Model model) {

        objectVo = getService().get(objectVo);

        //游戏盈亏项
        Map listtomap = getStationProfitLoss(objectVo);
        model.addAttribute("listtomap", listtomap);

        //api 二级分类
        Map<String, SiteI18n> gameTypeFilterByLocal = getAvailableGameType(0);
        model.addAttribute("gameTypeMap", gameTypeFilterByLocal);

        //分摊费用
        StationBillOtherListVo stationBillOtherListVo = getStationBillOtherListVo(objectVo);
        model.addAttribute("stationBillOtherListVo", stationBillOtherListVo);
        model.addAttribute("objectVo", objectVo);
        return OPERATION_STATION_BILL_DISTRIBUTOR_VIEW;
    }

    /**
     * 查看站长的包网方案
     * @return
     */
    @RequestMapping("/viewContractScheme")
    public String contractScheme(VContractSchemeVo objectVo,Model model) {

        objectVo.getSearch().setId(getSysSiteVo().getResult().getSiteNetSchemeId());
        objectVo.getSearch().setLocale(SessionManager.getLocale().toString());
        objectVo = ServiceTool.vContractSchemeService().viewContractScheme(objectVo);
        if(objectVo.getResult()!=null){
            objectVo.getResult().setSchemeName(CacheBase.getContractName(objectVo.getResult().getId()));
        }

        model.addAttribute("command",objectVo);
        return OPERATION_STATION_BILL_VIEW_CONTRACT_SCHEME;
    }

    /**
     * 修改应付金额发送站内信
     * @param stationBillVo
     */
    private void sendSiteMsg(StationBillVo stationBillVo) {
        SysSiteVo sysSiteVo = getSysSiteVo(SessionManager.getSiteParentId());
        NoticeVo noticeVo = NoticeVo.autoNotify(AutoNoticeEvent.MODIFY_STATION_BILL,sysSiteVo.getResult().getSysUserId());
        noticeVo._setDataSourceId(SessionManager.getSiteParentId());
        noticeVo.setSendUserId(NoticeVo.SEND_USER_ID);
        Map<NoticePublishMethod, Set<NoticeTmpl>> noticePublishMethodSetMap = ServiceTool.noticeService().fetchTmpls(noticeVo);
        noticeVo.setTmplMap(noticePublishMethodSetMap);
        stationBillVo.getSearch().setId(stationBillVo.getResult().getId());
        stationBillVo = ServiceTool.stationBillService().get(stationBillVo);
        Map<String, SiteI18n> siteNameMap = Cache.getSiteI18n(SiteI18nEnum.SETTING_SITE_NAME);
        String username = SessionManager.getMasterInfo().getUsername();

        Double amountPayable = stationBillVo.getResult().getAmountPayable();
        Double amountMoney = stationBillVo.getResult().getAmountActual();
        noticeVo.addParams(new Pair("mastername",username==null?"":"<a href='/vSiteMasterManage/view.html?id="+stationBillVo.getResult().getMasterId()+"' "+"nav-target='mainFrame'>"+username+"</a>"),
                new Pair("sitename","<a href='/site/detail/viewMaxProfit.html?search.id="+stationBillVo.getResult().getSiteId()+"' "+"nav-target='mainFrame'>"+siteNameMap.get(SessionManager.getLocale().toString()).getValue()+"</a>"),
                new Pair("billname",stationBillVo.getResult().getBillName()),
                new Pair("amountPayable",String.valueOf(CurrencyTool.formatCurrency(amountPayable != null ? amountPayable : 0d))),
                new Pair("amountMoney",String.valueOf(CurrencyTool.formatCurrency(amountMoney != null ? amountMoney : 0d))),
                new Pair("detail","<a href='/operation/stationbill/view.html?id="+stationBillVo.getResult().getId()+"' "+"nav-target='mainFrame'>查看详细</a>"));
        noticeVo._setDataSourceId(SessionManager.getSiteParentId());
        //左上角消息提醒
        noticeVo.setSubscribeType(CometSubscribeType.READ_COUNT);
        try {
            ServiceTool.noticeService().publish(noticeVo);
        } catch (Exception e) {
            LOG.warn("站内信发送异常");
        }
    }

    //endregion your codes 3

}