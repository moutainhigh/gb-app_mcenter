package so.wwb.gamebox.mcenter.setting.controller;


import org.soul.web.controller.NoMappingCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.company.credit.ICreditRecordService;
import so.wwb.gamebox.mcenter.setting.form.CreditRecordForm;
import so.wwb.gamebox.mcenter.setting.form.CreditRecordSearchForm;
import so.wwb.gamebox.mcenter.setting.form.VCreditRecordForm;
import so.wwb.gamebox.model.company.credit.po.CreditRecord;
import so.wwb.gamebox.model.company.credit.vo.CreditRecordListVo;
import so.wwb.gamebox.model.company.credit.vo.CreditRecordVo;
import so.wwb.gamebox.web.common.token.Token;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;


/**
 * 买分记录控制器
 *
 * @author kobe
 * @time 2017-8-10 15:52:14
 */
@Controller
//region your codes 1
@RequestMapping("/creditRecord")
public class CreditRecordController extends NoMappingCrudController<ICreditRecordService, CreditRecordListVo, CreditRecordVo, CreditRecordSearchForm, CreditRecordForm, CreditRecord, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/credit/";
        //endregion your codes 2
    }

    //region your codes 3
    @RequestMapping(value = "uploadReceipt")
    @Token(generate = true)
    public String uploadReceipt(CreditRecordVo creditRecordVo,Model model){
        if(creditRecordVo.getSearch().getId()==null){
            return getViewBasePath() + "UploadReceipt";
        }
        creditRecordVo = getService().get(creditRecordVo);
        creditRecordVo.setValidateRule(JsRuleCreator.create(VCreditRecordForm.class));
        model.addAttribute("command",creditRecordVo);
        return getViewBasePath() + "UploadReceipt";
    }

    @RequestMapping(value = "saveUploadReceipt")
    @ResponseBody
    @Token(valid = true)
    public Map saveUploadReceipt(CreditRecordVo creditRecordVo, @FormModel("result") @Valid VCreditRecordForm form, BindingResult result){
        Map resMap = new HashMap();
        if(result.hasErrors()){
            resMap.put("state",false);
            return resMap;
        }
        creditRecordVo.setProperties(CreditRecord.PROP_PATH);
        creditRecordVo = getService().updateOnly(creditRecordVo);
        resMap = getVoMessage(creditRecordVo);
        return resMap;
    }
    //endregion your codes 3

}