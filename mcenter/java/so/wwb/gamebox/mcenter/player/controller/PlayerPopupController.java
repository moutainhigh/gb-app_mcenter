package so.wwb.gamebox.mcenter.player.controller;


import org.soul.commons.bean.BeanTool;
import org.soul.commons.bean.IEntity;
import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionQueryTool;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.collections.ListTool;
import org.soul.commons.collections.MapTool;
import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateFormat;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.IpTool;
import org.soul.commons.net.ServletTool;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.Paging;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.query.sort.Direction;
import org.soul.commons.query.sort.Order;
import org.soul.commons.security.Base36;
import org.soul.commons.security.CryptoTool;
import org.soul.commons.security.key.CryptoKey;
import org.soul.commons.support._Module;
import org.soul.commons.validation.form.PasswordRule;
import org.soul.iservice.taskschedule.ITaskScheduleService;
import org.soul.model.listop.po.SysListOperator;
import org.soul.model.listop.vo.SysListOperatorListVo;
import org.soul.model.log.audit.enums.OpMode;
import org.soul.model.log.audit.enums.OpType;
import org.soul.model.log.audit.vo.BaseLog;
import org.soul.model.log.audit.vo.LogVo;
import org.soul.model.msg.notice.po.NoticeContactWay;
import org.soul.model.msg.notice.po.VNoticeSendText;
import org.soul.model.msg.notice.vo.NoticeLocaleTmpl;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.model.msg.notice.vo.VNoticeReceivedTextVo;
import org.soul.model.msg.notice.vo.VNoticeSendTextListVo;
import org.soul.model.security.privilege.po.SysUser;
import org.soul.model.security.privilege.po.SysUserProtection;
import org.soul.model.security.privilege.po.SysUserStatus;
import org.soul.model.security.privilege.vo.SysUserProtectionVo;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.model.sys.po.SysAuditLog;
import org.soul.model.sys.po.SysDict;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.so.SysAuditLogSo;
import org.soul.model.sys.vo.SysAuditLogListVo;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.model.taskschedule.po.TaskSchedule;
import org.soul.model.taskschedule.vo.TaskScheduleVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.listop.ListOpTool;
import org.soul.web.session.RedisSessionDao;
import org.soul.web.session.SessionManagerBase;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import so.wwb.gamebox.common.dubbo.ServiceScheduleTool;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.player.IUserPlayerService;
import so.wwb.gamebox.iservice.master.player.IVUserPlayerService;
import so.wwb.gamebox.iservice.master.report.IPlayerRecommendAwardService;
import so.wwb.gamebox.mcenter.enmus.ListOpEnum;
import so.wwb.gamebox.mcenter.player.form.*;
import so.wwb.gamebox.mcenter.report.controller.AuditLogController;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.share.form.SysListOperatorForm;
import so.wwb.gamebox.model.*;
import so.wwb.gamebox.model.boss.enums.ExportFileTypeEnum;
import so.wwb.gamebox.model.boss.enums.TemplateCodeEnum;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.common.Const;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.common.notice.enums.AutoNoticeEvent;
import so.wwb.gamebox.model.common.notice.enums.ManualNoticeEvent;
import so.wwb.gamebox.model.company.risk.po.RiskManagementCheck;
import so.wwb.gamebox.model.company.risk.vo.RiskManagementCheckVo;
import so.wwb.gamebox.model.company.setting.po.SysExport;
import so.wwb.gamebox.model.company.setting.vo.SysExportVo;
import so.wwb.gamebox.model.company.site.po.SiteCurrency;
import so.wwb.gamebox.model.company.site.vo.SiteLanguageListVo;
import so.wwb.gamebox.model.company.vo.BankListVo;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.listop.FilterRow;
import so.wwb.gamebox.model.listop.FilterSelectConstant;
import so.wwb.gamebox.model.listop.FreezeType;
import so.wwb.gamebox.model.listop.TabTypeEnum;
import so.wwb.gamebox.model.master.enums.*;
import so.wwb.gamebox.model.master.fund.po.PlayerWithdraw;
import so.wwb.gamebox.model.master.fund.vo.PlayerWithdrawListVo;
import so.wwb.gamebox.model.master.fund.vo.PlayerWithdrawVo;
import so.wwb.gamebox.model.master.operation.po.PlayerAdvisoryRead;
import so.wwb.gamebox.model.master.operation.vo.PlayerAdvisoryReadVo;
import so.wwb.gamebox.model.master.player.enums.PlayerAdvisoryEnum;
import so.wwb.gamebox.model.master.player.enums.PlayerRiskDataTypeEnum;
import so.wwb.gamebox.model.master.player.enums.UserAgentEnum;
import so.wwb.gamebox.model.master.player.enums.UserBankcardTypeEnum;
import so.wwb.gamebox.model.master.player.po.*;
import so.wwb.gamebox.model.master.player.so.VUserPlayerSo;
import so.wwb.gamebox.model.master.player.vo.*;
import so.wwb.gamebox.model.master.report.vo.PlayerRecommendAwardListVo;
import so.wwb.gamebox.model.master.report.vo.VPlayerTransactionListVo;
import so.wwb.gamebox.model.master.setting.po.FieldSort;
import so.wwb.gamebox.model.master.setting.po.RakebackSet;
import so.wwb.gamebox.model.master.setting.vo.NoticeTmplVo;
import so.wwb.gamebox.model.master.setting.vo.RakebackSetListVo;
import so.wwb.gamebox.model.master.setting.vo.RakebackSetVo;
import so.wwb.gamebox.model.master.tasknotify.vo.UserTaskReminderVo;
import so.wwb.gamebox.model.report.vo.AddLogVo;
import so.wwb.gamebox.web.BussAuditLogTool;
import so.wwb.gamebox.web.RiskTagTool;
import so.wwb.gamebox.web.SessionManagerCommon;
import so.wwb.gamebox.web.bank.BankHelper;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;
import so.wwb.gamebox.web.fund.form.BtcBankcardForm;
import so.wwb.gamebox.web.shiro.common.filter.KickoutFilter;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.*;

