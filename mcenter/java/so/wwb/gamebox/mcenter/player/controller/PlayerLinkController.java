package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.dict.DictTool;
import org.soul.commons.net.ServletTool;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.listop.ListOpTool;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.player.IVUserPlayerService;
import so.wwb.gamebox.mcenter.enmus.ListOpEnum;
import so.wwb.gamebox.mcenter.player.form.VUserPlayerForm;
import so.wwb.gamebox.mcenter.player.form.VUserPlayerSearchForm;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.master.operation.vo.RakebackBillVo;
import so.wwb.gamebox.model.master.operation.vo.RebateBillVo;
import so.wwb.gamebox.model.master.player.po.VUserPlayer;
import so.wwb.gamebox.model.master.player.vo.VUserPlayerListVo;
import so.wwb.gamebox.model.master.player.vo.VUserPlayerVo;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.util.Map;

/**
 * 玩家管理（主要用于外部链接）
 * Created by fei on 16-5-31.
 */
@Controller
@RequestMapping("/player/link")
public class PlayerLinkController extends BaseCrudController<IVUserPlayerService, VUserPlayerListVo, VUserPlayerVo, VUserPlayerSearchForm, VUserPlayerForm, VUserPlayer, Integer> {

    @Override
    protected String getViewBasePath() {
        return "/player/Index";
    }

    /**
     * 返水玩家
     */
    @RequestMapping("/rakeback")
    public String rakebackPlayers(RakebackBillVo vo, HttpServletRequest request, Model model) {
        // 获取玩家列表
        VUserPlayerListVo listVo = ServiceTool.vUserPlayerService().searchRakebackPlayers(vo);
        // 处理页面参数
        setPageParam(listVo, model);
        // 返回页面
        return getPageUrl(request);
    }

    /**
     * 返佣玩家
     */
    @RequestMapping("/rebate")
    public String rebatePlayers(RebateBillVo vo, HttpServletRequest request, Model model) {
        // 获取玩家列表
        VUserPlayerListVo listVo = ServiceTool.vUserPlayerService().searchRebatePlayers(vo);
        // 处理页面参数
       setPageParam(listVo, model);
        // 返回页面
        return getPageUrl(request);
    }

    /**
     * 处理页面参数
     * @param listVo VUserPlayerListVo
     */
    private void setPageParam(VUserPlayerListVo listVo, Model model) {
        Map allListFields = ListOpTool.getFields(ListOpEnum.VUserPlayerListVo);
        listVo.setAllFieldLists(allListFields);
        if (allListFields != null) {
            model.addAttribute("list", allListFields.values());
        }
        Map<String, Serializable> status = DictTool.get(DictEnum.PLAYER_STATUS);
        model.addAttribute("playerStatus", status);
        model.addAttribute("hasReturn", true);
        model.addAttribute("command", listVo);
    }

    /**
     * 返回跳转链接
     * @param request HttpServletRequest
     * @return url
     */
    private String getPageUrl(HttpServletRequest request) {
        if (ServletTool.isAjaxSoulRequest(request)) {
            return getViewBasePath() + "Partial";
        } else {
            return getViewBasePath();
        }
    }

}
