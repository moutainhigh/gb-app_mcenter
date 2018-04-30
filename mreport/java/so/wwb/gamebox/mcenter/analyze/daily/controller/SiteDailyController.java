package so.wwb.gamebox.mcenter.analyze.daily.controller;

import com.alibaba.fastjson.JSON;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.query.Paging;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.tools.DataTransTool;
import so.wwb.gamebox.model.WeekTool;
import so.wwb.gamebox.model.company.setting.po.ApiGametypeRelation;
import so.wwb.gamebox.model.company.setting.vo.ApiGametypeRelationListVo;
import so.wwb.gamebox.model.company.setting.vo.ApiGametypeRelationVo;
import so.wwb.gamebox.model.gameapi.enums.ApiProviderEnum;
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
        vo.setTimeZone(WeekTool.getTimeZoneInterval());
        vo = ServiceSiteTool.operationSummaryService().getOperationSummaryData(vo);
        model.addAttribute("operationSummaryData", JsonTool.toJson(vo.getEntities()));
        Map<String,ApiGametypeRelation> map = ServiceTool.apiGametypeRelationService().load(new ApiGametypeRelationVo());
        model.addAttribute("rakebackCashApis", map);
        return OPERATION_SUMMARY;
    }

    /**
     * 运营统计
     * @return
     */
    @RequestMapping("/operationSummaryDataOfChoiceDays")
    @ResponseBody
    public String operationSummaryDataOfChoiceDays(OperationSummaryVo vo , Model model) {
        //拼装结束时间
        Calendar createDate = Calendar.getInstance();
        createDate.setTime(vo.getSearch().getStaticTimeEnd());
        createDate.set(Calendar.HOUR_OF_DAY,00);
        createDate.set(Calendar.MINUTE,00);
        createDate.set(Calendar.SECOND,00);
        Date date = new Date(createDate.getTime().getTime());
        vo.getSearch().setStaticTimeEnd(date);
        //拼装开始时间
        createDate.setTime(vo.getSearch().getStaticTime());
        createDate.set(Calendar.HOUR_OF_DAY,00);
        createDate.set(Calendar.MINUTE,00);
        createDate.set(Calendar.SECOND,00);
        date = new Date(createDate.getTime().getTime());
        vo.getSearch().setStaticTime(date);

        vo = ServiceSiteTool.operationSummaryService().getOperationSummaryData(vo);
        return JsonTool.toJson(vo.getEntities());
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
     * 根据选择的API来查询反水金额
     */
    @RequestMapping("/queryRakebackCashByApi")
    @ResponseBody
    public String queryRakebackCashByApi(OperationSummaryVo vo) {
        RakebackApiListVo rakebackApiListVo = new RakebackApiListVo();
        RakebackApiSo rakebackApiSo = new RakebackApiSo();
//        rakebackApiSo.setQueryDateRange("D");
//        rakebackApiSo.setRakebackAmountApis(new Integer[]{22,3,12,9,10,13,14,15,16});
//        rakebackApiSo.setRakebackAmountGameTypes(new String[]{"Casino","Lottery","Sportsbook"});
//        rakebackApiSo.setStartTime(new Date(new Date().getTime() - (long)15*24*60*60*1000));
//        rakebackApiSo.setEndTime(new Date());


        rakebackApiSo.setQueryDateRange(vo.getQueryDateRange());
        rakebackApiSo.setRakebackAmountApis(vo.getRakebackAmountApis());
        rakebackApiSo.setRakebackAmountGameTypes(vo.getRakebackAmountGameTypes());
        rakebackApiSo.setStartTime(vo.getResult().getStaticTime());
        rakebackApiSo.setEndTime(vo.getResult().getStaticTimeEnd());
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
            realtimeProfileListVo.setResult(profiles);
            model.addAttribute("Vo", profileVo);
            model.addAttribute("realtimeData",lastProfile);
        }
        if(CollectionTool.isNotEmpty(profiles)){
            model.addAttribute("profilesJson", JsonTool.toJson(profiles));
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
