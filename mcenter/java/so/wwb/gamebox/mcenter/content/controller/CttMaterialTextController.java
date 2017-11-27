package so.wwb.gamebox.mcenter.content.controller;

import org.apache.commons.collections.Predicate;
import org.apache.commons.lang3.StringEscapeUtils;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.collections.ListTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.support._Module;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.agent.ICttMaterialTextService;
import so.wwb.gamebox.mcenter.content.form.CttMaterialPicForm;
import so.wwb.gamebox.mcenter.content.form.CttMaterialTextForm;
import so.wwb.gamebox.mcenter.content.form.CttMaterialTextSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.CacheBase;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.master.agent.po.CttMaterialPic;
import so.wwb.gamebox.model.master.agent.po.CttMaterialText;
import so.wwb.gamebox.model.master.agent.vo.CttMaterialPicListVo;
import so.wwb.gamebox.model.master.agent.vo.CttMaterialTextListVo;
import so.wwb.gamebox.model.master.agent.vo.CttMaterialTextVo;
import so.wwb.gamebox.model.master.content.enums.CttMaterialEnum;
import so.wwb.gamebox.web.common.token.Token;

import javax.validation.Valid;
import java.util.*;


/**
 * 推广素材文字表控制器
 *
 * @author tom
 * @time 2015-10-29 11:32:15
 */
@Controller
//region your codes 1
@RequestMapping("/cttMaterialText")
public class CttMaterialTextController extends BaseCrudController<ICttMaterialTextService, CttMaterialTextListVo, CttMaterialTextVo, CttMaterialTextSearchForm, CttMaterialTextForm, CttMaterialText, Integer> {
//endregion your codes 1

