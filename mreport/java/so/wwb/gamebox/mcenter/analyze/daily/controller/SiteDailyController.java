package so.wwb.gamebox.mcenter.analyze.daily.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.tools.DataTransTool;
import so.wwb.gamebox.model.WeekTool;
import so.wwb.gamebox.model.company.setting.po.ApiGametypeRelation;
import so.wwb.gamebox.model.company.setting.vo.ApiGametypeRelationVo;
import so.wwb.gamebox.model.master.operation.so.RakebackApiSo;
import so.wwb.gamebox.model.master.operation.vo.RakebackApiListVo;
import so.wwb.gamebox.model.master.operation.vo.RakebackApiVo;
import so.wwb.gamebox.model.site.report.po.RealtimeProfile;
import so.wwb.gamebox.model.site.report.vo.OperationSummaryVo;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileListVo;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileVo;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 站点日常数据Controller
 * @author martin
 * @time 2018-4-12
 */
@Controller
@RequestMapping("/daily")
public class SiteDailyController {

    private static final Log LOG = LogFactory.getLog(SiteDailyController.class);

    private static final String OPERATION_SUMMARY = "/daily/OperationSummary";

    private static final String REAL_TIME_SUMMARY = "/daily/RealTimeSummary";

    private static final String ACTIVE_PLAYER = "/daily/ActivePlayer";

    private static final String NEW_ADDED_PLAYER = "/daily/NewAddedPlayer";

    private static final String PLAYER_RETAIN = "/daily/PlayerRetain";

    /**
     * 运营统计首页数据加载
     * @return
     */
    @RequestMapping("/operationSummary")
    public String operationSummary(OperationSummaryVo vo , Model model) {
        vo.setTimeZone(WeekTool.getTimeZoneInterval());
        vo = ServiceSiteTool.operationSummaryService().getOperationSummaryData(vo);
        model.addAttribute("operationSummaryData", JsonTool.toJson(vo.getEntities()));
        Map<String,ApiGametypeRelation> map = ServiceTool.apiGametypeRelationService().load(new ApiGametypeRelationVo());
        List<String> gameTypes = new ArrayList<>();
        if(CollectionTool.isNotEmpty(map.values())) {
            for (ApiGametypeRelation relation : map.values()) {
                if (!gameTypes.contains(relation.getGameType())) {
                    gameTypes.add(relation.getGameType());
                }
            }
        }
        model.addAttribute("gameTypes", gameTypes);
        model.addAttribute("rakebackCashApis", map);
        return OPERATION_SUMMARY;
    }

    /**
     * 异步加载运营统计数据
     * @return
     */
    @RequestMapping("/asyncLoadOperationSummary")
    @ResponseBody
    public Map<String, Object> asyncLoadOperationSummary(OperationSummaryVo vo) {
        vo.setTimeZone(WeekTool.getTimeZoneInterval());
        vo = ServiceSiteTool.operationSummaryService().getOperationSummaryData(vo);
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("operationSummaryData", vo.getEntities());
        return model;
    }

    /**
     * 按指定时间查询运营统计数据
     * @return
     */
    @RequestMapping("/operationSummaryDataOfChoiceDays")
    @ResponseBody
    public String operationSummaryDataOfChoiceDays(OperationSummaryVo vo) {
        //拼装结束时间
//        Calendar createDate = Calendar.getInstance();
//        createDate.setTime(vo.getSearch().getStaticTimeEnd());
//        createDate.set(Calendar.HOUR_OF_DAY,00);
//        createDate.set(Calendar.MINUTE,00);
//        createDate.set(Calendar.SECOND,00);
//        Date date = new Date(createDate.getTime().getTime());
//        vo.getSearch().setStaticTimeEnd(date);
//        //拼装开始时间
//        createDate.setTime(vo.getSearch().getStaticTime());
//        createDate.set(Calendar.HOUR_OF_DAY,00);
//        createDate.set(Calendar.MINUTE,00);
//        createDate.set(Calendar.SECOND,00);
//        date = new Date(createDate.getTime().getTime());
//        vo.getSearch().setStaticTime(date);

        vo = ServiceSiteTool.operationSummaryService().getOperationSummaryDataByDays(vo);
        return JsonTool.toJson(vo.getEntities());
    }

