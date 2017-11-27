package so.wwb.gamebox.mcenter.player.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.player.IPlayerTagService;
import so.wwb.gamebox.mcenter.player.form.PlayerTagForm;
import so.wwb.gamebox.mcenter.player.form.PlayerTagSearchForm;
import so.wwb.gamebox.model.master.player.po.PlayerTag;
import so.wwb.gamebox.model.master.player.po.VPlayerTag;
import so.wwb.gamebox.model.master.player.vo.PlayerTagListVo;
import so.wwb.gamebox.model.master.player.vo.PlayerTagVo;
import so.wwb.gamebox.model.master.player.vo.VPlayerTagListVo;
import so.wwb.gamebox.model.master.player.vo.VPlayerTagVo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 玩家标签 关联表控制器
 *
 * Created by jeff using soul-code-generator on 2015-6-29 14:26:58
 */
@Controller
//region your codes 1
@RequestMapping("/playerTag")
public class PlayerTagController extends BaseCrudController<IPlayerTagService, PlayerTagListVo, PlayerTagVo, PlayerTagSearchForm, PlayerTagForm, PlayerTag, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "player/tag/";
        //endregion your codes 2
    }

    //region your codes 3
    //region Views List
    private static final String MANAGER_TAG="player/tag/Manage";
    private static final String PLAYER_TAGS="player/tag/playerTags";
    //endregion
    @RequestMapping("/manageTag")
    public String manageTag(Model model){
        model.addAttribute("PlayerTags", ServiceTool.vPlayerTagService().allSearch(new VPlayerTagListVo()));
         return MANAGER_TAG;
     }

    @RequestMapping("/getTagByUserId")
    public String getTagByUserId(VPlayerTagVo vPlayerTagVo,Model model){
        List<VPlayerTag> vPlayerTags = ServiceTool.vPlayerTagService().getTagByUserId(vPlayerTagVo);

        model.addAttribute("tags", vPlayerTags);
        model.addAttribute("userLen",vPlayerTagVo.getUserId().size());
        model.addAttribute("userIds",vPlayerTagVo.getUserId());
        return PLAYER_TAGS;
    }

    @RequestMapping("/saveTag")
    @ResponseBody
    public Map saveTag(PlayerTagVo playerTagVo){

        if (playerTagVo.getSearch().getInsertTagId() != null && playerTagVo.getSearch().getPlayerIds() != null) {
            VPlayerTagListVo vPlayerTagListVo = new VPlayerTagListVo();
            vPlayerTagListVo.setPropertyValues(playerTagVo.getSearch().getInsertTagId());
            List<VPlayerTag> vPlayerTags = ServiceTool.vPlayerTagService().inSearchById(vPlayerTagListVo);
            Map<String,Object> map = new HashMap<>(3,1f);
            for (VPlayerTag vPlayerTag : vPlayerTags) {
                if (vPlayerTag.getBuiltIn()) {
                    if (vPlayerTag.getPlayerCount() + playerTagVo.getSearch().getPlayerIds().size() > vPlayerTag.getQuantity()) {
                        map.put("isFull",true);
                        map.put("playerCount",vPlayerTag.getPlayerCount());
                        map.put("quantity",vPlayerTag.getQuantity());
                        return map;
                    }
                }
            }
        }

       super.getService().saveTag(playerTagVo);
       return getVoMessage(playerTagVo);
    }

    //endregion your codes 3

}