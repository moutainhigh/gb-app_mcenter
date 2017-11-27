package so.wwb.gamebox.mcenter.fund.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.fund.ISiteStationBillService;
import so.wwb.gamebox.mcenter.fund.form.SiteStationBillForm;
import so.wwb.gamebox.mcenter.fund.form.SiteStationBillSearchForm;
import so.wwb.gamebox.model.master.fund.po.SiteStationBill;
import so.wwb.gamebox.model.master.fund.vo.SiteStationBillListVo;
import so.wwb.gamebox.model.master.fund.vo.SiteStationBillVo;


/**
 * 站点结算账单控制器
 *
 * @author Administrator
 * @time 2017-3-16 20:19:42
 */
@Controller
//region your codes 1
@RequestMapping("/siteStationBill")
public class SiteStationBillController extends BaseCrudController<ISiteStationBillService, SiteStationBillListVo, SiteStationBillVo, SiteStationBillSearchForm, SiteStationBillForm, SiteStationBill, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/fund/";
        //endregion your codes 2
    }

    //region your codes 3

    //endregion your codes 3

}