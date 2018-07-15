package so.wwb.gamebox.mcenter.content.controller;

import org.soul.commons.collections.CollectionQueryTool;
import org.soul.commons.collections.ListTool;
import org.soul.commons.collections.MapTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.exception.SystemException;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.BooleanTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.commons.support._Module;
import org.soul.model.log.audit.enums.OpType;
import org.soul.model.security.privilege.po.SysUser;
import org.soul.model.security.privilege.vo.SysUserListVo;
import org.soul.model.sys.po.SysParam;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.company.sys.ISysDomainService;
import so.wwb.gamebox.mcenter.content.form.*;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.*;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.company.enums.DomainCheckStatusEnum;
import so.wwb.gamebox.model.company.enums.DomainPageUrlEnum;
import so.wwb.gamebox.model.company.enums.DomainPlatformEnum;
import so.wwb.gamebox.model.company.enums.ResolveStatusEnum;
import so.wwb.gamebox.model.company.sys.po.SysDomain;
import so.wwb.gamebox.model.company.sys.po.SysDomainCheck;
import so.wwb.gamebox.model.company.sys.so.SysDomainSo;
import so.wwb.gamebox.model.company.sys.vo.SysDomainCheckVo;
import so.wwb.gamebox.model.company.sys.vo.SysDomainListVo;
import so.wwb.gamebox.model.company.sys.vo.SysDomainVo;
import so.wwb.gamebox.model.company.sys.vo.SysSiteVo;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.player.po.VUserAgent;
import so.wwb.gamebox.model.master.player.vo.VUserAgentListVo;
import so.wwb.gamebox.model.master.player.vo.VUserAgentVo;
import so.wwb.gamebox.web.BussAuditLogTool;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.*;


/**
 * 站长域名表-修改完会替换 sys_domain控制器
 *
 * @author jeff
 * @time 2015-8-20 9:21:53
 */
@Controller
//region your codes 1
@RequestMapping("/content/sysDomain")
public class SysDomainController extends BaseCrudController<ISysDomainService, SysDomainListVo, SysDomainVo, SysDomainSearchForm, SysDomainForm, SysDomain, Integer> {

    private static final Log LOG = LogFactory.getLog(SysDomainController.class);

