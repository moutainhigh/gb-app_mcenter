package so.wwb.gamebox.mcenter.content.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.web.controller.BaseCrudController;
import org.soul.commons.locale.DateQuickPicker;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.company.site.IVSiteApiTypeService;
import so.wwb.gamebox.mcenter.content.form.VSiteApiTypeForm;
import so.wwb.gamebox.mcenter.content.form.VSiteApiTypeSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.company.setting.po.ApiTypeI18n;
import so.wwb.gamebox.model.company.site.po.SiteApiTypeI18n;
import so.wwb.gamebox.model.company.site.po.SiteApiTypeRelation;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.company.site.po.VSiteApiType;
import so.wwb.gamebox.model.company.site.vo.SiteApiTypeRelationListVo;
import so.wwb.gamebox.model.company.site.vo.SiteLanguageListVo;
import so.wwb.gamebox.model.company.site.vo.VSiteApiTypeListVo;
import so.wwb.gamebox.model.company.site.vo.VSiteApiTypeVo;
import so.wwb.gamebox.model.master.player.vo.PlayerGameLogVo;
import so.wwb.gamebox.web.cache.Cache;

import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * 控制器
 *
 * @author River
 * @time 2015-11-4 15:19:03
 */
@Controller
//region your codes 1
@RequestMapping("/vSiteApiType")
public class VSiteApiTypeController extends BaseCrudController<IVSiteApiTypeService, VSiteApiTypeListVo, VSiteApiTypeVo, VSiteApiTypeSearchForm, VSiteApiTypeForm, VSiteApiType, Integer> {

    private static final Log LOG = LogFactory.getLog(VSiteApiTypeController.class);
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/gameManager/apiType/";
        //endregion your codes 2
    }



    //region your codes 3
    private  final static String ORDER_URL = "/content/gameManager/apiType/OrderApiType";

    @Override
    protected VSiteApiTypeListVo doList(VSiteApiTypeListVo listVo, VSiteApiTypeSearchForm form, BindingResult result, Model model) {
        setApiTypeCache(model);
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo =  super.doList(listVo, form, result, model);
        if(listVo.getResult()!=null&&listVo.getResult().size()>0){
            for(VSiteApiType type : listVo.getResult()){
                Integer count = getPlayerCount(type);
                type.setPlayerCount(count);
            }
        }
        return listVo;
    }

    @Override
    protected VSiteApiTypeVo doEdit(VSiteApiTypeVo objectVo, Model model) {
        SiteLanguageListVo siteLanguageListVo = new SiteLanguageListVo();
        siteLanguageListVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageListVo);//TODO 站长语言
        model.addAttribute("languageList",languageList);
        return objectVo;
    }

    @RequestMapping("/orderApiType")
    public String orderApiType(VSiteApiTypeListVo vSiteApiTypeListVo, Model model){
        vSiteApiTypeListVo.setPaging(null);
        vSiteApiTypeListVo.getSearch().setSiteId(SessionManager.getSiteId());
        vSiteApiTypeListVo = this.getService().search(vSiteApiTypeListVo);
        setApiTypeCache(model);
        model.addAttribute("command",vSiteApiTypeListVo);
        return ORDER_URL;
    }
    @RequestMapping(value = "/saveApiTypeOrder",method = RequestMethod.POST ,headers = {"Content-type=application/json"})
    @ResponseBody
    public boolean saveApiTypeOrder(@RequestBody VSiteApiTypeVo vSiteApiTypeVo,Model model){
        try{
            this.getService().saveSietApiTypeOrder(vSiteApiTypeVo);
            Cache.refreshSiteApiType();
            Cache.refreshCurrentSitePageCache();
            return true;
        }catch (Exception e){
            LOG.error(e);
            return false;
        }
    }

    private Integer getPlayerCount(VSiteApiType vSiteApiType){
        SiteApiTypeRelationListVo listVo = new SiteApiTypeRelationListVo();
        listVo.getSearch().setApiTypeId(vSiteApiType.getApiTypeId());
        listVo.getSearch().setSiteId(vSiteApiType.getSiteId());
        listVo.setProperties(SiteApiTypeRelation.PROP_API_ID);
        List<Integer> apiIds = ServiceTool.siteApiTypeRelationService().searchProperty(listVo);
        if(CollectionTool.isEmpty(apiIds)){
            return 0;
        }
        PlayerGameLogVo logVo = new PlayerGameLogVo();
        logVo.getSearch().setApiIds(apiIds);
        DateQuickPicker dp = SessionManager.getDate();
        Date now = dp.getToday();
        Date start = DateTool.addDays(now, -30);
        logVo.getSearch().setLoginEndTime(now);
        logVo.getSearch().setLoginStartTime(start);
        Integer playerCount = ServiceTool.playerGameLogService().getPlayerCountBySiteApiType(logVo);
        return playerCount;
    }

    private void setApiTypeCache(Model model){
        Map<String, SiteApiTypeI18n> siteApiTypeI18nMap = Cache.getSiteApiTypeI18n();
        Map<String,ApiTypeI18n> apiTypeI18nMap = Cache.getApiTypeI18n();
        model.addAttribute("apiTypes",apiTypeI18nMap);
        model.addAttribute("siteApiTypes",siteApiTypeI18nMap);
    }
    //endregion your codes 3

}