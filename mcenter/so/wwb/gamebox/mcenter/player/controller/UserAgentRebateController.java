package so.wwb.gamebox.mcenter.player.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.player.IUserAgentRebateService;
import so.wwb.gamebox.mcenter.player.form.UserAgentRebateForm;
import so.wwb.gamebox.mcenter.player.form.UserAgentRebateSearchForm;
import so.wwb.gamebox.model.master.player.po.UserAgentRebate;
import so.wwb.gamebox.model.master.player.vo.UserAgentRebateListVo;
import so.wwb.gamebox.model.master.player.vo.UserAgentRebateVo;


/**
 * 代理/总代 返佣关联表控制器
 *
 * @author loong
 * @time 2015-9-6 9:27:01
 */
@Controller
//region your codes 1
@RequestMapping("/userAgentRebate")
public class UserAgentRebateController extends BaseCrudController<IUserAgentRebateService, UserAgentRebateListVo, UserAgentRebateVo, UserAgentRebateSearchForm, UserAgentRebateForm, UserAgentRebate, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/player/";
        //endregion your codes 2
    }

    //region your codes 3

    //endregion your codes 3

}