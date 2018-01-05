package so.wwb.gamebox.mcenter.fund.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.collections.MapTool;
import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.string.EncodeTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.math.NumberTool;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.query.sort.Direction;
import org.soul.commons.support._Module;
import org.soul.model.log.audit.enums.OpType;
import org.soul.model.log.audit.vo.BaseLog;
import org.soul.model.log.audit.vo.LogVo;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.model.security.privilege.po.SysUser;
import org.soul.model.security.privilege.vo.SysUserListVo;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.model.sys.po.SysAuditLog;
import org.soul.model.sys.po.SysDict;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.fund.form.ManualDepositForm;
import so.wwb.gamebox.mcenter.fund.form.ManualWithdrawForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.ModuleType;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.common.AutoCompleter;
import so.wwb.gamebox.model.common.notice.enums.AutoNoticeEvent;
import so.wwb.gamebox.model.common.notice.enums.NoticeParamEnum;
import so.wwb.gamebox.model.company.setting.po.SysCurrency;
import so.wwb.gamebox.model.company.site.po.SiteCustomerService;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.enums.ActivityTypeEnum;
import so.wwb.gamebox.model.master.enums.RemarkEnum;
import so.wwb.gamebox.model.master.enums.TransactionOriginEnum;
import so.wwb.gamebox.model.master.fund.enums.RechargeTypeParentEnum;
import so.wwb.gamebox.model.master.fund.enums.TransactionTypeEnum;
import so.wwb.gamebox.model.master.fund.enums.TransactionWayEnum;
import so.wwb.gamebox.model.master.fund.enums.WithdrawTypeEnum;
import so.wwb.gamebox.model.master.fund.po.PlayerFavorable;
import so.wwb.gamebox.model.master.fund.po.PlayerRecharge;
import so.wwb.gamebox.model.master.fund.po.PlayerWithdraw;
import so.wwb.gamebox.model.master.fund.po.VPlayerDeposit;
import so.wwb.gamebox.model.master.fund.vo.*;
import so.wwb.gamebox.model.master.operation.po.ActivityMessage;
import so.wwb.gamebox.model.master.operation.po.VActivityMessage;
import so.wwb.gamebox.model.master.operation.vo.ActivityMessageVo;
import so.wwb.gamebox.model.master.operation.vo.VActivityMessageListVo;
import so.wwb.gamebox.model.master.player.po.PlayerTransaction;
import so.wwb.gamebox.model.master.player.po.Remark;
import so.wwb.gamebox.model.master.player.po.VUserPlayer;
import so.wwb.gamebox.model.master.player.vo.PlayerTransactionVo;
import so.wwb.gamebox.model.master.player.vo.RemarkVo;
import so.wwb.gamebox.model.master.player.vo.UserPlayerVo;
import so.wwb.gamebox.model.master.player.vo.VUserPlayerVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.*;

/**
 * Created by cherry on 16-7-19.
 */
@Controller
@RequestMapping("/fund/manual")
public class ManualController {
    /**
     * 人工存取页面
     */
    private static final String MANUAL_INDEX = "/fund/manual/Index";
    /**
     * 校验用户账号页面
     */
    private static final String MANUAL_CHECK = "/fund/manual/Check";
    /**
     * 人工存取-存入页面
     */
    private static final String MANUAL_DEPOSIT = "/fund/manual/Deposit";
    /**
     * 人工存取-取款页面
     */
    private static final String MANUAL_WITHDRAW = "/fund/manual/Withdraw";
    /**
     * 人工存取-失败页面
     */
    private static final String MANUAL_ERROR = "/fund/manual/Error";
    /**
     * 人工存入-详细页面
     */
    private static final String MANUAL_DEPOSIT_VIEW = "/fund/manual/DepositView";
    /**
     * 人工取出-详细页面
     */
    private static final String MANUAL_WITHDRAW_VIEW = "/fund/manual/WithdrawView";

    private Log LOG = LogFactory.getLog(ManualController.class);

    @RequestMapping("/index")
    @Token(generate = true)
    public String index(Model model, String type, String username, HttpServletRequest request) {
        model.addAttribute("type", type);
        //type为空显示存款，否则显示取款
        if (StringTool.isBlank(type)) {
            deposit(model, username, request);
        } else {
            withdraw(model, username);
        }
        model.addAttribute("hasReturn", request.getParameter("hasReturn"));
        model.addAttribute("fromPlayerDetail", request.getParameter("fromPlayerDetail"));
        model.addAttribute("playerId", request.getParameter("playerId"));
        model.addAttribute("activityType",ActivityTypeEnum.values());
        return MANUAL_INDEX;
    }

