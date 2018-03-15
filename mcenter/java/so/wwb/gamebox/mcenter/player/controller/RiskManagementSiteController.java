package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.dict.DictTool;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.company.risk.IRiskManagementCheckService;
import so.wwb.gamebox.mcenter.player.form.RiskManagementCheckForm;
import so.wwb.gamebox.mcenter.player.form.RiskManagementCheckSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.company.risk.po.RiskManagementCheck;
import so.wwb.gamebox.model.company.risk.vo.RiskManagementCheckListVo;
import so.wwb.gamebox.model.company.risk.vo.RiskManagementCheckVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;


/**
 * 风控审核表控制器
 *
 * @author steffan
 * @time 2018-2-8 14:37:57
 */
@Controller
//region your codes 1
@RequestMapping("/riskManagementSite")
public class RiskManagementSiteController extends BaseCrudController<IRiskManagementCheckService, RiskManagementCheckListVo, RiskManagementCheckVo, RiskManagementCheckSearchForm, RiskManagementCheckForm, RiskManagementCheck, Integer> {
//endregion your codes 1
    private static final String EDIT_RISK_LABEL = "/player/risk/Index";
    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/player/risk/";
        //endregion your codes 2
    }

    //region your codes 3


    @Override
    public String list(RiskManagementCheckListVo listVo, @FormModel("search") @Valid RiskManagementCheckSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        //只能查看自己站点的数据
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        //获得字典中的风控标识列表
        listVo.setRiskDicts(DictTool.get(DictEnum.PLAYER_RISK_DATA_TYPE));
        return super.list(listVo, form, result, model, request, response);
    }

    //endregion your codes 3

}