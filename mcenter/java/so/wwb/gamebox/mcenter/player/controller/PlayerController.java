package so.wwb.gamebox.mcenter.player.controller;


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
import org.soul.model.msg.notice.po.VNoticeSendText;
import org.soul.model.msg.notice.vo.*;
import org.soul.model.security.privilege.po.SysUser;
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
 * Created by tony on 15-6-4.
 */

@Controller
@RequestMapping(value = "/player")
public class PlayerController extends BaseCrudController<IVUserPlayerService, VUserPlayerListVo, VUserPlayerVo, VUserPlayerSearchForm, VUserPlayerForm, VUserPlayer, Integer> {
    public static final int REPLAY_COUNT = 50;

    /*比特币*/
    public static final String BITCOIN = "bitcoin";

    @Autowired
    private RedisSessionDao redisSessionDao;

    private static final Log LOG = LogFactory.getLog(PlayerController.class);
    private static final String PLAYER_VIEW_URI = "/player/view.include/PlayerView";
    private static final String PLAYER_INFO_URI = "/player/view.include/PlayerInfo";
    private static final String ADDRESS_URI = "/player/view.include/Address";
    private static final String BANK_CARD_URI = "/player/view.include/BankCard";
    private static final String COLLECT_URI = "/player/view.include/Collect";
    private static final String INTEGRATE_URI = "/player/view.include/Integrate";
    private static final String JOURNAL_URI = "/player/view.include/Journal";
    private static final String MORE_JOURNAL_URI = "/player/view.include/more/JournalMore";

    private static final String NEWS_URI = "/player/advisory/News";
    private static final String SALE_URI = "/player/view.include/Sale";
    private static final String SINGLE_RECORD_URI = "/player/view.include/SingleRecord";
    private static final String READ_PLAYER_REQUEST = "/player/view.include/ReadPlayerRequest";
    private static final String ENCRYPT_DATA_URI = "/player/EncryptData";
    private static final String CLEAR_CONTACT_INFO_URI = "/player/ClearContactInfo";
    private static final String DISABLE_ACCOUNT = "/player/player/moreoperate/DisabledAccount";
    private static final String DISABLE_URL = "/player/player/moreoperate/Disabled";
    private static final String DISABLE_PREVIEW = "/player/player/moreoperate/DisablePreview";
    private static final String OFFLINE_FORCED = "/player/player/moreoperate/OfflineForced";
    private static final String OFFLINE_PREVIEW = "/player/player/moreoperate/OfflinePreview";
    private static final String SEND_MESSAGE_CHOOSE_TYPE_URI = "/player/sendMessage/chooseType";
    private static final String SEND_MESSAGE_CONTENT_URI = "/player/sendMessage/editContent";
    private static final String VUSER_PLAYER_VIEW = "/player/vuserplayer/Edit";
    private static final String VUSER_EDITLABEL_VIEW = "/player/vuserplayer/EditLabel";

    private static final String MORE_ADVISORY_URI = "/player/advisory/MoreAdvisory";
    private static final String MORE_ADVISORYREPLY_URI = "/player/advisory/MoreAdvisoryReply";

    private static final String ADDRESS_EDIT_URI = "/player/view.include/AddressEdit";
    private static final String BANK_CARD_EDIT_URI = "/player/view.include/BankCardEdit";
    private static final String BTC_EDIT_URI = "/player/view.include/BtcEdit";
    private static final String UPDATE_REAL_NAME = "/player/view.include/UpdateRealName";

    /*返水方案*/
    private static final String RAKEBACK_INDEX = "player/player/rakeback/Index";

    private static final String EDIT_RISK_LABEL = "/player/risk/EditRiskLabel";

    private String root;

    public String getRoot() {
        return root;
    }

    public void setRoot(String root) {
        this.root = root;
    }


