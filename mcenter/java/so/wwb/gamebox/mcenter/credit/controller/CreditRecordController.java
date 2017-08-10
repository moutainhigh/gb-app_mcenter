package so.wwb.gamebox.mcenter.credit.controller;

import org.soul.web.controller.BaseCrudController;
import so.wwb.gamebox.iservice.credit.ICreditRecordService;
import so.wwb.gamebox.model.credit.po.CreditRecord;
import so.wwb.gamebox.model.credit.vo.CreditRecordListVo;
import so.wwb.gamebox.model.credit.vo.CreditRecordVo;
import so.wwb.gamebox.credit.form.CreditRecordSearchForm;
import so.wwb.gamebox.credit.form.CreditRecordForm;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


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
        return "/credit/";
        //endregion your codes 2
    }

    //region your codes 3

    //endregion your codes 3

}