package so.wwb.gamebox.mcenter.content.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.content.IPayWarningService;
import so.wwb.gamebox.mcenter.content.form.PayWarningForm;
import so.wwb.gamebox.mcenter.content.form.PayWarningSearchForm;
import so.wwb.gamebox.model.master.content.po.PayWarning;
import so.wwb.gamebox.model.master.content.vo.PayWarningListVo;
import so.wwb.gamebox.model.master.content.vo.PayWarningVo;


/**
 * 控制器
 *
 * @author mark
 * @time 2016-3-15 11:51:46
 */
@Controller
//region your codes 1
@RequestMapping("/payWarning")
public class PayWarningController extends BaseCrudController<IPayWarningService, PayWarningListVo, PayWarningVo, PayWarningSearchForm, PayWarningForm, PayWarning, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/";
        //endregion your codes 2
    }

    //region your codes 3

    @RequestMapping("/warningList")
    protected String warningList(PayWarningListVo listVo, PayWarningSearchForm form, BindingResult result, Model model) {
        listVo=super.doList(listVo, form, result, model);
        model.addAttribute("command",listVo);
        return "/content/payaccount/WarningSettings";
    }

    //endregion your codes 3

}