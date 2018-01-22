package so.wwb.gamebox.mcenter.setting.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.ArrayTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.commons.security.CryptoTool;
import org.soul.commons.support._Module;
import org.soul.iservice.sys.ISysParamService;
import org.soul.model.msg.notice.enums.NoticePublishMethod;
import org.soul.model.msg.notice.po.NoticeEmailInterface;
import org.soul.model.msg.notice.vo.NoticeEmailInterfaceVo;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.model.sms_interface.po.SmsInterface;
import org.soul.model.sms_interface.vo.SmsInterfaceListVo;
import org.soul.model.sms_interface.vo.SmsInterfaceVo;
import org.soul.model.sys.po.SysDict;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.vo.SysParamListVo;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.session.SessionManagerBase;
import org.soul.web.sys.form.SysParamForm;
import org.soul.web.sys.form.SysParamSearchForm;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.content.form.RegLimitForm;
import so.wwb.gamebox.mcenter.player.form.RecommendedForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.*;
import so.wwb.gamebox.model.*;
import so.wwb.gamebox.model.common.Const;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.common.notice.enums.AutoNoticeEvent;
import so.wwb.gamebox.model.common.notice.enums.CometSubscribeType;
import so.wwb.gamebox.model.company.site.po.SiteConfineArea;
import so.wwb.gamebox.model.company.site.po.SiteI18n;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.company.site.po.SiteOperateArea;
import so.wwb.gamebox.model.company.site.vo.*;
import so.wwb.gamebox.model.company.sys.po.SysDomain;
import so.wwb.gamebox.model.company.sys.po.SysSite;
import so.wwb.gamebox.model.company.sys.vo.SysDomainListVo;
import so.wwb.gamebox.model.company.sys.vo.SysSiteVo;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.agent.po.VSubAccount;
import so.wwb.gamebox.model.master.agent.vo.VSubAccountListVo;
import so.wwb.gamebox.model.master.content.vo.CttLogoVo;
import so.wwb.gamebox.model.master.content.vo.PayAccountVo;
import so.wwb.gamebox.model.master.operation.vo.PlayerRankAppDomainListVo;
import so.wwb.gamebox.model.master.player.vo.PlayerRankVo;
import so.wwb.gamebox.model.master.setting.po.FieldSort;
import so.wwb.gamebox.model.master.setting.po.GradientTemp;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.SiteCustomerServiceHelper;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.text.MessageFormat;
import java.util.*;


/**
 * 开关、参数相关控制器
 *
 * @author loong
 * @time 2015-8-17 10:07:49
 */
