package so.wwb.gamebox.mcenter.fee.controller;

import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.fee.IRechargeFeeSchemaService;
import so.wwb.gamebox.mcenter.fee.form.RechargeFeeSchemaForm;
import so.wwb.gamebox.mcenter.fee.form.RechargeFeeSchemaSearchForm;
import so.wwb.gamebox.model.master.fee.po.RechargeFeeSchema;
import so.wwb.gamebox.model.master.fee.vo.RechargeFeeSchemaListVo;
import so.wwb.gamebox.model.master.fee.vo.RechargeFeeSchemaVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.Map;

/**
 * 存款手续费方案表
 * @author martin
 * @time 2018-9-2 17:59:50
 */
@Controller
@RequestMapping("/rechargeFeeSchema")
public class RechargeFeeSchemaController extends BaseCrudController<IRechargeFeeSchemaService,
        RechargeFeeSchemaListVo, RechargeFeeSchemaVo, RechargeFeeSchemaSearchForm, RechargeFeeSchemaForm,
        RechargeFeeSchema, Integer> {

    @Override
    protected String getViewBasePath() {
        return "/operation/fee/";
    }


    @Override
    public String list(RechargeFeeSchemaListVo listVo, @FormModel("search") @Valid RechargeFeeSchemaSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        return super.list(listVo, form, result, model, request, response);
    }

    @Override
    public String create(RechargeFeeSchemaVo objectVo, Model model, HttpServletRequest request, HttpServletResponse response) {
        return super.create(objectVo, model, request, response);
    }

    @Override
    public Map persist(RechargeFeeSchemaVo objectVo, @FormModel("result") @Valid RechargeFeeSchemaForm form, BindingResult bindingResult) {

        //页面数据转换
        RechargeFeeSchema fee = objectVo.getResult();
        //收取
        String feeType = fee.getFeeType() == null ? "1" : fee.getFeeType();
        if ("1".equals(feeType)) {
            fee.setFeeMoney(objectVo.getPercentageAmount());
        } else {
            fee.setFeeMoney(objectVo.getFixedAmount());
        }

        //返还
        String returnType = fee.getReturnType() == null ? "1" : fee.getReturnType();
        if ("1".equals(returnType)) {
            fee.setReturnMoney(objectVo.getReturnPercentageAmount());
        } else {
            fee.setReturnMoney(objectVo.getReturnFixedAmount());
        }

        return super.persist(objectVo, form, bindingResult);
    }
}