    //endregion your codes 1
    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/domain/";
        //endregion your codes 2
    }

    //region your codes 3

    //    private static final String RANKS = "/content/domain/ranks";
    private static final String SETTING = "/content/domain/Setting";
    private static final String SETTING_PART = "/content/domain/SettingPart";


    @Override
    protected SysDomainListVo doList(SysDomainListVo listVo, SysDomainSearchForm form, BindingResult result, Model model) {
        listVo.setSearch(createSearchObj(listVo.getSearch()));
        listVo = super.doList(listVo, form, result, model);
        Collection<SysParam> sysParams = ParamTool.getSysParams(BossParamEnum.CONTENT_DOMAIN_TYPE_INDEX);
        Collection<SysParam> sysParams1 = new ArrayList<>();
        for (SysParam sysParam : sysParams) {
            if (!"creditPay".equals(sysParam.getParamCode())) {
                sysParams1.add(sysParam);
            }
        }
        listVo.setDomainTypes(sysParams1);
        return listVo;
    }

    @Override
    protected SysDomainVo doSave(SysDomainVo sysDomainVo) {
        SysDomain sysDomain = sysDomainVo.getResult();
        if (DomainPageUrlEnum.AGENT.getCode().equals(sysDomainVo.getResult().getPageUrl())) {
            sysDomain.setSubsysCode(SubSysCodeEnum.MCENTER_AGENT.getCode());
        } else if (DomainPageUrlEnum.TOPAGENT.getCode().equals(sysDomainVo.getResult().getPageUrl())) {
            sysDomain.setSubsysCode(SubSysCodeEnum.MCENTER_TOP_AGENT.getCode());
        } else if (DomainPageUrlEnum.VIP.getCode().equals(sysDomainVo.getResult().getPageUrl())
                || DomainPageUrlEnum.INDEX.getCode().equals(sysDomainVo.getResult().getPageUrl())
                || DomainPageUrlEnum.DETECTION.getCode().equals(sysDomainVo.getResult().getPageUrl())) {
            sysDomain.setSubsysCode(SubSysCodeEnum.MSITES.getCode());
        } else {
            sysDomain.setSubsysCode(SubSysCodeEnum.MCENTER.getCode());
        }

        setDomainData(sysDomain);
        sysDomainVo = initSysDomainCheckData(sysDomainVo);
        sysDomainVo = getService().batchSaveDomain(sysDomainVo);
        Cache.refreshSiteDomain(sysDomain.getDomain());
        Cache.refreshCurrentSitePageCache();
        return sysDomainVo;
    }

    /**
     * 初始审核表数据
     *
     * @param sysDomainVo
     * @return
     */
    private SysDomainVo initSysDomainCheckData(SysDomainVo sysDomainVo) {
        sysDomainVo.setDomainPlatform(DomainPlatformEnum.SITE.getCode());
        String siteName = Cache.getSiteNameBySiteId(SessionManager.getSiteId());
        SysDomainCheck check = new SysDomainCheck();
        check.setPublishUserType(SessionManager.getUserType().getCode());
        check.setPublishUserId(SessionManager.getUserId());
        check.setPublishUserName(SessionManager.getUser().getUsername());
        check.setSiteId(SessionManager.getSiteId());
        check.setSiteName(siteName);
        check.setDomainPlatform(sysDomainVo.getDomainPlatform());
        sysDomainVo.setSysDomainCheck(check);
        return sysDomainVo;
    }

    /**
     * 初始数据
     *
     * @param sysDomain
     */
    private void setDomainData(SysDomain sysDomain) {
        sysDomain.setSiteId(SessionManager.getSiteId());
        sysDomain.setIsDeleted(false);
        sysDomain.setBuildIn(false);
        sysDomain.setResolveStatus(ResolveStatusEnum.TOBEBOUND.getCode());
        sysDomain.setIsTemp(false);
        sysDomain.setCode(UUID.randomUUID().toString().replace("-", ""));
        sysDomain.setIsEnable(true);
        sysDomain.setSysUserId(SessionManager.getSiteUserId());
        sysDomain.setSiteId(SessionManager.getSiteId());
        sysDomain.setCreateTime(new Date());
        sysDomain.setCreateUser(SessionManager.getUserId());
        sysDomain.setSubsysCode(sysDomain.getSubsysCode());
        sysDomain.setSysUserId(SessionManager.getSiteUserId());

    }

    @Override
    protected SysDomainVo doUpdate(SysDomainVo sysDomainVo) {
        sysDomainVo.getResult().setUpdateTime(new Date());
        sysDomainVo.getResult().setUpdateUser(SessionManager.getUserId());
        if (sysDomainVo.getResult().getForAgent() != null) {
            sysDomainVo.getResult().setForAgent(sysDomainVo.getResult().getForAgent() ? true : false);
        } else {
            sysDomainVo.getResult().setForAgent(false);
        }
        if (DomainPageUrlEnum.AGENT.getCode().equals(sysDomainVo.getResult().getPageUrl())) {
            sysDomainVo.getResult().setSubsysCode(SubSysCodeEnum.MCENTER_AGENT.getCode());
        } else if (DomainPageUrlEnum.TOPAGENT.getCode().equals(sysDomainVo.getResult().getPageUrl())) {
            sysDomainVo.getResult().setSubsysCode(SubSysCodeEnum.MCENTER_TOP_AGENT.getCode());
        } else {
            sysDomainVo.getResult().setSubsysCode(SubSysCodeEnum.MSITES.getCode());
        }

        ServiceTool.sysDomainService().updateSysDomain(sysDomainVo);
        //ServiceTool.cttDomainRankService().saveBySysDomain(sysDomainVo);
        //sysDomainVo.setProperties(SysDomain.PROP_NAME,SysDomain.PROP_PAGE_URL,SysDomain.PROP_UPDATE_TIME,SysDomain.PROP_UPDATE_USER);
        //this.getService().updateOnly(sysDomainVo);
        //sysDomainVo = super.doUpdate(sysDomainVo);
        Cache.refreshSiteDomain(sysDomainVo.getResult().getDomain());
        return sysDomainVo;
    }


    @Override
    @Token(generate = true)
    public String create(SysDomainVo objectVo, Model model, HttpServletRequest request, HttpServletResponse response) {


        return super.create(objectVo, model, request, response);
    }


    @Override
    protected SysDomainVo doCreate(SysDomainVo sysDomainVo, Model model) {
        // 增加token，防重复提交
        return createOrEdit(super.doCreate(sysDomainVo, model));
    }

    //    @Override
//    protected SysDomainVo doEdit(SysDomainVo sysDomainVo, Model model) {
//        sysDomainVo = createOrEdit(sysDomainVo);
//        return super.doEdit(sysDomainVo, model);
//    }
    @RequestMapping("/domainEdit")
    @Token(generate = true)
    public String domainEdit(Integer id, SysDomainVo sysDomainVo, Model model) {
        sysDomainVo.getSearch().setId(id);
        sysDomainVo = createOrEdit(sysDomainVo);
        sysDomainVo = super.doEdit(sysDomainVo, model);
        SysDomain domain = sysDomainVo.getResult();
        model.addAttribute("isDefault", false);
        if (domain.getResolveStatus().equals("2") && domain.getIsEnable()) {
            String indexUrl = ParamTool.getSysParam(BossParamEnum.CONTENT_DOMAIN_TYPE_INDEX).getParamValue();
            String manageUrl = ParamTool.getSysParam(BossParamEnum.CONTENT_DOMAIN_TYPE_MANAGER).getParamValue();
            if (domain.getPageUrl().equals(indexUrl) && domain.getIsForAllRank() || domain.getPageUrl().equals(manageUrl)) {
                model.addAttribute("isDefault", true);
            }
        }
        sysDomainVo.setValidateRule(JsRuleCreator.create(SysDomainForm.class));
        model.addAttribute("command", sysDomainVo);
        return this.getViewBasePath() + "/Edit";
    }

    @Override
    protected SysDomainVo doPersist(SysDomainVo objectVo) {
        //如果是默认，去除其他默认
        if (objectVo.getResult().getIsDefault() != null && objectVo.getResult().getIsDefault()) {
            this.getService().batchUpdateStatusToFalse(objectVo);
        }
        objectVo = super.doPersist(objectVo);
        return objectVo;
    }

    public SysDomainVo createOrEdit(SysDomainVo sysDomainVo) {
        Collection<SysParam> sysParams = ParamTool.getSysParams(BossParamEnum.CONTENT_DOMAIN_TYPE_INDEX);
        Collection<SysParam> sysParams1 = new ArrayList<>();
        for (SysParam sysParam : sysParams) {
            if (!"creditPay".equals(sysParam.getParamCode())) {
                sysParams1.add(sysParam);
            }
        }
        sysDomainVo.setDomainTypes(sysParams1);
//        sysDomainVo = ServiceTool.cttDomainRankService().getDomainRank(sysDomainVo);
//        sysDomainVo.setPlayerRanks(ServiceTool.playerRankService().queryUsableRankList(new PlayerRankVo()));
        LOG.debug("域名类型：{0}", JsonTool.toJson(sysDomainVo.getDomainTypes()));
        return sysDomainVo;
    }

