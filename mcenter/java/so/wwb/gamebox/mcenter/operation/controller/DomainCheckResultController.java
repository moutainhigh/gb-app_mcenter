package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.commons.dict.DictTool;
import org.soul.commons.net.ServletTool;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.company.sys.IDomainCheckResultService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.company.sys.po.DomainCheckResult;
import so.wwb.gamebox.model.company.sys.vo.DomainCheckResultListVo;
import so.wwb.gamebox.model.company.sys.vo.DomainCheckResultVo;
import so.wwb.gamebox.mcenter.operation.form.DomainCheckResultSearchForm;
import so.wwb.gamebox.mcenter.operation.form.DomainCheckResultForm;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.model.master.enums.PlayerStatusEnum;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.Serializable;
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
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        super.list(listVo, form, result, model, request, response);
//        ServiceTool.domainCheckResultService().

        //状态
        Map<String, Serializable> domainStatus = DictTool.get(DictEnum.COMMON_DOMAIN_CHECK_RESULT_STATUS);
        model.addAttribute("domainStatus", domainStatus);
        //运营商
        Map<String, Serializable> isp = DictTool.get(DictEnum.COMMON_ISP);
        model.addAttribute("isp", isp);


        //ServiceTool.vDomainCheckResultStatisticsService().getDomainCount(new DomainCheckResult());


        return getViewBasePath() + (ServletTool.isAjaxSoulRequest(request) ? "ResultPartial" : "Result");
    }

    //endregion your codes 3


}