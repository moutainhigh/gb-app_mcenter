package so.wwb.gamebox.mcenter.operation.hall.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.operation.IActivityMoneyAwardsRulesService;
import so.wwb.gamebox.mcenter.operation.form.ActivityMoneyAwardsRulesForm;
import so.wwb.gamebox.mcenter.operation.form.ActivityMoneyAwardsRulesSearchForm;
import so.wwb.gamebox.model.master.operation.po.ActivityMoneyAwardsRules;
import so.wwb.gamebox.model.master.operation.vo.ActivityMoneyAwardsRulesListVo;
import so.wwb.gamebox.model.master.operation.vo.ActivityMoneyAwardsRulesVo;

import java.util.List;


/**
 * 优惠活动奖项设置控制器
 *
 * @author Administrator
 * @time 2017-3-24 14:10:41
 */
@Controller
//region your codes 1
@RequestMapping("/activityHall/activityMoneyAwardsRules")
public class HallActivityMoneyAwardsRulesController extends BaseCrudController<IActivityMoneyAwardsRulesService, ActivityMoneyAwardsRulesListVo, ActivityMoneyAwardsRulesVo, ActivityMoneyAwardsRulesSearchForm, ActivityMoneyAwardsRulesForm, ActivityMoneyAwardsRules, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/activityHall";
        //endregion your codes 2
    }

    //region your codes 3
    @RequestMapping(value = "/queryAwardRemainCount")
    @ResponseBody
    public List<ActivityMoneyAwardsRules> queryAwardRemainCount(ActivityMoneyAwardsRulesListVo listVo){

        Integer id = listVo.getSearch().getActivityMessageId();
        if(id==null){
            return null;
        }
        listVo = getService().queryAwardRemainCount(listVo);

        return listVo.getResult();

    }
    //endregion your codes 3

}