//    @RequestMapping("/getRanks")
//    public String getRank(Model model, SysDomainVo sysDomainVo) {
//        List<Map<String, Object>> ranks = ServiceTool.cttDomainRankService().getRank(sysDomainVo);
//        model.addAttribute("ranks", ranks);
//        return RANKS;
//    }

//    @RequestMapping(value = "/resetRank")
//    @ResponseBody
//    public Map resetRank(SysDomainVo sysDomainVo) {
//        sysDomainVo = ServiceTool.cttDomainRankService().resetRank(sysDomainVo);
//        return getVoMessage(sysDomainVo);
//    }

    @RequestMapping("/delDomain")
    @ResponseBody
    @Audit(module = Module.MASTER_SETTING, moduleType = ModuleType.MASTER_SETTING_DEL_DOMAIN, opType = OpType.DELETE)
    public Map delDomain(SysDomainVo sysDomainVo) {
        sysDomainVo._setDataSourceId(SessionManager.getSiteParentId());
        if (this.getService().delDomain(sysDomainVo)) {
            sysDomainVo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_SUCCESS));
        } else {
            sysDomainVo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_FAILED));
        }
        if (sysDomainVo.isSuccess()) {
            BussAuditLogTool.addLog("DEL_DOMAIN", sysDomainVo.getResult().getDomain());
        }
        return getVoMessage(sysDomainVo);
    }

    /***
     * 修改域名状态
     *
     * @param sysDomainVo
     * @return
     */
    @RequestMapping("/changeResolveStatus")
    @ResponseBody
    @Audit(module = Module.MASTER_SETTING, moduleType = ModuleType.MASTER_SETTING_CHANGE_RESOLVE_STATUS, opType = OpType.UPDATE)
    public Map changeResolveStatus(SysDomainVo sysDomainVo) {
        //
        sysDomainVo._setDataSourceId(SessionManager.getSiteParentId());
        sysDomainVo.setProperties(SysDomain.PROP_RESOLVE_STATUS);
        sysDomainVo = this.getService().updateOnly(sysDomainVo);
        //修改状态之后，添加审核表
        //申请解绑
        if (ResolveStatusEnum.TOBETIEDUP.getCode().equals(sysDomainVo.getResult().getResolveStatus())) {
            insertDomainCheck(sysDomainVo);
        } else if (ResolveStatusEnum.SUCCESS.getCode().equals(sysDomainVo.getResult().getResolveStatus())) {
            //取消解绑
            ServiceTool.sysDomainCheckService().DelDomainCheck(sysDomainVo);
        }

        domainSaveMsg(sysDomainVo);
        Map<String, Object> map = new HashMap<>(2, 1f);
        if (sysDomainVo.isSuccess() && sysDomainVo.getResult().getResolveStatus().equals("5")) {
            sysDomainVo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_SUCCESS));

        } else if (!sysDomainVo.isSuccess() && StringTool.isBlank(sysDomainVo.getErrMsg())) {
            sysDomainVo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "operation.fail"));
        }
        CacheBase.refreshSiteDomain(sysDomainVo.getResult().getDomain());
        map.put("msg", StringTool.isNotBlank(sysDomainVo.getOkMsg()) ? sysDomainVo.getOkMsg() : sysDomainVo.getErrMsg());
        map.put("state", sysDomainVo.isSuccess());
        if (MapTool.getBoolean(map, "state")) {
            BussAuditLogTool.addLog("MASTER_SETTING_CHANGE_RESOLVE_STATUS", sysDomainVo.getResult().getDomain(),
                    ResolveStatusEnum.TOBETIEDUP.getCode().equals(sysDomainVo.getResult().getResolveStatus()) ? ResolveStatusEnum.TOBETIEDUP.getTrans() : "取消");
        }
        return map;
    }