    @RequestMapping("/deposit")
    @Token(generate = true)
    public String deposit(Model model, String username, HttpServletRequest request) {
        //类型
        model.addAttribute("rechargeType", manualRechargeType());
        model.addAttribute("validateRule", JsRuleCreator.create(ManualDepositForm.class));
        model.addAttribute("username", username);
        String transactionNo = request.getParameter("transactionNo");
        model.addAttribute("transactionNo", transactionNo);
//        sales(model, transactionNo);//优惠活动
        return MANUAL_DEPOSIT;
    }

    @RequestMapping("/sales")
    @ResponseBody
    private List<Map<String, Object>> sales(String favorableType ,String transactionNo) {
        if (StringTool.isBlank(favorableType)) {
            return null;
        }
        VActivityMessageListVo vActivityMessageListVo = new VActivityMessageListVo();
        vActivityMessageListVo.getSearch().setActivityVersion(SessionManager.getLocale().toString());
        vActivityMessageListVo.getSearch().setIsDeleted(false);
        vActivityMessageListVo.getSearch().setCode(favorableType);
        if (StringTool.isNotBlank(transactionNo)) {
            vActivityMessageListVo.getSearch().setCodes(new String[]{ActivityTypeEnum.DEPOSIT_SEND.getCode(), ActivityTypeEnum.FIRST_DEPOSIT.getCode()});
        }
        vActivityMessageListVo.setProperties(VActivityMessage.PROP_ID, VActivityMessage.PROP_ACTIVITY_NAME,VActivityMessage.PROP_CODE);
        List<Map<String, Object>> mapList = ServiceSiteTool.vActivityMessageService().searchProperties(vActivityMessageListVo);
        return mapList;
    }

    @RequestMapping("/withdraw")
    @Token(generate = true)
    public String withdraw(Model model, String username) {
        model.addAttribute("withdrawType", manualWithdrawType());
        model.addAttribute("validateRule", JsRuleCreator.create(ManualWithdrawForm.class));
        model.addAttribute("username", username);
        return MANUAL_WITHDRAW;
    }

