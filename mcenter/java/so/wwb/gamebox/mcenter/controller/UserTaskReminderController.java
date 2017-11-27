package so.wwb.gamebox.mcenter.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.tasknotify.IUserTaskReminderService;
import so.wwb.gamebox.mcenter.form.UserTaskReminderForm;
import so.wwb.gamebox.mcenter.form.UserTaskReminderSearchForm;
import so.wwb.gamebox.model.master.content.vo.WarningContentVo;
import so.wwb.gamebox.model.master.player.vo.PlayerRankVo;
import so.wwb.gamebox.model.master.player.vo.VPayRankVo;
import so.wwb.gamebox.model.master.tasknotify.po.UserTaskReminder;
import so.wwb.gamebox.model.master.tasknotify.vo.UserTaskReminderListVo;
import so.wwb.gamebox.model.master.tasknotify.vo.UserTaskReminderVo;

import java.util.Map;


/**
 * 控制器
 * <p/>
 * Created by ke using soul-code-generator on 2015-6-18 14:37:12
 */
@Controller
@RequestMapping("/userTaskReminder")
public class UserTaskReminderController extends BaseCrudController<IUserTaskReminderService, UserTaskReminderListVo, UserTaskReminderVo, UserTaskReminderSearchForm, UserTaskReminderForm, UserTaskReminder, Integer> {

    @Override
    protected String getViewBasePath() {
        return "/boss/";
    }

//    @RequestMapping({"/getTaskJson"})
//    public String fetchRootMenus(UserTaskReminderListVo listVo) {
//        this.getService().unResdTask(listVo);
//        return  "";
//    }

    //region your codes
//    @RequestMapping({"/payDialogOrange"})
//    public String payDialogOrange(Model model,Integer payId,Long updateTime,String warningVal,Integer taskId){
//        model.addAttribute("payName", fetchPayAccount(payId).getPayName());
//        model.addAttribute("payId", payId);
//        model.addAttribute("updateTime", new Date(updateTime));
//        model.addAttribute("warningVal", warningVal);
//        model.addAttribute("taskId",taskId);
//        return "content/payaccount/payTask/payDialogOrange";
//    }
//    @RequestMapping({"/payDialogRed"})
//    public String payDialogRed(Model model,Integer payId,Long updateTime,String warningVal,Integer taskId){
//
//        model.addAttribute("payName", fetchPayAccount(payId).getPayName());
//        model.addAttribute("payId",payId);
//        model.addAttribute("updateTime", new Date(updateTime));
//        model.addAttribute("warningVal", warningVal);
//        model.addAttribute("taskId",taskId);
//        return "content/payaccount/payTask/payDialogRed";
//    }
//    //查询账户信息
//    public PayAccount fetchPayAccount(Integer accountId){
//        if(accountId==null){
//            return new PayAccount();
//        }
//        PayAccountVo payAccountVo = new PayAccountVo();
//        payAccountVo.getSearch().setId(accountId);
//        payAccountVo = ServiceTool.payAccountService().get(payAccountVo);
//
//        return payAccountVo.getResult();
//    }

//    @RequestMapping({"/profitOrange"})
//    public String profitOrange(Model model,Integer siteId){
//        Cache.getSysSiteUser();
//        return "";
//    }
    @RequestMapping({"/rankInadequate"})
    public String rankInadequate(Model model, WarningContentVo vo, PlayerRankVo rankVo){
        rankVo = ServiceTool.playerRankService().get(rankVo);
        vo.setRankName(rankVo.getResult().getRankName());
        model.addAttribute("command", vo);
        return "content/payaccount/payTask/rankInadequate";
    }

    @RequestMapping({"/rankInadequateDialog"})
    public String rankInadequateDialog(Model model, WarningContentVo vo){
        Map map = ServiceTool.vPayRankService().rankInadequate(new VPayRankVo());
        vo.setRankName(map.get(vo.getRankName()).toString());
        model.addAttribute("command", vo);
        return "content/payaccount/payTask/rankInadequate";
    }
//    private IVPayRankService getPayRankService() {
//        return ServiceTool.getService(IVPayRankService.class);
//    }

//    /**
//     * 查询账户预警设置的提醒类型
//     * @param payTaskType：提醒类型（任务栏，任务栏并弹窗）
//     * @param payType：账户类型（公司，在线）
//     * @return
//     */
//    @RequestMapping({"/getPayTaskWarningType"})
//    @ResponseBody
//    private String getPayTaskWarningType(String payType,String payTaskType){
//        SysParam sysParam = new SysParam();
//        //公司入款
//        if(RechargeTypeParentEnum.COMPANY_DEPOSIT.getCode().equals(payType)){
//            if("orange".equals(payTaskType)){
//                sysParam= ParamTool.getSysParam(SiteParamEnum.CONTENT_DEPOSIT_ACCOUNT_WARNING_ORANGE_TYPE);
//            }
//        }else if(RechargeTypeParentEnum.COMPANY_DEPOSIT.getCode().equals(payType)){
//            if("orange".equals(payTaskType)){
//                sysParam=ParamTool.getSysParam(SiteParamEnum.CONTENT_DEPOSIT_ACCOUNT_WARNING_ORANGE_TYPE);
//            }
//        }
//        return sysParam!=null?sysParam.getParamValue():"";
//    }

    //endregion your codes

}