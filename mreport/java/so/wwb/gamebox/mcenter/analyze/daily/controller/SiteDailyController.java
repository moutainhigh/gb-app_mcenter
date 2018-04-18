package so.wwb.gamebox.mcenter.analyze.daily.controller;

import com.alibaba.fastjson.JSON;
import org.soul.commons.data.json.JsonTool;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.model.site.report.po.OperationSummary;
import so.wwb.gamebox.model.site.report.po.RealtimeProfile;
import so.wwb.gamebox.model.site.report.vo.OperationSummaryVo;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileListVo;

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
        List<RealtimeProfile> profileLists = new ArrayList<>();
        Date date = new Date();
//        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//        String format = dateFormat.format(date);
        for(int i = 1;i<=10;i++){
            RealtimeProfile realtimeProfile = new RealtimeProfile();
            realtimeProfile.setRealtimeDate(date);
            realtimeProfile.setVisitorAll(10);
            realtimeProfile.setActiveAll(30);
            realtimeProfile.setDepositAll(20);
            realtimeProfile.setEffcTransactionAll(40);
            realtimeProfile.setOnlineAll(50);
            realtimeProfile.setProfitAll(60);
            realtimeProfile.setRegisterAll(70);
            profileLists.add(realtimeProfile);
        }

        for(int i = 0;i<=23;i++){
            RealtimeProfile realtimeProfile = new RealtimeProfile();
//            realtimeProfile
        }
        RealtimeProfileListVo realtimeProfileListVo = new RealtimeProfileListVo();
        realtimeProfileListVo.setResult(profileLists);
        model.addAttribute("command",realtimeProfileListVo);
        model.addAttribute("realtimeProfileListJson", JsonTool.toJson(profileLists));
        return REAL_TIME_SUMMARY;
    }

    /**
     * 活跃玩家
     * @return
     */
    @RequestMapping("/activePlayer")
    public String activePlayer(HttpServletRequest request, Model model) {
        return ACTIVE_PLAYER;
    }

    /**
     * 玩家留存
     * @return
     */
    @RequestMapping("/playerRetain")
    public String playerRetain(HttpServletRequest request, Model model) {
        return PLAYER_RETAIN;
    }

    /**
     * 新增玩家
     * @return
     */
    @RequestMapping("/newAddedPlayer")
    public String newAddedPlayer(HttpServletRequest request, Model model) {
        return NEW_ADDED_PLAYER;
    }
}
