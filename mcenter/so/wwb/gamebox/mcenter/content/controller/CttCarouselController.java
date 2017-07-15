package so.wwb.gamebox.mcenter.content.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.model.sys.po.SysDict;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import so.wwb.gamebox.iservice.master.content.ICttCarouselService;
import so.wwb.gamebox.mcenter.content.form.CttCarouselForm;
import so.wwb.gamebox.mcenter.content.form.CttCarouselSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.company.setting.po.ApiTypeI18n;
import so.wwb.gamebox.model.company.site.po.SiteApi;
import so.wwb.gamebox.model.company.site.po.SiteApiTypeRelation;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.company.site.vo.SiteLanguageListVo;
import so.wwb.gamebox.model.master.content.po.CttCarousel;
import so.wwb.gamebox.model.master.content.po.CttCarouselI18n;
import so.wwb.gamebox.model.master.content.vo.CttCarouselListVo;
import so.wwb.gamebox.model.master.content.vo.CttCarouselVo;
import so.wwb.gamebox.model.master.enums.CarouselTypeEnum;
import so.wwb.gamebox.web.cache.Cache;

import javax.servlet.http.HttpServletRequest;
import java.util.*;


/**
 * 内容管理-轮播广告表控制器
 *
 * @author jeff
 * @time 2015-7-30 17:32:29
 */
@Controller
//region your codes 1
@RequestMapping("/content/cttCarousel")
public class CttCarouselController extends BaseCrudController<ICttCarouselService, CttCarouselListVo, CttCarouselVo, CttCarouselSearchForm, CttCarouselForm, CttCarousel, Integer> {

