package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.commons.dict.DictTool;
import org.soul.commons.query.sort.Direction;
import org.soul.model.sys.po.SysDict;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.operation.IVActivityMonitorService;
import so.wwb.gamebox.mcenter.operation.form.VActivityMonitorForm;
import so.wwb.gamebox.mcenter.operation.form.VActivityMonitorSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.TerminalEnum;
import so.wwb.gamebox.model.master.operation.po.VActivityMonitor;
import so.wwb.gamebox.model.master.operation.vo.VActivityMonitorListVo;
import so.wwb.gamebox.model.master.operation.vo.VActivityMonitorVo;

import java.util.Map;


/**
 * 活动效果监控视图控制器
 *
 * @author steffan
 * @time 2018-3-18 11:13:42
 */
@Controller
//region your codes 1
@RequestMapping("/vActivityMonitor")
public class VActivityMonitorController extends BaseCrudController<IVActivityMonitorService, VActivityMonitorListVo, VActivityMonitorVo, VActivityMonitorSearchForm, VActivityMonitorForm, VActivityMonitor, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/activityHall/monitor/";
        //endregion your codes 2
    }

    //region your codes 3

    @Override
    protected VActivityMonitorListVo doList(VActivityMonitorListVo listVo, VActivityMonitorSearchForm form, BindingResult result, Model model) {

        VActivityMessageHallController.setActivitySelectBtnDicts(model);
        listVo.getSearch().setActivityVersion(SessionManager.getLocale().toString());
        listVo.getSearch().setActivityTerminalType(TerminalEnum.PC.getCode());
        //状态列表

        //审核状态字典
        Map<String, SysDict> checkStatusDicts = DictTool.get(DictEnum.ACTIVITY_APPLY_CHECK_STATUS);
        model.addAttribute("checkStatusDicts",checkStatusDicts);
        listVo.getQuery().addOrder(VActivityMonitor.PROP_APPLY_TIME, Direction.DESC);
        return super.doList(listVo, form, result, model);
    }


    //endregion your codes 3

}