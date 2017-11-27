package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.operation.IActivityMoneyDefaultWinRecordService;
import so.wwb.gamebox.mcenter.operation.form.ActivityMoneyDefaultWinRecordForm;
import so.wwb.gamebox.mcenter.operation.form.ActivityMoneyDefaultWinRecordSearchForm;
import so.wwb.gamebox.model.master.operation.po.ActivityMoneyDefaultWinRecord;
import so.wwb.gamebox.model.master.operation.vo.ActivityMoneyDefaultWinRecordListVo;
import so.wwb.gamebox.model.master.operation.vo.ActivityMoneyDefaultWinRecordVo;


/**
 * 红包内定操作记录表控制器
 *
 * @author Administrator
 * @time 2017-5-25 15:29:27
 */
@Controller
//region your codes 1
@RequestMapping("/activityMoneyDefaultWinRecord")
public class ActivityMoneyDefaultWinRecordController extends BaseCrudController<IActivityMoneyDefaultWinRecordService, ActivityMoneyDefaultWinRecordListVo, ActivityMoneyDefaultWinRecordVo, ActivityMoneyDefaultWinRecordSearchForm, ActivityMoneyDefaultWinRecordForm, ActivityMoneyDefaultWinRecord, Integer> {
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