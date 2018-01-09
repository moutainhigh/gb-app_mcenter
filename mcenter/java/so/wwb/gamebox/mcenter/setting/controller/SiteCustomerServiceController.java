package so.wwb.gamebox.mcenter.setting.controller;

import org.apache.commons.collections.map.HashedMap;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.support._Module;
import org.soul.commons.validation.form.support.RegExpConstants;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.company.site.ISiteCustomerServiceService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.SiteCustomerServiceForm;
import so.wwb.gamebox.mcenter.setting.form.SiteCustomerServiceSearchForm;
import so.wwb.gamebox.mcenter.setting.form.SiteMobileCustomerServiceForm;
import so.wwb.gamebox.mcenter.setting.form.SitePCCustomerServiceForm;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.company.site.po.SiteCustomerService;
import so.wwb.gamebox.model.company.site.vo.SiteCustomerServiceListVo;
import so.wwb.gamebox.model.company.site.vo.SiteCustomerServiceVo;
import so.wwb.gamebox.model.company.sys.po.SysSite;
import so.wwb.gamebox.model.company.sys.vo.SysSiteVo;
import so.wwb.gamebox.model.master.content.po.VFloatPic;
import so.wwb.gamebox.model.master.content.vo.VFloatPicListVo;
import so.wwb.gamebox.model.master.enums.FloatPicLinkTypeEnum;
import so.wwb.gamebox.web.cache.Cache;

import javax.validation.Valid;
import java.util.*;
import java.util.regex.Pattern;


/**
 * 客服设置表控制器
 *
 * @author loong
 * @time 2015-8-12 16:25:57
 */
