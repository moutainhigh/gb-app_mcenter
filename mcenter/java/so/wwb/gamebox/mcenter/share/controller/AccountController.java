package so.wwb.gamebox.mcenter.share.controller;


import org.soul.commons.bean.Pair;
import org.soul.commons.dict.DictTool;
import org.soul.commons.enums.EnumTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.BooleanTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.LogFactory;
import org.soul.commons.support._Module;
import org.soul.iservice.security.privilege.ISysUserService;
import org.soul.model.log.audit.enums.OpMode;
import org.soul.model.msg.notice.enums.INoticeEventType;
import org.soul.model.msg.notice.vo.NoticeLocaleTmpl;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.model.security.privilege.po.SysUser;
import org.soul.model.security.privilege.vo.SysUserListVo;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.model.sys.po.SysDict;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.security.privilege.form.SysUserForm;
import org.soul.web.security.privilege.form.SysUserSearchForm;
import org.soul.web.session.RedisSessionDao;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.player.IVUserPlayerService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.common.notice.enums.ManualNoticeEvent;
import so.wwb.gamebox.model.common.notice.enums.NoticeParamEnum;
import so.wwb.gamebox.model.company.site.po.SiteCustomerService;
import so.wwb.gamebox.model.company.sys.vo.SysSiteVo;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.listop.FreezeTime;
import so.wwb.gamebox.model.listop.FreezeType;
import so.wwb.gamebox.model.master.player.po.UserPlayer;
import so.wwb.gamebox.model.master.player.vo.*;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.shiro.common.filter.KickoutFilter;

import java.util.*;


@Controller
//region your codes 1
/**
 * Created by jeff on 15-12-18.
 * 账号相关操作（停用，冻结，找回密码）
 */
