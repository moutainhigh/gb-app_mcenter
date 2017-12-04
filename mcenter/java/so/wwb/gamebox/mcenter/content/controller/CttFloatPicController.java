package so.wwb.gamebox.mcenter.content.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.enums.EnumTool;
import org.soul.commons.lang.ArrayTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.support._Module;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.content.ICttFloatPicService;
import so.wwb.gamebox.mcenter.content.form.CttFloatPicForm;
import so.wwb.gamebox.mcenter.content.form.CttFloatPicSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.company.site.po.SiteCustomerService;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.company.site.vo.SiteCustomerServiceListVo;
import so.wwb.gamebox.model.company.site.vo.SiteLanguageListVo;
import so.wwb.gamebox.model.master.content.enums.CttFloatTemplateTypeEnums;
import so.wwb.gamebox.model.master.content.po.CttFloatPic;
import so.wwb.gamebox.model.master.content.po.CttFloatPicItem;
import so.wwb.gamebox.model.master.content.vo.CttFloatPicItemListVo;
import so.wwb.gamebox.model.master.content.vo.CttFloatPicListVo;
import so.wwb.gamebox.model.master.content.vo.CttFloatPicVo;
import so.wwb.gamebox.model.master.enums.FloatPicInteractivityEnum;
import so.wwb.gamebox.web.cache.Cache;

import java.io.Serializable;
import java.util.*;


/**
 * 内容管理-浮动图片表控制器
 *
 * @author cj
 * @time 2015-7-28 9:46:06
 */
