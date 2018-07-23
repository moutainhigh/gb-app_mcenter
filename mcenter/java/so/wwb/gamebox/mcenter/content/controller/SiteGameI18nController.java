package so.wwb.gamebox.mcenter.content.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.cache.Cache;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.company.site.ISiteGameI18nService;
import so.wwb.gamebox.mcenter.content.form.SiteGameI18nForm;
import so.wwb.gamebox.mcenter.content.form.SiteGameI18nSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.company.setting.po.GameI18n;
import so.wwb.gamebox.model.company.site.po.*;
import so.wwb.gamebox.model.company.site.vo.SiteGameI18nListVo;
import so.wwb.gamebox.model.company.site.vo.SiteGameI18nVo;
import so.wwb.gamebox.model.company.site.vo.SiteGameTagListVo;
import so.wwb.gamebox.model.company.site.vo.SiteLanguageListVo;
import so.wwb.gamebox.web.cache.CachePage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * site_game_i18n控制器
 *
 * @author River
 * @time 2015-11-9 16:29:24
 */
@Controller
//region your codes 1
@RequestMapping("/siteGameI18n")
public class SiteGameI18nController extends BaseCrudController<ISiteGameI18nService, SiteGameI18nListVo, SiteGameI18nVo, SiteGameI18nSearchForm, SiteGameI18nForm, SiteGameI18n, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/gameManager/siteGame/";
        //endregion your codes 2
    }

    //region your codes 3

    @Override
    protected SiteGameI18nVo doEdit(SiteGameI18nVo objectVo, Model model) {
        SiteLanguageListVo siteLanguageListVo = new SiteLanguageListVo();
        siteLanguageListVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageListVo);//TODO 站长语言
        model.addAttribute("languageList",languageList);
        if(objectVo.getSiteGameI18ns()==null){
            SiteGameI18nListVo siteGameI18nListVo = new SiteGameI18nListVo();
            siteGameI18nListVo.getSearch().setGameId(objectVo.getSearch().getGameId());
            siteGameI18nListVo.setPaging(null);
            siteGameI18nListVo.getSearch().setSiteId(SessionManager.getSiteId());
            siteGameI18nListVo = this.getService().search(siteGameI18nListVo);
            //如果没有设置国际化语言时初始化空数据
            initData(siteGameI18nListVo,languageList);
            objectVo.setSiteGameI18ns(siteGameI18nListVo.getResult());
        }

        //将国际化语言转成MAP
        Map<Object, SiteGameI18n> typeI18nMap= CollectionTool.toEntityMap(objectVo.getSiteGameI18ns(), SiteGameI18n.PROP_LOCAL);
        model.addAttribute("typeI18nMap", typeI18nMap);
        //查询站点游戏信息
        objectVo.getSearch().setSiteId(SessionManager.getSiteId());
        SiteGame siteGame = this.getService().getSiteGameById(objectVo);
        if(siteGame!=null){
            objectVo.setSiteGameVo(siteGame);
        }
        objectVo.setValidateRule(JsRuleCreator.create(SiteGameI18nForm.class));
        objectVo.setGameTagI18nList(getGameTagList(objectVo));
        return objectVo;
    }

    @Override
    protected SiteGameI18nVo doPersist(SiteGameI18nVo objectVo) {
        objectVo.getSearch().setSiteId(SessionManager.getSiteId());
        objectVo = this.getService().saveSiteGameI18n(objectVo);
        Cache.refreshSiteGameI18n();
        Cache.refreshSiteGame();
        Cache.refreshSiteGameTag();
        CachePage.refreshCurrentSitePageCache();
        return objectVo;
    }

    @RequestMapping(value = "/revertDefault",method = RequestMethod.POST )
    @ResponseBody
    public Map<String,GameI18n> revertDefault(SiteGameI18nVo objectVo,Model model){
        Map<String,GameI18n> apiTypeI18nMap = Cache.getGameI18n();
        Map<String,GameI18n> result = new HashMap<String,GameI18n>();
        if(apiTypeI18nMap!=null){
            GameI18n i18n = apiTypeI18nMap.get(objectVo.getResult().getGameId().toString());
            result.put("i18n",i18n);
        }
        return result;
    }

    /**
     * 如果国际化不全时补全 d
     * @param siteGameI18nListVo
     * @param languageList
     */
    private void initData(SiteGameI18nListVo siteGameI18nListVo,List<SiteLanguage> languageList){
        if(siteGameI18nListVo.getResult()==null||siteGameI18nListVo.getResult().size()==0){
            //一个国际化也没有时
            List<SiteGameI18n> tempList = new ArrayList<SiteGameI18n>();
            for (int i=0;i<languageList.size();i++ ){
                SiteLanguage lang = languageList.get(i);
                SiteGameI18n i18n = new SiteGameI18n();
                i18n.setLocal(lang.getLanguage());
                i18n.setGameId(siteGameI18nListVo.getSearch().getGameId());
                tempList.add(i18n);
            }
            siteGameI18nListVo.setResult(tempList);
        }else {
            //只有部分国际化时
            newSiteGame(siteGameI18nListVo, languageList);
        }
    }

    private void newSiteGame(SiteGameI18nListVo siteGameI18nListVo, List<SiteLanguage> languageList) {
        for (int j = 0; j < languageList.size(); j++) {
            SiteLanguage lang = languageList.get(j);
            boolean flag = false;
            for (int i = 0; i < siteGameI18nListVo.getResult().size(); i++) {
                SiteGameI18n i18n = siteGameI18nListVo.getResult().get(i);
                if (lang.getLanguage().equals(i18n.getLocal())) {
                    flag = true;
                }
            }
            if (!flag) {
                SiteGameI18n i18n = new SiteGameI18n();
                i18n.setLocal(lang.getLanguage());
                i18n.setGameId(siteGameI18nListVo.getSearch().getGameId());
                siteGameI18nListVo.getResult().add(i18n);
            }

        }
    }

    private List<SiteGameTag> getSiteGameTag(SiteGameI18nVo objectVo){
        SiteGameTagListVo siteGameTagListVo = new SiteGameTagListVo();
        siteGameTagListVo.getSearch().setGameId(objectVo.getSearch().getGameId());
        siteGameTagListVo.getSearch().setSiteId(SessionManager.getSiteId());
        siteGameTagListVo.setPaging(null);
        siteGameTagListVo = ServiceTool.siteGameTagService().search(siteGameTagListVo);
        return siteGameTagListVo.getResult();
    }

    /**/
    private List<Map<String,Object>> getGameTagList(SiteGameI18nVo objectVo) {
        /**
         * Cache.getSiteI18n(SiteI18nEnum.MASTER_GAME_TAG);
         * 修改为：
         * Cache.getGameTag();
         * 默认游戏分类，新游戏，热门游戏分类，不属于站点分类，这里做特殊处理
         */
        Map<String, SiteI18n> siteI18nMap = Cache.getGameTag();
        List<Map<String,Object>> siteI18ns = new ArrayList<>();
        String language = SessionManager.getLocale().toString();
        for (String siteI18nMapKey : siteI18nMap.keySet()) {
            String[] key = StringTool.split(siteI18nMapKey, ":");
            if (language.equals(key[1])) {
                Map<String,Object> dataMap = new HashMap<>();
                SiteI18n gameTagI18n = siteI18nMap.get(siteI18nMapKey);
                dataMap.put("gameTagI18n",gameTagI18n);
                dataMap.put("isCheck",isCheckGameTag(objectVo,gameTagI18n));
                siteI18ns.add(dataMap);
            }
        }
        return siteI18ns;

    }

    private boolean isCheckGameTag(SiteGameI18nVo objectVo,SiteI18n gameTagI18n){
        List<SiteGameTag> tagList = getSiteGameTag(objectVo);
        if(tagList==null||tagList.size()==0){
            return false;
        }
        boolean isCheck = false;
        for(SiteGameTag gameTag : tagList){
            if(StringTool.isNotBlank(gameTagI18n.getKey())&&gameTagI18n.getKey().equals(gameTag.getTagId())){
                isCheck = true;
                break;
            }
        }
        return isCheck;
    }

    //endregion your codes 3

}
