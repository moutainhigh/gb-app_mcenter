package so.wwb.gamebox.mcenter.content.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.cache.Cache;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.company.site.ISiteApiTypeI18nService;
import so.wwb.gamebox.mcenter.content.form.SiteApiTypeI18nForm;
import so.wwb.gamebox.mcenter.content.form.SiteApiTypeI18nSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.company.setting.po.ApiTypeI18n;
import so.wwb.gamebox.model.company.site.po.SiteApiTypeI18n;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.company.site.vo.SiteApiTypeI18nListVo;
import so.wwb.gamebox.model.company.site.vo.SiteApiTypeI18nVo;
import so.wwb.gamebox.model.company.site.vo.SiteApiTypeVo;
import so.wwb.gamebox.model.company.site.vo.SiteLanguageListVo;
import so.wwb.gamebox.web.init.ConfigBase;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * site_api_type_i18n控制器
 *
 * @author River
 * @time 2015-11-5 10:10:12
 */
@Controller
//region your codes 1
@RequestMapping("/siteApiTypeI18n")
public class SiteApiTypeI18nController extends BaseCrudController<ISiteApiTypeI18nService, SiteApiTypeI18nListVo, SiteApiTypeI18nVo, SiteApiTypeI18nSearchForm, SiteApiTypeI18nForm, SiteApiTypeI18n, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/gameManager/apiType/";
        //endregion your codes 2
    }

    //region your codes 3

    @Override
    protected SiteApiTypeI18nVo doEdit(SiteApiTypeI18nVo objectVo, Model model) {
        SiteLanguageListVo siteLanguageListVo = new SiteLanguageListVo();
        siteLanguageListVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageListVo);//TODO 站长语言
        model.addAttribute("languageList",languageList);

        SiteApiTypeI18nListVo siteApiTypeI18nListVo = new SiteApiTypeI18nListVo();
        siteApiTypeI18nListVo.getSearch().setApiTypeId(objectVo.getSearch().getApiTypeId());
        siteApiTypeI18nListVo.setPaging(null);
        siteApiTypeI18nListVo.getSearch().setSiteId(SessionManager.getSiteId());
        siteApiTypeI18nListVo = this.getService().search(siteApiTypeI18nListVo);
        initSiteApiTypeData(siteApiTypeI18nListVo,languageList);
        objectVo.setApiTypeI18ns(siteApiTypeI18nListVo.getResult());
        //objectVo.setSiteApiTypeI18nListVo(siteApiTypeI18nListVo);

        model.addAttribute("validateRule", JsRuleCreator.create(SiteApiTypeI18nForm.class));
        Map<Object, SiteApiTypeI18n> typeI18nMap= CollectionTool.toEntityMap(siteApiTypeI18nListVo.getResult(), SiteApiTypeI18n.PROP_LOCAL);
        model.addAttribute("typeI18nMap", typeI18nMap);

        SiteApiTypeVo siteApiTypeVo = new SiteApiTypeVo();
        siteApiTypeVo.getSearch().setApiTypeId(objectVo.getSearch().getApiTypeId());
        siteApiTypeVo.getSearch().setSiteId(SessionManager.getSiteId());
        siteApiTypeVo = ServiceTool.siteApiTypeService().search(siteApiTypeVo);
        if(siteApiTypeVo.getResult()!=null){
            objectVo.setApiTypeStatus(siteApiTypeVo.getResult().getStatus());
        }

        return objectVo;
    }
    @RequestMapping(value = "/revertDefault",method = RequestMethod.POST )
    @ResponseBody
    public Map<String,ApiTypeI18n> revertDefault(SiteApiTypeI18nVo objectVo,Model model){
        Map<String,ApiTypeI18n> apiTypeI18nMap = Cache.getApiTypeI18n();
        Map<String,ApiTypeI18n> result = new HashMap<String,ApiTypeI18n>();
        if(apiTypeI18nMap!=null){
            ApiTypeI18n i18n = apiTypeI18nMap.get(objectVo.getResult().getApiTypeId().toString());
            result.put("i18n",i18n);
        }
         return result;
    }

    @Override
    protected SiteApiTypeI18nVo doPersist(SiteApiTypeI18nVo objectVo) {
        objectVo.getSearch().setSiteId(SessionManager.getSiteId());
        this.getService().updateApiType(objectVo);
        Cache.refreshSiteApiTypeI18n();
        Cache.refreshSiteApiType();
        Cache.refreshSiteApiTypeRelation();
        Cache.refreshCurrentSitePageCache(ConfigBase.get().getPageKey());
        return objectVo;
    }

    private void initSiteApiTypeData(SiteApiTypeI18nListVo siteApiTypeI18nListVo,List<SiteLanguage> languageList){
        if(siteApiTypeI18nListVo.getResult()==null||siteApiTypeI18nListVo.getResult().size()==0){
            //一个国际化也没有时
            List<SiteApiTypeI18n> result = new ArrayList<SiteApiTypeI18n>();
            for (int i =0 ;i < languageList.size();i++){
                SiteLanguage lang = languageList.get(i);
                SiteApiTypeI18n i18n = new SiteApiTypeI18n();
                i18n.setLocal(lang.getLanguage());
                result.add(i18n);
            }
            siteApiTypeI18nListVo.setResult(result);
        }else{
            //只有部分国际化时
            for (int j = 0 ;j < languageList.size(); j ++){
                SiteLanguage lang = languageList.get(j);
                boolean flag = false;
                for(int i =0;i<siteApiTypeI18nListVo.getResult().size();i++){
                    SiteApiTypeI18n i18n = siteApiTypeI18nListVo.getResult().get(i);
                    if(lang.getLanguage().equals(i18n.getLocal())){
                        flag = true;
                    }
                }
                if(!flag){
                    SiteApiTypeI18n i18n = new SiteApiTypeI18n();
                    i18n.setLocal(lang.getLanguage());
                    siteApiTypeI18nListVo.getResult().add(i18n);
                }

            }

        }
    }
    //endregion your codes 3

}
