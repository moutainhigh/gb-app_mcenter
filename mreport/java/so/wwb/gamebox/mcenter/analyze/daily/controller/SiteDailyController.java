package so.wwb.gamebox.mcenter.analyze.daily.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.json.JsonTool;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.mcenter.tools.DataTransTool;
import so.wwb.gamebox.model.site.report.po.RealtimeProfile;
import so.wwb.gamebox.model.site.report.vo.OperationSummaryVo;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileListVo;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileVo;

import javax.servlet.http.HttpServletRequest;
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
        model.addAttribute("balanceBarChartData", JsonTool.toJson(o.getBalanceBarChart()));
        model.addAttribute("effectiveBarChartData", JsonTool.toJson(o.getEffectiveBarChart()));
        model.addAttribute("operationSummaryData", JsonTool.toJson(o.getEntities()));
        model.addAttribute("balanceSummaryData", JsonTool.toJson(DataTransTool.transBalanceObjToMap(o.getEntities())));
        model.addAttribute("columnsDateFieldList", JsonTool.toJson(DataTransTool.extractDateFields(o.getEntities())));
        return OPERATION_SUMMARY;
    }

    /**
     * (o1-o2)/o2*100:保留两位小数后返回（参数仅支持int或double）
     *
     * @param o1 today
     * @param o2 yesterday
     * @return
     */
    public static double getPercentage(Object o1, Object o2) {
        if (o1 == null && o2 == null) {
            return 0.0D;
        } else {
            double d1 = 0.0D, d2 = 0.0D;
            boolean b1 = false, b2 = false;
            if (o1 instanceof Integer) {
                d1 = ((Integer) o1).doubleValue();
                b1 = true;
            }

            if (o2 instanceof Integer) {
                d2 = ((Integer) o2).doubleValue();
                b2 = true;
            }

            if (o1 instanceof Double) {
                d1 = ((Double) o1).doubleValue();
                b1 = true;
            }

            if (o2 instanceof Double) {
                d2 = ((Double) o2).doubleValue();
                b2 = true;
            }

            return b1 && b2 ? Double.valueOf(String.format("%.2f", new Object[]{Double.valueOf((d1 - d2) / d2 * 100 )})).doubleValue() : 0.0D;
        }
    }

    /**
     * 实时总览
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping({"/realTimeSummary"})
    public String realTimeSummaryData(HttpServletRequest request, Model model) {
        RealtimeProfileVo condition = new RealtimeProfileVo();
        List<RealtimeProfile> profiles = ServiceSiteTool.realtimeProfileService().queryRealtimeCartogram(condition);
        List<RealtimeProfileVo> historyReportForm = ServiceSiteTool.realtimeProfileService().queryHistoryReportForm(condition);
        RealtimeProfileListVo realtimeProfileListVo = new RealtimeProfileListVo();
        if (CollectionTool.isNotEmpty(profiles)) {
            //今日此时
            RealtimeProfile lastProfile = profiles.get(profiles.size() - 1);
            //昨日此时
            RealtimeProfile fristProfile = profiles.get(0);
            profiles.remove(0);
            //对比昨日同时段浮动百分比
            RealtimeProfileVo profileVo = new RealtimeProfileVo();
            profileVo.setCompareVisitor(getPercentage(lastProfile.getCountVisitor(), fristProfile.getCountVisitor()));
            profileVo.setCompareActive(getPercentage(lastProfile.getCountActive(), fristProfile.getCountActive()));
            profileVo.setCompareRegister(getPercentage(lastProfile.getCountRegister(), fristProfile.getCountRegister()));
            profileVo.setCompareDeposit(getPercentage(lastProfile.getCountDeposit(), fristProfile.getCountDeposit()));
            profileVo.setCompareEffcTransaction(getPercentage(lastProfile.getCountEffcTransaction(), fristProfile.getCountEffcTransaction()));
            profileVo.setCompareOnline(getPercentage(lastProfile.getCountOnline(), fristProfile.getCountOnline()));
            profileVo.setCompareRealtimeProfitLoss(getPercentage(lastProfile.getRealtimeProfitLoss(), fristProfile.getRealtimeProfitLoss()));
            realtimeProfileListVo.setResult(profiles);
            model.addAttribute("profilesJson", JsonTool.toJson(profiles));
            model.addAttribute("Vo", profileVo);
        }

        if (CollectionTool.isNotEmpty(historyReportForm)) {
            RealtimeProfileVo fristProfileVo = (RealtimeProfileVo) historyReportForm.get(0);
            fristProfileVo.setStatisticsDate(new Date());
            model.addAttribute("realtimeProfileVos", historyReportForm);
        }

        model.addAttribute("command", realtimeProfileListVo);
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
