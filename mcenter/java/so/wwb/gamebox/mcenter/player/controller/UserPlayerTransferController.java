package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.lang.string.StringTool;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.player.IUserPlayerTransferService;
import so.wwb.gamebox.mcenter.player.form.UserPlayerTransferForm;
import so.wwb.gamebox.mcenter.player.form.UserPlayerTransferSearchForm;
import so.wwb.gamebox.model.master.player.po.UserPlayerTransfer;
import so.wwb.gamebox.model.master.player.vo.UserPlayerTransferListVo;
import so.wwb.gamebox.model.master.player.vo.UserPlayerTransferVo;

import java.util.Arrays;
import java.util.List;


/**
 * 导入玩家表 by River控制器
 *
 * @author River
 * @time 2015-12-28 16:30:45
 */
@Controller
//region your codes 1
@RequestMapping("/userPlayerTransfer")
public class UserPlayerTransferController extends BaseCrudController<IUserPlayerTransferService, UserPlayerTransferListVo, UserPlayerTransferVo, UserPlayerTransferSearchForm, UserPlayerTransferForm, UserPlayerTransfer, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/param/importplayer/playerview/";
        //endregion your codes 2
    }

    //region your codes 3

    @Override
    protected UserPlayerTransferListVo doList(UserPlayerTransferListVo listVo, UserPlayerTransferSearchForm form, BindingResult result, Model model) {
        if(StringTool.isNotBlank(listVo.getSearch().getPlayerAccount())){
            String playerAccount = listVo.getSearch().getPlayerAccount();
            String[] usernames = playerAccount.split(",");
            List<String> nameList = Arrays.asList(usernames);
            listVo.getSearch().setUsernameList(nameList);
            listVo.getSearch().setPlayerAccount(null);
        }
        return super.doList(listVo, form, result, model);
    }

    //endregion your codes 3

}