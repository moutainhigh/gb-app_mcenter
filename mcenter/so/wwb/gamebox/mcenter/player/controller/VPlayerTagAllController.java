package so.wwb.gamebox.mcenter.player.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.player.IVPlayerTagAllService;
import so.wwb.gamebox.mcenter.player.form.VPlayerTagAllForm;
import so.wwb.gamebox.mcenter.player.form.VPlayerTagAllSearchForm;
import so.wwb.gamebox.model.master.player.po.VPlayerTagAll;
import so.wwb.gamebox.model.master.player.vo.VPlayerTagAllListVo;
import so.wwb.gamebox.model.master.player.vo.VPlayerTagAllVo;


/**
 * 控制器
 * <p/>
 * Created by ke using soul-code-generator on 2015-7-6 11:49:31
 */
@Controller
//region your codes 1
@RequestMapping("/vPlayerTagAll")
public class VPlayerTagAllController extends BaseCrudController<IVPlayerTagAllService, VPlayerTagAllListVo, VPlayerTagAllVo, VPlayerTagAllSearchForm, VPlayerTagAllForm, VPlayerTagAll, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/sysUserLabel/";
        //endregion your codes 2
    }

    //region your codes 3
    //endregion your codes 3

}