    @Override
    protected VUserPlayerListVo doList(VUserPlayerListVo listVo, VUserPlayerSearchForm form, BindingResult result, Model model) {

        Map<String, Serializable> status = DictTool.get(DictEnum.PLAYER_STATUS);
        status.remove(PlayerStatusEnum.ACCOUNTEXPIRED.getCode());
        model.addAttribute("playerStatus", status);
        VPlayerTagListVo vPlayerTagListVo = new VPlayerTagListVo();
        long count = ServiceSiteTool.vPlayerTagService().count(vPlayerTagListVo);
        vPlayerTagListVo.getPaging().setPageSize((int) count);
        //新增的语句
        String templateCode = TemplateCodeEnum.PLAYER.getCode();
        model.addAttribute("searchTempCode", templateCode);
        model.addAttribute("searchTemplates", CacheBase.getSysSearchTempByCondition(SessionManager.getUserId(), templateCode));
        List<Pair> userTypeSearchKeys = initUserTypeSearchKeys();
        model.addAttribute("userTypeSearchKeys", userTypeSearchKeys);
        model.addAttribute("playerRanks", ServiceSiteTool.playerRankService().queryUsableList(new PlayerRankVo()));
        model.addAttribute("playerTag", ServiceSiteTool.vPlayerTagService().search(vPlayerTagListVo));
        model.addAttribute("rakebackSet", getService().getRakebackSet(new UserPlayerVo()).getRakebackSet());
        model.addAttribute("tagSet", ServiceSiteTool.playerTagService().search(new PlayerTagListVo()).getResult());
        String queryParamsJson = JsonTool.toJson(listVo.getSearch());
        model.addAttribute("queryParamsJson", queryParamsJson);
        model.addAttribute("validateRule", JsRuleCreator.create(VUserPlayerSearchForm.class));
        //查自己站点sys_param表的param_value值
        SysParam sysParam = getExportParam();
        model.addAttribute("queryparamValue", sysParam);
        // 玩家检测注册IP
        listVo = ServiceSiteTool.vUserPlayerService().countTransfer(listVo);
        model.addAttribute("operateIp", listVo.getSearch().getIp());
        model.addAttribute("hasReturn", listVo.getSearch().isHasReturn());
        model.addAttribute("tagIds",listVo.getSearch().getTagId());

        //获得字典中的风控标识列表
        Map<String, SysDict> riskDicts = DictTool.get(DictEnum.PLAYER_RISK_DATA_TYPE);
        model.addAttribute("riskDicts", riskDicts);

        /*玩家检测真是姓名*/
        if (listVo.getSearch().isHasReturn() && StringTool.isNotBlank(listVo.getSearch().getRealName())) {
            try {
                String realName = URLDecoder.decode(listVo.getSearch().getRealName(), Const.DEFAULT_CHARACTER);
                listVo.getSearch().setRealName(realName);
            } catch (UnsupportedEncodingException e) {
                LOG.error(e, "玩家检测页面--解码真实姓名");
            }
        }
        if (("old").equals(listVo.getSearch().getVersion())) {
            setRoot("/player/Old");
        } else {
            setRoot("/player/");
        }
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

        /*
        * 登录ip和注册ip模糊查询
        *
        * */
        listVo = buildSearchIp(listVo);
        if(!listVo.isSuccess()){
            return listVo;
        }

        // 玩家检测页面IP登录记录,筛选玩家
        playerDetection(listVo, model);
        // 初始化外部链接时间
        initDate(listVo);

        //标签管理,筛选有该标签的玩家
        getPlayerByTagId(listVo, model);
        initRemarkContent(listVo);
        //条件查询根据标签查询玩家
        getTagIdByPlayer(listVo, model);
        // 不同的链接得到不同的玩家列表
        VUserPlayerListVo list = getListVo(listVo);
        // 玩家筛选
        playeFilter(model, list);

        handlePageData(list);
        return list;
    }
    /*
    * 根据登录ip和注册ip模糊查询
    * */
    private VUserPlayerListVo buildSearchIp(VUserPlayerListVo listVo){

        if(StringTool.isNotBlank(listVo.getSearch().getRegisterIpv4())){
            Map regMap = fetchStartEndIp(listVo.getSearch().getRegisterIpv4());
            if(!MapTool.getBoolean(regMap,"state")){
                listVo.setSuccess(false);
                return listVo;
            }
            String min = MapTool.getString(regMap, "min");
            listVo.getSearch().setRegisterStartIp(min);
            String max = MapTool.getString(regMap, "max");
            listVo.getSearch().setRegisterEndIp(max);
        }
        if(StringTool.isNotBlank(listVo.getSearch().getLastLoginIpv4())){
            Map loginMap = fetchStartEndIp(listVo.getSearch().getLastLoginIpv4());
            if(!MapTool.getBoolean(loginMap,"state")){
                listVo.setSuccess(false);
                return listVo;
            }
            String loginMin = MapTool.getString(loginMap, "min");
            listVo.getSearch().setLoginStartIp(loginMin);
            String loginmax = MapTool.getString(loginMap, "max");
            listVo.getSearch().setLoginEndIp(loginmax);
        }
        return listVo;
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

    public SysParam getExportParam() {
        SysParamVo sysParamVo = new SysParamVo();
        //sysParamVo._setDataSourceId(sysParamVo._getSiteId());//设置数据源为各个站点
        sysParamVo.getSearch().setModule(SiteParamEnum.SITE_PLAYER_EXPORT.getModule().getCode());//设置查询条件的值
        sysParamVo.getSearch().setParamType(SiteParamEnum.SITE_PLAYER_EXPORT.getType());
        sysParamVo.getSearch().setParamCode(SiteParamEnum.SITE_PLAYER_EXPORT.getCode());
        List<SysParam> sysParams = ServiceTool.getSysParamService().byCodeAndActive(sysParamVo);//查询并返回结果
        if (!sysParams.isEmpty()) {
            SysParam sysParam = sysParams.get(0);
            return sysParam;
        }
        return null;
    }

    private List<Pair> initUserTypeSearchKeys() {
        List<Pair> searchKeys;
        searchKeys = new ArrayList<>();
        searchKeys.add(new Pair("search.username", LocaleTool.tranView(Module.COLUMN.getCode(), "playerAccount")));
        searchKeys.add(new Pair("search.agentName", LocaleTool.tranView(Module.COLUMN.getCode(), "agentAccount")));
        searchKeys.add(new Pair("search.generalAgentName", LocaleTool.tranView(Module.COLUMN.getCode(), "agentTopAccount")));
        return searchKeys;
    }

    private void initRemarkContent(VUserPlayerListVo listVo) {
        if (StringTool.isNotBlank(listVo.getSearch().getRemarkContent())) {
            RemarkVo remarkVo = new RemarkVo();
            remarkVo.getSearch().setRemarkContent(listVo.getSearch().getRemarkContent());
            List<Integer> integers = ServiceTool.getRemarkService().searchPlayerRemark(remarkVo);
            if (integers != null && integers.size() > 0) {
                List<Integer> ids = listVo.getSearch().getIds();
                //可能其它条件已经不了IDS查询条件
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
     * //标签管理,筛选有该标签的玩家
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

    //条件查询查询有该标签的玩家
    private void getTagIdByPlayer(VUserPlayerListVo listVo, Model model) {
        List userPlayerId = ServiceSiteTool.playerTagService().searchTagIdByPlayerId(listVo);
        listVo.getSearch().setUserTagIds(userPlayerId);
    }

    /*
    * 验证ip是否合法
    * */
    @RequestMapping("/doMsg")
    @ResponseBody
    protected Map msg(String ip) {
        return fetchStartEndIp(ip);
    }

   /*
    * 获取模糊查询IP的开始和结束IP
    * */
    private Map fetchStartEndIp(String ip) {
        Map<String,Object> maps=new HashMap<>();
        maps.put("state", false);
        if (StringTool.isNotBlank(ip)) {
            String[] ips = ip.split("[.]");
            if(ips.length!=4){
                return maps;
            }
            String minIp = "";
            String maxIp = "";
            for (String s : ips) {
                Map map = testIp(s);
                String min = MapTool.getString(map, "min");
                String max = MapTool.getString(map, "max");
                minIp += min + ".";
                maxIp += max + ".";
            }
            if (minIp.endsWith(".")) {
                minIp = minIp.substring(0, minIp.length() - 1);
            }
            if (maxIp.endsWith(".")) {
                maxIp = maxIp.substring(0, maxIp.length() - 1);
            }
            if (IpTool.isValidIpv4(maxIp)) {
                maps.put("max",maxIp);
                maps.put("min",minIp);
                maps.put("state", true);
            } else {
                maps.put("state", false);
            }
        }
        return maps;
    }




    private static Map testIp(String ip) {
        Map ipMap = new HashMap();
        if (StringTool.isBlank(ip)) {
            return ipMap;
        }
        if (ip.indexOf("*") > -1) {
            ipMap.put("min", "0");
            ipMap.put("max", "255");
        } else if (ip.indexOf("?") > -1) {
            if (ip.length() == 3) {
                //IP小段为3位
                dealIp3(ip, ipMap);
            } else {
                ipMap.put("min", ip.replaceAll("[?]", "0"));
                ipMap.put("max", ip.replaceAll("[?]", "9"));
            }


        } else {
            ipMap.put("min", ip);
            ipMap.put("max", ip);
        }
        return ipMap;
    }
    /*
    * 模糊查询ip小段为3位数
    * */
    private static void dealIp3(String ip, Map ipMap) {
        if ("???".equals(ip)) {
            ipMap.put("min", "0");
            ipMap.put("max", "255");
        } else if (ip.endsWith("??")) {
            ipMap.put("min", ip.replaceAll("[?]", "0"));
            String firstIp = ip.substring(0, 1);
            if ("2".equals(firstIp)) {
                ipMap.put("max", ip.replaceAll("[?]", "5"));
            } else {
                ipMap.put("max", ip.replaceAll("[?]", "9"));
            }

        } else if (ip.endsWith("?")) {
            ipMap.put("min", ip.replaceAll("[?]", "0"));
            String firstIp = ip.substring(0, 1);
            String secondIp = ip.substring(1, 2);
            if (firstIp.equals("2") && secondIp.equals("5")) {
                ipMap.put("max", ip.replaceAll("[?]", "5"));
            } else {
                ipMap.put("max", ip.replaceAll("[?]", "9"));
            }
        } else if (ip.startsWith("?", 1)) {
            String firstIp = ip.substring(0, 1);
            ipMap.put("min", ip.replaceAll("[?]", "0"));
            if ("2".equals(firstIp)) {
                ipMap.put("max", ip.replaceAll("[?]", "2"));
            } else {
                ipMap.put("max", ip.replaceAll("[?]", "9"));
            }
        }
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
//        listVo = ServiceSiteTool.vUserPlayerService().countTransfer(listVo);
        return listVo;
    }

    /**
     * 筛选玩家
     */
    private void playeFilter(Model model, VUserPlayerListVo list) {
        Map allListFields = ListOpTool.getFields(ListOpEnum.VUserPlayerListVo);
        list.setAllFieldLists(allListFields);
        if (allListFields != null) {
            model.addAttribute("list", allListFields.values());
        }
    }

    /**
     * 添加修改玩家标签
     * Created by orange
     *
     * @param objectVo
     * @param model
     * @return
     */
    @RequestMapping("/editLabel")
    public String editLabel(VUserPlayerVo objectVo, Model model) {
        objectVo = this.getService().editLabel(objectVo);
        model.addAttribute("validateRule", JsRuleCreator.create(PlayerTagForm.class));
        model.addAttribute("command", objectVo);
        return VUSER_EDITLABEL_VIEW;
    }

    /**
     * 保存玩家标签
     *
     * @param objectVo
     * @return
     */
    @RequestMapping("/saveLabel")
    @ResponseBody
    public Map saveLabel(UserPlayerVo objectVo) {

        if (StringTool.isNotBlank(objectVo.getTagsIdStr()) && objectVo.isVip()) {
            List<Integer> ids = convertIdToInteger(objectVo.getTagsIdStr());
            VPlayerTagListVo vPlayerTagListVo = new VPlayerTagListVo();
            vPlayerTagListVo.setPropertyValues(ids);
            List<VPlayerTag> vPlayerTags = ServiceSiteTool.vPlayerTagService().inSearchById(vPlayerTagListVo);
            Map<String, Object> map = new HashMap<>(3);
            for (VPlayerTag vPlayerTag : vPlayerTags) {
                if (vPlayerTag.getBuiltIn()) {
                    if (vPlayerTag.getPlayerCount() + 1 > vPlayerTag.getQuantity()) {
                        map.put("isFull", true);
                        map.put("playerCount", vPlayerTag.getPlayerCount());
                        map.put("quantity", vPlayerTag.getQuantity());
                        return map;
                    }
                }
            }
        }

        objectVo = this.getService().saveLabel(objectVo);
        return this.getVoMessage(objectVo);
    }

    private List<Integer> convertIdToInteger(String ids) {
        String[] idarray = StringTool.split(ids, ",");
        List<Integer> rids = null;
        if (idarray != null && idarray.length > 0) {
            rids = new ArrayList<>();
            for (int i = 0; i < idarray.length; i++) {
                Integer temp = Integer.parseInt(idarray[i]);
                rids.add(temp);
            }
        }
        return rids;
    }


    /**
     * 消息群发
     *
     * @return
     */
    @RequestMapping(value = "/sendMessage", method = RequestMethod.GET)
    public String sendMessage(String ids, Model model) {
        model.addAttribute("ids", ids);
        return SEND_MESSAGE_CHOOSE_TYPE_URI;
    }

    /**
     * 发邮件
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/sendEmail", method = RequestMethod.GET)
    public String sendEmail(Model model, String ids, UserPlayerVo userPlayerVo, SysUserVo sysUserVo) {
        final Map<String, Object> data = parseSelectPlayerData(ids, userPlayerVo, sysUserVo);
        model.addAttribute("title", "email");
        model.addAttribute("data", data);
        return SEND_MESSAGE_CONTENT_URI;
    }

    /**
     * 获取玩家的一些数据
     *
     * @param ids
     * @param userPlayerVo
     * @return
     */
    private Map<String, Object> parseSelectPlayerData(String ids, UserPlayerVo userPlayerVo, SysUserVo sysUserVo) {
        final HashMap<String, Object> data = new HashMap<>(4);
        /*if (StringUtils.isNoneBlank(ids)) {
            final String[] idArr = ids.split(",");

            final List<Object> allIds = new ArrayList();
            final List<Object> alls = new ArrayList();
            final List<Object> bads = new ArrayList();
            final List<Object> badIds = new ArrayList();
            for (String id : idArr) {
                allIds.add(id);
                SysUser sysUser = new SysUser(Integer.parseInt(id));
                sysUserVo.setResult(sysUser);
                SysUser dbSysUser = ServiceSiteTool.sysUserService().get(sysUserVo).getResult();
                userPlayerVo.setResult(new UserPlayer(Integer.parseInt(id)));
                UserPlayer player = ServiceSiteTool.userPlayerService().get(userPlayerVo).getResult();
                if (StringUtils.isBlank(player.getMail())) {
                    bads.add(dbSysUser.getUsername());
                    badIds.add(id);
                }
                alls.add(dbSysUser.getUsername());
                data.put("alls", alls);
                data.put("bads", bads);
                data.put("allIds", allIds);
                data.put("badIds", badIds);
            }
        }*/
        //TODO 玩家表删除重叠字段
        return data;
    }

    /**
     * 发站内信
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/sendStationLetter", method = RequestMethod.GET)
    public String sendStationLetter(Model model) {
        model.addAttribute("title", "stationLetter");
        return SEND_MESSAGE_CONTENT_URI;
    }

    /**
     * 嵌入在玩家列表的玩家信息详情页
     *
     * @return
     */
    @RequestMapping("/playerView")
    public String playerView(VUserPlayerVo vUserPlayerVo, Model model, Boolean ajax) {
        /*queryDetail(vUserPlayerVo, model);
        return (ajax != null && ajax) ? PLAYER_INFO_URI : PLAYER_VIEW_URI;*/
        return playerDetail(vUserPlayerVo, model);
    }

    private VUserPlayerVo queryDetail(VUserPlayerVo vUserPlayerVo, Model model) {
        vUserPlayerVo = doView(vUserPlayerVo, model);
        model.addAttribute("extendedLinks", vUserPlayerVo.getExtendedLinks());
        vUserPlayerVo.setPlayerRankList(ServiceSiteTool.playerRankService().queryUsableList(new PlayerRankVo()));
        model.addAttribute("command", vUserPlayerVo);
        //站内信
        message(vUserPlayerVo, model);

        //统计优惠次数和优惠金额
        //countFavorableNumAndMoney(vUserPlayerVo.getSearch().getId(), model);
        fetchPlayerBackwater(vUserPlayerVo);
        return vUserPlayerVo;
    }

    private void fetchPlayerBackwater(VUserPlayerVo vUserPlayerVo) {
        VPlayerTransactionListVo transactionListVo = new VPlayerTransactionListVo();
        transactionListVo.getSearch().setUsername(vUserPlayerVo.getResult().getUsername());
        Map<String, Object> stringObjectMap = ServiceSiteTool.vPlayerTransactionService().queryPlayerRakebackAmount(transactionListVo);
        if (stringObjectMap.get("totalMoney") != null) {
            Double totalMoney = MapTool.getDouble(stringObjectMap, "totalMoney");
            vUserPlayerVo.getResult().setRakeback(totalMoney);
        }

    }

    private String playerDetail(VUserPlayerVo vUserPlayerVo, Model model) {
        vUserPlayerVo = queryDetail(vUserPlayerVo, model);
        //vUserPlayerVo = fetchTotalProfitLoss(vUserPlayerVo);
//        vUserPlayerVo = fetchTotalTradeAmount(vUserPlayerVo);
//        vUserPlayerVo = fetchTotalEffectTradeAmount(vUserPlayerVo);
        //代理修改日志
        SysAuditLogListVo sysAuditLogListVo = new SysAuditLogListVo();
        sysAuditLogListVo.getSearch().setEntityUserId(vUserPlayerVo.getSearch().getId());
        sysAuditLogListVo.getSearch().setModuleType(ModuleType.PLAYER_UPDATEAGENTLINE_SUCCESS.getCode());
        sysAuditLogListVo = ServiceSiteTool.auditLogService().queryLogs(sysAuditLogListVo);
        List logList = sysAuditLogListVo.getResult();
        if (logList != null && logList.size() > 0) {
            model.addAttribute("sysAuditLog", logList.get(0));
        }
        //风控修改日志
        SysAuditLogListVo riskLogListVo = new SysAuditLogListVo();
        riskLogListVo.getSearch().setEntityUserId(vUserPlayerVo.getSearch().getId());
        riskLogListVo.getSearch().setModuleType(ModuleType.PLAYER_RISK_SUCCESS.getCode());
        riskLogListVo.getPaging().setPageSize(1);
        riskLogListVo.getQuery().addOrder(SysAuditLog.PROP_OPERATE_TIME, Direction.DESC);
        riskLogListVo = ServiceSiteTool.auditLogService().queryLogs(riskLogListVo);
        List riskLogList = riskLogListVo.getResult();
        if (riskLogList != null && riskLogList.size() > 0) {
            model.addAttribute("riskLog", riskLogList.get(0));
        }

        //银行卡列表
        model.addAttribute("userbankcards", BankHelper.queryUserBanksByUserId(vUserPlayerVo.getSearch().getId(), UserBankcardTypeEnum.TYPE_BANK, 5));
        model.addAttribute("btnBanks", BankHelper.queryUserBanksByUserId(vUserPlayerVo.getSearch().getId(), UserBankcardTypeEnum.TYPE_BTC, 5));
        model.addAttribute("bitcoinParam", ParamTool.getSysParam(SiteParamEnum.SETTING_WITHDRAW_TYPE_IS_BITCOIN));
        model.addAttribute("cashParam", ParamTool.getSysParam(SiteParamEnum.SETTING_WITHDRAW_TYPE_IS_CASH));

        Map map = queryPlayerRecomd(vUserPlayerVo);
        model.addAttribute("playerRecomd", map);

        VPlayerAdvisoryListVo listVo = queryPlayerAdvisory(vUserPlayerVo);
        if (listVo != null && listVo.getResult() != null) {
            model.addAttribute("playerAdvisoryCount", listVo.getResult().size());
        }
        Map<String, Serializable> status = DictTool.get(DictEnum.PLAYER_STATUS);
        status.remove(PlayerStatusEnum.ACCOUNTEXPIRED.getCode());
        model.addAttribute("playerStatus", status);
        model.addAttribute("unencryption", SessionManager.checkPrivilegeStatus());
        PlayerWithdraw playerWithdraw = fetchWithdrawRecord(vUserPlayerVo.getSearch().getId());
        if (playerWithdraw != null) {
            model.addAttribute("playerWithdraw", playerWithdraw);
        }

        RemarkListVo playerListVo = new RemarkListVo();
        playerListVo.getSearch().setEntityUserId(vUserPlayerVo.getSearch().getId());
        playerListVo.getPaging().setPageSize(10);
        //playerListVo.getSearch().setRemarkType(RemarkEnum.PLAYER_REMARK.getType());
        RemarkListVo remarkListVo = queryUserRemark(playerListVo);
        model.addAttribute("remarkListVo", remarkListVo);
        model.addAttribute("isLotterySite", ParamTool.isLotterySite());
        SysUserProtectionVo sysUserProtectionVo = new SysUserProtectionVo();
        sysUserProtectionVo.getSearch().setId(vUserPlayerVo.getSearch().getId());
        SysUserProtectionVo protectionVo = ServiceTool.sysUserProtectionService().get(sysUserProtectionVo);
        model.addAttribute("saferQuestion", protectionVo);
        //风控标识
        UserPlayerVo userPlayerVo = new UserPlayerVo();
        userPlayerVo.getSearch().setId(vUserPlayerVo.getSearch().getId());
        userPlayerVo = ServiceSiteTool.userPlayerService().get(userPlayerVo);
        getRisk2Set(userPlayerVo);
        model.addAttribute("riskDataType", userPlayerVo.getResult()!=null?userPlayerVo.getResult().getRiskDataType():null);
        model.addAttribute("riskSet", userPlayerVo.getResult()!=null?userPlayerVo.getResult().getRiskSet():null);

        return "/player/view.include/PlayerDetail";
    }

    @RequestMapping("/bindBtcByManager")
    @ResponseBody
    @Token(valid = true)
    public Map bindBtcByManager(UserBankcardVo userBankcardVo, @FormModel @Valid BtcBankcardForm form, BindingResult result) {
        if (result.hasErrors() || userBankcardVo.getResult().getUserId() == null) {
            LOG.info("管理{0}操作比特币,用户{1},地址为空", SessionManagerCommon.getUserName(), userBankcardVo.getResult().getUserId());
            userBankcardVo.setSuccess(false);
            return getVoMessage(userBankcardVo);
        }
        UserBankcard userBankcard = userBankcardVo.getResult();
        userBankcard.setType(UserBankcardTypeEnum.BITCOIN.getCode());
        userBankcard.setBankName(BITCOIN);
        LOG.info("管理{0}操作用户绑定比特币,用户{1},绑定地址{2}", SessionManagerBase.getUserName(), userBankcard.getBankcardNumber());
        userBankcardVo = ServiceSiteTool.userBankcardService().saveAndUpdateUserBankcard(userBankcardVo);
        return getVoMessage(userBankcardVo);
    }

    private VUserPlayerVo fetchTotalProfitLoss(VUserPlayerVo vUserPlayerVo) {
        PlayerApiVo playerApiVo = new PlayerApiVo();
        playerApiVo.getSearch().setPlayerId(vUserPlayerVo.getSearch().getId());
        double totalAssets = vUserPlayerVo.getResult().getTotalAssets() == null ? 0d : vUserPlayerVo.getResult().getTotalAssets();
        Double txTotal = vUserPlayerVo.getResult().getTxTotal() == null ? 0d : vUserPlayerVo.getResult().getTxTotal();
        Double rechargeTotal = vUserPlayerVo.getResult().getRechargeTotal() == null ? 0d : vUserPlayerVo.getResult().getRechargeTotal();
        PlayerWithdrawListVo withdrawListVo = new PlayerWithdrawListVo();
        withdrawListVo.getSearch().setPlayerId(vUserPlayerVo.getSearch().getId());
        Double manualWithdraw = ServiceSiteTool.playerWithdrawService().calManualWithdraw(withdrawListVo);
        PlayerTransactionListVo transactionListVo = new PlayerTransactionListVo();
        transactionListVo.getSearch().setPlayerId(vUserPlayerVo.getSearch().getId());
        Double otherDepoist = ServiceSiteTool.getPlayerTransactionService().calOtherDeposit(transactionListVo);
        LOG.info("总资产：{0}，玩家取款总额：{1}，手动取款：{2}，存款总额：{3}，其它存款：{4}", totalAssets, txTotal, manualWithdraw, rechargeTotal, otherDepoist);
        double profitLoss = totalAssets + txTotal + manualWithdraw - rechargeTotal - otherDepoist;
        BigDecimal b = new BigDecimal(profitLoss);
        profitLoss = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        LOG.info("总盈亏计算结果：{0}", profitLoss);
        vUserPlayerVo.getResult().setTotalProfitLoss(profitLoss);
        return vUserPlayerVo;
    }

    @RequestMapping("/querySingleAndEffective")
    @ResponseBody
    public String querySingleAndEffective(VUserPlayerVo vUserPlayerVo) {
        PlayerGameOrderVo gameOrderVo = new PlayerGameOrderVo();
        gameOrderVo.getSearch().setPlayerId(vUserPlayerVo.getSearch().getId());
        Map<String, Object> map = ServiceSiteTool.playerGameOrderService().querySingleAndEffectiveAmount(gameOrderVo);
        return JsonTool.toJson(map);
    }


    private VUserPlayerVo fetchTotalTradeAmount(VUserPlayerVo vUserPlayerVo) {
        PlayerGameOrderVo gameOrderVo = getPlayerGameOrderVo(vUserPlayerVo);
        Double aDouble = ServiceSiteTool.playerGameOrderService().calSingleAmountByPlayerId(gameOrderVo);
        vUserPlayerVo.getResult().setTotalTradeVolume(aDouble);
        return vUserPlayerVo;
    }

    private PlayerGameOrderVo getPlayerGameOrderVo(VUserPlayerVo vUserPlayerVo) {
        PlayerWithdrawVo withdrawVo = new PlayerWithdrawVo();
        withdrawVo.getSearch().setPlayerId(vUserPlayerVo.getSearch().getId());
        PlayerWithdraw withdraw = ServiceSiteTool.playerWithdrawService().getNewAuditedWithdraw(withdrawVo);
        PlayerGameOrderVo gameOrderVo = new PlayerGameOrderVo();
        gameOrderVo.getSearch().setPlayerId(vUserPlayerVo.getSearch().getId());
        if (withdraw != null) {//
            gameOrderVo.getSearch().setPayoutTime(withdraw.getCreateTime());
        }
        return gameOrderVo;
    }

    private VUserPlayerVo fetchTotalEffectTradeAmount(VUserPlayerVo vUserPlayerVo) {
        PlayerGameOrderVo gameOrderVo = getPlayerGameOrderVo(vUserPlayerVo);
        Double aDouble = ServiceSiteTool.playerGameOrderService().calEffectiveAmountByPlayerId(gameOrderVo);
        vUserPlayerVo.getResult().setTotalEffectiveVolume(aDouble);
        /*PlayerWithdrawVo withdrawVo = new PlayerWithdrawVo();
        withdrawVo.getSearch().setPlayerId(vUserPlayerVo.getSearch().getId());
        PlayerWithdraw withdraw = ServiceSiteTool.playerWithdrawService().getNewAuditedWithdraw(withdrawVo);
        PlayerTransactionVo transactionVo = new PlayerTransactionVo();
        transactionVo.getSearch().setPlayerId(vUserPlayerVo.getSearch().getId());
        if(withdraw!=null){
            transactionVo.getSearch().setCreateTime(withdraw.getCreateTime());
        }
        Double aDouble = ServiceSiteTool.getPlayerTransactionService().calPlayerEffectTradeAmount(transactionVo);
        vUserPlayerVo.getResult().setTotalEffectiveVolume(aDouble);*/
        return vUserPlayerVo;
    }


    private PlayerWithdraw fetchWithdrawRecord(Integer userId) {
        PlayerWithdrawVo playerWithdrawVo = new PlayerWithdrawVo();
        playerWithdrawVo.setResult(new PlayerWithdraw());
        playerWithdrawVo.getSearch().setPlayerId(userId);
        List<PlayerWithdraw> playerWithdraws = ServiceSiteTool.playerWithdrawService().queryWithdrawingRecord(playerWithdrawVo);
        PlayerWithdraw playerWithdraw = null;
        if (playerWithdraws != null && playerWithdraws.size() > 0) {
            playerWithdraw = playerWithdraws.get(0);
            /*for(PlayerWithdraw playerWithdraw : playerWithdraws){
                if(playerWithdraw.getWithdrawAmount()!=null){
                    amount += playerWithdraw.getWithdrawActualAmount();
                }
            }*/
        }
        return playerWithdraw;
    }

    private RemarkListVo queryUserRemark(RemarkListVo listVo) {
        if (listVo.getSearch().getEntityUserId() == null) {
            return listVo;
        }
        if (listVo.getSearch().getFromCount() == null) {
            listVo.getSearch().setFromCount(0);
        }
        //listVo.getSearch().setPageSize(playerListVo.getPaging().getPageSize());
        //listVo.getSearch().setEntityUserId(playerListVo.getSearch().getId());
        listVo = ServiceTool.getRemarkService().searchByPaging(listVo); //
        RemarkListVo search = ServiceTool.getRemarkService().search(listVo);
        listVo.setPaging(search.getPaging());
        return listVo;
    }

    private UserBankcardListVo queryUserBankcard(VUserPlayerVo vUserPlayerVo) {
        UserBankcardListVo listVo = new UserBankcardListVo();
        if (vUserPlayerVo.getSearch().getId() == null) {
            return listVo;
        }
        listVo.getSearch().setUserId(vUserPlayerVo.getSearch().getId());
        listVo.getPaging().setPageSize(10);
        listVo = ServiceSiteTool.userBankcardService().search(listVo);
        return listVo;
    }

    //玩家推荐数
    private Map queryPlayerRecomd(VUserPlayerVo vUserPlayerVo) {
        if (vUserPlayerVo.getSearch().getId() == null) {
            return null;
        }
        IPlayerRecommendAwardService service = ServiceSiteTool.playerRecommendAwardService();
        PlayerRecommendAwardListVo listVo = new PlayerRecommendAwardListVo();
        listVo.getSearch().setStartTime(SessionManager.getDate().getYestoday());
        listVo.getSearch().setEndTime(SessionManager.getDate().getToday());
        listVo.getSearch().setUserId(vUserPlayerVo.getSearch().getId());
        Map map = service.searchCountAndAmountAndRebate(listVo);
        return map;
    }

    //玩家咨询数
    private VPlayerAdvisoryListVo queryPlayerAdvisory(VUserPlayerVo vUserPlayerVo) {
        if (vUserPlayerVo.getSearch().getId() == null) {
            return null;
        }
        VPlayerAdvisoryListVo listVo = new VPlayerAdvisoryListVo();
        listVo.getSearch().setAdvisoryTime(DateTool.addMonths(SessionManager.getDate().getNow(), -1));
        listVo.getSearch().setPlayerId(vUserPlayerVo.getSearch().getId());
        listVo.getSearch().setStatus(true);
        listVo.getSearch().setQuestionType(PlayerAdvisoryEnum.QUESTION.getCode());
        listVo = ServiceSiteTool.vPlayerAdvisoryService().search(listVo);
        return listVo;
    }


    /**
     * 玩家信息详情页-显示局部隐藏的字段
     *
     * @return
     */
    @RequestMapping("/playerViewDetail")
    @ResponseBody
    public Map playerViewDetail(VUserPlayerVo vUserPlayerVo, Model model, Boolean ajax) {
        Map map = new HashMap();
        map.put("playerId", vUserPlayerVo.getSearch().getId());
        map.put("state", true);
        return map;
        /**/


        /*vUserPlayerVo = doView(vUserPlayerVo, model);
        model.addAttribute("extendedLinks", vUserPlayerVo.getExtendedLinks());
        model.addAttribute("command", vUserPlayerVo);
        //站内信
        message(vUserPlayerVo, model);

        //统计优惠次数和优惠金额
        countFavorableNumAndMoney(vUserPlayerVo.getSearch().getId(), model);

        model.addAttribute("unencryption", SessionManager.checkPrivilegeStatus());
        return (ajax != null && ajax) ? PLAYER_INFO_URI : PLAYER_VIEW_URI;*/
    }

    @RequestMapping("/showPersonalData")
    public String showPersonalData(VUserPlayerVo vUserPlayerVo, Model model) {
        vUserPlayerVo = doView(vUserPlayerVo, model);
        model.addAttribute("unencryption", SessionManager.checkPrivilegeStatus());
        model.addAttribute("command", vUserPlayerVo);
        return "/player/view.include/PlayerPersonalData";
    }

    /**
     * 玩家信息详情页-修改真实姓名-弹窗
     *
     * @return
     */
    @RequestMapping("/updateRealName")
    public String updateRealName(SysUserVo sysUserVo, Model model, Boolean ajax) {
        //表单校验
        model.addAttribute("validate", JsRuleCreator.create(PlayerRealNameForm.class));
        model.addAttribute("command", sysUserVo);
        return UPDATE_REAL_NAME;
    }

    /**
     * 玩家信息详情页-修改真实姓名
     *
     * @return
     */
    @RequestMapping("/editRealName")
    @Audit(module = Module.PLAYER, moduleType = ModuleType.PLAYER_REALNAME_SUCCESS, opType = OpType.UPDATE)
    @ResponseBody
    public Map editRealName(HttpServletRequest request, SysUserVo sysUserVo) {
        UserPlayerVo userPlayerVo = new UserPlayerVo();
        userPlayerVo.getSearch().setId(sysUserVo.getResult().getId());
        userPlayerVo.setRealName(sysUserVo.getResult().getRealName());
        Boolean bool = ServiceSiteTool.userPlayerService().updatePlayerRealName(userPlayerVo);
        if (bool) {
            sysUserVo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "update.success"));
            //操作日志
            //日志参数,日志vo
            List<String> list = new ArrayList<>();
            list.add(sysUserVo.getResult().getUsername());
            list.add(sysUserVo.getResult().getNickname());//旧的玩家真实姓名暂时保存在nickname中
            list.add(sysUserVo.getResult().getRealName());
            AddLogVo addLogVo = new AddLogVo();
            addLogVo.setResult(new SysAuditLog());
            addLogVo.setList(list);
            AuditLogController.addLog(request, "player.realname.success", addLogVo);
        } else {
            sysUserVo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "update.failed"));
        }
        Map map = new HashMap();
        map.put("msg", StringTool.isNotBlank(sysUserVo.getOkMsg()) ? sysUserVo.getOkMsg() : sysUserVo.getErrMsg());
        map.put("state", sysUserVo.isSuccess());
        return map;
    }

