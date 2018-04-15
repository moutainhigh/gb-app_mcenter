package so.wwb.gamebox.mcenter.analyze.daily.controller;

import org.soul.web.controller.BaseIndexController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * 站点日常数据
 * @author martin
 * Created by martin on 18-4-12.
 */
@Controller
@RequestMapping("/daily")
public class SiteDailyController extends BaseIndexController {

    private static final String OPERATION_SUMMARY = "/daily/OperationSummary";

    private static final String REAL_TIME_SUMMARY = "/daily/RealTimeSummary";

    private static final String ACTIVE_PLAYER = "/daily/ActivePlayer";

    private static final String NEW_ADDED_PLAYER = "/daily/NewAddedPlayer";

    private static final String PLAYER_RETAIN = "/daily/PlayerRetain";

    /**
     * 经营趋势
     * @return
     */
    @RequestMapping("/operationSummary")
    public String operationSummary(HttpServletRequest request, Model model) {
        return OPERATION_SUMMARY;
    }

    /**
     * 实时总览
     * @return
     */
    @RequestMapping("/realTimeSummary")
    public String realTimeSummaryData(HttpServletRequest request, Model model) {
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
