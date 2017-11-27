package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.commons.dict.DictTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.ArrayTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.net.IpTool;
import org.soul.commons.support._Module;
import org.soul.model.log.audit.enums.OpType;
import org.soul.model.log.audit.vo.BaseLog;
import org.soul.model.log.audit.vo.LogVo;
import org.soul.model.sys.po.SysAuditLog;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.session.SessionManagerBase;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.company.site.ISiteConfineIpService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.SiteConfineIpForm;
import so.wwb.gamebox.mcenter.setting.form.SiteConfineIpSearchForm;
import so.wwb.gamebox.model.*;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.company.enums.SiteConfineIpTypeEnum;
import so.wwb.gamebox.model.company.site.po.SiteConfineIp;
import so.wwb.gamebox.model.company.site.vo.SiteConfineIpListVo;
import so.wwb.gamebox.model.company.site.vo.SiteConfineIpVo;
import so.wwb.gamebox.model.master.setting.enums.SiteConfineStatusEnum;
import so.wwb.gamebox.model.report.vo.AddLogVo;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.*;


/**
 * 限制/允许访问站点/管理中心的IP表控制器
 *
 * @author loong
 * @time 2015-8-11 11:18:00
 */
@Controller
//region your codes 1
@RequestMapping("/siteConfineIp")
public class SiteConfineIpController extends BaseCrudController<ISiteConfineIpService, SiteConfineIpListVo, SiteConfineIpVo, SiteConfineIpSearchForm, SiteConfineIpForm, SiteConfineIp, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/siteConfine/ip/";
        //endregion your codes 2
    }

    //region your codes 3

    @Override
    protected SiteConfineIpVo doEdit(SiteConfineIpVo objectVo, Model model) {
        objectVo=super.doEdit(objectVo, model);
        SiteConfineIp ip=objectVo.getResult();
        ip.setStartIpStr(IpTool.ipv4LongToString(ip.getStartIp()));
        ip.setEndIpStr(IpTool.ipv4LongToString(ip.getEndIp()));
        if("1".equals(ip.getTimeType())){
            ip.setEndTime(DateTool.addDays(new Date(),1));
        }
        objectVo.getResult().setNewDate(new Date());
        initLimitTimeType(model);
        objectVo.setDateList(ServiceTool.siteConfineAreaService().getDateList());

        return objectVo;
    }

    @Override
    protected SiteConfineIpListVo doList(SiteConfineIpListVo listVo, SiteConfineIpSearchForm form, BindingResult result, Model model) {
        if(listVo.getSysParam()!=null && listVo.getSysParam().getParamValue()!=null && listVo.getSysParam().getParamValue().equals("true")) {
            changeParamValue(listVo);
        }
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo = super.doList(listVo, form, result, model);
        for (SiteConfineIp area : listVo.getResult()) {
            if (area.getEndTime().getTime() > new Date().getTime()) {
                //使用中
                area.setStatus(SiteConfineStatusEnum.USING.getCode());
            } else {
                area.setStatus(SiteConfineStatusEnum.EXPIRED.getCode());
            }
        }
        listVo.setStatus(DictTool.get(DictEnum.SETTING_SITE_CONFINE_STATUS));
        SiteConfineIpListVo siteConfineIpListVo=new SiteConfineIpListVo();
        siteConfineIpListVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo.setTotal(this.getService().count(siteConfineIpListVo));
        listVo = getVisitSysParam(listVo);
        return listVo;
    }

    @Override
    protected SiteConfineIpVo doPersist(SiteConfineIpVo objectVo) {
        if(objectVo.getResult().getTimeType().equals("1")){
            objectVo.getResult().setEndTime(so.wwb.gamebox.model.common.Const.Platform_Forever_Date);
        }
        SiteConfineIp ip=objectVo.getResult();
        ip.setStartIp(IpTool.ipv4StringToLong(ip.getStartIpStr()));
        ip.setEndIp(IpTool.ipv4StringToLong(ip.getEndIpStr()));
        objectVo.getResult().setSiteId(SessionManagerBase.getSiteId());
        objectVo.getResult().setCreateUser(SessionManagerBase.getUserId());
        if (objectVo.isSuccess()) {
            objectVo.getResult().setCreateTime(new Date());
            if(ipContains(objectVo)){
                objectVo.setSuccess(false);
                return objectVo;
            }
            objectVo = super.doPersist(objectVo);
        }
        CacheBase.refreshSiteConfineIp();
        return objectVo;
    }
    @RequestMapping({"/ipContains"})
    @ResponseBody
    public boolean ipContains(SiteConfineIpVo objectVo){
        SiteConfineIp ip=objectVo.getResult();
        ip.setSiteId(SessionManager.getSiteId());
        int count = this.getService().ipContains(objectVo);
        return count>0;
    }
    @RequestMapping({"/batchDeleteArea"})
    @ResponseBody
    public Map batchDeleteArea(Integer[] ids) {
        SiteConfineIpListVo vo = new SiteConfineIpListVo();
        if (ArrayTool.isEmpty(ids)) {
            vo.setSuccess(false);
            return this.getVoMessage(vo);
        }
        vo.setPropertyValues(Arrays.asList(ids));
        this.getService().batchDelete(vo);
        if (vo.isSuccess() && StringTool.isBlank(vo.getOkMsg())) {
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "delete.success", new Object[0]));
        } else if (!vo.isSuccess() && StringTool.isBlank(vo.getErrMsg())) {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "delete.failed", new Object[0]));
        }
        CacheBase.refreshSiteConfineIp();
        return this.getVoMessage(vo);
    }

    @RequestMapping({"/selectIds"})
    @ResponseBody
    public Boolean selectIds(Integer[] ids) {
        SiteConfineIpListVo vo = new SiteConfineIpListVo();
        if (ArrayTool.isEmpty(ids)) {
            return null;
        }
        vo.setPropertyValues(Arrays.asList(ids));
        List<SiteConfineIp> list = this.getService().inSearchById(vo);
        for (SiteConfineIp area : list) {
            if (area.getEndTime().getTime() > new Date().getTime()) {
                //使用中
                return true;
            }
        }
        return false;

    }
    @RequestMapping({"/getSettingParam"})
    public String getSettingParam(SiteConfineIpListVo listVo,Model model,String type){
        listVo = getVisitSysParam(listVo);
        model.addAttribute("command", listVo);
        return "/setting/siteConfine/ip/Setting";
    }

    /**
     * 根据IP限制类型，获取系统参数的定义
     * @param listVo
     * @return
     */
    private SiteConfineIpListVo getVisitSysParam(SiteConfineIpListVo listVo){
        if (SiteConfineIpTypeEnum.SITE_ALLOW.getCode().equals(listVo.getType())) {
            listVo.setSysParam(ParamTool.getSysParam(SiteParamEnum.SETTING_VISIT_SITE_STATUS));
        } else  if (SiteConfineIpTypeEnum.CENTER_ALLOW.getCode().equals(listVo.getType())) {
            listVo.setSysParam(ParamTool.getSysParam(SiteParamEnum.SETTING_VISIT_MANAGEMENT_CENTER_STATUS));
        }
        return listVo;
    }
    @RequestMapping({"/changeParamValue"})
    @ResponseBody
    public Map changeParamValue(SiteConfineIpListVo listVo){
        SysParamVo sysParamVo = new SysParamVo();
        sysParamVo.setResult(listVo.getSysParam());
        sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE);
        ServiceTool.getSysParamService().updateOnly(sysParamVo);
        ParamTool.refresh(SiteParamEnum.SETTING_VISIT);
        return this.getVoMessage(listVo);
    }

    @Override
    protected SiteConfineIpVo doCreate(SiteConfineIpVo objectVo, Model model) {
        objectVo=super.doCreate(objectVo, model);
        objectVo.getResult().setType(objectVo.getType());
        objectVo.getResult().setNewDate(new Date());
        objectVo.getResult().setTimeType("1");
        objectVo.setDateList(ServiceTool.siteConfineAreaService().getDateList());
        initLimitTimeType(model);
        return objectVo;
    }

    private void initLimitTimeType(Model model) {
        Map<String,String> limitTypeMap = new HashMap<>();
        for(int i=1;i<=8;i++){
            String key = String.valueOf(i);
            String value = I18nTool.getLocalStr("siteConfine."+key, "setting", "dicts", CommonContext.get().getLocale());
            limitTypeMap.put(key,value);
        }
        model.addAttribute("limitTypeMap",limitTypeMap);
    }

    /**
     * 设置访问IP限制
     * @param objectVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping({"/persist"})
    @ResponseBody
    @Audit(module = Module.MASTER_SETTING, moduleType = ModuleType.CONFINE_IP_ADD, opType = OpType.CREATE)
    @Override
    public Map persist(SiteConfineIpVo objectVo, @FormModel("result") @Valid SiteConfineIpForm form, BindingResult result) {
        Map map;
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        //操作日志
        LogVo logVo = new LogVo();
        BaseLog baseLog = logVo.addBussLog();
        addLog(objectVo, request, logVo, baseLog);
        map = super.persist(objectVo,form,result);
        return map;
    }

    /**
     * 日志
     * @param objectVo
     * @param request
     * @param logVo
     * @param baseLog
     */
    private void addLog(SiteConfineIpVo objectVo, HttpServletRequest request, LogVo logVo, BaseLog baseLog) {
        List<String> list = new ArrayList<>();
        SiteConfineIp siteConfineIp=null;
        SiteConfineIpVo vo=new SiteConfineIpVo();
        if (objectVo.getResult().getId() != null){
            vo.getSearch().setId(objectVo.getResult().getId());
            vo = getService().get(vo);
            siteConfineIp=vo.getResult();
            baseLog.setDescription("setting.confine.edit");
            baseLog.setOpType(OpType.UPDATE);
        }else {
            baseLog.setDescription("setting.confine.add");
        }
        if(siteConfineIp!=null){
            list.add(siteConfineIp.getStartIpStr());
            list.add(siteConfineIp.getEndIpStr());
            list.add(siteConfineIp.getTimeType());
            list.add(DateTool.formatDate(objectVo.getResult().getEndTime(),CommonContext.getDateFormat().getDAY_SECOND()));
            list.add(siteConfineIp.getRemark());
        }
        list.add(objectVo.getResult().getStartIpStr());
        list.add(objectVo.getResult().getEndIpStr());
        list.add(objectVo.getResult().getTimeType());
        list.add(DateTool.formatDate(objectVo.getResult().getEndTime(),CommonContext.getDateFormat().getDAY_SECOND()));
        list.add(objectVo.getResult().getRemark());
        AddLogVo addLogVo = new AddLogVo();
        addLogVo.setResult(new SysAuditLog());
        addLogVo.setList(list);
        if(objectVo.getResult().getId()!=null){
            addLogVo.getResult().setEntityId(Long.valueOf(objectVo.getResult().getId()));
            addLogVo.getResult().setEntityUserId(vo._getOperator().getOperatorId());
            addLogVo.getResult().setEntityUsername(vo._getOperator().getOperator());
            baseLog.setEntityId(addLogVo.getResult().getEntityId());
            baseLog.setEntityUserId(addLogVo.getResult().getEntityUserId());
            baseLog.setEntityUsername(addLogVo.getResult().getEntityUsername());
        }
        for(String param:addLogVo.getList()){
            baseLog.addParam(param);
        }
        request.setAttribute(SysAuditLog.AUDIT_LOG, logVo);
    }


    //endregion your codes 3

}