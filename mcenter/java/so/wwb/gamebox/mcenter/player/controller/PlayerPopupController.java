package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateFormat;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.query.Paging;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.iservice.master.player.IVUserPlayerService;
import so.wwb.gamebox.mcenter.player.form.VUserPlayerForm;
import so.wwb.gamebox.mcenter.player.form.VUserPlayerSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.WeekTool;
import so.wwb.gamebox.model.master.player.po.VUserPlayer;
import so.wwb.gamebox.model.master.player.vo.VUserPlayerListVo;
import so.wwb.gamebox.model.master.player.vo.VUserPlayerVo;
import so.wwb.gamebox.web.RiskTagTool;
import so.wwb.gamebox.web.SessionManagerCommon;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

/**
 * Created by kobe on 18-6-28.
 */
@Controller
@RequestMapping(value = "/player/popup")
public class PlayerPopupController extends BaseCrudController<IVUserPlayerService, VUserPlayerListVo, VUserPlayerVo,
        VUserPlayerSearchForm, VUserPlayerForm, VUserPlayer, Integer> {

    private static final Log LOG = LogFactory.getLog(PlayerPopupController.class);

    @Override
    protected String getViewBasePath() {
        return "/player/popup/";
    }

    /**
     * 玩家列表页数据查询
     * @param listVo
     * @param form
     * @param result
     * @param model
     * @return
     */
    @RequestMapping("/doData")
    @ResponseBody
    protected VUserPlayerListVo doData(VUserPlayerListVo listVo, VUserPlayerSearchForm form, BindingResult result, Model model) {
        initCondition(listVo);
        // 不同的链接得到不同的玩家列表
        VUserPlayerListVo list = getListVo(listVo);
        handlePageData(list);
        return list;
    }

    /**
     * 分页统计
     * @param listVo
     * @param model
     * @param page
     * @return
     */
    @RequestMapping("/count")
    public String count(VUserPlayerListVo listVo, Model model,@RequestParam("page") String page) {
        if(listVo.isSuccess()){
            Paging paging = JsonTool.fromJson(page, Paging.class);
            listVo.setPaging(paging);
            model.addAttribute("command", listVo);
        }
        return getViewBasePath() + "IndexPagination";
    }

    /**
     * 不同的链接得到不同的玩家列表
     */
    private VUserPlayerListVo getListVo(VUserPlayerListVo listVo) {
        int rawOffset = SessionManager.getTimeZone().getRawOffset();
        int hour = rawOffset / 1000 / 3600;
        listVo.getSearch().setTimeZoneInterval(hour);
        if (listVo.getComp() != null && listVo.getComp() == 1) {        // 代理分析/新增玩家查询
            listVo = ServiceSiteTool.vUserPlayerService().queryNewPlayer(listVo);
        } else if (listVo.getComp() != null && listVo.getComp() == 2) { // 代理分析/新增存款玩家查询
            listVo = ServiceSiteTool.vUserPlayerService().queryTotalDepositPlayer(listVo);
        } else if (listVo.getComp() != null && listVo.getComp() == 3) { // 首页/新增存款玩家
            listVo = ServiceSiteTool.vUserPlayerService().queryOutLinkPlayer(listVo);
        } else if (listVo.getComp() != null && listVo.getComp() == 4) { // 首页/存款总人数
            listVo = ServiceSiteTool.vUserPlayerService().queryOutLinkRechargePlayer(listVo);
        } else if (listVo.getComp() != null && listVo.getComp() == 5) { // 首页/投注玩家
            listVo = ServiceSiteTool.vUserPlayerService().queryOutLinkBetPlayer(listVo);
        } else {
            listVo = ServiceSiteTool.vUserPlayerService().searchByCustom(listVo);
        }
        return listVo;
    }

    /**
     * 处理页面模板化数据
     * @param listVo
     */
    private void handlePageData(VUserPlayerListVo listVo) {
        Integer orderNumber = (listVo.getPaging().getPageNumber() - 1) * listVo.getPaging().getPageSize();
        Map<String, Map<String, String>> views = I18nTool.getI18nMap(SessionManagerCommon.getLocale().toString()).get("views");
        Map<String, Map<String, Map<String, String>>> dictsMap = I18nTool.getDictsMap(SessionManagerCommon.getLocale().toString());
        DateFormat dateFormat = new DateFormat();
        TimeZone timeZone = SessionManagerCommon.getTimeZone();
        if (CollectionTool.isNotEmpty(listVo.getResult())) {
            List<VUserPlayer> result = listVo.getResult();
            for (VUserPlayer player : result) {
                player.set_views_player_auto_defaultagent(views.get("player_auto").get("默认代理"));
                player.set_views_player_auto_dangerousRank(views.get("player_auto").get("危险层级"));
                player.set_views_player_auto_backgroundCreatePlayer(views.get("player_auto").get("后台新增玩家"));
                player.set_views_role_playerOnline(views.get("role").get("player.list.icon.online"));
                player.set_dicts_player_player_status(dictsMap.get("player").get("player_status").get(player.getPlayerStatus()));
                player.set_dicts_common_currency_symbol(dictsMap.get("common").get("currency_symbol").get(player.getDefaultCurrency()));
                player.set_views_common_edit(views.get("common").get("edit"));
                player.set_views_common_detail(views.get("common").get("detail"));

                player.set_soulFn_formatInteger_walletBalance(CurrencyTool.formatInteger(player.getWalletBalance()));
                player.set_soulFn_formatDecimals_walletBalance(CurrencyTool.formatDecimals(player.getWalletBalance()));

                player.set_soulFn_formatInteger_totalAssets(CurrencyTool.formatInteger(player.getTotalAssets()));
                player.set_soulFn_formatDecimals_totalAssets(CurrencyTool.formatDecimals(player.getTotalAssets()));

                player.set_soulFn_formatInteger_rechargeTotal(CurrencyTool.formatInteger(player.getRechargeTotal()));
                player.set_soulFn_formatDecimals_rechargeTotal(CurrencyTool.formatDecimals(player.getRechargeTotal()));

                player.set_soulFn_formatInteger_txTotal(CurrencyTool.formatInteger(player.getTxTotal()));
                player.set_soulFn_formatDecimals_txTotal(CurrencyTool.formatDecimals(player.getTxTotal()));

                player.set_soulFn_formatDateTz_loginTime(LocaleDateTool.formatDate(player.getLoginTime(), dateFormat.getDAY_SECOND(), timeZone));
                player.set_soulFn_formatDateTz_createTime(LocaleDateTool.formatDate(player.getCreateTime(), dateFormat.getDAY_SECOND(), timeZone));
                player.set_soulFn_formatDateTz_createTimeDay(LocaleDateTool.formatDate(player.getCreateTime(), dateFormat.getDAY(), timeZone));
                player.set_views_riskDataType(RiskTagTool.getRiskImg(player.getId()));
                orderNumber++;
                player.set_paging_orderNumber(orderNumber);
                /*清空玩家联系方式*/
                player.setMail(null);
                player.setMobilePhone(null);
                player.setSkype(null);
                player.setMsn(null);
                player.setQq(null);
                player.setWeixin(null);
            }
        }
    }

    /**
     * 初使化查询条件
     * @param listVo
     */
    private void initCondition(VUserPlayerListVo listVo) {
        // 玩家账号查询条件
        if (StringTool.isNotBlank(listVo.getSearch().getUsername())) {
            String[] split = listVo.getSearch().getUsername().split(",");
            if (split.length == 1) {
                listVo.getSearch().setUsername(split[0]);
                listVo.getSearch().setUsernames(null);
            } else {
                listVo.getSearch().setUsernames(split);
                listVo.getSearch().setUsername(null);
            }
        }

        // 玩家注册时间过滤条件处理
        if (listVo.getStartTime() != null) {
            if (listVo.getSearch().getCreateTimeBegin() == null
                    || listVo.getSearch().getCreateTimeBegin().before(listVo.getStartTime())) {
                listVo.getSearch().setCreateTimeBegin(listVo.getStartTime());
            }
        }
        if (listVo.getEndTime() != null) {
            if (listVo.getSearch().getCreateTimeEnd() == null
                    || listVo.getSearch().getCreateTimeEnd().after(listVo.getEndTime()))
                listVo.getSearch().setCreateTimeEnd(listVo.getEndTime());
        }

        Integer outer = listVo.getOuter() == null ? 0 : listVo.getOuter();
        if (outer != 0) {
            if (listVo.getSearch().getCreateTimeBegin() != null && listVo.getSearch().getCreateTimeEnd() != null) {
                return;
            }
            Date today = SessionManager.getDate().getToday();
            Date now = SessionManager.getDate().getNow();
            Date weekStartDate = WeekTool.getWeekStartDate(today, null);
            Date monthStartDate = WeekTool.getMonthStartDate(today);
            switch (outer) {
                case 1: // 今日
                    listVo.getSearch().setCreateTimeBegin(today);
                    listVo.getSearch().setCreateTimeEnd(now);
                    break;
                case 2: // 昨日
                case 11:
                    listVo.getSearch().setCreateTimeBegin(SessionManager.getDate().getYestoday());
                    listVo.getSearch().setCreateTimeEnd(today);
                    break;
                case 3: // 本周
                    listVo.getSearch().setCreateTimeBegin(weekStartDate);
                    listVo.getSearch().setCreateTimeEnd(today);
                    break;
                case 4: // 上周
                    listVo.getSearch().setCreateTimeBegin(DateTool.addDays(weekStartDate, -7));
                    listVo.getSearch().setCreateTimeEnd(weekStartDate);
                    break;
                case 5: // 本月
                    listVo.getSearch().setCreateTimeBegin(monthStartDate);
                    listVo.getSearch().setCreateTimeEnd(today);
                    break;
                case 6: // 上月
                    Date lastMonthFirstDay = SessionManager.getDate().getLastMonthFirstDay(SessionManager.getTimeZone
                            ());
                    listVo.getSearch().setCreateTimeBegin(lastMonthFirstDay);
                    listVo.getSearch().setCreateTimeEnd(monthStartDate);
                    break;
                case 12: // 前天
                    listVo.getSearch().setCreateTimeBegin(DateTool.addDays(today, -2));
                    listVo.getSearch().setCreateTimeEnd(SessionManager.getDate().getYestoday());
                    break;
                case 13: // 大前天
                    listVo.getSearch().setCreateTimeBegin(DateTool.addDays(today, -3));
                    listVo.getSearch().setCreateTimeEnd(DateTool.addDays(today, -2));
                    break;
                case 14: // 大大前天
                    listVo.getSearch().setCreateTimeBegin(DateTool.addDays(today, -4));
                    listVo.getSearch().setCreateTimeEnd(DateTool.addDays(today, -3));
                    break;
                case 15: // 大大大前天
                    listVo.getSearch().setCreateTimeBegin(DateTool.addDays(today, -5));
                    listVo.getSearch().setCreateTimeEnd(DateTool.addDays(today, -4));
                    break;
                case 16: // 大大大大前天
                    listVo.getSearch().setCreateTimeBegin(DateTool.addDays(today, -6));
                    listVo.getSearch().setCreateTimeEnd(DateTool.addDays(today, -5));
                    break;
                case 17: // 大大大大大前天
                    listVo.getSearch().setCreateTimeBegin(DateTool.addDays(today, -7));
                    listVo.getSearch().setCreateTimeEnd(DateTool.addDays(today, -6));
                    break;
            }
        }
    }
}

