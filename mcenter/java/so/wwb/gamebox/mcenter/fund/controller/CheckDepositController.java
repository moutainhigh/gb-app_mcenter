package so.wwb.gamebox.mcenter.fund.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.support._Module;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.model.security.privilege.po.SysUser;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.mcenter.fund.form.DepositRemarkForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.common.notice.enums.AutoNoticeEvent;
import so.wwb.gamebox.model.common.notice.enums.ManualNoticeEvent;
import so.wwb.gamebox.model.common.notice.enums.NoticeParamEnum;
import so.wwb.gamebox.model.company.setting.po.SysCurrency;
import so.wwb.gamebox.model.company.site.po.SiteCustomerService;
import so.wwb.gamebox.model.company.sys.po.SysSite;
import so.wwb.gamebox.model.company.sys.vo.SysSiteVo;
import so.wwb.gamebox.model.master.enums.UserTaskEnum;
import so.wwb.gamebox.model.master.fund.enums.CheckStatusEnum;
import so.wwb.gamebox.model.master.fund.enums.RechargeStatusEnum;
import so.wwb.gamebox.model.master.fund.enums.RechargeTypeParentEnum;
import so.wwb.gamebox.model.master.fund.po.PlayerRecharge;
import so.wwb.gamebox.model.master.fund.po.VPlayerDeposit;
import so.wwb.gamebox.model.master.fund.vo.PlayerRechargeVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerDepositListVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerDepositVo;
import so.wwb.gamebox.model.master.setting.vo.NoticeTmplVo;
import so.wwb.gamebox.model.master.tasknotify.vo.UserTaskReminderVo;
import so.wwb.gamebox.web.cache.Cache;

import javax.validation.Valid;
import java.util.*;

/**
 * 存款审核控制器
 *
 * @author fei
 *         2016-07-09 16:46:46
 */
@SuppressWarnings("ALL")
@Controller
@RequestMapping("/fund/deposit/check")
public class CheckDepositController extends BaseDepositController {

    private static final Log LOG = LogFactory.getLog(CheckDepositController.class);

    @Override
    protected void initQuery(VPlayerDepositListVo listVo) {

    }

    @Override
    protected String getViewBasePath() {
        return "/fund/deposit/check";
    }

    /**
     * 存款审核-确认审核通过弹窗
     */
    @RequestMapping("/checkSuccessPop")
    public String checkSuccessPop(VPlayerDepositVo vo, Model model) {
        vo = getService().get(vo);
        VPlayerDeposit deposit = vo.getResult();
        if (deposit != null) {
            if (RechargeTypeParentEnum.ONLINE_DEPOSIT.getCode().equals(deposit.getRechargeTypeParent())) {
                deposit.setRechargeStatus(RechargeStatusEnum.ONLINE_SUCCESS.getCode());
            } else {
                deposit.setRechargeStatus(RechargeStatusEnum.SUCCESS.getCode());
            }
            deposit.setCheckStatus(CheckStatusEnum.SUCCESS.getCode());
            vo.setRealName(getSysUser(deposit.getPlayerId()).getRealName());
        }
        model.addAttribute("command", vo);
        return getViewBasePath() + "/CheckSuccessPop";
    }

    /**
     * 存款审核-确认审核失败弹窗
     * 如果开启消息提醒，要选择发送消息模板
     */
    @RequestMapping("/checkFailurePop")
    public String checkFailurePop(VPlayerDepositVo vo, NoticeVo noticeVo, Model model) {
        vo = getService().get(vo);
        VPlayerDeposit deposit = vo.getResult();
        if (deposit != null) {
            if (RechargeTypeParentEnum.ONLINE_DEPOSIT.getCode().equals(deposit.getRechargeTypeParent())) {
                deposit.setRechargeStatus(RechargeStatusEnum.ONLINE_FAIL.getCode());
            } else {
                deposit.setRechargeStatus(RechargeStatusEnum.FAIL.getCode());
            }
            deposit.setCheckStatus(CheckStatusEnum.FAILURE.getCode());
        }

        // 是否发送消息
        Boolean isPublish = isPublishMessage();
        if (isPublish) {
            //查询失败原因模板
            noticeVo.setEventType(ManualNoticeEvent.DEPOSIT_AUDIT_FAIL);
            vo.setFailTmpls(ServiceTool.noticeService().fetchLocaleTmpls(noticeVo));
        }
        vo.setPublish(isPublish);

        model.addAttribute("command", vo);
        return getViewBasePath() + "/CheckFailurePop";
    }

    /**
     * 查询玩家
     */
    private SysUser getSysUser(Integer playerId) {
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setId(playerId);
        SysUser user = ServiceTool.sysUserService().get(sysUserVo).getResult();
        return user == null ? new SysUser() : user;
    }

    /**
     * 是否发送消息
     */
    private Boolean isPublishMessage() {
        NoticeTmplVo tmplVo = new NoticeTmplVo();
        tmplVo.getSearch().setEventType(ManualNoticeEvent.DEPOSIT_AUDIT_FAIL.getCode());
        Map<String, Object> map = ServiceTool.noticeTmplService().searchNoticeTmplByEventType(tmplVo);
        return !map.isEmpty() && Boolean.valueOf(String.valueOf(map.get("siteMsg")));
    }

