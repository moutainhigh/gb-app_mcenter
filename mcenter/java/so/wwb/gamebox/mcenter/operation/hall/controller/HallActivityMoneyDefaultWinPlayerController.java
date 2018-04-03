package so.wwb.gamebox.mcenter.operation.hall.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.operation.IActivityMoneyDefaultWinPlayerService;
import so.wwb.gamebox.mcenter.operation.form.ActivityMoneyDefaultWinPlayerForm;
import so.wwb.gamebox.mcenter.operation.form.ActivityMoneyDefaultWinPlayerSearchForm;
import so.wwb.gamebox.model.master.operation.po.ActivityMoneyDefaultWinPlayer;
import so.wwb.gamebox.model.master.operation.vo.ActivityMoneyDefaultWinPlayerListVo;
import so.wwb.gamebox.model.master.operation.vo.ActivityMoneyDefaultWinPlayerVo;


/**
 * 红包内定玩家表控制器
 *
 * @author Administrator
 * @time 2017-3-29 13:53:53
 */
@Controller
//region your codes 1
@RequestMapping("/activityHall/activityMoneyDefaultWinPlayer")
public class HallActivityMoneyDefaultWinPlayerController extends BaseCrudController<IActivityMoneyDefaultWinPlayerService, ActivityMoneyDefaultWinPlayerListVo, ActivityMoneyDefaultWinPlayerVo, ActivityMoneyDefaultWinPlayerSearchForm, ActivityMoneyDefaultWinPlayerForm, ActivityMoneyDefaultWinPlayer, Integer> {
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