//    @RequestMapping("/setting")
//    public String setting(Model model, SysDomainListVo sysDomainListVo) {
//        sysDomainListVo.getSearch().setIsForAllRank(true);
//        sysDomainListVo.getSearch().setIsDeleted(false);
//        sysDomainListVo.getSearch().setIsEnable(true);
//        sysDomainListVo.getSearch().setIsTemp(false);
//        sysDomainListVo.setSearch(createSearchObj(sysDomainListVo.getSearch()));
//        sysDomainListVo.setPaging(null);
//        sysDomainListVo = getService().search(sysDomainListVo);
//        sysDomainListVo.getSearch().setResolveStatus(ResolveStatusEnum.SUCCESS.getCode());
//        sysDomainListVo.setProperties(SysDomain.PROP_ID, SysDomain.PROP_IS_ENABLE, SysDomain.PROP_DOMAIN);
//        sysDomainListVo.setSomeDomain(getService().searchProperties(sysDomainListVo));
//
//        sysDomainListVo.setSysParam(ParamTool.getSysParam(SiteParamEnum.CONTENT_SETTINGS_DOMAIN));
//        //查出可用的域名
//        sysDomainListVo.getSearch().setIsForAllRank(false);
//        sysDomainListVo.setPaging(null);
//        SysDomainListVo search = getService().search(sysDomainListVo);
//
//
//        List list = CollectionQueryTool.queryProperty(search.getResult(), SysDomain.PROP_ID);
//        if(list!=null&&list.size()>0){
//            sysDomainListVo.setIds(list);
//        }else{
//            sysDomainListVo.setIds(null);
//        }
//
//        List domainList = ServiceTool.cttDomainRankService().getDomainRank(sysDomainListVo);
//        sysDomainListVo.setDomainRanks(domainList);
//        model.addAttribute("sysDomainListVo", sysDomainListVo);
//        return SETTING;
//    }

