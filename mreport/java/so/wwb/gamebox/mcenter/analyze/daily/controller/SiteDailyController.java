package so.wwb.gamebox.mcenter.analyze.daily.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.json.JsonTool;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.mcenter.tools.DataTransTool;
import so.wwb.gamebox.model.gameapi.enums.ApiProviderEnum;
import so.wwb.gamebox.model.master.operation.vo.RakebackApiListVo;
import so.wwb.gamebox.model.site.report.po.RealtimeProfile;
import so.wwb.gamebox.model.site.report.vo.OperationSummaryVo;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileListVo;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileVo;

import javax.servlet.http.HttpServletRequest;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
    public String operationSummary(OperationSummaryVo vo , Model model) {
       /* Calendar createDate = Calendar.getInstance();
        createDate.set(Calendar.HOUR,23);
        createDate.set(Calendar.MINUTE,59);
        createDate.set(Calendar.SECOND,59);
        Date date = new Date(createDate.getTime().getTime() - (long)24*60*60*1000);
        vo.getSearch().setStaticTimeEnd(date);

        createDate.set(Calendar.HOUR_OF_DAY,00);
        createDate.set(Calendar.MINUTE,00);
        createDate.set(Calendar.SECOND,00);
        createDate.set(Calendar.DAY_OF_MONTH,10);
        date = new Date(createDate.getTime().getTime());
        vo.getSearch().setStaticTime(date);*/

        vo = ServiceSiteTool.operationSummaryService().getOperationSummaryData(vo);
        model.addAttribute("balanceGaugeChartData", JsonTool.toJson(vo.getBalanceGaugeChart()));
        model.addAttribute("effectiveGaugeChartData", JsonTool.toJson(vo.getEffectiveGaugeChart()));
        model.addAttribute("profitLossGaugeChartData", JsonTool.toJson(vo.getProfitLossGaugeChart()));
        model.addAttribute("operationSummaryData", JsonTool.toJson(vo.getEntities()));
        model.addAttribute("rakebackCashApis", ApiProviderEnum.values());
        return OPERATION_SUMMARY;
    }

    /**
     * 根据选择的API来查询反水金额
     */
    @RequestMapping("/queryRakebackCashByApi")
    public Map<String , Object> queryRakebackCashByApi(RakebackApiListVo rakebackApiListVo) {
        rakebackApiListVo  = ServiceSiteTool.rakebackApiService().query(rakebackApiListVo);
        return null;
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
            profileVo.setCompareVisitor(DataTransTool.getPercentage(lastProfile.getCountVisitor(), fristProfile.getCountVisitor()));
            profileVo.setCompareActive(DataTransTool.getPercentage(lastProfile.getCountActive(), fristProfile.getCountActive()));
            profileVo.setCompareRegister(DataTransTool.getPercentage(lastProfile.getCountRegister(), fristProfile.getCountRegister()));
            profileVo.setCompareDeposit(DataTransTool.getPercentage(lastProfile.getCountDeposit(), fristProfile.getCountDeposit()));
            profileVo.setCompareEffcTransaction(DataTransTool.getPercentage(lastProfile.getCountEffcTransaction(), fristProfile.getCountEffcTransaction()));
            profileVo.setCompareOnline(DataTransTool.getPercentage(lastProfile.getCountOnline(), fristProfile.getCountOnline()));
            profileVo.setCompareRealtimeProfitLoss(DataTransTool.getPercentage(lastProfile.getRealtimeProfitLoss(), fristProfile.getRealtimeProfitLoss()));
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
        return REAL_TIME_SUMMARY;

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
