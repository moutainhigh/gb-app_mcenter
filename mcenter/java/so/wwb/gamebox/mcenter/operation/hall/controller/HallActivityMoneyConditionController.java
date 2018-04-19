package so.wwb.gamebox.mcenter.operation.hall.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.operation.IActivityMoneyConditionService;
import so.wwb.gamebox.mcenter.operation.form.ActivityMoneyConditionForm;
import so.wwb.gamebox.mcenter.operation.form.ActivityMoneyConditionSearchForm;
import so.wwb.gamebox.model.master.operation.po.ActivityMoneyCondition;
import so.wwb.gamebox.model.master.operation.vo.ActivityMoneyConditionListVo;
import so.wwb.gamebox.model.master.operation.vo.ActivityMoneyConditionVo;


/**
 * 优惠时间段控制器
 *
 * @author Administrator
 * @time 2017-3-24 14:12:43
 */
@Controller
//region your codes 1
@RequestMapping("/activityHall/activityMoneyCondition")
public class HallActivityMoneyConditionController extends BaseCrudController<IActivityMoneyConditionService, ActivityMoneyConditionListVo, ActivityMoneyConditionVo, ActivityMoneyConditionSearchForm, ActivityMoneyConditionForm, ActivityMoneyCondition, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/activityHall";
        //endregion your codes 2
    }

    //region your codes 3

    //endregion your codes 3

}