//    @RequestMapping("/getDomainByRank")
////    @ResponseBody
//    public String getDomainByRank(Model model, SysDomainListVo sysDomainListVo) {
//        // ids
//        sysDomainListVo = ServiceTool.cttDomainRankService().getDomainIdByRankId(sysDomainListVo);
//        sysDomainListVo.setSearch(createSearchObj(sysDomainListVo.getSearch()));
//        sysDomainListVo = getService().getDomainByIds(sysDomainListVo);
//
//
//        model.addAttribute("sysDomainListVo", sysDomainListVo);
//
//        return SETTING_PART;
//    }


    /**
     * 　共用的查询参数
     *
     * @param sysDomainSo
     * @return
     */
    public SysDomainSo createSearchObj(SysDomainSo sysDomainSo) {
        sysDomainSo.setIsDeleted(false);
        sysDomainSo.setSiteId(SessionManager.getSiteId());
        sysDomainSo.setIsDefault(false);
        sysDomainSo.setBuildIn(false);
        return sysDomainSo;
    }

    @RequestMapping("/changeStatus")
    @ResponseBody
    public Map changeStatus(SysDomainVo sysDomainVo) {
        sysDomainVo.setProperties(SysDomain.PROP_IS_ENABLE);
        sysDomainVo = getService().updateOnly(sysDomainVo);
        Cache.refreshSiteDomain(sysDomainVo.getResult().getDomain());
        Cache.refreshCurrentSitePageCache();
        return getVoMessage(sysDomainVo);
    }

    @RequestMapping({"/agentDomainList"})
    public String agentDomainList(SysDomainListVo listVo, @FormModel("search") @Valid SysDomainSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        String method = request.getMethod();
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        boolean pass = false;
        if ("GET".equals(method) && request.getParameterMap().isEmpty()) {
            pass = true;
        }

        if (!pass && result.hasErrors()) {
            return null;
        } else {
            listVo.getSearch().setType("23");//TODO:type
            listVo.getSearch().setIsDeleted(false);
            //如果search.agentUserName有值要查出用户Id
            String agentUserName = listVo.getSearch().getAgentUserName();
            if (StringTool.isNotBlank(agentUserName)) {
                VUserAgent vUserAgent = ServiceSiteTool.vUserAgentService().checkAgentInfo(new VUserAgentVo(), agentUserName);
                if (vUserAgent != null) {
                    listVo.getSearch().setAgentId(vUserAgent.getId());
                }
            }
            listVo = super.doList(listVo, form, result, model);
            if (listVo.getResult().size() > 0) {
                List<Integer> ids = CollectionQueryTool.queryProperty(listVo.getResult(), SysDomain.PROP_AGENT_ID);

                SysUserListVo sysUserListVo = new SysUserListVo();
                sysUserListVo.setPropertyName(SysUser.PROP_ID);
                sysUserListVo.setPropertyValues(ids);
                List<SysUser> list = ServiceTool.sysUserService().inSearch(sysUserListVo);
                //把集合遍历放进map
                Map<Integer, SysUser> sysUserMap = new HashMap<>();
                for (SysUser user : list) {
                    sysUserMap.put(user.getId(), user);
                }
                listVo.setUserAgentMap(sysUserMap);
            }
            listVo.setValidateRule(JsRuleCreator.create(SysDomainAgentForm.class));
            model.addAttribute("command", listVo);
            if (ServletTool.isAjaxSoulRequest(request)) {
                return "/content/domain/agent/IndexPartial";
            } else {
                return "/content/domain/agent/Index";
            }
        }
    }

    @RequestMapping({"/agentCreate"})
    @Token(generate = true)
    public String agentCreate(SysDomainVo objectVo, Model model, HttpServletRequest request, HttpServletResponse response) {
        objectVo = this.doCreate(objectVo, model);
        model.addAttribute("command", objectVo);
        if (ServletTool.isAjaxSoulRequest(request)) {
            return this.getViewBasePath() + "agent/AddPartial";
        } else {
            objectVo.setValidateRule(JsRuleCreator.create(SysDomainAgentForm.class));
            return this.getViewBasePath() + "agent/Add";
        }
    }

    @RequestMapping({"/queryDoMainAgentInfo"})
    @ResponseBody
    public String queryDoMainAgentInfo(String agentUserName) {
        VUserAgentListVo listVo = new VUserAgentListVo();
        listVo.getSearch().setUsername(agentUserName);
        listVo.getSearch().setUserType(UserTypeEnum.AGENT.getCode());
        VUserAgentListVo search = ServiceSiteTool.vUserAgentService().search(listVo);
        if (search.getResult() != null && search.getResult().size() > 0) {
            SysDomainListVo sysDomainListVo = new SysDomainListVo();
            sysDomainListVo.getSearch().setAgentId(search.getResult().get(0).getId());
            sysDomainListVo.getSearch().setType(UserTypeEnum.AGENT.getCode());
            sysDomainListVo.getSearch().setSiteId(SessionManager.getSiteId());
            return JsonTool.toJson(this.getService().search(sysDomainListVo).getResult());
        }
        return null;
    }

    /**
     * 验证该账号是否存在
     *
     * @param agentUserName
     * @return
     */
    @RequestMapping("/checkAgentUserName")
    @ResponseBody
    public String checkAgentUserName(@RequestParam("agentUserName") String agentUserName) {

        VUserAgentListVo listVo = new VUserAgentListVo();
        listVo.getSearch().setUsername(agentUserName);
        listVo.getSearch().setUserType(UserTypeEnum.AGENT.getCode());
        listVo.getSearch().setStatus("1");
        long count = ServiceSiteTool.vUserAgentService().count(listVo);
        return (count > 0) + "";
    }

    @RequestMapping("/checkDomain")
    @ResponseBody
    public String checkDomain(@RequestParam("result.domain") String domain, @RequestParam("result.id") Integer id) {

        return baseCheckDomain(domain, id);
    }

    @RequestMapping("/checkIndexDomain")
    @ResponseBody
    public String checkIndexDomain(@RequestParam("indexDomain") String domain, @RequestParam("result.id") Integer id) {

        return baseCheckDomain(domain, id);
    }

    @RequestMapping("/checkManagerDomain")
    @ResponseBody
    public String checkManagerDomain(@RequestParam("managerDomain") String domain, @RequestParam("result.id") Integer id) {

        return baseCheckDomain(domain, id);
    }

    private String baseCheckDomain(@RequestParam("result.domain") String domain, @RequestParam("result.id") Integer id) {
        SysDomainVo sysDomainVo = new SysDomainVo();
        sysDomainVo.getSearch().setDomain(domain);
        sysDomainVo.getSearch().setId(id);
        return this.getService().checkDomainExists(sysDomainVo);
    }

    @RequestMapping({"/addAgentDomain"})
    @ResponseBody
    public Map addAgentDomain(SysDomainVo sysDomainVo, @FormModel("result") @Valid SysDomainAgentForm form, BindingResult result) {
        if (!result.hasErrors()) {
            SysDomain sysDomain = sysDomainVo.getResult();
            sysDomain.setSubsysCode(SubSysCodeEnum.MSITES.getCode());
            sysDomain.setPageUrl(DomainPageUrlEnum.INDEX.getCode());
            setDomainData(sysDomain);
            //按账号查出该代理ID
            Integer agentId = getAgentId(sysDomainVo);
            if (agentId != null) {
                sysDomain.setAgentId(agentId);
                sysDomainVo.setResult(sysDomain);
                sysDomainVo = initSysDomainCheckData(sysDomainVo);
                sysDomainVo.setDomainPlatform(DomainPlatformEnum.AGENT.getCode());
                sysDomainVo.getSysDomainCheck().setDomainPlatform(DomainPlatformEnum.AGENT.getCode());
                sysDomainVo = this.getService().batchSaveDomain(sysDomainVo);
                sysDomainVo.getResult().setPageUrl(DomainPageUrlEnum.INDEX.getCode());
                this.domainSaveMsg(sysDomainVo);
            } else {
                sysDomainVo.setSuccess(false);
                sysDomainVo.setErrMsg(LocaleTool.tranMessage("content_auto", "找不到代理对象"));
            }
            return this.getVoMessage(sysDomainVo);
        }
        return null;
    }

    private Integer getAgentId(SysDomainVo sysDomainVo) {
        VUserAgentListVo listVo = new VUserAgentListVo();
        listVo.getSearch().setUsername(sysDomainVo.getAgentUserName());
        listVo.getSearch().setUserType(UserTypeEnum.AGENT.getCode());
        VUserAgentListVo vUserAgentListVo = ServiceSiteTool.vUserAgentService().search(listVo);
        if (vUserAgentListVo == null || vUserAgentListVo.getResult() == null || vUserAgentListVo.getResult().size() == 0) {
            return null;
        }
        return vUserAgentListVo.getResult().get(0).getId();
    }

    @RequestMapping({"/getAgentDomainEdit"})
    public String getAgentDomainEdit(SysDomainVo sysDomainVo, Integer id, Model model, VUserAgentVo vUserAgentVo) {
        if (id == null || StringTool.isBlank(id.toString())) {
            throw new SystemException("加载实体时id参数必须指定！");
        }
        sysDomainVo.getSearch().setId(id);
        sysDomainVo = this.getService().get(sysDomainVo);
        vUserAgentVo.getSearch().setId(sysDomainVo.getResult().getAgentId());
        String username = ServiceSiteTool.vUserAgentService().get(vUserAgentVo).getResult().getUsername();
        sysDomainVo.setAgentUserName(username);
        sysDomainVo.setValidateRule(JsRuleCreator.create(SysDomainAgentForm.class));
        model.addAttribute("command", sysDomainVo);
        return this.getViewBasePath() + "agent/Edit";
    }

    @RequestMapping({"/updateAgentDomain"})
    @ResponseBody
    @Token(valid = true)
    public Map updateAgentDomain(SysDomainVo sysDomainVo, @FormModel("result") @Valid SysDomainAgentForm form, BindingResult result) {
        Map map = new HashMap();
        try {
            List<String> properties = ListTool.newArrayList();
            properties.add(SysDomain.PROP_DOMAIN);
            properties.add(SysDomain.PROP_RESOLVE_STATUS);
            properties.add(SysDomain.PROP_IS_ENABLE);
            properties.add(SysDomain.PROP_UPDATE_TIME);
            properties.add(SysDomain.PROP_UPDATE_USER);
            sysDomainVo.setProperties(properties.toArray(new String[1]));
            SysDomain sysDomain = sysDomainVo.getResult();
            sysDomain.setResolveStatus(ResolveStatusEnum.TOBEBOUND.getCode());
            sysDomain.setIsEnable(false);
            sysDomain.setUpdateTime(new Date());
            sysDomain.setUpdateUser(SessionManager.getSiteUserId());

            sysDomainVo = this.getService().updateOnly(sysDomainVo);
            map = this.getVoMessage(sysDomainVo);
            if (!sysDomainVo.isSuccess()) {
                map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
            }
        } catch (Exception ex) {
            map.put("state", false);
            map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
            LogFactory.getLog(this.getClass()).error(ex, "修改代理域出错");
        }
        return map;
    }