/**
 * Created by kobe on 18-6-28.
 */

@Controller
@RequestMapping(value = "/player/popup")
public class PlayerPopupController extends BaseCrudController<IVUserPlayerService, VUserPlayerListVo, VUserPlayerVo, VUserPlayerSearchForm, VUserPlayerForm, VUserPlayer, Integer> {

    private static final Log LOG = LogFactory.getLog(PlayerPopupController.class);

    @Override
    protected String getViewBasePath() {
        return "/player/popup/";
    }

    @Override
    protected VUserPlayerListVo doList(VUserPlayerListVo listVo, VUserPlayerSearchForm form, BindingResult result, Model model) {

        Map<String, Serializable> status = DictTool.get(DictEnum.PLAYER_STATUS);
        status.remove(PlayerStatusEnum.ACCOUNTEXPIRED.getCode());
        model.addAttribute("playerStatus", status);
        model.addAttribute("tagIds",listVo.getSearch().getTagId());
        model.addAttribute("operateIp", listVo.getSearch().getIp());
        model.addAttribute("validateRule", JsRuleCreator.create(VUserPlayerSearchForm.class));

        /*玩家检测真实姓名*/
        if (listVo.getSearch().isHasReturn() && StringTool.isNotBlank(listVo.getSearch().getRealName())) {
            try {
                String realName = URLDecoder.decode(listVo.getSearch().getRealName(), Const.DEFAULT_CHARACTER);
                listVo.getSearch().setRealName(realName);
            } catch (UnsupportedEncodingException e) {
                LOG.error(e, "玩家检测页面--解码真实姓名");
            }
        }
        listVo = ServiceSiteTool.vUserPlayerService().countTransfer(listVo);
        return listVo;
    }

