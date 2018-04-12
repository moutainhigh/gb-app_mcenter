package so.wwb.gamebox.mcenter.analyze.daily.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.site.report.IRealtimeProfileService;
import so.wwb.gamebox.mcenter.analyze.daily.form.RealtimeProfileForm;
import so.wwb.gamebox.mcenter.analyze.daily.form.RealtimeProfileSearchForm;
import so.wwb.gamebox.model.site.report.po.RealtimeProfile;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileListVo;
import so.wwb.gamebox.model.site.report.vo.RealtimeProfileVo;

import java.util.HashMap;
import java.util.Map;

/**
 * 实时概况控制器
 * @author martin
 * @time 2018-4-10 20:28:52
 */
@Controller
@RequestMapping("/realtimeProfile")
public class RealtimeProfileController extends BaseCrudController<IRealtimeProfileService, RealtimeProfileListVo, RealtimeProfileVo, RealtimeProfileSearchForm, RealtimeProfileForm, RealtimeProfile, Integer> {

    @Override
    protected String getViewBasePath() {
        return "/mreport/";
    }

    /**
     * 实时汇总数据
     * @return
     */
    @RequestMapping("/summaryData")
    public Map<String, Object> realtimeSummaryData() {
        Map<String, Object> map = new HashMap<String, Object>();
        return map;
    }

    /**
     * 实时访客
     * @return
     */
    @RequestMapping("/visitor")
    public Map<String, Object> realtimeVisitor() {
        Map<String, Object> map = new HashMap<String, Object>();
        return map;
    }

    /**
     * 实时活跃用户
     * @return
     */
    @RequestMapping("/active")
    public Map<String, Object> realtimeActive() {
        Map<String, Object> map = new HashMap<String, Object>();
        return map;
    }

    /**
     * 实时注册
     * @return
     */
    @RequestMapping("/register")
    public Map<String, Object> realtimeRegister() {
        Map<String, Object> map = new HashMap<String, Object>();
        return map;
    }

    /**
     * 实时存款
     * @return
     */
    @RequestMapping("/deposit")
    public Map<String, Object> realtimeDeposit() {
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
    public Map<String, Object> realtimeOnlne() {
        Map<String, Object> map = new HashMap<String, Object>();
        return map;
    }

    /**
     * 实时损益
     * @return
     */
    @RequestMapping("/profitLoss")
    public Map<String, Object> realtimeProfitLoss() {
        Map<String, Object> map = new HashMap<String, Object>();
        return map;
    }
}