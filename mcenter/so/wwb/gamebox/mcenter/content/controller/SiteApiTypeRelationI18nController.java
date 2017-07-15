package so.wwb.gamebox.mcenter.content.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.web.controller.BaseCrudController;
import org.springframework.ui.Model;
import so.wwb.gamebox.iservice.company.site.ISiteApiTypeRelationI18nService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.company.site.po.*;
import so.wwb.gamebox.model.company.site.vo.*;
import so.wwb.gamebox.mcenter.content.form.SiteApiTypeRelationI18nSearchForm;
import so.wwb.gamebox.mcenter.content.form.SiteApiTypeRelationI18nForm;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.web.cache.Cache;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


/**
 * site_api_type_relation_i18n控制器
 *
 * @author Administrator
 * @time 2016-6-14 11:37:28
 */
@Controller
//region your codes 1
@RequestMapping("/siteApiTypeRelationI18n")
public class SiteApiTypeRelationI18nController extends BaseCrudController<ISiteApiTypeRelationI18nService, SiteApiTypeRelationI18nListVo, SiteApiTypeRelationI18nVo, SiteApiTypeRelationI18nSearchForm, SiteApiTypeRelationI18nForm, SiteApiTypeRelationI18n, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/gameManager/siteApi/";
        //endregion your codes 2
    }

    //region your codes 3

    @Override
    protected SiteApiTypeRelationI18nVo doEdit(SiteApiTypeRelationI18nVo objectVo, Model model) {
        //objectVo = super.doEdit(objectVo,model);
        SiteLanguageListVo siteLanguageListVo = new SiteLanguageListVo();
        siteLanguageListVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageListVo);//TODO 站长语言
        model.addAttribute("languageList",languageList);

        objectVo = buildData(objectVo, languageList);

        objectVo = getSiteApi(objectVo);

        Map<Object, SiteApiTypeRelationI18n> typeI18nMap= CollectionTool.toEntityMap(objectVo.getRelationI18nList(), SiteApiTypeRelationI18n.PROP_LOCAL);
        model.addAttribute("typeI18nMap", typeI18nMap);

        return objectVo;
    }

    @Override
    protected SiteApiTypeRelationI18nVo doPersist(SiteApiTypeRelationI18nVo objectVo) {
        objectVo = this.getService().saveApiRelactionI18n(objectVo);
        Cache.refreshApiTypeRelationI18n();
        Cache.refreshApiTypeRelation();
        Cache.refreshSiteApiTypeRelation();
        Cache.refreshSiteApi();
        Cache.refreshCurrentSitePageCache();
        return objectVo;
    }

    private SiteApiTypeRelationI18nVo getSiteApi(SiteApiTypeRelationI18nVo objectVo) {
        SiteApiTypeRelationVo relationVo = new SiteApiTypeRelationVo();
        relationVo.getSearch().setId(objectVo.getSearch().getRelationId());
        relationVo = ServiceTool.siteApiTypeRelationService().get(relationVo);
        if(relationVo.getResult()!=null){
            VSiteApiVo siteApiVo = new VSiteApiVo();
            siteApiVo.getSearch().setApiId(relationVo.getResult().getApiId());
            siteApiVo.getSearch().setSiteId(relationVo.getResult().getSiteId());
            siteApiVo = ServiceTool.vSiteApiService().search(siteApiVo);
            objectVo.setSiteApi(siteApiVo.getResult());
        }
        return objectVo;
    }

    private SiteApiTypeRelationI18nVo buildData(SiteApiTypeRelationI18nVo objectVo, List<SiteLanguage> languageList) {

        SiteApiTypeRelationI18nListVo relationListVo = new SiteApiTypeRelationI18nListVo();
        relationListVo.getSearch().setRelationId(objectVo.getSearch().getRelationId());
        relationListVo = ServiceTool.siteApiTypeRelationI18nService().search(relationListVo);
        if(relationListVo.getResult()!=null&&relationListVo.getResult().size()>0){
            relationListVo = setLanguageData(objectVo, languageList, relationListVo);
            objectVo.setRelationI18nList(relationListVo.getResult());
        }else{

            SiteApiTypeRelation relation = getRelation(objectVo);
            List<SiteApiTypeRelationI18n> tempList = new ArrayList<>();
            for(SiteLanguage language : languageList){
                SiteApiTypeRelationI18n i18n = new SiteApiTypeRelationI18n();
                i18n.setLocal(language.getLanguage());
                i18n.setRelationId(objectVo.getSearch().getRelationId());
                i18n.setApiId(relation.getApiId());
                i18n.setApiTypeId(relation.getApiTypeId());
                i18n.setSiteId(relation.getSiteId());
                if(objectVo.getSiteApi().getApiId()!=null){
                    i18n.setName(Cache.getSiteApiName(objectVo.getSiteApi().getApiId().toString()));
                }
                tempList.add(i18n);
            }
            objectVo.setRelationI18nList(tempList);
        }
        return objectVo;
    }

    private SiteApiTypeRelationI18nListVo setLanguageData(SiteApiTypeRelationI18nVo objectVo, List<SiteLanguage> languageList, SiteApiTypeRelationI18nListVo relationListVo) {
        SiteApiTypeRelation relation = getRelation(objectVo);
        for(SiteLanguage language : languageList){
			boolean flag = false;
			for (SiteApiTypeRelationI18n i18n : relationListVo.getResult()){
				if(language.getLanguage().equals(i18n.getLocal())){
					flag = true;
				}
			}
			if(!flag){
				SiteApiTypeRelationI18n i18n = new SiteApiTypeRelationI18n();
				i18n.setLocal(language.getLanguage());
				i18n.setRelationId(objectVo.getSearch().getRelationId());
                i18n.setApiId(relation.getApiId());
                i18n.setApiTypeId(relation.getApiTypeId());
                i18n.setSiteId(relation.getSiteId());
				relationListVo.getResult().add(i18n);
			}
		}
        return relationListVo;
    }

    private SiteApiTypeRelation getRelation(SiteApiTypeRelationI18nVo objectVo){
        SiteApiTypeRelationVo relationVo = new SiteApiTypeRelationVo();
        relationVo.getSearch().setId(objectVo.getSearch().getRelationId());
        relationVo = ServiceTool.siteApiTypeRelationService().get(relationVo);
        return relationVo.getResult();
    }
    //endregion your codes 3

}