@Controller
//region your codes 1
@RequestMapping("/param")
public class ParamController extends BaseCrudController<ISysParamService, SysParamListVo, SysParamVo, SysParamSearchForm, SysParamForm, SysParam, Integer> {
    //endregion your codes 1
    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/param/";
        //endregion your codes 2
    }

    //region your codes 3

    /**
     * 开关设置
     *
     * @return
     */
    @RequestMapping({"/switch"})
    public String switchSetting(Model model) {
        Collection<SysParam> c1 = ParamTool.getSysParams(SiteParamEnum.SETTING_OPERATE_MANAGE_LINE);
        List<SysParam> list1 = new ArrayList<>();
        for (SysParam sysParam : c1) {
            list1.add(sysParam);
        }
        Collection<SysParam> c2 = ParamTool.getSysParams(SiteParamEnum.SETTING_SYSTEM_SETTINGS_SMS);
        List<SysParam> list2 = new ArrayList<>();
        for (SysParam sysParam : c2) {
            list2.add(sysParam);
        }
        model.addAttribute("list1", list1);
        model.addAttribute("list2", list2);
        findEnableImportPlayerParam(model);
        return this.getViewBasePath() + "switch/Index";
    }

    /**
     * 保存开关设置
     *
     * @param id
     * @param state
     * @return
     */
    @RequestMapping({"/saveSwitch"})
    @ResponseBody
    public Map saveSwitch(Integer id, String state) {
        SysParamVo vo = new SysParamVo();
        vo._setDataSourceId(SessionManager.getSiteId());
        vo.getSearch().setId(id);
        vo = ServiceTool.getSysParamService().get(vo);
        if (vo == null) {
            vo.setSuccess(false);
            return this.getVoMessage(vo);
        }
        vo.getResult().setParamValue(state);
        vo.setProperties(SysParam.PROP_PARAM_VALUE);
        ServiceTool.getSysParamService().updateOnly(vo);
        //查询是否已经发过站内信
        SiteI18nListVo siteI18nListVo = new SiteI18nListVo();
        siteI18nListVo._setDataSourceId(SessionManager.getSiteParentId());
        siteI18nListVo.getSearch().setModule(vo.getResult().getModule());
        siteI18nListVo.getSearch().setType(vo.getResult().getParamType());
        siteI18nListVo.getSearch().setKey(vo.getResult().getParamCode());
        siteI18nListVo = ServiceTool.siteI18nService().search(siteI18nListVo);
        //判断是否已经有发过站内信
        if (siteI18nListVo.getResult().size() > 0 && !Boolean.valueOf(state)) {
            return this.getVoMessage(vo);
        }
        //发送站内信
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setPublishMethod(NoticePublishMethod.SITE_MSG);
        noticeVo._setDataSourceId(SessionManager.getSiteId());
        noticeVo.setSendUserId(NoticeVo.SEND_USER_ID);

        //目标对象id
        //查询子账号id
        toUserIds(noticeVo);

        //内容
        noticeVo.setEventType(AutoNoticeEvent.SWITCH);
        String operator = LocaleTool.tranMessage(Module.MASTER_SETTING, "operate_manage.operate." + vo.getResult().getParamCode());
        String status = LocaleTool.tranMessage(Module.MASTER_SETTING, "operate_manage." + state);
        noticeVo.addParams(new Pair("account", SessionManager.getUserName()));
        noticeVo.addParams(new Pair("time", DateTool.formatDate(new Date(), LocaleDateTool.getFormat("DAY_SECOND"))));
        noticeVo.addParams(new Pair("switch", status));
        noticeVo.addParams(new Pair("name", operator));
        noticeVo.setSubscribeType(CometSubscribeType.READ_COUNT);
        try {
            ServiceTool.noticeService().publish(noticeVo);
        } catch (Exception ex) {
            LogFactory.getLog(this.getClass()).error(ex, "发布消息不成功");
        }

        ParamTool.refresh(SiteParamEnum.SETTING_OPERATE_MANAGE_LINE);
        ParamTool.refresh(SiteParamEnum.SETTING_SYSTEM_SETTINGS_SMS);
        Cache.refreshCurrentSitePageCache();
        return this.getVoMessage(vo);


    }

    private void toUserIds(NoticeVo noticeVo) {
        VSubAccountListVo vSubAccountListVo = new VSubAccountListVo();
        vSubAccountListVo.getSearch().setUserType(UserTypeEnum.MASTER_SUB.getCode());
        vSubAccountListVo.setProperties(VSubAccount.PROP_ID);
        List<Integer> ids = ServiceTool.vSubAccountService().searchProperty(vSubAccountListVo);
        /* 站长虚拟账号*/
        ids.add(Const.MASTER_BUILT_IN_ID);
        ids.add(NoticeVo.SEND_USER_ID);
        noticeVo.addUserIds(ids.toArray(new Integer[1]));
    }

    /**
     * 弹出 关闭文案
     *
     * @param model
     * @param id
     * @return
     */
    @RequestMapping({"/closeReminder"})
    public String closeReminder(Model model, Integer id) {
        SiteLanguageListVo vo = new SiteLanguageListVo();
        vo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> search = ServiceTool.siteLanguageService().availableLanguage(vo);
        SysParamVo command = new SysParamVo();
        command._setDataSourceId(SessionManager.getSiteId());
        command.getSearch().setId(id);
        command = ServiceTool.getSysParamService().get(command);

        Map<String, SiteI18n> siteI18n = null;
        switch (command.getResult().getParamCode()) {
            case "closure":
                siteI18n = Cache.getSiteI18n(SiteI18nEnum.SETTING_OPERATE_MANAGE_CLOSURE);
                break;
            case "player":
                siteI18n = Cache.getSiteI18n(SiteI18nEnum.SETTING_SYSTEM_SETTINGS_PLAYER);
                break;
            case "proxy":
                siteI18n = Cache.getSiteI18n(SiteI18nEnum.SETTING_SYSTEM_SETTINGS_AGENT);
                break;
        }


        command.setValidateRule(JsRuleCreator.create(Sitei18nForm.class, "result"));
        model.addAttribute("list", search);
        model.addAttribute("command", command);
        Map<String, SysDict> types = DictTool.get(DictEnum.MASTER_SETTING_CLOSE_TIME_TYPE);
        model.addAttribute("types", types);
        SysParam type = ParamTool.getSysParam(SiteParamEnum.SETTING_CLOSE_SITE_SALES_TYPE);
        model.addAttribute("closeType", type);
        model.addAttribute("siteI18n", siteI18n);

        return this.getViewBasePath() + "switch/CloseReminder";
    }

    /**
     * 保存关闭文案
     *
     * @param objectVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping({"/saveCloseReminder"})
    @ResponseBody
    public Map saveCloseReminder(SiteI18nVo objectVo, @FormModel("result") @Valid Sitei18nForm form, BindingResult result) {
        if (!result.hasErrors()) {
            objectVo._setSiteParentId(SessionManager.getSiteParentId());
            objectVo._setSiteId(SessionManager.getSiteId());
            objectVo._setDataSourceId(SessionManager.getSiteParentId());
            objectVo.getSearch().setSiteId(SessionManager.getSiteId());
            SysParamVo paramVo = new SysParamVo();
            paramVo.setResult(objectVo.getSysParam());
            paramVo.setProperties(SysParam.PROP_PARAM_VALUE);
            ServiceTool.getSysParamService().updateOnly(paramVo);
            //站内信是否需要显示 定时
            Date lastTime = new Date();
            if ("closure".equals(objectVo.getResult().getKey())) {
                if ("2".equals(objectVo.getType())) {
                    SysParam param = ParamTool.getSysParam(SiteParamEnum.SETTING_CLOSE_SITE_SALES_TIME);
                    param.setParamValue(String.valueOf(objectVo.getCloseTime()));
                    paramVo.setResult(param);
                    ServiceTool.getSysParamService().updateOnly(paramVo);
                }
            }
            objectVo = ServiceTool.siteI18nService().saveCloseReminder(objectVo);
            //发送站内信
            NoticeVo noticeVo = new NoticeVo();
            noticeVo.setPublishMethod(NoticePublishMethod.SITE_MSG);
            noticeVo._setDataSourceId(SessionManager.getSiteId());

            //目标对象id
            //查询子账号id
            toUserIds(noticeVo);

            //已开通的语言
            HashMap<String, Pair<String, String>> localTempMap = new HashMap();
            SiteLanguageListVo siteLanguageListVo = new SiteLanguageListVo();
            siteLanguageListVo.getSearch().setSiteId(SessionManager.getSiteId());
            List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageListVo);
            for (SiteLanguage language : languageList) {
                String title = I18nTool.getI18nMap(language.getLanguage()).get("messages").get("setting").get("operate_manage.notice.close");
                title = title.replace("{0}", SessionManager.getUserName());
                title = title.replace("{1}", DateTool.formatDate(new Date(), LocaleDateTool.getFormat("DAY_SECOND")));

                String status = I18nTool.getI18nMap(language.getLanguage()).get("messages").get("setting").get("operate_manage.false");
                title = title.replace("{2}", status);

                String operator = LocaleTool.tranMessage(Module.MASTER_SETTING, "operate_manage.operate." + objectVo.getResult().getKey());
                title = title.replace("{3}", operator);
                //遍历内容
                for (SiteI18n i18n : objectVo.getSv()) {
                    if (i18n.getLocale().equals(language.getLanguage())) {
                        //添加时间
                        String last = LocaleTool.tranMessage(Module.MASTER_SETTING, "operate_manage.notice.close.last");
                        String timing = LocaleTool.tranMessage(Module.MASTER_SETTING, "operate_manage.timing." + (objectVo.getCloseTime() != null));
                        last = last.replace("{0}", timing);
                        last = last.replace("{1}", DateTool.formatDate(lastTime, LocaleDateTool.getFormat("DAY_SECOND")));
                        Pair pair = new Pair<>(title, i18n.getValue() + last);
                        localTempMap.put(language.getLanguage(), pair);
                    }
                }
            }
            noticeVo.setLocaleTmplMap(localTempMap);
            noticeVo.setSubscribeType(CometSubscribeType.READ_COUNT);
            try {
                ServiceTool.noticeService().publish(noticeVo);
            } catch (Exception ex) {
                LogFactory.getLog(this.getClass()).error(ex, "发布消息不成功");
            }
            ParamTool.refresh(SiteParamEnum.SETTING_OPERATE_MANAGE_LINE);
            ParamTool.refresh(SiteParamEnum.SETTING_SYSTEM_SETTINGS_SMS);
            Cache.refreshSiteI18n(SiteI18nEnum.SETTING_OPERATE_MANAGE_CLOSURE);
            Cache.refreshSiteI18n(SiteI18nEnum.SETTING_SYSTEM_SETTINGS_PLAYER);
            Cache.refreshCurrentSitePageCache();
            return this.getVoMessage(objectVo);
        }
        return null;
    }

    /**
     * 验证码设置
     *
     * @return
     */
    @RequestMapping({"/verification"})
    public String verification(Model model) {
        setVerificationData(model);
        return this.getViewBasePath() + "verification/Index";
    }

    private void setVerificationData(Model model) {
        SysParam captchaStyleParam = ParamTool.getSysParam(SiteParamEnum.SETTING_CAPTCHA_STYLE);
        SysParam captchaExclusionsParam = ParamTool.getSysParam(SiteParamEnum.SETTING_CAPTCHA_EXCLUSIONS);
        SysParam captchaGimpyParam = ParamTool.getSysParam(SiteParamEnum.SETTING_CAPTCHA_GIMPY);
        Collection<SysParam> captchaStyles = ParamTool.getSysParams(SiteParamEnum.SETTING_CAPTCHA_STYLES);

        model.addAttribute("captchaStyleParams", captchaStyles);
        model.addAttribute("captchaStyleParam", captchaStyleParam);
        model.addAttribute("captchaExclusionsParam", captchaExclusionsParam);
        model.addAttribute("captchaGimpyParam", captchaGimpyParam);
        model.addAttribute("captchaStyleParam", captchaStyleParam);
        findEnableImportPlayerParam(model);
    }


    /**
     * 保存验证码设置
     * @param captchaStyleId
     * @param captchaStyle
     * @param captchaExclusionsId
     * @param captchaExclusions
     * @param captchaGimpyId
     * @param captchaGimpy
     * @param form
     * @param result
     * @return
     */
    @RequestMapping({"/saveCaptcha"})
    @ResponseBody
    public Map saveYzm(Integer captchaStyleId, String captchaStyle,
                       Integer captchaExclusionsId, String captchaExclusions,
                       Integer captchaGimpyId, String captchaGimpy,
                       @FormModel() @Valid CaptchaForm form, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, Object> map = new HashMap<>(2);
            map.put("state", false);
            map.put("msg", LocaleTool.tranMessage("setting_auto", "请检查输入是否错误并且不能排除所有的字母和数字"));
            return map;
        }

        List<SysParam> sysParamList = new ArrayList<>();
        SysParam sysParam = new SysParam();
        sysParam.setId(captchaStyleId);
        sysParam.setParamValue(captchaStyle);
        sysParamList.add(sysParam);

        sysParam = new SysParam();
        sysParam.setId(captchaExclusionsId);
        sysParam.setParamValue(captchaExclusions);
        sysParamList.add(sysParam);

        sysParam = new SysParam();
        sysParam.setId(captchaGimpyId);
        sysParam.setParamValue(captchaGimpy);
        sysParamList.add(sysParam);

        SysParamVo paramVo = new SysParamVo();
        paramVo._setDataSourceId(SessionManager.getSiteId());
        paramVo.setEntities(sysParamList);
        paramVo.setProperties(SysParam.PROP_PARAM_VALUE);
        ServiceTool.getSysParamService().batchUpdateOnly(paramVo);
        ParamTool.refresh(SiteParamEnum.SETTING_CAPTCHA_STYLE);
        return this.getVoMessage(paramVo);

    }

    @RequestMapping({"/siteParam"})
    public String siteParam(SysSiteVo sysSiteVo,Model model) {
        findEnableImportPlayerParam(model);
        basicSettingEdit(sysSiteVo,model);
        model.addAttribute("webtype", "1");
        return "setting/param/siteparameters/SiteParam";
    }


    /**
     * 加载站点参数-基本设置信息
     *
     * @param sysSiteVo
     * @param model
     * @return
     */
    @RequestMapping({"/basicSettingIndex"})
    public String basicSettingEdit(SysSiteVo sysSiteVo, Model model) {
        Integer siteId = SessionManagerBase.getSiteId();
        sysSiteVo.getSearch().setId(siteId);
        sysSiteVo = ServiceTool.sysSiteService().get(sysSiteVo);
        //计算开站至今
        Date openingTime = sysSiteVo.getResult().getOpeningTime();
        sysSiteVo.setYear(DateTool.yearsBetween(new Date(), openingTime));
        sysSiteVo.setMonth(DateTool.monthsBetween(new Date(), openingTime) % 12);
        sysSiteVo.setDay(DateTool.daysBetween(new Date(), openingTime) % 30);
        //国旗
        sysSiteVo.setCttLogo(ServiceSiteTool.getCttLogService().getCttlog(new CttLogoVo()));
        //货币 和 语言
        sysSiteVo = ServiceTool.siteOperateAreaService().getAreaCurrancyLang(new SiteOperateAreaListVo(), sysSiteVo);
        sysSiteVo.setValidateRule(JsRuleCreator.create(TrafficStatisticsForm.class, "result"));
        //查询货币使用的玩家数
        //增加设置languageListVo的查询条件 siteId 开始--cogo
        SiteLanguageListVo languageListVo = new SiteLanguageListVo();
        languageListVo.getSearch().setSiteId(siteId);
        //增加设置languageListVo的查询条件 siteId 结束--cogo
        languageListVo = ServiceTool.siteLanguageService().search(languageListVo);
        transLangByLocale(languageListVo, sysSiteVo.getResult().getMainLanguage());
        sysSiteVo.setSiteLanguageList(languageListVo.getResult());
        sysSiteVo.setSiteI18nMap(Cache.getSiteI18n(SiteI18nEnum.SETTING_SITE_NAME));
        sysSiteVo = ServiceSiteTool.vUserPlayerService().queryCurrencyPlayerNum(sysSiteVo);
        findEnableImportPlayerParam(model);
        model.addAttribute("command", sysSiteVo);
        model.addAttribute("siteTile", Cache.getSiteI18n(SiteI18nEnum.SETTING_SITE_TITLE));
        model.addAttribute("siteKeywords", Cache.getSiteI18n(SiteI18nEnum.SETTING_SITE_KEYWORDS));
        model.addAttribute("siteDescription", Cache.getSiteI18n(SiteI18nEnum.SETTING_SITE_DESCRIPTION));
        //该运营商下站长开通的语言
        List<String> list = ServiceTool.siteLanguageService().masterIsUse(sysSiteVo);
        model.addAttribute("masterIsUseLanguage", list);
        //查询多语言站点名称
        setVerificationData(model);
        setEmailInterface(model);
        getSmsInterface(model);
        //获取客服信息
        model.addAttribute("pcCustomerService", SiteCustomerServiceHelper.getDefaultCustomerService());
        model.addAttribute("mobileCustomerService", SiteCustomerServiceHelper.getMobileCustomerService());
        //取款方式
        withdrawTypeParam(model);
        //APP下载域名
        SysDomainListVo sysDomainListVo = new SysDomainListVo();
        sysDomainListVo.getSearch().setSiteId(SessionManager.getSiteId());
        sysDomainListVo = ServiceTool.sysDomainService().updateAppDomain(sysDomainListVo);
        List<SysDomain> result = sysDomainListVo.getResult();
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.SETTING_SYSTEM_SETTINGS_APP_DOMAIN);
        SysParam param = ParamTool.getSysParam(SiteParamEnum.SETTING_SYSTEM_SETTINGS_ACCESS_DOMAIN);
        SysParam mobileTraffic = ParamTool.getSysParam(SiteParamEnum.SETTING_SYSTEM_SETTINGS_MOBILE_TRAFFIC_STATISTICS);
        SysParam sysParamPhone = ParamTool.getSysParam(SiteParamEnum.CONNECTION_SETTING_PHONE_NUMBER);
        SysParam sysParamQq = ParamTool.getSysParam(SiteParamEnum.CONNECTION_SETTING_E_MAIL);
        SysParam sysParamSkyep = ParamTool.getSysParam(SiteParamEnum.CONNECTION_SETTING_QQ);
        SysParam sysParamEmail= ParamTool.getSysParam(SiteParamEnum.CONNECTION_SETTING_SKYPE);
        SysParam sysParamCopyright= ParamTool.getSysParam(SiteParamEnum.CONNECTION_SETTING_COPYRIGHT_INFORMATION);
        SysParam sysParamQrSwitch= ParamTool.getSysParam(SiteParamEnum.LOGIN_QR_CODE_SWITCH);
        model.addAttribute("qrSwitch",sysParamQrSwitch);
        model.addAttribute("phone",sysParamPhone);
        model.addAttribute("qq",sysParamQq);
        model.addAttribute("skyep",sysParamSkyep);
        model.addAttribute("email",sysParamEmail);
        model.addAttribute("copyright",sysParamCopyright);
        model.addAttribute("access_domain",param);
        model.addAttribute("select_domain",sysParam);
        model.addAttribute("mobile_traffic",mobileTraffic.getParamValue());
        model.addAttribute("appDomain",result);
        model.addAttribute("playerRanks", ServiceSiteTool.playerRankService().queryUsableList(new PlayerRankVo()));
        model.addAttribute("rankAppDomain",ServiceTool.playerRankAppDomainService().search(new PlayerRankAppDomainListVo()));
        return "/setting/param/siteparameters/BasicSetting";
    }

    /**
     * 设置取款打款方式
     *
     * @param model
     */
    private void withdrawTypeParam(Model model) {
        model.addAttribute("withdrawCashParam", ParamTool.getSysParam(SiteParamEnum.SETTING_WITHDRAW_TYPE_IS_CASH));
        model.addAttribute("withdrawBitcoinParam", ParamTool.getSysParam(SiteParamEnum.SETTING_WITHDRAW_TYPE_IS_BITCOIN));
    }

    private void setEmailInterface(Model model) {
        NoticeEmailInterface defaultEmailInterface = getDefaultEmailInterface();
        if (defaultEmailInterface != null) {
            defaultEmailInterface = showEmailInterfacePwd(defaultEmailInterface);
        }
        model.addAttribute("emailInterface", defaultEmailInterface);
    }

    private void getSmsInterface(Model model) {
        SmsInterfaceVo smsInterfaceVo = new SmsInterfaceVo();
        smsInterfaceVo._setDataSourceId(SessionManager.getSiteId());
        smsInterfaceVo = ServiceTool.smsInterfaceService().search(smsInterfaceVo);
        setSelectList(smsInterfaceVo);
        model.addAttribute("smsInterfaceVo", smsInterfaceVo);
    }

    private void setSelectList(SmsInterfaceVo objectVo) {
        SmsInterfaceListVo interfaceListVo = new SmsInterfaceListVo();
        interfaceListVo.setProperties(SmsInterface.PROP_ID, SmsInterface.PROP_FULL_NAME);
        interfaceListVo._setDataSourceId(0);
        objectVo.setQueryList(ServiceTool.smsInterfaceService().searchProperties(interfaceListVo));
    }

    private NoticeEmailInterface getDefaultEmailInterface() {
        NoticeEmailInterfaceVo emailInterfaceVo = new NoticeEmailInterfaceVo();
        emailInterfaceVo.getSearch().setId(-1);
        emailInterfaceVo = ServiceTool.noticeEmailInterfaceService().get(emailInterfaceVo);
        if (emailInterfaceVo != null && emailInterfaceVo.getResult() != null) {
            return emailInterfaceVo.getResult();
        }
        return null;
    }

    private NoticeEmailInterface showEmailInterfacePwd(NoticeEmailInterface emailInterface) {
        if (emailInterface == null || StringTool.isBlank(emailInterface.getAccountPassword())) {
            return emailInterface;
        }
        String pwd = CryptoTool.aesDecrypt(emailInterface.getAccountPassword());
        emailInterface.setAccountPassword(pwd);
        return emailInterface;
    }

    /**
     * 查询是否可转站参数
     *
     * @param model
     * @return
     */
    private void findEnableImportPlayerParam(Model model) {
        SysSiteVo sysSiteVo = new SysSiteVo();
        sysSiteVo.getSearch().setId(SessionManager.getSiteId());
        SysSite sysSite = ServiceTool.sysSiteService().getSiteImport(sysSiteVo);
        if (sysSite != null) {
            model.addAttribute("isEnableImport", "1");
            model.addAttribute("endImportTime", sysSite.getImportPlayersTime());
        }
    }


    @RequestMapping({"/importPlayer"})
    public String importPlayer(Model model, SysSiteVo sysSiteVo) {
        //siteOperateAreaVo.setValidateRule(JsRuleCreator.create(BasicAreaForm.class, "result"));
        findEnableImportPlayerParam(model);
        model.addAttribute("command", sysSiteVo);
        return "/setting/param/importplayer/ImportPlayer";
    }


    @RequestMapping({"/addOperatorArea"})
    public String addOperatorArea(Model model, SiteOperateAreaVo siteOperateAreaVo) {
        siteOperateAreaVo.setValidateRule(JsRuleCreator.create(BasicAreaForm.class, "result"));
        model.addAttribute("command", siteOperateAreaVo);
        return "/setting/param/siteparameters/AddOperatorArea";
    }

    /**
     * 保存访问地区限制
     *
     * @param siteOperateAreaVo
     * @param siteOperateAreaListVo
     * @param request
     * @param form
     * @param result
     * @return
     */
    @RequestMapping({"/saveOperatorArea"})
    @ResponseBody
    public Map saveOperatorArea(SiteOperateAreaVo siteOperateAreaVo, SiteOperateAreaListVo siteOperateAreaListVo, HttpServletRequest request, @FormModel("result") @Valid BasicAreaForm form, BindingResult result) {

        SiteOperateArea area = siteOperateAreaVo.getResult();
        siteOperateAreaListVo.getSearch().setCode(area.getCode());
        siteOperateAreaListVo.getSearch().setSiteId(SessionManager.getSiteId());
        long num = ServiceTool.siteOperateAreaService().count(siteOperateAreaListVo);
        if (num > 0) {
            siteOperateAreaVo.setSuccess(false);
            siteOperateAreaVo.setErrMsg(LocaleTool.tranMessage("setting_auto", "该地区已在限制列表中"));
            return this.getVoMessage(siteOperateAreaVo);
        }
        area.setSiteId(SessionManagerBase.getSiteId());
        area.setAreaIp(ServletTool.getIpAddr(request));
        area.setStatus("1");
        ServiceTool.siteOperateAreaService().insert(siteOperateAreaVo);
        Cache.refreshSiteOperateArea();
        return this.getVoMessage(siteOperateAreaVo);
    }

    /**
     * 修改限制地区访问
     *
     * @param siteOperateAreaVo
     */
    @RequestMapping({"/changeArea"})
    @ResponseBody
    public void changeArea(SiteOperateAreaVo siteOperateAreaVo) {
        String[] properties = new String[2];
        properties[0] = SiteLanguage.PROP_STATUS;
        properties[1] = SiteLanguage.PROP_OPEN_TIME;
        siteOperateAreaVo.setProperties(properties);
        siteOperateAreaVo.getResult().setOpenTime(new Date());
        ServiceTool.siteOperateAreaService().updateOnly(siteOperateAreaVo);
        Cache.refreshSiteOperateArea();
    }

    /**
     * 启用停用货币
     *
     * @param siteCurrencyVo
     */
    @RequestMapping({"/changeCurrency"})
    @ResponseBody
    public void changeCurrency(SiteCurrencyVo siteCurrencyVo) {
        String[] properties = new String[1];
        properties[0] = SiteConfineArea.PROP_STATUS;
        siteCurrencyVo.setProperties(properties);
        ServiceTool.sysSiteCurrencyService().updateOnly(siteCurrencyVo);
        Cache.refreshSiteCurrency();
        Cache.refreshCurrentSitePageCache();
    }

    /**
     * q启用停用语言
     *
     * @param siteLanguageVo
     */
    @RequestMapping({"/changeLanguage"})
    @ResponseBody
    public void changeLanguage(SiteLanguageVo siteLanguageVo) {
        String[] properties = new String[2];
        properties[0] = SiteLanguage.PROP_STATUS;
        properties[1] = SiteLanguage.PROP_OPEN_TIME;
        siteLanguageVo.setProperties(properties);
        siteLanguageVo.getResult().setOpenTime(new Date());
        ServiceTool.siteLanguageService().updateOnly(siteLanguageVo);
        Cache.refreshSiteLanguage();
        Cache.refreshCurrentSitePageCache();
    }

    //加载注册设置
    @RequestMapping({"/getPlayerReg"})
    public String getPlayerReg() {
        return this.getViewBasePath() + "/regSetting/PlayerReg";
    }

    /**
     * 加载玩家注册设置
     *
     * @param siteConfineAreaVo
     * @param model
     * @return
     */
    @RequestMapping({"/PlayerSetting"})
    public String PlayerSetting(SiteConfineAreaVo siteConfineAreaVo, Model model) {
        siteConfineAreaVo = this.loadSiteConfineIpVo(siteConfineAreaVo);
        SysParam interval;
        SysParam regnum;
        SysParam address;
        SysParam phone;
        SysParam mail;
        if (StringTool.isNotBlank(siteConfineAreaVo.getType())) {
            interval = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_LIMIT_IP_REG_INTERVAL_AGENT);
            regnum = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_LIMIT_IP_DAY_MAX_REGNUM_AGENT);
            address = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_LIMIT_REG_ADDRESS_AGENT);
            phone = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SETTING_PHONE_VERIFCATION_AGENT);
            mail = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SETTING_MAIL_VERIFCATION_AGENT);
        } else {
            interval = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_LIMIT_IP_REG_INTERVAL);
            regnum = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_LIMIT_IP_DAY_MAX_REGNUM);
            address = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_LIMIT_REG_ADDRESS);
            phone = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SETTING_PHONE_VERIFCATION);
            mail = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SETTING_MAIL_VERIFCATION);
        }

        siteConfineAreaVo.setPhoneParam(phone);
        siteConfineAreaVo.setMailParam(mail);
        siteConfineAreaVo.setRegAddressParam(address);
        siteConfineAreaVo.setIpRegIntervalParam(interval);
        siteConfineAreaVo.setIpDayMaxRegNumParam(regnum);
        siteConfineAreaVo.setValidateRule(JsRuleCreator.create(RegLimitForm.class, "result"));
        model.addAttribute("command", siteConfineAreaVo);
        return this.getViewBasePath() + "/regSetting/playerSetting";
    }

    /**
     * 保存注册设置
     *
     * @param siteConfineAreaVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping({"/savePlayerSetting"})
    @ResponseBody
    public Map savePlayerSetting(SiteConfineAreaVo siteConfineAreaVo, @FormModel("result") @Valid RegLimitForm form, BindingResult result) {
        if (!result.hasErrors()) {
            siteConfineAreaVo._setDataSourceId(SessionManager.getSiteId());
            //ServiceTool.siteConfineAreaService().savePlayerSetting(siteConfineAreaVo);
            ServiceSiteTool.siteSysParamService().savePlayerSetting(siteConfineAreaVo);
            ParamTool.refresh(SiteParamEnum.SETTING_REG_LIMIT_IP_REG);
            ParamTool.refresh(SiteParamEnum.SETTING_REG_SETTING_SETTING);

            ParamTool.refresh(SiteParamEnum.SETTING_REG_LIMIT_IP_REG_AGENT);
            ParamTool.refresh(SiteParamEnum.SETTING_REG_SETTING_FIELD_AGENT);
            ParamTool.refresh(SiteParamEnum.SETTING_REG_LIMIT_IP_DAY_MAX_REGNUM);

            Cache.refreshCurrentSitePageCache();

            return this.getVoMessage(siteConfineAreaVo);
        }
        return null;
    }

    /**
     * 保存流量统计
     *
     * @param vo
     */
    @RequestMapping({"/saveTrafficStatistics"})
    @ResponseBody
    public Map saveTrafficStatistics(SysSiteVo vo, @FormModel("result") @Valid TrafficStatisticsForm form, BindingResult result) {
        if (!result.hasErrors()) {
            vo.getResult().setId(CommonContext.get().getSiteId());
            vo.setProperties(SysSite.PROP_TRAFFIC_STATISTICS);
            ServiceTool.sysSiteService().updateOnly(vo);
            Cache.refreshSysSite();
            Cache.refreshCurrentSitePageCache();
            return this.getVoMessage(vo);
        } else {
            Map<String, Object> msg = new HashMap<>();
            msg.put("msg", result.getAllErrors().get(0).getDefaultMessage());
            return msg;
        }

    }

    /**
     * 加载注册设置
     */

    @RequestMapping({"/getFieldSort"})
    public String getFieldSort(SiteConfineAreaVo siteConfineAreaVo, Model model) {
        model.addAttribute("command", this.loadSiteConfineIpVo(siteConfineAreaVo));
        findEnableImportPlayerParam(model);
        return this.getViewBasePath() + "/regSetting/PlayerReg";
    }

    /**
     * 保存注册设置字段排序
     *
     * @param sysParamVo
     * @return
     */
    @RequestMapping({"/saveRegSetting"})
    @ResponseBody
    public Map saveRegSetting(SysParamVo sysParamVo) {
        sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE);
        sysParamVo = ServiceTool.getSysParamService().updateOnly(sysParamVo);
        ParamTool.refresh(SiteParamEnum.SETTING_REG_SETTING_FIELD_SETTING_AGENT);
        ParamTool.refresh(SiteParamEnum.SETTING_REG_SETTING_FIELD_SETTING);
        Cache.refreshCurrentSitePageCache();
        return this.getVoMessage(sysParamVo);
    }

    /**
     * 加载ｖｏ数据
     *
     * @return
     */
    public SiteConfineAreaVo loadSiteConfineIpVo(SiteConfineAreaVo siteConfineAreaVo) {
        SysParam phone;
        SysParam mail;
        if (StringTool.isNotBlank(siteConfineAreaVo.getType())) {

            phone = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SETTING_PHONE_VERIFCATION_AGENT);
            mail = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SETTING_MAIL_VERIFCATION_AGENT);
            SysParam param = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SETTING_FIELD_SETTING_AGENT);
            ArrayList<FieldSort> fieldSorts = JsonTool.fromJson(StringTool.isBlank(param.getParamValue()) ? param.getDefaultValue() : param.getParamValue(), new TypeReference<ArrayList<FieldSort>>() {
            });
            siteConfineAreaVo.setFieldSortList(fieldSorts);
            siteConfineAreaVo.setParamId(param.getId());
        } else {
            SysParam param = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SETTING_FIELD_SETTING);
            phone = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SETTING_PHONE_VERIFCATION);
            mail = ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SETTING_MAIL_VERIFCATION);
            ArrayList<FieldSort> fieldSorts = JsonTool.fromJson(StringTool.isBlank(param.getParamValue()) ? param.getDefaultValue() : param.getParamValue(), new TypeReference<ArrayList<FieldSort>>() {
            });
            siteConfineAreaVo.setFieldSortList(fieldSorts);
            siteConfineAreaVo.setParamId(param.getId());

        }
        siteConfineAreaVo.setPhoneParam(phone);
        siteConfineAreaVo.setMailParam(mail);
        return siteConfineAreaVo;
    }

    /**
     * 加载服务条款设置
     *
     * @param siteConfineAreaVo
     * @param siteI18nListVo
     * @param model
     * @return
     */
    @RequestMapping({"/getServiceTerms"})
    public String getServiceTerms(SiteConfineAreaVo siteConfineAreaVo, SiteI18nListVo siteI18nListVo, Model model, SiteLanguageListVo siteLanguageListVo) {
        //代理
        if (StringTool.isNotBlank(siteConfineAreaVo.getType())) {
            siteConfineAreaVo.setPhoneParam(ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SERVICE_TERMS_SHOW_AGENT));
            siteConfineAreaVo.setMailParam(ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SERVICE_TERMS_FORCED_SHOW_AGENT));
            //服务条款相关语言内容
            siteConfineAreaVo.setSiteI18nMap(Cache.getSiteI18n(SiteI18nEnum.MASTER_SERVICE_TERMS_AGENT));
            model.addAttribute("service", SiteI18nEnum.MASTER_SERVICE_TERMS_AGENT);
        } else {
            siteConfineAreaVo.setPhoneParam(ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SERVICE_TERMS_SHOW));
            siteConfineAreaVo.setMailParam(ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SERVICE_TERMS_FORCED_SHOW));
            //服务条款相关语言内容
            siteConfineAreaVo.setSiteI18nMap(Cache.getSiteI18n(SiteI18nEnum.MASTER_SERVICE_TERMS));
            model.addAttribute("service", SiteI18nEnum.MASTER_SERVICE_TERMS);
        }
        siteLanguageListVo._setDataSourceId(SessionManager.getSiteParentId());
        siteLanguageListVo.getSearch().setSiteId(SessionManager.getSiteId());
        siteConfineAreaVo.setSiteLanguageList(ServiceTool.siteLanguageService().availableLanguage(siteLanguageListVo));
        siteConfineAreaVo.setValidateRule(JsRuleCreator.create(ServiceTermsForm.class, "result"));
        siteConfineAreaVo.getSearch().setSiteId(SessionManager.getSiteId());
        model.addAttribute("command", siteConfineAreaVo);
        return this.getViewBasePath() + "/regSetting/ServiceTerms";
    }

    /**
     * 保存服务条款
     *
     * @param siteConfineAreaVo
     * @return
     */
    @RequestMapping({"/saveServiceTrems"})
    @ResponseBody
    private Map saveServiceTrems(SiteConfineAreaVo siteConfineAreaVo, @FormModel("result") @Valid ServiceTermsForm form, BindingResult result, SiteI18nListVo siteI18nListVo) {
        if (result.hasErrors()) {
            Map map = new HashMap(2,1f);
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
            map.put("state", false);
            return map;
        }
        siteI18nListVo.setResult(siteConfineAreaVo.getSiteI18nList());
        siteI18nListVo._setDataSourceId(SessionManager.getSiteParentId());
        ServiceTool.siteI18nService().saveSiteI18n(siteI18nListVo);
        //刷新缓存
        Cache.refreshSiteI18n(SiteI18nEnum.MASTER_SERVICE_TERMS);
        Cache.refreshSiteI18n(SiteI18nEnum.MASTER_SERVICE_TERMS_AGENT);
        Cache.refreshCurrentSitePageCache();
        ServiceSiteTool.siteSysParamService().saveServiceTrems(siteConfineAreaVo);
        ParamTool.refresh(SiteParamEnum.SETTING_REG_SERVICE_TERMS_SHOW);
        ParamTool.refresh(SiteParamEnum.SETTING_REG_SERVICE_TERMS_SHOW_AGENT);
        return this.getVoMessage(siteConfineAreaVo);
    }

    /**
     * 分摊设置
     *
     * @param model
     * @return
     */
    @RequestMapping("/apportion")
    public String apportion(Model model) {
        ParamTool.refresh(SiteParamEnum.SETTING_APPORTIONSETTING_AGENT_RAKEBACK_PERCENT);
        ParamTool.refresh(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_RAKEBACK_PERCENT);
        SysParam p0 = ParamTool.getSysParam(SiteParamEnum.SETTING_APPORTIONSETTING_AGENT_RAKEBACK_PERCENT);
        SysParam p1 = ParamTool.getSysParam(SiteParamEnum.SETTING_APPORTIONSETTING_AGENT_PREFERENTIAL_PERCENT);
        SysParam p2 = ParamTool.getSysParam(SiteParamEnum.SETTING_APPORTIONSETTING_AGENT_POUNDAGE_PERCENT);
        SysParam p3 = ParamTool.getSysParam(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_RAKEBACK_PERCENT);
        SysParam p4 = ParamTool.getSysParam(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_PREFERENTIAL_PERCENT);
        SysParam p5 = ParamTool.getSysParam(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_POUNDAGE_PERCENT);
        SysParam p6 = ParamTool.getSysParam(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_REBATE_PERCENT);
        model.addAttribute("p0", p0);
        model.addAttribute("p1", p1);
        model.addAttribute("p2", p2);
        model.addAttribute("p3", p3);
        model.addAttribute("p4", p4);
        model.addAttribute("p5", p5);
        model.addAttribute("p6", p6);
        model.addAttribute("rule", JsRuleCreator.create(ApportionForm.class));
        return this.getViewBasePath() + "/apportion/Index";
    }

    /**
     * 保存分摊设置
     *
     * @param vo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping("/apportion/save")
    @ResponseBody
    public Map saveApportion(PayAccountVo vo, @FormModel() @Valid ApportionForm form, BindingResult result) {
        if (result.hasErrors()) {
            Map map = new HashMap(2,1f);
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
            map.put("state", false);
            return map;
        }
        vo = ServiceSiteTool.payAccountService().saveWarningSettings(vo);
        if (vo.isSuccess()) {
            ParamTool.refresh(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_REBATE_PERCENT);
        }
        return this.getVoMessage(vo);
    }

    /**
     * 加载推荐设置
     *
     * @param
     * @param
     * @param model
     * @return
     */
    @RequestMapping({"/getRecommended"})
    public String getRecommended(SiteConfineIpVo siteConfineIpVo, Model model, SiteI18nListVo siteI18nListVo, SiteLanguageListVo siteLanguageListVo) {
        siteConfineIpVo.setValidateRule(JsRuleCreator.create(RecommendedForm.class, "result"));
        refresh();
        SysParam audit = ParamTool.getSysParam(SiteParamEnum.SETTING_RECOMMENDED_AUDIT);
        SysParam reward = ParamTool.getSysParam(SiteParamEnum.SETTING_RECOMMENDED_REWARD);
        SysParam rewardMoney = ParamTool.getSysParam(SiteParamEnum.SETTING_RECOMMENDED_REWARD_MONEY);
        SysParam rewardTheway = ParamTool.getSysParam(SiteParamEnum.SETTING_RECOMMENDED_REWARD_THEWAY);
        SysParam bonusBonusMax = ParamTool.getSysParam(SiteParamEnum.SETTING_RECOMMENDED_BONUS_BONUSMAX);
        SysParam bonusTrading = ParamTool.getSysParam(SiteParamEnum.SETTING_RECOMMENDED_BONUS_TRADING);
        SysParam bonus = ParamTool.getSysParam(SiteParamEnum.SETTING_RECOMMENDED_BONUS);
        SysParam bonusAudit = ParamTool.getSysParam(SiteParamEnum.SETTING_RECOMMENDED_BONUS_AUDIT);
        SysParam bonusJson = ParamTool.getSysParam(SiteParamEnum.SETTING_RECOMMENDED_BONUS_JSON);

        ArrayList<GradientTemp> gradientTempArrayList = JsonTool.fromJson(bonusJson.getParamValue(), new TypeReference<ArrayList<GradientTemp>>() {
        });
        siteConfineIpVo.setBonusJsonId(bonusJson.getId());
        siteConfineIpVo.setAudit(audit);
        siteConfineIpVo.setBonusAudit(bonusAudit);
        siteConfineIpVo.setIsReward(reward);
        siteConfineIpVo.setRewardMoney(rewardMoney);
        siteConfineIpVo.setRewardTheWay(rewardTheway);
        siteConfineIpVo.setBonusBonusMax(bonusBonusMax);
        siteConfineIpVo.setBonusTrading(bonusTrading);
        siteConfineIpVo.setBonus(bonus);
        siteConfineIpVo.setGradientTempList(gradientTempArrayList);
        siteConfineIpVo.getSearch().setSiteId(SessionManager.getSiteId());
        //加载站长开通的语言
        siteLanguageListVo._setDataSourceId(SessionManager.getSiteParentId());
        siteLanguageListVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageListVo);
        siteConfineIpVo.setLanguageList(languageList);
        //加载推荐方式及内容
        siteConfineIpVo.setSiteI18nContentMap(Cache.getSiteI18n(SiteI18nEnum.MASTER_RECOMMEND_CONTENT));
        //活动规则
        siteConfineIpVo.setSiteI18nRuleMap(Cache.getSiteI18n(SiteI18nEnum.MASTER_RECOMMEND_RULE));
        model.addAttribute("content", SiteI18nEnum.MASTER_RECOMMEND_CONTENT);
        model.addAttribute("rule", SiteI18nEnum.MASTER_RECOMMEND_RULE);
        model.addAttribute("command", siteConfineIpVo);
        return this.getViewBasePath() + "/recommended/Edit";
    }

    /**
     * 更新推荐设置
     *
     * @param siteConfineIpVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping("/saveRecommended")
    @ResponseBody
    public Map saveRecommended(SiteConfineIpVo siteConfineIpVo, @FormModel @Valid RecommendedForm form, BindingResult result, SiteI18nListVo siteI18nListVo) {
        if (!result.hasErrors()) {
            ServiceSiteTool.siteSysParamService().batchUpdateRecommended(siteConfineIpVo);
            ParamTool.refresh(SiteParamEnum.SETTING_RECOMMENDED);
            //保存内容和规则
            List<SiteI18n> content = siteConfineIpVo.getSiteI18nContentList();
            List<SiteI18n> rule = siteConfineIpVo.getSiteI18nRuleList();
            content.addAll(rule);
            siteI18nListVo.setResult(content);
            ServiceTool.siteI18nService().saveSiteI18n(siteI18nListVo);
            Cache.refreshSiteI18n(SiteI18nEnum.MASTER_RECOMMEND, SessionManager.getSiteId().toString());
            Cache.refreshSiteI18n(SiteI18nEnum.MASTER_RECOMMEND_RULE, SessionManager.getSiteId().toString());
            return this.getVoMessage(siteConfineIpVo);
        }
        siteConfineIpVo.setSuccess(false);
        return this.getVoMessage(siteConfineIpVo);

    }

    private void refresh() {
        ParamTool.refresh(SiteParamEnum.SETTING_RECOMMENDED_AUDIT);
        Cache.refreshSiteI18n(SiteI18nEnum.MASTER_RECOMMEND);
    }

    public static SiteLanguageListVo transLangByLocale(SiteLanguageListVo vo, String locale) {
        if (CollectionTool.isNotEmpty(vo.getResult())) {
            for (int i = 0; i < vo.getResult().size(); i++) {
                vo.getResult().get(i).setTransLangByLocale(tranView("common", vo.getResult().get(i).getLanguage(), locale));
            }
        }
        return vo;
    }

    public static String tranView(String moduleCode, String i18nKey, String locale, Object... args) {
        String messagePattern = I18nTool.getLocalStr(i18nKey, moduleCode, "views", LocaleTool.getLocale(locale));
        if (ArrayTool.isNotEmpty(args)) {
            return MessageFormat.format(messagePattern, args);
        }
        return messagePattern;
    }

    @RequestMapping("/getDefaultServiceTerms")
    @ResponseBody
    public Map getDefaultServiceTerms(SiteI18nListVo siteI18nListVo) {
        Map result = new HashMap();
        if (siteI18nListVo == null || StringTool.isBlank(siteI18nListVo.getSearch().getLocale())) {
            result.put("state", "false");
            result.put("errMsg", "");
            return result;
        }
        Map<String, SiteI18n> siteI18n = Cache.getSiteI18n(SiteI18nEnum.MASTER_SERVICE_TERMS);
        if (StringTool.isNotBlank(siteI18nListVo.getType())) {
            siteI18n = Cache.getSiteI18n(SiteI18nEnum.MASTER_SERVICE_TERMS_AGENT);
        }
        Iterator<String> iter = siteI18n.keySet().iterator();
        while (iter.hasNext()) {
            String key = iter.next();
            if (siteI18nListVo.getSearch().getLocale().equals(key)) {
                SiteI18n serviceTerms = siteI18n.get(key);
                result.put("state", "true");
                result.put("serviceTerms", serviceTerms.getDefaultValue());
            }
        }
        return result;
    }

    /**
     * 手机端流量统计
     * @param sysParamVo
     * @return
     */
    @RequestMapping("/saveMobileTrafficStatistics")
    @ResponseBody
    public Map saveMobileTrafficStatistics(SysParamVo sysParamVo){
        Map map=new HashMap(2,1f);
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.SETTING_SYSTEM_SETTINGS_MOBILE_TRAFFIC_STATISTICS);
        if (sysParam!=null){
            sysParamVo.getResult().setId(sysParam.getId());
            sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE);
            ServiceTool.getSysParamService().updateOnly(sysParamVo);
        }else {
            sysParamVo.getResult().setRemark("手机端流量统计代码");
            sysParamVo.getResult().setModule(SiteParamEnum.SETTING_SYSTEM_SETTINGS_MOBILE_TRAFFIC_STATISTICS.getModule().getCode());
            sysParamVo.getResult().setParamType(SiteParamEnum.SETTING_SYSTEM_SETTINGS_MOBILE_TRAFFIC_STATISTICS.getType());
            sysParamVo.getResult().setParamCode(SiteParamEnum.SETTING_SYSTEM_SETTINGS_MOBILE_TRAFFIC_STATISTICS.getCode());
            sysParamVo.getResult().setActive(true);
            sysParamVo = ServiceTool.getSysParamService().insert(sysParamVo);
        }
        ParamTool.refresh(SiteParamEnum.SETTING_SYSTEM_SETTINGS_MOBILE_TRAFFIC_STATISTICS);
        if(sysParamVo.isSuccess()){
            map.put("ms" +
                    "g",LocaleTool.tranMessage("setting_auto","成功"));
            map.put("state",true);
        }else {
            map.put("msg",LocaleTool.tranMessage("setting_auto","失败"));
            map.put("state",false);
        }
        return map;
    }


    /*
    *
    * pc端联方式设置
    *
    * */
    @RequestMapping("/saveContactInformation")
    @ResponseBody
    public Map saveContactInformation(SysSiteVo sysSiteVo){
        Map map=new HashMap(2,1f);
        SysParamVo sysParamVo=new SysParamVo();
        sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE);
        SysParam[] sysParam = sysSiteVo.getSysParam();
      if (sysParam!=null){
          for (SysParam sysParam1:sysParam){
              sysParamVo.setResult(sysParam1);
              ServiceTool.getSysParamService().updateOnly(sysParamVo);
          }
          ParamTool.refresh(SiteParamEnum.CONNECTION_SETTING_PHONE_NUMBER);
          ParamTool.refresh(SiteParamEnum.CONNECTION_SETTING_E_MAIL);
          ParamTool.refresh(SiteParamEnum.CONNECTION_SETTING_QQ);
          ParamTool.refresh(SiteParamEnum.CONNECTION_SETTING_SKYPE);
          ParamTool.refresh(SiteParamEnum.CONNECTION_SETTING_COPYRIGHT_INFORMATION);
      }

        return map;
    }
    /*
    * 玩家中心弹窗开关
    *
    * */
    @RequestMapping("/updatesysParam")
    @ResponseBody
    public  Map updatesysParam(SysParamVo sysParamVo){
        HashMap map = new HashMap(2,1f);
        /*ParamTool.refresh(SiteParamEnum.SETTING_SYSTEM_SETTINGS_OPENPLAYER_STATISTICS);*/
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.SETTING_SYSTEM_SETTINGS_POPUP_SWITCH);
        if (sysParam!=null) {
            sysParamVo.getResult().setId(sysParam.getId());
            sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE);
            ServiceTool.getSysParamService().updateOnly(sysParamVo);
            ParamTool.refresh(SiteParamEnum.SETTING_SYSTEM_SETTINGS_POPUP_SWITCH);
        }
        return  map;
    }
    /*
      * 登录二维码显示开关
      *
      * */
    @RequestMapping("/updateQrSwitch")
    @ResponseBody
    public  Map updateQrSwitch(SysParamVo sysParamVo){
        HashMap map = new HashMap(2,1f);
        /*ParamTool.refresh(SiteParamEnum.SETTING_SYSTEM_SETTINGS_OPENPLAYER_STATISTICS);*/
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.LOGIN_QR_CODE_SWITCH);
        if (sysParam!=null) {
            sysParamVo.getResult().setId(sysParam.getId());
            sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE);
            ServiceTool.getSysParamService().updateOnly(sysParamVo);
            ParamTool.refresh(SiteParamEnum.LOGIN_QR_CODE_SWITCH);
        }
        return  map;
    }

    /*
    * 提示音设置开关
    *
    * */
    @RequestMapping("/updateTonesysParam")
    @ResponseBody
    public  Map updateTonesysParam(SysParamVo sysParamVo){
        HashMap map = new HashMap(2,1f);
        if(sysParamVo.getResult()==null){
            return  null;
        }
        sysParamVo.setProperties(SysParam.PROP_ACTIVE);
        ServiceTool.getSysParamService().updateOnly(sysParamVo);
        ParamTool.refresh(SiteParamEnum.WARMING_TONE_ONLINEPAY);
        ParamTool.refresh(SiteParamEnum.WARMING_TONE_DRAW);
        ParamTool.refresh(SiteParamEnum.WARMING_TONE_AUDIT);
        ParamTool.refresh(SiteParamEnum.WARMING_TONE_WARM);
        ParamTool.refresh(SiteParamEnum.WARMING_TONE_NOTICE);
        return  map;
    }
    //endregion your codes 3
}