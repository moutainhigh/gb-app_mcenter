package so.wwb.gamebox.mcenter.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.json.JsonTool;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.tools.DataTransTool;
import so.wwb.gamebox.model.WeekTool;
import so.wwb.gamebox.model.company.setting.po.ApiGametypeRelation;
import so.wwb.gamebox.model.company.setting.vo.ApiGametypeRelationVo;
import so.wwb.gamebox.model.site.report.po.RealtimeProfile;
import so.wwb.gamebox.model.site.report.vo.OperationSummaryVo;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileListVo;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileVo;
import so.wwb.gamebox.web.home.controller.BaseHomeController;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author martin
 * @time 2018-5-4
 */
@Controller
@RequestMapping("/home")
public class HomeController extends BaseHomeController {

    private static final String REAL_TIME_SUMMARY = "/daily/RealTimeSummary";

    private static final String OPERATION_SUMMARY = "/daily/OperationSummary";

    @RequestMapping("/index")
    public String topagentHome(Model model) {
        super.index(model);
        OperationSummaryVo vo = new OperationSummaryVo();
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
}
