package so.wwb.gamebox.mcenter.analyze.daily.controller;

import org.soul.web.controller.BaseCrudController;
import org.soul.web.controller.BaseIndexController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.site.report.IRealtimeProfileService;
import so.wwb.gamebox.mcenter.analyze.daily.form.RealtimeProfileForm;
import so.wwb.gamebox.mcenter.analyze.daily.form.RealtimeProfileSearchForm;
import so.wwb.gamebox.model.site.report.po.RealtimeProfile;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileListVo;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileVo;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * 实时概况控制器
 * @author martin
 * @time 2018-4-10 20:28:52
 */
@Controller
@RequestMapping("/realtimeProfile")
public class RealtimeProfileController extends BaseIndexController {

    private static final String REAL_TIME_SUMMARY = "/daily/RealTimeSummary";

    /**
     * 实时汇总数据
     * @return
     */
    @RequestMapping("/summaryData")
    public String realTimeSummaryData(HttpServletRequest request, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        return REAL_TIME_SUMMARY;
    }

    /**
     * 实时访客
     * @return
     */
    @RequestMapping("/visitor")
    public Map<String, Object> realTimeVisitor() {
        Map<String, Object> map = new HashMap<String, Object>();
        return map;
    }

    /**
     * 实时活跃用户
     * @return
     */
    @RequestMapping("/active")
    public Map<String, Object> realTimeActive() {
        Map<String, Object> map = new HashMap<String, Object>();
        return map;
    }

    /**
     * 实时注册
     * @return
     */
    @RequestMapping("/register")
    public Map<String, Object> realTimeRegister() {
        Map<String, Object> map = new HashMap<String, Object>();
        return map;
    }

    /**
     * 实时存款
     * @return
     */
    @RequestMapping("/deposit")
    public Map<String, Object> realTimeDeposit() {
        Map<String, Object> map = new HashMap<String, Object>();
        return map;
    }

    /**
     * 实时投注额
     * @return
     */
    @RequestMapping("/effcTransaction")
    public Map<String, Object> realtimeEffcTransaction() {
        Map<String, Object> map = new HashMap<String, Object>();
        return map;
    }

    /**
     * 实时在线
     * @return
     */
    @RequestMapping("/online")
    public Map<String, Object> realTimeOnlne() {
        Map<String, Object> map = new HashMap<String, Object>();
        return map;
    }

    /**
     * 实时损益
     * @return
     */
    @RequestMapping("/profitLoss")
    public Map<String, Object> realTimeProfitLoss() {
        Map<String, Object> map = new HashMap<String, Object>();
        return map;
    }
}