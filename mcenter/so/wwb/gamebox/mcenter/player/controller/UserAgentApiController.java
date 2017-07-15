package so.wwb.gamebox.mcenter.player.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.player.IUserAgentApiService;
import so.wwb.gamebox.mcenter.player.form.UserAgentApiForm;
import so.wwb.gamebox.mcenter.player.form.UserAgentApiSearchForm;
import so.wwb.gamebox.model.master.player.po.UserAgentApi;
import so.wwb.gamebox.model.master.player.vo.UserAgentApiListVo;
import so.wwb.gamebox.model.master.player.vo.UserAgentApiVo;


/**
 * 总代API占成表控制器
 *
 * @author loong
 * @time 2015-9-6 9:25:05
 */
@Controller
//region your codes 1
@RequestMapping("/userAgentApi")
public class UserAgentApiController extends BaseCrudController<IUserAgentApiService, UserAgentApiListVo, UserAgentApiVo, UserAgentApiSearchForm, UserAgentApiForm, UserAgentApi, Integer> {
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