    private void message(VUserPlayerVo vUserPlayerVo, Model model) {
        VNoticeReceivedTextVo vNoticeReceivedTextVo = new VNoticeReceivedTextVo();
        vNoticeReceivedTextVo.setSearchUserId(vUserPlayerVo.getSearch().getId());
        Long length = ServiceTool.noticeService().fetchUnclaimedMsgCount(vNoticeReceivedTextVo);
        model.addAttribute("msgLength", length);

        VNoticeReceivedTextVo vnrtVo = new VNoticeReceivedTextVo();
        vnrtVo.getSearch().setId(vUserPlayerVo.getSearch().getId());
        vnrtVo.getSearch().setReceiverId(vUserPlayerVo.getSearch().getId());
        Long count = ServiceSiteTool.playerWithdrawService().sumSystemCount(vnrtVo);
        model.addAttribute("msgCount", count);
    }

    /**
     * 取消账号冻结
     *
     * @return
     */
    @RequestMapping("/cancelPlayerFrozen")
    @ResponseBody
    public Map cancelPlayerFrozen(SysUserVo vo) {
        vo.setSuccess(false);
        vo.getResult().setStatus("1");
        vo.getResult().setUpdateUser(SessionManager.getUserId());
        vo.getResult().setUpdateTime(new Date());
        vo = getService().cancelPlayerFrozen(vo);

        if (vo.isSuccess()) {
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "update.success"));
        } else {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "update.failed"));
        }
        HashMap map = new HashMap(2);
        map.put("msg", StringTool.isNotBlank(vo.getOkMsg()) ? vo.getOkMsg() : vo.getErrMsg());
        map.put("state", Boolean.valueOf(vo.isSuccess()));
        map.put("text", I18nTool.getDictsMap(SessionManager.getLocale().toString()).get(Module.PLAYER.getCode()).get(Module.PLAYER_STATUS.getCode()).get("1"));

        return map;
    }

    /**
     * 玩家详情页-删除单个标签
     *
     * @return
     */
    @RequestMapping("/deleteTag")
    @ResponseBody
    public Map deleteTag(PlayerTagVo playerTagVo) {
        Boolean bool = ServiceSiteTool.playerTagService().delete(playerTagVo);
        Map map = new HashMap();
        if (bool) {
            map.put("state", true);
        } else {
            map.put("state", false);
        }
        return map;
    }

    @Override
    protected VUserPlayerVo doView(VUserPlayerVo objectVo, Model model) {
        objectVo = this.getService().get(objectVo);
        VPlayerTagAllListVo vPlayerTagAllListVo = new VPlayerTagAllListVo();
        vPlayerTagAllListVo.getSearch().setPlayerId(objectVo.getResult().getId());
        vPlayerTagAllListVo.setPaging(null);
        vPlayerTagAllListVo = ServiceSiteTool.vPlayerTagAllService().search(vPlayerTagAllListVo);

        RemarkListVo remarkListVo = new RemarkListVo();
        remarkListVo.getSearch().setEntityUserId(objectVo.getResult().getId());
        Long remarkCount = ServiceTool.getRemarkService().count(remarkListVo);
        String freezeType = objectVo.getResult().getFreezeType();
        // 影响范围:账号停用>账号冻结  (当该玩家处于账号停用状态时，账号冻结、余额冻结、重置登录密码、重置安全密码功能禁用，呈灰色不可点击；账号停用功能正常可点击)
        // 当该玩家处于账号冻结状态时，余额冻结、重置安全密码功能禁用，呈灰色不可点击；账号冻结、账号停用、重置登录密码功能正常可点击
        Date freezeStartTime = objectVo.getResult().getFreezeStartTime();
        Date freezeEndTime = objectVo.getResult().getFreezeEndTime();
        if (FreezeType.AUTO.getCode().equals(freezeType)) {
            model.addAttribute("accountStatus", PlayerStatusEnum.ACCOUNTFREEZE.getCode());
        } else if (freezeEndTime != null && freezeStartTime != null && freezeEndTime.compareTo(new Date()) > 0 && freezeStartTime.compareTo(new Date()) < 0) {
            model.addAttribute("accountStatus", PlayerStatusEnum.ACCOUNTFREEZE.getCode());
        }
        String balanceType = objectVo.getResult().getBalanceType();
        Date balanceFreezeStartTime = objectVo.getResult().getBalanceFreezeStartTime();
        Date balanceFreezeEndTime = objectVo.getResult().getBalanceFreezeEndTime();
        if (FreezeType.AUTO.getCode().equals(freezeType)) {
            model.addAttribute("balanceStatus", PlayerStatusEnum.BALANCEFREEZE.getCode());
        } else if (balanceFreezeEndTime != null && balanceFreezeStartTime != null && balanceFreezeEndTime.compareTo(new Date()) > 0 && balanceFreezeStartTime.compareTo(new Date()) < 0) {
            model.addAttribute("balanceStatus", PlayerStatusEnum.BALANCEFREEZE.getCode());
        }

        model.addAttribute("remarkCount", remarkCount);
        model.addAttribute("vPlayerTagAllListVo", vPlayerTagAllListVo);
        String registCode = Base36.encryptIgnoreCase(objectVo.getResult().getRegistCode() + objectVo.getResult().getId());
        objectVo.getResult().setRegistCode(registCode);
        return objectVo;
    }

    /**
     * 特别关注设置
     *
     * @param userPlayerVo
     * @return
     */
    @RequestMapping("/setSpecialFocus")
    @ResponseBody
    public Map setSpecialFocus(UserPlayerVo userPlayerVo) {
        Boolean flag = ServiceSiteTool.userPlayerService().setSpecialFocus(userPlayerVo);

        if (flag) {
            userPlayerVo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_SUCCESS));
        } else {
            userPlayerVo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_FAILED));
        }
        return this.getVoMessage(userPlayerVo);
    }

    /**
     * 玩家信息详情-地址
     *
     * @return
     */
    @RequestMapping("/view/address")
    public String address(PlayerAddressListVo listVo, Model model) {
        listVo.getPaging().setPageSize(10);
        listVo = ServiceSiteTool.playerAddressService().queryAddress(listVo);
        model.addAttribute("command", listVo);
        return ADDRESS_URI;
    }

    /**
     * 玩家信息详情-修改地址
     *
     * @param objVo
     * @param model
     * @return
     */
    @RequestMapping("/view/addressEdit")
    public String addressEdit(PlayerAddressVo objVo, Model model) {
        //表单校验
        model.addAttribute("validate", JsRuleCreator.create(PlayerAddressForm.class));
        objVo.getSearch().setIsDefault(true);
        objVo = ServiceSiteTool.playerAddressService().search(objVo);
        model.addAttribute("command", objVo);
        return ADDRESS_EDIT_URI;
    }

    @RequestMapping("/view/addressSave")
    @ResponseBody
    public Map addressSave(PlayerAddressVo objVo, @FormModel @Valid PlayerAddressForm form, BindingResult result) {
        if (result.hasErrors()) {
            return null;
        }
        PlayerAddressVo _objVo = ServiceSiteTool.playerAddressService().get(objVo);
        _objVo.getResult().setIsDefault(false);
        _objVo.setProperties(PlayerAddress.PROP_IS_DEFAULT);
        _objVo = ServiceSiteTool.playerAddressService().updateOnly(_objVo);//原有默认信息更改为不默认

        //玩家地址修改即为新增一条默认地址，原有默认地址改为不默认使用
        Map<String, Map<String, String>> i18nMap = I18nTool.getDictsMap(SessionManagerBase.getLocale().toString()).get(Module.COMMON.getCode());
        objVo.getResult().setLocaleNation(i18nMap.get(DictEnum.COMMON_NATION.getType()).get(objVo.getResult().getNation()));
        objVo.getResult().setLocaleProvince(i18nMap.get(DictEnum.COMMON_PROVINCE.getType()).get(objVo.getResult().getProvince()));
        objVo.getResult().setLocaleCity(i18nMap.get(DictEnum.COMMON_CITY.getType()).get(objVo.getResult().getCity()));
        objVo.getResult().setCreateTime(SessionManager.getDate().getNow());
        objVo.getResult().setIsDefault(true);
        objVo.getResult().setUseStauts(false);
        objVo.getResult().setPlayerId(_objVo.getResult().getPlayerId());
        objVo = ServiceSiteTool.playerAddressService().insert(objVo);
        return this.getVoMessage(objVo);
    }

    /**
     * 玩家信息详情-银行卡
     *
     * @return
     */
    @RequestMapping("/view/bankCard")
    public String bankCard(UserBankcardListVo listVo, Model model) {
        listVo.getPaging().setPageSize(10);
        listVo = ServiceSiteTool.userBankcardService().search(listVo);
        model.addAttribute("bankMap", Cache.getBank());
        model.addAttribute("command", listVo);
        return BANK_CARD_URI;
    }

    @RequestMapping("/view/bankEdit")
    @Token(generate = true)
    public String bankEdit(UserBankcardVo objVo, Model model, BankListVo bankListVo) {
        UserBankcard userBankcard = BankHelper.getUserBankcard(objVo.getSearch().getUserId(), UserBankcardTypeEnum.TYPE_BANK);
        objVo.setResult(userBankcard);
        if (userBankcard == null) {
            objVo.setResult(new UserBankcard());
            objVo.getResult().setUserId(objVo.getSearch().getUserId());
        }
        model.addAttribute("command", objVo);

        model.addAttribute("bankListVo", BankHelper.getBankListVo());

        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setId(objVo.getResult().getUserId());
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        model.addAttribute("sysUser", sysUserVo.getResult());

        //表单校验
        model.addAttribute("validate", JsRuleCreator.create(UserBankcardForm.class));

        return BANK_CARD_EDIT_URI;
    }

    @RequestMapping("/view/btcEdit")
    @Token(generate = true)
    public String btcEdit(Model model, UserBankcardVo userBankcardVo) {
        model.addAttribute("validate", JsRuleCreator.create(BtcBankcardForm.class));
        UserBankcard userBankcard = BankHelper.getUserBankcard(userBankcardVo.getSearch().getUserId(), UserBankcardTypeEnum.TYPE_BTC);
        userBankcardVo.setResult(userBankcard);
        model.addAttribute("command", userBankcardVo);
        return BTC_EDIT_URI;
    }

    @RequestMapping("/view/bankCardSave")
    @Audit(module = Module.MASTER_SETTING, moduleType = ModuleType.BANKCARD_EDIT, opType = OpType.CREATE)
    @ResponseBody
    @Token(valid = true)
    public Map bankCardSave(UserBankcardVo objVo, @FormModel @Valid UserBankcardForm form, BindingResult result) {
        Map map = new HashMap();
        map.put("state", true);
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        LogVo logVo = new LogVo();
        List<String> params = new ArrayList<>();
        BaseLog baseLog = logVo.addBussLog();
        UserBankcardVo vo = new UserBankcardVo();
        VUserPlayerVo vUserPlayerVo = new VUserPlayerVo();
        addLog(objVo, request, logVo, params, baseLog, vo, vUserPlayerVo);
        UserBankcard userBankcard;
        if (result.hasErrors()) {
            map.put("state", false);
            map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
            return map;
        }
        try {
            userBankcard = objVo.getResult();
            userBankcard.setType(UserBankcardTypeEnum.BANK.getCode());
            objVo = ServiceSiteTool.userBankcardService().saveAndUpdateUserBankcard(objVo);

            map.put("state", objVo.isSuccess());
            if (!objVo.isSuccess()) {
                map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
            }
        } catch (Exception ex) {
            map.put("state", false);
            map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
            LOG.error(ex, "保存银行卡出错");
        }
        //保存银行卡成功，添加风控标识
        if (objVo.isSuccess()){
            UserBankcardVo userBankcardVo = ServiceSiteTool.userPlayerService().addRiskByBankCardNumber(objVo);
            map.put("state", userBankcardVo.isSuccess());
        }

        return map;
    }

    /**
     * 日志
     *
     * @param vUserPlayerVo
     */
    private void addLog(UserBankcardVo objVo, HttpServletRequest request, LogVo logVo, List<String> params, BaseLog baseLog, UserBankcardVo vo, VUserPlayerVo vUserPlayerVo) {
        UserBankcard userBankcard = null;
        if (objVo.getResult().getId() != null) {
            vo.getSearch().setId(objVo.getResult().getId());
            vo = ServiceSiteTool.userBankcardService().get(vo);
            userBankcard = vo.getResult();
            baseLog.setDescription("setting.bankCard.edit");
            baseLog.setOpType(OpType.UPDATE);
        } else {
            baseLog.setDescription("setting.bankCard.add");
        }
        if (userBankcard != null) {
            vUserPlayerVo.getSearch().setId(userBankcard.getUserId());
            vUserPlayerVo = ServiceSiteTool.vUserPlayerService().get(vUserPlayerVo);
            params.add(vUserPlayerVo.getResult().getUsername());
            params.add(userBankcard.getBankcardNumber());
            params.add(LocaleTool.tranDict(DictEnum.BANKNAME, userBankcard.getBankName()));
            if (userBankcard.getBankDeposit() != null && !userBankcard.getBankDeposit().equals("")) {
                params.add(userBankcard.getBankDeposit());
            } else {
                params.add(LocaleTool.tranView("player_auto", "未设置"));
            }
        }
        vUserPlayerVo.getSearch().setId(objVo.getResult().getUserId());
        vUserPlayerVo = ServiceSiteTool.vUserPlayerService().get(vUserPlayerVo);
        params.add(vUserPlayerVo.getResult().getUsername());
        params.add(objVo.getResult().getBankcardNumber());
        params.add(LocaleTool.tranDict(DictEnum.BANKNAME, objVo.getResult().getBankName()));
        if (objVo.getResult().getBankDeposit() != null && !objVo.getResult().getBankDeposit().equals("")) {
            params.add(objVo.getResult().getBankDeposit());
        } else {
            params.add(LocaleTool.tranView("player_auto", "未设置"));
        }
        AddLogVo addLogVo = new AddLogVo();
        addLogVo.setResult(new SysAuditLog());
        addLogVo.setList(params);
        for (String param : params) {
            baseLog.addParam(param);
        }
        request.setAttribute(SysAuditLog.AUDIT_LOG, logVo);
    }

  /*  @RequestMapping("/view/checkBankcardNumber")
    @ResponseBody
    public String checkBankcardNumber(@RequestParam("result.bankcardNumber") String bankcardNumber, @RequestParam("result.bankName") String bankName) {
        String flag = "false";
        BankExtendListVo listVo = new BankExtendListVo();
        listVo.setProperties(BankExtend.PROP_BANK_CARD_BEGIN);
        listVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(BankExtend.PROP_BANK_NAME, Operator.EQ, bankName)
        });
        List<String> bankCardBegin = ServiceSiteTool.bankExtendService().searchProperty(listVo);
        if (CollectionTool.isNotEmpty(bankCardBegin)) {
            for (String st : bankCardBegin) {
                if (StringTool.startsWith(bankcardNumber, st)) {
                    flag = "true";
                    break;
                }
            }
        } else {
            flag = "true";
        }
        return flag;
    }*/

    /**
     * 玩家信息详情-收藏
     *
     * @return
     */
    @RequestMapping("/view/collect")
    public String collect() {
        return COLLECT_URI;
    }

    /**
     * 玩家信息详情-积分
     *
     * @return
     */
    @RequestMapping("/view/integrate")
    public String Integrate() {
        return INTEGRATE_URI;
    }

    /**
     * 玩家信息详情-日志
     *
     * @return
     */
    @RequestMapping("/view/journal")
    public String journal(SysAuditLogListVo listVo, Model model, HttpServletRequest request) {
        if (listVo.getSearch().getOperatorBegin() == null && listVo.getSearch().getOperatorEnd() == null) {
            listVo.getSearch().setOperatorEnd(new Date());
            listVo.getSearch().setOperatorBegin(DateTool.addDays(listVo.getSearch().getOperatorEnd(), -7));
        }
        //日期不等
        if (listVo.getSearch().getOperatorBegin() != null && listVo.getSearch().getOperatorEnd() != null
                && DateTool.truncatedEquals(listVo.getSearch().getOperatorBegin(), listVo.getSearch().getOperatorEnd(), Calendar.SECOND) == false) {
            listVo.getSearch().setOperatorEnd(DateTool.addDays(listVo.getSearch().getOperatorEnd(), +1));
        }
        //日期相等
        if (listVo.getSearch().getOperatorBegin() != null && listVo.getSearch().getOperatorEnd() != null && DateTool.truncatedCompareTo(listVo.getSearch().getOperatorBegin(), listVo.getSearch().getOperatorEnd(), Calendar.SECOND) == 0) {
            listVo.getSearch().setOperatorEnd(DateTool.addDays(listVo.getSearch().getOperatorEnd(), +1));
        }

        listVo = ServiceSiteTool.auditLogService().queryLogs(listVo);
        if (listVo.getSearch().getOperatorBegin() != null && listVo.getSearch().getOperatorEnd() != null) {
            listVo.getSearch().setOperatorEnd(DateTool.addDays(listVo.getSearch().getOperatorEnd(), -1));
        }
        Date nowTime = SessionManager.getDate().getNow();
        model.addAttribute("command", listVo);
        model.addAttribute("nowTime", nowTime);
        model.addAttribute("userType", DictTool.get(DictEnum.COMMON_USER_TYPE));//用户类型
        Map<String, Serializable> map = DictTool.get(DictEnum.Log_OpType);
        map.remove(ModuleType.PASSPORT_LOGIN_FAIL);
        model.addAttribute("opType", map);//操作类型
        return ServletTool.isAjaxSoulRequest(request) ? JOURNAL_URI + "Partial" : JOURNAL_URI;
    }

    /**
     * 玩家信息详情-日志
     *
     * @return
     */
    @RequestMapping("/view/journalMore")
    public String journalMore(SysAuditLogListVo listVo, Model model, HttpServletRequest request) {
        //listVo = ServiceSiteTool.vUserPlayerService().searchSysAuditLogs(listVo);
        model.addAttribute("command", listVo);
        return MORE_JOURNAL_URI;
    }

    /**
     * 玩家-咨询
     *
     * @return
     */
    @RequestMapping("/view/news")
    public String news(VPlayerAdvisoryListVo listVo, Model model, HttpServletRequest request) {
        //提问内容
        listVo.getSearch().setAdvisoryTime(DateTool.addMonths(SessionManager.getDate().getNow(), -1));
        listVo = ServiceSiteTool.vPlayerAdvisoryService().search(listVo);
        listVo.changeReadState(SessionManager.getUserId());
        //获取全部的追问咨询是否已读
        List<VPlayerAdvisory> list = new ArrayList();
        for (VPlayerAdvisory vp : listVo.getResult()) {
            if (PlayerAdvisoryEnum.PUMP.getCode().equals(vp.getQuestionType())) {
                VPlayerAdvisory vPlayerAdvisory = new VPlayerAdvisory();
                vPlayerAdvisory.setContinueQuizId(vp.getContinueQuizId());
                vPlayerAdvisory.setRead(vp.getRead());
                list.add(vPlayerAdvisory);
            }
        }
        //把未读的追问咨询同步到他的父类咨询问题
        for (VPlayerAdvisory advisory : listVo.getResult()) {
            if (PlayerAdvisoryEnum.QUESTION.getCode().equals(advisory.getQuestionType())) {
                for (VPlayerAdvisory obj : list) {
                    if (advisory.getId().equals(obj.getContinueQuizId()) && obj.getRead() == false) {
                        advisory.setRead(false);
                    }
                }
            }
        }
        model.addAttribute("command", listVo);

        return ServletTool.isAjaxSoulRequest(request) ? NEWS_URI + "Partial" : NEWS_URI;
    }

    /**
     * 判断回复次数
     *
     * @param vo
     * @return
     */
    @RequestMapping("/view/checkReplyCount")
    @ResponseBody
    public String checkReplyCount(PlayerAdvisoryReplyVo vo) {
        Long count = ServiceSiteTool.playerAdvisoryReplyService().checkReplyCount(vo);
        String flag = "";
        if (count >= REPLAY_COUNT) {
            flag = "false";
        } else {
            flag = "true";
        }
        return flag;
    }

    //查看咨询
    @RequestMapping({"/view/playerAdvisory"})
    public String playerAdvisory(VPlayerAdvisoryListVo vPlayerAdvisoryListVo, Integer id, Integer continueQuizId, VPlayerAdvisoryReplyListVo listVo, Model model) {
        listVo.getPaging().setPageSize(60);//查看所有的回复
        //表单校验
        model.addAttribute("validate", JsRuleCreator.create(PlayerAdvisoryForm.class, "result"));

        //当前咨询信息
        if (continueQuizId != null) {
            vPlayerAdvisoryListVo.getSearch().setId(continueQuizId);
        } else {
            vPlayerAdvisoryListVo.getSearch().setId(id);
        }
        List<VPlayerAdvisory> vPlayerAdvisoryList = ServiceSiteTool.vPlayerAdvisoryService().searchVPlayerAdvisoryReply(vPlayerAdvisoryListVo);
        Map map = new TreeMap(new Comparator() {
            @Override
            public int compare(Object o1, Object o2) {
                return ((Integer) o2) - ((Integer) o1);
            }
        });
        for (VPlayerAdvisory obj : vPlayerAdvisoryList) {
            //回复标题和内容
            listVo.getSearch().setPlayerAdvisoryId(obj.getId());
            listVo = ServiceSiteTool.vPlayerAdvisoryReplyService().search(listVo);
            map.put(obj.getId(), listVo);
        }

        model.addAttribute("command", vPlayerAdvisoryList);
        model.addAttribute("map", map);

        //判断咨询是否已读
        PlayerAdvisoryReadVo playerAdvisoryReadVo = new PlayerAdvisoryReadVo();
        playerAdvisoryReadVo.setResult(new PlayerAdvisoryRead());
        playerAdvisoryReadVo.getSearch().setPlayerAdvisoryId(id);
        playerAdvisoryReadVo.getSearch().setUserId(SessionManager.getUserId());
        playerAdvisoryReadVo = ServiceSiteTool.playerAdvisoryReadService().search(playerAdvisoryReadVo);
        if (playerAdvisoryReadVo.getResult() == null) {
            PlayerAdvisoryReadVo readVo = new PlayerAdvisoryReadVo();
            readVo.setResult(new PlayerAdvisoryRead());
            readVo.getResult().setUserId(SessionManager.getUserId());
            readVo.getResult().setPlayerAdvisoryId(id);
            ServiceSiteTool.playerAdvisoryReadService().insert(readVo);
            //标识为已读时更新任务数
            updateTaskNum(UserTaskEnum.PLAYERCONSULTATION);
        }
        //判断追问咨询是否已读
        PlayerAdvisoryListVo playerAdvisoryListVo = new PlayerAdvisoryListVo();
        playerAdvisoryListVo.getSearch().setContinueQuizId(id);
        playerAdvisoryListVo = ServiceSiteTool.playerAdvisoryService().search(playerAdvisoryListVo);
        for (PlayerAdvisory pa : playerAdvisoryListVo.getResult()) {
            PlayerAdvisoryReadVo par = new PlayerAdvisoryReadVo();
            par.setResult(new PlayerAdvisoryRead());
            par.getSearch().setPlayerAdvisoryId(pa.getId());
            par.getSearch().setUserId(SessionManager.getUserId());
            par = ServiceSiteTool.playerAdvisoryReadService().search(par);
            if (par.getResult() == null) {
                PlayerAdvisoryReadVo readVo = new PlayerAdvisoryReadVo();
                readVo.setResult(new PlayerAdvisoryRead());
                readVo.getResult().setUserId(SessionManager.getUserId());
                readVo.getResult().setPlayerAdvisoryId(pa.getId());
                ServiceSiteTool.playerAdvisoryReadService().insert(readVo);
                //标识为已读时更新任务数
                updateTaskNum(UserTaskEnum.PLAYERCONSULTATION);
            }
        }

        return "/player/advisory/View";
    }

    private void updateTaskNum(UserTaskEnum userTaskEnum) {
        try {
            UserTaskReminderVo userTaskReminderVo = new UserTaskReminderVo();
            userTaskReminderVo.setTaskEnum(userTaskEnum);
            ServiceSiteTool.userTaskReminderService().reduceTaskReminder(userTaskReminderVo);
        } catch (Exception ex) {
            LOG.error(ex, "更新任务数出错");
        }

    }


    //保存咨询回复
    @RequestMapping("/save/reply")
    @ResponseBody
    public Map saveReply(PlayerAdvisoryReply reply, PlayerAdvisoryReplyVo vo) {
        vo.setSuccess(false);
        if (reply.getReplyContent().trim().length() > 0) {
            Date timeNow = SessionManager.getDate().getNow();
            reply.setReplyTime(timeNow);
            reply.setUserId(SessionManager.getUserId());
            vo.setResult(reply);
            vo = ServiceSiteTool.playerAdvisoryReplyService().insert(vo);

            PlayerAdvisoryVo playerAdvisoryVo = new PlayerAdvisoryVo();
            playerAdvisoryVo.setResult(new PlayerAdvisory());
            playerAdvisoryVo.getSearch().setId(vo.getResult().getPlayerAdvisoryId());
            playerAdvisoryVo = ServiceSiteTool.playerAdvisoryService().get(playerAdvisoryVo);
            //保存咨询回复同时修改咨询回复次数及时间
            PlayerAdvisoryVo pVo = new PlayerAdvisoryVo();
            pVo.setResult(new PlayerAdvisory());
            pVo.getResult().setId(playerAdvisoryVo.getResult().getId());
            pVo.getResult().setLatestTime(SessionManager.getDate().getNow());
            pVo.getResult().setReplyCount(playerAdvisoryVo.getResult().getReplyCount() == null ? 0 : playerAdvisoryVo.getResult().getReplyCount() + 1);
            pVo.setProperties(PlayerAdvisory.PROP_REPLY_COUNT, PlayerAdvisory.PROP_LATEST_TIME);
            ServiceSiteTool.playerAdvisoryService().updateOnly(pVo);
            if (vo.isSuccess() == true) {
                vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "send.success"));
            } else {
                vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "send.fail"));
            }
        }

        //生成任务提醒
        //updateTaskNum(UserTaskEnum.PLAYERCONSULTATION);

        HashMap map = new HashMap(2, 1f);
        map.put("msg", StringTool.isNotBlank(vo.getOkMsg()) ? vo.getOkMsg() : vo.getErrMsg());
        map.put("state", Boolean.valueOf(vo.isSuccess()));
        return map;
    }

    //删除咨询(暂时没有用了)
    @RequestMapping("/delete/reply")
    @ResponseBody
    public Map deleteReply(PlayerAdvisoryReply reply, Integer id) {
        PlayerAdvisoryVo vo = new PlayerAdvisoryVo();
        vo.setResult(new PlayerAdvisory());
        vo.getSearch().setId(id);
        if (id != null) {
            boolean success = ServiceSiteTool.playerAdvisoryService().delete(vo);
            vo.setSuccess(success);
            if (success == true) {
                vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_SUCCESS));
            } else {
                vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_FAILED));
            }
        }
        return this.getVoMessage(vo);
    }

    /**
     * 查看更多咨询
     *
     * @param listVo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/moreAdvisory")
    public String moreAdvisory(VPlayerAdvisoryListVo listVo, Model model, HttpServletRequest request) {
        listVo = ServiceSiteTool.vPlayerAdvisoryService().searchVPlayerAdvisorys(listVo);
        model.addAttribute("command", listVo);
        return ServletTool.isAjaxSoulRequest(request) ? MORE_ADVISORY_URI + "Partial" : MORE_ADVISORY_URI;
    }

    /**
     * 查看更多咨询回复内容
     *
     * @param listVo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/moreAdvisoryReply")
    public String moreAdvisoryReply(PlayerAdvisoryReplyListVo listVo, Model model, HttpServletRequest request) {
        listVo = ServiceSiteTool.playerAdvisoryReplyService().searchPlayerAdvisoryReplys(listVo);
        model.addAttribute("command", listVo);
        return ServletTool.isAjaxSoulRequest(request) ? MORE_ADVISORYREPLY_URI + "Partial" : MORE_ADVISORYREPLY_URI;
    }

    /**
     * 玩家信息详情-优惠
     *
     * @return
     */
    @RequestMapping("/view/sale")
    public String sale() {
        return SALE_URI;
    }

    /**
     * 玩家信息详情-交易
     *
     * @return
     */
    @RequestMapping("/view/singleRecord")
    public String singleRecord() {
        return SINGLE_RECORD_URI;
    }

    /**
     * 查看资讯内容弹出框
     *
     * @return
     */
    @RequestMapping("readPlayerRequest")
    public String readPlayerRequest() {
        return READ_PLAYER_REQUEST;
    }

    /**
     * 数据混淆
     *
     * @return
     */
    @RequestMapping("/encryptData")
    public String encryptData() {
        return ENCRYPT_DATA_URI;
    }

    /**
     * 清除联系方式
     *
     * @return
     */
    @RequestMapping("/clearContact")
    public String clearContact() {
        return CLEAR_CONTACT_INFO_URI;
    }

    @Override
    protected String getViewBasePath() {
        return root;
    }

    /**
     * 跳转到账号停用页面
     *
     * @param userId
     * @param model
     * @return
     */
    @RequestMapping("/view/disabledAccount")
    public String disabledAccount(Integer userId, Model model) {
        VUserPlayerVo vo = new VUserPlayerVo();
        vo.getSearch().setId(userId);
        VUserPlayer user = this.getService().findOnLineUser(vo);
        model.addAttribute("vo", user);
        if (StringTool.isNotEmpty(user.getStatus()) && user.getStatus().equals(SysUserStatus.DISABLED.getCode())) {

            VNoticeSendTextListVo listVo = new VNoticeSendTextListVo();
            listVo.getSearch().setReceiverGroupId(userId);
            listVo.getSearch().setEventType(ManualNoticeEvent.PLAYER_ACCOUNT_STOP.getCode());
            listVo.getSearch().setLocale(SessionManager.getLocale().toString());
            VNoticeSendText send = ServiceTool.noticeService().fetchNoticeReason(listVo);
            model.addAttribute("send", send);
            return DISABLE_URL;

        } else {

            NoticeVo noticeVo = new NoticeVo();
            noticeVo.setEventType(ManualNoticeEvent.PLAYER_ACCOUNT_STOP);
            List<NoticeLocaleTmpl> noticeLocaleTmpls = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);
            model.addAttribute("noticeLocaleTmpls", noticeLocaleTmpls);
            return DISABLE_ACCOUNT;

        }
    }


    /**
     * 账号停用预览
     *
     * @return
     */
    @RequestMapping(value = "/view/disablePreview")
    public String disablePreview(PlayerDisable playerDisable, Model model) {
        model.addAttribute("username", playerDisable.getUsername());
        int size = redisSessionDao.getUserActiveSessions(UserTypeEnum.PLAYER.getCode(), playerDisable.getPlayerId()).size();
        model.addAttribute("onLineId", size);
        model.addAttribute("title", playerDisable.getTitle());
        model.addAttribute("remark", playerDisable.getRemark());
        model.addAttribute("reasonContent", playerDisable.getReasonContent());
        model.addAttribute("playerId", playerDisable.getPlayerId());
        if (playerDisable.getType() != null && playerDisable.getType() == 2) {
            return OFFLINE_PREVIEW;
        } else {
            return DISABLE_PREVIEW;
        }
    }

    /**
     * 停用确定操作
     *
     * @param vo
     * @return
     */
    @RequestMapping(value = "/view/saveDisable")
    @ResponseBody
    public Map saveDisable(RemarkVo vo) {
        // TODO Jeff
        Integer userId = vo.getResult().getEntityUserId();
        String remark = vo.getResult().getRemarkContent();
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setId(userId);
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        sysUserVo.getResult().setStatus(SysUserStatus.DISABLED.getCode());
        sysUserVo = this.getService().updateStatus(sysUserVo);
        if (sysUserVo.isSuccess()) {
            //保存备注
            if (StringTool.isNotEmpty(remark)) {
                vo.getResult().setRemarkTime(new Date());
                vo.getResult().setRemarkType(RemarkEnum.PLAYER_USERBLOCK_IP.getType());
                vo.getResult().setModel(RemarkEnum.PLAYER_USERBLOCK_IP.getModel());
                vo.getResult().setEntityUserId(userId);
                vo.getResult().setOperatorId(SessionManager.getUserId());
                vo.getResult().setOperator(SessionManager.getUserName());
                vo.getResult().setRemarkTitle(SessionManager.getUser().getUsername() + "对玩家" + sysUserVo.getResult().getUsername() + "进行账号停用");
                ServiceTool.getRemarkService().insert(vo);
            }
            //发送信息
            NoticeVo noticeVo = NoticeVo.manualNotify(vo.getGroupCode(), null, userId);
            noticeVo.setRemarks(remark);
            try {
                ServiceTool.noticeService().publish(noticeVo);
            } catch (Exception ex) {
                LogFactory.getLog(this.getClass()).error(ex, "发布消息不成功");
            }
            //保存日志
            //TODO lorne
        }
        if (vo.isSuccess() && StringTool.isBlank(vo.getOkMsg())) {
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_SUCCESS));
        } else if (!vo.isSuccess() && StringTool.isBlank(vo.getErrMsg())) {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_FAILED));
        }
        return this.getVoMessage(vo);
    }

    /**
     * 取消停用操作
     *
     * @param userId
     * @return
     */
    @RequestMapping(value = "/view/cancelDisabled")
    @ResponseBody
    public Map cancelDisabled(Integer userId) {
        SysUserVo vo = new SysUserVo();
        vo.getSearch().setId(userId);
        vo = ServiceTool.sysUserService().get(vo);
        if (vo.getResult().getStatus() == null || !SysUserStatus.DISABLED.getCode().equals(vo.getResult().getStatus())) {
            vo.setSuccess(false);
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "player.disable_operate"));
        } else {
            vo.getResult().setStatus(SysUserStatus.NORMAL.getCode());
            vo = this.getService().updateStatus(vo);
        }
        //保存日志
        //TODO lorne
        if (vo.isSuccess() && StringTool.isBlank(vo.getOkMsg())) {
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_SUCCESS));
        } else if (!vo.isSuccess() && StringTool.isBlank(vo.getErrMsg())) {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_FAILED));
        }
        return this.getVoMessage(vo);
    }

    /**
     * 跳转到强制踢出页面
     *
     * @param userId
     * @param model
     * @return
     */
    @RequestMapping("/view/offlineForced")
    public String offlineForced(Integer userId, Model model) {
        VUserPlayerVo vo = new VUserPlayerVo();
        vo.getSearch().setId(userId);
        VUserPlayer user = this.getService().findOnLineUser(vo);
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.FORCE_KICK_OUT);
        List<NoticeLocaleTmpl> noticeLocaleTmpls = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);
        int onLineId = redisSessionDao.getUserActiveSessions(UserTypeEnum.PLAYER.getCode(), user.getId()).size();
        model.addAttribute("onLineId", onLineId);
        model.addAttribute("vo", user);
        model.addAttribute("noticeLocaleTmpls", noticeLocaleTmpls);
        return OFFLINE_FORCED;
    }

    /**
     * 踢出确定操作
     *
     * @param vo
     * @return
     */
    @RequestMapping(value = "/view/saveOffline")
    @ResponseBody
    public Map saveOffline(RemarkVo vo, HttpServletRequest request) {
        Integer userId = vo.getResult().getEntityUserId();
        String remark = vo.getResult().getRemarkContent();
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setId(userId);
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        //保存备注
        if (StringTool.isNotEmpty(remark)) {
            vo.getResult().setRemarkTime(new Date());
            vo.getResult().setRemarkType(RemarkEnum.PLAYER_FORCEKICK_OUT.getType());
            vo.getResult().setModel(RemarkEnum.PLAYER_FORCEKICK_OUT.getModel());
            vo.getResult().setOperatorId(SessionManager.getUserId());
            vo.getResult().setOperator(SessionManager.getUserName());
            vo.getResult().setRemarkTitle(SessionManager.getUser().getUsername() + "对玩家" + sysUserVo.getResult().getUsername() + "进行强制踢出");
            ServiceTool.getRemarkService().insert(vo);
        }
        String content = vo.getReasonContent();
        //发送信息
        if (StringTool.isNotBlank(vo.getGroupCode())) {
            NoticeVo noticeVo = NoticeVo.manualNotify(vo.getGroupCode(), null, userId);
            String time = LocaleDateTool.formatDate(new Date(), CommonContext.getDateFormat().getDAY_SECOND(), sysUserVo.getResult().getDefaultTimezone());
            noticeVo.addParams(new Pair("time", time));
            Calendar c = Calendar.getInstance();
            noticeVo.addParams(new Pair("year", String.valueOf(c.get(Calendar.YEAR))));
            noticeVo.addParams(new Pair("month", String.valueOf(c.get(Calendar.MONTH))));
            noticeVo.addParams(new Pair("day", String.valueOf(c.get(Calendar.DAY_OF_MONTH))));
            noticeVo.addParams(new Pair("sitename", SessionManager.getSiteName(request)));
            String ip = IpTool.ipv4LongToString(SessionManager.getUser().getLoginIp());
            noticeVo.addParams(new Pair("ip", ip));
            noticeVo.addParams(new Pair("user", sysUserVo.getResult().getUsername()));
            //TODO:water 变量标签需要实现
//            noticeVo.addParams(new Pair("website",""));
//            noticeVo.addParams(new Pair("customer",""));
            content = StringTool.fillTemplate(content, noticeVo.getParamMap());
//            noticeVo.setRemarks(remark);
            try {
                ServiceTool.noticeService().publish(noticeVo);
            } catch (Exception ex) {
                LogFactory.getLog(this.getClass()).error(ex, "发布消息不成功");
            }
        }

        //调用单点退出登录
        KickoutFilter.loginKickoutAll(userId, OpMode.MANUAL, content, "站长后台强制踢出玩家");
        //保存日志
        //TODO lorne
        if (vo.isSuccess() && StringTool.isBlank(vo.getOkMsg())) {
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_SUCCESS));
        } else if (!vo.isSuccess() && StringTool.isBlank(vo.getErrMsg())) {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_FAILED));
        }
        return this.getVoMessage(vo);
    }

    /**
     * 首页管理－筛选管理
     *
     * @param listVo 　列表页面实体
     * @param model
     * @return
     */
    @RequestMapping({"/filters"})
    public String list(SysListOperatorListVo listVo, Model model) {

        Map<String, SysListOperator> listOp = ListOpTool.getFilter(ListOpEnum.VUserPlayerListVo);
        if (listOp != null && listOp.size() > 0) {
            model.addAttribute("filters", listOp.values());
        }
        //region Filter Conditions
        String vUserSimpleclassName = VUserPlayer.class.getSimpleName();
        List<FilterRow> filterRowList = new ArrayList<>();
        Map<String, List<Pair>> masterFilter = getService().searchMstFilter(new PlayerRankVo());
        //状态、层级、返水方案、返水总额、存款总数、存款总额、取款总数、取款总额、总盈亏、总交易量、总有效交易量、等级、性别、注册时间、钱包余额、标签、手机号码、邮箱、QQ、MSN、Skype、有效优惠券数量、货币、生日

        filterRowList.add(new FilterRow(VUserPlayer.PROP_STATUS, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_STATUS),
                FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, FilterSelectConstant.status));
        if (MapTool.isNotEmpty(masterFilter)) {
            List<Pair> hierarchyList = masterFilter.get(PlayerRank.class.getName());
            // 层级
            if (CollectionTool.isNotEmpty(hierarchyList)) {
                filterRowList.add(new FilterRow(VUserPlayer.PROP_RANK_ID, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_RANK_ID),
                        FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, hierarchyList));
            }
        }
        if (MapTool.isNotEmpty(masterFilter)) {
            // 返水方案
            List<Pair> rakeList = masterFilter.get(RakebackSet.class.getName());
            if (CollectionTool.isNotEmpty(rakeList)) {
                filterRowList.add(new FilterRow(VUserPlayer.PROP_RAKEBACK_ID, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_RAKEBACK_NAME),
                        FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, rakeList));
            }
        }
        // 返水总额
        filterRowList.add(new FilterRow(VUserPlayer.PROP_RAKEBACK, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_RAKEBACK),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        // 存款次数
        filterRowList.add(new FilterRow(VUserPlayer.PROP_RECHARGE_COUNT, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_RECHARGE_COUNT),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        // 存款总额
        filterRowList.add(new FilterRow(VUserPlayer.PROP_RECHARGE_TOTAL, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_RECHARGE_TOTAL),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        // 取款总数
        filterRowList.add(new FilterRow(VUserPlayer.PROP_TX_COUNT, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_TX_COUNT),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        // 取款总额
        filterRowList.add(new FilterRow(VUserPlayer.PROP_TX_TOTAL, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_TX_TOTAL),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        /*// 总盈亏
        filterRowList.add(new FilterRow(VUserPlayer.PROP_TOTAL_PROFIT_LOSS, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_TOTAL_PROFIT_LOSS),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        // 总交易量
        filterRowList.add(new FilterRow(VUserPlayer.PROP_TOTAL_TRADE_VOLUME, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_TOTAL_TRADE_VOLUME),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        // 总有效交易量
        filterRowList.add(new FilterRow(VUserPlayer.PROP_TOTAL_EFFECTIVE_VOLUME, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_TOTAL_EFFECTIVE_VOLUME),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));*/
        // 性别
        filterRowList.add(new FilterRow(VUserPlayer.PROP_SEX, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_SEX),
                FilterSelectConstant.equal, TabTypeEnum.SELECT, FilterSelectConstant.sex));

        // 注册时间
        filterRowList.add(new FilterRow(VUserPlayer.PROP_CREATE_TIME, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_CREATE_TIME),
                FilterSelectConstant.greatAndLess, TabTypeEnum.DATE, null));
        // 钱包余额
        filterRowList.add(new FilterRow(VUserPlayer.PROP_WALLET_BALANCE, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_WALLET_BALANCE),
                FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));

        if (MapTool.isNotEmpty(masterFilter)) {
            // 标签
            List<Pair> tagsList = masterFilter.get(Tags.class.getName());
            if (CollectionTool.isNotEmpty(tagsList)) {
                filterRowList.add(new FilterRow(Tags.PROP_TAG_NAME, LocaleTool.tranView("column", vUserSimpleclassName + ".label"),
                        FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, tagsList));
            }
        }
        // 国家地区
        /*filterRowList.add(new FilterRow(VUserPlayer.PROP_COUNTRY, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_COUNTRY),
                FilterSelectConstant.contain, TabTypeEnum.TEXT, null));*/
        // 手机号码
        filterRowList.add(new FilterRow(VUserPlayer.PROP_MOBILE_PHONE, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_MOBILE_PHONE),
                FilterSelectConstant.onlyEqual, TabTypeEnum.SELECT, FilterSelectConstant.yesnot));
        // 邮箱
        filterRowList.add(new FilterRow(VUserPlayer.PROP_MAIL, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_MAIL),
                FilterSelectConstant.onlyEqual, TabTypeEnum.SELECT, FilterSelectConstant.yesnot));
        // QQ
        filterRowList.add(new FilterRow(VUserPlayer.PROP_QQ, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_QQ),
                FilterSelectConstant.onlyEqual, TabTypeEnum.SELECT, FilterSelectConstant.yesnot));
        // 微信
        filterRowList.add(new FilterRow(VUserPlayer.PROP_WEIXIN, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_WEIXIN),
                FilterSelectConstant.onlyEqual, TabTypeEnum.SELECT, FilterSelectConstant.yesnot));
        // skype
        /*filterRowList.add(new FilterRow(VUserPlayer.PROP_SKYPE, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_SKYPE),
                FilterSelectConstant.onlyEqual, TabTypeEnum.SELECT, FilterSelectConstant.yesnot));*/
        // 货币
        List<Pair> siteCurrencyList = new ArrayList<>();
        Map<String, SiteCurrency> mapCurrencyList = Cache.getSiteCurrency();
        if (MapTool.isNotEmpty(mapCurrencyList)) {
            for (String s : mapCurrencyList.keySet()) {
                siteCurrencyList.add(new Pair(mapCurrencyList.get(s).getCode(), LocaleTool.tranDict(DictEnum.COMMON_CURRENCY, mapCurrencyList.get(s).getCode())));
            }
        }
        if (CollectionTool.isNotEmpty(siteCurrencyList)) {
            filterRowList.add(new FilterRow(VUserPlayer.PROP_DEFAULT_CURRENCY, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_DEFAULT_CURRENCY),
                    FilterSelectConstant.equal, TabTypeEnum.SELECT, siteCurrencyList));
        }
        // 生日
        filterRowList.add(new FilterRow(VUserPlayer.PROP_BIRTHDAY, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_BIRTHDAY),
                FilterSelectConstant.greatAndLess, TabTypeEnum.DATE, null));
        // TODO BEGIN 一期不做 by tom
        // 等级
        /*List<Pair> levelMap = new ArrayList<>();
        levelMap.add(new Pair("01", "一级"));
        levelMap.add(new Pair("02", "二级"));

        filterRowList.add(new FilterRow(VUserPlayer.PROP_LEVEL, LocaleTool.tranView("column", vUserSimpleclassName + "." + VUserPlayer.PROP_RANK_ID),
                FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, levelMap));
        filterRowList.add(new FilterRow(VUserPlayer.PROP_INTEGRAL, LocaleTool.tranView("column",VUserPlayer.PROP_积分),
              FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));*/
        // TODO END
        // 状态
