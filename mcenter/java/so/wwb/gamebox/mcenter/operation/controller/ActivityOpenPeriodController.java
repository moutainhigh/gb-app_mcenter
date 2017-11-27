package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.operation.IActivityOpenPeriodService;
import so.wwb.gamebox.mcenter.operation.form.ActivityOpenPeriodForm;
import so.wwb.gamebox.mcenter.operation.form.ActivityOpenPeriodSearchForm;
import so.wwb.gamebox.model.master.operation.po.ActivityOpenPeriod;
import so.wwb.gamebox.model.master.operation.vo.ActivityOpenPeriodListVo;
import so.wwb.gamebox.model.master.operation.vo.ActivityOpenPeriodVo;


/**
 * 优惠时间段控制器
 *
 * @author Administrator
 * @time 2017-3-24 14:13:15
 */
@Controller
//region your codes 1
@RequestMapping("/activityOpenPeriod")
public class ActivityOpenPeriodController extends BaseCrudController<IActivityOpenPeriodService, ActivityOpenPeriodListVo, ActivityOpenPeriodVo, ActivityOpenPeriodSearchForm, ActivityOpenPeriodForm, ActivityOpenPeriod, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/";
        //endregion your codes 2
    }

    //region your codes 3

    //endregion your codes 3

}