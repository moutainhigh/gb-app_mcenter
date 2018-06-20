package so.wwb.gamebox.mcenter.report.controller;

import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.net.ServletTool;
import org.soul.model.sys.po.SysParam;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.iservice.master.report.IVPlayerFundsRecordService;
import so.wwb.gamebox.mcenter.report.form.VPlayerFundsRecordForm;
import so.wwb.gamebox.mcenter.report.form.VPlayerFundsRecordSearchForm;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.master.enums.CommonStatusEnum;
import so.wwb.gamebox.model.master.report.po.VPlayerFundsRecord;
import so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordListVo;
import so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordVo;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;


/**
 * 控制器
 *
 * @author linsen
 * @time 2018-6-14 10:12:15
 */
@Controller
//region your codes 1
@RequestMapping("/report/vPlayerFundsRecordLinkPopup")
public class VPlayerFundsRecordLinkPopupController extends BaseCrudController<IVPlayerFundsRecordService, VPlayerFundsRecordListVo, VPlayerFundsRecordVo, VPlayerFundsRecordSearchForm, VPlayerFundsRecordForm, VPlayerFundsRecord, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/linkPopup/fund/";
        //endregion your codes 2
    }

    //region your codes 3

    /**
     * 玩家详细页--存款、取款、优惠跳转
     *
     * @param listVo
     * @param form
     * @param result
     * @param model
     * @return
     */
    @RequestMapping("/fundsRecord")
    public String fundsRecord(VPlayerFundsRecordListVo listVo, VPlayerFundsRecordSearchForm form, BindingResult result, Model model, HttpServletRequest request) {
        initData(model);
        //默认搜索成功订单:列表页面
        if (listVo.getSearch().getStatus() == null) {
            listVo.getSearch().setStatus(CommonStatusEnum.SUCCESS.getCode());
        }
        if (listVo.isAnalyzeNewAgent()) {
            listVo.getSearch().setOrigin("all");
        }

        listVo = ServiceSiteTool.vPlayerFundsRecordService().search(listVo);
        model.addAttribute("command", listVo);
        //根据条件汇总总金额
        listVo.setPropertyName(VPlayerFundsRecord.PROP_TRANSACTION_MONEY);
        Number sumMoney = ServiceSiteTool.vPlayerFundsRecordService().AmountSum(listVo);
        model.addAttribute("sumMoney",CurrencyTool.formatCurrency(sumMoney == null ? 0 : sumMoney));
        if (ServletTool.isAjaxSoulRequest(request)) {
            return getViewBasePath() + "IndexPartial";
        } else {
            return getViewBasePath() + "Index";
        }
    }

    /**
     * 初始化数据
     * @param model
     */
    private void initData(Model model){
        //表头的状态和资金类型列表
        model.addAttribute("dictCommonStatus", DictTool.get(DictEnum.COMMON_STATUS));
        Map<String, String> dictFundType = DictTool.get(DictEnum.COMMON_FUND_TYPE);
        model.addAttribute("dictFundType", dictFundType);
        model.addAttribute("validateRule", JsRuleCreator.create(VPlayerFundsRecordSearchForm.class));

        //易收付出款入口开启状态
        model.addAttribute("easyPaymentStatus",ParamTool.getSysParam(SiteParamEnum.EASY_PAYMENT).getParamValue());
        model.addAttribute("withdrawCkeckStatus", DictTool.get(DictEnum.WITHDRAW_CHECK_STATUS));
        //易收付出款账户开启状态
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.WITHDRAW_ACCOUNT);
        model.addAttribute("isActive", sysParam.getActive());
    }

    //endregion your codes 3

}