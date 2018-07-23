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
import so.wwb.gamebox.iservice.company.site.ISiteApiI18nService;
import so.wwb.gamebox.mcenter.content.form.SiteApiI18nForm;
import so.wwb.gamebox.mcenter.content.form.SiteApiI18nSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.company.setting.po.ApiI18n;
import so.wwb.gamebox.model.company.site.po.SiteApi;
import so.wwb.gamebox.model.company.site.po.SiteApiI18n;
import so.wwb.gamebox.model.company.site.po.SiteApiTypeI18n;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.company.site.vo.SiteApiI18nListVo;
import so.wwb.gamebox.model.company.site.vo.SiteApiI18nVo;
import so.wwb.gamebox.model.company.site.vo.SiteLanguageListVo;
import so.wwb.gamebox.web.cache.CachePage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * site_api_i18n表控制器
 *
 * @author River
 * @time 2015-11-6 15:31:37
 */
@Controller
//region your codes 1
@RequestMapping("/siteApiI18n")
public class SiteApiI18nController extends BaseCrudController<ISiteApiI18nService, SiteApiI18nListVo, SiteApiI18nVo, SiteApiI18nSearchForm, SiteApiI18nForm, SiteApiI18n, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/gameManager/siteApi/";
        //endregion your codes 2
    }

    //region your codes 3

    @Override
    protected SiteApiI18nVo doEdit(SiteApiI18nVo objectVo, Model model) {
        SiteLanguageListVo siteLanguageListVo = new SiteLanguageListVo();
        siteLanguageListVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageListVo);//TODO 站长语言
        model.addAttribute("languageList",languageList);

        SiteApiI18nListVo siteApiI18nListVo = new SiteApiI18nListVo();
        siteApiI18nListVo.getSearch().setApiId(objectVo.getSearch().getApiId());
        siteApiI18nListVo.setPaging(null);
        siteApiI18nListVo.getSearch().setSiteId(SessionManager.getSiteId());
        siteApiI18nListVo = this.getService().search(siteApiI18nListVo);
        initSiteApiData(siteApiI18nListVo,languageList);
        //objectVo.setSiteApiListVo(siteApiI18nListVo);
        objectVo.setSiteApiI18ns(siteApiI18nListVo.getResult());

        Map<Object, SiteApiI18n> typeI18nMap= CollectionTool.toEntityMap(siteApiI18nListVo.getResult(), SiteApiTypeI18n.PROP_LOCAL);
        model.addAttribute("typeI18nMap", typeI18nMap);
        objectVo.setValidateRule(JsRuleCreator.create(SiteApiI18nForm.class));
        objectVo.getSearch().setSiteId(SessionManager.getSiteId());
        SiteApi api = this.getService().getSiteApiById(objectVo);
        if(api!=null){
            objectVo.setSiteApiStatus(api.getStatus());
        }
        return objectVo;
    }

    @Override
    protected SiteApiI18nVo doPersist(SiteApiI18nVo objectVo) {
        objectVo.getSearch().setSiteId(SessionManager.getSiteId());
        this.getService().updateSiteApi(objectVo);
        Cache.refreshSiteApiI18n();
        Cache.refreshSiteApi();
        Cache.refreshSiteApiTypeRelation();
        CachePage.refreshCurrentSitePageCache();
        return objectVo;
    }

    @RequestMapping(value = "/revertDefault",method = RequestMethod.POST )
    @ResponseBody
    public Map<String,ApiI18n> revertDefault(SiteApiI18nVo objectVo,Model model){
        Map<String,ApiI18n> apiTypeI18nMap = Cache.getApiI18n();
        Map<String,ApiI18n> result = new HashMap<String,ApiI18n>();
        if(apiTypeI18nMap!=null){
            ApiI18n i18n = apiTypeI18nMap.get(objectVo.getResult().getApiId().toString());
            result.put("i18n",i18n);
        }
        return result;
    }

    /**
     * 当还没有国际化时初始数据
     * @param siteApiI18nListVo
     * @param languageList
     */
    private void initSiteApiData(SiteApiI18nListVo siteApiI18nListVo,List<SiteLanguage> languageList){
        if(siteApiI18nListVo.getResult()==null||siteApiI18nListVo.getResult().size()==0){
            //一个国际化都没有时
            List<SiteApiI18n> result = new ArrayList<SiteApiI18n>();
            for (int i =0 ;i < languageList.size();i++){
                SiteLanguage lang = languageList.get(i);
                SiteApiI18n i18n = new SiteApiI18n();
                i18n.setLocal(lang.getLanguage());
                result.add(i18n);
            }
            siteApiI18nListVo.setResult(result);
        }else{
            //只有部分国际化时
            for (int j = 0 ;j < languageList.size(); j ++){
                SiteLanguage lang = languageList.get(j);
                boolean flag = false;
                for(int i =0;i<siteApiI18nListVo.getResult().size();i++){
                    SiteApiI18n i18n = siteApiI18nListVo.getResult().get(i);
                    if(lang.getLanguage().equals(i18n.getLocal())){
                        flag = true;
                    }
                }
                if(!flag){
                    SiteApiI18n i18n = new SiteApiI18n();
                    i18n.setLocal(lang.getLanguage());
                    siteApiI18nListVo.getResult().add(i18n);
                }

            }

        }
    }
    //endregion your codes 3

}
