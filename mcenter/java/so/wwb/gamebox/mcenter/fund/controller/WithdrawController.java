package so.wwb.gamebox.mcenter.fund.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionTool;
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
import org.soul.commons.math.NumberTool;
import org.soul.commons.net.IpTool;
import org.soul.commons.net.ServletTool;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.Paging;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.query.sort.Direction;
import org.soul.commons.security.CryptoTool;
import org.soul.commons.security.key.CryptoKey;
import org.soul.commons.support._Module;
import org.soul.model.comet.vo.MessageVo;
import org.soul.model.listop.po.SysListOperator;
import org.soul.model.listop.vo.SysListOperatorListVo;
import org.soul.model.log.audit.enums.OpType;
import org.soul.model.msg.notice.po.NoticeContactWay;
import org.soul.model.msg.notice.vo.NoticeContactWayListVo;
import org.soul.model.msg.notice.vo.NoticeLocaleTmpl;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.model.security.privilege.po.SysUser;
import org.soul.model.security.privilege.vo.SysResourceListVo;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.model.sys.po.SysDict;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.so.SysDictSo;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.controller.NoMappingCrudController;
import org.soul.web.listop.ListOpTool;
import org.soul.web.session.SessionManagerBase;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import so.wwb.gamebox.common.cache.Cache;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.fund.IVPlayerWithdrawService;
import so.wwb.gamebox.mcenter.enmus.ListOpEnum;
import so.wwb.gamebox.mcenter.fund.form.PlayerWithdrawRemindForm;
import so.wwb.gamebox.mcenter.fund.form.VPlayerWithdrawForm;
import so.wwb.gamebox.mcenter.fund.form.VPlayerWithdrawSearchForm;
import so.wwb.gamebox.mcenter.player.form.PlayerTransactionForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.share.form.SysListOperatorForm;
import so.wwb.gamebox.model.*;
import so.wwb.gamebox.model.boss.enums.TemplateCodeEnum;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.common.Const;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.common.notice.enums.AutoNoticeEvent;
import so.wwb.gamebox.model.common.notice.enums.CometSubscribeType;
import so.wwb.gamebox.model.common.notice.enums.ManualNoticeEvent;
import so.wwb.gamebox.model.common.notice.enums.NoticeParamEnum;
import so.wwb.gamebox.model.company.enums.BankEnum;
import so.wwb.gamebox.model.company.enums.BankPayTypeEnum;
import so.wwb.gamebox.model.company.po.Bank;
import so.wwb.gamebox.model.company.setting.po.CurrencyExchangeRate;
import so.wwb.gamebox.model.company.setting.vo.CurrencyExchangeRateVo;
import so.wwb.gamebox.model.company.site.po.SiteCustomerService;
import so.wwb.gamebox.model.company.vo.BankListVo;
import so.wwb.gamebox.model.currency.po.CurrencyRate;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.listop.FilterRow;
import so.wwb.gamebox.model.listop.FilterSelectConstant;
import so.wwb.gamebox.model.listop.TabTypeEnum;
import so.wwb.gamebox.model.master.content.vo.PayAccountListVo;
import so.wwb.gamebox.model.master.content.vo.WithdrawAccountListVo;
import so.wwb.gamebox.model.master.dataRight.DataRightModuleType;
import so.wwb.gamebox.model.master.dataRight.po.SysUserDataRight;
import so.wwb.gamebox.model.master.dataRight.vo.SysUserDataRightVo;
import so.wwb.gamebox.model.master.enums.CurrencyEnum;
import so.wwb.gamebox.model.master.enums.PublishMethodEnum;
import so.wwb.gamebox.model.master.enums.RankFeeType;
import so.wwb.gamebox.model.master.enums.RemarkEnum;
import so.wwb.gamebox.model.master.fund.enums.*;
import so.wwb.gamebox.model.master.fund.po.PlayerRecharge;
import so.wwb.gamebox.model.master.fund.po.PlayerWithdraw;
import so.wwb.gamebox.model.master.fund.po.VPlayerWithdraw;
import so.wwb.gamebox.model.master.fund.so.PlayerWithdrawSo;
import so.wwb.gamebox.model.master.fund.so.VPlayerWithdrawSo;
import so.wwb.gamebox.model.master.fund.vo.PlayerRechargeVo;
import so.wwb.gamebox.model.master.fund.vo.PlayerWithdrawVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerWithdrawListVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerWithdrawVo;
import so.wwb.gamebox.model.master.player.po.PlayerRank;
import so.wwb.gamebox.model.master.player.po.PlayerTransaction;
import so.wwb.gamebox.model.master.player.po.Remark;
import so.wwb.gamebox.model.master.player.po.VUserPlayer;
import so.wwb.gamebox.model.master.player.vo.*;
import so.wwb.gamebox.model.master.report.so.VPlayerTransactionSo;
import so.wwb.gamebox.model.master.report.vo.VPlayerTransactionVo;
import so.wwb.gamebox.model.master.setting.vo.NoticeTmplVo;
import so.wwb.gamebox.web.*;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.*;


/**
 * 资金管理
 * <p/>
 * Created by Orange on 2015-08-14.
 */
@Controller
@RequestMapping(value = "/fund/withdraw")
public class WithdrawController extends NoMappingCrudController<IVPlayerWithdrawService, VPlayerWithdrawListVo, VPlayerWithdrawVo, VPlayerWithdrawSearchForm, VPlayerWithdrawForm, VPlayerWithdraw, Integer> {

    private static final Log LOG = LogFactory.getLog(WithdrawController.class);

    @InitBinder
    public void initListBinder(WebDataBinder binder) {
        // 设置需要包裹的元素个数，默认为256d
        binder.setAutoGrowCollectionLimit(1024);
    }

    //region Orange code
    private static final String WITHDRAW_INDEX_URL = "/fund/withdraw/Index";
    private static final String WITHDRAW_INDEX_PARIAL_URl = "/fund/withdraw/IndexPartial";
    private static final String WITHDRAW_VIEW_URl = "/fund/withdraw/WithdrawView";
    private static final String WITHDRAW_AUDIT_VIEW_URl = "/fund/withdraw/WithdrawAuditView";
    private static final String RECHARGE_PUT_CONFIRM_CHECK_PASS_URI = "/fund/withdraw/PutConfirmOK";
    //提现记录-选择审核失败原因
    public static final String RECHARGE_PUT_CHECK_FAILURE_URI = "/fund/withdraw/PutConfirmError";
    //提现记录-拒绝申请原因
    public static final String RECHARGE_PUT_CHECK_REFUSES_URI = "/fund/withdraw/PutConfirmRefuses";
    //取款审核-未通过稽核
    public static final String WITHDRAW_NOSUDIT_URI = "fund/withdraw/NoAudit";
    //取款审核-二次确认未通过稽核
    public static final String WITHDRAW_NOSUDITPAGE_URI = "fund/withdraw/NoAuditPage";
    //修改稽核
    public static final String WITHDRAW_EDIT_AUDIT_URI = "fund/withdraw/EditAudit";
    //提醒
    public static final String REMIND_URI = "fund/withdraw/Remind";
    //取款
    public static final String PLAYER_DETECT_URI = "fund/withdraw/PlayerDetect";
    //比特币兑换页面
    public static final String WITHDRAW_EXCHANGE_BIT = "/fund/withdraw/Exchange";

    //站长中心-玩家取款审核url
    private static final String MCENTER_PLAYER_WITHDRAW_URL = "fund/withdraw/withdrawAuditView.html";
    //保存出款账户
    public static final String WITHDRAW_ACCOUNT = "fund/withdraw/WithdrawAccount";
    //选择出款账户
    public static final String SELECT_WITHDRAW_ACCOUNT = "fund/withdraw/SelectWithdrawAccount";
    //出款详细页面
    private static final String WITHDRAW_STATUS_VIEW_URl = "/fund/withdraw/withdrawStatusView";
    //确认重新出款页面
    private static final String WITHDRAW_STATUS_REVIEW_URl = "/fund/withdraw/withdrawStatusReview";

    @Override
    protected String getViewBasePath() {
        return "fund/withdraw/";
    }


    //修改审核页面提醒
    @RequestMapping("/remind")
    private String remind(Model model) {
        List<SysParam> sysParamList = ServiceSiteTool.playerWithdrawService().searchSysParam(new SysParamVo());//系统参数表
        model.addAttribute("validateRule", JsRuleCreator.create(PlayerWithdrawRemindForm.class));
        model.addAttribute("sysParam", sysParamList.get(0));
        return REMIND_URI;
    }

