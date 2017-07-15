package so.wwb.gamebox.mcenter.player.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.player.IUserAgentRakebackService;
import so.wwb.gamebox.mcenter.player.form.UserAgentRakebackForm;
import so.wwb.gamebox.mcenter.player.form.UserAgentRakebackSearchForm;
import so.wwb.gamebox.model.master.player.po.UserAgentRakeback;
import so.wwb.gamebox.model.master.player.vo.UserAgentRakebackListVo;
import so.wwb.gamebox.model.master.player.vo.UserAgentRakebackVo;


/**
 * 代理/总代 返水关联表控制器
 *
 * @author loong
 * @time 2015-9-6 9:26:44
 */
@Controller
//region your codes 1
@RequestMapping("/userAgentRakeback")
public class UserAgentRakebackController extends BaseCrudController<IUserAgentRakebackService, UserAgentRakebackListVo, UserAgentRakebackVo, UserAgentRakebackSearchForm, UserAgentRakebackForm, UserAgentRakeback, Integer> {
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