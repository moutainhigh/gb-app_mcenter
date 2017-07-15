package so.wwb.gamebox.mcenter.content.controller;

import org.soul.commons.lang.DateTool;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.locale.DateQuickPicker;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.company.site.IVSiteApiTypeRelationService;
import so.wwb.gamebox.mcenter.content.form.VSiteApiTypeRelationForm;
import so.wwb.gamebox.mcenter.content.form.VSiteApiTypeRelationSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.company.help.po.HelpDocumentI18n;
import so.wwb.gamebox.model.company.setting.po.ApiI18n;
import so.wwb.gamebox.model.company.site.po.SiteApiI18n;
import so.wwb.gamebox.model.company.site.po.SiteApiTypeRelation;
import so.wwb.gamebox.model.company.site.po.SiteApiTypeRelationI18n;
import so.wwb.gamebox.model.company.site.po.VSiteApiTypeRelation;
import so.wwb.gamebox.model.company.site.vo.VSiteApiTypeRelationListVo;
import so.wwb.gamebox.model.company.site.vo.VSiteApiTypeRelationVo;
import so.wwb.gamebox.model.master.content.po.CttDocument;
import so.wwb.gamebox.model.master.player.vo.PlayerGameLogVo;
import so.wwb.gamebox.web.cache.Cache;

import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * 控制器
 *
 * @author River
 * @time 2015-11-6 14:33:27
 */
@Controller
//region your codes 1
@RequestMapping("/vSiteApiTypeRelation")
public class VSiteApiTypeRelationController extends BaseCrudController<IVSiteApiTypeRelationService, VSiteApiTypeRelationListVo, VSiteApiTypeRelationVo, VSiteApiTypeRelationSearchForm, VSiteApiTypeRelationForm, VSiteApiTypeRelation, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/gameManager/siteApi/";
        //endregion your codes 2
    }

    //region your codes 3
    private final static String ORDER_URL = "/content/gameManager/siteApi/OrderSiteApi";

    @Override
    protected VSiteApiTypeRelationListVo doList(VSiteApiTypeRelationListVo listVo, VSiteApiTypeRelationSearchForm form, BindingResult result, Model model) {
        setApiCache(model);
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo = super.doList(listVo, form, result, model);
        if(listVo.getResult()!=null&&listVo.getResult().size()>0){
            for(VSiteApiTypeRelation relation : listVo.getResult()){
                Integer count = getPlayerCount(relation);
                relation.setPlayerCount(count);
            }
        }
        return listVo;

    }

    @RequestMapping("/orderSiteApi")
    public String orderSiteApi(VSiteApiTypeRelationListVo vSiteApiTypeRelationListVo, Model model){
        setApiCache(model);
        vSiteApiTypeRelationListVo.setPaging(null);
        vSiteApiTypeRelationListVo.getSearch().setSiteId(SessionManager.getSiteId());
        vSiteApiTypeRelationListVo = this.getService().search(vSiteApiTypeRelationListVo);
        model.addAttribute("command",vSiteApiTypeRelationListVo);
        return ORDER_URL;
    }

    @RequestMapping(value = "/saveSiteApiOrder",method = RequestMethod.POST ,headers = {"Content-type=application/json"})
    @ResponseBody
    public boolean saveSiteApiOrder(@RequestBody VSiteApiTypeRelationVo vSiteApiTypeRelationVo,Model model){
        this.getService().saveSiteApiOrder(vSiteApiTypeRelationVo);
        return true;
    }

    private void setApiCache(Model model){
        Map<String,SiteApiI18n> siteApiI18nMap = Cache.getSiteApiI18n();
        model.addAttribute("siteApiI18ns",siteApiI18nMap);
        Map<String,ApiI18n> apiI18nMap = Cache.getApiI18n();
        model.addAttribute("apiI18ns",apiI18nMap);
    }
    private Integer getPlayerCount(VSiteApiTypeRelation vSiteApiTypeRelation){
        PlayerGameLogVo logVo = new PlayerGameLogVo();
        logVo.getSearch().setApiId(vSiteApiTypeRelation.getApiId());
        DateQuickPicker dp = SessionManager.getDate();
        Date now = dp.getToday();
        Date start = DateTool.addDays(now, -30);
        logVo.getSearch().setLoginEndTime(now);
        logVo.getSearch().setLoginStartTime(start);
        logVo._setDataSourceId(SessionManager.getSiteId());
        Integer playerCount = ServiceTool.playerGameLogService().getPlayerCountBySiteApi(logVo);
        return playerCount;
    }

    //endregion your codes 3

}