package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.commons.dict.DictTool;
import org.soul.commons.dict.IDictEnum;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.ArrayTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.support._Module;
import org.soul.model.log.audit.enums.OpType;
import org.soul.model.log.audit.vo.BaseLog;
import org.soul.model.log.audit.vo.LogVo;
import org.soul.model.sys.po.SysAuditLog;
import org.soul.model.sys.po.SysDict;
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
import so.wwb.gamebox.iservice.company.site.ISiteConfineAreaService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.SiteConfineAreaForm;
import so.wwb.gamebox.mcenter.setting.form.SiteConfineAreaSearchForm;
import so.wwb.gamebox.model.CacheBase;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.ModuleType;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.company.site.po.SiteConfineArea;
import so.wwb.gamebox.model.company.site.vo.SiteConfineAreaListVo;
import so.wwb.gamebox.model.company.site.vo.SiteConfineAreaVo;
import so.wwb.gamebox.model.master.setting.enums.SiteConfineStatusEnum;
import so.wwb.gamebox.model.report.vo.AddLogVo;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.*;


/**
 * 限制访问站点的地区表控制器
 *
 * @author loong
 * @time 2015-8-11 11:17:30
 */
@Controller
//region your codes 1
@RequestMapping("/siteConfineArea")
public class SiteConfineAreaController extends BaseCrudController<ISiteConfineAreaService, SiteConfineAreaListVo, SiteConfineAreaVo, SiteConfineAreaSearchForm, SiteConfineAreaForm, SiteConfineArea, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/siteConfine/area/";
        //endregion your codes 2
    }

    //region your codes 3

    @Override
    protected SiteConfineAreaListVo doList(SiteConfineAreaListVo listVo, SiteConfineAreaSearchForm form, BindingResult result, Model model) {
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo = super.doList(listVo, form, result, model);
        for (SiteConfineArea area : listVo.getResult()) {
            if (area.getEndTime().getTime() > new Date().getTime()) {
                //使用中
                area.setStatus(SiteConfineStatusEnum.USING.getCode());
            } else {
                area.setStatus(SiteConfineStatusEnum.EXPIRED.getCode());
            }
        }
        DictTool.refresh(DictEnum.COMMON_CONSTELLATION);
        listVo.setStatus(DictTool.get(DictEnum.SETTING_SITE_CONFINE_STATUS));
        return listVo;
    }

    /**
     * 设置访问地区限制
     * @param objectVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping({"/persist"})
    @Audit(module = Module.MASTER_SETTING, moduleType = ModuleType.CONFINE_AREA_ADD, opType = OpType.CREATE)
    @ResponseBody
    public Map persist(SiteConfineAreaVo objectVo, @FormModel("result") @Valid  SiteConfineAreaForm form, BindingResult result) {
        HttpServletRequest request =((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        LogVo logVo=new LogVo();
        List<String> params = new ArrayList<>();
        BaseLog baseLog = logVo.addBussLog();
        addLog(objectVo, request, logVo, params, baseLog);
        Map persist = super.persist(objectVo, form, result);
        return persist;
    }

    /**
     * 日志
     * @param objectVo
     * @param request
     * @param logVo
     * @param params
     * @param baseLog
     */
    private void addLog(SiteConfineAreaVo objectVo, HttpServletRequest request, LogVo logVo, List<String> params, BaseLog baseLog) {
        SiteConfineArea siteConfineArea=null;
        SiteConfineAreaVo vo=new SiteConfineAreaVo();
        if(objectVo.getResult().getId()!=null){
            vo.getSearch().setId(objectVo.getResult().getId());
            vo = getService().get(vo);
            siteConfineArea = vo.getResult();
            baseLog.setDescription("setting.confine.area.edit");
            baseLog.setOpType(OpType.UPDATE);
        }
        else {
            baseLog.setDescription("setting.confine.area.add");
        }
        if(siteConfineArea!=null){
            String nation = LocaleTool.tranDict(DictEnum.REGION_REGION, siteConfineArea.getNation());
            String nationProvince=siteConfineArea.getNation()+"."+siteConfineArea.getProvince();
            String nationProvinceCity=siteConfineArea.getNation()+"_"+siteConfineArea.getProvince()+"."+siteConfineArea.getCity();
            String province = I18nTool.getLocalStr(nationProvince, DictEnum.REGION_STATE.getModule().getCode(), "dicts", CommonContext.get().getLocale());
            String city = I18nTool.getLocalStr(nationProvinceCity, DictEnum.REGION_CITY.getModule().getCode(), "dicts", CommonContext.get().getLocale());
            params.add(nation);
            params.add(province);
            params.add(city);
            params.add(siteConfineArea.getTimeType());
            params.add(DateTool.formatDate(siteConfineArea.getEndTime(),CommonContext.getDateFormat().getDAY_SECOND()));
            params.add(siteConfineArea.getRemark());
        }
        String nation = LocaleTool.tranDict(DictEnum.REGION_REGION, objectVo.getResult().getNation());
        String nationProvince=objectVo.getResult().getNation()+"."+objectVo.getResult().getProvince();
        String nationProvinceCity=objectVo.getResult().getNation()+"_"+objectVo.getResult().getProvince()+"."+objectVo.getResult().getCity();
        String province = I18nTool.getLocalStr(nationProvince, DictEnum.REGION_STATE.getModule().getCode(), "dicts", CommonContext.get().getLocale());
        String city = I18nTool.getLocalStr(nationProvinceCity, DictEnum.REGION_CITY.getModule().getCode(), "dicts", CommonContext.get().getLocale());
        params.add(nation);
        params.add(province);
        params.add(city);
        params.add(objectVo.getResult().getTimeType());
        if(Integer.valueOf(objectVo.getResult().getTimeType())==1){
            params.add(DateTool.formatDate(objectVo.getResult().getEndTime(),CommonContext.getDateFormat().getDAY_SECOND()));
        }else {
            params.add(DateTool.formatDate(objectVo.getResult().getEndTime(),CommonContext.getDateFormat().getDAY_SECOND()));
        }
        params.add(objectVo.getResult().getRemark());
        AddLogVo addLogVo = new AddLogVo();
        addLogVo.setResult(new SysAuditLog());
        addLogVo.setList(params);
        if(objectVo.getResult().getId()!=null){
            addLogVo.getResult().setEntityId(Long.valueOf(objectVo.getResult().getId()));
            addLogVo.getResult().setEntityUserId(vo._getOperator().getOperatorId());
            addLogVo.getResult().setEntityUsername(vo._getOperator().getOperator());
            baseLog.setEntityId(addLogVo.getResult().getEntityId());
            baseLog.setEntityUserId(addLogVo.getResult().getEntityUserId());
            baseLog.setEntityUsername(addLogVo.getResult().getEntityUsername());
        }
        for (String param : params){
            baseLog.addParam(param);
        }
        request.setAttribute(SysAuditLog.AUDIT_LOG, logVo);
    }

    @Override
    protected SiteConfineAreaVo doPersist(SiteConfineAreaVo objectVo) {
        SiteConfineArea area=objectVo.getResult();
        area.setNation(StringTool.isNotBlank(area.getNation())?area.getNation():null);
        area.setProvince(StringTool.isNotBlank(area.getProvince())?area.getProvince():null);
        area.setCity(StringTool.isNotBlank(area.getCity()) ? area.getCity() : null);
        if(area.getTimeType().equals("1")){
            area.setEndTime(so.wwb.gamebox.model.common.Const.Platform_Forever_Date);
        }
        area.setCreateUser(SessionManagerBase.getUserId());
        area.setCreateTime(new Date());
        area.setSiteId(SessionManager.getSiteId());
        //TODO　未验证 Mon Sep 28 08:34:26 UTC 2015
        objectVo = this.getService().isThereArea(objectVo);
        if (objectVo.isSuccess()) {

            objectVo=super.doPersist(objectVo);

            CacheBase.refreshSiteConfineArea();
            return objectVo;
        }
        return objectVo;
    }


    @RequestMapping({"/batchDeleteArea"})
    @ResponseBody
    public Map batchDeleteArea(Integer[] ids){
        SiteConfineAreaListVo vo = new SiteConfineAreaListVo();
        if(ArrayTool.isEmpty(ids)){
            vo.setSuccess(false);
            return this.getVoMessage(vo);
        }
        vo.setPropertyValues(Arrays.asList(ids));
        this.getService().batchDelete(vo);
        if(vo.isSuccess() && StringTool.isBlank(vo.getOkMsg())) {
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "delete.success"));
        } else if(!vo.isSuccess() && StringTool.isBlank(vo.getErrMsg())) {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "delete.failed"));
        }
        CacheBase.refreshSiteConfineArea();
        return this.getVoMessage(vo);
    }

    /**
     * 查找parentCode的相关字典
     *
     * @param codeEnum
     * @param parentCode
     * @return
     */
    public Map getChildDice(IDictEnum codeEnum, String parentCode) {
        DictTool.refresh(codeEnum);
        Map<String, SysDict> dictEnumMap = DictTool.get(codeEnum);
        Map<String, SysDict> valMap = new HashMap<>();
        if (parentCode != null) {
            for (String key : dictEnumMap.keySet()) {
                SysDict sysDict = dictEnumMap.get(key);

                if (sysDict.getParentCode().equals(parentCode)) {
                    valMap.put(key, sysDict);
                }
            }
        }else{
            valMap=dictEnumMap;
        }
        Map<String, String> i18nMap = I18nTool.getI18nMap(SessionManager.getLocale().toString()).get("dicts").get(codeEnum.getModule().getCode());
        Map<String, String> dictMap = new LinkedHashMap();
        Iterator it = valMap.keySet().iterator();
        while (it.hasNext()) {
            String key = it.next().toString();
            SysDict sysDict = valMap.get(key);
            dictMap.put(key, i18nMap.get(sysDict.getDictType().concat(".").concat(sysDict.getDictCode())));
        }
        return dictMap;
    }
    @RequestMapping({"/selectIds"})
    @ResponseBody
    public Boolean selectIds(Integer[] ids){
        SiteConfineAreaListVo vo = new SiteConfineAreaListVo();
        if(ArrayTool.isEmpty(ids)){
            return null;
        }vo.setPropertyValues(Arrays.asList(ids));
        List<SiteConfineArea> list=  this.getService().inSearchById(vo);
        for (SiteConfineArea area : list) {
            if (area.getEndTime().getTime() > new Date().getTime()) {
                //使用中
                return true;
            }
        }
        return false;

    }

    @Override
    protected SiteConfineAreaVo doCreate(SiteConfineAreaVo objectVo, Model model) {
        objectVo=super.doCreate(objectVo, model);
        objectVo.setDateList(this.getService().getDateList());
        objectVo.getResult().setNewDate(new Date());
        objectVo.getResult().setTimeType("1");
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

    @Override
    protected SiteConfineAreaVo doEdit(SiteConfineAreaVo objectVo, Model model) {
        objectVo=super.doEdit(objectVo, model);
        objectVo.setDateList(this.getService().getDateList());
        objectVo.getResult().setNewDate(new Date());
        if("1".equals(objectVo.getResult().getTimeType())){
            objectVo.getResult().setEndTime(DateTool.addDays(new Date(), 1));
        }
        initLimitTimeType(model);
        return objectVo;
    }
    //endregion your codes 3

}