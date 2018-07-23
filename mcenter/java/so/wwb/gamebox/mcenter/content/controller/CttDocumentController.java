package so.wwb.gamebox.mcenter.content.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.cache.Cache;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.content.ICttDocumentService;
import so.wwb.gamebox.mcenter.content.form.CttDocumentForm;
import so.wwb.gamebox.mcenter.content.form.CttDocumentSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.company.site.vo.SiteLanguageListVo;
import so.wwb.gamebox.model.master.content.po.CttDocument;
import so.wwb.gamebox.model.master.content.po.VCttDocumentUser;
import so.wwb.gamebox.model.master.content.vo.CttDocumentI18nListVo;
import so.wwb.gamebox.model.master.content.vo.CttDocumentListVo;
import so.wwb.gamebox.model.master.content.vo.CttDocumentVo;
import so.wwb.gamebox.model.master.content.vo.VCttDocumentUserVo;
import so.wwb.gamebox.web.init.ConfigBase;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 控制器
 *
 * @author River
 * @time 2015-11-12 16:19:11
 */
@Controller
//region your codes 1
@RequestMapping("/cttDocument")
public class CttDocumentController extends BaseCrudController<ICttDocumentService, CttDocumentListVo, CttDocumentVo, CttDocumentSearchForm, CttDocumentForm, CttDocument, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/cttdocument/";
        //endregion your codes 2
    }

    //region your codes 3
    @RequestMapping(value = "/saveDocumentOrder",method = RequestMethod.POST ,headers = {"Content-type=application/json"})
    @ResponseBody
    public boolean saveApiTypeOrder(@RequestBody CttDocumentVo cttDocumentVo,Model model){
        this.getService().updateDocumentOrder(cttDocumentVo);
        Cache.refreshContentDocument();
        Cache.refreshContentDocumentI18n();
        Cache.refreshCurrentSitePageCache(ConfigBase.get().getPageKey());
        return true;
    }
    @RequestMapping(value = "/showDocumentDetail")
    public String showDocumentDetail(VCttDocumentUserVo vCttDocumentUserVo,Model model){
        getSiteLanguage(model);
        vCttDocumentUserVo = ServiceSiteTool.vCttDocumentUserService().get(vCttDocumentUserVo);
        vCttDocumentUserVo = getCttDocumentVo(vCttDocumentUserVo);
        model.addAttribute("command",vCttDocumentUserVo);
        return getViewBasePath() + "DocumentDetail";
    }
    /**
     * 查找文案
     * @param cttDocumentVo
     * @return
     */
    public VCttDocumentUserVo getCttDocumentVo(VCttDocumentUserVo cttDocumentVo) {
        if(cttDocumentVo.getResult()!=null){
            cttDocumentVo = findDocumentI18n(cttDocumentVo);
            cttDocumentVo = findParentDocument(cttDocumentVo);
        }

        return cttDocumentVo;
    }
    /**
     * 查找文案的国际化信息
     * @param cttDocumentVo
     * @return
     */
    private VCttDocumentUserVo findDocumentI18n(VCttDocumentUserVo cttDocumentVo){
        Map<String,CttDocumentI18nListVo> i18nMap = new HashMap<>();
        CttDocumentI18nListVo listVo = getStringCttDocumentI18nListVoMap(cttDocumentVo);
        i18nMap.put(cttDocumentVo.getResult().getId().toString(), listVo);
        cttDocumentVo.setI18nMap(i18nMap);
        return cttDocumentVo;
    }
    private VCttDocumentUserVo findParentDocument(VCttDocumentUserVo cttDocumentVo){
        Map<Integer,VCttDocumentUser> parentMap = new HashMap<Integer,VCttDocumentUser>();

        VCttDocumentUser document =cttDocumentVo.getResult();
        VCttDocumentUserVo documentUserVo = new VCttDocumentUserVo();
        documentUserVo.getSearch().setId(document.getParentId());
        documentUserVo = ServiceSiteTool.vCttDocumentUserService().get(documentUserVo);
        if(documentUserVo.getResult()==null){
            return cttDocumentVo;
        }
        parentMap.put(document.getId(), documentUserVo.getResult());
        if(document.getParentId()!=null){
            Map<String,CttDocumentI18nListVo> i18nMap = cttDocumentVo.getI18nMap();
            if(i18nMap==null){
                i18nMap = new HashMap<>();
            }
            CttDocumentI18nListVo listVo = getStringCttDocumentI18nListVoMap(documentUserVo);
            i18nMap.put(documentUserVo.getResult().getId().toString(), listVo);
            cttDocumentVo.setI18nMap(i18nMap);
            cttDocumentVo.setParentMap(parentMap);
        }



        return cttDocumentVo;
    }
    private CttDocumentI18nListVo getStringCttDocumentI18nListVoMap(VCttDocumentUserVo cttDocumentVo) {
        VCttDocumentUser document = cttDocumentVo.getResult();
        CttDocumentI18nListVo listVo = new CttDocumentI18nListVo();
        listVo.getSearch().setDocumentId(document.getId());
        listVo = ServiceSiteTool.vCttDocumentService().findCttDocumentI18nListByDocumentId(listVo);

        return listVo;
    }

    /**
     * 获取站点语言
     * @param model
     */
    public void getSiteLanguage(Model model) {
        SiteLanguageListVo siteLanguageVo = new SiteLanguageListVo();
        siteLanguageVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageVo);
        model.addAttribute("languageList",languageList);
    }
    //endregion your codes 3

}
