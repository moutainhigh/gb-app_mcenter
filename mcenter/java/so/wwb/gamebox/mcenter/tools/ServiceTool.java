package so.wwb.gamebox.mcenter.tools;

import org.soul.commons.dubbo.DubboTool;
import org.soul.iservice.msg.notice.INoticeEmailInterfaceService;
import org.soul.iservice.msg.notice.INoticeService;
import org.soul.iservice.pay.IOnlinePayService;
import org.soul.iservice.security.privilege.ISysResourceService;
import org.soul.iservice.security.privilege.ISysRoleService;
import org.soul.iservice.security.privilege.ISysUserService;
import org.soul.iservice.smsinterface.ISmsInterfaceService;
import org.soul.iservice.sys.ISysAuditLogService;
import org.soul.iservice.sys.ISysParamService;
import org.soul.iservice.taskschedule.ITaskScheduleService;
import so.wwb.gamebox.iservice.boss.taskschedule.ITaskRunRecordService;
import so.wwb.gamebox.iservice.common.ICustomSysAuditLogService;
import so.wwb.gamebox.iservice.common.IVSubAccountService;
import so.wwb.gamebox.iservice.company.IBankExtendService;
import so.wwb.gamebox.iservice.company.IBankService;
import so.wwb.gamebox.iservice.company.filter.ISysMasterListOperatorService;
import so.wwb.gamebox.iservice.company.lottery.ISiteLotteryOddService;
import so.wwb.gamebox.iservice.company.setting.ICurrencyExchangeRateService;
import so.wwb.gamebox.iservice.company.site.*;
import so.wwb.gamebox.iservice.company.sys.ISysDomainService;
import so.wwb.gamebox.iservice.company.sys.ISysSiteService;
import so.wwb.gamebox.iservice.company.sys.IUserExtendService;
import so.wwb.gamebox.iservice.company.sys.IVSysSiteUserService;
import so.wwb.gamebox.iservice.master.content.ICttCarouselService;
import so.wwb.gamebox.iservice.master.content.ICttLogoService;
import so.wwb.gamebox.iservice.master.content.IVCttCarouselService;
import so.wwb.gamebox.iservice.master.fund.*;
import so.wwb.gamebox.iservice.master.operation.*;
import so.wwb.gamebox.iservice.master.player.*;
import so.wwb.gamebox.iservice.master.player.IRemarkService;
import so.wwb.gamebox.iservice.master.report.IAuditLogService;
import so.wwb.gamebox.iservice.master.report.IVRebateReportService;
import so.wwb.gamebox.iservice.master.setting.*;
import so.wwb.gamebox.iservice.master.tasknotify.IUserTaskReminderService;
import so.wwb.gamebox.iservice.site.report.IVPlayerGameTipOrderService;

import static org.soul.commons.dubbo.DubboTool.getService;

/**
 * 远程服务实例获取工具类
 *
 * @author younger
 * @time 2017-5-31 20:01:37
 */
public class ServiceTool {

    //region your codes 1

    /**
     * 返回玩家远程服务实例
     *
     * @return 玩家远程服务实例
     */
    public static IUserPlayerService userPlayerService() {
        return getService(IUserPlayerService.class);
    }

    public static IVUserPlayerService vUserPlayerService() {
        return getService(IVUserPlayerService.class);
    }

    public static IVSysUserPlayerFrozenService vSysUserPlayerFrozenService() {
        return getService(IVSysUserPlayerFrozenService.class);
    }

    public static ISysUserService sysUserService() {
        return getService(ISysUserService.class);
    }

    public static IVPlayerTagAllService vPlayerTagAllService() {
        return getService(IVPlayerTagAllService.class);
    }

    public static IPlayerAddressService playerAddressService() {
        return getService(IPlayerAddressService.class);
    }


    public static IVPlayerAdvisoryService vPlayerAdvisoryService() {
        return getService(IVPlayerAdvisoryService.class);
    }

    public static IPlayerAdvisoryReplyService playerAdvisoryReplyService() {
        return getService(IPlayerAdvisoryReplyService.class);
    }

    public static IVPlayerAdvisoryReplyService vPlayerAdvisoryReplyService() {
        return getService(IVPlayerAdvisoryReplyService.class);
    }

    public static IPlayerAdvisoryService playerAdvisoryService() {
        return getService(IPlayerAdvisoryService.class);
    }

    public static IUserExtendService userExtendService() {
        return getService(IUserExtendService.class);
    }

    public static IVSysUserPlayerFrozenService sysUserPlayerFrozenService() {
        return getService(IVSysUserPlayerFrozenService.class);
    }

    public static ITaskScheduleService taskScheduleService(String dubboVersion) {
        return getService(ITaskScheduleService.class, dubboVersion);
    }

    public static IUserTaskReminderService userTaskReminderService() {
        return getService(IUserTaskReminderService.class);
    }

    public static ISysResourceService sysResourceService() {
        return getService(ISysResourceService.class);
    }

    public static ISysAuditLogService sysAuditLogService() {
        return getService(ISysAuditLogService.class);
    }

    public static IAuditLogService auditLogService() {
        return getService(IAuditLogService.class);
    }

    public static IVPlayerWithdrawService vPlayerWithdrawService() {
        return getService(IVPlayerWithdrawService.class);
    }

    public static IVPlayerTagService vPlayerTagService() {
        return getService(IVPlayerTagService.class);
    }

    public static IPlayerTagService playerTagService() {
        return getService(IPlayerTagService.class);
    }

    public static IVUserShortcutMenuService vUserShortcutMenuService() {
        return getService(IVUserShortcutMenuService.class);
    }

    public static ISysMasterListOperatorService sysMasterListOperatorService() {
        return getService(ISysMasterListOperatorService.class);
    }

    /**
     * 返回系统公告视图远程服务实例
     *
     * @return 系统公告视图远程服务实例
     */
    public static so.wwb.gamebox.iservice.company.operator.IVSystemAnnouncementService vSystemAnnouncementService() {
        return getService(so.wwb.gamebox.iservice.company.operator.IVSystemAnnouncementService.class);
    }