    /**
     * 验证玩家账号
     *
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/check")
    public String check(Model model, HttpServletRequest request) {
        String userNames = request.getParameter("userNames");
        if (StringTool.isNotBlank(userNames)) {
            userNames = EncodeTool.urlDecode(userNames);
        }
        model.addAttribute("illegalNames", userNames);
        return MANUAL_CHECK;
    }

    @RequestMapping("/error")
    public String error(Model model, String operateFails, int successNum, int failNum) {
        model.addAttribute("operateFails", operateFails);
        model.addAttribute("successNum", successNum);
        model.addAttribute("failNum", failNum);
        return MANUAL_ERROR;
    }

    /**
     * 人工存入
     *
     * @param playerRechargeVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping("/manualDeposit")
    @ResponseBody
    @Token(valid = true)
    @Audit(module = Module.FUND, moduleType = ModuleType.FUND_MANUAL, opType = OpType.RECHARGE)
    public Map<String, Object> manualDeposit(PlayerRechargeVo playerRechargeVo, @FormModel @Valid ManualDepositForm form, BindingResult result) {
        addDepositLog(playerRechargeVo, form);//添加日志
        Map<String, Object> map = new HashMap<>(5, 1f);
        if (result.hasErrors()) {
            return errorMsg(map);
        }
        try {
            Map<String, Object> existNameMap = illegalNames(form.get$userNames());
            List<String> illegalNames = (List<String>) existNameMap.get("illegalNames");
            if (CollectionTool.isNotEmpty(illegalNames)) {
                map.put("state", false);
                map.put("userNames", illegalNames);
                map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
                return map;
            }
            List<SysUser> existUser = (List<SysUser>) existNameMap.get("existUser");
            playerRechargeVo.setOrigin(TransactionOriginEnum.PC.getCode());
            map = handleManualDeposit(playerRechargeVo, existUser, map);
            if (!MapTool.getBoolean(map, "state")) {
                map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
            }
        } catch (Exception ex) {
            map.put("state", false);
            map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
            LogFactory.getLog(this.getClass()).error(ex, "人工存入出错");
        }

        return map;
    }

    /**
     * 人工存入日志
     * @param playerRechargeVo
     * @param form
     */
    private void addDepositLog(PlayerRechargeVo playerRechargeVo, @FormModel @Valid ManualDepositForm form) {
        HttpServletRequest request =((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        LogVo logVo=new LogVo();
        List<String> params = new ArrayList<>();
        Boolean isAuditRecharge = playerRechargeVo.getResult().getIsAuditRecharge();//存款稽核
        PlayerFavorable playerFavorable = playerRechargeVo.getPlayerFavorable();
        params.add(form.get$userNames());
        if (playerFavorable.getFavorable()!=null){
            String favorableType = "recharge_type." + playerRechargeVo.getFavorableType();
            String localStr = I18nTool.getLocalStr(favorableType, DictEnum.FUND_RECHARGE_TYPE.getModule().getCode(),
                    "dicts", CommonContext.get().getLocale());
            Boolean isAuditFavorable = playerFavorable.getIsAuditFavorable();
            params.add(playerFavorable.getFavorable().toString());
            params.add(localStr);
            params.add(isAuditFavorable.toString());
            if (isAuditFavorable){
                params.add(playerFavorable.getAuditFavorableMultiple().toString());
            }
        }else {
            PlayerRecharge result = playerRechargeVo.getResult();
            String rechargeType = "recharge_type." + result.getRechargeType();
            String localStr = I18nTool.getLocalStr(rechargeType, DictEnum.FUND_RECHARGE_TYPE.getModule().getCode(),
                    "dicts", CommonContext.get().getLocale());
            params.add(result.getRechargeAmount().toString());//存款金额
            params.add(localStr);//存款类型
            params.add(isAuditRecharge.toString());//是否稽核
            if (isAuditRecharge){
                params.add("是");
                params.add(playerRechargeVo.getAuditMultiple().toString());//稽核倍数
            }else {
                params.add("否");
                params.add("0");
            }
        }
        if (playerRechargeVo.getActivityName()!=null){
            params.add(playerRechargeVo.getActivityName());
        }
        BaseLog baseLog = logVo.addBussLog();
        for (String param : params){
            baseLog.addParam(param);
        }
        baseLog.setDescription("fund.manual.deposit");
        request.setAttribute(SysAuditLog.AUDIT_LOG, logVo);
    }

    /**
     * 人工取款
     *
     * @param playerWithdrawVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping("/manualWithdraw")
    @ResponseBody
    @Token(valid = true)
    @Audit(module = Module.FUND, moduleType = ModuleType.FUND_MANUAL, opType = OpType.WITHDRAW)
    public Map<String, Object> manualWithdraw(PlayerWithdrawVo playerWithdrawVo, @FormModel @Valid ManualWithdrawForm form, BindingResult result) {
        Map<String, Object> map = new HashMap<>(3, 1f);
        addWithdrawLog(playerWithdrawVo);//添加日志
        if (result.hasErrors()) {
            return errorMsg(map);
        }
        try {
            playerWithdrawVo.getResult().setCheckUserId(SessionManager.getUserId());
            playerWithdrawVo.setOperator(SessionManager.getAuditUserName());
            playerWithdrawVo = ServiceSiteTool.playerWithdrawService().manualWithdraw(playerWithdrawVo);
            if (playerWithdrawVo.isSuccess() && !TransactionWayEnum.MANUAL_PAYOUT.getCode().equals(playerWithdrawVo.getResult().getWithdrawType())) {
                map.put("id", playerWithdrawVo.getResult().getId());
                PlayerWithdraw playerWithdraw = playerWithdrawVo.getResult();
                sendNotice(AutoNoticeEvent.MANUAL_WITHDRAWAL, new Integer[]{playerWithdraw.getPlayerId()}, playerWithdraw.getWithdrawAmount(), playerWithdraw.getCreateTime());
            }
            map = resultMsg(playerWithdrawVo.isSuccess(), map);
            if (!MapTool.getBoolean(map, "state")) {
                map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
            }
        } catch (Exception ex) {
            map.put("state", false);
            map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
            LogFactory.getLog(this.getClass()).error(ex, "人工取出出错");
        }
        return resultMsg(playerWithdrawVo.isSuccess(), map);
    }

    /**
     * 人工取出日志
     * @param playerWithdrawVo
     */
    private void addWithdrawLog(PlayerWithdrawVo playerWithdrawVo) {
        HttpServletRequest request =((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        LogVo logVo=new LogVo();
        List<String> params = new ArrayList<>();
        PlayerWithdraw result = playerWithdrawVo.getResult();
        params.add(playerWithdrawVo.getUsername());
        params.add(result.getWithdrawAmount().toString());
        String withdrawType = "withdraw_type." + result.getWithdrawType();
        String localStr = I18nTool.getLocalStr(withdrawType, DictEnum.WITHDRAW_TYPE.getModule().getCode(),
                "dicts", CommonContext.get().getLocale());
        params.add(localStr);//取款类型
        if (result.getIsClearAudit()!= null){
            params.add("是");//清除稽核点
        }else {
            params.add("否");
        }
        BaseLog baseLog = logVo.addBussLog();
        for (String param : params){
            baseLog.addParam(param);
        }
        baseLog.setDescription("fund.manual.withdraw");
        request.setAttribute(SysAuditLog.AUDIT_LOG, logVo);
    }

    private void sendNotice(AutoNoticeEvent autoNoticeEvent, Integer[] userIds, Double amount, Date createTime) {
        NoticeVo noticeVo = NoticeVo.autoNotify(autoNoticeEvent, userIds);
        try {
            addParams(noticeVo, amount, createTime);
            ServiceTool.noticeService().publish(noticeVo);
        } catch (Exception ex) {
            LOG.error(ex, "发布消息不成功");
        }
    }

    private void addParams(NoticeVo noticeVo, Double amount, Date createTime) {
        Pair<String, String> orderAmount = new Pair<>(NoticeParamEnum.ORDER_AMOUNT.getCode(), CurrencyTool.formatCurrency(amount));
        Pair<String, String> orderLaunchTime = new Pair(NoticeParamEnum.ORDER_LAUNCH_TIME.getCode(),
                LocaleDateTool.formatDate(createTime, CommonContext.getDateFormat().getDAY_SECOND(), SessionManager.getTimeZone()));
        Pair<String, String> customer = getCustomer();
        noticeVo.addParams(orderAmount, orderLaunchTime, customer);
    }

    /**
     * 客服设置
     */
    private Pair<String, String> getCustomer() {
        Pair<String, String> customer;
        SiteCustomerService siteCustomerService = Cache.getDefaultCustomerService();
        if (siteCustomerService != null) {
            String url = siteCustomerService.getParameter();
            if (StringTool.isNotBlank(url) && !url.contains("http")) {
                url = "http://" + url;
            }
            customer = new Pair<>(NoticeParamEnum.CUSTOMER.getCode(), "<a class=\"\" href=\"" + url
                    + "\" target=\"_blank\">" + LocaleTool.tranMessage(_Module.COMMON, "contactCustomerService") + "</a>");
        } else {
            customer = new Pair<>(NoticeParamEnum.CUSTOMER.getCode(), LocaleTool.tranMessage(_Module.COMMON, "contactCustomerService"));
        }
        return customer;
    }

    /**
     * 检查玩家账号
     *
     * @param username
     * @return
     */
    @RequestMapping("/checkUserName")
    @ResponseBody
    public boolean checkUserName(@RequestParam("username") String username) {
        SysUserListVo sysUserListVo = new SysUserListVo();
        sysUserListVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(SysUser.PROP_USERNAME, Operator.EQ, username),
                new Criterion(SysUser.PROP_USER_TYPE, Operator.EQ, UserTypeEnum.PLAYER.getCode()),
                new Criterion(SysUser.PROP_SITE_ID, Operator.EQ, SessionManager.getSiteId())
        });
        long count = ServiceTool.sysUserService().count(sysUserListVo);
        return count > 0d;
    }

    /**
     * 检查金额
     *
     * @param withdrawAmount
     * @param username
     * @return
     */
    @RequestMapping("/checkMoney")
    @ResponseBody
    public boolean checkMoney(@RequestParam("result.withdrawAmount") String withdrawAmount, @RequestParam("username") String username) {
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setUsername(username);
        Double walletBalance = ServiceSiteTool.userPlayerService().queryWalletBalance(sysUserVo);
        if (walletBalance == null) {
            return false;
        }
        Double amount = NumberTool.toDouble(withdrawAmount);
        return amount <= walletBalance;
    }

    /**
     * 查询钱包余额
     *
     * @param username
     * @return
     */
    @RequestMapping("/walletBalance")
    @ResponseBody
    public Map walletBalance(String username) {
        VUserPlayerVo vUserPlayerVo = new VUserPlayerVo();
        vUserPlayerVo.getSearch().setUsername(username);
        vUserPlayerVo = ServiceSiteTool.vUserPlayerService().search(vUserPlayerVo);
        Map<String, String> map = new HashMap<>(3, 1f);
        map.put(VUserPlayer.PROP_WALLET_BALANCE, CurrencyTool.formatInteger(vUserPlayerVo.getResult().getWalletBalance()));
        map.put(VUserPlayer.PROP_DEFAULT_CURRENCY, getCurrencySign(vUserPlayerVo.getResult().getDefaultCurrency()));
        map.put("decimals", CurrencyTool.formatDecimals(vUserPlayerVo.getResult().getWalletBalance()));
        return map;
    }

    /**
     * 实时查询玩家账号
     *
     * @param query
     * @return
     */
    @RequestMapping("/queryUserName")
    @ResponseBody
    public String queryUserName(String query) {
        SysUserListVo sysUserListVo = new SysUserListVo();
        sysUserListVo.setProperties(SysUser.PROP_USERNAME);
        sysUserListVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(SysUser.PROP_USER_TYPE, Operator.EQ, UserTypeEnum.PLAYER.getCode()),
                new Criterion(SysUser.PROP_SITE_ID, Operator.EQ, SessionManager.getSiteId()),
                new Criterion(SysUser.PROP_USERNAME, Operator.LIKE, query)
        });
        sysUserListVo.setPaging(null);
        //sysUserListVo.getPaging().setPageSize(5);
        sysUserListVo.getQuery().addOrder(SysUser.PROP_ID, Direction.DESC);
        sysUserListVo = ServiceTool.sysUserService().search(sysUserListVo);
        if (CollectionTool.isEmpty(sysUserListVo.getResult())) {
            return JsonTool.toJson(new ArrayList<>());
        }
        return JsonTool.toJson(
                new AutoCompleter().getCompleters(CollectionTool.extractToMap(sysUserListVo.getResult(), SysUser.PROP_USERNAME, SysUser.PROP_USERNAME)));
    }

