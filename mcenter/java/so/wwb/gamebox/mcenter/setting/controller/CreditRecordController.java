package so.wwb.gamebox.mcenter.setting.controller;



import org.soul.commons.bean.Pair;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.net.ServletTool;
import org.soul.model.common.BaseListVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.company.credit.ICreditRecordService;
import so.wwb.gamebox.mcenter.setting.form.CreditRecordForm;
import so.wwb.gamebox.mcenter.setting.form.CreditRecordSearchForm;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.company.credit.po.CreditRecord;
import so.wwb.gamebox.model.company.credit.vo.CreditRecordListVo;
import so.wwb.gamebox.model.company.credit.vo.CreditRecordVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;


/**
 * 买分记录控制器
 *
 * @author kobe
 * @time 2017-8-10 15:52:14
 */
@Controller
//region your codes 1
@RequestMapping("/creditRecord")
public class CreditRecordController extends BaseCrudController<ICreditRecordService, CreditRecordListVo, CreditRecordVo, CreditRecordSearchForm, CreditRecordForm, CreditRecord, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/credit/";
        //endregion your codes 2
    }

    //region your codes 3
    @Override
    public String list(CreditRecordListVo listVo, @FormModel("search") @Valid CreditRecordSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        List<Pair> Status = initStatus();
        model.addAttribute("status", Status);
        return super.list(listVo, form, result, model, request, response);
    }

    private List<Pair> initStatus() {
        List<Pair> Status = new ArrayList<>();
        Status.add(new Pair("1", LocaleTool.tranDict(DictEnum.CREDIT_STATUS,"1")));
        Status.add(new Pair("2", LocaleTool.tranDict(DictEnum.CREDIT_STATUS,"2")));
        Status.add(new Pair("3", LocaleTool.tranDict(DictEnum.CREDIT_STATUS,"3")));
        return Status;
    }
    //endregion your codes 3

}