@RequestMapping("/share/account")
public class AccountController extends BaseCrudController<ISysUserService, SysUserListVo, SysUserVo, SysUserSearchForm, SysUserForm, SysUser, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/share/account/";
        //endregion your codes 2
    }

    //region your codes 3
    @Autowired
    private RedisSessionDao redisSessionDao;
    /**
     * 账号停用
     *
     * @param accountVo
     * @return
     */
    @RequestMapping(value = "/disabledAccount", method = RequestMethod.GET)
    @Token(generate = true)
    public String disabledAccount(Model model, AccountVo accountVo) {
        String type = accountVo.getType();
        INoticeEventType eventType = getDisabledNoticeEventType(type);


        /*停用模板 账号信息 在线状态*/
        /*模板*/
        accountVo = ServiceSiteTool.userPlayerService().accountOption(accountVo);
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(eventType);
        List<NoticeLocaleTmpl> noticeLocaleTmpls = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);
        accountVo.setNoticeLocaleTmpls(noticeLocaleTmpls);

        accountVo.setValidateRule(JsRuleCreator.create(so.wwb.gamebox.mcenter.share.form.AccountOptionForm.class, "result"));
        accountVo.setType(type);
        model.addAttribute("command", accountVo);
        isUserOnline(accountVo, model);
        return getViewBasePath() + "DisabledAccount";

    }

    /*
     * 基于账号类型获取账号停用消息通知事件类型
     * @param accountVo
     * @return
     */
    private INoticeEventType getDisabledNoticeEventType(String accountType) {
        INoticeEventType eventType = null;
        if (AccountVo.TYPE_AGENT.equals(accountType)) {
            eventType = ManualNoticeEvent.ACENTER_ACCOUNT_STOP;
        } else if (AccountVo.TYPE_TOPAGENT.equals(accountType)) {
            eventType = ManualNoticeEvent.TCENTER_ACCOUNT_STOP;
        } else {
            eventType = ManualNoticeEvent.PLAYER_ACCOUNT_STOP;
        }
        return eventType;
    }

    /*
     * 基于账号类型获取账号冻结消息通知事件类型
     * @param accountVo
     * @return
     */
    private INoticeEventType getFreezeNoticeEventType(String accountType) {
        INoticeEventType eventType = null;
        if (AccountVo.TYPE_AGENT.equals(accountType)) {
            eventType = ManualNoticeEvent.ACENTER_ACCOUNT_FREEZON;
        } else if (AccountVo.TYPE_TOPAGENT.equals(accountType)) {
            eventType = ManualNoticeEvent.TCENTER_ACCOUNT_FREEZON;
        } else {
            eventType = ManualNoticeEvent.PLAYER_ACCOUNT_FREEZON;
        }
        return eventType;
    }

    /**
     * 账号停用
     *
     * @param model
     * @param accountVo
     * @return
     */
    @RequestMapping(value = "setAccountDisabled", method = RequestMethod.POST)
    @ResponseBody
    @Token(valid = true)
    public Map setAccountDisabled(Model model, AccountVo accountVo) {
        createRemarkTitle(accountVo, "account.disabledAccount.text");
        ServiceSiteTool.userPlayerService().setAccountDisabled(accountVo);
        /*踢出当前登录的用户*/
        //loginKickout(accountVo.getResult().getId());
        KickoutFilter.loginKickoutAll(accountVo.getResult().getId(), OpMode.MANUAL,"站长中心停用玩家密码强制踢出");
        // code by cogo
        INoticeEventType eventType = getDisabledNoticeEventType(accountVo.getType());
        // code by cogo end
        String messageType = "accountDisabled";
        NoticeVo noticeVo = buildNoticeParam(messageType,accountVo,eventType);
        sendMessageByGroupCode(noticeVo);
        return getVoMessage(accountVo);
    }

    @RequestMapping("/freezeAccount")
    @Token(generate = true)
    public String freezeAccount(Model model, AccountVo accountVo) {
        String type = accountVo.getType();
        /*冻结模板 账号信息 在线状态*/
        accountVo = ServiceSiteTool.userPlayerService().accountOption(accountVo);
        Map<String, SysDict> freezeTime = DictTool.get(DictEnum.COMMON_FREEZE_TIME);
        accountVo.setFreezeTime(freezeTime);
        // code by cogo
        INoticeEventType eventType = getFreezeNoticeEventType(type);
        // code by cogo end
        /*模板*/

        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(eventType);
        List<NoticeLocaleTmpl> noticeLocaleTmpls = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);
        accountVo.setNoticeLocaleTmpls(noticeLocaleTmpls);
        accountVo.setValidateRule(JsRuleCreator.create(so.wwb.gamebox.mcenter.share.form.AccountOptionForm.class, "result"));
        accountVo.setType(type);
        model.addAttribute("command", accountVo);
        isUserOnline(accountVo, model);
        return getViewBasePath() + "FreezeAccount";
    }

    /**
     * 账号冻结
     *
     * @param model
     * @param accountVo
     * @return
     */
    @RequestMapping("/setFreezeAccount")
    @ResponseBody
    @Token(valid = true)
    public Map setFreezeAccount(Model model, AccountVo accountVo) {

        INoticeEventType eventType = getFreezeNoticeEventType(accountVo.getType());
        /*'备注类型 sys_dict Model：common,Dict_type：remark_type';*/
        createRemarkTitle(accountVo, "account.freezeAccount.text");
        /*踢出当前登录的用户*/
        //loginKickout(accountVo.getResult().getId());
        KickoutFilter.loginKickoutAll(accountVo.getResult().getId(),OpMode.MANUAL,"站长中心冻结玩家密码强制踢出");
        kickoutFromApi(accountVo.getResult().getId());
        /*发送信息*/
        String messageType = "accountFreeze";//玩家账号冻结
        NoticeVo noticeVo = buildNoticeParam(messageType, accountVo, eventType);
        //NoticeVo noticeVo = sendMessageByGroupCode(messageType, accountVo, accountVo.getGroupCode(), accountVo.getResult().getId(), eventType);
        String freezeContent = accountVo.getSearch().getFreezeContent();
        if(StringTool.isBlank(freezeContent)){
            if(FreezeTime.FORERVE.getCode().equals(accountVo.getChooseFreezeTime())){
                freezeContent = LocaleTool.tranMessage("playerFrozen","player.frozen.account.forever");
            }else{
                freezeContent = LocaleTool.tranMessage("playerFrozen","player.frozen.account");
            }
        }
        accountVo.setBalanceFreezeContent(freezeContent);
        freezeContent = formatContent(accountVo);
        String content = StringTool.fillTemplate(freezeContent, noticeVo.getParamMap());
        accountVo.getSearch().setFreezeContent(content);
        accountVo = ServiceSiteTool.userPlayerService().setAccountFreeze(accountVo);
        sendMessageByGroupCode(noticeVo);
        return getVoMessage(accountVo);
    }

    private void kickoutFromApi(Integer userId){
        try{
            PlayerApiAccountListVo accountListVo = new PlayerApiAccountListVo();
            accountListVo.getSearch().setUserId(userId);
            accountListVo = ServiceSiteTool.playerApiAccountService().search(accountListVo);
            SysUser sysUser = getSysUser(userId);
            accountListVo.setSysUser(sysUser);
            ServiceSiteTool.playerApiAccountService().kickoutFromApi(accountListVo);
        }catch (Exception ex){
            LogFactory.getLog(this.getClass()).error(ex,"从API踢出玩家失败，但不影响操作");
        }

    }
    private SysUser getSysUser(Integer userId){
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setId(userId);
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        return sysUserVo.getResult();
    }

    /***
     * 取消账户冻结前查看
     */
    @RequestMapping("/toCancelAccountFreeze")
    public String toCancelAccountFreeze(VSysUserPlayerFrozenVo vo, Model model, String sign) {
        vo = ServiceSiteTool.vSysUserPlayerFrozenService().get(vo);
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.setResult(new SysUser());
        sysUserVo.getSearch().setId(vo.getResult().getFreezeUser());
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        SysUserVo onlineUser = new SysUserVo();
        onlineUser.getSearch().setId(vo.getResult().getId());
        onlineUser = ServiceTool.sysUserService().get(onlineUser);
        isUserOnline(onlineUser, model);
        model.addAttribute("command", vo);
        if (sysUserVo != null && sysUserVo.getResult() != null) {
            model.addAttribute("username", sysUserVo.getResult().getUsername());
        }
        if ("player".equals(sign)) {
            model.addAttribute("urls", "/player/playerView.html");
        }
        if ("agent".equals(sign)) {
            model.addAttribute("urls", "/userAgent/agent/detail.html");
        }
        if ("topAgent".equals(sign)) {
            model.addAttribute("urls", "/userAgent/topagent/detail.html");
        }

        return getViewBasePath() + "CancelFreezeAccount";
    }

    //TODO: water on line is need modify
    private void isUserOnline(SysUserVo sysUserVo, Model model) {
        IVUserPlayerService vUserPlayerService = ServiceSiteTool.vUserPlayerService();
        VUserPlayerVo vUserPlayerVo = new VUserPlayerVo();
        vUserPlayerVo.getSearch().setId(sysUserVo.getResult().getId());
        vUserPlayerVo = vUserPlayerService.get(vUserPlayerVo);
        if (vUserPlayerVo.getResult() != null
                && BooleanTool.isTrue(vUserPlayerVo.getResult().getOnLine())) {
            model.addAttribute("isOnline",true);
        } else {
            model.addAttribute("isOnline",false);
        }

    }

    /***
     * 取消账户冻结
     *
     * @param accountVo
     * @return
     */
    @RequestMapping("/cancelAccountFreeze")
    @ResponseBody
    public Map cancelAccountFreeze(AccountVo accountVo) {
        accountVo.setResult(new SysUser());
        accountVo.getResult().setId(accountVo.getSearch().getId());
        accountVo.getResult().setFreezeEndTime(new Date());
        accountVo.getResult().setLoginErrorTimes(0);
        accountVo.setProperties(SysUser.PROP_FREEZE_END_TIME, SysUser.PROP_LOGIN_ERROR_TIMES);
        ServiceTool.sysUserService().updateOnly(accountVo);
        return getVoMessage(accountVo);
    }

    /*
     *  系统生成备注标题
     * @param accountVo
     * @param viewsKey
     * @return
     */
    private AccountVo createRemarkTitle(AccountVo accountVo, String viewsKey) {
        //获取被操作实体用户信息
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setId(accountVo.getResult().getId());
        sysUserVo = this.getService().get(sysUserVo);
        //获取操作用户信息
        /*SysUserVo opSysUserVo  = new SysUserVo();
        opSysUserVo.getSearch().setId(accountVo.getResult().getId());
        opSysUserVo=  this.getService().get(opSysUserVo);*/
        //设置result
        accountVo.setResult(sysUserVo.getResult());

        //获取国际化后的角色显示信息
        String role = LocaleTool.tranView("role", "account." + EnumTool.enumOf(UserTypeEnum.class, accountVo.getResult().getUserType().toString()));
        //获取备注标题
        String title = SessionManager.getUser().getUsername() + LocaleTool.tranView("role", viewsKey, role, accountVo.getResult().getUsername());
        accountVo.setRemarkTitle(title);
        accountVo.setOperator(SessionManager.getUserName());
        return accountVo;
    }

    @RequestMapping("/freezeBalance")
    @Token(generate = true)
    public String freezeBalance(Model model, AccountVo accountVo) {

        /*账号冻结模板*/
        accountVo = ServiceSiteTool.userPlayerService().accountOption(accountVo);
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.BALANCE_FREEZON);
        List<NoticeLocaleTmpl> noticeLocaleTmpls = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);
        accountVo.setNoticeLocaleTmpls(noticeLocaleTmpls);

        /*冻结时间字典*/
        Map<String, SysDict> freezeTime = DictTool.get(DictEnum.COMMON_FREEZE_TIME);
        accountVo.setFreezeTime(freezeTime);
        accountVo.setValidateRule(JsRuleCreator.create(so.wwb.gamebox.mcenter.share.form.AccountOptionForm.class, "result"));
        model.addAttribute("command", accountVo);
        isUserOnline(accountVo, model);
        return getViewBasePath() + "FreezeBalance";
    }

    /**
     * 余额冻结
     *
     * @param accountVo
     * @return
     */
    @RequestMapping("/setFreezeBalance")
    @ResponseBody
    @Token(valid = true)
    public Map setFreezeBalance(AccountVo accountVo) {
        String messageType = "balanceFreeze";
        createRemarkTitle(accountVo, "account.freezeBalance.text");
        accountVo.getResult().setFreezeType(FreezeType.MANUAL.getCode());
        if(StringTool.isBlank(accountVo.getBalanceFreezeContent())){
            String content = LocaleTool.tranMessage("playerFrozen", "player.frozen.balance");
            accountVo.setBalanceFreezeContent(content);
        }
        String content = formatContent(accountVo);
        NoticeVo noticeVo = buildNoticeParam(messageType,accountVo,ManualNoticeEvent.BALANCE_FREEZON);
        content = StringTool.fillTemplate(content, noticeVo.getParamMap());
        accountVo.setBalanceFreezeContent(content);
        UserPlayer userPlayer = ServiceSiteTool.userPlayerService().setAccountBalanceFreeze(accountVo);
        sendMessageByGroupCode(noticeVo);
        return getVoMessage(accountVo);
    }

    private String formatContent(AccountVo accountVo){
        String content = accountVo.getBalanceFreezeContent();
        if(StringTool.isBlank(content)){
            return "";
        }
        Date freezeEndTime = getFreezeEndTime(accountVo.getChooseFreezeTime());
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.setResult(new SysUser());
        sysUserVo.getSearch().setId(accountVo.getResult().getId());
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        String timeZone = getUserTimezone(sysUserVo);
        String time = LocaleDateTool.formatDate(freezeEndTime, CommonContext.getDateFormat().getDAY_SECOND(), timeZone);
        content = content.replace("${unfreezetime}",time);
        return content;
    }
    public Date getFreezeEndTime(String freezeTime) {
        if (StringTool.isBlank(freezeTime))
            return null;
        if (FreezeTime.FORERVE.getCode().equals(freezeTime))
            return DateTool.addYears(new Date(), 3000);
        return DateTool.addHours(new Date(), Integer.valueOf(freezeTime));
    }

    /***
     * 取消余额冻结前查看
     */
    @RequestMapping("/toCancelBalanceFreeze")
    public String toCancelBalanceFreeze(VSysUserPlayerFrozenVo vo, Model model) {
        vo = ServiceSiteTool.vSysUserPlayerFrozenService().get(vo);

        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.setResult(new SysUser());
        sysUserVo.getSearch().setId(vo.getResult().getBalanceFreezeUserId());
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        isUserOnline(sysUserVo, model);
        model.addAttribute("command", vo);
        model.addAttribute("username", sysUserVo.getResult().getUsername());

        return getViewBasePath() + "CancelFreezeBalance";
    }

    /***
     * 取消余额冻结
     *
     * @param accountVo
     * @return
     */
    @RequestMapping("/cancelBalanceFreeze")
    @ResponseBody
    public Map cancelBalanceFreeze(AccountVo accountVo) {
        UserPlayerVo userPlayerVo = new UserPlayerVo();
        userPlayerVo.setResult(new UserPlayer());
        userPlayerVo.getResult().setId(accountVo.getSearch().getId());
        userPlayerVo.getResult().setBalanceFreezeEndTime(new Date());
        userPlayerVo.setProperties(UserPlayer.PROP_BALANCE_FREEZE_END_TIME);
        ServiceSiteTool.userPlayerService().updateOnly(userPlayerVo);
        return getVoMessage(accountVo);
    }

    /**
     * 根据模板code发送信息
     *
     * @param noticeVo
     */
    private NoticeVo sendMessageByGroupCode(NoticeVo noticeVo) {
        if(StringTool.isNotBlank(noticeVo.getTmplGroupCode())){
            try{
                ServiceTool.noticeService().publish(noticeVo);
            }catch (Exception ex){
                LogFactory.getLog(this.getClass()).error(ex,"发布消息不成功");
            }
        }

        return noticeVo;
    }

    private NoticeVo buildNoticeParam(String messageType, AccountVo accountVo,INoticeEventType eventType) {
        //获取接收用户的默认时区
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.setResult(new SysUser());
        sysUserVo.getSearch().setId(accountVo.getResult().getId());
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        //发送站内信模板内容
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setTmplGroupCode(accountVo.getGroupCode());
        noticeVo.setEventType(eventType);
        noticeVo.addUserIds(accountVo.getResult().getId());
        noticeVo = addParams(sysUserVo, accountVo.getResult().getFreezeEndTime(), messageType, noticeVo);
        return noticeVo;
    }

    /**
     * 系统模板添加参数
     *
     * @param sysUserVo
     * @param endTime
     * @param messageType
     * @param noticeVo
     * @return
     */
    private NoticeVo addParams(SysUserVo sysUserVo, Date endTime, String messageType, NoticeVo noticeVo) {
        SiteCustomerService siteCustomerService = Cache.getDefaultCustomerService();
        Pair<String, String> customer;
        if (siteCustomerService != null) {
            String url = siteCustomerService.getParameter();
            if (StringTool.isNotBlank(url) && !url.contains("http")) {
                url = "http://" + url;
            }
            customer = new Pair<>(NoticeParamEnum.CUSTOMER.getCode(), "<a class=\"\" href=\"" + url + "\" target=\"_blank\">" + LocaleTool.tranMessage(_Module.COMMON, "contactCustomerService") + "</a>");
        } else {
            customer = new Pair<>(NoticeParamEnum.CUSTOMER.getCode(), LocaleTool.tranMessage(_Module.COMMON, "contactCustomerService"));
        }
        Pair<String, String> user = new Pair<>(NoticeParamEnum.USER.getCode(), sysUserVo.getResult().getUsername());
        Pair<String, String> siteName = new Pair<>(NoticeParamEnum.SITE_NAME.getCode(), SessionManager.getSiteName(null));
        String timeZone = getUserTimezone(sysUserVo);
        String time = LocaleDateTool.formatDate(endTime, CommonContext.getDateFormat().getDAY_SECOND(), timeZone);
        Pair<String, String> year = new Pair<>(NoticeParamEnum.YEAR.getCode(), LocaleDateTool.formatDate(endTime, CommonContext.getDateFormat().getYEAR(), timeZone));
        Pair<String, String> month = new Pair<>(NoticeParamEnum.MONTH.getCode(), LocaleDateTool.formatDate(endTime, CommonContext.getDateFormat().getMONTH(), timeZone));
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.setTimeZone(TimeZone.getTimeZone(timeZone));
        Pair<String, String> day = new Pair<>(NoticeParamEnum.DAY.getCode(), String.valueOf(cal.get(Calendar.DAY_OF_MONTH)));

        //账号冻结
        if ("accountFreeze".equals(messageType)) {
            noticeVo.addParams(new Pair(NoticeParamEnum.UN_FREEZE_TIME.getCode(), time), customer, user, siteName, year, month, day);
        }
        //账号停用
        if ("accountDisabled".equals(messageType)) {
            noticeVo.addParams(new Pair(NoticeParamEnum.OPERATE_TIME.getCode(), time), customer, user, siteName, year, month, day);
        }
        //余额冻结
        if ("balanceFreeze".equals(messageType)) {
            noticeVo.addParams(new Pair(NoticeParamEnum.UN_FREEZE_TIME.getCode(), time), customer, user, siteName, year, month, day);
        }
        return noticeVo;
    }

    private String getUserTimezone(SysUserVo sysUserVo) {
        String timeZone = sysUserVo.getResult().getDefaultTimezone();
        if(timeZone==null){
            SysSiteVo siteVo = new SysSiteVo();
            siteVo.getSearch().setId(sysUserVo.getResult().getSiteId());
            siteVo = ServiceTool.sysSiteService().get(siteVo);
            if(siteVo.getResult()!=null){
                timeZone = siteVo.getResult().getTimezone();
            }
        }
        return timeZone;
    }
    //endregion your codes 3

}