    /**
     * 运营统计数据分页查询
     * @return
     */
    @RequestMapping("/searchOperationSummaryByDays")
    @ResponseBody
    public OperationSummaryVo searchOperationSummaryByDays(OperationSummaryVo vo) {
        return ServiceSiteTool.operationSummaryService().searchOperationSummaryByDays(vo);
    }

    /**
     * 根据选择的API来查询反水金额
     */
    @RequestMapping(value = "/queryRakebackCashByApi",method = RequestMethod.POST ,headers = {"Content-type=application/json"})
    @ResponseBody
    public String queryRakebackCashByApi(@RequestBody OperationSummaryVo vo) {
        RakebackApiListVo rakebackApiListVo = new RakebackApiListVo();
        RakebackApiSo rakebackApiSo = new RakebackApiSo();
        rakebackApiSo.setQueryDateRange(vo.getQueryDateRange());
        rakebackApiSo.setRakebackAmountApis(vo.getRakebackAmountApis());
        rakebackApiSo.setRakebackAmountGameTypes(vo.getRakebackAmountGameTypes());
        rakebackApiSo.setStartTime(vo.getBeginTime());
        rakebackApiSo.setEndTime(vo.getEndTime());
        rakebackApiListVo.setSearch(rakebackApiSo);
        List<RakebackApiVo> apiVos  = ServiceSiteTool.rakebackApiService().queryRakebacksByDate(rakebackApiListVo);
        if(CollectionTool.isEmpty(apiVos)){
            return null;
        }
        return JsonTool.toJson(apiVos);
    }

    /**
     * 实时总览
     * @param
     * @param model
     * @return
     */
    @RequestMapping({"/realTimeSummary"})
    public String realTimeSummaryData(RealtimeProfileVo condition, Model model) {
        condition.setCurrentTimeZone(WeekTool.getTimeZoneInterval());
        List<RealtimeProfile> profiles = ServiceSiteTool.realtimeProfileService().queryRealtimeCartogram(condition);
        List<RealtimeProfile> realtimedata = ServiceSiteTool.realtimeProfileService().queryNowAndYesterdayData(condition);
        List<RealtimeProfileVo> historyReportForm = ServiceSiteTool.realtimeProfileService().queryHistoryReportForm(condition);
        RealtimeProfileListVo realtimeProfileListVo = new RealtimeProfileListVo();
        if (CollectionTool.isNotEmpty(realtimedata)) {
            //今日此时
            RealtimeProfile lastProfile = realtimedata.get(realtimedata.size() - 1);
            //昨日此时
            RealtimeProfile fristProfile = realtimedata.get(0);

            //对比昨日同时段浮动百分比
            RealtimeProfileVo profileVo = new RealtimeProfileVo();
            profileVo.setCompareVisitor(DataTransTool.getPercentage(lastProfile.getCountVisitor(), fristProfile.getCountVisitor()));
            profileVo.setCompareActive(DataTransTool.getPercentage(lastProfile.getCountActive(), fristProfile.getCountActive()));
            profileVo.setCompareRegister(DataTransTool.getPercentage(lastProfile.getCountRegister(), fristProfile.getCountRegister()));
            profileVo.setCompareDeposit(DataTransTool.getPercentage(lastProfile.getCountDeposit(), fristProfile.getCountDeposit()));
            profileVo.setCompareEffcTransaction(DataTransTool.getPercentage(lastProfile.getCountEffcTransaction(), fristProfile.getCountEffcTransaction()));
            profileVo.setCompareOnline(DataTransTool.getPercentage(lastProfile.getCountOnline(), fristProfile.getCountOnline()));
            profileVo.setCompareRealtimeProfitLoss(DataTransTool.getPercentage(lastProfile.getRealtimeProfitLoss(), fristProfile.getRealtimeProfitLoss()));
            model.addAttribute("Vo", profileVo);
            model.addAttribute("realtimeData",lastProfile);
        }
        if(CollectionTool.isNotEmpty(profiles)){
            model.addAttribute("profilesJson", JsonTool.toJson(profiles));
            realtimeProfileListVo.setResult(profiles);
        }

        if (CollectionTool.isNotEmpty(historyReportForm)) {
            RealtimeProfileVo fristProfileVo = historyReportForm.get(0);
            fristProfileVo.setStatisticsDate(new Date());
            model.addAttribute("realtimeProfileVos", historyReportForm);
        }

        model.addAttribute("command", realtimeProfileListVo);
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