    /**
     * 玩家列表
     */
    @RequestMapping("/doData")
    @ResponseBody
    protected VUserPlayerListVo doData(VUserPlayerListVo listVo, VUserPlayerSearchForm form, BindingResult result, Model model) {
        if (result.hasErrors()) {
            LOG.info("站点ID{0}玩家列表查询验证有误", SessionManager.getSiteId());
        }
        // 玩家检测页面IP登录记录,筛选玩家
        playerDetection(listVo, model);
        // 初始化外部链接时间
        initDate(listVo);
        //标签管理,筛选有该标签的玩家
        getPlayerByTagId(listVo, model);

        initRemarkContent(listVo);
        //查询该玩家有的标签
        getTagIdByPlayer(listVo, model);
        // 不同的链接得到不同的玩家列表
        VUserPlayerListVo list = getListVo(listVo);
        //处理页面模板化数据
        handlePageData(list);
        return list;
    }


    /**
     * 处理页面模板化数据
     *
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
            }
        }
    }

    @RequestMapping("/count")
    public String count(VUserPlayerListVo listVo, Model model,@RequestParam("page") String page) {
        if(listVo.isSuccess()){
            Paging paging = JsonTool.fromJson(page, Paging.class);
            listVo.setPaging(paging);
            model.addAttribute("command", listVo);
        }
        return getViewBasePath() + "IndexPagination";
    }


    private void initRemarkContent(VUserPlayerListVo listVo) {
        if (StringTool.isNotBlank(listVo.getSearch().getRemarkContent())) {
            RemarkVo remarkVo = new RemarkVo();
            remarkVo.getSearch().setRemarkContent(listVo.getSearch().getRemarkContent());
            List<Integer> integers = ServiceTool.getRemarkService().searchPlayerRemark(remarkVo);
            if (integers != null && integers.size() > 0) {
                List<Integer> ids = listVo.getSearch().getIds();
                //可能其它条件已经有了IDS查询条件
                if (ids != null && ids.size() > 0) {
                    for (Integer id : integers) {
                        if (id != null && !ids.contains(id)) {
                            ids.add(id);
                        }
                    }
                } else {
                    listVo.getSearch().setIds(integers);
                }
            } else {
                //为了查不出数据
                integers = new ArrayList<>();
                integers.add(0);
                listVo.getSearch().setIds(integers);
            }
        }
    }

    /**
     * 标签管理,筛选有该标签的玩家
     *
     * @param listVo
     * @param model
     */
    private void getPlayerByTagId(VUserPlayerListVo listVo, Model model) {
        if (StringTool.isNotBlank(listVo.getSearch().getTagId())) {
            PlayerTagListVo playerTagListVo = new PlayerTagListVo();
            playerTagListVo.getSearch().setTagId(Integer.valueOf(listVo.getSearch().getTagId()));
            List playerIds = ServiceSiteTool.playerTagService().searchPlayerIdByTagId(playerTagListVo);

            listVo.getSearch().setIds(playerIds);
        }
        model.addAttribute("tagIds", listVo.getSearch().getTagId());
    }

    //该玩家有的标签
    private void getTagIdByPlayer(VUserPlayerListVo listVo, Model model) {
        List userPlayerId = ServiceSiteTool.playerTagService().searchTagIdByPlayerId(listVo);
        listVo.getSearch().setUserTagIds(userPlayerId);
    }

    /**
     * 玩家检测页面IP登录记录,筛选玩家
     * add by Bruce.QQ
     */
    private void playerDetection(VUserPlayerListVo listVo, Model model) {
        VUserPlayerSo vuserPlayerSo = listVo.getSearch();
        if (StringTool.isNotBlank(vuserPlayerSo.getIp())) {
            SysAuditLogSo sysAuditLogSo = new SysAuditLogSo();
            sysAuditLogSo.setOperateIp(Long.valueOf(vuserPlayerSo.getIp()));
            sysAuditLogSo.setModuleType(ModuleType.PASSPORT_LOGIN.getCode());
            sysAuditLogSo.setOperatorUserType(UserTypeEnum.PLAYER.getCode());
            List<Integer> playerIds = ServiceTool.customSysAuditLogService().searchOperatorIdByIp(sysAuditLogSo);
            vuserPlayerSo.setIds(playerIds);

        }

        if (vuserPlayerSo.isHasReturn() && StringTool.isNotBlank(vuserPlayerSo.getRealName())) {
            try {
                String realName = URLDecoder.decode(vuserPlayerSo.getRealName(), Const.DEFAULT_CHARACTER);
                vuserPlayerSo.setRealName(realName);
            } catch (UnsupportedEncodingException e) {
                LOG.error(e, "玩家检测页面--解码真实姓名");
            }
        }
    }

