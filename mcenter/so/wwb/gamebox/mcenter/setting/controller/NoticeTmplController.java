package so.wwb.gamebox.mcenter.setting.controller;

import com.alibaba.fastjson.JSONArray;
import org.apache.commons.collections.Predicate;
import org.apache.commons.lang3.StringEscapeUtils;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.collections.ListTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.support._Module;
import org.soul.model.msg.notice.enums.NoticeTmplType;
import org.soul.model.msg.notice.po.NoticeTmpl;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.setting.INoticeTmplService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.NoticeTmplForm;
import so.wwb.gamebox.mcenter.setting.form.NoticeTmplSearchForm;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.CacheBase;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.common.notice.enums.ManualNoticeEvent;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.master.setting.so.NoticeTmplSo;
import so.wwb.gamebox.model.master.setting.vo.NoticeParamRelationListVo;
import so.wwb.gamebox.model.master.setting.vo.NoticeTmplListVo;
import so.wwb.gamebox.model.master.setting.vo.NoticeTmplVo;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.text.MessageFormat;
import java.util.*;


/**
 * 通知模板控制器
 *
 * @author tom
 * @time 2015-8-21 14:03:05
 */
@Controller
//region your codes 1
@RequestMapping("/noticeTmpl")
public class NoticeTmplController extends BaseCrudController<INoticeTmplService, NoticeTmplListVo, NoticeTmplVo, NoticeTmplSearchForm, NoticeTmplForm, NoticeTmpl, Integer> {
//endregion your codes 1
    /**
     * 页面显示最多 站长语言
     */
    private static final Integer MAX_LANG = 3;

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/";
        //endregion your codes 2
    }

    //region your codes 3

    /**
     * 查询手动信息模板、系统信息模板
     * @param tmplType 不存在为手动信息模板；存在为系统信息模板
     * @param model
     * @return
     */
    @RequestMapping("/tmpIndex")
    public String manualIndex(String tmplType,Model model) {
        NoticeTmplListVo vo = new NoticeTmplListVo();
        String result = "/setting/templates/ManualIndex";
        // 查找站长相同语言的信息模板内容
        vo.getSearch().setLocale(SessionManager.getLocale().toString());
        if (StringTool.isEmpty(tmplType)||NoticeTmplType.MANUAL.getCode().equals(tmplType)) {
            vo.getSearch().setTmplType(NoticeTmplType.MANUAL.getCode());
            vo = ServiceTool.noticeTmplService().searchManual(vo);
            model.addAttribute("tmplType",NoticeTmplType.MANUAL.getCode());
            model.addAttribute("reasonType",DictTool.get(DictEnum.NOTICE_REASON_TMPL_TYPE));
        } else {
            vo.getSearch().setTmplType(NoticeTmplType.AUTO.getCode());
            vo = ServiceTool.noticeTmplService().searchAuto(vo);
            model.addAttribute("tmplType",NoticeTmplType.AUTO.getCode());
            model.addAttribute("reasonType",DictTool.get(DictEnum.NOTICE_REASON_TMPL_TYPE_AUTO));
            result = "/setting/templates/SystemIndex";
        }

        model.addAttribute("command",vo.getGroupList());

        return result;
    }

    /**
     * 手动信息模板的优化的查询，存在问题：soul:button 的属性替换  TODO TOM AND HELP TONY
     * @param tmplType
     * @param model
     * @return
     */
    @RequestMapping("/manualIndexOptimization")
    public String manualIndexOptimization(String tmplType,Model model) {
        NoticeTmplListVo vo = new NoticeTmplListVo();
        String result = "/setting/templates/ManualIndex1";
        // 查找站长相同语言的信息模板内容
        vo.getSearch().setLocale(CommonContext.get().getLocale().toString());
        if (StringTool.isEmpty(tmplType)||NoticeTmplType.MANUAL.getCode().equals(tmplType)) {
            vo.getSearch().setTmplType(NoticeTmplType.MANUAL.getCode());
            vo = ServiceTool.noticeTmplService().searchBulitInManual(vo);
            model.addAttribute("tmplType",NoticeTmplType.MANUAL.getCode());
            model.addAttribute("reasonType",DictTool.get(DictEnum.NOTICE_REASON_TMPL_TYPE));
        } else {
            vo.getSearch().setTmplType(NoticeTmplType.AUTO.getCode());
            vo = ServiceTool.noticeTmplService().searchAuto(vo);
            model.addAttribute("tmplType",NoticeTmplType.AUTO.getCode());
            model.addAttribute("reasonType",DictTool.get(DictEnum.NOTICE_REASON_TMPL_TYPE_AUTO));
            result = "/setting/templates/SystemIndex";
        }

        model.addAttribute("command",vo);

        return result;
    }

    /**
     * 新增模板
     * @param model
     * @return
     */
    @RequestMapping("/createNoticeTmpl")
    @Token(generate = true)
    public String createNoticeTmpl(Model model) {
        siteLang(model);
        model.addAttribute("reasonType", DictTool.get(DictEnum.NOTICE_REASON_TMPL_TYPE));
        Map<String, Serializable> publishMethodMap = DictTool.get(DictEnum.NOTICE_PUBLISH_METHOD);
        publishMethodMap.remove("email");
        model.addAttribute("publishMethod",publishMethodMap);
        model.addAttribute("maxLang", MAX_LANG);
        model.addAttribute("validateRule", JsRuleCreator.create(NoticeTmplForm.class, null));
        return "/setting/templates/AddNoticeTmpl";
    }

    /**
     * 编辑邮件、手机模板
     * @param noticeTmpl
     * @param model
     * @return
     */
    @RequestMapping("/editNoticeTmpl")
    @Token(generate = true)
    public String editNoticeTmpl(NoticeTmpl noticeTmpl, Model model) {
        NoticeTmplVo vo = new NoticeTmplVo();
        vo.setResult(noticeTmpl);
        List<NoticeTmpl> noticeTmplList = ServiceTool.noticeTmplService().searchEditTmpl(vo);
        List<SiteLanguage> siteLanguageList = siteLang(model);
        if (CollectionTool.isNotEmpty(noticeTmplList) && CollectionTool.isNotEmpty(siteLanguageList)) {
            final SiteLanguage siteLanguage = siteLanguageList.get(0);
            Predicate predicate = new Predicate() {
                @Override
                public boolean evaluate(Object o) {
                    return ((NoticeTmpl)o).getLocale().equals(siteLanguage.getLanguage());
                }
            };
            Collection<NoticeTmpl> noticeTmpls = CollectionTool.filter(noticeTmplList, predicate);
            if (CollectionTool.isNotEmpty(noticeTmpls)) {
                model.addAttribute("firstLang", noticeTmpls.iterator().next());
            }
        }
        // 本应放在service中；考虑返回值就放到controller
        // 目的存在已编辑内容的状态线上已编辑
        List<NoticeTmpl> tempList = new ArrayList<>();
        if (CollectionTool.isNotEmpty(noticeTmplList) && CollectionTool.isNotEmpty(siteLanguageList)) {
            int index = 0;
            for(SiteLanguage siteLanguage : siteLanguageList) {
                for(NoticeTmpl nt : noticeTmplList) {
                    if (StringTool.isNotEmpty(siteLanguage.getLanguage()) && StringTool.isNotEmpty(nt.getLocale())) {
                        if (siteLanguage.getLanguage().equals(nt.getLocale())) {
                            tempList.add(nt);
                            if(StringTool.isNotEmpty(nt.getTitle()) || StringTool.isNotEmpty(nt.getContent())){
                                siteLanguageList.get(index).setIsEdit(true);
                            }

                        }
                    }
                }
                index++;
            }
        }
        NoticeParamRelationListVo noticeParamRelationListVo = new NoticeParamRelationListVo();
        noticeParamRelationListVo.getSearch().setEventType(noticeTmpl.getEventType());
        noticeParamRelationListVo = ServiceTool.noticeParamRelationService().search(noticeParamRelationListVo);
        model.addAttribute("tags", noticeParamRelationListVo.getResult());
        model.addAttribute("noticeTmpl", noticeTmpl);
        model.addAttribute("maxLang", MAX_LANG);
        model.addAttribute("validateRule", JsRuleCreator.create(NoticeTmplForm.class, null));
        model.addAttribute("noticeTmplListJson", StringEscapeUtils.unescapeHtml4(JsonTool.toJson(tempList)));
        if ("email".equals(noticeTmpl.getPublishMethod()) || "siteMsg".equals(noticeTmpl.getPublishMethod()) || "comet".equals(noticeTmpl.getPublishMethod())) {
            return MessageFormat.format("/setting/templates/Edit{0}Tmpl","Email");
        } else {
            return MessageFormat.format("/setting/templates/Edit{0}Tmpl",StringTool.capitalize(noticeTmpl.getPublishMethod()));
        }
    }

    /**
     * 保存模板
     * @param vo
     * @return
     */
    @RequestMapping("/saveNoticeTmpl")
    @ResponseBody
    @Token(valid = true)
    public Map saveNoticeTmpl(NoticeTmplVo vo, HttpServletRequest request) {
        vo.getSearch().setCreateUser(SessionManager.getUserId());
        vo = ServiceTool.noticeTmplService().saveNoticeTmpl(vo);
        Map map = new HashMap(2);
        if (vo.isSuccess()) {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, "save.success"));
            map.put("groupCode",vo.getResult().getGroupCode());
            map.put("eventType",vo.getResult().getEventType());
        } else {
            map.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
            if (StringTool.isNotEmpty(vo.getErrMsg())) {
                map.put("msg", LocaleTool.tranMessage(Module.MASTER_SETTING, vo.getErrMsg()));
            } else {
                map.put("msg", LocaleTool.tranMessage(_Module.COMMON, "save.failed"));
            }
        }
        map.put("state", Boolean.valueOf(vo.isSuccess()));
        return map;
    }

    /**
     * 恢复系统默认
     * @return
     */
    @RequestMapping("/resetActive")
    @ResponseBody
    public Map resetActive(String tmplType) {
        NoticeTmplListVo vo = new NoticeTmplListVo();
        vo.getSearch().setTmplType(tmplType);
//        vo.getSearch().setPublishMethod(NoticePublishMethod.SITE_MSG.getCode());
        vo = ServiceTool.noticeTmplService().resetActive(vo);
        Map map = new HashMap(2);
        if (vo.isSuccess()) {
            map.put("msg", LocaleTool.tranMessage(Module.COMMON, "reset.success"));
        } else {
            map.put("msg", LocaleTool.tranMessage(Module.COMMON, "reset.failed"));
        }
        map.put("state", Boolean.valueOf(vo.isSuccess()));
        return map;
    }

    /**
     * 保存设置
     * @return
     */
    @RequestMapping("/saveActive")
    @ResponseBody
    public Map saveActive(String noticeTmplSo) {
        List<NoticeTmplSo> noticeTmplSoList = JSONArray.parseArray(noticeTmplSo, NoticeTmplSo.class);
        NoticeTmplListVo vo = new NoticeTmplListVo();
        vo.setNoticeTmplSoList(noticeTmplSoList);
        if (CollectionTool.isNotEmpty(noticeTmplSoList)) {
            vo = ServiceTool.noticeTmplService().saveActive(vo);
        }
        if(vo.isSuccess()) {
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "save.success"));
        } else if(!vo.isSuccess()) {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "save.failed"));
        }

        return this.getVoMessage(vo);
    }

    /**
     * 删除
     * @return
     */
    @RequestMapping("/deleteAllNotDefault")
    @ResponseBody
    public Map deleteAllNotDefault(String code) {
        NoticeTmplVo vo = new NoticeTmplVo();
        vo.getSearch().setGroupCode(code);
        boolean isSuccess = ServiceTool.noticeTmplService().deleteAllNotDefault(vo);
        vo.setSuccess(isSuccess);
        if(isSuccess) {
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "delete.success"));
        } else if(!isSuccess) {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "delete.failed"));
        }

        return this.getVoMessage(vo);
    }

    /**
     * 恢复默认模板
     * @param vo
     * @return
     */
    @RequestMapping("/fillDefault")
    @ResponseBody
    public String fillDefault(NoticeTmplVo vo) {
        List<NoticeTmpl> noticeTmplList = ServiceTool.noticeTmplService().searchEditTmpl(vo);
        return JsonTool.toJson(noticeTmplList);
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

        model.addAttribute("siteLang", _siteLanguageList);
        return _siteLanguageList;
    }

    @RequestMapping("/getGroupSendTemplate")
    @ResponseBody
    public String getGroupSendTemplate(NoticeTmplListVo noticeTmplVo,@RequestParam("sendType")String sendType){
        noticeTmplVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(NoticeTmpl.PROP_EVENT_TYPE, Operator.EQ,ManualNoticeEvent.PLAYER_WITHDRAWAL_AUDIT_FAIL.getCode()),
                new Criterion(NoticeTmpl.PROP_TMPL_TYPE, Operator.EQ,NoticeTmplType.MANUAL.getCode()),
                new Criterion(NoticeTmpl.PROP_PUBLISH_METHOD, Operator.EQ,sendType)
        });
        noticeTmplVo.setPaging(null);
        noticeTmplVo = getService().search(noticeTmplVo);
        return JsonTool.toJson(noticeTmplVo.getResult());
    }

    @RequestMapping("/getNoticeParam")
    @ResponseBody
    public String getNoticeParam(NoticeParamRelationListVo vo) {
        vo = ServiceTool.noticeParamRelationService().search(vo);
        return JsonTool.toJson(vo.getResult());
    }

    @RequestMapping("/getNoBuiltIns")
    @ResponseBody
    public String getNoBuiltIns(NoticeTmplListVo vo) {
        vo.getSearch().setLocale(CommonContext.get().getLocale().toString());
        vo = ServiceTool.noticeTmplService().getNoBuiltIns(vo);
        return JsonTool.toJson(vo.getNoticeTmplSoList());
    }
    //endregion your codes 3

}