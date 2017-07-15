package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.net.ServletTool;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.player.IPlayerGameOrderService;
import so.wwb.gamebox.mcenter.player.form.PlayerGameOrderForm;
import so.wwb.gamebox.mcenter.player.form.PlayerGameOrderSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.master.enums.GameOrderStateEnum;
import so.wwb.gamebox.model.master.player.po.PlayerApiOrder;
import so.wwb.gamebox.model.master.player.po.PlayerGameOrder;
import so.wwb.gamebox.model.master.player.po.UserPlayer;
import so.wwb.gamebox.model.master.player.so.PlayerGameOrderSo;
import so.wwb.gamebox.model.master.player.vo.PlayerGameOrderListVo;
import so.wwb.gamebox.model.master.player.vo.PlayerGameOrderVo;
import so.wwb.gamebox.model.master.player.vo.UserPlayerVo;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by cheery on 15-7-2.
 */
@Controller
@RequestMapping("/playerSingleRecord")
public class PlayerSingleRecordController extends BaseCrudController<IPlayerGameOrderService, PlayerGameOrderListVo, PlayerGameOrderVo, PlayerGameOrderSearchForm, PlayerGameOrderForm, PlayerGameOrder, Integer> {
    public static String SINGLE_RECORD_URI = "/player/view.include/SingleRecord";
    public static String SINGLE_RECORD_LIST_URI = "/player/singleRecord/SingleRecordList";
    //public static String MORE_RECORD_URI = "/player/singleRecord/MoreRecord";

    @Override
    protected String getViewBasePath() {
        return null;
    }

    @RequestMapping("/singleRecord")
    public String singleRecord(Model model, PlayerGameOrderListVo listVo, Integer playerId, HttpServletRequest request) {
        listVo.getSearch().setPlayerId(playerId);
        if (StringTool.isBlank(listVo.getSearch().getOrderState())) {
            listVo.getSearch().setOrderState(GameOrderStateEnum.SETTLE.getCode());
        }
        querySingleRecord(model, listVo);//查询交易记录
        //更新最新查询交易时间
        Date date = SessionManager.getDate().getNow();
        UserPlayerVo userPlayerVo = new UserPlayerVo();
        UserPlayer player = new UserPlayer();
        player.setTransactionSynTime(date);
        player.setId(playerId);
        userPlayerVo.setResult(player);
        getService().refreshSynTime(userPlayerVo);
        model.addAttribute("synTime", date);
        return ServletTool.isAjaxSoulRequest(request) ? SINGLE_RECORD_LIST_URI : SINGLE_RECORD_URI;
    }

    /**
     * 查询交易记录列表
     *
     * @param model
     * @param listVo
     * @param so
     * @return
     */
    @RequestMapping("/singleRecordList")
    public String singleRecordList(Model model, PlayerGameOrderListVo listVo, @ModelAttribute PlayerGameOrderSo so) {
        listVo.setSearch(so);
        querySingleRecord(model, listVo);
        return SINGLE_RECORD_LIST_URI;
    }

    /**
     * 查询玩家信息-交易记录
     */
    public void querySingleRecord(Model model, PlayerGameOrderListVo listVo) {
        Date endTime = SessionManager.getDate().getNow();
        //默认显示近90天
        if (listVo.getSearch().getBeginBetTime() == null) {
            listVo.getSearch().setBeginBetTime(DateTool.addDays(endTime, -90));
        }
        if (listVo.getSearch().getEndBetTime() == null) {
            listVo.getSearch().setEndBetTime(endTime);
        }
        String _startTime = LocaleDateTool.formatDate(listVo.getSearch().getBeginBetTime(),
                CommonContext.getDateFormat().getDAY_SECOND(), SessionManager.getTimeZone());
        String _endTime = LocaleDateTool.formatDate(listVo.getSearch().getEndBetTime(),
                CommonContext.getDateFormat().getDAY_SECOND(), SessionManager.getTimeZone());
        model.addAttribute("startTime", _startTime);
        model.addAttribute("endTime", _endTime);
        Map total = getService().queryTotalSingle(listVo);
        SysUserVo vo = new SysUserVo();
        vo.getSearch().setId(listVo.getSearch().getPlayerId());
        vo = ServiceTool.sysUserService().get(vo);
        model.addAttribute("total", total);
        model.addAttribute("player", vo.getResult());
        List<PlayerApiOrder> playerApiOrders = getService().queryPlayerApiOrder(listVo);
        listVo.getPaging().setTotalCount(getService().queryPlayerApiOrderCount(listVo));
        model.addAttribute("playerApiOrders", playerApiOrders);
        model.addAttribute("listVo", listVo);
    }

 /*   *//**
     * 查看更多记录
     *
     * @param model
     * @param listVo
     * @param playerId
     * @param request
     * @return
     *//*
    @RequestMapping("/moreRecord")
    public String moreRecord(Model model, PlayerGameOrderListVo listVo, Integer playerId, HttpServletRequest request) {
        listVo.getSearch().setPlayerId(playerId);
        Date endTime = DateTool.truncate(SessionManager.getDate().getToday(), Calendar.DAY_OF_MONTH);
        listVo.getSearch().setBeginCreateTime(DateTool.addDays(endTime, -90));
        listVo.getSearch().setEndCreateTime(endTime);
        listVo.getPaging().setTotalCount(getService().queryPlayerApiOrderCount(listVo));
        listVo.getPaging().cal();
        listVo.setPlayerApiOrders(getService().queryPlayerApiOrder(listVo));
        model.addAttribute("command", listVo);
        return ServletTool.isAjaxSoulRequest(request) ? MORE_RECORD_URI + "Partial" : MORE_RECORD_URI;
    }
*/

    /**
     * 刷新同步时间
     *
     * @param model
     * @param playerId
     * @param objVo
     * @return
     */
    @RequestMapping("/refresh")
    @ResponseBody
    public boolean refresh(Model model, Integer playerId, UserPlayerVo objVo) {
        Date date = SessionManager.getDate().getNow();
        UserPlayer player = new UserPlayer();
        player.setTransactionSynTime(date);
        player.setId(playerId);
        objVo.setResult(player);
        boolean success = getService().refreshSynTime(objVo);
        return success;
    }
}
