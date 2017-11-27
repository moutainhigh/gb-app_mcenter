package so.wwb.gamebox.mcenter.player.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.player.IVPlayerRankStatisticsService;
import so.wwb.gamebox.mcenter.player.form.VPlayerRankStatisticsForm;
import so.wwb.gamebox.mcenter.player.form.VPlayerRankStatisticsSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.master.player.po.VPlayerRankStatistics;
import so.wwb.gamebox.model.master.player.vo.VPlayerRankStatisticsListVo;
import so.wwb.gamebox.model.master.player.vo.VPlayerRankStatisticsVo;


/**
 * 玩家层级统计控制器
 *
 * @author tom
 * @date 2015-7-20 17:24:29
 */
@Controller
@RequestMapping("/vPlayerRankStatistics")
public class VPlayerRankStatisticsController extends BaseCrudController<IVPlayerRankStatisticsService, VPlayerRankStatisticsListVo, VPlayerRankStatisticsVo, VPlayerRankStatisticsSearchForm, VPlayerRankStatisticsForm, VPlayerRankStatistics, Integer> {

    @Override
    protected String getViewBasePath() {
        return "/player/playerrank/";
    }

    @Override
    protected VPlayerRankStatisticsListVo doList(VPlayerRankStatisticsListVo listVo, VPlayerRankStatisticsSearchForm form, BindingResult result, Model model) {
        // getMstCurrency(model);
        model.addAttribute("currency",SessionManager.getUser().getDefaultCurrency());
        listVo = this.getService().search(listVo);
        return listVo;
    }

    @Override
    protected VPlayerRankStatisticsVo doView(VPlayerRankStatisticsVo objectVo, Model model) {
        getMstCurrency(model);
        objectVo = ServiceTool.vPlayerRankStatisticsService().viewPlayerRank(objectVo);
        return super.doView(objectVo, model);
    }

    private void getMstCurrency(Model model) {
        /*UserExtendVo userExtendVo = new UserExtendVo();
        userExtendVo.getSearch().setId(SessionManager.getSiteUserId());
        userExtendVo = ServiceTool.userExtendService().get(userExtendVo);
        model.addAttribute("currency",userExtendVo.getResult().getCurrency());*/
    }
}