// 钱包余额、标签、手机号码、邮箱、QQ、MSN、Skype、有效优惠券数量、货币、生日


        // 地址
        /*filterRowList.add(new FilterRow(PlayerAddress.PROP_ADDRESS, LocaleTool.tranView("column", PlayerAddress.PROP_ADDRESS),
                FilterSelectConstant.onlyEqual, TabTypeEnum.SELECT, FilterSelectConstant.yesnot));*/


        //TODO Tony 优惠券还没有相关表
        //filterRowList.add(new FilterRow(VPlayerTag.PROP_TAG_ID, LocaleTool.tranView("column",className+"."+VPlayerTag.PROP_TAG_ID),
        //      FilterSelectConstant.contain, TabTypeEnum.TEXT, null));
        //filterRowList.add(new FilterRow(VUserPlayer.PROP_ADDRESS, LocaleTool.tranView("column",className+"."+VUserPlayer.PROP_ADDRESS),
        //      FilterSelectConstant.onlyEqual, TabTypeEnum.SELECT, FilterSelectConstant.yesnot));
        //filterRowList.add(new FilterRow("validSaleNum", "有效优惠券数量", FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));
        //endregion
        model.addAttribute("validateRule", JsRuleCreator.create(SysListOperatorForm.class, ""));
        model.addAttribute("filterList", filterRowList);
        model.addAttribute("keyClassName", ListOpEnum.VUserPlayerListVo.getClassName());
        model.addAttribute("jsonFilterList", JsonTool.toJson(filterRowList));
        model.addAttribute("goFilterUrl", "/player/index.html");

        return "/share/ListFilters";
    }

    @RequestMapping(value = "/columns")
    public String indexOp(Model model) {
        Map<String, Boolean> hasFeilds = new HashMap();
        ListOpTool.refreshFields(ListOpEnum.VUserPlayerListVo);
        Map<String, SysListOperator> listOp = ListOpTool.getFields(ListOpEnum.VUserPlayerListVo);
        Map map = new TreeMap(new Comparator() {
            @Override
            public int compare(Object o1, Object o2) {
                return ((Integer) o1) - ((Integer) o2);
            }
        });
        if (listOp != null) {
            map.putAll(listOp);
        }
        for (Object o : listOp.keySet()) {
            SysListOperator tem = listOp.get(o);
            ArrayList<Map<String, String>> tt = JsonTool.fromJson(tem.getContent(), ArrayList.class);
            for (Map<String, String> stringStringMap : tt) {
                for (String s : stringStringMap.keySet()) {
                    hasFeilds.put(stringStringMap.get("name"), true);
                }
            }
            tem.setMapContent(tt);
        }

        model.addAttribute("keyClassName", ListOpEnum.VUserPlayerListVo.getClassName());
        model.addAttribute("defaultFeilds", new VUserPlayerListVo().getDefaultFields());
        model.addAttribute("lists", map);
        model.addAttribute("hasFeilds", hasFeilds);

        return "share/ListColumns";
    }

    /**
     * 新增玩家
     * Created by kobe on 17-9-10.
     */
    @RequestMapping("/addNewPlayer")
    public String addNewPlayer(VUserPlayerVo objectVo, Model model) {
        VUserPlayer vUserPlayer = new VUserPlayer();
        vUserPlayer.setDefaultCurrency(SessionManager.getUser().getDefaultCurrency());
        vUserPlayer.setDefaultLocale(SessionManager.getUser().getDefaultLocale());
        vUserPlayer.setDefaultTimezone(SessionManager.getUser().getDefaultTimezone());
        objectVo.setResult(vUserPlayer);
        model.addAttribute("command", objectVo);
        List playerRanks = ServiceSiteTool.playerRankService().queryUsableRankList(new PlayerRankVo());
        model.addAttribute("playerRanks", playerRanks);
        model.addAttribute("validateRule", JsRuleCreator.create(AddNewPlayerForm.class));
        return "player/Edit";
    }

    /**
     * 保存新增玩家
     * Created by kobe on 17-9-10.
     */
    @RequestMapping("/saveNewPlayer")
    @ResponseBody
    @Audit(module = Module.PLAYER, moduleType = ModuleType.PLAYER_SAVE_NEW_ACCOUNT, opType = OpType.CREATE)
    public Map saveNewPlayer(VUserPlayerVo objectVo, HttpServletRequest request, @FormModel("result") @Valid AddNewPlayerForm form, BindingResult result) {
        Map resultMap = new HashMap(2, 1f);
        SysUser sysUser = new SysUser();
        sysUser.setOwnerId(objectVo.getResult().getAgentId());
        sysUser.setUsername(objectVo.getResult().getUsername());
        sysUser.setPassword(objectVo.getResult().getPassword());
        sysUser.setDefaultLocale(objectVo.getResult().getDefaultLocale());
        sysUser.setDefaultTimezone(objectVo.getResult().getDefaultTimezone());
        sysUser.setDefaultCurrency(objectVo.getResult().getDefaultCurrency());
        sysUser.setRegisterIpDictCode(SessionManager.getIpDictCode());
        sysUser.setRegisterIp(IpTool.ipv4StringToLong(ServletTool.getIpAddr(request)));
        sysUser.setCreateUser(SessionManager.getUserId());
        UserPlayer userPlayer = new UserPlayer();
        String domain = SessionManagerCommon.getDomain(request);
        sysUser.setRegisterSite(domain);
        userPlayer.setCreateChannel(CreateChannelEnum.BACKSTAGE_MANAGEMENT.getCode());
        userPlayer.setRankId(objectVo.getResult().getRankId());
        UserRegisterVo userRegisterVo = new UserRegisterVo();
        userRegisterVo.setSysUser(sysUser);
        userRegisterVo.setUserPlayer(userPlayer);
        ServiceSiteTool.userPlayerService().register(userRegisterVo);
        if (userRegisterVo.isSuccess()) {
            resultMap.put("status", true);
            BussAuditLogTool.addLog(BussAuditLogDescEnum.PLAYER_SAVE_NEW_ACCOUNT.getCode(),objectVo.getResult().getUsername());
        } else {
            resultMap.put("status", false);
            resultMap.put("msg", userRegisterVo.getErrMsg());

        }
        return resultMap;
    }


    /**
     * 加载玩家编辑页面
     * Created by jerry on 15-6-4.
     */
    @RequestMapping("/getVUserPlayer")
    @Token(generate = true)
    public String getVUserPlayer(VUserPlayerVo objectVo, Model model, SiteLanguageListVo siteLanguageListVo) {
        objectVo = super.doEdit(objectVo, model);

        SysAuditLogListVo sysAuditLogListVo = new SysAuditLogListVo();
        sysAuditLogListVo.getSearch().setEntityUserId(objectVo.getSearch().getId());
        sysAuditLogListVo.getSearch().setModuleType(ModuleType.PLAYER_UPDATEAGENTLINE_SUCCESS.getCode());
        sysAuditLogListVo = ServiceSiteTool.auditLogService().queryLogs(sysAuditLogListVo);
        List logList = sysAuditLogListVo.getResult();
        if (logList != null && logList.size() > 0) {
            model.addAttribute("sysAuditLog", logList.get(0));
        }

        ParamTool.refresh(SiteParamEnum.SETTING_REG_SETTING_FIELD_SETTING);
        SysParam param = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SETTING_FIELD_SETTING);
        List<FieldSort> fieldSortAll = (List<FieldSort>) JsonTool.fromJson(param.getParamValue(), JsonTool.createCollectionType(ArrayList.class, FieldSort.class));

        /*使用中的注册项*/
        List<FieldSort> fieldSorts = CollectionQueryTool.andQuery(fieldSortAll, ListTool.newArrayList(new Criterion(FieldSort.PROP_STATUS, Operator.NE, "2"), new Criterion(FieldSort.PROP_NAME, Operator.NOT_IN, objectVo.getDefaultCode())), Order.asc(FieldSort.PROP_SORT));

        /*必填的注册项*/
        List<FieldSort> requiredFieldSorts = CollectionQueryTool.andQuery(fieldSorts, ListTool.newArrayList(new Criterion(FieldSort.PROP_STATUS, Operator.NE, "2"), new Criterion(FieldSort.PROP_IS_REQUIRED, Operator.NE, "2")), Order.asc(FieldSort.PROP_SORT));

        /*必填的注册项name的json*/
        String required = JsonTool.toJson(CollectionTool.extractToList(requiredFieldSorts, FieldSort.PROP_NAME));

        /*层级*/
        objectVo.setSomePlayerRanks(ServiceSiteTool.playerRankService().queryUsableRankList(new PlayerRankVo()));

        //返水
        RakebackSetListVo rakebackSetListVo = new RakebackSetListVo();
        rakebackSetListVo.getQuery().setCriterions(new Criterion[]{new Criterion(RakebackSet.PROP_STATUS, Operator.EQ, UserAgentEnum.SET_STATUS_NORMAL.getCode())});
        rakebackSetListVo.setProperties(RakebackSet.PROP_ID, RakebackSet.PROP_NAME);
        objectVo.setRakebackSetList(ServiceSiteTool.rakebackSetService().searchProperties(rakebackSetListVo));
        objectVo.setRequired(required);
