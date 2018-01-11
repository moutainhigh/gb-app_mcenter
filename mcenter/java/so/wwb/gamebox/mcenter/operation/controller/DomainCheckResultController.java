package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.net.ServletTool;
import org.soul.commons.query.Criteria;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.company.sys.IDomainCheckResultService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.company.enums.ResolveStatusEnum;
import so.wwb.gamebox.model.company.sys.po.DomainCheckResult;
import so.wwb.gamebox.model.company.sys.po.SysDomain;
import so.wwb.gamebox.model.company.sys.po.VDomainCheckResultStatistics;
import so.wwb.gamebox.model.company.sys.so.SysDomainSo;
import so.wwb.gamebox.model.company.sys.vo.DomainCheckResultBatchLogListVo;
import so.wwb.gamebox.model.company.sys.vo.DomainCheckResultListVo;
import so.wwb.gamebox.model.company.sys.vo.DomainCheckResultVo;
import so.wwb.gamebox.mcenter.operation.form.DomainCheckResultSearchForm;
import so.wwb.gamebox.mcenter.operation.form.DomainCheckResultForm;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.model.company.sys.vo.SysDomainListVo;
import so.wwb.gamebox.model.master.enums.PlayerStatusEnum;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.Serializable;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 控制器
 *
 * @author steffan
 * @time 2018-1-7 15:10:59
 */
@Controller
//region your codes 1
@RequestMapping("/operation/domainCheckResult")
public class DomainCheckResultController extends BaseCrudController<IDomainCheckResultService, DomainCheckResultListVo, DomainCheckResultVo, DomainCheckResultSearchForm, DomainCheckResultForm, DomainCheckResult, String> {

//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/domainCheck/";
        //endregion your codes 2
    }

    //region your codes 3


    @Override
    public String list(DomainCheckResultListVo listVo, @FormModel("search") @Valid DomainCheckResultSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        Integer siteId = SessionManager.getSiteId();
        listVo.getSearch().setSiteId(siteId);
        if (StringTool.isNotBlank(listVo.getSearch().getDomain())) {
            listVo.getSearch().setDomains(Arrays.asList(listVo.getSearch().getDomain().split(",")));
        }
//        super.list(listVo, form, result, model, request, response);
        listVo = ServiceTool.domainCheckResultService().searchList(listVo);
        model.addAttribute("command", listVo);

        //总体数量显示只有在非ajax请求才需要
        if (!ServletTool.isAjaxSoulRequest(request)) {
            //状态
            Map<String, Serializable> domainStatus = DictTool.get(DictEnum.COMMON_DOMAIN_CHECK_RESULT_STATUS);
            model.addAttribute("domainStatus", domainStatus);
            //运营商
            Map<String, Serializable> isp = DictTool.get(DictEnum.COMMON_ISP);
            model.addAttribute("isp", isp);

            //获取siteId下检查点数量
            int checkPointCount = getCheckPointCount();
            model.addAttribute("checkPointCount", checkPointCount);

            //siteId下所有域名的数量
            Long sysDomainCount = ServiceTool.domainCheckResultService().getSysDomainCountBySiteId(siteId);//this.getCustomCriteria()
            model.addAttribute("sysDomainCount", sysDomainCount);

            //各种状态的数量
            DomainCheckResult domainCheckResult = new DomainCheckResult();
            domainCheckResult.setSiteId(siteId);
            VDomainCheckResultStatistics statusCount =  ServiceTool.domainCheckResultService().getStatusCount(listVo);


            model.addAttribute("statusCount", statusCount);
        }


        return getViewBasePath() + (ServletTool.isAjaxSoulRequest(request) ? "ResultPartial" : "Result");
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