    private static final Log LOG = LogFactory.getLog(CttCarouselController.class);
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/carousel/";
        //endregion your codes 2
    }

    //region your codes 3
    private static final Integer TITLE_MAX_LENGTH = 50;

    @Override
    protected CttCarouselVo doEdit(CttCarouselVo objectVo, Model model) {
        objectVo = super.doEdit(objectVo,model);
        if(CarouselTypeEnum.CAROUSEL_TYPE_PLAYER_INDEX.getCode().equals(objectVo.getResult().getType())){
            String link = objectVo.getResult().getLink();
            if(StringTool.isNotBlank(link)){
                Map jsonMap = JsonTool.fromJson(link, Map.class);
                model.addAttribute("apiMap",jsonMap);
            }
        }
        objectVo.setValidateRule(JsRuleCreator.create(CttCarouselForm.class));
        objectVo =  setCarouselData(objectVo);
        buildCarouselData(objectVo);
        Map<Object, CttCarouselI18n> typeI18nMap= CollectionTool.toEntityMap(objectVo.getCttCarouselI18n(), CttCarouselI18n.PROP_LANGUAGE);
        model.addAttribute("typeI18nMap", typeI18nMap);
        return objectVo;
    }
    @Override
    protected CttCarouselVo doCreate(CttCarouselVo objectVo, Model model) {
        objectVo = super.doCreate(objectVo,model);
        objectVo.getSearch().setId(this.getService().getNextVal(objectVo));
        objectVo.setValidateRule(JsRuleCreator.create(CttCarouselForm.class));
        objectVo =  setCarouselData(objectVo);
        objectVo = loadCarouselI18nData(objectVo);
        Map<Object, CttCarouselI18n> typeI18nMap= CollectionTool.toEntityMap(objectVo.getCttCarouselI18n(), CttCarouselI18n.PROP_LANGUAGE);
        model.addAttribute("typeI18nMap", typeI18nMap);
        return objectVo;
    }

    @RequestMapping("/searchApiList")
    @ResponseBody
    public String searchApiList(){
        List<Map<String, String>> siteApi = getSiteApi();
        Map linkMap = new HashMap();
        linkMap.put("id","link");
        linkMap.put("apiName","链接");
        siteApi.add(linkMap);
        return JsonTool.toJson(siteApi);
    }
    @RequestMapping("/searchApiTypeList/{apiId}")
    @ResponseBody
    public String searchApiTypeList(@PathVariable("apiId") String apiId){
        if(StringTool.isBlank(apiId)||"link".equals(apiId)){
            return "";
        }
        try{
            Integer id = Integer.valueOf(apiId);
            List<Map<String, String>> apiTypeByApiId = getApiTypeByApiId(id);
            return JsonTool.toJson(apiTypeByApiId);
        }catch(Exception ex){
            LOG.error(ex,"获取API类型出错");
        }
        return "";
    }

    private List<Map<String,String>> getApiTypeByApiId(Integer apiId){
        Map<String, List<SiteApiTypeRelation>> siteApiTypeRelation = Cache.getSiteApiTypeRelation();
        Iterator<String> iter = siteApiTypeRelation.keySet().iterator();
        List<Map<String,String>> apiTypeList = new ArrayList<>();
        Map<String, ApiTypeI18n> apiTypeI18n = Cache.getApiTypeI18n();
        while (iter.hasNext()){
            String key = iter.next();
            List<SiteApiTypeRelation> relationList = siteApiTypeRelation.get(key);
            for(SiteApiTypeRelation relation : relationList){
                if(relation.getApiId().equals(apiId)){
                    Map<String,String> map = new HashMap<>();
                    String id = relation.getApiTypeId()+"";
                    ApiTypeI18n typeI18n = apiTypeI18n.get(id);
                    map.put("id",id);
                    map.put("apiTypeName",typeI18n.getName());
                    apiTypeList.add(map);
                }
            }
        }
        return apiTypeList;
    }

    private List<Map<String,String>> getSiteApi(){
        Map<String, SiteApi> siteApi = Cache.getSiteApi();
        Iterator<String> iter = siteApi.keySet().iterator();
        List<Map<String,String>> apiList = new ArrayList<>();
        while (iter.hasNext()){
            Map<String,String> map = new HashMap<>();
            String key = iter.next();
            String apiName = Cache.getApiName(key);
            map.put("id",key);
            map.put("apiName",apiName);
            apiList.add(map);
        }
        return apiList;
    }

    private CttCarouselVo loadCarouselI18nData(CttCarouselVo objectVo){
        if(objectVo.getCttCarouselI18n()==null||objectVo.getCttCarouselI18n().size()==0){
            List<CttCarouselI18n> i18nList = new ArrayList<>();
            List<SiteLanguage> languageList = objectVo.getSiteLanguages();
            if(languageList==null||languageList.size()==0){
                languageList = getSiteLanguages();
                objectVo.setSiteLanguages(languageList);
            }
            for(SiteLanguage lang : languageList){
                CttCarouselI18n i18n = new CttCarouselI18n();
                i18n.setLanguage(lang.getLanguage());
                i18nList.add(i18n);
            }
            objectVo.setCttCarouselI18n(i18nList);
        }
        return objectVo;
    }

    /**
     * 轮播图 停用启用
     * @param cttCarouselListVo
     * @return
     */
    @RequestMapping(value = "changeStatus",method = RequestMethod.POST)
    @ResponseBody
    public Boolean changeStopStatus(CttCarouselListVo cttCarouselListVo){
        Boolean success = ServiceTool.cttCarouselService().changeStopStatus(cttCarouselListVo);
        Cache.refreshSiteCarousel();
        Cache.refreshCurrentSitePageCache();
        return success;
    }

    /**
     * 批量删除
     * @param cttCarouselListVo
     * @return
     */
    @RequestMapping(value = "deleteByBatch")
    @ResponseBody
    public Boolean deleteByBatch(CttCarouselListVo cttCarouselListVo){
        Boolean success = ServiceTool.cttCarouselService().deleteBatch(cttCarouselListVo);
        Cache.refreshSiteCarousel();
        Cache.refreshCurrentSitePageCache();
        return success;
    }
    @RequestMapping(value = "/resetSort")
    @ResponseBody
    public Map resetSort(@RequestBody CttCarouselVo cttCarouselVo){
        cttCarouselVo = getService().resetCarouselSort(cttCarouselVo);
        ParamTool.refresh(SiteParamEnum.CONTENT_CAROUSEL_INTERVAL_TIME);
        Cache.refreshSiteCarousel();
        Cache.refreshCurrentSitePageCache();
        return getVoMessage(cttCarouselVo);
    }

    @Override
    protected CttCarouselVo doPersist(CttCarouselVo objectVo) {
        objectVo.getResult().setPublishTime(new Date());
        objectVo = super.doPersist(objectVo);
        Cache.refreshSiteCarousel();
        Cache.refreshCurrentSitePageCache();
        return objectVo;
    }

    @Override
    protected CttCarouselVo doUpdate(CttCarouselVo objectVo) {
        objectVo.getResult().setUpdateTime(new Date());
        objectVo.getResult().setUpdateUser(SessionManager.getUserId());
        objectVo = getService().updateCarousel(objectVo);
        return objectVo;
    }

    @Override
    protected CttCarouselVo doSave(CttCarouselVo objectVo) {
        if(objectVo.getSearch().getId() !=null && objectVo.getResult().getId() == null){
        objectVo.getResult().setCreateUser(SessionManager.getUserId());
        objectVo.getResult().setCreateTime(new Date());
            objectVo.getResult().setId(objectVo.getSearch().getId());
        }
        objectVo = getService().saveCarousel(objectVo);
        return objectVo;
    }

    /**
     * 判断开始时间 结束时间
     * @param request
     * @param startTime
     * @param endTime
     * @return
     */
    @RequestMapping("/checkTime")
    @ResponseBody
    public String checkTime(HttpServletRequest request,@RequestParam("result.startTime")Date startTime,@RequestParam("result.endTime")Date endTime){
        return startTime==null ||endTime == null|| startTime.getTime() >= endTime.getTime() ? "false" : "true";
    }

    public CttCarouselVo setCarouselData(CttCarouselVo cttCarouselVo){
        //TODO 放到缓存 从缓存获取
        List<SiteLanguage> languageList = getSiteLanguages();
        cttCarouselVo.setSiteLanguages(languageList);
        //广告管理类别
        Map<String, SysDict> types = DictTool.get(DictEnum.CONTENT_CAROUSEL_TYPE);
        cttCarouselVo.setTypes(types);
        return cttCarouselVo;
    }

    public List<SiteLanguage> getSiteLanguages() {
        SiteLanguageListVo siteLanguageVo = new SiteLanguageListVo();
        siteLanguageVo.getSearch().setSiteId(SessionManager.getSiteId());
        return ServiceTool.siteLanguageService().availableLanguage(siteLanguageVo);
    }

    private void buildCarouselData(CttCarouselVo cttCarouselVo){
        List<SiteLanguage> siteLanguages = cttCarouselVo.getSiteLanguages();
        List<CttCarouselI18n> cttCarouselI18n = cttCarouselVo.getCttCarouselI18n();
        if(siteLanguages==null||cttCarouselI18n==null){
            return;
        }
        for(SiteLanguage language : siteLanguages){
            boolean isExist = false;
            for(CttCarouselI18n carouselI18n : cttCarouselI18n){
                if(language.getLanguage().equals(carouselI18n.getLanguage())){
                    isExist = true;
                }
            }
            if(!isExist){
                CttCarouselI18n i18n = new CttCarouselI18n();
                i18n.setLanguage(language.getLanguage());
                i18n.setCarouselId(cttCarouselVo.getSearch().getId());
                cttCarouselI18n.add(i18n);
            }
        }
    }
    //endregion your codes 3

}