    /**
     * 审核结果处理
     */
    private void checkResult(PlayerRechargeVo vo) {
        PlayerRecharge recharge = vo.getResult();
        if (vo.isSuccess()) {
            // 审核成功
            if (RechargeStatusEnum.SUCCESS.getCode().equals(recharge.getRechargeStatus())
                    || RechargeStatusEnum.ONLINE_SUCCESS.getCode().equals(recharge.getRechargeStatus())) {
                NoticeVo noticeVo = NoticeVo.autoNotify(AutoNoticeEvent.DEPOSIT_AUDIT_SUCCESS, recharge.getPlayerId());
                publishMessage(noticeVo, recharge);
                Boolean isAuditActivity = ServiceTool.playerRechargeService().isAuditActivity(vo);
                if (isAuditActivity != null && isAuditActivity) {
                    addTaskReminder();
                }
            } else if ((RechargeStatusEnum.FAIL.getCode().equals(recharge.getRechargeStatus()) || RechargeStatusEnum.ONLINE_FAIL.getCode().equals(recharge.getRechargeStatus())) && StringTool.isNotBlank(vo.getGroupCode())) {
                // 审核失败
                NoticeVo noticeVo = NoticeVo.manualNotify(vo.getGroupCode(), null, recharge.getPlayerId());
                publishMessage(noticeVo, recharge);
            }
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_SUCCESS));
        } else {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "operation.fail"));
        }
    }


    /**
     * 发布消息
     */
    private void publishMessage(NoticeVo noticeVo, PlayerRecharge recharge) {
        try {
            noticeVo = addParams(recharge, noticeVo);
            ServiceTool.noticeService().publish(noticeVo);
        } catch (Exception ex) {
            LOG.error(ex, "存款审核发布消息不成功");
        }
    }

    /**
     * 设置信息模板参数
     */
    private NoticeVo addParams(PlayerRecharge recharge, NoticeVo noticeVo) {
        // 查询用户信息
        SysUser sysUser = getSysUser(recharge.getPlayerId());

        String timeZone = sysUser.getDefaultTimezone();
        if (timeZone == null) {
            SysSite site = getSysSite();
            if (site != null) {
                timeZone = site.getTimezone();
            } else {
                LOG.error("未设置时区，返回参数为空，发送的站内信将无法替换参数");
                return noticeVo;
            }
        }

        // 初始化消息参数
        initNoticeParam(recharge, noticeVo, sysUser, timeZone);
        return noticeVo;
    }

    /**
     * 初始化消息参数
     */
    private void initNoticeParam(PlayerRecharge recharge, NoticeVo noticeVo, SysUser sysUser, String timeZone) {
        SysCurrency sysCurrency = Cache.getSysCurrency().get(sysUser.getDefaultCurrency());
        Date createTime = recharge.getCreateTime();
        Pair<String, String> orderLaunchTime = new Pair(NoticeParamEnum.ORDER_LAUNCH_TIME.getCode(),
                LocaleDateTool.formatDate(createTime, CommonContext.getDateFormat().getDAY_SECOND(), timeZone));
        Pair<String, String> orderAmount = new Pair<>(NoticeParamEnum.ORDER_AMOUNT.getCode(), sysCurrency.getCurrencySign() + CurrencyTool.formatCurrency(recharge.getRechargeAmount()));
        Pair<String, String> orderNum = new Pair<>(NoticeParamEnum.ORDER_NUM.getCode(), recharge.getTransactionNo());
        Pair<String, String> siteName = new Pair(NoticeParamEnum.SITE_NAME.getCode(), SessionManager.getSiteName(null));
        Pair<String, String> year = new Pair(NoticeParamEnum.YEAR.getCode(),
                LocaleDateTool.formatDate(createTime, CommonContext.getDateFormat().getYEAR(), timeZone));
        Pair<String, String> month = new Pair(NoticeParamEnum.MONTH.getCode(),
                LocaleDateTool.formatDate(createTime, CommonContext.getDateFormat().getMONTH(), timeZone));
        Pair<String, String> day = new Pair<>(NoticeParamEnum.DAY.getCode(), getDay(timeZone));
        Pair<String, String> user = new Pair(NoticeParamEnum.USER.getCode(),
                LocaleDateTool.formatDate(createTime, CommonContext.getDateFormat().getDAY(), sysUser.getUsername()));
        Pair<String, String> customer = getCustomer();
        noticeVo.addParams(orderLaunchTime, orderAmount, orderNum, siteName, year, month, day, user, customer);
    }

    /**
     * 获取当前日期（几号）
     */
    private String getDay(String timeZone) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.setTimeZone(TimeZone.getTimeZone(timeZone));
        return String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
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
     * 获取站点信息
     */
    private SysSite getSysSite() {
        SysSiteVo siteVo = new SysSiteVo();
        siteVo.getSearch().setId(SessionManager.getSiteId());
        siteVo = ServiceTool.sysSiteService().get(siteVo);
        return siteVo.getResult();
    }

    /**
     * 保存编辑备注
     */
    @RequestMapping("/updateRemark")
    @ResponseBody
    public Map updateRemark(PlayerRechargeVo playerRechargeVo, @FormModel @Valid DepositRemarkForm form, BindingResult result) {
        if (result.hasErrors()) {
            playerRechargeVo.setSuccess(false);
            return getVoMessage(playerRechargeVo);
        }
        playerRechargeVo.getResult().setCheckUserId(SessionManager.getUserId());
        playerRechargeVo.getResult().setCheckUsername(SessionManager.getAuditUserName());
        playerRechargeVo.setProperties(PlayerRecharge.PROP_CHECK_REMARK);
        playerRechargeVo = ServiceTool.playerRechargeService().updateRechargeRemark(playerRechargeVo);
        return getVoMessage(playerRechargeVo);
    }

    //生成任务提醒
    private void addTaskReminder() {
        UserTaskReminderVo userTaskReminderVo = new UserTaskReminderVo();
        userTaskReminderVo.setTaskEnum(UserTaskEnum.PREFERENTIAL);
        ServiceTool.userTaskReminderService().addTaskReminder(userTaskReminderVo);
    }

}