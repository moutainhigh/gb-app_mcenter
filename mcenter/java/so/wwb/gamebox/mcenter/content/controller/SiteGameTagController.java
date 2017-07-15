package so.wwb.gamebox.mcenter.content.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import org.apache.commons.collections.map.ListOrderedMap;
import org.soul.commons.collections.CollectionQueryTool;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.collections.MapTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.query.Criteria;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.support._Module;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.company.site.ISiteGameTagService;
import so.wwb.gamebox.mcenter.content.form.SiteGameTagForm;
import so.wwb.gamebox.mcenter.content.form.SiteGameTagSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.CacheBase;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.SiteI18nEnum;
import so.wwb.gamebox.model.company.site.po.SiteGameTag;
import so.wwb.gamebox.model.company.site.po.SiteI18n;
import so.wwb.gamebox.model.company.site.vo.*;
import so.wwb.gamebox.web.cache.Cache;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.*;


/**
 * 游戏标签表 by River控制器
 *
 * @author River
 * @time 2015-12-17 12:01:07
 */
@Controller
//region your codes 1
@RequestMapping("/siteGameTag")
public class SiteGameTagController extends BaseCrudController<ISiteGameTagService, SiteGameTagListVo, SiteGameTagVo, SiteGameTagSearchForm, SiteGameTagForm, SiteGameTag, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/gameManager/siteGame/";
        //endregion your codes 2
    }

    //region your codes 3
    private SiteI18n existGameTag;
    @RequestMapping(value = "/gameTagEdit")
    public String gameTagEdit(SiteGameTagVo siteGameTagVo,Model model){

        siteGameTagVo.setGameTagMap(getGameTagMap());
        model.addAttribute("command",siteGameTagVo);
        model.addAttribute("siteLang", CacheBase.getSiteLanguage());//语言分类
        model.addAttribute("validate", JsRuleCreator.create(SiteGameTagForm.class));//表单验证
        return getViewBasePath() + "GameTagEdit";
    }

    private Map<String, List<SiteI18n>> getGameTagMap(){
        /**
         * Cache.getSiteI18n(SiteI18nEnum.MASTER_GAME_TAG);
         * 修改为：
         * Cache.getGameTag();
         * 默认游戏分类，新游戏，热门游戏分类，不属于站点分类，这里做特殊处理
         */
        Map<String, SiteI18n> siteI18nMap = Cache.getGameTag();
        Map<String, List<SiteI18n>> gameTagMap = new ListOrderedMap();
        for (String siteI18nKey : siteI18nMap.keySet()) {
            String[] keyLocale = StringTool.split(siteI18nKey, ":");
            if (CollectionTool.isEmpty(MapTool.getObject(gameTagMap, keyLocale[0]))) {
                gameTagMap.put(keyLocale[0], new ArrayList<SiteI18n>());
            }
            gameTagMap.get(keyLocale[0]).add(siteI18nMap.get(siteI18nKey));
        }
        return gameTagMap;
    }

    private boolean siteGameTagIsExists(List<SiteGameTagCustomerVo> list){
        existGameTag = null;
        boolean flag = false;
        for (SiteGameTagCustomerVo obj : list) {
            flag = gameTagIsExists(obj.getList());
        }
        return flag;
    }

    private boolean gameTagIsExists(List<SiteI18n> newList){
        if(newList==null||newList.size()==0){
            return false;
        }
        boolean flag = false;
        for (SiteI18n siteI18n : newList) {
            boolean isNew = false;
            if(siteI18n.getId()==null){
                isNew = true;
            }
            flag = isExists(siteI18n,isNew);
            if(flag==true){
                break;
            }
        }
        return flag;
    }

    private boolean isExists(SiteI18n siteI18n,boolean isNew){
        Map<String, SiteI18n> gameTagMap = Cache.getSiteI18n(SiteI18nEnum.MASTER_GAME_TAG);
        Iterator<String> gameTageIter = gameTagMap.keySet().iterator();
        boolean flag = false;
        while (gameTageIter.hasNext()){
            String key = gameTageIter.next();
            SiteI18n oldGameTag = gameTagMap.get(key);
            if(isNew){
                if(oldGameTag.getLocale().equals(siteI18n.getLocale())
                        &&oldGameTag.getValue().equals(siteI18n.getValue())){
                    existGameTag = oldGameTag;
                    flag = true;
                    break;
                }
            }else{
                if(oldGameTag.getLocale().equals(siteI18n.getLocale())
                        &&oldGameTag.getValue().equals(siteI18n.getValue())
                        &&!oldGameTag.getId().equals(siteI18n.getId())
                        &&!oldGameTag.getKey().equals(siteI18n.getKey())){
                    flag = true;
                    existGameTag = oldGameTag;
                    break;
                }
            }

        }
        return flag;
    }

    @RequestMapping(value = "/saveGameTagI18n")
    @ResponseBody
    protected Map saveGameTagI18n(String data, @FormModel @Valid SiteGameTagForm form,BindingResult result) {
        if (result.hasErrors()) {
            return null;
        }
        List<SiteGameTagCustomerVo> list = JsonTool.fromJson(data, new TypeReference<ArrayList<SiteGameTagCustomerVo>>() {
        });
        SiteI18nListVo listVo = new SiteI18nListVo();
        boolean gameTagIsExists = siteGameTagIsExists(list);
        if(gameTagIsExists){
            listVo.setSuccess(false);
            String tagName = "";
            if(existGameTag!=null){
                tagName = existGameTag.getValue();
            }
            String msg = LocaleTool.tranMessage(Module.MASTER_CONTENT,"game.gametag.namerepeat",tagName);
            listVo.setErrMsg(msg);
        }else{
            listVo.setGameTagList(list);
            listVo.setSiteId(SessionManager.getSiteId());
            listVo = ServiceTool.siteI18nService().saveGameTagI18n(listVo);
            Cache.refreshSiteI18n(SiteI18nEnum.MASTER_GAME_TAG);
            Cache.refreshCurrentSitePageCache();
        }

        return getVoMessage(listVo);
    }
    @RequestMapping(value = "/gameTagIsExists")
    @ResponseBody
    public Map<String,Object> gameTagIsExists(String data){
        Map<String,Object> result = new HashMap<String,Object>();
        List<SiteGameTagCustomerVo> list = JsonTool.fromJson(data, new TypeReference<ArrayList<SiteGameTagCustomerVo>>() {});
        boolean gameTagIsExists = siteGameTagIsExists(list);
        result.put("state",gameTagIsExists);
        if(gameTagIsExists){
            String tagName = "";
            if(existGameTag!=null){
                tagName = existGameTag.getValue();
            }
            String msg = LocaleTool.tranMessage(Module.MASTER_CONTENT,"game.gametag.namerepeat",tagName);
            result.put("msg",msg);
        }

        return result;
    }



    @RequestMapping(value = "/deleteSiteGameTag")
    @ResponseBody
    public Map<String,Object> deleteSiteGameTag(String key, SiteI18nVo vo){
        /**
         * Cache.getSiteI18n(SiteI18nEnum.OPERATE_ACTIVITY_CLASSIFY);
         * 修改为：
         * Cache.getOperateActivityClassify();
         * 默认分类，不属于站点分类，这里做特殊处理
         */
        Map<String, SiteI18n> siteI18nMap = Cache.getGameTag();
        List<SiteI18n> siteI18ns = CollectionQueryTool.query(siteI18nMap.values(), Criteria.add(SiteI18n.PROP_KEY, Operator.EQ, key));
        boolean isDefault = false;
        //判断是否为默认分类，如果是默认分类不能删除
        for (SiteI18n siteI18n : siteI18ns) {
            if (siteI18n.getBuiltIn() != null && siteI18n.getBuiltIn()) {
                isDefault = true;
                break;
            }
        }
        Map<String, Object> map = new HashMap(4);
        map.put("isDefault", isDefault);
        if (isDefault) {
            map.put("msg", LocaleTool.tranMessage(Module.MASTER_OPERATION.getCode(), "classification.defaultNotDelete"));
            return map;
        }
        Map<String, Object> tempMap = deleteSiteGameTag(key);
        map.putAll(tempMap);
        Cache.refreshSiteI18n(SiteI18nEnum.OPERATE_ACTIVITY_CLASSIFY);
        Cache.refreshCurrentSitePageCache();
        return map;
    }

    private Map<String, Object> deleteSiteGameTag(String key) {
        Map<String, Object> map = new HashMap<>(2);
        try{
            SiteI18nVo vo = new SiteI18nVo();
            vo.getSearch().setModule(Module.MASTER_SETTING.getCode());
            vo.getSearch().setType(SiteI18nEnum.MASTER_GAME_TAG.getType());
            vo.getSearch().setKey(key);
            ServiceTool.siteI18nService().deleSiteI18nByModuleAndKey(vo);
            map.put("state", true);
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, "delete.success"));
        }catch (Exception ex){
            map.put("state", false);
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, "delete.failed"));
        }

        return map;
    }

    @RequestMapping(value = "/checkTitle")
    @ResponseBody
    public boolean checkTitle(@FormModel SiteGameTagForm siteGameTagForm,HttpServletRequest request){
        if(siteGameTagForm==null){
            return true;
        }
        Map<String, SiteI18n> siteI18nMap = Cache.getGameTag();
        Collection<SiteI18n> values = siteI18nMap.values();
        String idParam = request.getParameter("id");
        String key = request.getParameter("key");
        Integer id = null;
        if(StringTool.isNotBlank(idParam)&&!"undefined".equals(idParam)){
            id = Integer.valueOf(idParam);
        }
        boolean flag = true;
        for(SiteI18n siteI18n : values){
            if(siteI18n.getValue().equals(siteGameTagForm.getGruop$$_locale$$()[0])){
                if(siteI18n.getId()!=id&&!siteI18n.getKey().equals(key)&&siteI18n.getSiteId()==SessionManager.getSiteId()){
                    flag = false;
                    break;
                }
            }
        }
        return flag;
    }


    //endregion your codes 3

}