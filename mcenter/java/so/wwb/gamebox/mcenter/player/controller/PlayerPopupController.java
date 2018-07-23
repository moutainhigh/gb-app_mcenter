package so.wwb.gamebox.mcenter.player.controller;


import org.soul.commons.bean.BeanTool;
import org.soul.commons.bean.IEntity;
import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionQueryTool;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateFormat;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
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
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.player.IUserPlayerService;
import so.wwb.gamebox.iservice.master.player.IVUserPlayerService;
import so.wwb.gamebox.mcenter.player.form.VUserPlayerForm;
import so.wwb.gamebox.mcenter.player.form.VUserPlayerSearchForm;
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

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.*;

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
        if (listVo.getComp() != null && listVo.getComp() == 1) {      // 新增存款玩家
            listVo = ServiceSiteTool.vUserPlayerService().queryOutLinkPlayer(listVo);
        } else if (listVo.getComp() != null && listVo.getComp() == 2) { // 存款玩家
            listVo = ServiceSiteTool.vUserPlayerService().queryOutLinkRechargePlayer(listVo);
        } else if (listVo.getComp() != null && listVo.getComp() == 3) { // 投注玩家
            listVo = ServiceSiteTool.vUserPlayerService().queryOutLinkBetPlayer(listVo);
        } else if (listVo.getComp() != null && listVo.getComp() == 4) { // 代理新进分析/总存款玩家
            listVo = ServiceSiteTool.vUserPlayerService().queryTotalDepositPlayer(listVo);
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
            }
        }
    }

    /**
     * 初使化查询条件
     * @param vo
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
    }
}

