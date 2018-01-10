package so.wwb.gamebox.mcenter.operation.controller;

import org.omg.CORBA.SystemException;
import org.soul.commons.lang.ArrayTool;
import org.soul.commons.lang.string.StringTool;
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
import java.util.Arrays;
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

    @RequestMapping("/getCount")
    public String doList(VDomainCheckResultStatisticsListVo domainChecksVo,VDomainCheckResultStatisticsForm form, BindingResult result, Model model,HttpServletRequest request){
       //dmainCheckResultStatistics.setdomainarr(domainChecksVo.getSearch().getDomain().split(","))
        DomainCheckResult dmainCheckResultStatistics=new DomainCheckResult();

        if(StringTool.isNotEmpty(domainChecksVo.getSearch().getDomain())){

            dmainCheckResultStatistics.setDomains(Arrays.asList(domainChecksVo.getSearch().getDomain().split(",")));
            dmainCheckResultStatistics.setDomain(domainChecksVo.getSearch().getDomain());
        }


        dmainCheckResultStatistics.setServerProvince(domainChecksVo.getSearch().getServerProvince());
        dmainCheckResultStatistics.setIsp(domainChecksVo.getSearch().getIsp());
        List<VDomainCheckResultStatistics> domainList = ServiceTool.vDomainCheckResultStatisticsService().getDomainCount(dmainCheckResultStatistics);

        domainChecksVo.setResult(domainList);

        model.addAttribute("command",domainChecksVo);
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

        if(StringTool.isNotEmpty(domainChecksVo.getSearch().getDomain())){

            dmainCheckResultStatistics.setDomains(Arrays.asList(domainChecksVo.getSearch().getDomain().split(",")));
            dmainCheckResultStatistics.setDomain(domainChecksVo.getSearch().getDomain());
        }

        List<VDomainCheckResultStatistics> domainList = ServiceTool.vDomainCheckResultStatisticsService().getDomainCount(dmainCheckResultStatistics);

        domainChecksVo.setResult(domainList);

        model.addAttribute("command",domainChecksVo);
        //model.addAttribute("command",domainChecksVo);
        return Domain_DETAIL_URI;
    }

    //endregion your codes 3

}