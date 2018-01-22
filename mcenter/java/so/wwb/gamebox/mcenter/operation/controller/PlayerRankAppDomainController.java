package so.wwb.gamebox.mcenter.operation.controller;


import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.operation.IPlayerRankAppDomainService;
import so.wwb.gamebox.mcenter.operation.form.PlayerRankAppDomainForm;
import so.wwb.gamebox.mcenter.operation.form.PlayerRankAppDomainSearchForm;
import so.wwb.gamebox.model.master.operation.po.PlayerRankAppDomain;
import so.wwb.gamebox.model.master.operation.vo.PlayerRankAppDomainListVo;
import so.wwb.gamebox.model.master.operation.vo.PlayerRankAppDomainVo;


/**
 * APP下载域名层级关联表控制器
 *
 * @author back
 * @time 2018-1-18 19:49:09
 */
@Controller
//region your codes 1
@RequestMapping("/playerRankAppDomain")
public class PlayerRankAppDomainController extends BaseCrudController<IPlayerRankAppDomainService, PlayerRankAppDomainListVo, PlayerRankAppDomainVo, PlayerRankAppDomainSearchForm, PlayerRankAppDomainForm, PlayerRankAppDomain, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/playerRankAppDomain/";
        //endregion your codes 2
    }

    //region your codes 3

    //endregion your codes 3

}