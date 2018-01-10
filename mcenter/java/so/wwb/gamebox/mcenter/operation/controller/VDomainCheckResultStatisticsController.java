package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.commons.net.ServletTool;
import org.soul.commons.query.Criteria;
import org.soul.web.controller.BaseCrudController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.company.sys.IVDomainCheckResultStatisticsService;
import so.wwb.gamebox.model.company.sys.po.DomainCheckResult;
import so.wwb.gamebox.model.company.sys.po.VDomainCheckResultStatistics;
import so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsListVo;
import so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsVo;
import so.wwb.gamebox.mcenter.operation.form.VDomainCheckResultStatisticsForm;
import so.wwb.gamebox.mcenter.operation.form.VDomainCheckResultStatisticsSearchForm;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


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

    private static final String PROP_ACTIVITY_INDEX = "/operation/domainCheck/Index";

    private static final String Domain_DETAIL_URI = "/operation/domainCheck/Detail";

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/domainCheck/";
        //endregion your codes 2
    }

    //region your codes 3
   /* @Override
    protected  doList(HelpDocumentListVo listVo, HelpDocumentSearchForm form, BindingResult result, Model model) {
        listVo = getService().search(listVo);

        return super.doList(listVo, form, result, model);
    }*/
    @RequestMapping("/getCount")
    public String doList(VDomainCheckResultStatisticsVo domainChecksVo,VDomainCheckResultStatisticsForm form, BindingResult result, Model model,HttpServletRequest request){
        DomainCheckResult dmainCheckResultStatistics=new DomainCheckResult();
        dmainCheckResultStatistics.setDomain(domainChecksVo.getSearch().getDomain());
        dmainCheckResultStatistics.setArea(domainChecksVo.getSearch().getArea());
        dmainCheckResultStatistics.setIsp(domainChecksVo.getSearch().getIsp());
        List<VDomainCheckResultStatistics> domainList = ServiceTool.vDomainCheckResultStatisticsService().getDomainCount(dmainCheckResultStatistics);
         VDomainCheckResultStatisticsListVo listVo=new VDomainCheckResultStatisticsListVo();
        listVo.setResult(domainList);
        model.addAttribute("command",listVo);
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
        DomainCheckResult dmainCheckResultStatistics=new DomainCheckResult();
        dmainCheckResultStatistics.setDomain(domainChecksVo.getSearch().getDomain());
        dmainCheckResultStatistics.setArea(domainChecksVo.getSearch().getArea());
        dmainCheckResultStatistics.setIsp(domainChecksVo.getSearch().getIsp());
        List<VDomainCheckResultStatistics> domainList = ServiceTool.vDomainCheckResultStatisticsService().getDomainCount(dmainCheckResultStatistics);
        VDomainCheckResultStatisticsListVo listVo=new VDomainCheckResultStatisticsListVo();
        listVo.setResult(domainList);
        model.addAttribute("command",listVo);

        return Domain_DETAIL_URI;
    }

    //endregion your codes 3

}