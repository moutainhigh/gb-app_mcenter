package so.wwb.gamebox.mcenter.player.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.player.IVPlayerTagService;
import so.wwb.gamebox.mcenter.player.form.VPlayerTagForm;
import so.wwb.gamebox.mcenter.player.form.VPlayerTagSearchForm;
import so.wwb.gamebox.model.master.player.po.VPlayerTag;
import so.wwb.gamebox.model.master.player.vo.VPlayerTagListVo;
import so.wwb.gamebox.model.master.player.vo.VPlayerTagVo;


/**
 * 玩家标签视图控制器
 *
 * @author jeff
 * @time 2015-8-4 20:38:55
 */
@Controller
//region your codes 1
@RequestMapping("/vPlayerTag")
public class VPlayerTagController extends BaseCrudController<IVPlayerTagService, VPlayerTagListVo, VPlayerTagVo, VPlayerTagSearchForm, VPlayerTagForm, VPlayerTag, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/player/tag/";
        //endregion your codes 2
    }

    //region your codes 3

    //endregion your codes 3

}