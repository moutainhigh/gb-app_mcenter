package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.commons.dict.DictTool;
import org.soul.commons.query.sort.Direction;
import org.soul.web.controller.NoMappingCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.company.credit.IVCreditRecordService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.VCreditRecordForm;
import so.wwb.gamebox.mcenter.setting.form.VCreditRecordSearchForm;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.company.credit.po.VCreditRecord;
import so.wwb.gamebox.model.company.credit.vo.VCreditRecordListVo;
import so.wwb.gamebox.model.company.credit.vo.VCreditRecordVo;
import so.wwb.gamebox.model.company.enums.CreditAccountPayTypeEnum;
import so.wwb.gamebox.model.company.enums.CreditRecordStatusEnum;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.Map;


/**
 * 充值记录查询视图控制器
 *
 * @author leo
 * @time 2017-11-15 20:19:42
 */
@Controller
//region your codes 1
@RequestMapping("/vCreditRecord")
public class VCreditRecordController extends NoMappingCrudController<IVCreditRecordService, VCreditRecordListVo, VCreditRecordVo, VCreditRecordSearchForm, VCreditRecordForm, VCreditRecord, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/credit/";
        //endregion your codes 2
    }

    //region your codes 3
    @RequestMapping({"/list"})
    public String searchCreditRecord(VCreditRecordListVo listVo, @FormModel("search") @Valid VCreditRecordSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        return list(listVo, form, result, model, request, response);
    }

    @Override
    public String list(VCreditRecordListVo listVo, @FormModel("search") @Valid VCreditRecordSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        Map Status = DictTool.get(DictEnum.CREDIT_STATUS);
        Map type = DictTool.get(DictEnum.PAY_TYPE);
        type.remove(CreditAccountPayTypeEnum.AUTHORIZE_STATUS.getCode());
        model.addAttribute("payType",type);
        model.addAttribute("status", Status);
        listVo.getQuery().addOrder(VCreditRecord.PROP_CREATE_TIME, Direction.DESC);
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        return super.list(listVo, form, result, model, request, response);
    }

    @Override
    protected VCreditRecordListVo doList(VCreditRecordListVo listVo, VCreditRecordSearchForm form, BindingResult result, Model model) {
        listVo.getSearch().setStatusArr(new String[]{CreditRecordStatusEnum.DEAL.getCode(),
                CreditRecordStatusEnum.SUCCESS.getCode(),CreditRecordStatusEnum.FAIL.getCode()});
        String[] creditPayType = new String[]{CreditAccountPayTypeEnum.CASH_PLEDGE.getCode(),
                CreditAccountPayTypeEnum.CHECKOUT.getCode(), CreditAccountPayTypeEnum.ARTIFICIAL_PLEDGE.getCode()};
        listVo.getSearch().setRecordPayType(creditPayType);
        listVo = getService().searchRecordFromMcenter(listVo);
        return listVo;
    }

    //endregion your codes 3

}