    @RequestMapping("/depositView")
    public String depositView(PlayerTransactionVo playerTransactionVo, Model model) {
        playerTransactionVo = ServiceSiteTool.getPlayerTransactionService().get(playerTransactionVo);
        model.addAttribute("command", playerTransactionVo);
        Map transactionDataMap = JsonTool.fromJson(playerTransactionVo.getResult().getTransactionData(),HashMap.class);
        String activityId = MapTool.getString(transactionDataMap,"activityId");
        model.addAttribute("activityId",activityId);
        if(StringTool.isNotEmpty(activityId)){
            ActivityMessageVo activityMessageVo = new ActivityMessageVo();
            activityMessageVo.getSearch().setId(Integer.valueOf(activityId));
            activityMessageVo = ServiceTool.activityMessageService().get(activityMessageVo);
            model.addAttribute("activityMessage",activityMessageVo.getResult());
        }
        model.addAttribute("activityName",MapTool.getString(transactionDataMap,"activityName"));
        model.addAttribute("activityType",MapTool.getString(transactionDataMap,"activityType"));
        PlayerTransaction playerTransaction = playerTransactionVo.getResult();
        LOG.info("查询人工存款详细，交易号{0}", playerTransaction.getTransactionNo());
        if (TransactionTypeEnum.DEPOSIT.getCode().equals(playerTransaction.getTransactionType())) {
            recharge(playerTransaction, model);
        } else if (TransactionTypeEnum.FAVORABLE.getCode().equals(playerTransaction.getTransactionType())) {
            favorable(playerTransaction, model);
        }

        return MANUAL_DEPOSIT_VIEW;
    }

