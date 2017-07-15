package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.web.controller.BaseCrudController;
import so.wwb.gamebox.iservice.master.operation.IActivityMoneyPlayRecordService;
import so.wwb.gamebox.model.master.operation.po.ActivityMoneyPlayRecord;
import so.wwb.gamebox.model.master.operation.vo.ActivityMoneyPlayRecordListVo;
import so.wwb.gamebox.model.master.operation.vo.ActivityMoneyPlayRecordVo;
import so.wwb.gamebox.mcenter.operation.form.ActivityMoneyPlayRecordSearchForm;
import so.wwb.gamebox.mcenter.operation.form.ActivityMoneyPlayRecordForm;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * 红包抽奖记录表控制器
 *
 * @author younger
 * @time 2017-5-31 20:01:37
 */
@Controller
//region your codes 1
@RequestMapping("/activityMoneyPlayRecord")
public class ActivityMoneyPlayRecordController extends BaseCrudController<IActivityMoneyPlayRecordService, ActivityMoneyPlayRecordListVo, ActivityMoneyPlayRecordVo, ActivityMoneyPlayRecordSearchForm, ActivityMoneyPlayRecordForm, ActivityMoneyPlayRecord, Integer> {
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