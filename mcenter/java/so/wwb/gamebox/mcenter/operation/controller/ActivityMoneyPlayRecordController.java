package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.commons.net.ServletTool;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceActivityTool;
import so.wwb.gamebox.iservice.master.operation.IActivityMoneyPlayRecordService;
import so.wwb.gamebox.mcenter.operation.form.ActivityMoneyPlayRecordForm;
import so.wwb.gamebox.mcenter.operation.form.ActivityMoneyPlayRecordSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.master.operation.po.ActivityMoneyPlayRecord;
import so.wwb.gamebox.model.master.operation.po.VActivityMessage;
import so.wwb.gamebox.model.master.operation.vo.ActivityMoneyPlayRecordListVo;
import so.wwb.gamebox.model.master.operation.vo.ActivityMoneyPlayRecordVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;


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
        return "/operation/activityMoneyPlayRecord/";
        //endregion your codes 2
    }

    //region your codes 3
    private static final String INDEX = "/operation/activityMoneyPlayRecord/Index";

    private static final String INDEXPARTIAL = "/operation/activityMoneyPlayRecord/IndexPartial";

    private static final String INDEXPARTIALTIME = "/operation/activityMoneyPlayRecord/IndexPartialTime";


    @Override
    public String list(ActivityMoneyPlayRecordListVo listVo, @FormModel("search") @Valid ActivityMoneyPlayRecordSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        Integer activityMessageId = listVo.getSearch().getActivityMessageId();
        VActivityMessage vActivityMessage = new VActivityMessage();
        listVo.setActivityMessage(vActivityMessage);
        listVo.getActivityMessage().setActivityVersion(SessionManager.getLocale().toString());//查询活动需要设定语言
        listVo = ServiceActivityTool.activityMoneyPlayRecordService().statisticsActivityMoneyPlayRecord(listVo);
        model.addAttribute("command", listVo);
        //ServletTool.isAjaxSoulRequest(request) ? OPERATION_REBATE_VIEW + "Partial" : OPERATION_REBATE_VIEW;
        return ServletTool.isAjaxSoulRequest(request) ? INDEXPARTIAL  : INDEX;
    }

    @RequestMapping("/getRecordListByPlayer")
    public String getRecordListByPlayer(ActivityMoneyPlayRecordListVo listVo, @FormModel("search") @Valid ActivityMoneyPlayRecordSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        Integer activityMessageId = listVo.getSearch().getActivityMessageId();
        VActivityMessage vActivityMessage = new VActivityMessage();
        listVo.setActivityMessage(vActivityMessage);
        listVo.getActivityMessage().setActivityVersion(SessionManager.getLocale().toString());//查询活动需要设定语言
        listVo = ServiceActivityTool.activityMoneyPlayRecordService().getRecordListByPlayer(listVo);
        model.addAttribute("command", listVo);
        //ServletTool.isAjaxSoulRequest(request) ? OPERATION_REBATE_VIEW + "Partial" : OPERATION_REBATE_VIEW;
        return ServletTool.isAjaxSoulRequest(request) ? INDEXPARTIAL  : INDEX;
    }

    @RequestMapping("/statisticsRecordListByTime")
    public String statisticsRecordListByTime(ActivityMoneyPlayRecordListVo listVo, @FormModel("search") @Valid ActivityMoneyPlayRecordSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        Integer activityMessageId = listVo.getSearch().getActivityMessageId();
        VActivityMessage vActivityMessage = new VActivityMessage();
        listVo.setActivityMessage(vActivityMessage);
        listVo.getActivityMessage().setActivityVersion(SessionManager.getLocale().toString());//查询活动需要设定语言
        listVo = ServiceActivityTool.activityMoneyPlayRecordService().statisticsRecordListByTime(listVo);
        model.addAttribute("command", listVo);
        //ServletTool.isAjaxSoulRequest(request) ? OPERATION_REBATE_VIEW + "Partial" : OPERATION_REBATE_VIEW;
        return ServletTool.isAjaxSoulRequest(request) ? INDEXPARTIALTIME  : INDEX;
    }



    //endregion your codes 3

}