//        userAgentVo.setFieldSorts(fieldSorts);
        objectVo.setFieldSorts(fieldSorts);

        /* 时区 */
        objectVo.setTimeZone(DictTool.get(DictEnum.COMMON_TIME_ZONE));

        /* 联系方式 */
        objectVo.setContact(DictTool.get(DictEnum.COMMON_CONTACT_WAY_TYPE));
        objectVo = this.getService().getEdit(objectVo);
        /*语言集合*/
        siteLanguageListVo.getSearch().setStatus("2");
        objectVo.setSiteLanguageList(ServiceTool.siteLanguageService().search(siteLanguageListVo).getResult());
        //获取手机区号字典
        DictTool.refresh(DictEnum.REGION_CALLING_CODE);
        Map<String, Serializable> phoneCode = DictTool.get(DictEnum.REGION_CALLING_CODE);
        objectVo.setPhoneCodeDict(phoneCode);
        Map<String, Serializable> imTypeMaps = DictTool.get(DictEnum.COMMON_IM_TYPE);
        objectVo.setImTypeMaps(imTypeMaps);
        //获取标签和所属代理
        objectVo = this.getService().queryPlayerTagAllAndMstRankList(objectVo);
        objectVo.setPlayerRankList(ServiceSiteTool.playerRankService().queryUsableList(new PlayerRankVo()));
        objectVo.setValidateRule(JsRuleCreator.create(VUserPlayerForm.class, "result"));
        objectVo.setUserDate(SessionManager.getDate().getNow());

        //安全问题
        SysUserProtectionVo protection = new SysUserProtectionVo();
        protection.getSearch().setId(objectVo.getResult().getId());
        protection = ServiceTool.sysUserProtectionService().get(protection);
        objectVo.setSysUserProtection(protection.getResult());
        //获取在线状态
        model.addAttribute("command", objectVo);
        return VUSER_PLAYER_VIEW;
    }

    @RequestMapping("/getPhoneCode")
    @ResponseBody
    public String getPhoneCode() {
        /*Map<String, Serializable> dictMap = DictTool.get(DictEnum.REGION_CALLING_CODE);
        Collection<Serializable> values = dictMap.values();
        for(Serializable obj :values){
            SysDict dict = (SysDict)obj;
            String key = LocaleTool.tranDict(DictEnum.REGION_REGION, dict.getDictCode())+dict.getRemark();
            dict.setDictCode(key);
        }
        String s = JsonTool.toJson(values);*/
        String json = filterPhoneCode();
        return json;
    }

    private String filterPhoneCode() {
        Map<String, Serializable> dictMap = DictTool.get(DictEnum.REGION_CALLING_CODE);
        Collection<Serializable> values = dictMap.values();
        Collection<Serializable> res = new ArrayList<>();
        Map<String, String> map = new HashMap<>();
        for (Serializable obj : values) {
            SysDict dict = (SysDict) obj;
            if (!map.containsKey(dict.getRemark())) {
                res.add(dict);
                map.put(dict.getRemark(), dict.getDictCode());
            }

        }
        String s = JsonTool.toJson(res);
        return s;
    }

    @RequestMapping({"/getNationsMap"})
    @ResponseBody
    public Map<String, String> getNationsMap() {
        Map<String, String> nationMap = new HashMap();
        Map<String, SysDict> dictMap = DictTool.get(DictEnum.COMMON_NATION);
        if (dictMap == null) {
            return nationMap;
        }
        for (String key : dictMap.keySet()) {
            SysDict dict = dictMap.get(key);
            nationMap.put(key, dict.getRemark());
        }
        return nationMap;

    }

    @RequestMapping({"/getAreaMap/{parentCode}"})
    @ResponseBody
    public Map<String, String> getAreaMap(@PathVariable String parentCode) {
        Map<String, String> nationMap = new HashMap();
        if (parentCode == null || parentCode.equals("")) {
            nationMap.put("", "请选择");
            return nationMap;
        }

        Map<String, SysDict> dictMap = DictTool.get(DictEnum.COMMON_PROVINCE);
        for (String key : dictMap.keySet()) {
            SysDict dict = dictMap.get(key);
            if (dict.getParentCode().equals(parentCode)) {
                nationMap.put(key, dict.getRemark());
            }
        }
        return nationMap;
    }

    @RequestMapping({"/updateUserPlayerAndPlayerTag"})
    @Audit(module = Module.PLAYER, moduleType = ModuleType.PLAYER_PLAYERRANK_SUCCESS, opType = OpType.UPDATE)
    @ResponseBody
    @Token(valid = true)
    public Map updateUserPlayerAndPlayerTag(HttpServletRequest request, VUserPlayerVo vUserPlayerVo, @FormModel("result") @Valid UserPlayerUpdateForm form, BindingResult result) {
        Map resultMap = new HashMap();
        try {
            if (!result.hasErrors()) {
                if (StringTool.isBlank(vUserPlayerVo.getSysUser().getDefaultLocale())) {
                    vUserPlayerVo.getSysUser().setDefaultLocale(SessionManager.getLocale().toString());
                }
                vUserPlayerVo = this.getService().updateUserPlayerAndPlayerTag(vUserPlayerVo);
                Map<String, Object> map = getIsPubMsg();
                if (vUserPlayerVo.isSuccess() && map != null) {
                    if (Boolean.valueOf(map.get("siteMsg").toString())) {
                        //发送固定站内信内容
                        NoticeVo noticeVo = NoticeVo.autoNotify(AutoNoticeEvent.CHANGE_PLAYER_DATA, vUserPlayerVo.getResult().getId());
                        noticeVo.addParams(new Pair("手动修改玩家资料", vUserPlayerVo.getResult().getUsername()));
                        try {
                            ServiceTool.noticeService().publish(noticeVo);
                        } catch (Exception ex) {
                            LogFactory.getLog(this.getClass()).error(ex, "发布消息不成功");
                        }
                    }
                    if (!vUserPlayerVo.getResult().getOldRankId().equals(vUserPlayerVo.getResult().getRankId())) {
                        //旧的rankId 和　返水方案
                        PlayerRankVo oldRankVo = new PlayerRankVo();
                        oldRankVo.setResult(new PlayerRank());
                        oldRankVo.getSearch().setId(vUserPlayerVo.getResult().getOldRankId());
                        oldRankVo = ServiceSiteTool.playerRankService().get(oldRankVo);
                        RakebackSetVo oldSetVo = new RakebackSetVo();
                        oldSetVo.setResult(new RakebackSet());
                        oldSetVo.getSearch().setId(oldRankVo.getResult().getRakebackId());
                        oldSetVo = ServiceSiteTool.rakebackSetService().get(oldSetVo);
                        //新的rankId 和　返水方案
                        PlayerRankVo newRankVo = new PlayerRankVo();
                        newRankVo.setResult(new PlayerRank());
                        newRankVo.getSearch().setId(vUserPlayerVo.getResult().getRankId());
                        newRankVo = ServiceSiteTool.playerRankService().get(newRankVo);
                        RakebackSetVo newSetVo = new RakebackSetVo();
                        newSetVo.setResult(new RakebackSet());
                        newSetVo.getSearch().setId(newRankVo.getResult().getRakebackId());
                        newSetVo = ServiceSiteTool.rakebackSetService().get(newSetVo);
                        //填充玩家名称
                        SysUserVo sysUserVo = new SysUserVo();
                        sysUserVo.setResult(new SysUser());
                        sysUserVo.getSearch().setId(vUserPlayerVo.getResult().getId());
                        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
                        vUserPlayerVo.getResult().setUsername(sysUserVo.getResult().getUsername());

                        //操作日志
                        addLog(request, BussAuditLogDescEnum.PLAYER_PLAYERRANK_SUCCESS.getCode(), vUserPlayerVo, oldRankVo, oldSetVo, newRankVo, newSetVo);
                    }
                }
                resultMap = this.getVoMessage(vUserPlayerVo);
            } else {
                resultMap.put("state", false);
                resultMap.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
            }
        } catch (Exception ex) {
            resultMap.put("state", false);
            resultMap.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
        }
        if(vUserPlayerVo.isSuccess() && StringTool.isBlank(vUserPlayerVo.getResult().getUsername())){
            SysUserVo sysUserVo = new SysUserVo();
            sysUserVo.setResult(new SysUser());
            sysUserVo.getSearch().setId(vUserPlayerVo.getResult().getId());
            sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
            vUserPlayerVo.getResult().setUsername(sysUserVo.getResult().getUsername());
        }
        addDetailLog(request, BussAuditLogDescEnum.PLAYER_PLAYERDETAIL_SUCCESS.getCode(),vUserPlayerVo);


        return resultMap;

    }


    /**
     * 日志
     *
     * @param request
     * @param description 日志描述
     */
    private void addDetailLog(HttpServletRequest request, String description, VUserPlayerVo vo) {
        LogVo logVo = (LogVo) request.getAttribute(SysAuditLog.AUDIT_LOG);
        if (logVo == null) {
            logVo = new LogVo();
        }

        BaseLog baseLog = logVo.addBussLog();
        baseLog.setModule(Module.PLAYER);
        baseLog.setModuleType(ModuleType.PLAYER_PLAYE_SUCCESS);
        baseLog.setOpType(OpType.UPDATE);
        baseLog.setDescription(description);
        baseLog.setEntityId(vo.getResult().getId());
        baseLog.setEntityUserId(vo.getResult().getId());
        baseLog.setEntityUsername(vo.getResult().getUsername());
        baseLog.addParam(vo.getResult().getUsername());
        request.setAttribute(SysAuditLog.AUDIT_LOG, logVo);
    }



    /**
     * 是否发送消息和邮件通知
     *
     * @return
     */
    private Map<String, Object> getIsPubMsg() {
        NoticeTmplVo vo = new NoticeTmplVo();
        vo.getSearch().setEventType(AutoNoticeEvent.CHANGE_PLAYER_DATA.getCode());
        return ServiceSiteTool.noticeTmplService().searchNoticeTmplByEventType(vo);
    }

    @RequestMapping({"/getLanguagePlayerCount"})
    @ResponseBody
    public Long getLanguagePlayerCount(VUserPlayerListVo listVo) {
        return this.getService().count(listVo);

    }

    @RequestMapping("/rakeback/list")
    public String getRakeback(UserPlayerVo userPlayerVo, Model model) {
        userPlayerVo = getService().getRakebackSet(userPlayerVo);
        model.addAttribute("userPlayerVo", userPlayerVo);
        return RAKEBACK_INDEX;
    }

    @RequestMapping("/rakeback/changeRakeback")
    @ResponseBody
    public Map chagneRakeback(UserPlayerVo userPlayerVo) {
        userPlayerVo = getService().changeRakeback(userPlayerVo);
        return getVoMessage(userPlayerVo);
    }

    @RequestMapping("/rakeback/chagneRakebackByParent")
    @ResponseBody
    public Map chagneRakebackByParent(UserPlayerVo userPlayerVo) {
        userPlayerVo = getService().changeRakebackByParent(userPlayerVo);
        return getVoMessage(userPlayerVo);
    }

    @RequestMapping("/savePreview")
    public String savePreview(PlayerDisable playerDisable, Model model) {
        model.addAttribute("command", playerDisable);
        return getViewBasePath() + "Preview";
    }


    @RequestMapping("/view/")
    public String stopAccount() {
        return null;
    }


    private void countFavorableNumAndMoney(Integer playerId, Model model) {

        PlayerTransactionListVo playerTransactionListVo = new PlayerTransactionListVo();
        playerTransactionListVo.getSearch().setPlayerId(playerId);
        playerTransactionListVo.getSearch().setStatus(CommonStatusEnum.SUCCESS.getCode());
        long count = ServiceSiteTool.getPlayerTransactionService().countFavorable(playerTransactionListVo);
        model.addAttribute("count", count);

        Double favorableValue = ServiceSiteTool.getPlayerTransactionService().countPlayerFavorable(playerTransactionListVo);
        model.addAttribute("favorableVal", favorableValue);
    }

    @RequestMapping("/getUserNames")
    @ResponseBody
    public Map getUserNames(String ids) {
        Map map = new HashMap();
        if (StringTool.isBlank(ids)) {
            return map;
        }
        String[] allIds = ids.split(",");
        List<Integer> searchIds = new ArrayList<>();
        for (String id : allIds) {
            if (StringTool.isNotBlank(id)) {
                searchIds.add(Integer.valueOf(id));
            }
        }
        VUserPlayerVo playerVo = new VUserPlayerVo();
        playerVo.getSearch().setIds(searchIds);
        List<SysUser> sysUsers = getService().queryUserNameByIds(playerVo);
        String username = CollectionTool.extractToString(sysUsers, SysUser.PROP_USERNAME, ",");
        map.put("usernames", username);
        return map;
    }

    @RequestMapping("/updatePlayerRealName")
    @Audit(module = Module.PLAYER, moduleType = ModuleType.PLAYER_REALNAME_SUCCESS, opType = OpType.UPDATE)
    @ResponseBody
    public Map updatePlayerRealName(HttpServletRequest request, UserPlayerVo userPlayerVo) {
        //旧的玩家真实姓名
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.setResult(new SysUser());
        sysUserVo.getSearch().setId(userPlayerVo.getResult().getId());
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);

        Map map = new HashMap();
        if (userPlayerVo.getResult() == null || userPlayerVo.getResult().getId() == null || StringTool.isBlank(userPlayerVo.getRealName())) {
            map.put("state", false);
            return map;
        }
        userPlayerVo.getSearch().setId(userPlayerVo.getResult().getId());
        boolean flag = ServiceSiteTool.userPlayerService().updatePlayerRealName(userPlayerVo);
        if (flag) {
            //操作日志
            //日志参数,日志vo
            List<String> list = new ArrayList<>();
            list.add(sysUserVo.getResult().getUsername());
            list.add(sysUserVo.getResult().getRealName() != null ? sysUserVo.getResult().getRealName() : null);
            list.add(userPlayerVo.getRealName());
            AddLogVo addLogVo = new AddLogVo();
            addLogVo.setResult(new SysAuditLog());
            addLogVo.setList(list);
            AuditLogController.addLog(request, "player.realname.success", addLogVo);
        }
        map.put("state", flag);
        if (flag) {
            SessionManagerCommon.resetUserSession(userPlayerVo.getResult().getId());
        }
        return map;
    }

    /**
     * 这里只用于修改玩家状态为正常值
     *
     * @param sysUserVo
     * @return
     */
    @RequestMapping("/updatePlayerStatus")
    @ResponseBody
    @Audit(module = Module.PLAYER, moduleType = ModuleType.USER_CANCEL_FREEZE, opType = OpType.UPDATE)
    public Map updatePlayerStatus(SysUserVo sysUserVo) {
        Map map = new HashMap();
        if (sysUserVo.getResult() == null || sysUserVo.getResult().getId() == null || StringTool.isBlank(sysUserVo.getResult().getStatus())) {
            map.put("state", false);
            return map;
        }
        try {
            sysUserVo.getResult().setUpdateUser(SessionManager.getUserId());
            sysUserVo.getResult().setUpdateTime(new Date());

            sysUserVo = ServiceSiteTool.vUserPlayerService().updateUserPlayerStatus(sysUserVo);
            map.put("state", sysUserVo.isSuccess());
            //日志
            if(sysUserVo.isSuccess()){
                addNormalStatusLog(sysUserVo);
            }
        } catch (Exception ex) {
            map.put("state", false);
        }

        return map;
    }

    /**
     * 日志
     * @param sysUserVo
     */
    private void addNormalStatusLog(SysUserVo sysUserVo) {
        try {
            sysUserVo.getSearch().setId(sysUserVo.getResult().getId());
            sysUserVo = sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
            BussAuditLogTool.addBussLog(Module.PLAYER, ModuleType.USER_CANCEL_FREEZE, OpType.UPDATE, "PLAYER_CANCELACCOUNTFREEZE", sysUserVo.getResult().getUsername());
        } catch (Exception ex) {
            sysUserVo.getSearch().setId(sysUserVo.getResult().getId());
        }
    }

    @RequestMapping("/updateAgentLine")
    @ResponseBody
    @Audit(module = Module.PLAYER, moduleType = ModuleType.PLAYER_UPDATEAGENTLINE_SUCCESS, opType = OpType.UPDATE)
    public Map updateAgentLine(HttpServletRequest request, UserPlayerVo userPlayerVo, Integer oldagentId, String username) {
        Map map = new HashMap(2, 1f);
        if (userPlayerVo.getResult() == null || userPlayerVo.getResult().getId() == null || userPlayerVo.getResult().getUserAgentId() == null) {
            map.put("state", false);
            return map;
        }
        try {
            UserPlayer userPlayer = userPlayerVo.getResult();
            Integer agentId = userPlayer.getUserAgentId();
            SysUser sysUser = new SysUser();
            sysUser.setId(userPlayer.getId());
            sysUser.setOwnerId(agentId);
            //更新user_player和sys_user的数据
            userPlayerVo.setSysUser(sysUser);
            userPlayerVo = ServiceSiteTool.userPlayerService().updateAgentData(userPlayerVo);
            //组装操作日志的数据
            getLogData(request, oldagentId,agentId ,userPlayer);
            map.put("state", userPlayerVo.isSuccess());
        } catch (Exception ex) {
            ex.printStackTrace();
            map.put("state", false);
        }

        return map;
    }

    private void getLogData(HttpServletRequest request, Integer oldagentId,Integer nweAgentId, UserPlayer userPlayer) {
        try {
            VUserPlayerVo vUserPlayerVo = new VUserPlayerVo();
            vUserPlayerVo.getSearch().setId(userPlayer.getId());
            vUserPlayerVo = getService().get(vUserPlayerVo);
            String oldAgentLines = this.getAgentLine(oldagentId);
            String newAgentLines = this.getAgentLine(nweAgentId);
            List<String> list = new ArrayList<>();
            list.add(oldAgentLines);
            list.add(newAgentLines);
            list.add(vUserPlayerVo.getResult() == null ? "" : vUserPlayerVo.getResult().getUsername());
            AddLogVo addLogVo = new AddLogVo();
            SysAuditLog sysAuditLog = new SysAuditLog();
            sysAuditLog.setEntityUserId(userPlayer.getId());
            sysAuditLog.setEntityId(Long.valueOf(userPlayer.getId()));
            addLogVo.setResult(sysAuditLog);
            addLogVo.setList(list);
            //操作日志
            AuditLogController.addLog(request, "player.updateAgentLine.success", addLogVo);
        } catch (Exception ex) {

        }

    }

    private String getAgentLine(Integer agentId) {
        UserAgentVo userAgentVo = new UserAgentVo();
        userAgentVo.getSearch().setId(agentId);
        Map map = ServiceSiteTool.userAgentService().queryAgentLine(userAgentVo);
        String agentName = this.getAgentNameByAgentId(agentId);
        StringBuilder agentLine = new StringBuilder(MapTool.getString(map, "parent_name_array") == null ? "" : MapTool.getString(map, "parent_name_array"));
        agentLine.append(" > " + agentName);
        return agentLine.toString();
    }

    private String getAgentNameByAgentId(Integer agentId) {
        VUserAgentVo vo = new VUserAgentVo();
        vo.getSearch().setId(agentId);
        vo = ServiceSiteTool.vUserAgentService().search(vo);
        String agentName = vo.getResult().getUsername();
        return agentName;
    }

    @RequestMapping("/updatePlayerRank")
    @Audit(module = Module.PLAYER, moduleType = ModuleType.PLAYER_PLAYERRANK_SUCCESS, opType = OpType.UPDATE)
    @ResponseBody
    public Map updatePlayerRank(HttpServletRequest request, UserPlayerVo userPlayerVo) {
        Map map = new HashMap();
        if (userPlayerVo.getResult() == null || userPlayerVo.getResult().getId() == null || userPlayerVo.getResult().getRankId() == null) {
            map.put("state", false);
            return map;
        }
        try {
            PlayerRankVo rankVo = new PlayerRankVo();
            rankVo.getSearch().setId(userPlayerVo.getResult().getRankId());
            rankVo = ServiceSiteTool.playerRankService().get(rankVo);
            if (rankVo.getResult() != null && rankVo.getResult().getRakebackId() != null) {
                userPlayerVo.getResult().setRakebackId(rankVo.getResult().getRakebackId());
            } else {
                userPlayerVo.getResult().setRakebackId(0);
            }
            userPlayerVo.setProperties(UserPlayer.PROP_RANK_ID, UserPlayer.PROP_RAKEBACK_ID);
            userPlayerVo = ServiceSiteTool.userPlayerService().updateOnly(userPlayerVo);

            if (!userPlayerVo.getResult().getOldRankId().equals(userPlayerVo.getResult().getRankId())) {
                //旧的rankId 和　返水方案
                PlayerRankVo oldRankVo = new PlayerRankVo();
                oldRankVo.setResult(new PlayerRank());
                oldRankVo.getSearch().setId(Integer.valueOf(userPlayerVo.getResult().getOldRankId()));
                oldRankVo = ServiceSiteTool.playerRankService().get(oldRankVo);
                RakebackSetVo oldSetVo = new RakebackSetVo();
                oldSetVo.setResult(new RakebackSet());
                oldSetVo.getSearch().setId(oldRankVo.getResult().getRakebackId());
                oldSetVo = ServiceSiteTool.rakebackSetService().get(oldSetVo);
                //新的rankId 和　返水方案
                PlayerRankVo newRankVo = new PlayerRankVo();
                newRankVo.setResult(new PlayerRank());
                newRankVo.getSearch().setId(userPlayerVo.getResult().getRankId());
                newRankVo = ServiceSiteTool.playerRankService().get(newRankVo);
                RakebackSetVo newSetVo = new RakebackSetVo();
                newSetVo.setResult(new RakebackSet());
                newSetVo.getSearch().setId(newRankVo.getResult().getRakebackId());
                newSetVo = ServiceSiteTool.rakebackSetService().get(newSetVo);
                //填充玩家名称
                SysUserVo sysUserVo = new SysUserVo();
                sysUserVo.setResult(new SysUser());
                sysUserVo.getSearch().setId(userPlayerVo.getResult().getId());
                sysUserVo = ServiceTool.sysUserService().get(sysUserVo);

                List<String> list = new ArrayList<>();
                list.add(sysUserVo.getResult().getUsername());
                list.add(oldRankVo.getResult().getRankName());
                list.add(newRankVo.getResult().getRankName());
                list.add(oldSetVo.getResult().getName());
                list.add(newSetVo.getResult().getName());
                AddLogVo addLogVo = new AddLogVo();
                addLogVo.setResult(new SysAuditLog());
                addLogVo.setList(list);
                //操作日志
                AuditLogController.addLog(request, "player.playerRank.success", addLogVo);
            }


            map.put("state", userPlayerVo.isSuccess());
        } catch (Exception ex) {
            ex.printStackTrace();
            map.put("state", false);
        }

        return map;
    }

    @RequestMapping("/detect")
    public String detect(VUserPlayerVo userPlayerVo, Model model) {
        userPlayerVo = doView(userPlayerVo, model);
        try {
            String convertRealName = URLEncoder.encode(URLEncoder.encode(userPlayerVo.getResult().getRealName(), org.soul.commons.init.context.Const.DEFAULT_CHARACTER), org.soul.commons.init.context.Const.DEFAULT_CHARACTER);
            userPlayerVo.setConvertRealName(convertRealName);
        } catch (Exception ex) {
            userPlayerVo.setConvertRealName(userPlayerVo.getResult().getRealName());
        }
        model.addAttribute("command", userPlayerVo);
        baseInfoRepeatNum(model, userPlayerVo.getResult());
        model.addAttribute("unencryption", SessionManager.checkPrivilegeStatus());
        return "/player/view.include/PlayerDetectionData";
    }

    private void baseInfoRepeatNum(Model model, VUserPlayer player) {
        UserPlayerVo userPlayerVo = new UserPlayerVo();
        userPlayerVo.setPropertiesMap(userInfoQueryMap(player));
        model.addAttribute("repeatNum", ServiceSiteTool.userPlayerService().queryRepeatNum(userPlayerVo));
    }

    private Map userInfoQueryMap(VUserPlayer userPlayer) {
        Map propertiesMap = new HashMap();
        propertiesMap.put("playerId", userPlayer.getId());
        propertiesMap.put(SysUser.PROP_REAL_NAME, StringTool.isBlank(userPlayer.getRealName()) ? null : userPlayer.getRealName());
        propertiesMap.put("mobile", CryptoTool.aesEncrypt(userPlayer.getMobilePhone(), CryptoKey.KEY_NOTICE_CONTACT_WAY));
        propertiesMap.put("skype", CryptoTool.aesEncrypt(userPlayer.getSkype(), CryptoKey.KEY_NOTICE_CONTACT_WAY));
        propertiesMap.put("qq", CryptoTool.aesEncrypt(userPlayer.getQq(), CryptoKey.KEY_NOTICE_CONTACT_WAY));
        propertiesMap.put("msn", CryptoTool.aesEncrypt(userPlayer.getMsn(), CryptoKey.KEY_NOTICE_CONTACT_WAY));
        propertiesMap.put("weixin", CryptoTool.aesEncrypt(userPlayer.getWeixin(), CryptoKey.KEY_NOTICE_CONTACT_WAY));
        propertiesMap.put("email", CryptoTool.aesEncrypt(userPlayer.getMail(), CryptoKey.KEY_NOTICE_CONTACT_WAY));
        propertiesMap.put(SysUser.PROP_LOGIN_IP, userPlayer.getLastLoginIp());
        propertiesMap.put(SysUser.PROP_REGISTER_IP, userPlayer.getRegisterIp());
        return propertiesMap;
    }

    @RequestMapping("/fetchRemarkList")
    public String fetchRemarkList(RemarkListVo remarkListVo, Model model) {
        if (remarkListVo.getSearch().getEntityUserId() != null) {
            //remarkListVo.getPaging().setPageSize(50);
            remarkListVo = queryUserRemark(remarkListVo);
            model.addAttribute("remarkListVo", remarkListVo);
        }

        return "/player/view.include/PlayerRemarkList";
    }

    @RequestMapping("/checkBankcardIsExist")
    @ResponseBody
    public boolean checkBankcardIsExist(@FormModel UserBankcardForm userBankcardForm, HttpServletRequest request) {
        if (userBankcardForm == null) {
            return true;
        }
        UserBankcardVo vo = new UserBankcardVo();
        vo.getSearch().setBankcardNumber(userBankcardForm.getResult_bankcardNumber());
        vo.getSearch().setUserType(UserTypeEnum.PLAYER.getCode());
        UserBankcard isExists = ServiceSiteTool.userBankcardService().cardIsExists(vo);
        if (isExists == null) {
            return true;
        }
        String userId = userBankcardForm.getResult_userId();
        String parameter = request.getParameter("result.id");
        if (StringTool.isNotBlank(parameter)) {
            Integer id = Integer.valueOf(parameter);
            if (!id.equals(isExists.getId())) {
                return false;
            }
        } else {
            if (!isExists.getUserId().equals(Integer.valueOf(userId))) {
                return false;
            }

        }
        return true;
    }

    @RequestMapping("/queryUserPlayerById")
    @ResponseBody
    public Map queryUserPlayerById(VUserPlayerVo userPlayerVo) {
        Map map = new HashMap();
        if (userPlayerVo.getSearch().getId() == null) {
            return map;
        }
        userPlayerVo = getService().get(userPlayerVo);
        VUserPlayer result = userPlayerVo.getResult();
        if (result != null) {
            Double totalAssets = result.getTotalAssets();
            String totalAsset = CurrencyTool.formatInteger(totalAssets) + CurrencyTool.formatDecimals(totalAssets);
            Double walletBalance = result.getWalletBalance();
            String balance = CurrencyTool.formatInteger(walletBalance) + CurrencyTool.formatDecimals(walletBalance);
            map.put("totalAsset", totalAsset);
            map.put("balance", balance);

            Integer userAgentRank = getUserAgentRank(result.getAgentId());
            map.put("agentId", result.getAgentId());
            map.put("agentRank", userAgentRank);
            map.put("agentName", result.getAgentName());
        }
        return map;
    }

    private Integer getUserAgentRank(Integer agentId) {
        if (agentId == null) {
            return null;
        }
        UserAgentVo userAgentVo = new UserAgentVo();
        userAgentVo.getSearch().setId(agentId);
        userAgentVo = ServiceSiteTool.userAgentService().get(userAgentVo);
        if (userAgentVo.getResult() != null) {
            return userAgentVo.getResult().getAgentRank();
        }
        return null;
    }



    /**
     * 日志
     *
     * @param request
     * @param description 日志描述
     */
    private void addLog(HttpServletRequest request, String description, VUserPlayerVo vo, PlayerRankVo oldRankVo, RakebackSetVo oldSetVo, PlayerRankVo newRankVo, RakebackSetVo newSetVo) {
        LogVo logVo = (LogVo) request.getAttribute(SysAuditLog.AUDIT_LOG);
        if (logVo == null) {
            logVo = new LogVo();
        }

        BaseLog baseLog = logVo.addBussLog();
        baseLog.setDescription(description);
        baseLog.setEntityId(vo.getResult().getId());
        baseLog.setEntityUserId(vo.getResult().getId());
        baseLog.setEntityUsername(vo.getResult().getUsername());
        baseLog.addParam(vo.getResult().getUsername())
                .addParam(oldRankVo.getResult().getRankName())
                .addParam(newRankVo.getResult().getRankName())
                .addParam(oldSetVo.getResult().getName())
                .addParam(newSetVo.getResult().getName());
        request.setAttribute(SysAuditLog.AUDIT_LOG, logVo);
    }

    @RequestMapping("/saveRemark")
    @ResponseBody
    public Map saveRemark(SysUserVo sysUserVo) {
        Map map = new HashMap();
        if (sysUserVo.getResult() == null || sysUserVo.getResult().getId() == null) {
            map.put("state", false);
        }
        sysUserVo.getResult().setUpdateUser(SessionManager.getUserId());
        sysUserVo.getResult().setUpdateTime(new Date());
        sysUserVo.setProperties(SysUser.PROP_MEMO, SysUser.PROP_UPDATE_USER, SysUser.PROP_UPDATE_TIME);
        sysUserVo = ServiceTool.sysUserService().updateOnly(sysUserVo);
        map.put("state", sysUserVo.isSuccess());
        BussAuditLogTool.addBussLog(Module.PLAYER, ModuleType.PLAYER_PLAYERRANK_SUCCESS, OpType.UPDATE, BussAuditLogDescEnum.PLAYER_PLAYERRANK_SUCCESS.getCode(),
                sysUserVo.getResult().getUpdateUser().toString());
        return map;
    }

    @RequestMapping("/queryPlayerMoney")
    @ResponseBody
    public Map queryPlayerMoney(Integer playerId) {
        Map map = new HashMap();
        if (playerId == null) {
            return map;
        }
        PlayerTransactionListVo playerTransactionListVo = new PlayerTransactionListVo();
        playerTransactionListVo.getSearch().setPlayerId(playerId);
        playerTransactionListVo.getSearch().setStatus(CommonStatusEnum.SUCCESS.getCode());
        map = ServiceSiteTool.getPlayerTransactionService().queryPlayerAllSumMoney(playerTransactionListVo);
        return map;
    }

    @RequestMapping("/export")
    @ResponseBody
    @Audit(module = Module.PLAYER, moduleType = ModuleType.PLAYER_EXPORTPLAYER_SUCCESS, opType = OpType.OTHER)
    public Map export(VUserPlayerListVo listVo, SysExportVo sysExportVo, Model model) {
        if (StringTool.isNotBlank(sysExportVo.getQueryParamsJson())) {
            //这里是查询后是固定了查询条件，不会因为条件改变而改变
            IEntity exportObject = JsonTool.fromJson(sysExportVo.getQueryParamsJson(), listVo.getSearch().getClass());
            sysExportVo.setExportObject(exportObject);
        } else {
            //如果没有根据sysExportVo.getQueryParamsJson()查询，那有可能导出的数据和列表数据不对。
            //如果列表修改了条件，但是没有点搜索，直接导出就会有该问题。
            sysExportVo.setExportObject(listVo.getSearch());
        }
        return doExport(listVo, sysExportVo, model);
    }

    private SysExportVo buildExportData(VUserPlayerListVo listVo, SysExportVo vo) {
        if (vo.getResult() == null) {
            vo.setResult(new SysExport());
        }
        vo.getResult().setService(IVUserPlayerService.class.getName());
        if (listVo.getComp() == null) {
            vo.getResult().setMethod("searchByCustom");
        } else {
            if (listVo.getComp() == 1) {    // 新增玩家的存款玩家
                vo.getResult().setMethod("queryOutLinkPlayer");
            } else if (listVo.getComp() == 2) { // 存款玩家
                vo.getResult().setMethod("queryOutLinkRechargePlayer");
            } else if (listVo.getComp() == 3) { // 投注玩家
                vo.getResult().setMethod("queryOutLinkBetPlayer");
            }

        }
        //vo.setTemplateFileName("gb/0/exportTemplate/232/1516517552234.xls");
        vo.setExportFileType(ExportFileTypeEnum.PLAYER_MANAGE.getCode());
        vo.setExportLocale(SessionManager.getLocale().toString());
        vo.getResult().setParam(VUserPlayerListVo.class.getName());
        vo.getResult().setUsername(SessionManager.getUserName());
        vo.getResult().setExportUserId(SessionManager.getUserId());
        vo.getResult().setExportUserSiteId(SessionManager.getSiteId());
        if (vo.getResult().getSiteId() == null) {
            vo.getResult().setSiteId(SessionManager.getSiteId());
        }
        vo.getResult().setFileName(LocaleTool.tranView("export", "player_manage") + "-"
                + DateTool.formatDate(DateQuickPicker.getInstance().getNow(), SessionManager.getTimeZone(), "yyyyMMddHHmmss"));
        if (vo.isNeedCallBack()) {
            vo.setCallbackClass(IUserPlayerService.class.getName());
            vo.setCallbackMethod("updateUserPlayerExportStatus");
        }
        return vo;
    }

    protected Map doExport(VUserPlayerListVo listVo, SysExportVo vo, Model model) {
        Map result = new HashMap();
        try {
            vo = buildExportData(listVo, vo);
            if (vo == null || vo.getResult() == null) {
                result.put("state", false);
                return result;
            }
            SysParam sysParam = getExportParam();
            if (sysParam != null && "false".equals(sysParam.getParamValue())) {
                result.put("state", false);
                return result;
            }
            vo = ServiceTool.sysExportService().doExport(vo);
            if (vo.isSuccess()) {
                TaskScheduleVo taskScheduleVo = new TaskScheduleVo();
                taskScheduleVo.setResult(new TaskSchedule(SysExportVo.EXPORT_SCHEDULE_CODE));
                ITaskScheduleService taskScheduleService = ServiceScheduleTool.getTaskScheduleService();
                taskScheduleService.runOnceTask(taskScheduleVo, vo);
            }
            result.put("state",vo.isSuccess());
            //记录日志
            if (vo.isSuccess()){
                BussAuditLogTool.addLog("PLAYER_EXPORTPLAYER_SUCCESS","");
            }
        } catch (Exception ex) {
            LogFactory.getLog(this.getClass()).error(ex, "导出失败");
            result.put("state", false);
        }
        return result;
    }

    @RequestMapping("/getRank/{agentRank}")
    @ResponseBody
    public String getRank(@PathVariable("agentRank") Integer agentRank) {
        VUserAgentManageListVo listVo = new VUserAgentManageListVo();
        listVo.getSearch().setAgentRank(agentRank);
        List<VUserAgentManage> result = ServiceSiteTool.vUserAgentManageService().queryAgentByAgentRank(listVo);
        return JsonTool.toJson(result);
    }

    @RequestMapping("/queryAgentLine")
    @ResponseBody
    public Map queryAgentLine(Integer agentId) {
        UserAgentVo userAgentVo = new UserAgentVo();
        userAgentVo.getSearch().setId(agentId);
        Map map = ServiceSiteTool.userAgentService().queryAgentLine(userAgentVo);
        return map;
    }


    @RequestMapping(value = "/checkUserNameExist")
    @ResponseBody
    public String checkUserNameExist(@RequestParam("result.username") String userName) {
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setSubsysCode(SubSysCodeEnum.PCENTER.getCode());
        sysUserVo.getSearch().setUsername(userName);
        sysUserVo.getSearch().setSiteId(SessionManager.getSiteId());
        String existAgent = ServiceSiteTool.userAgentService().isExistAgent(sysUserVo);
        return existAgent;
    }

    @RequestMapping("/passwordNotWeak")
    @ResponseBody
    public String passwordNotWeak(@RequestParam("result.password") String password, @RequestParam("result.username") String username) {
        if (StringTool.isBlank(password))
            return "false";
        if (password.equals(username)) {
            return "false";
        }
        if (PasswordRule.isWeak(password)) {
            return "false";
        }

        return "true";
    }

    /**
     * 批量冻结账号
     *
     * @param
     * @return
     */
    @RequestMapping("/changeStatus")
    @ResponseBody
    @Audit(module = Module.PLAYER, moduleType = ModuleType.USER_FREEZE, opType = OpType.UPDATE)
    public Map changeStatus(Integer[] ids) {
        VUserPlayerListVo listVo = new VUserPlayerListVo();
        listVo.setMasterName(SessionManager.getUserName());
        listVo.getSearch().setIds(Arrays.asList(ids));
        Map map = new HashMap(2, 1f);
        try {
            VUserPlayerListVo vUserPlayerListVo = ServiceSiteTool.userPlayerService().batchFreezenAccount(listVo);
            if (vUserPlayerListVo.isSuccess()) {
                for (Integer id : ids) {
                    KickoutFilter.loginKickoutAll(id, OpMode.MANUAL, "站长中心冻结玩家强制踢出");
                }
                map = getVoMessage(listVo);
            }
            if (vUserPlayerListVo.isSuccess()) {
                BussAuditLogTool.addBussLog(Module.PLAYER,ModuleType.USER_FREEZE,OpType.AUDIT.UPDATE,BussAuditLogDescEnum.PLAYER_SETFREEZEACCOUNT_SUCCESS.getCode(),vUserPlayerListVo.getOperatedName());
            }
        } catch (Exception ex) {
            map.put("state", false);
            map.put("msg", "操作失败");
            LOG.error(ex, "批量冻结账户失败！");
        }

        return map;
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
    /*
    * 远程表单校验注册IP
    *
    * */
    @RequestMapping(value = "/checkRegIp")
    @ResponseBody
    public boolean checkRegIp(@RequestParam("search.registerIpv4") String ip){
        Map map = fetchStartEndIp(ip);
        return MapTool.getBoolean(map,"state");
    }
    /*
    *
    * 远程校验登录ip
    * */
    @RequestMapping(value = "/checkLoginIp")
    @ResponseBody
    public boolean checkLoginIp(@RequestParam("search.lastLoginIpv4") String ip){
        Map map = fetchStartEndIp(ip);
        return MapTool.getBoolean(map,"state");
    }

    /**
     * 添加修改玩家风控标识
     * Created by orange
     *
     * @param userPlayerVo
     * @param model
     * @return
     */
    @RequestMapping("/editRiskLabel")
    public String editRiskLabel(UserPlayerVo userPlayerVo, Model model) {
        //查询玩家风控标识
        userPlayerVo = ServiceSiteTool.userPlayerService().get(userPlayerVo);
        //数据库中的字符串00000111的代码转化成Set<String>方便页面展示
        getRisk2Set(userPlayerVo);

        //获得字典中的风控标识列表
        Map<String, SysDict> riskDicts = DictTool.get(DictEnum.PLAYER_RISK_DATA_TYPE);
        model.addAttribute("command", userPlayerVo);
        model.addAttribute("riskDicts", riskDicts);
        return EDIT_RISK_LABEL;
    }

    /**
     * 保存玩家风控标识
     * Created by orange
     *
     * @param userPlayerVo
     * @return
     */
    @RequestMapping("/saveRiskLabel")
    @ResponseBody
    @Audit(module = Module.PLAYER, moduleType = ModuleType.PLAYER_RISK_SUCCESS, opType = OpType.UPDATE)
    public Map saveRiskLabel(UserPlayerVo userPlayerVo) {

        Map regMap = MapTool.newHashMap();
        //把页面传入的xx;yy;zz;转成数据库中的字符串00000111的代码方便存储
        setRiskSet(userPlayerVo);
        userPlayerVo.setProperties(UserPlayer.PROP_RISK_DATA_TYPE);
        userPlayerVo = ServiceSiteTool.userPlayerService().updateOnly(userPlayerVo);

        //是否推送总控
        Boolean is2Boss = StringTool.isNotBlank(userPlayerVo.getResult().getRiskDataType());

        //日志;添加完日志后，userPlayerVo的risk值有改变，后续使用注意
        addModifyRiskLog(userPlayerVo);

        //推送到总控
        if (userPlayerVo.isSuccess() && is2Boss) {

            //设置风控审核数据内容
            RiskManagementCheckVo riskManagementVo = new RiskManagementCheckVo();
            RiskManagementCheck riskManagement = new RiskManagementCheck();
            riskManagement.setCreateTime(DateQuickPicker.getInstance().getNow());
            riskManagement.setCreateUserId(SessionManager.getUserId());
            riskManagement.setCreateUserName(SessionManager.getUserName());
            riskManagement.setSiteId(SessionManager.getSiteId());
            riskManagementVo.setResult(riskManagement);
            //查询其他按数据并发送
            userPlayerVo = ServiceSiteTool.vUserPlayerService().addRiskToBoss(userPlayerVo, riskManagementVo);
        }

        if (userPlayerVo.isSuccess()) {
            regMap.put("state", true);
        } else {
            regMap.put("state", false);
        }
        return this.getVoMessage(userPlayerVo);
    }


    /**
     * 风控修改日志
     * <br>添加完日志后，userPlayerVo的risk值有改变，后续使用注意
     * @param userPlayerVo
     *
     */
    private void addModifyRiskLog(UserPlayerVo userPlayerVo){

        //修改后的数据国际化
        getRisk2Set(userPlayerVo);
        String risk = " ";
        for(String str:userPlayerVo.getResult().getRiskSet()){
            risk+=I18nTool.getI18nMap(SessionManagerCommon.getLocale().toString()).get("views").get("common").get(str);
            risk+=" ";
        }
        //旧数据国际化
        String oldRisk = " ";
        userPlayerVo.getResult().setRiskDataType(userPlayerVo.getResult().getOldRiskDataType());
        getRisk2Set(userPlayerVo);
        for(String str:userPlayerVo.getResult().getRiskSet()){
            oldRisk+=I18nTool.getI18nMap(SessionManagerCommon.getLocale().toString()).get("views").get("common").get(str);
            oldRisk+=" ";
        }
//        if(StringTool.isBlank(risk)){
//            risk = I18nTool.getI18nMap(SessionManagerCommon.getLocale().toString()).get("views").get("player_auto").get("空");
//        }
//        setRisk
//        setRiskSet(oldUserPlayerVo);
        BussAuditLogTool.addLog("PLAYER_RISK_SUCCESS", userPlayerVo.getResult().getId(), SessionManager.getUserName(), oldRisk, risk);
    }


    /**
     * 数据库中风控标识的字符串00000111的代码转化成Set<String>方便页面展示
     * @param userPlayerVo
     */
    public void getRisk2Set(UserPlayerVo userPlayerVo) {
        String riskDataType = userPlayerVo.getResult().getRiskDataType();
        Set<String> riskSet = new HashSet<>();
        if (StringTool.isNotBlank(riskDataType) && riskDataType.length()==8) {
            if (riskDataType.charAt(7) != '0') {
                riskSet.add(PlayerRiskDataTypeEnum.MALICIOUS.getCode());
            }
            if (riskDataType.charAt(6) != '0') {
                riskSet.add(PlayerRiskDataTypeEnum.MONEY_LAUNDERING.getCode());
            }
            if (riskDataType.charAt(5) != '0') {
                riskSet.add(PlayerRiskDataTypeEnum.INTEREST_ARBITRAGE.getCode());
            }
        }
        userPlayerVo.getResult().setRiskSet(riskSet);
    }

    /**
     * 把页面传入的风控标识xx;yy;zz;转成数据库中的字符串00000111的风控标识代码方便存储
     * @param userPlayerVo
     */
    public void setRiskSet(UserPlayerVo userPlayerVo) {
        String riskDataType = userPlayerVo.getResult().getRiskDataType();
        if (StringTool.isNotBlank(riskDataType)) {
            StringBuilder str = new StringBuilder();
            Set<String> set = new HashSet<>(Arrays.asList(riskDataType.split(";")));
            if (set.contains(PlayerRiskDataTypeEnum.INTEREST_ARBITRAGE.getCode())) {
                str.append("1");
            } else {
                str.append("0");
            }
            if (set.contains(PlayerRiskDataTypeEnum.MONEY_LAUNDERING.getCode())) {
                str.append("1");
            } else {
                str.append("0");
            }
            if (set.contains(PlayerRiskDataTypeEnum.MALICIOUS.getCode())) {
                str.append("1");
            } else {
                str.append("0");
            }
            //补足8位
            while (str.length() < 8) {
                str.insert(0, "0");
            }
            userPlayerVo.getResult().setRiskDataType(str.toString());
        }
    }

    @RequestMapping(value = "/fetchPlayerPhoneNumber")
    @ResponseBody
    public Map fetchPlayerPhoneNumber(SysUserVo sysUserVo){
        Map resMap = new HashMap(3,1f);
        Integer userId = sysUserVo.getSearch().getId();
        if(userId == null){
            resMap.put("state",false);
            return resMap;
        }
        resMap = getService().queryPlayerPhoneMessage(sysUserVo);
        //TODO 获取本站点的呼叫中心地址 如果是缓存，从这里设置，如果取表，在service设置
        /** soulButton使用主法，只需要传和玩家ID
         * <soul:button target="callPlayer" text="拔打电话" opType="function" playerId="${command.result.id}">
         <i class="fa fa-flash"></i>
         </soul:button>
         */
        resMap.put("domain","47.52.0.17:8089");
        resMap.put("zxNo",SessionManager.getUser().getIdcard());
        return resMap;
    }

    //endregion
}