    /**
     * 初始化外部链接时间
     */
    private void initDate(VUserPlayerListVo listVo) {
        Integer outer = listVo.getOuter() == null ? 0 : listVo.getOuter();
        if (outer != 0) {
            if (listVo.getSearch().getCreateTimeBegin() != null && listVo.getSearch().getCreateTimeEnd() != null) {
                return;
            }
            Date today = SessionManager.getDate().getToday();
            Date now = SessionManager.getDate().getNow();
            Date weekStartDate = WeekTool.getWeekStartDate(today,null);
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
                    Date lastMonthFirstDay = SessionManager.getDate().getLastMonthFirstDay(SessionManager.getTimeZone());
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

    /**
     * 不同的链接得到不同的玩家列表
     */
    private VUserPlayerListVo getListVo(VUserPlayerListVo listVo) {
        int rawOffset = SessionManager.getTimeZone().getRawOffset();
        int hour = rawOffset / 1000 / 3600;
        listVo.getSearch().setTimeZoneInterval(hour);
        Integer comp = listVo.getComp();
        if (comp != null) {
            if (comp == 1) {    // 新增玩家的存款玩家
                listVo = ServiceSiteTool.vUserPlayerService().queryOutLinkPlayer(listVo);
            } else if (comp == 2) { // 存款玩家
                listVo = ServiceSiteTool.vUserPlayerService().queryOutLinkRechargePlayer(listVo);
            } else if (comp == 3) { // 投注玩家
                listVo = ServiceSiteTool.vUserPlayerService().queryOutLinkBetPlayer(listVo);
            }
        } else {
            if (listVo.isAnalyzeNewAgent()) {
                Integer searchType = listVo.getSearchType();
                if (searchType != null) {
                    if (searchType == 1) {
                        listVo = ServiceSiteTool.vUserPlayerService().queryTotalDepositPlayer(listVo);
                    } else if (searchType == 2) {
                        resetFormatTime(listVo);
                        List<Integer> player = ServiceSiteTool.vUserPlayerService().queryEffectivePlayer(listVo);
                        //玩家id不能为空
                        if (CollectionTool.isEmpty(player)) {
                            player.add(-1);
                        }
                        listVo.getSearch().setIds(player);
                    } else {
                        resetFormatTime(listVo);
                        List<Integer> player = ServiceSiteTool.vUserPlayerService().queryDepositPlayer(listVo);
                        if (CollectionTool.isEmpty(player)) {
                            player.add(-1);
                        }
                        listVo.getSearch().setIds(player);
                    }
                }

            }
            listVo = ServiceSiteTool.vUserPlayerService().searchByCustom(listVo);
        }
        return listVo;
    }

    /**
     * 时间格式更改
     *
     * @param listVo
     * @return
     */
    private VUserPlayerListVo resetFormatTime(VUserPlayerListVo listVo) {
        Date startStaticTime = listVo.getStartTime();
        if (startStaticTime != null) {
            Date date = DateTool.addHours(startStaticTime, listVo.getSearch().getTimeZoneInterval());
            listVo.setStartTime(date);
        }

        Date endStaticTime = listVo.getEndTime();
        if (endStaticTime != null) {
            Date date = DateTool.addHours(endStaticTime, listVo.getSearch().getTimeZoneInterval());
            listVo.setEndTime(date);
        }

        return listVo;
    }
    //endregion
}

