package so.wwb.gamebox.mcenter.analyze.daily.controller;

import com.alibaba.fastjson.JSON;
import org.soul.commons.data.json.JsonTool;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.model.site.report.po.RealtimeProfile;
import so.wwb.gamebox.model.site.report.vo.OperationSummaryVo;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileListVo;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileVo;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 站点日常数据Controller
 * @author martin
 * @time 18-4-12
 */
@Controller
@RequestMapping("/daily")
public class SiteDailyController {

    private static final String OPERATION_SUMMARY = "/daily/OperationSummary";

    private static final String REAL_TIME_SUMMARY = "/daily/RealTimeSummary";

    private static final String ACTIVE_PLAYER = "/daily/ActivePlayer";

    private static final String NEW_ADDED_PLAYER = "/daily/NewAddedPlayer";

    private static final String PLAYER_RETAIN = "/daily/PlayerRetain";

    /**
     * 运营统计
     * @return
     */
    @RequestMapping("/operationSummary")
    public String operationSummary(HttpServletRequest request, Model model) {
        OperationSummaryVo o = new OperationSummaryVo();
        o = ServiceSiteTool.operationSummaryService().getOperationSummaryData(o);
        model.addAttribute("lastDifferenceData", JSON.toJSONString(o.getEntities()));
        return OPERATION_SUMMARY;
    }

    /**
     * 实时总览
     * @return
     */
    @RequestMapping("/realTimeSummary")
    public String realTimeSummaryData(HttpServletRequest request, Model model) {
        List<RealtimeProfile> profileList = new ArrayList();
        Date date = new Date();
        for (int i = 0; i <= 23; i++) {
            RealtimeProfile realtimeProfile = new RealtimeProfile();
            realtimeProfile.setCreateTime(date);
            realtimeProfile.setVisitorH5(5 + i);
            realtimeProfile.setVisitorPc(8 + i);
            realtimeProfile.setActiveH5(1 + i);
            realtimeProfile.setActiveAndroid(3 + i);
            realtimeProfile.setActiveIos(40 - i);
            realtimeProfile.setActivePc(5 + i);
            realtimeProfile.setActivePhone(35 - i);
            realtimeProfile.setDepositAndroid(1.23 + i);
            realtimeProfile.setDepositH5(35.98 -  i);
            realtimeProfile.setDepositIos(3.02 +  i);
            realtimeProfile.setDepositPc(Double.valueOf(40.1D - (double) i));
            realtimeProfile.setDepositPhone(Double.valueOf(2.99D + (double) i));
            realtimeProfile.setEffcTransactionAndroid(Double.valueOf(41.02D - (double) i));
            realtimeProfile.setEffcTransactionH5(Double.valueOf(2.63D + (double) i));
            realtimeProfile.setEffcTransactionIos(Double.valueOf(1.77D + (double) i));
            realtimeProfile.setEffcTransactionPc(Double.valueOf(36.12D - (double) i));
            realtimeProfile.setEffcTransactionPhone(Double.valueOf(41.63D - (double) i));
            realtimeProfile.setOnlineAndroid(Integer.valueOf(3 + i));
            realtimeProfile.setOnlineH5(Integer.valueOf(35 - i));
            realtimeProfile.setOnlineIos(Integer.valueOf(3 + i));
            realtimeProfile.setOnlinePc(Integer.valueOf(40 - i));
            realtimeProfile.setOnlinePhone(Integer.valueOf(5 + i));
            realtimeProfile.setRegisterAndroid(Integer.valueOf(1 + i));
            realtimeProfile.setRegisterH5(Integer.valueOf(38 - i));
            realtimeProfile.setRegisterIos(Integer.valueOf(3 + i));
            realtimeProfile.setRegisterPc(Integer.valueOf(5 + i));
            realtimeProfile.setRegisterPhone(Integer.valueOf(37 - i));
            realtimeProfile.setRealtimeProfitLoss(Double.valueOf(Double.valueOf(String.format("%.2f", Double.valueOf(-8986.56D + (double) (i * -1000) <= -20000.0D ? 1986.56D + (double) (i * 1000) : -8986.56D + (double) (i * -1000))))));
            realtimeProfile.setCountVisitor(Integer.valueOf(realtimeProfile.getVisitorH5().intValue() + realtimeProfile.getVisitorPc().intValue()));
            realtimeProfile.setCountActive(Integer.valueOf(35 + i));
            realtimeProfile.setCountDeposit(Double.valueOf(60.69D - (double) i));
            realtimeProfile.setCountEffcTransaction(Double.valueOf(20.36D + (double) i));
            realtimeProfile.setCountOnline(Integer.valueOf(69 - i));
            realtimeProfile.setCountRegister(Integer.valueOf(80 - i));
            realtimeProfile.setCountRealtimeProfitLoss(Double.valueOf(String.format("%.2f", new Object[]{Double.valueOf(-8986.56D + (double) (i * 100) <= -20000.0D ? 1986.56D + (double) (i * 100) : -8986.56D + (double) (i * 100))})));
            profileList.add(realtimeProfile);
        }

        RealtimeProfileVo realtimeProfileVo = new RealtimeProfileVo();
        realtimeProfileVo.setCompareVisitor(Double.valueOf(-12.12D));
        realtimeProfileVo.setCompareActive(Double.valueOf(13.13D));
        realtimeProfileVo.setCompareDeposit(Double.valueOf(-14.14D));
        realtimeProfileVo.setCompareEffcTransaction(Double.valueOf(15.15D));
        realtimeProfileVo.setCompareOnline(Double.valueOf(-16.16D));
        realtimeProfileVo.setCompareRegister(Double.valueOf(17.17D));
        realtimeProfileVo.setCompareRealtimeProfitLoss(Double.valueOf(-18.18D));
        model.addAttribute("Vo", realtimeProfileVo);
        RealtimeProfileListVo realtimeProfileListVo = new RealtimeProfileListVo();
        realtimeProfileListVo.setResult(profileList);

        List<RealtimeProfileVo> realtimeProfileVos = new ArrayList();
        for(int i = 0 ;i<=30;i++){
            RealtimeProfileVo voList2Today = new RealtimeProfileVo();
            voList2Today.setResult(new RealtimeProfile());
            voList2Today.getResult().setCreateTime(date);
            voList2Today.setVisitorAll(123);
            voList2Today.setActiveAll(233);
            voList2Today.setDepositAll(654.23);
            voList2Today.setEffcTransactionAll(35.45);
            voList2Today.setOnlineAll(45);
            voList2Today.setRegisterAll(231);
            voList2Today.getResult().setRealtimeProfitLoss(5639.87);
            realtimeProfileVos.add(voList2Today);
        }
        model.addAttribute("command", realtimeProfileListVo);
        model.addAttribute("profilesJson", JsonTool.toJson(profileList));
        model.addAttribute("realtimeProfileVos", realtimeProfileVos);
        return "/daily/RealTimeSummary";
    }

    /**
     * 活跃玩家
     *
     * @return
     */
    @RequestMapping("/activePlayer")
    public String activePlayer(HttpServletRequest request, Model model) {
        return ACTIVE_PLAYER;
    }

    /**
     * 玩家留存
     *
     * @return
     */
    @RequestMapping("/playerRetain")
    public String playerRetain(HttpServletRequest request, Model model) {
        return PLAYER_RETAIN;
    }

    /**
     * 新增玩家
     *
     * @return
     */
    @RequestMapping("/newAddedPlayer")
    public String newAddedPlayer(HttpServletRequest request, Model model) {
        return NEW_ADDED_PLAYER;
    }
}