//    @RequestMapping("/getRankByUserId")
//    public String getTagByUserId(VPlayerTagVo vPlayerTagVo, Model model, SysDomainListVo sysDomainListVo) {
//        List<VPlayerTag> vPlayerTags = ServiceSiteTool.vPlayerTagService().getDomainRankByUsers(vPlayerTagVo);
//        //查询全部层级的域名
//        sysDomainListVo.getSearch().setUserIds(vPlayerTagVo.getUserId());
//        sysDomainListVo.getSearch().setIsForAllRank(true);
//        sysDomainListVo = this.getService().search(sysDomainListVo);
//
//        for (VPlayerTag tag : vPlayerTags) {
//            tag.setPlayerCount(tag.getPlayerCount() + sysDomainListVo.getResult().size());
//        }
//
//        model.addAttribute("tags", vPlayerTags);
//        model.addAttribute("userLen", vPlayerTagVo.getUserId().size());
//        model.addAttribute("userIds", vPlayerTagVo.getUserId());
//        return this.getViewBasePath() + "/RankTags";
//    }

    /**
     * 未设主域名和管理中心 第一次提示去设置
     *
     * @return
     */
    @RequestMapping("/toIndexAndManager")
    public String indexPrompt(Model model, SysDomainListVo sysDomainListVo) {
        sysDomainListVo.getSearch().setSiteId(SessionManager.getSiteId());
        Date create = this.getService().getTempDate(sysDomainListVo);
        if (create != null) {
            create = DateTool.addDays(create, 15);
        } else {

        }
        model.addAttribute("create", create);
        return this.getViewBasePath() + "/mainManager/ToIndexAndManager";
    }

    /**
     * 第一次设置弹窗(管理中心和主域名)
     *
     * @param sysDomainVo
     * @param model
     * @return
     */
    @RequestMapping("/toSetting")
    public String toSetting(SysDomainVo sysDomainVo, Model model, SysDomainListVo sysDomainListVo) {
        sysDomainVo.setValidateRule(JsRuleCreator.create(SysDomainDefaultForm.class));
        sysDomainVo = this.createOrEdit(sysDomainVo);

        SysParam indexParam = ParamTool.getSysParam(BossParamEnum.CONTENT_DOMAIN_TYPE_INDEX);
        SysParam managerParam = ParamTool.getSysParam(BossParamEnum.CONTENT_DOMAIN_TYPE_MANAGER);
        if (indexParam != null) {
            sysDomainVo.setIndexPageUrl(indexParam.getParamValue());
        }
        if (managerParam != null) {
            sysDomainVo.setManagerPageUrl(managerParam.getParamValue());
        }
        sysDomainListVo.getSearch().setSiteId(SessionManager.getSiteId());
        Date create = this.getService().getTempDate(sysDomainListVo);
        if (create != null) {
            create = DateTool.addDays(create, 15);
        } else {
            create = new Date();
        }

        sysDomainVo.getSearch().setCreateTime(create);
        model.addAttribute("command", sysDomainVo);
        return this.getViewBasePath() + "/mainManager/Add";
    }

    /**
     * 第二个站点 设置主域名
     *
     * @return
     */
    @RequestMapping("/toIndex")
    public String toIndex(Model model, SysDomainListVo sysDomainListVo) {
        sysDomainListVo.getSearch().setSiteId(SessionManager.getSiteId());
        Date create = this.getService().getTempDate(sysDomainListVo);
        if (create != null)
            create = DateTool.addDays(create, 15);
        model.addAttribute("create", create);
        return this.getViewBasePath() + "/mainManager/ToIndex";
    }

    /**
     * 第二个站点设置弹窗(主域名)
     *
     * @param sysDomainVo
     * @param model
     * @return
     */
    @RequestMapping("/toMainDomainSetting")
    public String toMainDomainSetting(SysDomainVo sysDomainVo, Model model) {
        sysDomainVo.setValidateRule(JsRuleCreator.create(SysDomainIndexForm.class));
        sysDomainVo = this.createOrEdit(sysDomainVo);
        String indexUrl = ParamTool.getSysParam(BossParamEnum.CONTENT_DOMAIN_TYPE_INDEX).getParamValue();
        model.addAttribute("indexPageUrl", indexUrl);
        model.addAttribute("command", sysDomainVo);
        return this.getViewBasePath() + "/mainManager/IndexAdd";
    }

    /**
     * 保存首次添加主域名和管理中心域名
     *
     * @param sysDomainVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping({"/saveSiteDomain"})
    @ResponseBody
    public Map saveSiteDomain(SysDomainVo sysDomainVo, @FormModel("result") @Valid SysDomainDefaultForm form, BindingResult result) {
        if (!result.hasErrors()) {
            sysDomainVo.getSearch().setSiteId(CommonContext.get().getSiteId());
            sysDomainVo.setDomainPlatform(DomainPlatformEnum.SITE.getCode());
            SysDomain sysDomain = setDomainData(sysDomainVo);
            sysDomain.setSubsysCode(SubSysCodeEnum.MCENTER.getCode());
            sysDomainVo.setResult(sysDomain);
            sysDomainVo = initSysDomainCheckData(sysDomainVo);
            sysDomainVo.setSaveManageDomain(true);
            this.getService().saveSiteDomain(sysDomainVo);
            domainSaveMsg(sysDomainVo);
            Cache.refreshSiteDomain(sysDomainVo.getResult().getDomain());
            Cache.refreshCurrentSitePageCache();
            return this.getVoMessage(sysDomainVo);
        }
        return null;
    }

    private SysDomain setDomainData(SysDomainVo sysDomainVo) {
        SysDomain sysDomain = sysDomainVo.getResult();
        sysDomain.setSiteId(SessionManager.getSiteId());
        sysDomain.setIsDeleted(false);
        sysDomain.setResolveStatus(ResolveStatusEnum.TOBEBOUND.getCode());
        sysDomain.setIsEnable(true);
        sysDomain.setBuildIn(false);
        sysDomain.setIsTemp(false);
        sysDomain.setSysUserId(SessionManager.getSiteUserId());
        sysDomain.setSiteId(SessionManager.getSiteId());
        sysDomain.setCreateTime(new Date());
        sysDomain.setCreateUser(SessionManager.getUserId());
        sysDomain.setSysUserId(SessionManager.getSiteUserId());
        sysDomain.setIsDefault(true);

        return sysDomain;
    }

    /**
     * 保存首次添加主域名
     *
     * @param sysDomainVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping({"/saveIndexDomain"})
    @ResponseBody
    public Map saveIndexDomain(SysDomainVo sysDomainVo, @FormModel("result") @Valid SysDomainIndexForm form, BindingResult result) {
        if (!result.hasErrors()) {
            sysDomainVo.setDomainPlatform(DomainPlatformEnum.SITE.getCode());
            SysDomain sysDomain = setDomainData(sysDomainVo);
            sysDomain.setSubsysCode(SubSysCodeEnum.MSITES.getCode());
            sysDomainVo.setResult(sysDomain);

            sysDomainVo = initSysDomainCheckData(sysDomainVo);
            this.getService().saveSiteDomain(sysDomainVo);
            domainSaveMsg(sysDomainVo);
            Cache.refreshSiteDomain(sysDomainVo.getResult().getDomain());
            Cache.refreshCurrentSitePageCache();
            return this.getVoMessage(sysDomainVo);
        }
        return null;
    }

    private void insertDomainCheck(SysDomainVo sysDomainVo) {
        SysDomainCheckVo sysDomainCheckVo = new SysDomainCheckVo();
        SysDomainCheck sysDomainCheck = new SysDomainCheck();
        sysDomainCheck.setSiteId(SessionManager.getSiteId());
        sysDomainCheck.setSysDomainId(sysDomainVo.getResult().getId());
        sysDomainCheck.setContentType(sysDomainVo.getResult().getResolveStatus());
        sysDomainCheck.setPublishUserType(SessionManager.getUserType().getCode());
        sysDomainCheck.setPublishTime(new Date());
        sysDomainCheck.setDomain(sysDomainVo.getResult().getDomain());
        sysDomainCheck.setPublishUserId(SessionManager.getUserId());
        sysDomainCheck.setPublishUserName(SessionManager.getUser().getUsername());
        SysSiteVo sysSiteVo = new SysSiteVo();
        sysSiteVo.getSearch().setId(SessionManager.getSiteId());
        sysDomainCheck.setSiteName(ServiceTool.sysSiteService().get(sysSiteVo).getResult().getName());
        sysDomainCheck.setDomainPlatform(sysDomainVo.getDomainPlatform());
        sysDomainCheck.setCode(sysDomainVo.getResult().getCode());
        sysDomainCheck.setCheckStatus(DomainCheckStatusEnum.PENDING.getCode());
        sysDomainCheck.setAgentId(sysDomainVo.getResult().getAgentId());
        sysDomainCheckVo.setResult(sysDomainCheck);
        ServiceTool.sysDomainCheckService().insert(sysDomainCheckVo);
    }

    private void domainSaveMsg(SysDomainVo sysDomainVo) {
        if (sysDomainVo.isSuccess() && StringTool.isBlank(sysDomainVo.getOkMsg())) {
            if (sysDomainVo.getResult().getUpdateTime() == null && (ResolveStatusEnum.TOBEBOUND.getCode().equals(sysDomainVo.getResult().getResolveStatus())
                    || ResolveStatusEnum.TOBETIEDUP.getCode().equals(sysDomainVo.getResult().getResolveStatus()))) {
                if (sysDomainVo.getResult().getAgentId() != null) {
                    sysDomainVo.setOkMsg(LocaleTool.tranMessage("content", "sysdomain.agent.success"));
                } else {
                    sysDomainVo.setOkMsg(LocaleTool.tranMessage("content", "sysdomain.success"));
                }
            } else {
                sysDomainVo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_SUCCESS));
            }
        } else if (!sysDomainVo.isSuccess() && StringTool.isBlank(sysDomainVo.getErrMsg())) {
            sysDomainVo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "operation.fail"));
        }
    }

    /**
     * 只修改名称的编辑弹窗
     *
     * @param sysDomainVo
     * @param model
     * @return
     */
    @RequestMapping("/editName")
    public String EditName(SysDomainVo sysDomainVo, Model model) {
        sysDomainVo = doEdit(sysDomainVo, model);
        sysDomainVo.setValidateRule(JsRuleCreator.create(SysDomainMainManagerEditForm.class));
        sysDomainVo = createOrEdit(sysDomainVo);
        model.addAttribute("command", sysDomainVo);
        return this.getViewBasePath() + "/mainManager/EditName";
    }

    @RequestMapping({"/updateName"})
    @ResponseBody
    @Audit(module = Module.MASTER_SETTING, moduleType = ModuleType.MASTER_SETTING_UPDATE_DOMAIN, opType = OpType.UPDATE)
    public Map updateMainManager(SysDomainVo sysDomainVo, @FormModel("result") @Valid SysDomainMainManagerEditForm form, BindingResult result) {
        Map map = new HashMap();
        if (!result.hasErrors()) {
            if (DomainPageUrlEnum.INDEX.getCode().equals(sysDomainVo.getResult().getPageUrl()) || DomainPageUrlEnum.INDEXCNAME.getCode().equals(sysDomainVo.getResult().getPageUrl())) {
                sysDomainVo.setProperties(SysDomain.PROP_NAME, SysDomain.PROP_FOR_AGENT, SysDomain.PROP_UPDATE_USER, SysDomain.PROP_IS_DEFAULT);
            } else {
                sysDomainVo.setProperties(SysDomain.PROP_NAME, SysDomain.PROP_UPDATE_USER, SysDomain.PROP_IS_DEFAULT);
            }
            sysDomainVo.getResult().setUpdateUser(SessionManager.getUserId());
            this.getService().updateNameAndIsDefault(sysDomainVo);
            SysDomain result1 = sysDomainVo.getResult();
            BussAuditLogTool.addLog("UPDATE_DOMAIN", result1.getId().toString(), result1.getName(), BooleanTool.isTrue(result1.getIsDefault()) ? "是" : "否", BooleanTool.isTrue(result1.getForAgent()) ? "是" : "否");
            return this.getVoMessage(sysDomainVo);
        } else {
            map.put("state", false);
            map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
            return map;
        }
    }

    @RequestMapping({"/persistDomain"})
    @ResponseBody
    @Token(valid = true)
    @Audit(module = Module.MASTER_SETTING, moduleType = ModuleType.MASTER_SETTING_PERSIST_DOMAIN, opType = OpType.CREATE)
    public Map persistDomain(SysDomainVo objectVo, @FormModel("result") @Valid SysDomainForm form, BindingResult result) {
        Map map = new HashMap();
        if (!result.hasErrors()) {
            try {
                objectVo.getSearch().setIsEnable(false);
                objectVo = this.doPersist(objectVo);
                this.domainSaveMsg(objectVo);
                map = this.getVoMessage(objectVo);
                if (!objectVo.isSuccess()) {
                    map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
                }
            } catch (Exception ex) {
                map.put("state", false);
                map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
                LogFactory.getLog(this.getClass()).error(ex, "保存域名出错");
            }

        } else {
            map.put("state", false);
            map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
            return map;
        }
        if (MapTool.getBoolean(map, "state")) {
            SysDomain result1 = objectVo.getResult();
            if (result1 != null) {
                try {
                    BussAuditLogTool.addLog("PERSIST_DOMAIN", result1.getDomain(), result1.getName(), BooleanTool.isTrue(result1.getIsDefault()) ? "是" : "否", BooleanTool.isTrue(result1.getForAgent()) ? "是" : "否");
                } catch (Exception e) {
                    LOG.error(e);
                }
            }
        }
        return map;
    }
    //endregion your codes 3

}