    private void recharge(PlayerTransaction playerTransaction, Model model) {
        VPlayerDepositVo vPlayerDepositVo = new VPlayerDepositVo();
        vPlayerDepositVo.getSearch().setId(playerTransaction.getSourceId());
        vPlayerDepositVo = ServiceSiteTool.vPlayerDepositService().get(vPlayerDepositVo);
        VPlayerDeposit vPlayerDeposit = vPlayerDepositVo.getResult();
        model.addAttribute("username", vPlayerDeposit.getUsername());
        model.addAttribute("currency", getCurrencySign(vPlayerDeposit.getDefaultCurrency()));
        model.addAttribute("operator", vPlayerDeposit.getCheckUsername());
        model.addAttribute("remark", vPlayerDeposit.getCheckRemark());
    }

    private void favorable(PlayerTransaction playerTransaction, Model model) {
        LOG.info("查询手动优惠详细：id:{0}", playerTransaction.getSourceId());
        PlayerFavorableVo playerFavorableVo = new PlayerFavorableVo();
        playerFavorableVo.getSearch().setId(playerTransaction.getSourceId());
        playerFavorableVo = ServiceSiteTool.playerFavorableService().get(playerFavorableVo);
        SysUser sysUser = getUser(playerFavorableVo.getResult().getOperatorId());
        if (sysUser != null) {
            model.addAttribute("operator", sysUser.getUsername());
        }
        sysUser = getUser(playerTransaction.getPlayerId());
        model.addAttribute("username", sysUser.getUsername());
        model.addAttribute("currency", getCurrencySign(sysUser.getDefaultCurrency()));
        model.addAttribute("remark", playerFavorableVo.getResult().getFavorableRemark());
        model.addAttribute("favorableAudit", playerFavorableVo.getResult().getAuditFavorableMultiple());
        model.addAttribute("transactionData", JsonTool.fromJson(playerTransaction.getTransactionData(), HashMap.class));
    }