    /**
     * 返回系统公告远程服务实例
     *
     * @return 系统公告远程服务实例
     */
    public static so.wwb.gamebox.iservice.company.operator.ISystemAnnouncementService systemAnnouncementService() {
        return getService(so.wwb.gamebox.iservice.company.operator.ISystemAnnouncementService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static so.wwb.gamebox.iservice.company.operator.ISystemAnnouncementI18nService systemAnnouncementI18nService() {
        return getService(so.wwb.gamebox.iservice.company.operator.ISystemAnnouncementI18nService.class);
    }


    /**
     * 返回任务运行结果远程服务实例
     *
     * @return 任务运行结果远程服务实例
     */
    public static so.wwb.gamebox.iservice.boss.taskschedule.ITaskRunRecordService taskRunRecordService(String dubboVersion) {
        return getService(ITaskRunRecordService.class, dubboVersion);
    }

    /**
     * 返回player_advisory_read表远程服务实例
     *
     * @return player_advisory_read表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IPlayerAdvisoryReadService playerAdvisoryReadService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IPlayerAdvisoryReadService.class);
    }

    /**
     * 返回玩家层级表远程服务实例
     *
     * @return 玩家层级表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IPlayerRankService playerRankService() {
        return getService(so.wwb.gamebox.iservice.master.player.IPlayerRankService.class);
    }


    public static ISysRoleService sysRoleService() {
        return DubboTool.getService(ISysRoleService.class);
    }

    public static so.wwb.gamebox.iservice.master.setting.ISysRoleService mSysRoleService() {
        return DubboTool.getService(so.wwb.gamebox.iservice.master.setting.ISysRoleService.class);
    }

    /**
     * 返回收款账户表远程服务实例
     *
     * @return 收款账户表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.IPayAccountService payAccountService() {
        return getService(so.wwb.gamebox.iservice.master.content.IPayAccountService.class);
    }

    /**
     * 返回玩家层级对应支付限制表远程服务实例
     *
     * @return 玩家层级对应支付限制表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IPayRankService payRankService() {
        return getService(so.wwb.gamebox.iservice.master.player.IPayRankService.class);
    }

    /**
     * v_pcenter_withdraw 取款
     *
     * @return
     */
    public static so.wwb.gamebox.iservice.master.fund.IVPcenterWithdrawService vPcenterWithdrawService() {
        return getService(so.wwb.gamebox.iservice.master.fund.IVPcenterWithdrawService.class);
    }

    /**
     * 玩家提现表
     *
     * @return
     */
    public static IVPlayerWithdrawService getVPlayerWithdrawService() {
        return getService(IVPlayerWithdrawService.class);
    }

    /**
     * 备注表
     *
     * @return
     */
    public static IRemarkService getRemarkService() {
        return getService(IRemarkService.class);
    }

    /**
     * 提现交易表
     *
     * @return
     */
    public static IPlayerTransactionService getPlayerTransactionService() {
        return getService(IPlayerTransactionService.class);
    }


    /**
     * 汇率表
     */
    public static ICurrencyExchangeRateService getCurrencyExchangeRateService() {
        return getService(ICurrencyExchangeRateService.class);
    }

    /**
     * 返回玩家层级对应支付限制视图远程服务实例
     *
     * @return 玩家层级对应支付限制视图远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IVPayRankService vPayRankService() {
        return getService(so.wwb.gamebox.iservice.master.player.IVPayRankService.class);
    }

    /**
     * 返回玩家层级统计远程服务实例
     *
     * @return 玩家层级统计远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IVPlayerRankStatisticsService vPlayerRankStatisticsService() {
        return getService(so.wwb.gamebox.iservice.master.player.IVPlayerRankStatisticsService.class);
    }

    /**
     * 玩家充值记录表
     *
     * @return
     */
    public static so.wwb.gamebox.iservice.master.fund.IPlayerRechargeService playerRechargeService() {
        return getService(so.wwb.gamebox.iservice.master.fund.IPlayerRechargeService.class);
    }

    /**
     * 玩家充值记录表
     *
     * @return
     */
    public static so.wwb.gamebox.iservice.master.fund.IVPlayerRechargeService vPlayerRechargeService() {
        return getService(so.wwb.gamebox.iservice.master.fund.IVPlayerRechargeService.class);
    }

    /**
     * 玩家提现记录表
     *
     * @return
     */
    public static so.wwb.gamebox.iservice.master.fund.IPlayerWithdrawService playerWithdrawService() {
        return getService(so.wwb.gamebox.iservice.master.fund.IPlayerWithdrawService.class);
    }

    /**
     * 返回收款账户对应币种表远程服务实例
     *
     * @return 收款账户对应币种表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.IPayAccountCurrencyService payAccountCurrencyService() {
        return getService(so.wwb.gamebox.iservice.master.content.IPayAccountCurrencyService.class);
    }

    /**
     * 返回币种表--lorne远程服务实例
     *
     * @return 币种表--lorne远程服务实例
     */
    public static ISiteCurrencyService sysSiteCurrencyService() {
        return getService(ISiteCurrencyService.class);
    }

    /**
     * 返回内容管理-轮播广告表远程服务实例
     *
     * @return 内容管理-轮播广告表远程服务实例
     */
    public static ICttCarouselService cttCarouselService() {
        return getService(ICttCarouselService.class);
    }


    /**
     * 返回内容管理-轮播管理远程服务实例
     *
     * @return 内容管理-轮播管理远程服务实例
     */
    public static IVCttCarouselService vCttCarouselService() {
        return getService(IVCttCarouselService.class);
    }

    /**
     * 返回收款账户远程服务实例
     *
     * @return 收款账户远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.IVPayAccountService vPayAccountService() {
        return getService(so.wwb.gamebox.iservice.master.content.IVPayAccountService.class);
    }

    /**
     * 返回内容管理-浮动图片表远程服务实例
     *
     * @return 内容管理-浮动图片表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.ICttFloatPicService cttFloatPicService() {
        return getService(so.wwb.gamebox.iservice.master.content.ICttFloatPicService.class);
    }


    /**
     * 返回收款账户远程服务实例
     *
     * @return 收款账户远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.IPayAccountService PayAccountService() {
        return getService(so.wwb.gamebox.iservice.master.content.IPayAccountService.class);
    }

    /**
     * 玩家api关系远程服务实例
     *
     * @return
     */
    public static IPlayerApiService playerApiService() {
        return getService(IPlayerApiService.class);
    }

    /**
     * 返回限制访问站点的地区表远程服务实例
     *
     * @return 限制访问站点的地区表远程服务实例
     */
    public static ISiteConfineAreaService siteConfineAreaService() {
        return getService(ISiteConfineAreaService.class);
    }

    /**
     * 返回限制/允许访问站点/管理中心的IP表远程服务实例
     *
     * @return 限制/允许访问站点/管理中心的IP表远程服务实例
     */
    public static ISiteConfineIpService siteConfineIpService() {
        return getService(ISiteConfineIpService.class);
    }

    /**
     * 返回系统联系人表远程服务实例
     *
     * @return 系统联系人表远程服务实例
     */
    public static ISiteContactsService siteContactsService() {
        return getService(ISiteContactsService.class);
    }


    /**
     * 返回系统联系人职位表远程服务实例
     *
     * @return 系统联系人职位表远程服务实例
     */
    public static ISiteContactsPositionService siteContactsPositionService() {
        return getService(ISiteContactsPositionService.class);
    }

    /**
     * 返回站点语言表远程服务实例
     *
     * @return 站点语言表远程服务实例
     */
    public static ISiteLanguageService siteLanguageService() {
        return getService(ISiteLanguageService.class);
    }

    /**
     * 返回经营地区表远程服务实例
     *
     * @return 经营地区表远程服务实例
     */
    public static ISiteOperateAreaService siteOperateAreaService() {
        return getService(ISiteOperateAreaService.class);
    }

    /**
     * 返回系统联系人视图-lorne远程服务实例
     *
     * @return 系统联系人视图-lorne远程服务实例
     */
    public static IVSiteContactsService vSiteContactsService() {
        return getService(IVSiteContactsService.class);
    }

    /**
     * 返回客服设置表远程服务实例
     *
     * @return 客服设置表远程服务实例
     */
    public static ISiteCustomerServiceService siteCustomerServiceService() {
        return getService(ISiteCustomerServiceService.class);
    }

    /**
     * 返回偏好设置远程服务实例
     *
     * @return 偏好设置远程服务实例
     */
    public static IPreferenceService preferenceService() {
        return getService(IPreferenceService.class);
    }


    /**
     * 返回内容管理-域名与层级关联表远程服务实例
     *
     * @return 内容管理-域名与层级关联表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.ICttDomainRankService cttDomainRankService() {
        return getService(so.wwb.gamebox.iservice.master.content.ICttDomainRankService.class);
    }

    /**
     * 返回浮动图视图远程服务实例
     *
     * @return 浮动图视图远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.IVFloatPicService vFloatPicService() {
        return getService(so.wwb.gamebox.iservice.master.content.IVFloatPicService.class);
    }

    /**
     * 返回站长站点表服务实例
     *
     * @return 返回站长站点表远程服务实例
     */
    public static ISysSiteService sysSiteService() {
        return getService(ISysSiteService.class);
    }

    /**
     * 返回站长站点表服务实例
     *
     * @return 返回站长站点表远程服务实例
     */
    public static IVSysSiteUserService vSysSiteUserService() {
        return getService(IVSysSiteUserService.class);
    }

    /**
     * 返回玩家游戏下单表远程服务实例
     *
     * @return 玩家游戏下单表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IPlayerGameOrderService playerGameOrderService() {
        return getService(so.wwb.gamebox.iservice.master.player.IPlayerGameOrderService.class);
    }

    public static ISysParamService getSysParamService() {
        return getService(ISysParamService.class);
    }

    public static ICttLogoService getCttLogService() {
        return getService(ICttLogoService.class);
    }

    /**
     * 返回站点国际化远程服务实例
     *
     * @return 站点国际化远程服务实例
     */
    public static ISiteI18nService siteI18nService() {
        return getService(ISiteI18nService.class);
    }

    /**
     * 返回内容管理-公告表远程服务实例
     *
     * @return 内容管理-公告表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.ICttAnnouncementService cttAnnouncementService() {
        return getService(so.wwb.gamebox.iservice.master.content.ICttAnnouncementService.class);
    }

    /**
     * 返回通知模板远程服务实例
     *
     * @return 通知模板远程服务实例
     */
    public static INoticeTmplService noticeTmplService() {
        return getService(INoticeTmplService.class);
    }

    /**
     * 返回站长域名表-修改完会替换 sys_domain远程服务实例
     *
     * @return 站长域名表-修改完会替换 sys_domain远程服务实例
     */
    public static ISysDomainService sysDomainService() {
        return getService(ISysDomainService.class);
    }

    /**
     * 返回活动信息表远程服务实例
     *
     * @return 活动信息表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IActivityMessageService activityMessageService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IActivityMessageService.class);
    }

    /**
     * 活动申请玩家表
     *
     * @return
     */
    public static IVActivityPlayerApplyService vActivityPlayerApplyService() {
        return getService(IVActivityPlayerApplyService.class);
    }

    /**
     * 返回活动申请玩家表远程服务实例
     *
     * @return 活动申请玩家表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IActivityPlayerApplyService activityPlayerApplyService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IActivityPlayerApplyService.class);
    }

    public static so.wwb.gamebox.iservice.comet.IMessageService messageService() {
        return getService(so.wwb.gamebox.iservice.comet.IMessageService.class);
    }

    /**
     * 返回邮件接口视图远程服务实例
     *
     * @return 邮件接口视图远程服务实例
     */
    public static IVNoticeEmailInterfaceService vNoticeEmailInterfaceService() {
        return getService(IVNoticeEmailInterfaceService.class);
    }


    /**
     * 返回邮件接口视图远程服务实例
     *
     * @return 邮件接口视图远程服务实例
     */
    public static INoticeEmailInterfaceService noticeEmailInterfaceService() {
        return getService(INoticeEmailInterfaceService.class);
    }


    /**
     * 返回邮件接口视图远程服务实例
     *
     * @return 邮件接口视图远程服务实例
     */
    public static IVNoticeEmailRankService vNoticeEmailRankService() {
        return getService(IVNoticeEmailRankService.class);
    }

    /**
     * 返回运营概况表远程服务实例
     *
     * @return 运营概况表远程服务实例
     */
    public static so.wwb.gamebox.iservice.report.IOperationProfileService operationProfileService() {
        return getService(so.wwb.gamebox.iservice.report.IOperationProfileService.class);
    }

    /**
     * 返回游戏概况表远程服务实例
     *
     * @return 游戏概况表远程服务实例
     */
    public static so.wwb.gamebox.iservice.report.IGameSurveyService gameSurveyService() {
        return getService(so.wwb.gamebox.iservice.report.IGameSurveyService.class);
    }

    /**
     * 返回玩家银行卡远程服务实例
     *
     * @return
     */
    public static IUserBankcardService userBankcardService() {
        return getService(IUserBankcardService.class);
    }

    /**
     * 返回银行表远程服务实例
     *
     * @return 银行表远程服务实例
     */
    public static IBankService bankService() {
        return getService(IBankService.class);
    }

    /**
     * 返回银行扩展表远程服务实例
     *
     * @return
     */
    public static IBankExtendService bankExtendService() {
        return getService(IBankExtendService.class);
    }

    /**
     * 返回联系方式表远程服务实例
     *
     * @return 联系方式表远程服务实例
     */
    public static org.soul.iservice.msg.notice.INoticeContactWayService noticeContactWayService() {
        return getService(org.soul.iservice.msg.notice.INoticeContactWayService.class);
    }

    /**
     * 返回账号保护表远程服务实例
     *
     * @return 账号保护表远程服务实例
     */
    public static org.soul.iservice.security.privilege.ISysUserProtectionService sysUserProtectionService() {
        return getService(org.soul.iservice.security.privilege.ISysUserProtectionService.class);
    }


    /**
     * 返回活动国际化信息表远程服务实例
     *
     * @return 活动国际化信息表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IActivityMessageI18nService activityMessageI18nService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IActivityMessageI18nService.class);
    }

    /**
     * 返回优惠规则表远程服务实例
     *
     * @return 优惠规则表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IActivityPreferentialRuleService activityPreferentialRuleService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IActivityPreferentialRuleService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IVPlayerOnlineService vPlayerOnlineService() {
        return getService(so.wwb.gamebox.iservice.master.player.IVPlayerOnlineService.class);
    }

    /**
     * 返回站务账单表远程服务实例
     *
     * @return 站务账单表远程服务实例
     */
    public static so.wwb.gamebox.iservice.report.operation.IStationBillService stationBillService() {
        return getService(so.wwb.gamebox.iservice.report.operation.IStationBillService.class);
    }

    /**
     * 返回站务其他账单远程服务实例
     *
     * @return 站务其他账单远程服务实例
     */
    public static so.wwb.gamebox.iservice.report.operation.IStationBillOtherService stationBillOtherService() {
        return getService(so.wwb.gamebox.iservice.report.operation.IStationBillOtherService.class);
    }

    /**
     * 返回游戏盈亏账单远程服务实例
     *
     * @return 游戏盈亏账单远程服务实例
     */
    public static so.wwb.gamebox.iservice.report.operation.IStationProfitLossService stationProfitLossService() {
        return getService(so.wwb.gamebox.iservice.report.operation.IStationProfitLossService.class);
    }

    /**
     * 返回总代API占成表远程服务实例
     *
     * @return 总代API占成表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IUserAgentApiService userAgentApiService() {
        return getService(so.wwb.gamebox.iservice.master.player.IUserAgentApiService.class);
    }


    /**
     * 返回代理/总代 返水关联表远程服务实例
     *
     * @return 代理/总代 返水关联表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IUserAgentRakebackService userAgentRakebackService() {
        return getService(so.wwb.gamebox.iservice.master.player.IUserAgentRakebackService.class);
    }

    /**
     * 返回代理/总代 返佣关联表远程服务实例
     *
     * @return 代理/总代 返佣关联表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IUserAgentRebateService userAgentRebateService() {
        return getService(so.wwb.gamebox.iservice.master.player.IUserAgentRebateService.class);
    }

    /**
     * 返回代理子账号远程服务实例
     *
     * @return 代理子账号远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IUserAgentService userAgentService() {
        return getService(so.wwb.gamebox.iservice.master.player.IUserAgentService.class);
    }

    /**
     * 代理子账号
     *
     * @return
     */
    public static IUserAgentService getUserAgentService() {
        return getService(IUserAgentService.class);
    }

    /**
     * 返回返水设置表远程服务实例
     *
     * @return 返水设置表远程服务实例
     */
    public static IRakebackSetService rakebackSetService() {
        return getService(IRakebackSetService.class);
    }

    /**
     * 返回返佣设置表远程服务实例
     *
     * @return 返佣设置表远程服务实例
     */
    public static IRebateSetService rebateSetService() {
        return getService(IRebateSetService.class);
    }


    /**
     * 返回返水明细表远程服务实例
     *
     * @return 返水明细表远程服务实例
     */
    public static IRakebackApiService rakebackApiService() {
        return getService(IRakebackApiService.class);
    }


    /**
     * 返回玩家返水表远程服务实例
     *
     * @return 玩家返水表远程服务实例
     */
    public static IRakebackPlayerService rakebackPlayerService() {
        return getService(IRakebackPlayerService.class);
    }

    /**
     * 返回返水结算表远程服务实例
     *
     * @return 返水结算表远程服务实例
     */
    public static IRakebackBillService rakebackBillService() {
        return getService(IRakebackBillService.class);
    }

    /**
     * 代理取款订单表
     *
     * @return
     */
    public static IAgentWithdrawOrderService getAgentWithdrawOrderService() {
        return getService(IAgentWithdrawOrderService.class);
    }

    /**
     * 代理取款订单表
     *
     * @return
     */
    public static IVAgentWithdrawOrderService getVAgentWithdrawOrderService() {
        return getService(IVAgentWithdrawOrderService.class);
    }

    /**
     * 站点游戏表远程服务实例
     *
     * @return 站点游戏表远程服务实例
     */
    public static ISiteGameService siteGameService() {
        return getService(ISiteGameService.class);
    }

    public static ISiteGameI18nService siteGameI18nService() {
        return getService(ISiteGameI18nService.class);
    }

    /**
     * 返回返佣结算表远程服务实例
     *
     * @return 返佣结算表远程服务实例
     */
    public static IRebateBillService settlementRebateService() {
        return getService(IRebateBillService.class);
    }

    /**
     * 返回玩家返佣表远程服务实例
     *
     * @return 玩家返佣表远程服务实例
     */
    public static IRebateAgentService settlementRebateAgentService() {
        return getService(IRebateAgentService.class);
    }

    /**
     * 返回代理流水账单表远程服务实例
     *
     * @return 代理流水账单表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IAgentWaterBillService agentWaterBillService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IAgentWaterBillService.class);
    }

    /**
     * 返回代理（总代）管理远程服务实例
     *
     * @return 代理（总代）管理远程服务实例
     */
    public static IVUserAgentManageService vUserAgentManageService() {
        return getService(IVUserAgentManageService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static IVUserTopAgentManageService vUserTopAgentManageService() {
        return getService(IVUserTopAgentManageService.class);
    }

    /**
     * 返回代理/总代-返水/返佣/限额方案汇总视图远程服务实例
     *
     * @return 代理/总代-返水/返佣/限额方案汇总视图远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IVProgramService vProgramService() {
        return getService(so.wwb.gamebox.iservice.master.player.IVProgramService.class);
    }

    public static INoticeService noticeService() {
        return getService(INoticeService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IVUserAgentService vUserAgentService() {
        return getService(so.wwb.gamebox.iservice.master.player.IVUserAgentService.class);
    }

    /**
     * 返回返水设置梯度表远程服务实例
     *
     * @return 返水设置梯度表远程服务实例
     */
    public static IRakebackGradsService rakebackGradsService() {
        return getService(IRakebackGradsService.class);
    }

    /**
     * 返回返水设置梯度API比例表远程服务实例
     *
     * @return 返水设置梯度API比例表远程服务实例
     */
    public static IRakebackGradsApiService rakebackGradsApiService() {
        return getService(IRakebackGradsApiService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static IVRakebackSetService vRakebackSetService() {
        return getService(IVRakebackSetService.class);
    }

    /**
     * 返回代理返佣交易订单表远程服务实例
     *
     * @return 代理返佣交易订单表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IAgentRebateOrderService agentRebateOrderService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IAgentRebateOrderService.class);
    }

    public static IUserShortcutMenuService userShortcutMenuService() {
        return getService(IUserShortcutMenuService.class);
    }

    /**
     * 返回玩家游戏下单视图远程服务实例
     *
     * @return 玩家游戏下单视图远程服务实例
     */
    public static so.wwb.gamebox.iservice.site.report.IVPlayerGameOrderService vPlayerGameOrderService() {
        return getService(so.wwb.gamebox.iservice.site.report.IVPlayerGameOrderService.class);
    }


    public static so.wwb.gamebox.iservice.company.setting.IApiService apiService() {
        return getService(so.wwb.gamebox.iservice.company.setting.IApiService.class);
    }

    /**
     * 返回游戏表远程服务实例
     *
     * @return 游戏表远程服务实例
     */
    public static so.wwb.gamebox.iservice.company.setting.IGameService gameService() {
        return getService(so.wwb.gamebox.iservice.company.setting.IGameService.class);
    }

    /**
     * 返回活动类型表远程服务实例
     *
     * @return 活动类型表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IActivityTypeService activityTypeService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IActivityTypeService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IVActivityMessageService vActivityMessageService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IVActivityMessageService.class);
    }

    /**
     * 返回玩家优惠信息表远程服务实例
     *
     * @return 玩家优惠信息表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IActivityPlayerPreferentialService activityPlayerPreferentialService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IActivityPlayerPreferentialService.class);
    }

    /**
     * 返回活动优惠方式关系表远程服务实例
     *
     * @return 活动优惠方式关系表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IActivityWayRelationService activityWayRelationService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IActivityWayRelationService.class);
    }

    /**
     * 返回活动规则表远程服务实例
     *
     * @return 活动规则表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IActivityRuleService activityRuleService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IActivityRuleService.class);
    }

    /**
     * 返回活动优惠关系表远程服务实例
     *
     * @return 活动优惠关系表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IActivityPreferentialRelationService activityPreferentialRelationService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IActivityPreferentialRelationService.class);
    }


    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static IVSiteApiService vSiteApiService() {
        return getService(IVSiteApiService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static IVSiteApiTypeService vSiteApiTypeService() {
        return getService(IVSiteApiTypeService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.agent.ICttMaterialPicService cttMaterialPicService() {
        return getService(so.wwb.gamebox.iservice.master.agent.ICttMaterialPicService.class);
    }

    /**
     * 返回查看所有优惠订单远程服务实例
     *
     * @return 查看所有优惠订单远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.fund.IVFavorableOrderService vFavorableOrderService() {
        return getService(so.wwb.gamebox.iservice.master.fund.IVFavorableOrderService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static IVSiteApiTypeRelationService vSiteApiTypeRelationService() {
        return getService(IVSiteApiTypeRelationService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static IVSiteGameService vSiteGameService() {
        return getService(IVSiteGameService.class);
    }

    /**
     * 返回site_api_type_relation远程服务实例
     *
     * @return site_api_type_relation远程服务实例
     */
    public static ISiteApiTypeRelationService siteApiTypeRelationService() {
        return getService(ISiteApiTypeRelationService.class);
    }

    /**
     * 返回角色-资源关联表服务接口      *      * @return 角色-资源关联表服务接口
     */
    public static org.soul.iservice.security.privilege.ISysUserRoleService sysUserRoleService() {
        return getService(org.soul.iservice.security.privilege.ISysUserRoleService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.ICttDocumentService cttDocumentService() {
        return getService(so.wwb.gamebox.iservice.master.content.ICttDocumentService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.ICttDocumentI18nService cttDocumentI18nService() {
        return getService(so.wwb.gamebox.iservice.master.content.ICttDocumentI18nService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.IVCttDocumentService vCttDocumentService() {
        return getService(so.wwb.gamebox.iservice.master.content.IVCttDocumentService.class);
    }

    /**
     * 返回玩家交易视图-jeff远程服务实例
     *
     * @return 玩家交易视图-jeff远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.report.IVPlayerTransactionService vPlayerTransactionService() {
        return getService(so.wwb.gamebox.iservice.master.report.IVPlayerTransactionService.class);
    }

    /**
     * 接口参数服务接口
     *
     * @return
     */
    public static IOnlinePayService onlinePayService() {
        return getService(IOnlinePayService.class);
    }

    /**
     * 返回站点返佣汇总远程服务实例
     *
     * @return 站点返佣汇总远程服务实例
     */
    public static so.wwb.gamebox.iservice.report.rebate.ISiteRebateService siteRebateService() {
        return getService(so.wwb.gamebox.iservice.report.rebate.ISiteRebateService.class);
    }

    /**
     * 返回站点API返佣汇总远程服务实例
     *
     * @return 站点API返佣汇总远程服务实例
     */
    public static so.wwb.gamebox.iservice.report.rebate.ISiteRebateApiService siteRebateApiService() {
        return getService(so.wwb.gamebox.iservice.report.rebate.ISiteRebateApiService.class);
    }

    /**
     * 返回站点游戏分类返佣汇总远程服务实例
     *
     * @return 站点游戏分类返佣汇总远程服务实例
     */
    public static so.wwb.gamebox.iservice.report.rebate.ISiteRebateGametypeService siteRebateGametypeService() {
        return getService(so.wwb.gamebox.iservice.report.rebate.ISiteRebateGametypeService.class);
    }

    /**
     * 返回返佣统计详细视图远程服务实例
     *
     * @return 返佣统计详细视图远程服务实例
     */
    public static IVRebateReportService vRebateReportService() {
        return getService(IVRebateReportService.class);
    }

    /**
     * 银行开通的货币
     *
     * @return 银行开通的货币服务实例
     */
    public static so.wwb.gamebox.iservice.company.IBankSupportCurrencyService bankSupportCurrencyService() {
        return getService(so.wwb.gamebox.iservice.company.IBankSupportCurrencyService.class);
    }

    /**
     * 返回api游戏类别视图远程服务实例
     *
     * @return api游戏类别视图远程服务实例
     */
    public static so.wwb.gamebox.iservice.company.site.IVGameTypeService vGameTypeService() {
        return getService(so.wwb.gamebox.iservice.company.site.IVGameTypeService.class);
    }

    /**
     * 返回LOGO提交审核人信息远程服务实例
     *
     * @return LOGO提交审核人信息远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.IVCttLogoUserService vCttLogoUserService() {
        return getService(so.wwb.gamebox.iservice.master.content.IVCttLogoUserService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.IVCttDocumentUserService vCttDocumentUserService() {
        return getService(so.wwb.gamebox.iservice.master.content.IVCttDocumentUserService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.IVActivityMessageUserService vActivityMessageUserService() {
        return getService(so.wwb.gamebox.iservice.master.content.IVActivityMessageUserService.class);
    }

    /**
     * 返站点API 类型服务实例
     *
     * @return
     */
    public static so.wwb.gamebox.iservice.company.site.ISiteApiTypeService siteApiTypeService() {
        return getService(so.wwb.gamebox.iservice.company.site.ISiteApiTypeService.class);
    }

    /**
     * 返回站点经营报表 - Fly远程服务实例
     *
     * @return 站点经营报表 - Fly远程服务实例
     */
    public static so.wwb.gamebox.iservice.report.operate.ISiteOperateService siteOperateService() {
        return getService(so.wwb.gamebox.iservice.report.operate.ISiteOperateService.class);
    }

    /**
     * 返回总代经营报表 - Fly远程服务实例
     *
     * @return 总代经营报表 - Fly远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.report.IOperateTopagentService operateTopagentService() {
        return getService(so.wwb.gamebox.iservice.master.report.IOperateTopagentService.class);
    }

    /**
     * 返回代理经营报表 - Fly远程服务实例
     *
     * @return 代理经营报表 - Fly远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.report.IOperateAgentService operateAgentService() {
        return getService(so.wwb.gamebox.iservice.master.report.IOperateAgentService.class);
    }

    /**
     * 返回玩家经营报表 - Fly远程服务实例
     *
     * @return 玩家经营报表 - Fly远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.report.IOperatePlayerService operatePlayerService() {
        return getService(so.wwb.gamebox.iservice.master.report.IOperatePlayerService.class);
    }

    /**
     * 返回轮播广告国际化表 by River远程服务实例
     *
     * @return 轮播广告国际化表 by River远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.ICttCarouselI18nService cttCarouselI18nService() {
        return getService(so.wwb.gamebox.iservice.master.content.ICttCarouselI18nService.class);
    }

    public static so.wwb.gamebox.iservice.company.sys.ISysDomainCheckService sysDomainCheckService() {
        return getService(so.wwb.gamebox.iservice.company.sys.ISysDomainCheckService.class);
    }

    /**
     * 返回总代占成表远程服务实例
     *
     * @return 总代占成表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.agent.IOccupyTopagentService occupyTopagentService() {
        return getService(so.wwb.gamebox.iservice.master.agent.IOccupyTopagentService.class);
    }

    /*我的账号*/
    public static so.wwb.gamebox.iservice.master.setting.IMyAccountService myAccountService() {
        return getService(so.wwb.gamebox.iservice.master.setting.IMyAccountService.class);
    }

    /**
     * 返回包网方案api盈利共担信息远程服务实例
     *
     * @return 包网方案api盈利共担信息远程服务实例
     */
    public static so.wwb.gamebox.iservice.company.scheme.IContractApiService contractApiService() {
        return getService(so.wwb.gamebox.iservice.company.scheme.IContractApiService.class);
    }

    /**
     * 返回API账号表远程服务实例
     *
     * @return API账号表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IPlayerApiAccountService playerApiAccountService() {
        return getService(so.wwb.gamebox.iservice.master.player.IPlayerApiAccountService.class);
    }

    /**
     * 返回player_game_log表远程服务实例
     *
     * @return player_game_log表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IPlayerGameLogService playerGameLogService() {
        return getService(so.wwb.gamebox.iservice.master.player.IPlayerGameLogService.class);
    }

    /**
     * 返回包网方案视图远程服务实例
     *
     * @return 包网方案视图远程服务实例
     */
    public static so.wwb.gamebox.iservice.company.platform.IVContractSchemeService vContractSchemeService() {
        return getService(so.wwb.gamebox.iservice.company.platform.IVContractSchemeService.class);
    }

    /**
     * 返回游戏标签表 by River远程服务实例
     *
     * @return 游戏标签表 by River远程服务实例
     */
    public static so.wwb.gamebox.iservice.company.site.ISiteGameTagService siteGameTagService() {
        return getService(so.wwb.gamebox.iservice.company.site.ISiteGameTagService.class);
    }

    /**
     * 返回代理返佣订单视图远程服务实例
     *
     * @return 代理返佣订单视图远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IVAgentRebateOrderService vAgentRebateOrderService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IVAgentRebateOrderService.class);
    }

    /**
     * 返回返佣方案远程服务实例
     *
     * @return 返佣方案远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.setting.IVRebateAgentService vRebateAgentService() {
        return getService(so.wwb.gamebox.iservice.master.setting.IVRebateAgentService.class);
    }

    /**
     * 报表任务服务实例
     *
     * @return
     * @River
     */
    public static so.wwb.gamebox.iservice.company.setting.ISysExportService sysExportService() {
        return getService(so.wwb.gamebox.iservice.company.setting.ISysExportService.class);
    }

    /**
     * 返回意见反馈表 - eagle远程服务实例
     *
     * @return 意见反馈表 - eagle远程服务实例
     */
    public static so.wwb.gamebox.iservice.company.ISystemFeedbackService systemFeedbackService() {
        return getService(so.wwb.gamebox.iservice.company.ISystemFeedbackService.class);
    }

    public static so.wwb.gamebox.iservice.company.setting.IApiGametypeRelationService apiGametypeRelationService() {
        return getService(so.wwb.gamebox.iservice.company.setting.IApiGametypeRelationService.class);
    }

    /**
     * 返回子账户视图远程服务实例
     *
     * @return 子账户视图远程服务实例
     */
    public static IVSubAccountService vSubAccountService() {
        return getService(IVSubAccountService.class);
    }

    /**
     * 返回玩家导入记录表 by River远程服务实例
     *
     * @return 玩家导入记录表 by River远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IUserPlayerImportService userPlayerImportService() {
        return getService(so.wwb.gamebox.iservice.master.player.IUserPlayerImportService.class);
    }

    /**
     * 返回导入玩家表 by River远程服务实例
     *
     * @return 导入玩家表 by River远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IUserPlayerTransferService userPlayerTransferService() {
        return getService(so.wwb.gamebox.iservice.master.player.IUserPlayerTransferService.class);
    }

    /**
     * 返回返水统计详细视图 - Fly远程服务实例
     *
     * @return 返水统计详细视图 - Fly远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.report.IVRakebackReportService vRakebackReportService() {
        return getService(so.wwb.gamebox.iservice.master.report.IVRakebackReportService.class);
    }

    /**
     * 返回站点返水玩家远程服务实例
     *
     * @return 站点返水玩家远程服务实例
     */
    public static so.wwb.gamebox.iservice.report.rakeback.ISiteRakebackPlayerService siteRakebackPlayerService() {
        return getService(so.wwb.gamebox.iservice.report.rakeback.ISiteRakebackPlayerService.class);
    }

    /**
     * 返回站点API返水远程服务实例
     *
     * @return 站点API返水远程服务实例
     */
    public static so.wwb.gamebox.iservice.report.rakeback.ISiteRakebackApiService siteRakebackApiService() {
        return getService(so.wwb.gamebox.iservice.report.rakeback.ISiteRakebackApiService.class);
    }

    /**
     * 返回站点游戏分类返水远程服务实例
     *
     * @return 站点游戏分类返水远程服务实例
     */
    public static so.wwb.gamebox.iservice.report.rakeback.ISiteRakebackGametypeService siteRakebackGametypeService() {
        return getService(so.wwb.gamebox.iservice.report.rakeback.ISiteRakebackGametypeService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.player.IVUserPlayerImportService vUserPlayerImportService() {
        return getService(so.wwb.gamebox.iservice.master.player.IVUserPlayerImportService.class);
    }

    /**
     * 返回浮动图子项表远程服务实例
     *
     * @return 浮动图子项表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.ICttFloatPicItemService cttFloatPicItemService() {
        return getService(so.wwb.gamebox.iservice.master.content.ICttFloatPicItemService.class);
    }


    public static so.wwb.gamebox.iservice.company.sport.ISportRecommendedService sportRecommendedService() {
        return getService(so.wwb.gamebox.iservice.company.sport.ISportRecommendedService.class);
    }

    /**
     * 返回站点启用表远程服务实例
     *
     * @return 站点启用表远程服务实例
     */
    public static so.wwb.gamebox.iservice.company.sport.IVSportRecommendedService vSportRecommendedService() {
        return getService(so.wwb.gamebox.iservice.company.sport.IVSportRecommendedService.class);
    }

    public static IPlayerFavorableService playerFavorableService() {
        return getService(IPlayerFavorableService.class);
    }

    /**
     * 返回信息模板内容参数表远程服务实例
     *
     * @return 信息模板内容参数表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.setting.INoticeParamRelationService noticeParamRelationService() {
        return getService(so.wwb.gamebox.iservice.master.setting.INoticeParamRelationService.class);
    }

    public static so.wwb.gamebox.iservice.company.sport.ISportRecommendedSiteService sportRecommendedSiteService() {
        return getService(so.wwb.gamebox.iservice.company.sport.ISportRecommendedSiteService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.content.IPayWarningService payWarningService() {
        return getService(so.wwb.gamebox.iservice.master.content.IPayWarningService.class);
    }

    public static IPlayerTransferService playerTransferService() {
        return getService(IPlayerTransferService.class);
    }

    public static ICustomSysAuditLogService customSysAuditLogService() {
        return getService(ICustomSysAuditLogService.class);
    }
    /**
     * 返回site_api_type_relation_i18n远程服务实例
     *
     * @return site_api_type_relation_i18n远程服务实例
     */
    public static so.wwb.gamebox.iservice.company.site.ISiteApiTypeRelationI18nService siteApiTypeRelationI18nService() {
        return getService(so.wwb.gamebox.iservice.company.site.ISiteApiTypeRelationI18nService.class);
    }

    public static ISiteSysParamService siteSysParamService(){
        return getService(ISiteSysParamService.class);
    }

    public static IRebateBillService rebateBillService() {
        return getService(IRebateBillService.class);
    }

    /**
     * 返回Fei - 玩家存款列表视图远程服务实例
     *
     * @return Fei - 玩家存款列表视图远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.fund.IVPlayerDepositService vPlayerDepositService() {
        return getService(so.wwb.gamebox.iservice.master.fund.IVPlayerDepositService.class);
    }

    public static ISmsInterfaceService smsInterfaceService() {
        return getService(ISmsInterfaceService.class);
    }
    
    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.bankorders.IBankOrdersService bankOrdersService() {
        return getService(so.wwb.gamebox.iservice.master.bankorders.IBankOrdersService.class);
    }

    public static so.wwb.gamebox.iservice.company.serve.ISiteContentAuditService siteContentAuditService() {
        return getService(so.wwb.gamebox.iservice.company.serve.ISiteContentAuditService.class);
    }

    public static so.wwb.gamebox.iservice.master.fund.IAgentWithdrawOrderService agentWithdrawOrderService() {
        return getService(so.wwb.gamebox.iservice.master.fund.IAgentWithdrawOrderService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.report.IVPlayerApiTransactionService vPlayerApiTransactionService() {
        return getService(so.wwb.gamebox.iservice.master.report.IVPlayerApiTransactionService.class);
    }

    public static IVPlayerGameTipOrderService vPlayerGameTipOrderService() {
        return getService(IVPlayerGameTipOrderService.class);
    }

    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.report.IVPlayerFundsRecordService vPlayerFundsRecordService() {
        return getService(so.wwb.gamebox.iservice.master.report.IVPlayerFundsRecordService.class);
    }
    /**
     * 返回数据权限远程服务实例
     *
     * @return 数据权限远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.dataRight.ISysUserDataRightService sysUserDataRightService() {
        return getService(so.wwb.gamebox.iservice.master.dataRight.ISysUserDataRightService.class);
    }
    
    /**
     * 返回玩家分析远程服务实例
     *
     * @return 玩家分析远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.analyze.IAnalyzePlayerService analyzePlayerService() {
        return getService(so.wwb.gamebox.iservice.master.analyze.IAnalyzePlayerService.class);
    }
    
    /**
     * 返回远程服务实例
     *
     * @return 远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.analyze.IVAnalyzePlayerService vAnalyzePlayerService() {
        return getService(so.wwb.gamebox.iservice.master.analyze.IVAnalyzePlayerService.class);
    }
    
    /**
     * 返回代理分析远程服务实例
     *
     * @return 代理分析远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.analyze.IAnalyzeAgentService analyzeAgentService() {
        return getService(so.wwb.gamebox.iservice.master.analyze.IAnalyzeAgentService.class);
    }
    
    /**
     * 返回代理返佣账单远程服务实例
     *
     * @return 代理返佣账单远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.fund.rebate.IAgentRebateService agentRebateService() {
        return getService(so.wwb.gamebox.iservice.master.fund.rebate.IAgentRebateService.class);
    }

    /**
     * 返回代理返佣_玩家明细远程服务实例
     *
     * @return 代理返佣_玩家明细远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.fund.rebate.IAgentRebateGradsService agentRebateGradsService() {
        return getService(so.wwb.gamebox.iservice.master.fund.rebate.IAgentRebateGradsService.class);
    }
    
    /**
     * 返回代理返佣_玩家明细远程服务实例
     *
     * @return 代理返佣_玩家明细远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.fund.rebate.IAgentRebatePlayerService agentRebatePlayerService() {
        return getService(so.wwb.gamebox.iservice.master.fund.rebate.IAgentRebatePlayerService.class);
    }
    
    /**
     * 返回站点结算账单远程服务实例
     *
     * @return 站点结算账单远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.fund.ISiteStationBillService siteStationBillService() {
        return getService(so.wwb.gamebox.iservice.master.fund.ISiteStationBillService.class);
    }
    
    /**
     * 返回优惠活动奖项设置远程服务实例
     *
     * @return 优惠活动奖项设置远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IActivityMoneyAwardsRulesService activityMoneyAwardsRulesService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IActivityMoneyAwardsRulesService.class);
    }
    
    /**
     * 返回优惠时间段远程服务实例
     *
     * @return 优惠时间段远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IActivityMoneyConditionService activityMoneyConditionService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IActivityMoneyConditionService.class);
    }
    
    /**
     * 返回优惠时间段远程服务实例
     *
     * @return 优惠时间段远程服务实例
     */
    public static IActivityOpenPeriodService activityMoneyOpenPeriodService() {
        return getService(IActivityOpenPeriodService.class);
    }

    /**
     * 返回投注记录服务实例
     *
     * @return 投注记录服务实例
     */
    public static so.wwb.gamebox.iservice.master.lottery.ILotteryBetOrderService lotteryBetOrderService() {
        return getService(so.wwb.gamebox.iservice.master.lottery.ILotteryBetOrderService.class);
    }

    /**
     * 返回彩票资金记录表远程服务实例
     *
     * @return 彩票资金记录表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.lottery.ILotteryTransactionService lotteryTransactionService() {
        return getService(so.wwb.gamebox.iservice.master.lottery.ILotteryTransactionService.class);
    }

    /**
     * 返回红包内定表远程服务实例
     *
     * @return 红包内定表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IActivityMoneyDefaultWinService activityMoneyDefaultWinService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IActivityMoneyDefaultWinService.class);
    }

    /**
     * 返回红包内定玩家表远程服务实例
     *
     * @return 红包内定玩家表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IActivityMoneyDefaultWinPlayerService activityMoneyDefaultWinPlayerService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IActivityMoneyDefaultWinPlayerService.class);
    }

    /**
     * 返回红包内定操作记录表远程服务实例
     *
     * @return 红包内定操作记录表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IActivityMoneyDefaultWinRecordService activityMoneyDefaultWinRecordService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IActivityMoneyDefaultWinRecordService.class);
    }
    
    /**
     * 返回红包抽奖记录表远程服务实例
     *
     * @return 红包抽奖记录表远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.operation.IActivityMoneyPlayRecordService activityMoneyPlayRecordService() {
        return getService(so.wwb.gamebox.iservice.master.operation.IActivityMoneyPlayRecordService.class);
    }

    public static so.wwb.gamebox.iservice.company.lottery.ISiteLotteryQuotaService siteLotteryQuotaService() {
        return getService(so.wwb.gamebox.iservice.company.lottery.ISiteLotteryQuotaService.class);
    }

    public static so.wwb.gamebox.iservice.company.lottery.ISiteLotteryOddService siteLotteryOddService() {
        return getService(so.wwb.gamebox.iservice.company.lottery.ISiteLotteryOddService.class);
    }
    /**
     * 返回返佣梯度方案远程服务实例
     *
     * @return 返佣梯度方案远程服务实例
     */
    public static so.wwb.gamebox.iservice.master.setting.IRebateGradsSetService rebateGradsSetService() {
        return getService(so.wwb.gamebox.iservice.master.setting.IRebateGradsSetService.class);
    }

//endregion your codes 1

}