@Controller
//region your codes 1
@RequestMapping("/siteCustomerService")
public class SiteCustomerServiceController extends BaseCrudController<ISiteCustomerServiceService, SiteCustomerServiceListVo, SiteCustomerServiceVo, SiteCustomerServiceSearchForm, SiteCustomerServiceForm, SiteCustomerService, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/param/customerservice/";
        //endregion your codes 2
    }

    //region your codes 3
    @Override
    protected SiteCustomerServiceListVo doList(SiteCustomerServiceListVo listVo, SiteCustomerServiceSearchForm form, BindingResult result, Model model) {
        listVo.getSearch().setStatus(true);
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        findEnableImportPlayerParam(model);
        return this.getService().search(listVo);
    }
    /**
     * 查询是否可转站参数
     * @param model
     * @return
     */
    private void findEnableImportPlayerParam(Model model){
        /*SysParam enableParam = ParamTool.raw(SessionManager.getSiteParentId(), ParamEnum.MASTER_IMPORTPLAYER_ENABLE);
        if(enableParam!=null){
            model.addAttribute("isEnableImport",enableParam.getParamValue());
        }
        SysParam endTimeParam = ParamTool.raw(SessionManager.getSiteParentId(),ParamEnum.MASTER_IMPORTPLAYER_ENABLE_ENDTIME);
        if(endTimeParam!=null&&StringTool.isNotBlank(endTimeParam.getParamValue())){
            String endTime = endTimeParam.getParamValue();
            model.addAttribute("endImportTime",endTime);
        }*/
        SysSiteVo sysSiteVo = new SysSiteVo();
        sysSiteVo.getSearch().setId(SessionManager.getSiteId());
        SysSite sysSite = ServiceTool.sysSiteService().getSiteImport(sysSiteVo);
        if(sysSite!=null){
            model.addAttribute("isEnableImport","1");
            model.addAttribute("endImportTime",sysSite.getImportPlayersTime());
        }
    }
    @Override
    protected SiteCustomerServiceVo doCreate(SiteCustomerServiceVo objectVo, Model model) {
        objectVo.getSearch().setSiteId(SessionManager.getSiteId());
        String addCode = this.getService().findAddCode(objectVo);
        objectVo.setResult(new SiteCustomerService());
        objectVo.getResult().setCode(addCode);
        return objectVo;
    }
    @Override
    protected SiteCustomerServiceVo doSave(SiteCustomerServiceVo objectVo) {
        objectVo.getResult().setStatus(true);
        objectVo.getResult().setBuiltIn(false);
        objectVo.getResult().setSiteId(SessionManager.getSiteId());
        objectVo.getResult().setCreateUser(SessionManager.getUserId());
        objectVo.getResult().setCreateTime(new Date());
        SiteCustomerServiceListVo siteCustomerServiceListVo = new SiteCustomerServiceListVo();
        siteCustomerServiceListVo.getSearch().setCode(objectVo.getResult().getCode());
        siteCustomerServiceListVo.getSearch().setSiteId(SessionManager.getSiteId());
        long count = this.getService().count(siteCustomerServiceListVo);
        if(count>0){
            objectVo.setSuccess(false);
            objectVo.setErrMsg(LocaleTool.tranMessage("contacts", "customer.service.code"));
            return objectVo;
        }
        String url = objectVo.getResult().getParameter();
        if (!url.contains("http")) {
            objectVo.getResult().setParameter("http://" + url);
        }
        objectVo = this.getService().insert(objectVo);
        Cache.refreshCustomerService();
        Cache.refreshCurrentSitePageCache();
        return objectVo;
    }
    @Override
    protected SiteCustomerServiceVo doUpdate(SiteCustomerServiceVo objectVo) {
        objectVo.setProperties(SiteCustomerService.PROP_NAME, SiteCustomerService.PROP_PARAMETER);
        String url = objectVo.getResult().getParameter();
        if (!url.contains("http")) {
            objectVo.getResult().setParameter("http://" + url);
        }
        objectVo = this.getService().updateOnly(objectVo);
        Cache.refreshCustomerService();
        Cache.refreshCurrentSitePageCache();
        return objectVo;
    }

    /**
     * 删除验证
     * @param id
     * @return
     */
    @RequestMapping({"/validateDelete"})
    @ResponseBody
    public Map validateDelete(Integer id,SiteCustomerServiceVo siteCustomerServiceVo,SiteCustomerServiceListVo siteCustomerServiceListVo,VFloatPicListVo vFloatPicListVo){
        HashMap map = new HashMap(3,1f);
        siteCustomerServiceVo.getSearch().setId(id);
        Integer picCount=0;

        siteCustomerServiceVo = this.getService().get(siteCustomerServiceVo);
        if(siteCustomerServiceVo.getResult()==null){
            siteCustomerServiceVo.setSuccess(false);
        }else {


            /**
             * OK("0","OK"),
             * ONLY("1","在展示且为唯一展示"),
             * NO_ONLY("2","当不为唯一展示时"),
             * BLANK("3","前台也一个都没有展示时"),
             */
            siteCustomerServiceListVo.getSearch().setStatus(true);
            siteCustomerServiceListVo.getSearch().setSiteId(SessionManager.getSiteId());
            siteCustomerServiceListVo = this.getService().search(siteCustomerServiceListVo);
            List<String> ids =new ArrayList();
            for(SiteCustomerService i:siteCustomerServiceListVo.getResult()){
                ids.add(i.getId()+"");
            }

            vFloatPicListVo.getSearch().setIds(ids);
            vFloatPicListVo.getSearch().setImgLinkType(FloatPicLinkTypeEnum.CUSTOMER_SERVICE.getCode());
            vFloatPicListVo.getSearch().setImgLinkValue(id + "");
            //在线客服前端显示
            vFloatPicListVo = ServiceSiteTool.vFloatPicService().search(vFloatPicListVo);
            picCount=vFloatPicListVo.getResult().size();



            //BLANK("3","前台也一个都没有展示时"),
            for (VFloatPic pic:vFloatPicListVo.getResult()) {
                if (pic.getImgLinkValue().equals(id+"")) {
                    // * ONLY("1","在展示且为唯一展示"),
                    if(picCount==1){
                        siteCustomerServiceVo.setDelStatus("1");
                        break;
                    }else{
                        siteCustomerServiceVo.setDelStatus("2");
                        break;
                    }

                }
            }
        }
        map.put("msg", StringTool.isNotBlank(siteCustomerServiceVo.getOkMsg())?siteCustomerServiceVo.getOkMsg():siteCustomerServiceVo.getErrMsg());
        map.put("state", Boolean.valueOf(siteCustomerServiceVo.isSuccess()));
        map.put("delStatus", siteCustomerServiceVo.getDelStatus());
        return map;
    }
    /**
     *单个删除客服设置
     * @param id
     * @return
     */
    @RequestMapping({"/del"})
    @ResponseBody
    public Map del(Integer id,VFloatPicListVo vFloatPicListVo) {
        SiteCustomerServiceVo vo = new SiteCustomerServiceVo();
        vo.getSearch().setId(id);


        vo= this.getService().get(vo);
        if(vo.getResult()==null){
            vo.setSuccess(false);
        }else{
            vo.getResult().setStatus(false);
           this.getService().del(vo);
        }
        HashMap<String, String> map = new HashMap<>();
        vFloatPicListVo.getSearch().setImgLinkType(FloatPicLinkTypeEnum.CUSTOMER_SERVICE.getCode());
        vFloatPicListVo.getSearch().setImgLinkValue(id + "");
        //在线客服前端显示
        vFloatPicListVo = ServiceSiteTool.vFloatPicService().search(vFloatPicListVo);
       Integer picCount=vFloatPicListVo.getResult().size();
        if(picCount==0){
            //当前站点前端无客服咨询浮动窗口，建议立即去设置！
            map.put("state","toSetting");

        }
        Cache.refreshCustomerService();
        Cache.refreshCurrentSitePageCache();

        return map;
    }

    /**
     * 更新PC端客服参数
     *
     * @return
     */
    @RequestMapping("/pc")
    @ResponseBody
    public Map updatePCCustomerService(SiteCustomerServiceVo objectVo, @FormModel @Valid SitePCCustomerServiceForm form, BindingResult result) {
        Map<String,Object> map = new HashMap<>(2,1f);
        if (result.hasErrors()) {
            map.put("state",false);
            map.put("msg",LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
            return map;
        }

        objectVo.setProperties(SiteCustomerService.PROP_NAME, SiteCustomerService.PROP_PARAMETER);
        String url = objectVo.getPc().getParameter();
        StringBuilder newUrl =new StringBuilder(url);
        if (!url.contains("http")) {
            newUrl.insert(0,"http://");
        }
        boolean b = Pattern.compile(RegExpConstants.URL).matcher(newUrl.toString()).find();
        if(b){
            objectVo.setResult(new SiteCustomerService());
            objectVo.getResult().setParameter(newUrl.toString());
            objectVo.getResult().setId(objectVo.getPc().getId());
            objectVo.getResult().setName(objectVo.getPc().getName());
            objectVo = this.getService().updateOnly(objectVo);

            if (objectVo.isSuccess()) {
                map.put("state",true);
                map.put("msg",LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_SUCCESS));
                Cache.refreshCustomerService();
                Cache.refreshCurrentSitePageCache();
            } else {
                map.put("state",false);
                map.put("msg",LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
            }
        }else {
            map.put("state",false);
            map.put("msg",LocaleTool.tranMessage("setting_auto","输入的不是连接"));
        }
        return map;
    }

    /**
     * 更新Mobile端客服参数
     *
     * @return
     */
    @RequestMapping("/mobile")
    @ResponseBody
    public Map updateMobileCustomerService(SiteCustomerServiceVo objectVo, @FormModel @Valid SiteMobileCustomerServiceForm form, BindingResult result) {
        Map<String,Object> map = new HashMap<>(2,1f);
        if (result.hasErrors()) {
            map.put("state",false);
            map.put("msg",LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
            return map;
        }

        objectVo.setProperties(SiteCustomerService.PROP_NAME, SiteCustomerService.PROP_PARAMETER);
        String url = objectVo.getMobile().getParameter();
        StringBuilder newUrl = new StringBuilder(url);
        if (!url.contains("http")) {
            newUrl.insert(0,"http://");
        }
        boolean b = Pattern.compile(RegExpConstants.URL).matcher(newUrl.toString()).find();
        if (b){
            objectVo.setResult(new SiteCustomerService());
            objectVo.getResult().setParameter(newUrl.toString());
            objectVo.getResult().setId(objectVo.getMobile().getId());
            objectVo.getResult().setName(objectVo.getMobile().getName());
            objectVo = this.getService().updateOnly(objectVo);

            if (objectVo.isSuccess()) {
                map.put("state",true);
                map.put("msg",LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_SUCCESS));
                Cache.refreshCustomerService();
                Cache.refreshCurrentSitePageCache();
            } else {
                map.put("state",false);
                map.put("msg",LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
            }
        }else {
            map.put("state",false);
            map.put("msg",LocaleTool.tranMessage("setting_auto","输入的不是连接"));
        }
        return map;
    }

    /**
     * APP下载域名设置
     * @param sysParamVo
     * @param model
     * @return
     */
    @RequestMapping("/appDomain")
    @ResponseBody
    public Map updateAppDomainService(SysParamVo sysParamVo,Model model){

        Map map=new HashedMap();
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.SETTING_SYSTEM_SETTINGS_APP_DOMAIN);

        if(sysParam!=null){
            sysParamVo.getResult().setId(sysParam.getId());
            sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE);
            sysParamVo = ServiceTool.getSysParamService().updateOnly(sysParamVo);
        }else{
            sysParamVo.getResult().setRemark("APP下载域名设置");
            sysParamVo.getResult().setModule(SiteParamEnum.SETTING_SYSTEM_SETTINGS_APP_DOMAIN.getModule().getCode());
            sysParamVo.getResult().setParamType(SiteParamEnum.SETTING_SYSTEM_SETTINGS_APP_DOMAIN.getType());
            sysParamVo.getResult().setParamCode(SiteParamEnum.SETTING_SYSTEM_SETTINGS_APP_DOMAIN.getCode());
            sysParamVo.getResult().setActive(true);
            sysParamVo = ServiceTool.getSysParamService().insert(sysParamVo);
        }

        ParamTool.refresh(SiteParamEnum.SETTING_SYSTEM_SETTINGS_APP_DOMAIN);
        if(sysParamVo.isSuccess()){
            map.put("msg",LocaleTool.tranMessage("setting_auto","成功"));
            map.put("state",true);
        }else {
            map.put("msg",LocaleTool.tranMessage("setting_auto","失败"));
            map.put("state",false);
        }
        return map;
    }
    /**
     * APP下载域名设置
     * @param sysParamVo
     * @param model
     * @return
     */
    @RequestMapping("/accessDomain")
    @ResponseBody
    public Map settingAccessDomain(SysParamVo sysParamVo,Model model){

        Map map=new HashedMap();
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.SETTING_SYSTEM_SETTINGS_ACCESS_DOMAIN);

        if(sysParam!=null){
            sysParamVo.getResult().setId(sysParam.getId());
            sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE);
            sysParamVo = ServiceTool.getSysParamService().updateOnly(sysParamVo);
        }else{
            sysParamVo.getResult().setRemark("访问域名设置");
            sysParamVo.getResult().setModule(SiteParamEnum.SETTING_SYSTEM_SETTINGS_ACCESS_DOMAIN.getModule().getCode());
            sysParamVo.getResult().setParamType(SiteParamEnum.SETTING_SYSTEM_SETTINGS_ACCESS_DOMAIN.getType());
            sysParamVo.getResult().setParamCode(SiteParamEnum.SETTING_SYSTEM_SETTINGS_ACCESS_DOMAIN.getCode());
            sysParamVo.getResult().setActive(true);
            sysParamVo = ServiceTool.getSysParamService().insert(sysParamVo);
        }

        ParamTool.refresh(SiteParamEnum.SETTING_SYSTEM_SETTINGS_ACCESS_DOMAIN);
        if(sysParamVo.isSuccess()){
            map.put("msg",LocaleTool.tranMessage("setting_auto","成功"));
            map.put("state",true);
        }else {
            map.put("msg",LocaleTool.tranMessage("setting_auto","失败"));
            map.put("state",false);
        }
        return map;
    }
    //endregion your codes 3

}