    /**
     * 页面显示最多 站长语言
     */
    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/material/";
        //endregion your codes 2
    }

    //region your codes 3

    @Override
    protected CttMaterialTextListVo doList(CttMaterialTextListVo listVo, CttMaterialTextSearchForm form, BindingResult result, Model model) {
        listVo.getSearch().setLanguage(SessionManager.getLocale().toString());
        return getService().searchMaterial(listVo);
    }

    @RequestMapping("/showHideMaterial")
    @ResponseBody
    public Map showHideMaterial(CttMaterialTextVo vo) {
        vo.getResult().setUpdateUser(SessionManager.getUserId());
        vo = getService().showHideMaterial(vo);
        Map<Object, Object> result = new HashMap<>();
        if (vo.isSuccess())
            result.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_SUCCESS, new Object[0]));
        else
            result.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_SUCCESS, new Object[0]));
        result.put("state", Boolean.valueOf(vo.isSuccess()));
        return result;
    }

    @RequestMapping({"/deleteGroup"})
    @ResponseBody
    public Map deleteGroup(CttMaterialTextVo vo) {
        vo = getService().deleteGroup(vo);
        if(vo.isSuccess()) {
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_SUCCESS, new Object[0]));
        } else if(!vo.isSuccess()) {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "delete.failed", new Object[0]));
        }

        return this.getVoMessage(vo);
    }

    /**
     * 新增素材
     * @param model
     * @return
     */
    @RequestMapping("/createCtt")
    @Token(generate = true)
    public String createCtt(CttMaterialTextVo vo,Model model) {
        siteLang(model);
        if (CttMaterialEnum.TEXT.getCode().equals(vo.getSearch().getType())) {
            model.addAttribute("validateRule", JsRuleCreator.create(CttMaterialTextForm.class, null));
            return getViewBasePath()+"EditText";
        } else {
            model.addAttribute("validateRule", JsRuleCreator.create(CttMaterialPicForm.class, null));
            return getViewBasePath()+"EditPic";
        }
    }

    @RequestMapping("/saveCttText")
    @ResponseBody
    @Token(valid = true)
    public Map saveCttText(CttMaterialTextVo vo) {
        vo.getSearch().setCreateUser(SessionManager.getUserId());
        vo = getService().saveCttText(vo);
        Map map = new HashMap(2,1f);
        if (vo.isSuccess()) {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_SUCCESS));
        } else if (StringTool.isNotEmpty(vo.getErrMsg())) {
            map.put("msg", LocaleTool.tranMessage(Module.MASTER_CONTENT, vo.getErrMsg()));
        } else {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
        }
        map.put("state", Boolean.valueOf(vo.isSuccess()));
        return map;
    }

    /**
     *
     * @param vo
     * @return
     */
    @RequestMapping("/editMaterial")
    @Token(generate = true)
    public String editMaterial(CttMaterialTextListVo vo,Model model) {
        Map<String,Object> conditions = new HashMap<>();
        conditions.put(CttMaterialText.PROP_GROUP_CODE,vo.getSearch().getGroupCode());
        vo.setConditions(conditions);
        List<CttMaterialText>  cttMaterialList = getService().andSearch(vo);
        List<SiteLanguage> siteLanguageList = siteLang(model);
        if (CollectionTool.isNotEmpty(cttMaterialList) && CollectionTool.isNotEmpty(siteLanguageList)) {
            final SiteLanguage siteLanguage = siteLanguageList.get(0);
            Predicate predicate = new Predicate() {
                @Override
                public boolean evaluate(Object o) {
                    return ((CttMaterialText)o).getLanguage().equals(siteLanguage.getLanguage());
                }
            };
            Collection cttMaterial = CollectionTool.filter(cttMaterialList, predicate);
            if (CollectionTool.isNotEmpty(cttMaterial)) {
                model.addAttribute("firstLang", cttMaterial.iterator().next());
            }
        }
        if (CollectionTool.isNotEmpty(cttMaterialList) && CollectionTool.isNotEmpty(siteLanguageList)) {
            int index = 0;
            for(SiteLanguage siteLanguage : siteLanguageList) {
                for(int i=0;i<cttMaterialList.size();i++) {
                    CttMaterialText text = cttMaterialList.get(i);
                    if (StringTool.isNotEmpty(siteLanguage.getLanguage()) && StringTool.isNotEmpty(text.getLanguage())) {
                        if (siteLanguage.getLanguage().equals(text.getLanguage()) && StringTool.isNotEmpty(text.getContent())) {
                            siteLanguageList.get(index).setIsEdit(true);
                        }
                    }
                }
                index++;
            }
        }
        model.addAttribute("groupCode",vo.getSearch().getGroupCode());
        model.addAttribute("cttListJson", StringEscapeUtils.unescapeHtml4(JsonTool.toJson(cttMaterialList)));
        model.addAttribute("validateRule", JsRuleCreator.create(CttMaterialTextForm.class, null));
        return getViewBasePath()+"EditText";
    }

    /**
     * 编辑图片素材
     * @param vo
     * @return
     */
    @RequestMapping("/editMaterialPic")
    @Token(generate = true)
    public String editMaterial(CttMaterialPicListVo vo,Model model) {
        Map<String,Object> conditions = new HashMap<>();
        conditions.put(CttMaterialText.PROP_GROUP_CODE,vo.getSearch().getGroupCode());
        vo.setConditions(conditions);
        List<CttMaterialPic>  cttMaterialList = ServiceTool.cttMaterialPicService().andSearch(vo);
        List<SiteLanguage> siteLanguageList =siteLang(model);
        if (CollectionTool.isNotEmpty(cttMaterialList) && CollectionTool.isNotEmpty(cttMaterialList)) {
            int index = 0;
            for(SiteLanguage siteLanguage : siteLanguageList) {
                for(int i=0;i<cttMaterialList.size();i++) {
                    CttMaterialPic pic = cttMaterialList.get(i);
                    if (StringTool.isNotEmpty(siteLanguage.getLanguage()) && StringTool.isNotEmpty(pic.getLanguage())) {
                        if (siteLanguage.getLanguage().equals(pic.getLanguage()) && StringTool.isNotEmpty(pic.getTitle()) && StringTool.isNotEmpty(pic.getPic())) {
                            siteLanguageList.get(index).setIsEdit(true);
                        }
                    }
                }
                index++;
            }
        }
        vo.setResult(cttMaterialList);
        Map<Object, CttMaterialPic> picMap= CollectionTool.toEntityMap(vo.getResult(), CttMaterialPic.PROP_LANGUAGE);
        model.addAttribute("picMap", picMap);

        model.addAttribute("validateRule", JsRuleCreator.create(CttMaterialPicForm.class, null));
        model.addAttribute("listVo", vo);
        return getViewBasePath()+"EditPic";
    }


    @RequestMapping("/saveCttPic")
    @ResponseBody
    @Token(valid = true)
    public Map saveCttPic(CttMaterialPicListVo vo,@FormModel("result") @Valid CttMaterialPicForm form, BindingResult result) {
        if (!result.hasErrors()) {
            vo.getSearch().setCreateUser(SessionManager.getUserId());
            vo = ServiceTool.cttMaterialPicService().editCttPic(vo);
            Map map = new HashMap(2,1f);
            if (vo.isSuccess()) {
                map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_SUCCESS));
            } else if (StringTool.isNotEmpty(vo.getErrMsg())) {
                map.put("msg", LocaleTool.tranMessage(Module.MASTER_CONTENT, vo.getErrMsg()));
            } else {
                map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
            }
            map.put("state", Boolean.valueOf(vo.isSuccess()));
            return map;
        }
        return null;
    }


    /**
     * 获取可使用的语言
     * @param model
     * @return
     */
    private List<SiteLanguage> siteLang(Model model) {
        List<SiteLanguage> _siteLanguageList = ListTool.newArrayList();
        Map<String, SiteLanguage> availableSiteLanguage = CacheBase.getAvailableSiteLanguage();

        Iterator<String> iterator = availableSiteLanguage.keySet().iterator();
        while (iterator.hasNext()) {
            SiteLanguage siteLanguage = availableSiteLanguage.get(iterator.next());
            _siteLanguageList.add(siteLanguage);
        }

        model.addAttribute("maxLang", _siteLanguageList.size());
        model.addAttribute("siteLang", _siteLanguageList);
        return _siteLanguageList;
    }

    //endregion your codes 3

}