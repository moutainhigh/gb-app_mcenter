package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.commons.init.context.CommonContext;
import org.soul.commons.locale.LocaleTool;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.company.site.ISiteI18nService;
import so.wwb.gamebox.mcenter.setting.form.SiteI18nSearchForm;
import so.wwb.gamebox.mcenter.setting.form.Sitei18nForm;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.SiteI18nEnum;
import so.wwb.gamebox.model.company.site.po.SiteI18n;
import so.wwb.gamebox.model.company.site.vo.SiteI18nListVo;
import so.wwb.gamebox.model.company.site.vo.SiteI18nVo;
import so.wwb.gamebox.web.cache.Cache;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by faker on 16-10-30.
 */
@Controller
//region your codes 1
@RequestMapping("/siteI18n")
public class SiteI18nController extends BaseCrudController<ISiteI18nService, SiteI18nListVo, SiteI18nVo, SiteI18nSearchForm, Sitei18nForm, SiteI18n, Integer> {

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/settting/";
        //endregion your codes 2
    }

    /**
     * 新增和编辑seo的保存功能；
     *
     * @param listVo
     * @return
     */
    @RequestMapping("/batchSaveSeo")
    @ResponseBody
    public Map batchSave(SiteI18nVo objectVo,SiteI18nListVo listVo, BindingResult result) {
        Map<String,Object> map = new HashMap<>(2);
        if (result.hasErrors()) {
            map.put("state",false);
            map.put("msg","保存失败");
            return map;
        }
        //需要保存的code类型
        Map<Integer,String> code = new HashMap<>();
        code.put(0, SiteI18nEnum.SETTING_SITE_TITLE.getCode());
        code.put(1, SiteI18nEnum.SETTING_SITE_KEYWORDS.getCode());
        code.put(2, SiteI18nEnum.SETTING_SITE_DESCRIPTION.getCode());

        //需要保存的备注
        Map<Integer,String> remark = new HashMap<>();
        remark.put(0,"站点title");
        remark.put(1,"站点关键字");
        remark.put(2,"站点描述");

        List<SiteI18n> siteI18ns = listVo.getSiteI18ns();
        for(int i = 0;i<siteI18ns.size();i++){
            SiteI18n siteI18n = siteI18ns.get(i);
            siteI18n.setSiteId(CommonContext.get().getSiteId());
            siteI18n.setModule(Module.COMPANY_SETTING.getCode());
            siteI18n.setType(SiteI18nEnum.SETTING_SITE_TITLE.getType());
            siteI18n.setKey(code.get(i%3));
            siteI18n.setRemark(remark.get(i%3));
            objectVo.setResult(siteI18n);
            if(siteI18n.getId()==null){
                getService().insert(objectVo);
            }else{
                getService().update(objectVo);
            }
        }

        if (listVo.isSuccess()) {
            map.put("state",true);
            map.put("msg", LocaleTool.tranMessage("common","save.success"));
            Cache.refreshSiteI18n(SiteI18nEnum.SETTING_SITE_TITLE);
            Cache.refreshSiteI18n(SiteI18nEnum.SETTING_SITE_KEYWORDS);
            Cache.refreshSiteI18n(SiteI18nEnum.SETTING_SITE_DESCRIPTION);
            Cache.refreshCurrentSitePageCache();
        } else {
            map.put("state",false);
            map.put("msg",LocaleTool.tranMessage("common","save.failed"));
        }
        return map;
    }

}