    @RequestMapping("/withdrawView")
    public String withdrawView(VPlayerWithdrawVo vPlayerWithdrawVo, Model model) {
        vPlayerWithdrawVo = ServiceSiteTool.vPlayerWithdrawService().get(vPlayerWithdrawVo);
        model.addAttribute("command", vPlayerWithdrawVo);
        model.addAttribute("currency", getCurrencySign(vPlayerWithdrawVo.getResult().getWithdrawMonetary()));
        return MANUAL_WITHDRAW_VIEW;
    }

    @RequestMapping("/updateRemark")
    @ResponseBody
    public Map updateRemark(PlayerTransactionVo playerTransactionVo, String remarkContent) {
        Map<String, Object> map = new HashMap<>(2, 1f);
        Integer entityId = playerTransactionVo.getResult().getSourceId();
        String transactionType = playerTransactionVo.getResult().getTransactionType();
        if (TransactionTypeEnum.FAVORABLE.getCode().equals(transactionType)) {
            updateFavorableRemark(entityId, remarkContent, playerTransactionVo.getResult().getPlayerId());
        } else if (TransactionTypeEnum.DEPOSIT.getCode().equals(transactionType)) {
            updateRechargeRemark(entityId, remarkContent, playerTransactionVo.getResult().getPlayerId());
        } else if (TransactionTypeEnum.WITHDRAWALS.getCode().equals(transactionType)) {
            updateWithdrawRemark(entityId, remarkContent, playerTransactionVo.getResult().getPlayerId());
        }
        return resultMsg(playerTransactionVo.isSuccess(), map);
    }

    private void updateFavorableRemark(Integer entityId, String remark, Integer playerId) {
        PlayerFavorableVo playerFavorableVo = new PlayerFavorableVo();
        PlayerFavorable playerFavorable = new PlayerFavorable();
        playerFavorable.setId(entityId);
        playerFavorable.setFavorableRemark(remark);
        playerFavorableVo.setResult(playerFavorable);
        playerFavorableVo.setProperties(PlayerFavorable.PROP_FAVORABLE_REMARK);
        ServiceSiteTool.playerFavorableService().updateOnly(playerFavorableVo);
        saveOrUpdateRemark(entityId, RemarkEnum.FUND_ARTIFICIAL_DEPOSIT.getModel(), RemarkEnum.FUND_ARTIFICIAL_DEPOSIT.getType(), remark, playerId);
    }

