package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.net.ServletTool;
import org.soul.commons.query.sort.Direction;
import org.soul.model.sys.po.SysParam;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.company.sys.IDomainCheckResultService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.BossParamEnum;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.company.enums.DomainCheckResultImportStatusEnum;
import so.wwb.gamebox.model.company.enums.DomainCheckStatusEnum;
import so.wwb.gamebox.model.company.sys.po.DomainCheckResult;
import so.wwb.gamebox.model.company.sys.po.DomainCheckResultBatchLog;
import so.wwb.gamebox.model.company.sys.po.VDomainCheckResultStatistics;
import so.wwb.gamebox.model.company.sys.vo.DomainCheckResultBatchLogListVo;
import so.wwb.gamebox.model.company.sys.vo.DomainCheckResultListVo;
import so.wwb.gamebox.model.company.sys.vo.DomainCheckResultVo;
import so.wwb.gamebox.mcenter.operation.form.DomainCheckResultSearchForm;
import so.wwb.gamebox.mcenter.operation.form.DomainCheckResultForm;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.Serializable;
import java.util.*;


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
    public int hashCode() {
        return super.hashCode();
    }

    /**
     * 列表
     *
     * @param listVo
     * @param form
     * @param result
     * @param model
     * @param request
     * @param response
     * @return
     */
    @Override
    public String list(DomainCheckResultListVo listVo, @FormModel("search") @Valid DomainCheckResultSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        Integer siteId = SessionManager.getSiteId();
        listVo.getSearch().setSiteId(siteId);
        if (StringTool.isNotBlank(listVo.getSearch().getDomain())) {
            listVo.getSearch().setDomains(Arrays.asList(listVo.getSearch().getDomain().split(",")));
        }

        listVo = ServiceTool.domainCheckResultService().searchList(listVo);
        model.addAttribute("command", listVo);

        //域名类型对应的描述
        Collection<SysParam> sysParams = ParamTool.getSysParams(BossParamEnum.CONTENT_DOMAIN_TYPE_INDEX);
        Map<String, String> pageUrl = new HashMap<>();
        for (SysParam sysParam : sysParams) {
            pageUrl.put(sysParam.getParamValue(), sysParam.getRemark());
        }
        model.addAttribute("pageUrl", pageUrl);


        //状态
        Map<String, Serializable> domainStatus = DictTool.get(DictEnum.COMMON_DOMAIN_CHECK_RESULT_STATUS);
        domainStatus.remove("NORMAL" );//删掉正常状态
        model.addAttribute("domainStatus", domainStatus);
        //运营商
        Map<String, Serializable> isp = DictTool.get(DictEnum.COMMON_ISP);
        model.addAttribute("isp", isp);

        //获取综合统计信息
        getComprehensiveInfo(listVo, model, siteId);


        return getViewBasePath() + (ServletTool.isAjaxSoulRequest(request) ? "ResultPartial" : "Result");
    }


    /**
     * 获取siteId下检查时间
     *
     * @return
     */
    private Date getCheckTime() {
        DomainCheckResultBatchLogListVo batchVo = new DomainCheckResultBatchLogListVo();
        batchVo.getSearch().setSiteId(SessionManager.getSiteId());
        batchVo.getSearch().setStatus(Integer.valueOf(DomainCheckResultImportStatusEnum.SUCCESS.getCode()));
        batchVo.getPaging().setPageSize(1);
        batchVo = ServiceTool.domainCheckResultBatchLogService().search(batchVo);
        if (batchVo != null && CollectionTool.isNotEmpty(batchVo.getResult())) {
            return batchVo.getResult().get(0).getCheckTime();
        }
        return null;
    }


    /**
     * 弹窗展示状态统计
     *
     * @param listVo
     * @param form
     * @param result
     * @param model
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/showPopStatusCount")
    public String showPopStatusCount(DomainCheckResultListVo listVo, @FormModel("search") @Valid DomainCheckResultSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        Integer siteId = SessionManager.getSiteId();
        listVo.getSearch().setSiteId(siteId);
        //获取综合统计信息
        getComprehensiveInfo(listVo, model, siteId);

        return getViewBasePath() + "ShowPopStatusCount";
    }

    /**
     * 获取综合统计信息
     *
     * @param listVo
     * @param model
     * @param siteId
     */
    private void getComprehensiveInfo(DomainCheckResultListVo listVo, Model model, Integer siteId) {
        //获取siteId下检查时间
        model.addAttribute("checkTime", getCheckTime());

        //各种状态的数量
        VDomainCheckResultStatistics statusCount = ServiceTool.domainCheckResultService().getStatusCount(listVo);
        model.addAttribute("statusCount", statusCount);
    }

    //endregion your codes 3


}