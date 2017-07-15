package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.setting.IVNoticeEmailRankService;
import so.wwb.gamebox.mcenter.setting.form.VNoticeEmailRankForm;
import so.wwb.gamebox.mcenter.setting.form.VNoticeEmailRankSearchForm;
import so.wwb.gamebox.model.master.setting.po.VNoticeEmailRank;
import so.wwb.gamebox.model.master.setting.vo.VNoticeEmailRankListVo;
import so.wwb.gamebox.model.master.setting.vo.VNoticeEmailRankVo;


/**
 * 控制器
 *
 * @author mark
 * @time 2015-12-30 20:03:40
 */
@Controller
//region your codes 1
@RequestMapping("/vNoticeEmailRank")
public class VNoticeEmailRankController extends BaseCrudController<IVNoticeEmailRankService, VNoticeEmailRankListVo, VNoticeEmailRankVo, VNoticeEmailRankSearchForm, VNoticeEmailRankForm, VNoticeEmailRank, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/interface/email/";
        //endregion your codes 2
    }

    //region your codes 3

    //endregion your codes 3

}