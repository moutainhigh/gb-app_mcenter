package so.wwb.gamebox.mcenter.content.controller;

import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.cache.Cache;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.content.IVCttDocumentService;
import so.wwb.gamebox.mcenter.content.form.VCttDocumentForm;
import so.wwb.gamebox.mcenter.content.form.VCttDocumentSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.company.site.vo.SiteLanguageListVo;
import so.wwb.gamebox.model.master.content.po.CttDocumentI18n;
import so.wwb.gamebox.model.master.content.po.VCttDocument;
import so.wwb.gamebox.model.master.content.vo.CttDocumentI18nVo;
import so.wwb.gamebox.model.master.content.vo.VCttDocumentListVo;
import so.wwb.gamebox.model.master.content.vo.VCttDocumentVo;
import so.wwb.gamebox.web.init.ConfigBase;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 控制器
 *
 * @author River
 * @time 2015-11-12 16:53:31
 */
@Controller
//region your codes 1
@RequestMapping("/vCttDocument")
public class VCttDocumentController extends BaseCrudController<IVCttDocumentService, VCttDocumentListVo, VCttDocumentVo, VCttDocumentSearchForm, VCttDocumentForm, VCttDocument, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/cttdocument/";
        //endregion your codes 2
    }

    //region your codes 3
    private final static String ORDER_LIST = "OrderList";
    @Override
    protected VCttDocumentListVo doList(VCttDocumentListVo listVo, VCttDocumentSearchForm form, BindingResult result, Model model) {
        setSiteLanguage(model);
        getDocumentI18n(model);
        Integer openId = listVo.getOpenId();
        listVo =  super.doList(listVo, form, result, model);
        listVo = this.getService().findSubitemCttDocument(listVo);
        listVo.setOpenId(openId);
        return listVo;
    }

    private void getDocumentI18n(Model model) {
        CttDocumentI18nVo cttDocumentI18nVo = new CttDocumentI18nVo();
        cttDocumentI18nVo.getSearch().setLocal(SessionManager.getLocale().toString());
        Map<String,CttDocumentI18n> cacheMap = this.getService().getDocumentI18nByLocal(cttDocumentI18nVo);
        model.addAttribute("cacheMap",cacheMap);
    }

    private void setSiteLanguage(Model model) {
        SiteLanguageListVo siteLanguageListVo = new SiteLanguageListVo();
        siteLanguageListVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageListVo);;//TODO 站长语言
        model.addAttribute("languageList",languageList);
        model.addAttribute("languageCount",languageList.size());
    }

    @RequestMapping({"/deleteCttDocument"})
    @ResponseBody
    public Map<String,Object> deleteCttDocument(VCttDocumentVo vCttDocumentVo,Model model){
        this.getService().deleteCttDocumentById(vCttDocumentVo);
        Cache.refreshContentDocument();
        Cache.refreshContentDocumentI18n();
        Cache.refreshCurrentSitePageCache(ConfigBase.get().getPageKey());
        Map<String,Object> res = new HashMap<String,Object>();
        res.put("status",vCttDocumentVo.isSuccess());
        res.put("errMsg",vCttDocumentVo.getErrMsg());
        return res;
    }
    @RequestMapping({"/updateStatus"})
    @ResponseBody
    public Map<String,Object> updateStatus(VCttDocumentVo vCttDocumentVo,Model model){
        vCttDocumentVo = this.getService().updateCttDocumentStatus(vCttDocumentVo);
        Cache.refreshContentDocument();
        Cache.refreshContentDocumentI18n();
        Cache.refreshCurrentSitePageCache(ConfigBase.get().getPageKey());
        Map<String,Object> res = new HashMap<String,Object>();
        res.put("state",vCttDocumentVo.isSuccess());
        if(StringTool.isNotBlank(vCttDocumentVo.getErrMsg())){
            String errMsg = LocaleTool.tranMessage("content", vCttDocumentVo.getErrMsg());
            res.put("errMsg",errMsg);
        }

        return res;
    }
    @RequestMapping({"/toOrderList"})
    public String toOrderList(VCttDocumentListVo listVo,Model model){
        setSiteLanguage(model);
        getDocumentI18n(model);
        listVo.getQuery().getPageOrderMap().put(VCttDocument.PROP_ORDER_NUM,"asc");
        listVo.setPaging(null);
        listVo = this.getService().search(listVo);
        model.addAttribute("command",listVo);
        return getViewBasePath()+ORDER_LIST;
    }
    //endregion your codes 3

}