@Controller
//region your codes 1
@RequestMapping("/cttFloatPic")
public class CttFloatPicController extends BaseCrudController<ICttFloatPicService, CttFloatPicListVo, CttFloatPicVo, CttFloatPicSearchForm, CttFloatPicForm, CttFloatPic, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/floatPic/";
        //endregion your codes 2
    }

    //region your codes 3


    @Override
    protected CttFloatPicListVo doList(CttFloatPicListVo listVo, CttFloatPicSearchForm form, BindingResult result, Model model) {
        SiteLanguageListVo siteLanguageListVo = new SiteLanguageListVo();
        siteLanguageListVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> siteLanguages = ServiceTool.siteLanguageService().availableLanguage(siteLanguageListVo);
        model.addAttribute("langs", siteLanguages);
        //因为调用doList的时候，listvo原因赋值的hasReturn会变为null，所以需重新赋值
        String hasReturn = listVo.getHasReturn();
        listVo = super.doList(listVo, form, result, model);
        listVo = previewFloatPic(listVo);
        listVo.setHasReturn(hasReturn);
        return listVo;
    }

    private CttFloatPicListVo previewFloatPic(CttFloatPicListVo listVo){
        if(listVo.getResult()==null){
            return listVo;
        }
        Map<Integer,List<CttFloatPicItem>> floatItemMap = new HashMap<>();
        for(CttFloatPic floatPic : listVo.getResult()){
            CttFloatPicItemListVo itemListVo = new CttFloatPicItemListVo();
            itemListVo.getSearch().setFloatPicId(floatPic.getId());
            itemListVo = ServiceTool.cttFloatPicItemService().search(itemListVo);
            floatItemMap.put(floatPic.getId(),itemListVo.getResult());
        }
        listVo.setFloatItemMap(floatItemMap);
        return listVo;
    }

    /**
     * 新增浮动图
     *
     * @param objectVo vo
     * @param model    modeal defaultImgPath
     * @return vo with some page info.
     */
    @Override
    protected CttFloatPicVo doCreate(CttFloatPicVo objectVo, Model model) {
        setBaseData(model);
        getCustomerService(model);
        Map map =new HashMap(2,1f);
        map.put("http://","http://");
        map.put("https://","https://");
        model.addAttribute("protocol",map);
        objectVo.setFloatPicItem(new CttFloatPicItem());
        objectVo.setItemList(new ArrayList<CttFloatPicItem>());

        objectVo = super.doCreate(objectVo, model);
        objectVo.getResult().setId(this.getService().getCttFloatPicId(objectVo));
        refreshFloatPicCache();
        return objectVo;
    }

    private void refreshFloatPicCache() {
        Cache.refreshFloatPic();
        Cache.refreshFloatPicItem();
        Cache.refreshCurrentSitePageCache();
    }

    @Override
    protected CttFloatPicVo doPersist(CttFloatPicVo objectVo) {
        //return super.doPersist(objectVo);
        objectVo = initFloatPicData(objectVo);
        objectVo = this.getService().saveOrUpdateFloatPic(objectVo);
        refreshFloatPicCache();
        return objectVo;
    }
    private CttFloatPicVo initFloatPicData(CttFloatPicVo objectVo){
        if(objectVo.getResult().getSingleMode()){
            String templateType = objectVo.getTemplateType();
            if(StringTool.isBlank(templateType)){
                objectVo.setSuccess(false);
                objectVo.setErrMsg(LocaleTool.tranMessage("content_auto","没有选择模板"));
                return objectVo;
            }


            objectVo.getResult().setTempId(Integer.valueOf(templateType));

            objectVo = setBaseField(objectVo);

            setCttFloatItem(objectVo, templateType);



        }else{
            objectVo = setBaseField(objectVo);
        }
        if("1".equals(objectVo.getResult().getDistanceType())){
            objectVo.getResult().setDistanceTop(objectVo.getResult().getDistanceValue());
            objectVo.getResult().setDistanceBottom(null);
        }else{
            objectVo.getResult().setDistanceBottom(objectVo.getResult().getDistanceValue());
            objectVo.getResult().setDistanceTop(null);
        }
        return objectVo;
    }

    private void setCttFloatItem(CttFloatPicVo objectVo, String templateType) {
        String typeDesc = CttFloatTemplateTypeEnums.getTemplateTypeDesc(templateType);
        CttFloatPicItem item = objectVo.getFloatPicItem();
        String normalEffect = CttFloatTemplateTypeEnums.NORMAL_EFFECT_PATH.replace("{0}",typeDesc);
        String mouseInEffect = CttFloatTemplateTypeEnums.MOUSE_IN_EFFECT_PATH.replace("{0}",typeDesc);
        item.setMouseInEffect(mouseInEffect);
        item.setNormalEffect(normalEffect);
        objectVo.setFloatPicItem(item);
    }

    private CttFloatPicVo setBaseField(CttFloatPicVo cttFloatPicVo){
        if("1".equals(cttFloatPicVo.getEditType())){
            cttFloatPicVo.getResult().setStatus(false);
            cttFloatPicVo.getResult().setCreateUser(SessionManager.getUserId());
            cttFloatPicVo.getResult().setCreateTime(new Date());
        }else if("2".equals(cttFloatPicVo.getEditType())){
            cttFloatPicVo.getResult().setUpdateTime(SessionManager.getDate().getNow());
            cttFloatPicVo.getResult().setUpdateUser(SessionManager.getUserId());
            cttFloatPicVo.setProperties(CttFloatPic.PROP_STATUS, CttFloatPic.PROP_CREATE_USER, CttFloatPic.PROP_CREATE_TIME,
                    CttFloatPic.PROP_PUBLISH_TIME);
            //return getService().updateExcludeProperties(cttFloatPicVo);
        }
        return cttFloatPicVo;
    }
    @RequestMapping({"/previewFloatPic"})
    public String previewFloatPic(CttFloatPicVo cttFloatPicVo,Model model){
        cttFloatPicVo = initFloatPicData(cttFloatPicVo);
        model.addAttribute("command",cttFloatPicVo);
        return getViewBasePath()+"PreviewFloatPic";
    }


    /**
     * 浮动图列表：显示/隐藏开关操作
     *
     * @param objectVo
     * @return
     */
    @RequestMapping(value = "/changeStatus", method = RequestMethod.POST)
    @ResponseBody
    public Map changeStatus(CttFloatPicVo objectVo) {
        final HashMap<Object, Object> map = new HashMap<>(2,1f);
        if (objectVo.getResult().getStatus()) {
            objectVo.getResult().setPublishTime(SessionManager.getDate().getNow());
        }
        Boolean success = getService().changeFloatPicStatus(objectVo);
        refreshFloatPicCache();
        map.put("state", success);
        return map;
    }

    /**
     * 删除前判断是否存在使用中的图片
     *
     * @param ids
     * @return true/false
     */
    @RequestMapping(value = "/exsitUsing", method = RequestMethod.POST)
    @ResponseBody
    public Boolean exsitUsing(Integer[] ids) {
        if (ArrayTool.isNotEmpty(ids)) {
            CttFloatPicVo vo = new CttFloatPicVo();
            vo.setIds(Arrays.asList(ids));
            List<CttFloatPic> list = getService().queryFloatPicByIdAndStatus(vo);
            if (CollectionTool.isEmpty(list)) {
                return false;
            }
            for (CttFloatPic pic : list) {
                if (pic.getStatus()) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * 批量删除
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/batchDelete", method = RequestMethod.POST)
    @ResponseBody
    public Map batchDelete(Integer[] ids) {
        Map<String, Object> map = new HashMap<>(2,1f);
        if (ArrayTool.isNotEmpty(ids)) {
            CttFloatPicVo vo = new CttFloatPicVo();
            vo.setIds(Arrays.asList(ids));
            boolean success = getService().batchDeleteFloatPic(vo);
            if (success) {
                map.put("okMsg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_SUCCESS));
                refreshFloatPicCache();
            } else {
                map.put("errMsg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_FAILED));
            }
            map.put("state", success);
        }
        return map;
    }

    /**
     * 去编辑
     * @param objectVo
     * @param model
     * @return
     */
    @Override
    protected CttFloatPicVo doEdit(CttFloatPicVo objectVo, Model model) {
        setBaseData(model);
        getCustomerService(model);
        Map map =new HashMap(2,1f);
        map.put("http://","http://");
        map.put("https://","https://");
        model.addAttribute("protocol",map);
        CttFloatPicVo floatPicVo = super.doEdit(objectVo, model);

        floatPicVo = getItemList(floatPicVo);
        floatPicVo.setEditType(objectVo.getEditType());
        floatPicVo = setDistance(floatPicVo);
        model.addAttribute("command",floatPicVo);
        return floatPicVo;
    }

    private CttFloatPicVo setDistance(CttFloatPicVo floatPicVo){
        if(floatPicVo.getResult()!=null){
            if(floatPicVo.getResult().getDistanceTop()!=null){
                floatPicVo.getResult().setDistanceType("1");
                floatPicVo.getResult().setDistanceValue(floatPicVo.getResult().getDistanceTop());
            }else if(floatPicVo.getResult().getDistanceBottom()!=null){
                floatPicVo.getResult().setDistanceType("2");
                floatPicVo.getResult().setDistanceValue(floatPicVo.getResult().getDistanceBottom());
            }
        }
        return floatPicVo;
    }

    private CttFloatPicVo getItemList(CttFloatPicVo floatPicVo) {
        CttFloatPicItemListVo itemListVo = new CttFloatPicItemListVo();
        itemListVo.getSearch().setFloatPicId(floatPicVo.getResult().getId());
        itemListVo = ServiceTool.cttFloatPicItemService().search(itemListVo);
        if(itemListVo.getResult()!=null&&itemListVo.getResult().size()>0){
            if(floatPicVo.getResult().getSingleMode()){
                floatPicVo.setFloatPicItem(itemListVo.getResult().get(0));
            }else{
                floatPicVo.setItemList(itemListVo.getResult());
            }
        }else{
            floatPicVo.setFloatPicItem(new CttFloatPicItem());
            floatPicVo.setItemList(new ArrayList<CttFloatPicItem>());
        }
        return floatPicVo;
    }

    private void getCustomerService(Model model) {
        SiteCustomerServiceListVo listVo = new SiteCustomerServiceListVo();
        listVo.setPaging(null);
        listVo.getSearch().setStatus(true);
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteCustomerService> SiteCustomerService = ServiceTool.siteCustomerServiceService().search(listVo).getResult();
        model.addAttribute("SiteCustomerService", SiteCustomerService);
    }

    private void setBaseData(Model model) {
        SiteLanguageListVo siteLanguageListVo = new SiteLanguageListVo();
        siteLanguageListVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> siteLanguages = ServiceTool.siteLanguageService().availableLanguage(siteLanguageListVo);
        model.addAttribute("langs", siteLanguages);
        Map<String, String> codeMap = EnumTool.getCodeMap(FloatPicInteractivityEnum.class);
        model.addAttribute("interactivityMaps", codeMap);
        Map<String, Serializable> linkTypeMaps = DictTool.get(DictEnum.FLOAT_PIC_LINK_TYPE);
        model.addAttribute("floatPicLinkTypeMaps", linkTypeMaps);
        LinkedHashMap<String, Serializable> displayInMaps = (LinkedHashMap<String, Serializable>) DictTool.get(DictEnum.FLOAT_PIC_DISPLAY_IN);
        displayInMaps.remove("2");
        model.addAttribute("floatPicDisplayInMaps", displayInMaps);
    }

    @RequestMapping("/isExitPromo")
    @ResponseBody
    public Map isExitPromo(Model model, CttFloatPicVo cttFloatPicVo){
        Map map = new HashMap(2, 1f);
        cttFloatPicVo.getSearch().setStatus(true);
        boolean b = this.getService().isExitPromo(cttFloatPicVo);
        map.put("isExitPromo", b);
        return map;
    }

    //endregion your codes 3

}