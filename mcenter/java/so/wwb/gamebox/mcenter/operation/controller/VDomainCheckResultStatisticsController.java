package so.wwb.gamebox.mcenter.operation.controller;


import org.soul.commons.collections.CollectionTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.ArrayTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.commons.query.enums.Operator;
import org.soul.model.sys.po.SysParam;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.company.sys.IVDomainCheckResultStatisticsService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.BossParamEnum;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.company.sys.po.DomainCheckResult;
import so.wwb.gamebox.model.company.sys.po.VDomainCheckResultStatistics;
import so.wwb.gamebox.model.company.sys.vo.DomainCheckResultBatchLogListVo;
import so.wwb.gamebox.model.company.sys.vo.DomainCheckResultListVo;
import so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsListVo;
import so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsVo;
import so.wwb.gamebox.mcenter.operation.form.VDomainCheckResultStatisticsForm;
import so.wwb.gamebox.mcenter.operation.form.VDomainCheckResultStatisticsSearchForm;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.Serializable;
import java.util.*;


/**
 * 控制器
 * 域名检测视图
 * @author lock
 * @time 2018-1-8 11:21:38
 */
@Controller
//region your codes 1
@RequestMapping("/vDomainCheckResultStatistics")
public class VDomainCheckResultStatisticsController extends BaseCrudController<IVDomainCheckResultStatisticsService, VDomainCheckResultStatisticsListVo, VDomainCheckResultStatisticsVo, VDomainCheckResultStatisticsSearchForm, VDomainCheckResultStatisticsForm, VDomainCheckResultStatistics, String> {
//endregion your codes 1
    private static final Log LOG = LogFactory.getLog(VDomainCheckResultStatisticsController.class);

    private static final String PROP_ACTIVITY_INDEX = "/operation/domainCheck/Index";

    private static final String Domain_DETAIL_URI = "/operation/domainCheck/Detail";

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/domainCheck/";
        //endregion your codes 2
    }

    //region your codes 3

    /**
     * 根据域名状态、类型 统计数据
     * */
    @RequestMapping("/getCount")
    public String doList(VDomainCheckResultStatisticsListVo statisticsListVo,DomainCheckResultListVo listVo, @FormModel("search") @Valid VDomainCheckResultStatisticsForm form, BindingResult result, Model model, HttpServletRequest request){
//        statisticsListVo.getDomainCheckResultStatistics().get
        Integer siteId = SessionManager.getSiteId();


        listVo.getSearch().setSiteId(siteId);
        //总体数量显示只有在非ajax请求才需要
        if (!ServletTool.isAjaxSoulRequest(request)) {
            //状态
            Map<String, Serializable> domainStatus = DictTool.get(DictEnum.COMMON_DOMAIN_CHECK_RESULT_STATUS);
            model.addAttribute("domainStatus", domainStatus);

            //获取综合统计信息
            getComprehensiveInfo(listVo, model, siteId);
        }

        if(StringTool.isNotBlank(statisticsListVo.getSearch().getDomain())){
            String[] domains=statisticsListVo.getSearch().getDomain().split(",");
            statisticsListVo.getSearch().setDomains(Arrays.asList(domains));
        }
        /*if(statisticsListVo.getSearch().getDomain().contains(",")){

        }*/

        if(StringTool.isNotEmpty(statisticsListVo.getSearch().getStatus()) && !"".equals(statisticsListVo.getSearch().getStatus())){
            statisticsListVo.getSearch().setStatus(statisticsListVo.getSearch().getStatus());
        }
        //域名类型对应的描述
        Collection<SysParam> sysParams = ParamTool.getSysParams(BossParamEnum.CONTENT_DOMAIN_TYPE_INDEX);
        Map<String,String> pageUrl = new HashMap<>();
        Map<String,String> domainType = new HashMap<>();
        for (SysParam sysParam : sysParams) {
            pageUrl.put(sysParam.getParamValue(),sysParam.getRemark());
            domainType.put(sysParam.getParamValue(),sysParam.getRemark());
        }
        model.addAttribute("pageUrl", pageUrl);
        model.addAttribute("domainType",domainType);

        List<VDomainCheckResultStatistics> domainList = ServiceTool.vDomainCheckResultStatisticsService().getDomainCount(statisticsListVo);

        Long domainList1=ServiceTool.vDomainCheckResultStatisticsService().searchCount(statisticsListVo);
        statisticsListVo.getPaging().setTotalCount(domainList1);
        statisticsListVo.getPaging().cal();
        statisticsListVo.setResult(domainList);
        model.addAttribute("command",statisticsListVo);
        if (ServletTool.isAjaxSoulRequest(request)) {
            return PROP_ACTIVITY_INDEX + "Partial";
        } else {
            return PROP_ACTIVITY_INDEX;
        }
    }

    /**
     *
     * 查看详情信息
     *
     * */
    @RequestMapping("/searchDetail")
    public String searchDetail(VDomainCheckResultStatisticsListVo domainChecksVo, Model model, HttpServletRequest request){

        if(StringTool.isNotEmpty(domainChecksVo.getSearch().getDomain()) &&!"".equals(domainChecksVo.getSearch().getDomain()) ){
            domainChecksVo.getSearch().setDomain(domainChecksVo.getSearch().getDomain());
        }

        List<VDomainCheckResultStatistics> domainList = ServiceTool.vDomainCheckResultStatisticsService().getDomainCount(domainChecksVo);

        domainChecksVo.setResult(domainList);
        model.addAttribute("command",domainChecksVo);
        //model.addAttribute("command",domainChecksVo);
        return Domain_DETAIL_URI;
    }

    /**
     * 获取综合统计信息
     *
     * @param listVo
     * @param model
     * @param siteId
     */
    private void getComprehensiveInfo(DomainCheckResultListVo listVo, Model model, Integer siteId) {
         //获取siteId下检查点数量
        int checkPointCount = getCheckPointCount();
        model.addAttribute("checkPointCount", checkPointCount);

        //siteId下所有域名的数量
        Long sysDomainCount = ServiceTool.domainCheckResultService().getSysDomainCountBySiteId(siteId);//this.getCustomCriteria()
        model.addAttribute("sysDomainCount", sysDomainCount);

        //各种状态的数量
        VDomainCheckResultStatistics statusCount = ServiceTool.domainCheckResultService().getStatusCount(listVo);
        model.addAttribute("statusCount", statusCount);
    }

    /**
     * 获取siteId下检查点数量
     *
     * @return
     */
    private Integer getCheckPointCount() {
        DomainCheckResultBatchLogListVo batchVo = new DomainCheckResultBatchLogListVo();
        batchVo.getSearch().setSiteId(SessionManager.getSiteId());
        batchVo.getSearch().setStatus(0);
        batchVo.getPaging().setPageSize(1);
        batchVo = ServiceTool.domainCheckResultBatchLogService().search(batchVo);
        if (batchVo != null && CollectionTool.isNotEmpty(batchVo.getResult())) {
            return batchVo.getResult().get(0).getCheckPointCount();
        }
        return 0;
    }

    //endregion your codes 3

}