    @RequestMapping("/submitRemind")
    @ResponseBody
    private Map submitRemind(SysParamVo sysParamVo) {
        sysParamVo.setSuccess(false);
        SysParam param = ParamTool.getSysParam(SiteParamEnum.REMIND);
        sysParamVo.getResult().setId(param.getId());
        sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE, SysParam.PROP_ACTIVE);
        sysParamVo = ServiceTool.getSysParamService().updateOnly(sysParamVo);
        return getVoMessage(sysParamVo);
    }

    /**
     * 查询提现列表
     *
     * @param model
     * @return
     */
    @RequestMapping({"/withdrawList"})
    protected String withdrawList(HttpServletRequest request, VPlayerWithdrawListVo vo, Model model) {
        vo.setValidateRule(JsRuleCreator.create(VPlayerWithdrawSearchForm.class, "search"));
        initListVo(vo);
        if (UserTypeEnum.MASTER_SUB.getCode().equals(SessionManager.getUser().getUserType())) {
            List<SysUserDataRight> sysUserDataRights = querySysUserDataRights();
            buildPlayerRankData(model, sysUserDataRights);
            masterSubSearch(vo, sysUserDataRights);
        } else {
            model.addAttribute("playerRanks", ServiceSiteTool.playerRankService().queryUsableList(new PlayerRankVo()));
        }

        withdrawAccountIsActive(model);//是否开启出款账户
        easyPaymentStatus(model);//是否开启易收付出款入口
        handleVoice(vo, model);// 公司入款声音参数
        handleWithdrawStatus(model);//处理取款状态
        handleTemple(model);//筛选模板
        vo.setThisUserId(SessionManager.getAuditUserId());
        model.addAttribute("command", vo);
        return ServletTool.isAjaxSoulRequest(request) ? WITHDRAW_INDEX_PARIAL_URl : WITHDRAW_INDEX_URL;
    }

    /**
     * 是否开启出款账户
     *
     * @param model
     */
    private void withdrawAccountIsActive(Model model) {
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.WITHDRAW_ACCOUNT);
        model.addAttribute("isActive", sysParam.getActive());
    }

    /**
     * 是否开启易收付出款入口
     *
     * @param model
     */
    private void easyPaymentStatus(Model model) {
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.EASY_PAYMENT);
        model.addAttribute("easyPaymentStatus", sysParam.getParamValue());
    }

    /**
     * 筛选模板
     *
     * @param model
     */
    private void handleTemple(Model model) {
        String templateCode = TemplateCodeEnum.fund_withdraw_player_check.getCode();
        model.addAttribute("searchTempCode", templateCode);
        model.addAttribute("searchTemplates", CacheBase.getSysSearchTempByCondition(SessionManagerBase.getUserId(), TemplateCodeEnum.fund_withdraw_player_check.getCode()));
    }

    /**
     * 公司入款声音参数
     *
     * @param vo
     * @param model
     */
    private void handleVoice(VPlayerWithdrawListVo vo, Model model) {
        SysParam systemParam = ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DRAW);
        model.addAttribute("realActive", systemParam.getActive());
        model.addAttribute("systemParam", systemParam);
        if (SessionManager.getWithdrawNotice() != null) {
            systemParam.setActive(SessionManager.getWithdrawNotice());
        }
        vo.setTone(systemParam);
    }

    /**
     * 处理转义符
     *
     * @param search
     */
    private void handleEscape(VPlayerWithdrawSo search) {
        if (StringTool.isNotBlank(search.getUsername())) {
            search.setUsername(search.getUsername().replaceAll("\\\\", ""));
        }
        if (StringTool.isNotBlank(search.getPayeeName())) {
            search.setPayeeName(search.getPayeeName().replaceAll("\\\\", ""));
        }
        if (StringTool.isNotBlank(search.getRealName())) {
            search.setRealName(search.getRealName().replaceAll("\\\\", ""));
        }
        if (StringTool.isNotBlank(search.getCheckUserName())) {
            search.setCheckUserName(search.getCheckUserName().replaceAll("\\\\", ""));
        }
        if (StringTool.isNotBlank(search.getNewUserName())) {
            search.setNewUserName(search.getNewUserName().replaceAll("\\\\", ""));
        }
        if (StringTool.isNotBlank(search.getPayeeBankcard())) {
            search.setPayeeBankcard(search.getPayeeBankcard().replaceAll("\\\\", ""));
        }
    }

    @Override
    protected VPlayerWithdrawListVo doList(VPlayerWithdrawListVo listVo, VPlayerWithdrawSearchForm form, BindingResult result, Model model) {
        return super.doList(listVo, form, result, model);
    }

    /**
     * 查询提现列表
     *
     * @param model
     * @return
     */
    @RequestMapping({"/withdrawData"})
    @ResponseBody
    protected VPlayerWithdrawListVo withdrawData(HttpServletRequest request, VPlayerWithdrawListVo vo, Model model) {
        vo.setValidateRule(JsRuleCreator.create(VPlayerWithdrawSearchForm.class, "search"));
        initListVo(vo);
        if (UserTypeEnum.MASTER_SUB.getCode().equals(SessionManager.getUser().getUserType())) {
            List<SysUserDataRight> sysUserDataRights = querySysUserDataRights();
            buildPlayerRankData(model, sysUserDataRights);
            if (CollectionTool.isNotEmpty(sysUserDataRights)) {
                masterSubSearch(vo, sysUserDataRights);
                vo = ServiceSiteTool.vPlayerWithdrawService().searchPlayerWithdraw(vo);
            } else {
                vo = getTotalWithdraw(vo);
            }

        } else {
            vo = getTotalWithdraw(vo);
        }
        vo.setThisUserId(SessionManager.getAuditUserId());
        model.addAttribute("command", vo);
        //把转义符合去掉
        VPlayerWithdrawSo search = vo.getSearch();
        vo.setSearch(search);
        handleTempleData(vo);
        return vo;
    }

    @RequestMapping({"/withdrawStatistics"})
    @ResponseBody
    protected VPlayerWithdrawListVo withdrawStatistics(HttpServletRequest request, VPlayerWithdrawListVo vo, Model model) {
        initListVo(vo);
        if (UserTypeEnum.MASTER_SUB.getCode().equals(SessionManager.getUser().getUserType())) {
            List<SysUserDataRight> sysUserDataRights = querySysUserDataRights();
            if (CollectionTool.isNotEmpty(sysUserDataRights)) {
                masterSubSearch(vo, sysUserDataRights);
                if (vo.getSearch().isTodaySales()) {
                    //今日成功统计--jerry
                    todayTotal(vo);
                } else {
                    Double sum = ServiceSiteTool.vPlayerWithdrawService().sumPlayerWithdraw(vo);
                    vo.setTotalSum(CurrencyTool.CURRENCY.format(sum == null ? 0 : sum));
                }
            } else {
                getStatistics(vo);
            }

        } else {
            getStatistics(vo);
        }
        return vo;
    }

    /**
     * 获取统计数据
     *
     * @param vo
     */
    private void getStatistics(VPlayerWithdrawListVo vo) {
        if (vo.getSearch().isTodaySales()) {
            //今日成功统计--jerry
            todayTotal(vo);
        } else {
            vo.setPropertyName(VPlayerWithdraw.PROP_WITHDRAW_ACTUAL_AMOUNT);
            Number sum = this.getService().sum(vo);
            vo.setTotalSum(CurrencyTool.CURRENCY.format(sum == null ? 0 : sum.doubleValue()));
        }
    }

    /**
     * 处理模板渲染数据
     *
     * @param vo
     */
    private void handleTempleData(VPlayerWithdrawListVo vo) {
        if (CollectionTool.isNotEmpty(vo.getResult())) {
            DateFormat dateFormat = new DateFormat();
            TimeZone timeZone = SessionManagerCommon.getTimeZone();
            Map<String, Map<String, Map<String, String>>> dictsMap = I18nTool.getDictsMap(SessionManagerCommon.getLocale().toString());
            Map<String, Map<String, String>> views = I18nTool.getI18nMap(SessionManagerCommon.getLocale().toString()).get("views");
            SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.WITHDRAW_ACCOUNT);
            Map<String, String> paramValueMap = JsonTool.fromJson(sysParam.getParamValue(), Map.class);
            Boolean isActive = sysParam.getActive();
            String easyPaymentStatus = ParamTool.getSysParam(SiteParamEnum.EASY_PAYMENT).getParamValue();
            List<VPlayerWithdraw> result = vo.getResult();
            for (VPlayerWithdraw vPlayerWithdraw : result) {
                vPlayerWithdraw.set_formatDateTz_createTime(LocaleDateTool.formatDate(vPlayerWithdraw.getCreateTime(), dateFormat.getDAY_SECOND(), timeZone));
                Double counterFee = vPlayerWithdraw.getCounterFee();
                String _counterFee_pre = counterFee > 0 ? "-" : "";
                String _counterFee = _counterFee_pre + CurrencyTool.formatInteger(counterFee) + CurrencyTool.formatDecimals(counterFee);
                vPlayerWithdraw.set_counterFee(_counterFee);
                Double administrativeFee = vPlayerWithdraw.getAdministrativeFee();
                if (administrativeFee != null) {
                    String _administrativeFee_pre = administrativeFee > 0 ? "-" : "";
                    String _administrativeFee = _administrativeFee_pre + CurrencyTool.formatInteger(administrativeFee) + CurrencyTool.formatDecimals(administrativeFee);
                    vPlayerWithdraw.set_administrativeFee(_administrativeFee);
                }
                Double deductFavorable = vPlayerWithdraw.getDeductFavorable();
                String _deductFavorable_pre = deductFavorable > 0 ? "-" : "";
                String _deductFavorable = _deductFavorable_pre + CurrencyTool.formatInteger(deductFavorable) + CurrencyTool.formatDecimals(deductFavorable);
                vPlayerWithdraw.set_deductFavorable(_deductFavorable);
                String currenct_symbol = dictsMap.get("common").get("currency_symbol").get(vPlayerWithdraw.getWithdrawMonetary());
                vPlayerWithdraw.set_currency_symbol_withdrawMonetary(currenct_symbol);
                vPlayerWithdraw.set_withdrawActualAmount_formatInteger(CurrencyTool.formatInteger(vPlayerWithdraw.getWithdrawActualAmount()));
                vPlayerWithdraw.set_withdrawActualAmount_formatDecimals(CurrencyTool.formatDecimals(vPlayerWithdraw.getWithdrawActualAmount()));
                vPlayerWithdraw.set_bitAmount_formatNumber(getBitFormat(vPlayerWithdraw));
                vPlayerWithdraw.set_formatDateTz_checkTime(LocaleDateTool.formatDate(vPlayerWithdraw.getCheckTime(), dateFormat.getDAY_SECOND(), timeZone));
                if (StringTool.isNotBlank(vPlayerWithdraw.getLockPersonName())) {
                    String lockPersonName_replace = views.get("fund_auto").get("当前").replace("[0]", vPlayerWithdraw.getLockPersonName());
                    vPlayerWithdraw.set_lockPersonName_replace(lockPersonName_replace);
                }
                vPlayerWithdraw.set_dicts_fund_withdraw_status(dictsMap.get("fund").get("withdraw_status").get(vPlayerWithdraw.getWithdrawStatus()));
                if (StringTool.isNotBlank(vPlayerWithdraw.getCheckRemark())) {
                    String checkRemark = vPlayerWithdraw.getCheckRemark();
                    vPlayerWithdraw.set_checkRemark_length(checkRemark.length());
                    String remark_substring = (checkRemark.length() > 20) ? checkRemark.substring(0, 20) : checkRemark;
                    vPlayerWithdraw.set_checkRemark_substring(remark_substring);
                }
                String ipDictCode = vPlayerWithdraw.getIpDictCode();
                if (StringTool.isNotBlank(ipDictCode)) {
                    vPlayerWithdraw.set_getIpRegion_ipDictCode(IpRegionTool.getIpRegion(ipDictCode));
                }
                Long ipWithdraw = vPlayerWithdraw.getIpWithdraw();
                if (ipWithdraw != null) {
                    vPlayerWithdraw.set_ipWithdraw_ipv4LongToString(IpTool.ipv4LongToString(ipWithdraw));
                }
                vPlayerWithdraw.set_isActive(isActive);
                if (StringTool.isNotBlank(easyPaymentStatus)) {
                    vPlayerWithdraw.set_easyPaymentStatus(easyPaymentStatus);
                }
                vPlayerWithdraw.set_withdrawAccountEnableTime(new Date(Long.valueOf(paramValueMap.get("accountEnableTime"))));
                vPlayerWithdraw.set_islockPersonId(SessionManager.getAuditUserId().equals(vPlayerWithdraw.getLockPersonId()));
                vPlayerWithdraw.set_formatDateTz_withdrawCheckTime(LocaleDateTool.formatDate(vPlayerWithdraw.getWithdrawCheckTime(), dateFormat.getDAY_SECOND(), timeZone));
                vPlayerWithdraw.set_views_riskDataType(RiskTagTool.getRiskImgByUsername(vPlayerWithdraw.getUsername()));
                vPlayerWithdraw.set_withdrawAccountName(vPlayerWithdraw.getWithdrawAccountName());
                vPlayerWithdraw.set_bankCode(dictsMap.get("common").get("bankname").get(vPlayerWithdraw.getBankCode()));
                vPlayerWithdraw.set_merchantAccount(vPlayerWithdraw.getMerchantAccount());
            }
        }
    }

    /**
     * 获取bition的格式
     *
     * @param vPlayerWithdraw
     * @return
     */
    private String getBitFormat(VPlayerWithdraw vPlayerWithdraw) {
        DecimalFormat BONUS = new DecimalFormat("#.########");
        Double bitAmount = vPlayerWithdraw.getBitAmount();
        String format = "0.0";
        if (bitAmount != null) {
            BigDecimal bd = new BigDecimal(String.valueOf(bitAmount));
            format = BONUS.format(bd.setScale(8, BigDecimal.ROUND_DOWN));
        }
        return format;
    }

    /**
     * 处理取款状态
     *
     * @param model
     */
    private void handleWithdrawStatus(Model model) {
        Map<String, Serializable> siteWithdrawStatus = DictTool.get(DictEnum.WITHDRAW_STATUS);
        siteWithdrawStatus.remove(WithdrawStatusEnum.PENDING_SUB.getCode());
        siteWithdrawStatus.remove(WithdrawStatusEnum.CANCELLATION_OF_ORDERS.getCode());
        siteWithdrawStatus.remove(WithdrawStatusEnum.DEALAUDITFAIL.getCode());
        model.addAttribute("siteWithdrawStatus", siteWithdrawStatus);
    }

    /**
     * 获取子账号的查询条件
     *
     * @param vo
     * @param sysUserDataRights
     */
    private void masterSubSearch(VPlayerWithdrawListVo vo, List<SysUserDataRight> sysUserDataRights) {
        if (UserTypeEnum.MASTER_SUB.getCode().equals(SessionManager.getUser().getUserType()) && CollectionTool.isNotEmpty(sysUserDataRights)) {
            vo.getSearch().setCheckStatus(CheckStatusEnum.WITHOUT_REVIEW.getCode());
            vo.getSearch().setWithdrawSta(new String[]{WithdrawStatusEnum.PENDING_SUB.getCode(),
                    WithdrawStatusEnum.CANCELLATION_OF_ORDERS.getCode()});
            vo.getSearch().setDataRightUserId(SessionManager.getUserId());
            vo.getSearch().setModuleType(DataRightModuleType.PLAYERWITHDRAW.getCode());
            if (StringTool.isNotEmpty(vo.getSearch().getUsername())) {
                String username = vo.getSearch().getUsername().toLowerCase();
                String[] names = username.split(",");
                if (names.length == 1) {
                    vo.getSearch().setNewUserName(names[0]);
                } else if (names.length > 1) {
                    vo.getSearch().setAccountNames(names);
                }
            }
        }
    }

    /**
     * 初始化ListVo
     *
     * @param vo
     */
    private void initListVo(VPlayerWithdrawListVo vo) {
        VPlayerWithdrawSo search = vo.getSearch();
        //默认搜索3天内的数据
        if (search.getCreateStart() == null && search.getCreateEnd() == null && search.getCheckTimeStart() == null && search.getCheckTimeEnd() == null) {
            Date now = new Date();
            Date sevenDaysAgo = DateTool.addDays(now, -3);
            search.setCreateStart(sevenDaysAgo);
        }

        if (StringTool.isNotBlank(search.getUsername())) {
            String[] split = search.getUsername().split(",");
            if (split.length == 1) {
                search.setUsername(search.getUsername().replaceAll("_", "\\_"));
            }
        }
        if (StringTool.isNotBlank(search.getPayeeName())) {
            search.setPayeeName(search.getPayeeName().replaceAll("_", "\\\\_"));
        }
        if (StringTool.isNotBlank(search.getRealName())) {
            search.setRealName(search.getRealName().replaceAll("_", "\\\\_"));
        }
        if (StringTool.isNotBlank(search.getCheckUserName())) {
            search.setCheckUserName(search.getCheckUserName().replaceAll("_", "\\\\_"));
        }
        if (StringTool.isNotBlank(search.getNewUserName())) {
            search.setNewUserName(search.getNewUserName().replaceAll("_", "\\\\_"));
        }
        if (StringTool.isNotBlank(search.getPayeeBankcard())) {
            search.setPayeeBankcard(search.getPayeeBankcard().replaceAll("_", "\\\\_"));
        }
        vo.setSearch(search);
        //ip转义
        String ipStr = vo.getSearch().getIpStr();
        vo.getSearch().setIpWithdraw(StringTool.isBlank(ipStr) ? null : IpTool.ipv4StringToLong(vo.getSearch().getIpStr()));
    }

    @RequestMapping("/count")
    public String count(VPlayerWithdrawListVo listVo, Model model, String isCounter) {
        // 初始化ListVo
        initListVo(listVo);
        listVo = doCount(listVo, isCounter);
        listVo.getPaging().cal();
        model.addAttribute("command", listVo);
        return getViewBasePath() + "IndexPagination";
    }

    public VPlayerWithdrawListVo doCount(VPlayerWithdrawListVo listVo, String isCounter) {
        if (StringTool.isBlank(isCounter)) {
            if (UserTypeEnum.MASTER_SUB.getCode().equals(SessionManager.getUser().getUserType())) {
                List<SysUserDataRight> sysUserDataRights = querySysUserDataRights();
                if (CollectionTool.isNotEmpty(sysUserDataRights)) {
                    //子账号查询条件
                    masterSubSearch(listVo, sysUserDataRights);
                    Paging paging = listVo.getPaging();
                    paging.setTotalCount(ServiceSiteTool.vPlayerWithdrawService().countPlayerWithdraw(listVo));
                    paging.cal();
                } else {
                    listVo = ServiceSiteTool.getVPlayerWithdrawService().searchWithdraw(listVo);
                }
            } else {
                listVo = ServiceSiteTool.getVPlayerWithdrawService().searchWithdraw(listVo);
            }
        }
        return listVo;
    }

    /**
     * 子账号查询的层级权限
     *
     * @param model
     * @param sysUserDataRights
     */
    private void buildPlayerRankData(Model model, List<SysUserDataRight> sysUserDataRights) {
        List<Integer> rankIds = CollectionTool.extractToList(sysUserDataRights, SysUserDataRight.PROP_ENTITY_ID);
        PlayerRankVo rankVo = new PlayerRankVo();
        rankVo.getSearch().setIds(rankIds);
        model.addAttribute("playerRanks", ServiceSiteTool.playerRankService().queryUsableList(rankVo));
    }

    /**
     * 子账号的数据权限
     *
     * @return
     */
    private List<SysUserDataRight> querySysUserDataRights() {
        SysUserDataRightVo sysUserDataRightVo = new SysUserDataRightVo();
        sysUserDataRightVo.getSearch().setUserId(SessionManager.getUserId());
        sysUserDataRightVo.getSearch().setModuleType(DataRightModuleType.PLAYERWITHDRAW.getCode());
        return ServiceSiteTool.sysUserDataRightService().searchDataRightsByUserId(sysUserDataRightVo);
    }


    //查询今日成功订单总额
    public void todayTotal(VPlayerWithdrawListVo listVo) {
        VPlayerWithdrawListVo vPlayerWithdrawListVo = new VPlayerWithdrawListVo();

        Date today = SessionManager.getDate().getToday();
        Date todayEnd = DateTool.addDays(SessionManager.getDate().getToday(), 1);
        vPlayerWithdrawListVo.getSearch().setCheckTimeStart(today);
        vPlayerWithdrawListVo.getSearch().setCheckTimeEnd(todayEnd);
        vPlayerWithdrawListVo.getSearch().setCheckStatus(CheckStatusEnum.SUCCESS.getCode());
        vPlayerWithdrawListVo._setContextParam(listVo._getContextParam());
        vPlayerWithdrawListVo.setPropertyName(VPlayerWithdraw.PROP_WITHDRAW_AMOUNT);
        Number sum = this.getService().todayTotal(vPlayerWithdrawListVo);
        listVo.setTodayTotal(CurrencyTool.formatCurrency(sum == null ? 0 : sum));
    }

    //总额计算
    private VPlayerWithdrawListVo getTotalWithdraw(VPlayerWithdrawListVo vo) {
        vo = ServiceSiteTool.getVPlayerWithdrawService().searchWithdraw(vo);
        return vo;
    }

    private Map<String, Serializable> getBankList() {
        Map<String, Bank> bankCache = Cache.getBank();
        Map<String, Serializable> bankMap = new LinkedHashMap<>();
        if (MapTool.isNotEmpty(bankCache)) {
            for (Bank bank : bankCache.values()) {
                SysDict dict = new SysDict();
                dict.setModule("common");
                dict.setDictType("bankname");
                dict.setDictCode(bank.getBankName());
                dict.setActive(true);
                dict.setRemark(bank.getBankShortName());
                dict.setOrderNum(bank.getOrderNum());
                bankMap.put(bank.getBankName(), dict);
            }
        }
        return bankMap;
    }

    /**
     * 启用停用声音提醒
     */
    @RequestMapping({"/toneSwitch"})
    @ResponseBody
    public Map<String, Object> toneSwitch(@RequestParam("paramVal") String paramVal) {
        SessionManager.setWithdrawNotice(paramVal);
        Map map = new HashMap();
        map.put("state", true);
        return map;//toneSwitch(SiteParamEnum.WARMING_TONE_DRAW);
    }

    /**
     * 声音开关
     */
    Map<String, Object> toneSwitch(SiteParamEnum paramEnum) {
        Map<String, Object> map = new HashMap<>(1, 1f);
        SysParam param = ParamTool.getSysParam(paramEnum);
        if (param != null) {
            if (param.getActive()) {
                param.setActive(false);
            } else {
                param.setActive(true);
            }
            // 更新参数设置
            updateParam(param);
            // 刷新参数缓存
            ParamTool.refresh(paramEnum);
            map.put("state", true);
        }
        return map;
    }

    /**
     * 更新参数设置
     */
    private void updateParam(SysParam param) {
        SysParamVo vo = new SysParamVo();
        vo.setResult(param);
        vo.setProperties(SysParam.PROP_ACTIVE);
        ServiceSiteTool.siteSysParamService().updateOnly(vo);
    }

    /**
     * 提现--筛选
     *
     * @param listVo
     * @param model
     * @return
     */
    @RequestMapping("/withdrawFilter")
    public String withdrawFilter(SysListOperatorListVo listVo, Model model) {
        Map<String, SysListOperator> listOp = ListOpTool.getFilter(ListOpEnum.VPlayerWithdrawListVo);
        Map i18nMap = I18nTool.getDictsMap(SessionManager.getLocale().toString()).get(Module.FUND.getCode());

        if (listOp != null && listOp.size() > 0) {
            model.addAttribute("filters", listOp.values());
        }
        List<FilterRow> filterRowList = new ArrayList<>();

        //申请提现实际金额：大于等于/等于/小于等于
        filterRowList.add(new FilterRow(VPlayerWithdraw.PROP_WITHDRAW_ACTUAL_AMOUNT, LocaleTool.tranView("column", VPlayerWithdraw.class.getSimpleName() + "." + VPlayerWithdraw.PROP_WITHDRAW_ACTUAL_AMOUNT), FilterSelectConstant.equalRange, TabTypeEnum.TEXT, null));

        //稽核扣除：等于/不等于
        List<Pair> auditStatus = new ArrayList<>();
        Map<String, SysDictSo> auditStatusMap = DictTool.get(DictEnum.IS_AUDIT);
        Map auditTypeMap = (Map) i18nMap.get(DictEnum.IS_AUDIT.getType());
        for (String key : auditStatusMap.keySet()) {
            auditStatus.add(new Pair(key, auditTypeMap.get(key)));
        }
        filterRowList.add(new FilterRow(VPlayerWithdraw.PROP_IS_DEDUCT_AUDIT, LocaleTool.tranView("column", VPlayerWithdraw.class.getSimpleName() + "." + VPlayerWithdraw.PROP_IS_DEDUCT_AUDIT), FilterSelectConstant.onlyEqual, TabTypeEnum.SELECT, auditStatus));

        //订单提交时间：大于等于/等于/小于等于
        filterRowList.add(new FilterRow(VPlayerWithdraw.PROP_CREATE_TIME, LocaleTool.tranView("column", VPlayerWithdraw.class.getSimpleName() + "." + VPlayerWithdraw.PROP_CREATE_TIME), FilterSelectConstant.equalRange, TabTypeEnum.DATE, null));

        //状态：包含/不包含
        List<Pair> checkStatus = new ArrayList<>();
        Map<String, SysDictSo> withdrawStatusMap = DictTool.get(DictEnum.WITHDRAW_STATUS);
        withdrawStatusMap.remove(WithdrawStatusEnum.PENDING_SUB.getCode());
        withdrawStatusMap.remove(WithdrawStatusEnum.CANCELLATION_OF_ORDERS.getCode());
        withdrawStatusMap.remove(WithdrawStatusEnum.DEALAUDITFAIL.getCode());
        Map withdrawTypeMap = (Map) i18nMap.get(DictEnum.WITHDRAW_STATUS.getType());
        for (String key : withdrawStatusMap.keySet()) {
            checkStatus.add(new Pair(key, withdrawTypeMap.get(key)));
        }
        filterRowList.add(new FilterRow(VPlayerWithdraw.PROP_WITHDRAW_STATUS, LocaleTool.tranView("column", VPlayerWithdraw.class.getSimpleName() + "." + VPlayerWithdraw.PROP_WITHDRAW_STATUS), FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, checkStatus));
        //层级
        List<Pair> rankList = getSiteRankList();
        filterRowList.add(new FilterRow(VPlayerWithdraw.PROP_RANK_ID, LocaleTool.tranView("column", VPlayerWithdraw.class.getSimpleName() + "." + VPlayerWithdraw.PROP_RANK_ID),
                FilterSelectConstant.contain, TabTypeEnum.CHECKBOX, rankList));

        model.addAttribute("validateRule", JsRuleCreator.create(SysListOperatorForm.class, ""));
        model.addAttribute("filterList", filterRowList);
        model.addAttribute("keyClassName", ListOpEnum.VPlayerWithdrawListVo.getClassName());
        model.addAttribute("jsonFilterList", JsonTool.toJson(filterRowList));
        model.addAttribute("goFilterUrl", "/fund/withdrawList.html");
        return "/share/ListFilters";
    }

    private List<Pair> getSiteRankList() {
        Map<String, List<Pair>> masterFilter = ServiceSiteTool.vUserPlayerService().searchMstFilter(new PlayerRankVo());

        List<Pair> rankList = new ArrayList<>();
        // 层级
        if (MapTool.isNotEmpty(masterFilter)) {
            rankList = masterFilter.get(PlayerRank.class.getName());
        }
        return rankList;
    }

    /**
     * 提现审核前先判断订单是否已锁定详情页面
     *
     * @param vo
     * @return
     */
    @RequestMapping({"/isAuditPerson"})
    @ResponseBody
    protected String isAuditPerson(VPlayerWithdrawVo vo) {
        Integer id = SessionManager.getAuditUserId();
        String json = null;
        vo = ServiceSiteTool.getVPlayerWithdrawService().search(vo);//取款视图表
        Integer lockPersonId = vo.getResult().getLockPersonId();
        String withdrawStatus = vo.getResult().getWithdrawStatus();
        if (WithdrawStatusEnum.DEAL.getCode().equals(withdrawStatus) && lockPersonId != null && lockPersonId.intValue() != id.intValue()) {
            //取款订单被锁定
            SysUserVo sysUserVo = new SysUserVo();
            sysUserVo.setResult(new SysUser());
            sysUserVo.getSearch().setId(vo.getResult().getLockPersonId());
            sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
            String username = sysUserVo.getResult().getUsername();
            json = username;
        }
        return json;
    }

    /**
     * 提现审核页面
     *
     * @param vo
     * @return
     */
    @RequestMapping({"/withdrawAuditView"})
    public String withdrawAuditView(VPlayerWithdrawVo vo, PlayerTransactionListVo listVo, Model model, HttpServletRequest request) {
        vo = ServiceSiteTool.getVPlayerWithdrawService().get(vo);
        if (vo.getResult() == null) {
            return null;
        }
        Double counterFee = vo.getResult().getCounterFee() == null ? 0d : vo.getResult().getCounterFee();
        Double administrativeFee = vo.getResult().getAdministrativeFee() == null ? 0d : vo.getResult().getAdministrativeFee();
        Double deductFavorable = vo.getResult().getDeductFavorable() == null ? 0d : vo.getResult().getDeductFavorable();
        Double allFee = counterFee + administrativeFee + deductFavorable;
        vo.setAllFee(allFee);
        //取款提醒是否是存款的几倍
        getMultiple(vo.getResult(), model);
        //设置提醒倍数
        getReminderMultiple(model);
        //查询玩家银行
        getPlayerBank(vo, model);
        vo.setThisUserId(SessionManager.getAuditUserId());

        //判断当成账号是否可以审核该笔存款 add by Bruce.QQ
        if (UserTypeEnum.MASTER_SUB.getCode().equals(SessionManager.getUser().getUserType())) {
            model.addAttribute("isDataRight", isDataRight(vo.getResult().getRankId()));
        } else {
            model.addAttribute("isDataRight", true);
        }

        model.addAttribute("command", vo);//审核详情页面
        model.addAttribute("listVo", getAuditLog(vo.getResult()));//稽核记录
        model.addAttribute("map", getAuditMap(vo));//稽核注释几笔通过。。。
        model.addAttribute("validateRule", JsRuleCreator.create(PlayerTransactionForm.class));
        //比特币展示详细
        if (RemittanceWayEnum.BITCOIN.getCode().equals(vo.getResult().getRemittanceWay()) && vo.getResult().getBitAmount() != null && vo.getResult().getBitAmount() > 0) {
            PlayerTransaction playerTransaction = getPlayerTransaction(vo.getResult().getPlayerTransactionId());
            model.addAttribute("transactionData", JsonTool.fromJson(playerTransaction.getTransactionData(), Map.class));
        }
        String pageType = request.getParameter("pageType");
        return StringTool.equals(pageType, "detail") ? WITHDRAW_VIEW_URl : WITHDRAW_AUDIT_VIEW_URl;
    }

    private PlayerTransaction getPlayerTransaction(Integer id) {
        PlayerTransactionVo playerTransactionVo = new PlayerTransactionVo();
        playerTransactionVo.getSearch().setId(id);
        playerTransactionVo = ServiceSiteTool.getPlayerTransactionService().get(playerTransactionVo);
        return playerTransactionVo.getResult();
    }

    private boolean isDataRight(Integer rankId) {
        boolean flag = false;
        List<SysUserDataRight> sysUserDataRights = querySysUserDataRights();
        if (sysUserDataRights != null && sysUserDataRights.size() > 0) {
            for (SysUserDataRight sysUserDataRight : sysUserDataRights) {
                if (sysUserDataRight.getEntityId().equals(rankId)) {
                    flag = true;
                    break;
                }
            }
        } else {
            flag = true;
        }
        return flag;
    }

    /**
     * 获取稽核记录
     *
     * @param playerWithdraw
     * @return
     */
    private List<PlayerTransaction> getAuditLog(VPlayerWithdraw playerWithdraw) {
        PlayerTransactionListVo playerTransactionListVo = new PlayerTransactionListVo();
        playerTransactionListVo.getSearch().setPlayerId(playerWithdraw.getPlayerId());
        playerTransactionListVo.getSearch().setCreateTime(playerWithdraw.getCreateTime());
        return ServiceSiteTool.getPlayerTransactionService().searchAuditLog(playerTransactionListVo);
    }

    /**
     * 获取取款提醒倍数
     *
     * @param model
     */
    private void getReminderMultiple(Model model) {
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.REMIND);
        if (sysParam != null && StringTool.isNotBlank(sysParam.getParamValue())) {
            model.addAttribute("paramValue", NumberTool.toDouble(sysParam.getParamValue()));
        }
    }

    /**
     * 查询取款与上一次存款倍数
     *
     * @param playerWithdraw
     * @param model
     */
    private void getMultiple(VPlayerWithdraw playerWithdraw, Model model) {
        PlayerRechargeVo playerRechargeVo = new PlayerRechargeVo();
        playerRechargeVo.getSearch().setPlayerId(playerWithdraw.getPlayerId());
        PlayerRecharge playerRecharge = ServiceSiteTool.playerRechargeService().searchDescPlayerRecharge(playerRechargeVo);
        Double dd = 0.0d;
        Double rechargeAmount = 0d;
        if (playerRecharge != null && playerRecharge.getRechargeAmount() > 0) {
            dd = playerWithdraw.getWithdrawAmount() / playerRecharge.getRechargeAmount();
            rechargeAmount = playerRecharge.getRechargeAmount();
        }
        model.addAttribute("rechargeAmount", rechargeAmount);
        model.addAttribute("multiple", dd);

    }

    private Map getAuditMap(VPlayerWithdrawVo vo) {
        if (vo.getResult() == null) {
            return null;
        }
        //稽核注释几笔通过。。。
        PlayerTransactionVo playerTransactionVo = new PlayerTransactionVo();
        playerTransactionVo.setResult(new PlayerTransaction());
        playerTransactionVo.setPlayerId(vo.getResult().getPlayerId());
        playerTransactionVo.getResult().setTransactionNo(vo.getResult().getTransactionNo());
        playerTransactionVo.getResult().setTransactionMoney(vo.getResult().getWithdrawAmount());
        playerTransactionVo.getSearch().setCreateTime(vo.getResult().getCreateTime());
//        return ServiceSiteTool.getPlayerTransactionService().getTransactionMap(playerTransactionVo);
        return ServiceSiteTool.getPlayerTransactionService().getAuditMap(playerTransactionVo, vo.getResult());
    }

    private Map<String, Object> getAuditPassList(List<PlayerTransaction> playerTransactions) {

        Map<String, Object> map = new HashMap<>(6, 1f);
        if (playerTransactions == null || playerTransactions.size() == 0) {
            return map;
        }
        List<PlayerTransaction> depositList = new ArrayList<>();
        for (PlayerTransaction transaction : playerTransactions) {
            if (TransactionTypeEnum.DEPOSIT.getCode().equals(transaction.getTransactionType())) {
                depositList.add(transaction);
            }
        }
        if (CollectionTool.isNotEmpty(depositList))
            map.put("depositRecord", true);
        else
            map.put("depositRecord", false);

        map.put("depositSum", getAdminFee(depositList));
        int depcount = getDepcount(depositList);
        map.put("depositFailCount", depcount);

        List<PlayerTransaction> favorableVoList = new ArrayList<>();
        for (PlayerTransaction transaction : playerTransactions) {
            if (!TransactionTypeEnum.DEPOSIT.getCode().equals(transaction.getTransactionType())) {
                favorableVoList.add(transaction);
            }
        }
        map.put("favorableSum", getFavfee(favorableVoList));
        int favcount = getFavcount(favorableVoList);
        map.put("favorableFailCount", favcount);

        return map;
    }

    private int getFavcount(List<PlayerTransaction> favorableVoList) {
        int favcount = 0;
        for (PlayerTransaction transaction : favorableVoList) {
            if (transaction.getDeductFavorable() != null && transaction.getDeductFavorable() > 0) {
                favcount++;
            }
        }
        return favcount;
    }

    private int getDepcount(List<PlayerTransaction> depositList) {
        int depcount = 0;
        for (PlayerTransaction transaction : depositList) {
            if (transaction.getAdministrativeFee() != null && transaction.getAdministrativeFee() > 0) {
                depcount++;
            }
        }
        return depcount;
    }

    private double getFavfee(List<PlayerTransaction> favorableVoList) {
        double favcount = 0;
        for (PlayerTransaction transaction : favorableVoList) {
            if (transaction.getDeductFavorable() != null && transaction.getDeductFavorable() > 0) {
                favcount += transaction.getDeductFavorable();
            }
        }
        return favcount;
    }

    private double getAdminFee(List<PlayerTransaction> depositList) {
        double depcount = 0;
        for (PlayerTransaction transaction : depositList) {
            if (transaction.getAdministrativeFee() != null && transaction.getAdministrativeFee() > 0) {
                depcount += transaction.getAdministrativeFee();
            }
        }
        return depcount;
    }

    private void getPlayerBank(VPlayerWithdrawVo vo, Model model) {
        UserBankcardVo userBankcardVo = new UserBankcardVo();
        userBankcardVo.getSearch().setUserId(vo.getResult().getPlayerId());
        userBankcardVo.getSearch().setBankcardNumber(vo.getResult().getPayeeBankcard());
        userBankcardVo.getSearch().setBankName(vo.getResult().getPayeeBank());
        userBankcardVo = ServiceSiteTool.userBankcardService().search(userBankcardVo);
        model.addAttribute("userBankcard", userBankcardVo.getResult());
    }

    @RequestMapping("/showAuditList")
    public String showAuditList(PlayerTransactionListVo listVo, Model model) {
        searchAuditList(listVo, model);
        String url = getViewBasePath() + "ShowAuditList";
        return url;

    }

    @RequestMapping("/refreshAuditList")
    public String refreshAuditList(PlayerTransactionListVo listVo, Model model) {
        VPlayerWithdraw withdrawRecord = getWithdrawRecord(listVo);
        if (withdrawRecord != null && withdrawRecord.getPlayerId() != null) {
            Map map = reAuditTransaction(withdrawRecord.getPlayerId(), withdrawRecord.getCreateTime());
            searchAuditList(listVo, model);
            updateWithdrawRecord(withdrawRecord.getPlayerId(), map);
        }

        String url = getViewBasePath() + "AuditListRecord";
        return url;
    }

    private List<PlayerTransaction> queryAuditList(PlayerTransactionListVo listVo) {
        VPlayerWithdraw withdrawRecord = getWithdrawRecord(listVo);
        PlayerWithdrawVo withdrawVo = new PlayerWithdrawVo();
        withdrawVo.getSearch().setPlayerId(withdrawRecord.getPlayerId());
        withdrawVo.getSearch().setCreateTime(withdrawRecord.getCreateTime());
        List<PlayerWithdraw> playerWithdraws = ServiceSiteTool.playerWithdrawService().getPlayerWithdraws(withdrawVo);
        listVo.getSearch().setPlayerId(withdrawRecord.getPlayerId());
        listVo.getSearch().setEndCreateTime(withdrawRecord.getCreateTime());
        if (playerWithdraws != null && playerWithdraws.size() > 0) {

            if (playerWithdraws.size() > 0) {
                Date startDate = playerWithdraws.get(0).getCreateTime();
                listVo.getSearch().setBeginCreateTime(startDate);

            }
            List<PlayerTransaction> playerTransactions = ServiceSiteTool.getPlayerTransactionService().queryAuditPassList(listVo);
            return playerTransactions;
        } else {
            List<PlayerTransaction> playerTransactions = ServiceSiteTool.getPlayerTransactionService().queryAuditPassList(listVo);
            return playerTransactions;
        }
    }

    private void searchAuditList(PlayerTransactionListVo listVo, Model model) {
        //查询列表前先进行集合一下
        VPlayerWithdraw withdrawRecord = getWithdrawRecord(listVo);
        if ("true".equals(listVo.getAuditPass())) {
            List<PlayerTransaction> playerTransactions = queryAuditList(listVo);
            initAuditData(withdrawRecord.getPlayerId(), playerTransactions);
            model.addAttribute("totalEffTrade", fetchEffTrade(playerTransactions));
            model.addAttribute("listVo", playerTransactions);
            Map<String, Object> auditPassList = getAuditPassList(playerTransactions);
            model.addAttribute("map", auditPassList);
        } else {
            List<PlayerTransaction> list = getAuditLogList(listVo);
            initAuditData(withdrawRecord.getPlayerId(), list);
            model.addAttribute("totalEffTrade", fetchEffTrade(list));
            model.addAttribute("listVo", list);
            VPlayerWithdrawVo withdrawVo = new VPlayerWithdrawVo();
            withdrawVo.setResult(withdrawRecord);
            Map auditMap = getAuditMap(withdrawVo);
            model.addAttribute("map", auditMap);
        }
        model.addAttribute("user", getSysUser(withdrawRecord.getPlayerId()));
        model.addAttribute("withdrawRecord", withdrawRecord);
        model.addAttribute("validateRule", JsRuleCreator.create(PlayerTransactionForm.class));
        model.addAttribute("currentUser", SessionManager.getUser());
    }

    /**
     * 即时稽核
     *
     * @param listVo
     * @param model
     * @return
     */
    @RequestMapping("/immediateAudit")
    public String immediateAudit(PlayerTransactionListVo listVo, Model model) {
        Integer playerId = listVo.getSearch().getPlayerId();
        if (playerId != null) {
            Map transactionMap = reAuditTransaction(playerId, new Date());
            model.addAttribute("user", getSysUser(playerId));
            listVo.getSearch().setPlayerId(playerId);
            listVo.getSearch().setCreateTime(new Date());
            List<PlayerTransaction> playerTransactions = ServiceSiteTool.getPlayerTransactionService().searchAuditLog(listVo);
            initAuditData(playerId, playerTransactions);
            model.addAttribute("totalEffTrade", fetchEffTrade(playerTransactions));
            model.addAttribute("listVo", playerTransactions);
            model.addAttribute("map", transactionMap);

            updateWithdrawRecord(playerId, transactionMap);
        }

        model.addAttribute("command", listVo);
        return "/player/view.include/ImmediateAudit";
    }

    private Double fetchEffTrade(List<PlayerTransaction> playerTransactions) {
        BigDecimal total = BigDecimal.ZERO;
        if (playerTransactions == null || playerTransactions.size() == 0) {
            return total.doubleValue();
        }

        for (PlayerTransaction transaction : playerTransactions) {
            if (transaction.getEffectiveTransaction() != null) {
                BigDecimal bigDecimal = new BigDecimal(transaction.getEffectiveTransaction().toString());
                total = total.add(bigDecimal);
            }
        }
        return total.doubleValue();
    }

    private void initAuditData(Integer playerId, List<PlayerTransaction> playerTransactions) {
        if (playerId == null || playerTransactions == null || playerTransactions.size() == 0) {
            return;
        }
        VUserPlayer vUserPlayer = getVUserPlayer(playerId);
        if (vUserPlayer == null || vUserPlayer.getRankId() == null) {
            return;
        }
        PlayerRank playerRank = getPlayerRank(vUserPlayer.getRankId());
        if (playerRank == null || playerRank.getWithdrawNormalAudit() == null) {
            return;
        }
        for (PlayerTransaction transaction : playerTransactions) {
            if (transaction.getRechargeAuditPoints() == null && TransactionTypeEnum.DEPOSIT.getCode().equals(transaction.getTransactionType())
                    && !FundTypeEnum.ARTIFICIAL_DEPOSIT.getCode().equals(transaction.getFundType())) {
                Double rap = transaction.getTransactionMoney() * playerRank.getWithdrawNormalAudit();
                transaction.setRechargeAuditPoints(rap);
            }
        }
    }

    private void updateWithdrawRecord(Integer playerId, Map transactionMap) {
        if (playerId == null || transactionMap == null || transactionMap.isEmpty()) {
            return;
        }
        PlayerWithdrawVo withdrawVo = new PlayerWithdrawVo();
        withdrawVo.getSearch().setPlayerId(playerId);
        withdrawVo.getSearch().setWithdrawStatus(WithdrawStatusEnum.DEAL.getCode());
        withdrawVo = ServiceSiteTool.playerWithdrawService().search(withdrawVo);
        PlayerWithdraw result = withdrawVo.getResult();
        if (result == null) {
            return;
        }
        //depositSum //favorableSum
        Double depositSum = MapTool.getDouble(transactionMap, "depositSum");
        depositSum = depositSum == null ? 0d : depositSum;
        result.setAdministrativeFee(depositSum);
        Double favorableSum = MapTool.getDouble(transactionMap, "favorableSum");
        favorableSum = favorableSum == null ? 0d : favorableSum;
        result.setDeductFavorable(favorableSum);
        VUserPlayer vUserPlayer = getVUserPlayer(playerId);
        PlayerRank playerRank = getPlayerRank(vUserPlayer.getRankId());
        if (playerRank == null) {
            throw new RuntimeException("层级为空");
        }
        double poundage = getPoundage(result.getWithdrawAmount(), playerRank, playerId);
        double actualWithdraw = result.getWithdrawAmount() - result.getAdministrativeFee() - result.getDeductFavorable() - poundage;
        result.setWithdrawActualAmount(actualWithdraw);
        result.setCounterFee(poundage);
        withdrawVo.setResult(result);
        withdrawVo.setProperties(PlayerWithdraw.PROP_ADMINISTRATIVE_FEE, PlayerWithdraw.PROP_DEDUCT_FAVORABLE, PlayerWithdraw.PROP_WITHDRAW_ACTUAL_AMOUNT, PlayerWithdraw.PROP_COUNTER_FEE);
        ServiceSiteTool.playerWithdrawService().updateOnly(withdrawVo);
    }

    /**
     * 获取手续费
     *
     * @param withdrawAmount 取款金额
     * @return 手续费
     */
    private double getPoundage(Double withdrawAmount, PlayerRank rank, Integer playerId) {

        Integer hasCount = 0;     // 设定时间内已取款次数
        Integer freeCount = rank.getWithdrawFreeCount();
        // 有设置取款次数限制
        if ((rank.getIsWithdrawFeeZeroReset() || rank.getWithdrawTimeLimit() != null) && freeCount != null) {
            hasCount = getHasCount(rank, playerId);
        }
        LOG.info("已取款次数：{0}", hasCount);
        Double poundage = 0.0d; // 手续费
        // 超过免手续费次数(n+1次：即已取款次数+当前取款次数)时需要扣除手续费
        if (hasCount >= (freeCount == null ? 0 : freeCount)) {
            LOG.info("已取款次数超过免手续费次数：{0}", freeCount);
            poundage = calPoundage(withdrawAmount, rank);
        }

        // 手续费上限
        Double maxFee = rank.getWithdrawMaxFee();
        if (maxFee != null && poundage > maxFee) {
            LOG.info("手续费超过最大手续费：{0}", maxFee);
            poundage = maxFee;
        }

        DecimalFormat df = new DecimalFormat("#.00");
        df.format(poundage);
        return poundage;
    }

    /**
     * 设定时间内已取款次数
     */
    private Integer getHasCount(PlayerRank rank, Integer playerId) {
        //返回多次取款次数，收取手续费
        if (SessionManager.getUserId() == null) {
            throw new RuntimeException("玩家ID不存在");
        }
        Date date = new Date();
        Date lastTime = null;
        if (rank.getIsWithdrawFeeZeroReset()) {
            lastTime = DateQuickPicker.getInstance().getToday();
        } else {
            lastTime = DateTool.addHours(date, -rank.getWithdrawTimeLimit());
        }
        PlayerWithdrawVo withdrawVo = new PlayerWithdrawVo();
        withdrawVo.setResult(new PlayerWithdraw());
        withdrawVo.getSearch().setPlayerId(playerId);
        withdrawVo.setStartTime(lastTime);
        withdrawVo.setEndTime(date);
        Long count = ServiceSiteTool.playerWithdrawService().searchTwoHoursPlayerWithdrawCount(withdrawVo);
        return count.intValue();
    }

    /**
     * 计算平台设定的手续费
     *
     * @param withdrawAmount 取款金额
     * @param rank           玩家层级信息
     * @return 手续费
     */
    private Double calPoundage(Double withdrawAmount, PlayerRank rank) {
        Double ratioOrFee = rank.getWithdrawFeeNum();  // 比例或固定费用
        ratioOrFee = ratioOrFee == null ? 0d : ratioOrFee;

        Double poundage = 0d;
        if (RankFeeType.PROPORTION.getCode().equals(rank.getWithdrawFeeType())) {   // 比例收费
            poundage = ratioOrFee / 100 * withdrawAmount;
        } else if (RankFeeType.FIXED.getCode().equals(rank.getWithdrawFeeType())) { // 固定收费
            poundage = ratioOrFee;
        }
        return poundage == null ? 0d : poundage;
    }

    private Map reAuditTransaction(Integer playerId, Date searchDate) {
        PlayerTransactionVo transactionVo = new PlayerTransactionVo();
        transactionVo.setResult(new PlayerTransaction());
        transactionVo.setPlayerId(playerId);
        transactionVo.setAuditDate(new Date());
        transactionVo.getSearch().setCreateTime(searchDate);
        return ServiceSiteTool.getPlayerTransactionService().getTransactionMap(transactionVo);
    }

    @RequestMapping("/updateAuditFee")
    @ResponseBody
    @Audit(module = Module.FUND, moduleType = ModuleType.FUN_UPDATE_AUDIT_SUCCESS, opType = OpType.UPDATE)
    public Map updateAuditFee(HttpServletRequest request) {
        Map result = new HashMap();
        VPlayerTransactionVo objVo = new VPlayerTransactionVo();
        String dataJson = request.getParameter("dataJson"); //objVo.getDataJson();
        if (StringTool.isBlank(dataJson)) {
            result.put("state", false);
            return result;
        }
        JSONObject jsonObject = JSONObject.parseObject(dataJson);
        JSONArray feeArray = jsonObject.getJSONArray("feeList");
        for (Object obj : feeArray) {
            JSONObject jobj = (JSONObject) obj;
            jobj.put("id", jobj.getInteger("id"));
        }
        List<PlayerTransaction> feeList = JSONArray.parseArray(JSONArray.toJSONString(feeArray), PlayerTransaction.class);
        objVo.setFeeList(feeList);
        if (ServiceSiteTool.getPlayerTransactionService().checkFeeList(objVo)) {
            result.put("state", false);
            return result;
        }
        //List<PlayerTransaction> feeList = objVo.getFeeList();
//        PlayerTransactionVo transactionVo = new PlayerTransactionVo();
//        transactionVo.setEntities(feeList);
//        transactionVo.setProperties(PlayerTransaction.PROP_DEDUCT_FAVORABLE, PlayerTransaction.PROP_ADMINISTRATIVE_FEE);
        //int count = ServiceSiteTool.getPlayerTransactionService().batchUpdateOnly(transactionVo);
        result.put("state", true);
        //添加成功日志
        Integer playerId=jsonObject.getInteger("playerId");
        objVo.getSearch().setPlayerId(playerId);
        addUpdateAuditLog(objVo,"FUN_UPDATE_AUDIT_SUCCESS");
        return result;
    }

    @RequestMapping("/clearAudit")
    @ResponseBody
    @Audit(module = Module.PLAYER, moduleType = ModuleType.PLAYER_PLAYE_SUCCESS, opType = OpType.UPDATE)
    public Map clearAudit(HttpServletRequest request) {
        Map result = new HashMap();
        try {
            VPlayerTransactionVo objVo = new VPlayerTransactionVo();
            String dataJson = request.getParameter("dataJson"); //objVo.getDataJson();
            if (StringTool.isBlank(dataJson)) {
                result.put("state", false);
                return result;
            }
            JSONObject jsonObject = JSONObject.parseObject(dataJson);
            String searchJson = jsonObject.getString("search");
            VPlayerTransactionSo search = JSONObject.parseObject(searchJson, VPlayerTransactionSo.class);
            objVo.setSearch(search);


            JSONArray feeArray = jsonObject.getJSONArray("feeList");
            for (Object obj : feeArray) {
                JSONObject jobj = (JSONObject) obj;
                jobj.put("id", jobj.getInteger("id"));
            }
            List<PlayerTransaction> feeList = JSONArray.parseArray(JSONArray.toJSONString(feeArray), PlayerTransaction.class);
            PlayerTransactionVo transactionVo = new PlayerTransactionVo();
            transactionVo.setEntities(feeList);
            transactionVo.setProperties(PlayerTransaction.PROP_RECHARGE_AUDIT_POINTS, PlayerTransaction.PROP_FAVORABLE_AUDIT_POINTS);
            ServiceSiteTool.getPlayerTransactionService().batchUpdateOnly(transactionVo);
            result.put("state", true);
            Map map = reAuditTransaction(objVo.getSearch().getPlayerId(), new Date());
            updateWithdrawRecord(objVo.getSearch().getPlayerId(), map);
            //操作成功记录日志
            addUpdateAuditLog(objVo,"PLAYER_FUN_UPDATE_AUDIT_SUCCESS");
        } catch (Exception ex) {
            result.put("state", false);
            result.put("msg", ex.getMessage());
            LOG.error(ex, "即时稽核清修改稽核点出错：{0}", ex.getMessage());
        }


        return result;
    }

    /**
     * 添加修改稽核日志
     * @param objectVo
     */
    private void addUpdateAuditLog(VPlayerTransactionVo objectVo,String logDesc) {
        try {
            //取玩家名称
            SysUserVo sysUserVo = new SysUserVo();
            sysUserVo._setContextParam(objectVo._getContextParam());
            sysUserVo.getSearch().setId(objectVo.getSearch().getPlayerId());
            sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
            BussAuditLogTool.addLog(logDesc, sysUserVo.getResult()==null?"":sysUserVo.getResult().getUsername());
        } catch (Exception ex) {
            LOG.error("修改稽核成功后，添加日志报错");
        }
    }


    private List<PlayerTransaction> getAuditLogList(PlayerTransactionListVo listVo) {
        Date searchDate = new Date();
        Integer userId = null;
        VPlayerWithdraw withdrawRecord = getWithdrawRecord(listVo);
        if (withdrawRecord.getCreateTime() != null) {
            searchDate = withdrawRecord.getCreateTime();
        }
        userId = withdrawRecord.getPlayerId();
        if (userId == null) {
            return null;
        }
        listVo.getSearch().setPlayerId(userId);
        listVo.getSearch().setCreateTime(searchDate);
        return ServiceSiteTool.getPlayerTransactionService().searchAuditLog(listVo);
    }

    private VPlayerWithdraw getWithdrawRecord(PlayerTransactionListVo listVo) {
        if (listVo.getSearch().getId() != null) {
            VPlayerWithdrawVo playerWithdrawVo = new VPlayerWithdrawVo();
            playerWithdrawVo.getSearch().setId(listVo.getSearch().getId());
            playerWithdrawVo = ServiceSiteTool.vPlayerWithdrawService().get(playerWithdrawVo);
            if (playerWithdrawVo.getResult() != null) {
                return playerWithdrawVo.getResult();
            }
        }
        return null;
    }

    /**
     * 提现记录-二次确认审核通过
     * Modified  jerry  2016-12-11
     *
     * @param objVo
     * @param model
     * @return
     */
    @RequestMapping("/putConfirmCheck")
    public String putConfirmCheck(VPlayerWithdrawVo objVo, Model model) {
        Double fee = objVo.getAllFee();
        objVo = ServiceSiteTool.getVPlayerWithdrawService().search(objVo);
        objVo.setAllFee(fee);
        if (objVo.getResult().getWithdrawAmount() != null) {
            Double actualAmount = objVo.getResult().getWithdrawAmount() - fee;
            objVo.setWithdrawActualAmount(actualAmount);
        }
        objVo.getResult().setWithdrawActualAmount(objVo.getSearch().getWithdrawActualAmount());
        objVo.getResult().setCheckStatus(CheckStatusEnum.SUCCESS.getCode());
        objVo.getResult().setWithdrawStatus(RechargeStatusEnum.SUCCESS.getCode());
        model.addAttribute("currency", SessionManager.getUser().getDefaultCurrency());
        model.addAttribute("command", objVo);
        getPlayerBank(objVo, model);


        //推送消息给前端
        MessageVo message = new MessageVo();
        message.setSubscribeType(CometSubscribeType.MCENTER_RECHARGE_CHECK_REMINDER.getCode());
        message.setSendToUser(true);
        message.setCcenterId(SessionManager.getSiteParentId());
        message.setSiteId(SessionManager.getSiteId());
        message.setMasterId(SessionManager.getSiteUserId());
        SysResourceListVo sysResourceListVo = new SysResourceListVo();
        sysResourceListVo.getSearch().setUrl("/fund/withdraw/withdrawList.html");
        List<Integer> userIdByUrl = ServiceSiteTool.playerRechargeService().findUserIdByUrl(sysResourceListVo);
        userIdByUrl.add(Const.MASTER_BUILT_IN_ID);

        //判断账号是否可以查看该层级的记录 add by Bruce.QQ
        message.addUserIds(userIdByUrl);
        message.setMsgBody(LocaleTool.tranMessage("fund_auto", "存款审核完"));
        ServiceTool.messageService().sendToMcenterMsg(message);
        return RECHARGE_PUT_CONFIRM_CHECK_PASS_URI;
    }

    private List<PlayerTransaction> updateTransaction(VPlayerTransactionVo vo) {
        if (ServiceSiteTool.getPlayerTransactionService().checkFeeList(vo)) {
            throw new RuntimeException("修改稽核值失败");
        }
        List<PlayerTransaction> tempList = new ArrayList<>();
        if (vo.getFeeList() != null && vo.getFeeList().size() > 0) {
            String[] properties = new String[3];
            properties[0] = PlayerTransaction.PROP_ADMINISTRATIVE_FEE;
            properties[1] = PlayerTransaction.PROP_DEDUCT_FAVORABLE;
            for (PlayerTransaction transaction : vo.getFeeList()) {
                PlayerTransactionVo transactionVo = new PlayerTransactionVo();
                transactionVo.getSearch().setId(transaction.getId());
                transactionVo = ServiceSiteTool.getPlayerTransactionService().get(transactionVo);
                if (transactionVo.getResult() == null) {
                    continue;
                }
                PlayerTransaction tempTransaction = transactionVo.getResult();
                if (transaction.getAdministrativeFee() == null) {
                    transaction.setAdministrativeFee(tempTransaction.getAdministrativeFee());
                }
                if (transaction.getDeductFavorable() == null) {
                    transaction.setDeductFavorable(tempTransaction.getDeductFavorable());
                }
                if (TransactionTypeEnum.DEPOSIT.getCode().equals(tempTransaction.getTransactionType())
                        && tempTransaction.getRechargeAuditPoints() == null && vo.getPlayerRank() != null) {
                    Double rap = tempTransaction.getTransactionMoney() * vo.getPlayerRank().getWithdrawNormalAudit();
                    transaction.setRechargeAuditPoints(rap);
                    properties[2] = PlayerTransaction.PROP_RECHARGE_AUDIT_POINTS;
                }
                tempList.add(transaction);
            }
            PlayerTransactionVo listVo = new PlayerTransactionVo();
            listVo.setEntities(tempList);
            listVo.setProperties(properties);
            ServiceSiteTool.getPlayerTransactionService().batchUpdateOnly(listVo);
        }
        return tempList;
    }

    private Double calAdminFee(List<PlayerTransaction> transactionList) {
        Double allFee = 0d;
        if (transactionList != null && transactionList.size() > 0) {
            for (PlayerTransaction transaction : transactionList) {
                Double adminFee = transaction.getAdministrativeFee() == null ? 0d : transaction.getAdministrativeFee();
                allFee = allFee + adminFee;
            }
        }
        return allFee;
    }

    private Double calFavFee(List<PlayerTransaction> transactionList) {
        Double allFee = 0d;
        if (transactionList != null && transactionList.size() > 0) {
            for (PlayerTransaction transaction : transactionList) {
                Double favorableFee = transaction.getDeductFavorable() == null ? 0d : transaction.getDeductFavorable();
                allFee = allFee + favorableFee;
            }
        }
        return allFee;
    }

    private String getCustomerService() {
        SiteCustomerService siteCustomerService = Cache.getDefaultCustomerService();
        String url = siteCustomerService.getParameter();
        if (StringTool.isNotBlank(url) && !url.contains("http")) {
            url = "http://" + url;
        }
        return url;
    }

    private Remark buildRemarkData(PlayerWithdrawVo objVo, Remark remark) {
        if (StringTool.isNotBlank(remark.getRemarkContent())) {
            remark.setModel(RemarkEnum.FUND_WITHDRAW.getModel());
            remark.setRemarkType(RemarkEnum.FUND_WITHDRAW.getType());
            remark.setEntityId(objVo.getResult().getId());
            remark.setEntityUserId(objVo.getResult().getPlayerId());
            remark.setRemarkTime(SessionManager.getDate().getNow());
            remark.setOperatorId(SessionManager.getUserId());
            remark.setOperator(SessionManager.getUserName());
            String timezone = Cache.getUserTimezone(objVo.getResult().getPlayerId());
            String time = LocaleDateTool.formatDate(objVo.getResult().getCreateTime(), CommonContext.getDateFormat().getDAY_SECOND(), timezone);
            String remarkTitle = I18nTool.getDictsMap(SessionManagerBase.getLocale().toString()).get(Module.COMMON.getCode()).get(DictEnum.COMMON_REMARK_TITLE.getType()).get(RemarkEnum.FUND_WITHDRAW.getType());
            remarkTitle = remarkTitle.replace("%checkUser%", SessionManager.getUserName());
            remarkTitle = remarkTitle.replace("%player%", objVo.getUsername());
            remarkTitle = remarkTitle.replace("%createTime%", time);
            remark.setRemarkTitle(remarkTitle);
        }
        return remark;
    }

    /**
     * 提现记录-选择审核失败原因
     *
     * @param objVo
     * @param model
     * @return
     */
    @RequestMapping("/putCheckFailure")
    public String putCheckFailure(VPlayerWithdrawVo objVo, Remark remark, Model model) {
        objVo = ServiceSiteTool.getVPlayerWithdrawService().get(objVo);
        //查询审核失败原因
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.PLAYER_WITHDRAWAL_AUDIT_FAIL);
        List<NoticeLocaleTmpl> failReasons = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);

        model.addAttribute("failReasons", failReasons);
        model.addAttribute("command", objVo);
        model.addAttribute("remark", remark);
        return RECHARGE_PUT_CHECK_FAILURE_URI;
    }

    /**
     * 提现记录-拒绝申请原因
     *
     * @param objVo
     * @param model
     * @return
     */
    @RequestMapping("/putConfirmRefuses")
    public String putConfirmRefuses(VPlayerWithdrawVo objVo, Model model) {
        objVo = ServiceSiteTool.getVPlayerWithdrawService().get(objVo);

        //查询拒绝原因模板
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.REFUSE_PLAYER_WITHDRAWAL);
        List<NoticeLocaleTmpl> failReasons = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);

        model.addAttribute("failReasons", failReasons);
        model.addAttribute("command", objVo);
        return RECHARGE_PUT_CHECK_REFUSES_URI;
    }

    /**
     * 未通过稽核弹窗
     *
     * @param objVo
     * @param model
     * @return
     */
    @RequestMapping("/noAudit")
    public String noAudit(VPlayerWithdrawVo objVo, Remark remark, Model model) {
        //表单校验
        objVo.setValidateRule(JsRuleCreator.create(VPlayerWithdrawForm.class, "result"));
        objVo = ServiceSiteTool.getVPlayerWithdrawService().get(objVo);
        model.addAttribute("command", objVo);
        model.addAttribute("remark", remark);
        return WITHDRAW_NOSUDIT_URI;
    }

    /**
     * 未通过稽核确认弹窗
     *
     * @param model
     * @return
     */
    @RequestMapping("/noAuditPage")
    public String noAuditPage(VPlayerWithdraw vPlayerWithdraw, Remark remark, Model model) {
        model.addAttribute("command", vPlayerWithdraw);
        model.addAttribute("remark", remark);
        return WITHDRAW_NOSUDITPAGE_URI;
    }


    /**
     * 稽核确认
     *
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping("/auditWithdraw")
    @ResponseBody
    public Map auditWithdraw(PlayerWithdrawVo vo, Remark remark, Model model) {
        HashMap map = new HashMap(2, 1f);
        try {
            //添加备注
            remark = buildRemarkData(vo, remark);

            PlayerTransactionVo playerTransactionVo = new PlayerTransactionVo();
            playerTransactionVo.setResult(new PlayerTransaction());
            playerTransactionVo.getSearch().setTransactionNo(vo.getResult().getTransactionNo());
            playerTransactionVo.setPlayerWithdraw(vo.getResult());
            playerTransactionVo.setRemark(remark);
            playerTransactionVo = ServiceSiteTool.getPlayerTransactionService().updatePlayerTransaction(playerTransactionVo);
            if (playerTransactionVo.isSuccess()) {
                vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_SUCCESS));
            } else {
                vo.setSuccess(false);
                vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "operation.fail"));
            }
            map.put("msg", StringTool.isNotBlank(vo.getOkMsg()) ? vo.getOkMsg() : vo.getErrMsg());
            map.put("state", Boolean.valueOf(vo.isSuccess()));
        } catch (Exception ex) {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, "operation.fail"));
            map.put("state", false);
        }
        return map;
    }


    /**
     * 锁定订单
     *
     * @param vo
     * @return
     */
    @RequestMapping("/lockOrder")
    @ResponseBody
    public boolean lockOrder(PlayerWithdrawVo vo) {
        vo.getSearch().setLockPersonId(SessionManager.getAuditUserId());
        vo.setProperties(PlayerWithdraw.PROP_IS_LOCK, PlayerWithdraw.PROP_LOCK_PERSON_ID);
        vo = ServiceSiteTool.playerWithdrawService().lockOrder(vo);
        updateWithdrawStatus(vo);
        return vo.isSuccess();
    }

    /**
     * 取消锁定订单
     *
     * @return
     */
    @RequestMapping("/cancelLockOrder")
    @ResponseBody
    public boolean cancelLockOrder(PlayerWithdrawVo vo) {
        vo.getSearch().setLockPersonId(SessionManager.getAuditUserId());
        vo = ServiceSiteTool.playerWithdrawService().cancelLockOrder(vo);
        updateWithdrawStatus(vo);
        return vo.isSuccess();
    }

    /**
     * 审核成功
     *
     * @param vo
     * @param remarkContent
     * @return
     */
    @RequestMapping("/withdrawSuccess")
    @ResponseBody
    @Audit(module = Module.FUND, moduleType = ModuleType.FUN_CHECK_SUCCESS, opType = OpType.AUDIT)
    public Map withdrawSuccess(PlayerWithdrawVo vo, VPlayerTransactionVo vPlayerTransactionVo, String remarkContent) {
        Map map = checkWithdraw(vo, vPlayerTransactionVo, remarkContent, WithdrawStatusEnum.SUCCESS.getCode(), CheckStatusEnum.SUCCESS.getCode());
        addWithdrawCheckLog(vo, map, WithdrawStatusEnum.SUCCESS.getCode());
        return map;
    }

    /**
     * 审核日志
     *
     * @param vo
     * @param map
     */
    private void addWithdrawCheckLog(PlayerWithdrawVo vo, Map map, String status) {
        try {
            if (map.get("state") != null && (Boolean) map.get("state")) {
                VPlayerWithdrawVo vPlayerWithdrawVo = new VPlayerWithdrawVo();
                vPlayerWithdrawVo.getSearch().setId(vo.getSearch().getId());
                vPlayerWithdrawVo = this.getService().get(vPlayerWithdrawVo);
                if (WithdrawStatusEnum.SUCCESS.getCode().equals(status)) {
                    BussAuditLogTool.addBussLog(Module.FUND, ModuleType.FUN_CHECK_SUCCESS, OpType.AUDIT,
                            "PLAYTER_DEPOSIT_CHECK_SUCCESS", vPlayerWithdrawVo.getResult().getTransactionNo());
                } else if (WithdrawStatusEnum.FAIL.getCode().equals(status)) {
                    BussAuditLogTool.addBussLog(Module.FUND, ModuleType.FUN_CHECK_FAILURE, OpType.AUDIT,
                            "PLAYTER_DEPOSIT_CHECK_FAILURE", vPlayerWithdrawVo.getResult().getTransactionNo());
                } else if (WithdrawStatusEnum.REFUSE.getCode().equals(status)) {
                    BussAuditLogTool.addBussLog(Module.FUND, ModuleType.FUN_CHECK_REJECT, OpType.AUDIT,
                            "PLAYTER_DEPOSIT_CHECK_REFUSE", vPlayerWithdrawVo.getResult().getTransactionNo());
                }
            }
        } catch (Exception ex) {
        }
    }

    /**
     * 审核失败
     *
     * @param vo
     * @param remarkContent
     * @return
     */
    @RequestMapping("/withdrawFail")
    @ResponseBody
    @Audit(module = Module.FUND, moduleType = ModuleType.FUN_CHECK_FAILURE, opType = OpType.AUDIT)
    public Map withdrawFail(PlayerWithdrawVo vo, VPlayerTransactionVo vPlayerTransactionVo, String remarkContent) {
        Map map = checkWithdraw(vo, vPlayerTransactionVo, remarkContent, WithdrawStatusEnum.FAIL.getCode(), CheckStatusEnum.FAILURE.getCode());
        addWithdrawCheckLog(vo, map, WithdrawStatusEnum.FAIL.getCode());
        return map;

    }

    /**
     * 拒绝审核
     *
     * @param vo
     * @param remarkContent
     * @return
     */
    @RequestMapping("/withdrawReject")
    @ResponseBody
    @Audit(module = Module.FUND, moduleType = ModuleType.FUN_CHECK_REJECT, opType = OpType.AUDIT)
    public Map withdrawReject(PlayerWithdrawVo vo, VPlayerTransactionVo vPlayerTransactionVo, String remarkContent) {
        Map map = checkWithdraw(vo, vPlayerTransactionVo, remarkContent, WithdrawStatusEnum.REFUSE.getCode(), CheckStatusEnum.REJECT.getCode());
        addWithdrawCheckLog(vo, map, WithdrawStatusEnum.REFUSE.getCode());
        return map;
    }

    /**
     * 取款审核
     *
     * @param vo
     * @param remarkContent
     * @param withdrawStatus
     * @param checkStatus
     * @return
     */
    private Map checkWithdraw(PlayerWithdrawVo vo, VPlayerTransactionVo vPlayerTransactionVo, String remarkContent, String withdrawStatus, String checkStatus) {
        //保存修改的行政费用记录、取款的行政费、优惠
        updateAuditTransaction(vo, vPlayerTransactionVo);

        vo.getSearch().setCheckRemark(StringTool.substring(remarkContent, 0, 200));
        vo.getSearch().setCheckUserId(SessionManager.getUserId());
        vo.getSearch().setWithdrawStatus(withdrawStatus);
        vo.setCheckUserName(SessionManager.getUserName());
        vo.getSearch().setCheckStatus(checkStatus);
        if (StringTool.isNotBlank(vo.getSearch().getReasonTitle())) {
            vo.getSearch().setReasonTitle(vo.getSearch().getReasonTitle().replace("${customer}", LocaleTool.tranMessage(_Module.COMMON, "contactCustomerService")));
        }
        if (StringTool.isNotBlank(vo.getSearch().getReasonContent())) {
            vo.getSearch().setReasonContent(vo.getSearch().getReasonContent().replace("${customer}", LocaleTool.tranMessage(_Module.COMMON, "contactCustomerService")));
        }
        vo.setTimeZone(SessionManager.getTimeZone());
        try {
            vo = ServiceSiteTool.playerWithdrawService().checkWithdraw(vo);
            if (vo.isSuccess()) {
                updateWithdrawStatus(vo);
            } else {
                LOG.info("取款审核失败,不更新");
            }
        } catch (Exception e) {
            vo.setSuccess(false);
            vo.setErrMsg(LocaleTool.tranMessage("fund_auto", "取款审核出错") + e.getMessage());
            LOG.error(e, "取款审核出错");
        }
        if (vo.isSuccess()) {
            sendNotice(vo);
        }
        return getVoMessage(vo);
    }

    private void updateWithdrawStatus(PlayerWithdrawVo vo) {
        //推送消息给前端
        MessageVo message = new MessageVo();
        message.setSubscribeType(CometSubscribeType.MCENTER_RECHARGE_CHECK_REMINDER.getCode());
        message.setSendToUser(true);
        message.setCcenterId(SessionManager.getSiteParentId());
        message.setSiteId(SessionManager.getSiteId());
        message.setMasterId(SessionManager.getSiteUserId());
        SysResourceListVo sysResourceListVo = new SysResourceListVo();
        sysResourceListVo.getSearch().setUrl("fund/withdraw/withdrawList.html");
        List<Integer> userIdByUrl = ServiceSiteTool.playerRechargeService().findUserIdByUrl(sysResourceListVo);
        userIdByUrl.add(Const.MASTER_BUILT_IN_ID);

        //判断账号是否可以查看该层级的记录 add by Bruce.QQ
        //自已会刷新，不发给自己
        if (userIdByUrl.contains(SessionManager.getUserId())) {
            userIdByUrl.remove(SessionManager.getUserId());
        }
        message.addUserIds(userIdByUrl);
        message.setMsgBody("player_withdraw");
        ServiceTool.messageService().sendToMcenterMsg(message);
    }

    @RequestMapping("/fetchWithdrawRecord")
    public String fetchWithdrawRecord(VPlayerWithdrawVo vPlayerWithdrawVo, Model model) {
        LOG.info("账号[{0}]更新了玩家取款订单列表状态", SessionManager.getUser().getUsername());
        if (vPlayerWithdrawVo.getSearch().getId() != null) {
            vPlayerWithdrawVo = getService().get(vPlayerWithdrawVo);
            model.addAttribute("withdraw", vPlayerWithdrawVo.getResult());
            model.addAttribute("rowIndex", vPlayerWithdrawVo.getRowIndex());
        }
        return getViewBasePath() + "UpdateRecord";
    }

    /**
     * 保存修改的行政费用记录、取款的行政费、优惠
     *
     * @param vo
     * @param vPlayerTransactionVo
     */
    private void updateAuditTransaction(PlayerWithdrawVo vo, VPlayerTransactionVo vPlayerTransactionVo) {
        //更新行政费用
        getPlayerRank(vo, vPlayerTransactionVo);
        List<PlayerTransaction> updateList = updateTransaction(vPlayerTransactionVo);
        if (vPlayerTransactionVo.getFeeList() != null && vPlayerTransactionVo.getFeeList().size() > 0) {
            //计处所有行政费用
            Double adminFee = calAdminFee(updateList);
            Double favFee = calFavFee(updateList);
            vo.getSearch().setAdministrativeFee(adminFee);
            vo.getSearch().setDeductFavorable(favFee);
        }
    }

    private void getPlayerRank(PlayerWithdrawVo vo, VPlayerTransactionVo vPlayerTransactionVo) {
        if (vo == null || vo.getSearch().getId() == null) {
            return;
        }
        vo = ServiceSiteTool.playerWithdrawService().get(vo);
        if (vo.getResult() == null || vo.getResult().getPlayerId() == null) {
            return;
        }
        VUserPlayer vUserPlayer = getVUserPlayer(vo.getResult().getPlayerId());
        if (vUserPlayer == null || vUserPlayer.getRankId() == null) {
            return;
        }
        PlayerRank playerRank = getPlayerRank(vUserPlayer.getRankId());
        if (playerRank == null) {
            return;
        }
        vPlayerTransactionVo.setPlayerRank(playerRank);
    }

    private PlayerRank getPlayerRank(Integer rankId) {
        PlayerRankVo playerRankVo = new PlayerRankVo();
        playerRankVo.getSearch().setId(rankId);
        playerRankVo = ServiceSiteTool.playerRankService().get(playerRankVo);
        if (playerRankVo.getResult() == null) {
            return null;
        }
        return playerRankVo.getResult();
    }

    /**
     * 发送站内信
     *
     * @param vo
     */
    private void sendNotice(PlayerWithdrawVo vo) {
        try {
            //发送固定站内信内容
            PlayerWithdraw playerWithdraw = vo.getResult();
            NoticeVo noticeVo = null;
            if (WithdrawStatusEnum.SUCCESS.getCode().equals(playerWithdraw.getWithdrawStatus())) {
                noticeVo = NoticeVo.autoNotify(AutoNoticeEvent.PLAYER_WITHDRAWAL_AUDIT_SUCCESS, playerWithdraw.getPlayerId());
            } else if (StringTool.isNotBlank(vo.getGroupCode())) {
                noticeVo = NoticeVo.manualNotify(vo.getGroupCode(), null, playerWithdraw.getPlayerId());
            }
            if (noticeVo == null) {
                return;
            }
            SysUser sysUser = getSysUser(playerWithdraw.getPlayerId());
            String bankcard = playerWithdraw.getPayeeBankcard();
            String time = LocaleDateTool.formatDate(playerWithdraw.getCreateTime(), LocaleDateTool.getFormat("DAY_SECOND"), sysUser.getDefaultTimezone());
            String money = CurrencyTool.formatCurrency(playerWithdraw.getWithdrawAmount());
            String actualMoney = CurrencyTool.formatCurrency(playerWithdraw.getWithdrawActualAmount());
            String text = LocaleTool.tranMessage(_Module.COMMON, "contactCustomerService");
            String customer = "<a href=\"" + getCustomerService() + "\" target=\"_blank\">" + text + "</a>";
            noticeVo.addParams(
                    new Pair<String, String>(NoticeParamEnum.TIME.getCode(), time),
                    new Pair<String, String>(NoticeParamEnum.PLASE_MONEY.getCode(), money),
                    new Pair<String, String>(NoticeParamEnum.ORDER.getCode(), playerWithdraw.getTransactionNo()),
                    new Pair<String, String>(NoticeParamEnum.WITHDRAW_MONEY.getCode(), actualMoney),
                    new Pair<String, String>(NoticeParamEnum.BANK.getCode(), I18nTool.getDictsMap(SessionManagerCommon.getLocale().toString()).get("common").get("bankname").get(playerWithdraw.getPayeeBank())),
                    new Pair(NoticeParamEnum.USER.getCode(), sysUser.getUsername()),
                    new Pair(NoticeParamEnum.ORDER_AMOUNT.getCode(), money),
                    new Pair(NoticeParamEnum.ORDER_LAUNCH_TIME.getCode(), time),
                    new Pair(NoticeParamEnum.ORDER_NUM.getCode(), playerWithdraw.getTransactionNo()),
                    new Pair(NoticeParamEnum.CUSTOMER.getCode(), customer),
                    new Pair<String, String>(NoticeParamEnum.TAIL_NUMBER.getCode(), bankcard.substring(bankcard.length() - 4, bankcard.length())));
            ServiceTool.noticeService().publish(noticeVo);
        } catch (Exception ex) {
            LogFactory.getLog(this.getClass()).error(ex, "发布消息不成功");
        }
    }

    public void sendSms(PlayerWithdrawVo vo){
        //联系方式
        NoticeContactWayListVo listVo = new NoticeContactWayListVo();
        listVo.getSearch().setUserId(vo.getResult().getPlayerId());
        Map<String, List<NoticeContactWay>> contactWays = ServiceTool.noticeContactWayService().fetchByUserId(listVo);

        NoticeTmplVo noticeTmplVo = new NoticeTmplVo();
        noticeTmplVo.getSearch().setEventType(AutoNoticeEvent.PLAYER_WITHDRAWAL_AUDIT_SUCCESS.getCode());
        noticeTmplVo.getSearch().setLocale(SessionManagerCommon.getLocale().toString());
        noticeTmplVo.getSearch().setPublishMethod(PublishMethodEnum.SMS.getCode());
        noticeTmplVo = ServiceSiteTool.noticeTmplService().search(noticeTmplVo);
        if(noticeTmplVo.getResult()!=null && noticeTmplVo.getResult().getActive()){
            Map map = new HashMap();
            map.put("mobile","");
            map.put("content",noticeTmplVo.getResult().getContent());
            vo.getResult().getPlayerId();
            SmsTool.sendSmsContent(map);
        }
    }

    /**
     * 修改稽核页面
     *
     * @param listVo
     * @param model
     * @return
     */
    @RequestMapping("/editAudit")
    public String editAudit(PlayerTransactionListVo listVo, SysUserVo vo, Integer id, Model model) {
        vo.getSearch().setId(id);
        vo = ServiceTool.sysUserService().get(vo);
        listVo.getSearch().setPlayerId(id);
        List<PlayerTransaction> list = ServiceSiteTool.getPlayerTransactionService().searchAuditWithdrawLog(listVo);//交易表-稽核
        model.addAttribute("listVo", list);
        model.addAttribute("command", vo);
        return WITHDRAW_EDIT_AUDIT_URI;
    }

    /**
     * 确认修改稽核记录
     *
     * @return
     */
    @RequestMapping(value = "/editAuditPlayerTransaction")
    @ResponseBody
    public Map editAuditPlayerTransaction(PlayerTransactionVo vo, String items) {
        List<Map> list = JsonTool.fromJson(items, List.class);
        for (Map map : list) {
            PlayerTransaction tran = new PlayerTransaction();
            Integer ids = Integer.parseInt(map.get("id").toString());
            String name = map.get("name").toString();
            Double val = Double.parseDouble(map.get("val").toString());

            tran.setId(ids);
            if ("rechargeAuditPoints".equals(name)) {
                tran.setRechargeAuditPoints(val);//充值稽核点
                vo.setResult(tran);
                vo.setProperties(PlayerTransaction.PROP_RECHARGE_AUDIT_POINTS);
                ServiceSiteTool.getPlayerTransactionService().updateOnly(vo);
            }
            if ("favorableAuditPoints".equals(name)) {
                tran.setFavorableAuditPoints(val);//优惠稽核点
                vo.setResult(tran);
                vo.setProperties(PlayerTransaction.PROP_FAVORABLE_AUDIT_POINTS);
                ServiceSiteTool.getPlayerTransactionService().updateOnly(vo);
            }

        }
        return this.getVoMessage(vo);
    }

    @RequestMapping(value = "/checkMaxValue")
    @ResponseBody
    public boolean checkMaxValue(@FormModel PlayerTransactionForm transactionForm, HttpServletRequest request) {
        String id = request.getParameter("id");
        if (StringTool.isNotBlank(id)) {
            PlayerTransactionVo withdrawVo = new PlayerTransactionVo();
            withdrawVo.getSearch().setId(Integer.valueOf(id));
            withdrawVo = ServiceSiteTool.getPlayerTransactionService().get(withdrawVo);
            if (withdrawVo.getResult() == null) {
                return true;
            }
            if (transactionForm.getFeeList$$_administrativeFee() != null && withdrawVo.getResult().getAdministrativeFee() != null) {
                double maxval = withdrawVo.getResult().getAdministrativeFee();
                boolean b = transactionForm.getFeeList$$_administrativeFee()[0] <= maxval;
                LOG.info("存款稽核值是否超最大值：{0}", b);
                return b;
            } else if (transactionForm.getFeeList$$_deductFavorable() != null && withdrawVo.getResult().getDeductFavorable() != null) {
                double maxval = withdrawVo.getResult().getDeductFavorable();
                boolean b = transactionForm.getFeeList$$_deductFavorable()[0] <= maxval;
                LOG.info("优惠稽核值是否超最大值：{0}", b);
                return b;
            }
        } else {
            return true;
        }
        return false;
    }


    @RequestMapping("/detect")
    public String detect(Integer playerId, Model model) {
        VUserPlayer player = getVUserPlayer(playerId);

        SysUser sysUser = getSysUser(playerId);
        model.addAttribute("player", player);
        model.addAttribute("sysUser", sysUser);
        baseInfoRepeatNum(model, player, sysUser);
        return PLAYER_DETECT_URI;
    }

    private void baseInfoRepeatNum(Model model, VUserPlayer player, SysUser sysUser) {
        UserPlayerVo userPlayerVo = new UserPlayerVo();
        userPlayerVo.setPropertiesMap(userInfoQueryMap(player, sysUser));
        model.addAttribute("repeatNum", ServiceSiteTool.userPlayerService().queryRepeatNum(userPlayerVo));
    }

    private Map userInfoQueryMap(VUserPlayer player, SysUser sysUser) {
        Map propertiesMap = new HashMap();
        propertiesMap.put("playerId", sysUser.getId());
        propertiesMap.put(SysUser.PROP_REAL_NAME, player.getRealName());
        propertiesMap.put("mobile", CryptoTool.aesEncrypt(player.getMobilePhone(), CryptoKey.KEY_NOTICE_CONTACT_WAY));
        propertiesMap.put("skype", CryptoTool.aesEncrypt(player.getSkype(), CryptoKey.KEY_NOTICE_CONTACT_WAY));
        propertiesMap.put("qq", CryptoTool.aesEncrypt(player.getQq(), CryptoKey.KEY_NOTICE_CONTACT_WAY));
        propertiesMap.put("msn", CryptoTool.aesEncrypt(player.getMsn(), CryptoKey.KEY_NOTICE_CONTACT_WAY));
        propertiesMap.put("weixin", CryptoTool.aesEncrypt(player.getWeixin(), CryptoKey.KEY_NOTICE_CONTACT_WAY));
        propertiesMap.put("email", CryptoTool.aesEncrypt(player.getMail(), CryptoKey.KEY_NOTICE_CONTACT_WAY));
        propertiesMap.put("weixin", CryptoTool.aesEncrypt(player.getWeixin(), CryptoKey.KEY_NOTICE_CONTACT_WAY));
        propertiesMap.put(SysUser.PROP_LOGIN_IP, sysUser.getLastLoginIp());
        propertiesMap.put(SysUser.PROP_REGISTER_IP, sysUser.getRegisterIp());
        return propertiesMap;
    }

    /**
     * 获取玩家视图信息
     */
    private VUserPlayer getVUserPlayer(Integer playerId) {
        VUserPlayerVo vUserPlayerVo = new VUserPlayerVo();
        vUserPlayerVo.getSearch().setId(playerId);
        vUserPlayerVo = ServiceSiteTool.vUserPlayerService().get(vUserPlayerVo);
        return vUserPlayerVo.getResult();
    }

    private SysUser getSysUser(Integer playerId) {
        if (playerId == null) {
            return null;
        }
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setId(playerId);
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        return sysUserVo.getResult();
    }

    @RequestMapping("/saveAuditRemark")
    @ResponseBody
    public Map saveAuditRemark(PlayerWithdrawVo playerWithdrawVo, String remarkContent) {
        Map map = new HashMap();
        Integer id = playerWithdrawVo.getSearch().getId();
        if (id == null || StringTool.length(remarkContent) > 200) {
            map.put("state", false);
            return map;
        }
        playerWithdrawVo.getSearch().setCheckRemark(remarkContent);
        playerWithdrawVo.getSearch().setCheckUserId(SessionManager.getUserId());
        playerWithdrawVo.setCheckUserName(SessionManager.getAuditUserName());
        ServiceSiteTool.playerWithdrawService().updateWithdrawRemark(playerWithdrawVo);
        map.put("state", playerWithdrawVo.isSuccess());
        return map;
    }


    /*判断是否有开启玩家取款审核*/
    @RequestMapping("/hasReason")
    @ResponseBody
    public Map hasReason(VPlayerTransactionVo vPlayerTransactionVo) {
        //查询失败原因模板
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.PLAYER_WITHDRAWAL_AUDIT_FAIL);
        List<NoticeLocaleTmpl> failReasons = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);
        boolean bool = false;
        if (failReasons != null && failReasons.size() > 0) {
            bool = true;
        }
        Map<String, Object> map = new HashMap<>(2, 1f);
        map.put("state", bool);
        map.put("feeList", vPlayerTransactionVo.getFeeList());
        return map;
    }

    /**
     * 判断是否有取款拒绝原因
     *
     * @return
     */
    @RequestMapping("/hasRefuseReason")
    @ResponseBody
    public Map hasRefuseReason(VPlayerTransactionVo vPlayerTransactionVo) {
        //查询失败原因模板
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.REFUSE_PLAYER_WITHDRAWAL);
        List<NoticeLocaleTmpl> failReasons = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);
        boolean bool = false;
        if (failReasons != null && failReasons.size() > 0) {
            bool = true;
        }
        Map<String, Object> map = new HashMap<>(2, 1f);
        map.put("state", bool);
        map.put("feeList", vPlayerTransactionVo.getFeeList());
        return map;
    }

    /**
     * 判断是否有下一条
     *
     * @param vo
     * @return
     */
    @RequestMapping("/hasNext")
    @ResponseBody
    public Map<String, Object> hasNext(VPlayerWithdrawVo vo) {
        vo.getSearch().setLockPersonId(SessionManager.getAuditUserId());
        vo = getService().searchNext(vo);
        Map<String, Object> map = new HashMap<>(2, 1f);
        if (vo.getResult() == null) {
            map.put("status", false);
            return map;
        }
        map.put("status", true);
        map.put("id", vo.getResult().getId());
        return map;
    }

    /**
     * 跳转兑换取款
     *
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "exchange", method = RequestMethod.GET)
    public String exchange(Model model, VPlayerWithdrawVo vo) {
        vo = getService().get(vo);
        VPlayerWithdraw playerWithdraw = vo.getResult();
        if (playerWithdraw == null || !CheckStatusEnum.SUCCESS.getCode().equals(playerWithdraw.getCheckStatus())) {
            return WITHDRAW_EXCHANGE_BIT;
        }
        model.addAttribute("command", vo);
        //查询比特币账户
        model.addAttribute("accounts", ServiceSiteTool.payAccountService().searchBitPayAccount(new PayAccountListVo()));
        return WITHDRAW_EXCHANGE_BIT;
    }

    /**
     * 兑换比特币
     *
     * @param playerWithdrawVo
     * @return
     */
    @RequestMapping(value = "/exchange", method = RequestMethod.POST)
    @ResponseBody
    public Map exchange(PlayerWithdrawVo playerWithdrawVo) {
        LOG.info("兑换比特币:用户-{1}取款id-{2}", SessionManager.getUserName(), playerWithdrawVo.getSearch().getId());
        try {
            Integer payAccountId = playerWithdrawVo.getPayAccountId();
            Map<String, Object> map = new HashMap<>();
            if (payAccountId == null) {
                map.put("status", false);
                map.put("notAccount", true);
                LOG.info("取款{0}兑换交易选择收款帐号为空", playerWithdrawVo.getSearch().getId());
                return map;
            }
            playerWithdrawVo = ServiceSiteTool.playerWithdrawService().get(playerWithdrawVo);
            PlayerWithdraw playerWithdraw = playerWithdrawVo.getResult();
            if (playerWithdraw == null) {
                map.put("status", false);
                LOG.info("取款{0}兑换交易无该笔交易订单", playerWithdrawVo.getSearch().getId());
                return map;
            }
            playerWithdrawVo.setResult(playerWithdraw);
            if (!WithdrawStatusEnum.SUCCESS.getCode().equals(playerWithdraw.getWithdrawStatus()) && !CheckStatusEnum.SUCCESS.getCode().equals(playerWithdraw.getCheckStatus())) {
                map.put("status", false);
                map.put("hasExchange", true);
                LOG.info("取款{0}兑换交易状态无权兑换{1}-{2}", playerWithdraw.getTransactionNo(), playerWithdraw.getWithdrawStatus(), playerWithdraw.getCheckStatus());
                return map;
            }
            //查询汇率
            CurrencyRate rate = queryRate(playerWithdrawVo);
            if (rate == null || rate.getAskRate() == null) {
                map.put("status", false);
                map.put("rate", true);
                LOG.info("取款{0}查询汇率出错", playerWithdraw.getTransactionNo());
                return map;
            }
            playerWithdrawVo.setRate(rate);
            playerWithdrawVo.setOperator(SessionManager.getUserName());
            playerWithdrawVo.setUserId(SessionManager.getUserId());
            return ServiceSiteTool.playerWithdrawService().exchangeBtc(playerWithdrawVo);
        } catch (Exception e) {
            Map<String, Object> map = new HashMap<>(1, 1f);
            map.put("state", false);
            return map;
        }
    }

    /**
     * 自动打款
     *
     * @param playerWithdrawVo
     * @return
     */
    @RequestMapping("/automaticPay")
    @ResponseBody
    public Map automaticPay(PlayerWithdrawVo playerWithdrawVo) {
        LOG.info("取款自动打款:用户-{1}取款id-{2}", SessionManager.getUserName(), playerWithdrawVo.getSearch().getId());
        try {
            playerWithdrawVo.setOperator(SessionManager.getUserName());
            playerWithdrawVo.setUserId(SessionManager.getUserId());
            playerWithdrawVo = ServiceSiteTool.playerWithdrawService().automaticPay(playerWithdrawVo);
        } catch (Exception e) {
            LOG.error(e, "自动打款失败");
        }
        return getVoMessage(playerWithdrawVo);
    }

    private CurrencyRate queryRate(PlayerWithdrawVo playerWithdrawVo) {
        String currency = playerWithdrawVo.getResult().getWithdrawMonetary();
        CurrencyExchangeRateVo rateVo = new CurrencyExchangeRateVo();
        rateVo.getQuery().addOrder(CurrencyExchangeRate.PROP_UPDATE_TIME, Direction.DESC);
        rateVo.getQuery().setCriterions(new Criterion[]{new Criterion(CurrencyExchangeRate.PROP_ITO_CURRENCY, Operator.EQ, CurrencyEnum.USD.getCode()),
                new Criterion(CurrencyExchangeRate.PROP_IFROM_CURRENCY, Operator.EQ, currency)});
        rateVo = ServiceTool.getCurrencyExchangeRateService().search(rateVo);
        CurrencyExchangeRate currencyExchangeRate = rateVo.getResult();
        CurrencyRate rate = new CurrencyRate();
        if (currencyExchangeRate == null) {
            rate = ServiceTool.currencyExchangeService().currencyToUsd(currency);
            saveOrUpdateRate(currencyExchangeRate, rate, currency);
        } else if (currencyExchangeRate.getUpdateTime().getTime() < SessionManager.getDate().getToday().getTime()) {
            rate = ServiceTool.currencyExchangeService().currencyToUsd(currency);
            if (rate == null) {
                LOG.info("更新汇率失败,用数据库原有汇率,{0}", playerWithdrawVo.getResult().getTransactionNo());
                rate = new CurrencyRate();
                rate.setRateTime(currencyExchangeRate.getUpdateTime());
                rate.setAskRate(new BigDecimal(String.valueOf(currencyExchangeRate.getRate())));
                rate.setQueryTime(SessionManager.getDate().getNow());
            } else {
                saveOrUpdateRate(currencyExchangeRate, rate, currency);
            }
        } else {
            rate.setRateTime(currencyExchangeRate.getUpdateTime());
            rate.setAskRate(new BigDecimal(String.valueOf(currencyExchangeRate.getRate())));
            rate.setQueryTime(SessionManager.getDate().getNow());
        }
        return rate;
    }

    private void saveOrUpdateRate(CurrencyExchangeRate currencyExchangeRate, CurrencyRate rate, String currency) {
        if (rate == null || rate.getAskRate() == null) {
            return;
        }
        if (currencyExchangeRate == null) {
            currencyExchangeRate = new CurrencyExchangeRate();
        }
        currencyExchangeRate.setItoCurrency(CurrencyEnum.USD.getCode());
        currencyExchangeRate.setIfromCurrency(currency);
        currencyExchangeRate.setUpdateUser(SessionManager.getUserId());
        CurrencyExchangeRateVo rateVo = new CurrencyExchangeRateVo();
        rateVo.setRate(rate);
        rateVo.setResult(currencyExchangeRate);
        ServiceTool.getCurrencyExchangeRateService().saveOrUpdateRate(rateVo);
    }

    /**
     * 出款账号
     *
     * @param
     * @return
     */
    @RequestMapping("/withdrawAccount")
    private String withdrawAccount(SysParamVo sysParamVo, Model model) {
        SysParam siteParam = ParamTool.getSysParam(SiteParamEnum.WITHDRAW_ACCOUNT);
        sysParamVo.setResult(siteParam);
        Map<String, Object> paramValueMap = JsonTool.fromJson(siteParam.getParamValue(), Map.class);
        List<Map<String, String>> channelJson = new ArrayList<>();
        Map<String,String> map = new HashMap<>();
        Map<String,String> rMap = new HashMap<>();
        Map<String,String> tMap = new HashMap<>();
        for (String str : paramValueMap.keySet()){
            if ("merchantCode".equals(str)){
                map.put("column","merchantCode");
                map.put("value",paramValueMap.get(str).toString());
                map.put("view","merchantCode");
                channelJson.add(map);
            }else if ("key".equals(str)){
                rMap.put("column","key");
                rMap.put("value",CryptoTool.aesDecrypt(paramValueMap.get(str).toString()));
                rMap.put("view","key");
                channelJson.add(rMap);
            }else if("publicKey".equals(str)){
                rMap.put("column","publicKey");
                rMap.put("value",CryptoTool.aesDecrypt(paramValueMap.get(str).toString()));
                rMap.put("view","publicKey");
                channelJson.add(rMap);
            }else if ("private_key".equals(str)){
                tMap.put("column","private_key");
                tMap.put("value",CryptoTool.aesDecrypt(paramValueMap.get(str).toString()));
                tMap.put("view","private_key");
                channelJson.add(tMap);
            }
        }
        model.addAttribute("channelJson", channelJson);
        model.addAttribute("paramValueMap", paramValueMap);
        model.addAttribute("command", sysParamVo);
//        model.addAttribute("validateRule", JsRuleCreator.create(PlayerWithdrawForm.class));
        List<Bank> list = new ArrayList();
        List<Bank> bankList = getBankList(BankPayTypeEnum.EASY_PAY.getCode());
        if (bankList != null && bankList.size() > 0) {
            for (Bank bank : bankList) {
                //bankName国际化处理
                String interlingua = LocaleTool.tranDict(DictEnum.BANKNAME, bank.getBankName());
                if (StringTool.isNotEmpty(interlingua)) {
                    bank.setInterlinguaBankName(interlingua);
                } else {
                    bank.setInterlinguaBankName(bank.getBankShortName());
                }
                list.add(bank);
            }
        }
        model.addAttribute("bankList", list);
        return WITHDRAW_ACCOUNT;
    }
    /**
     * 出款账号选择页面
     *
     * @param
     * @return
     */
    @RequestMapping("/selectWithdrawAccount")
    private String selectWithdrawAccount(VPlayerWithdrawVo objectVo,Model model) {
        model.addAttribute("withdrawVo",objectVo);

        //获取可用的代付出款账户
        WithdrawAccountListVo accountListVo = ServiceSiteTool.WithdrawAccountService().
                selectUsingWithdrawAccount(new WithdrawAccountListVo());

        if (accountListVo.isSuccess()){
            model.addAttribute("accountListVo",accountListVo);
            return SELECT_WITHDRAW_ACCOUNT;
        }
        //如果没有设置过出款(代付)账户，取v2029之前版本的易收付参数
        SysParam siteParam = ParamTool.getSysParam(SiteParamEnum.WITHDRAW_ACCOUNT);
        SysParamVo sysParamVo = new SysParamVo();
        sysParamVo.setResult(siteParam);
        Map<String, Object> paramValueMap = JsonTool.fromJson(siteParam.getParamValue(), Map.class);
        List<Map<String, String>> channelJson = new ArrayList<>();
        Map<String,String> map = new HashMap<>();
        Map<String,String> rMap = new HashMap<>();
        Map<String,String> tMap = new HashMap<>();
        for (String str : paramValueMap.keySet()){
            if ("merchantCode".equals(str)){
                map.put("column","merchantCode");
                map.put("value",paramValueMap.get(str).toString());
                map.put("view","merchantCode");
                channelJson.add(map);
            }else if ("key".equals(str)){
                rMap.put("column","key");
                rMap.put("value",CryptoTool.aesDecrypt(paramValueMap.get(str).toString()));
                rMap.put("view","key");
                channelJson.add(rMap);
            }else if("publicKey".equals(str)){
                rMap.put("column","publicKey");
                rMap.put("value",CryptoTool.aesDecrypt(paramValueMap.get(str).toString()));
                rMap.put("view","publicKey");
                channelJson.add(rMap);
            }else if ("private_key".equals(str)){
                tMap.put("column","private_key");
                tMap.put("value",CryptoTool.aesDecrypt(paramValueMap.get(str).toString()));
                tMap.put("view","private_key");
                channelJson.add(tMap);
            }
        }
        model.addAttribute("channelJson", channelJson);
        model.addAttribute("paramValueMap", paramValueMap);
        model.addAttribute("command", sysParamVo);
//        model.addAttribute("validateRule", JsRuleCreator.create(PlayerWithdrawForm.class));
        List<Bank> list = new ArrayList();
        List<Bank> bankList = getBankList(BankPayTypeEnum.EASY_PAY.getCode());
        if (bankList != null && bankList.size() > 0) {
            for (Bank bank : bankList) {
                //bankName国际化处理
                String interlingua = LocaleTool.tranDict(DictEnum.BANKNAME, bank.getBankName());
                if (StringTool.isNotEmpty(interlingua)) {
                    bank.setInterlinguaBankName(interlingua);
                } else {
                    bank.setInterlinguaBankName(bank.getBankShortName());
                }
                list.add(bank);
            }
        }
        model.addAttribute("bankList", list);
        return SELECT_WITHDRAW_ACCOUNT;
    }

    /**
     * 获取银行列表
     *
     * @param paytype
     * @return
     */
    private List<Bank> getBankList(String paytype) {
        BankListVo bankListVo = new BankListVo();
        bankListVo.getSearch().setType(BankEnum.TYPE_ONLINE.getCode());
        bankListVo.getSearch().setIsUse(true);
        bankListVo.setPaging(null);
        bankListVo.getSearch().setPayType(paytype);
        bankListVo.getQuery().addOrder(Bank.PROP_ORDER_NUM, Direction.ASC).addOrder(Bank.PROP_BANK_NAME, Direction.ASC);
        bankListVo = ServiceTool.bankService().queryBankByPayType(bankListVo);
        return bankListVo.getResult();
    }

    /**
     * 保存出款账户
     *
     * @param sysParamVo
     * @return
     */

    @RequestMapping("/saveWithdrawAccount")
    @ResponseBody
    public Map saveWithdrawAccount(SysParamVo sysParamVo) {
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.WITHDRAW_ACCOUNT);
        Map<String, Object> paramValueMap = JsonTool.fromJson(sysParam.getParamValue(), Map.class);

        Boolean isActiveOld = sysParam.getActive();//原来的出款账户状态
        Boolean isActiveNew = sysParamVo.getResult().getActive();//要保存的出款账户状态
        //只有启用状态才保存更新账户信息，否则只更新状态
        if (isActiveNew) {
            String paramValues = sysParamVo.getResult().getParamValue();
            String[] array = paramValues.split(",");
            if (array.length == 3 ){
                paramValueMap.put("withdrawChannel", array[0]);
                paramValueMap.put("key", CryptoTool.aesEncrypt(array[1]));
                paramValueMap.put("merchantCode", array[2]);
                paramValueMap.remove("publicKey");
                paramValueMap.remove("private_key");
            }else {
                paramValueMap.put("withdrawChannel", array[0]);
                paramValueMap.put("publicKey", CryptoTool.aesEncrypt(array[1]));
                paramValueMap.put("private_key", CryptoTool.aesEncrypt(array[2]));
                paramValueMap.put("merchantCode", array[3]);
                paramValueMap.remove("key");

            }

            if (!isActiveOld || isActiveOld == null) {//如果原来的出款账户状态为false，更新开启时间为当前时间
                paramValueMap.put("accountEnableTime", String.valueOf(new Date().getTime()));
            }
            String paramValueJosn = JsonTool.toJson(paramValueMap);
            sysParam.setParamValue(paramValueJosn);
        }
        sysParam.setActive(isActiveNew);
        sysParamVo.setResult(sysParam);
        sysParamVo = ServiceSiteTool.siteSysParamService().update(sysParamVo);
        ParamTool.refresh(SiteParamEnum.WITHDRAW_ACCOUNT);
        return this.getVoMessage(sysParamVo);
    }

    /**
     * 出款
     *
     * @param playerWithdrawVo
     * @return
     */
    @RequestMapping("/payment")
    @ResponseBody
    public Map<String, Object> payment(PlayerWithdrawVo playerWithdrawVo) {
        playerWithdrawVo.getSearch().setWithdrawCheckUserId(SessionManager.getUserId());
        try {
            playerWithdrawVo = ServiceSiteTool.playerWithdrawService().payment(playerWithdrawVo);
        } catch (Exception e) {
            LOG.error(e);
        }
        return getVoMessage(playerWithdrawVo);
    }

    /**
     * 出款状态/重新出款页面
     *
     * @param vo
     * @return
     */
    @RequestMapping({"/withdrawStatusView"})
    public String withdrawFailView(VPlayerWithdrawVo vo, Model model) {
        vo = ServiceSiteTool.getVPlayerWithdrawService().get(vo);
        if (vo.getResult() == null) {
            return null;
        }
        //查询玩家银行
        getPlayerBank(vo, model);
        vo.setThisUserId(SessionManager.getAuditUserId());
        model.addAttribute("command", vo);
        model.addAttribute("validateRule", JsRuleCreator.create(PlayerTransactionForm.class));
        return WITHDRAW_STATUS_VIEW_URl;
    }

    /**
     * 手动置订单状态为出款成功/出款失败
     *
     * @param
     * @return
     */
    @RequestMapping("/setPaymentStatus")
    @ResponseBody
    public Map<String, Object> setPaymentStatus(VPlayerWithdrawVo vo) {
        PlayerWithdrawVo playerWithdrawVo = new PlayerWithdrawVo();
        PlayerWithdrawSo playerWithdrawSo = playerWithdrawVo.getSearch();
        playerWithdrawSo.setTransactionNo(vo.getSearch().getTransactionNo());
        playerWithdrawSo.setCheckStatus(vo.getSearch().getCheckStatus());
        playerWithdrawSo.setWithdrawCheckUserId(SessionManager.getUserId());
        //如果手动置为失败需保存失败原因
        if (CheckStatusEnum.PAYMENT_FAIL.getCode().equals(vo.getSearch().getCheckStatus())) {
            String errorLog = LocaleTool.tranMessage(_Module.COMMON, "manual_failure");
            playerWithdrawSo.setWithdrawFailureReason(errorLog);
        }
        try {
            playerWithdrawVo = ServiceSiteTool.playerWithdrawService().setPaymentStatus(playerWithdrawVo);
        } catch (Exception e) {
            LOG.error(e);
        }
        return getVoMessage(playerWithdrawVo);
    }

    /**
     * 查询出款状态
     *
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping("/checkWithdrawStatus")
    public String checkWithdrawStatus(VPlayerWithdrawVo vo, Model model) {
        PlayerWithdrawVo playerWithdrawVo = new PlayerWithdrawVo();
        playerWithdrawVo.getSearch().setTransactionNo(vo.getSearch().getTransactionNo());
        playerWithdrawVo.getSearch().setWithdrawCheckUserId(SessionManager.getUserId());
        try {
            playerWithdrawVo = ServiceSiteTool.playerWithdrawService().checkWithdrawStatus(playerWithdrawVo);
        } catch (Exception e) {
            LOG.error(e);
        }
        model.addAttribute("command", playerWithdrawVo);
        return WITHDRAW_STATUS_REVIEW_URl;
    }
}