    private void updateRechargeRemark(Integer entityId, String remark, Integer playerId) {
        PlayerRechargeVo playerRechargeVo = new PlayerRechargeVo();
        PlayerRecharge playerRecharge = new PlayerRecharge();
        playerRecharge.setId(entityId);
        playerRecharge.setCheckRemark(remark);
        playerRechargeVo.setResult(playerRecharge);
        playerRechargeVo.setProperties(PlayerRecharge.PROP_CHECK_REMARK);
        ServiceSiteTool.playerRechargeService().updateOnly(playerRechargeVo);
        saveOrUpdateRemark(entityId, RemarkEnum.FUND_ARTIFICIAL_DEPOSIT.getModel(), RemarkEnum.FUND_ARTIFICIAL_DEPOSIT.getType(), remark, playerId);
    }

    private void updateWithdrawRemark(Integer entityId, String remark, Integer playerId) {
        PlayerWithdrawVo playerWithdrawVo = new PlayerWithdrawVo();
        PlayerWithdraw playerWithdraw = new PlayerWithdraw();
        playerWithdraw.setCheckRemark(remark);
        playerWithdraw.setId(entityId);
        playerWithdrawVo.setResult(playerWithdraw);
        playerWithdrawVo.setProperties(PlayerWithdraw.PROP_CHECK_REMARK);
        ServiceSiteTool.playerWithdrawService().updateOnly(playerWithdrawVo);
        saveOrUpdateRemark(entityId, RemarkEnum.FUND_ARTIFICIAL_DRAW.getModel(), RemarkEnum.FUND_ARTIFICIAL_DRAW.getType(), remark, playerId);
    }

    private void saveOrUpdateRemark(Integer entityId, String model, String type, String remarkContent, Integer entityUserId) {
        RemarkVo remarkVo = new RemarkVo();
        Remark remark = new Remark();
        remark.setEntityId(entityId);
        remark.setOperator(SessionManager.getUserName());
        remark.setOperatorId(SessionManager.getAuditUserId());
        remark.setModel(model);
        remark.setRemarkType(type);
        remark.setRemarkContent(remarkContent);
        remark.setEntityUserId(entityUserId);
        remark.setRemarkTime(SessionManager.getDate().getNow());
        remarkVo.setResult(remark);
        ServiceTool.getRemarkService().saveOrUpdateRemark(remarkVo);
    }


    /**
     * 错误信息
     *
     * @param map
     * @return
     */
    private Map<String, Object> errorMsg(Map<String, Object> map) {
        map.put("state", false);
        map.put("msg", LocaleTool.tranMessage("fund_auto", "由于网络繁忙"));
        return map;
    }

    /**
     * 结果消息
     *
     * @param isSuccess
     * @param map
     * @return
     */
    private Map<String, Object> resultMsg(boolean isSuccess, Map<String, Object> map) {
        map.put("state", isSuccess);
        if (isSuccess) {
            map.put("msg", LocaleTool.tranMessage("fund_auto", "操作成功"));
        } else {
            map.put("msg", LocaleTool.tranMessage("fund_auto", "由于网络繁忙"));
        }
        return map;
    }

