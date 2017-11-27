package so.wwb.gamebox.mcenter.content.controller;

import org.soul.commons.collections.CollectionQueryTool;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.company.sport.IVSportRecommendedService;
import so.wwb.gamebox.mcenter.content.form.SportRecommendedSiteForm;
import so.wwb.gamebox.mcenter.content.form.SportRecommendedSiteSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.SiteI18nEnum;
import so.wwb.gamebox.model.company.site.po.SiteGame;
import so.wwb.gamebox.model.company.site.po.SiteI18n;
import so.wwb.gamebox.model.company.sport.po.SportRecommendedSite;
import so.wwb.gamebox.model.company.sport.po.VSportRecommended;
import so.wwb.gamebox.model.company.sport.vo.SportRecommendedSiteListVo;
import so.wwb.gamebox.model.company.sport.vo.SportRecommendedSiteVo;
import so.wwb.gamebox.model.company.sport.vo.VSportRecommendedListVo;
import so.wwb.gamebox.model.company.sport.vo.VSportRecommendedVo;
import so.wwb.gamebox.web.cache.Cache;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * 站点启用表控制器
 *
 * @author catban
 * @time 2016-2-17 17:54:29
 */
@Controller
//region your codes 1
@RequestMapping("/sportRecommendedSite")
public class SportRecommendedSiteController extends BaseCrudController<IVSportRecommendedService, VSportRecommendedListVo, VSportRecommendedVo, SportRecommendedSiteSearchForm, SportRecommendedSiteForm, SportRecommendedSite, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/sport/";
        //endregion your codes 2
    }

    //region your codes 3

    @Override
    protected VSportRecommendedListVo doList(VSportRecommendedListVo listVo, SportRecommendedSiteSearchForm form, BindingResult result, Model model) {
        setMatchTypeDict(listVo);
        getSiteSportRecomendedList(listVo);

        return listVo;
    }

    /**
     * 赛事类型下拉选项
     * @param listVo
     */
    private void setMatchTypeDict(VSportRecommendedListVo listVo) {
        List<SiteI18n> matchType =new ArrayList<SiteI18n>(Cache.getSiteI18nCurrent(SiteI18nEnum.SPORT_RECOMMENDED_SCHEME_MATCH_TYPE,0).values());
        listVo.setMatchType(matchType);
        Map<String, SiteI18n> siteI18nMap = CollectionTool.extractToMap(matchType, SiteI18n.PROP_KEY, SiteI18n.PROP_VALUE);
        listVo.setMatchTypeMap(siteI18nMap);
    }

    private void getSiteSportRecomendedList(VSportRecommendedListVo listVo) {
        VSportRecommendedListVo vSportRecommendedListVo = new VSportRecommendedListVo();
        vSportRecommendedListVo.getSearch().setCurrentTime(new Date());
        if (listVo.getSearch().getMatchType()!=null) {
            vSportRecommendedListVo.getSearch().setMatchType(listVo.getSearch().getMatchType());
        }
        /*获取当前站点可展示的赛事 - 过滤推荐的赛事的game是否是当前站点的game*/
        List<VSportRecommended> sportRecommendeds =  getService().queryDisplayMatch(vSportRecommendedListVo);
        sportRecommendeds =filterGamBleExistInCurrentSite(sportRecommendeds);
        listVo.getPaging().setTotalCount(sportRecommendeds.size());
        listVo.getPaging().cal();
        sportRecommendeds = CollectionQueryTool.pagingQuery(sportRecommendeds,null,listVo.getPaging().getPageNumber(),listVo.getPaging().getPageSize());
        listVo.getResult().addAll(sportRecommendeds);

        /*获取当前站点启用的赛事的id*/
        SportRecommendedSiteListVo recVo = new SportRecommendedSiteListVo();
        recVo.getSearch().setSiteId(SessionManager.getSiteId());
        recVo.setProperties(SportRecommendedSite.PROP_SPORT_RECOMMENDED_ID);
        List<Integer> recId = ServiceTool.sportRecommendedSiteService().searchProperty(recVo);
        listVo.setRecId(recId);

    }

    /**
     * 过滤推荐的赛事的game是否是当前站点的game
     * @param recommendedOriginal
     * @return
     */
    private List<VSportRecommended> filterGamBleExistInCurrentSite(List<VSportRecommended> recommendedOriginal) {
        List<VSportRecommended> recommendedSite = new ArrayList<>();
        Map<String, SiteGame> siteGame = Cache.getSiteGame();
        for (VSportRecommended recommended : recommendedOriginal) {
            for (String id: siteGame.keySet()){
                if ((siteGame.get(id).getGameId().intValue()==recommended.getGameId().intValue())
                     &&  (siteGame.get(id).getApiId().intValue()== recommended.getApiId().intValue())){
                    recommendedSite.add(recommended);
                }
            }
        }

        return recommendedSite;
    }


    @RequestMapping("/changeDisplayData")
    @ResponseBody
    public Map changDisplayData(SportRecommendedSiteVo vo){
        if(StringTool.equals(vo.getStatus(),"1")){
            //新增前端展现的赛事数据
            vo.getResult().setSiteId(SessionManager.getSiteId());
            ServiceTool.sportRecommendedSiteService().insert(vo);
        }else {
            //删除前端展现的赛事数据
            ServiceTool.sportRecommendedSiteService().deleteByRecommandId(vo);
        }
        Cache.refreshSportRecommendedToDisplay();
        Cache.refreshCurrentSitePageCache();
        return this.getVoMessage(vo);
    }



    //endregion your codes 3

}