    private Map<String, Object> handleManualDeposit(PlayerRechargeVo playerRechargeVo, List<SysUser> existUser, Map<String, Object> map) {
        Set<String> operateFails = new HashSet<>();
        Set<Integer> operateSuccess = new HashSet<>();
        Integer checkUserId = SessionManager.getUserId();
        String checkUserName = SessionManager.getAuditUserName();
        Date date = SessionManager.getDate().getNow();
        for (SysUser sysUser : existUser) {
            playerRechargeVo.setSysUser(sysUser);
            playerRechargeVo.getResult().setCheckUserId(checkUserId);
            playerRechargeVo.getResult().setCheckUsername(checkUserName);
            playerRechargeVo.getResult().setId(null);
            playerRechargeVo.getResult().setCreateTime(date);
            try {
                playerRechargeVo = ServiceSiteTool.playerRechargeService().manualRecharge(playerRechargeVo);
            } catch (Exception e) {
                LOG.error(e);
                playerRechargeVo.setSuccess(false);
                operateFails.add(sysUser.getUsername());
            }
            if (!playerRechargeVo.isSuccess()) {
                operateFails.add(sysUser.getUsername());
            } else {
                operateSuccess.add(sysUser.getId());
            }
        }
        boolean isSuccess = true;
        int failNum = operateFails.size();
        if (failNum == existUser.size()) {
            isSuccess = false;
        }
        if (failNum > 0) {
            map.put("operateFails", operateFails);
            map.put("failNum", failNum);
            map.put("successNum", existUser.size() - failNum);
        }
        if (CollectionTool.isNotEmpty(operateSuccess) && StringTool.isEmpty(playerRechargeVo.getSearch().getTransactionNo()) && !TransactionWayEnum.MANUAL_PAYOUT.getCode().equals(playerRechargeVo.getResult().getRechargeType()) && playerRechargeVo.getResult() != null && playerRechargeVo.getResult().getRechargeAmount() != null) {
            sendNotice(AutoNoticeEvent.MANUAL_RECHARGE_SUCCESS, operateSuccess.toArray(new Integer[operateSuccess.size()]), playerRechargeVo.getResult().getRechargeAmount(), date);
        }
        if (CollectionTool.isNotEmpty(operateSuccess) && !TransactionWayEnum.MANUAL_PAYOUT.getCode().equals(playerRechargeVo.getFavorableType()) && playerRechargeVo.getPlayerFavorable() != null && playerRechargeVo.getPlayerFavorable().getFavorable() != null) {
            sendNotice(AutoNoticeEvent.MANUAL_RECHARGE_SUCCESS, operateSuccess.toArray(new Integer[operateSuccess.size()]), playerRechargeVo.getPlayerFavorable().getFavorable(), date);
        }
        return resultMsg(isSuccess, map);
    }


    /**
     * 查询人工存入类型
     *
     * @return
     */
    private List<SysDict> manualRechargeType() {
        Map<String, SysDict> rechargeTypeMap = DictTool.get(so.wwb.gamebox.model.DictEnum.FUND_RECHARGE_TYPE);
        List<SysDict> manualRechargeTypeList = new ArrayList<>();
        String rechargeTypeParent = RechargeTypeParentEnum.ARTIFICIAL_DEPOSIT.getCode();
        for (SysDict dict : rechargeTypeMap.values()) {
            if (rechargeTypeParent.equals(dict.getParentCode())) {
                manualRechargeTypeList.add(dict);
            }
        }
        return manualRechargeTypeList;
    }

    /**
     * 查询人工取出类型
     *
     * @return
     */
    private List<SysDict> manualWithdrawType() {
        Map<String, SysDict> rechargeTypeMap = DictTool.get(so.wwb.gamebox.model.DictEnum.WITHDRAW_TYPE);
        List<SysDict> manualWithdrawTypeList = new ArrayList<>();
        String withdrawTypeParent = WithdrawTypeEnum.ARTIFICIAL.getCode();
        for (SysDict dict : rechargeTypeMap.values()) {
            if (withdrawTypeParent.equals(dict.getParentCode())) {
                manualWithdrawTypeList.add(dict);
            }
        }
        return manualWithdrawTypeList;
    }


    private Map<String, Object> illegalNames(String userNames) {
        userNames = userNames.replaceAll(" ", "");
        String[] userName = userNames.split(",");
        UserPlayerVo userPlayerVo = new UserPlayerVo();
        userPlayerVo.setProperties(userName);
        List<SysUser> existUser = ServiceSiteTool.userPlayerService().queryIgnoreCaseUserNamesExists(userPlayerVo);
        List<String> existUserNames = new ArrayList<>(existUser.size());
        for (SysUser sysUser : existUser) {
            existUserNames.add(StringTool.lowerCase(sysUser.getUsername()));
        }
        List<String> notExistUserNames = new ArrayList<>();
        for (String name : userName) {
            String lowerName = StringTool.lowerCase(name);
            if (!existUserNames.contains(lowerName) && !notExistUserNames.contains(lowerName)) {
                notExistUserNames.add(name);
            }
        }
        Map<String, Object> map = new HashMap<>(2, 1f);
        map.put("illegalNames", notExistUserNames);
        map.put("existUser", existUser);
        return map;
    }

    private String getCurrencySign(String defaultCurrency) {
        if (StringTool.isBlank(defaultCurrency)) {
            return "";
        }
        SysCurrency sysCurrency = Cache.getSysCurrency().get(defaultCurrency);
        if (sysCurrency != null) {
            return sysCurrency.getCurrencySign();
        }
        return "";
    }

    private SysUser getUser(Integer playerId) {
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setId(playerId);
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        return sysUserVo.getResult();
    }
}
