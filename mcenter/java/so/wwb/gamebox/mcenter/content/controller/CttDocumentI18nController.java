package so.wwb.gamebox.mcenter.content.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.log.LogFactory;
import org.soul.commons.math.NumberTool;
import org.soul.model.common.BaseVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.cache.Cache;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.content.ICttDocumentI18nService;
import so.wwb.gamebox.mcenter.content.form.CttDocumentForm;
import so.wwb.gamebox.mcenter.content.form.CttDocumentI18nForm;
import so.wwb.gamebox.mcenter.content.form.CttDocumentI18nSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.SendMessageTool;
import so.wwb.gamebox.model.common.ContentCheckEnum;
import so.wwb.gamebox.model.company.serve.po.SiteContentAudit;
import so.wwb.gamebox.model.company.serve.vo.SiteContentAuditVo;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.company.site.vo.SiteLanguageListVo;
import so.wwb.gamebox.model.master.content.enums.CttDocumentEnum;
import so.wwb.gamebox.model.master.content.po.CttDocument;
import so.wwb.gamebox.model.master.content.po.CttDocumentI18n;
import so.wwb.gamebox.model.master.content.vo.CttDocumentI18nListVo;
import so.wwb.gamebox.model.master.content.vo.CttDocumentI18nVo;
import so.wwb.gamebox.model.master.content.vo.CttDocumentListVo;
import so.wwb.gamebox.model.master.content.vo.CttDocumentVo;
import so.wwb.gamebox.model.master.enums.UserTaskEnum;
import so.wwb.gamebox.web.cache.CachePage;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.*;


/**
 * 控制器
 *
 * @author River
 * @time 2015-11-12 16:19:41
 */
@Controller
//region your codes 1
@RequestMapping("/cttDocumentI18n")
public class CttDocumentI18nController extends BaseCrudController<ICttDocumentI18nService, CttDocumentI18nListVo, CttDocumentI18nVo, CttDocumentI18nSearchForm, CttDocumentI18nForm, so.wwb.gamebox.model.master.content.po.CttDocumentI18n, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/cttdocument/";
        //endregion your codes 2
    }

    //region your codes 3
    private static final String EDIT_CONTENT = "/content/cttdocument/EditContent";

    @Override
    @Token(generate = true)
    public String create(CttDocumentI18nVo objectVo, Model model, HttpServletRequest request, HttpServletResponse response) {
        return super.create(objectVo, model, request, response);
    }

    @Override
    @Token(generate = true)
    public String edit(CttDocumentI18nVo objectVo, Integer id, Model model, HttpServletRequest request, HttpServletResponse response) {
        return super.edit(objectVo, id, model, request, response);
    }

    @Override
    protected CttDocumentI18nVo doCreate(CttDocumentI18nVo objectVo, Model model) {
        SiteLanguageListVo siteLanguageVo = new SiteLanguageListVo();
        siteLanguageVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageVo);//TODO 站长语言
        model.addAttribute("languageList", languageList);
        initData(objectVo, languageList);
        objectVo.setValidateRule(JsRuleCreator.create(CttDocumentI18nForm.class));
        objectVo.setDocumentId(this.getService().getCttDocumentId(objectVo));
        /*CttDocumentVo mainDocumentVo = new CttDocumentVo();
        mainDocumentVo.getResult().setId(this.getService().getCttDocumentId());
        objectVo.setCttDocumentVo(mainDocumentVo);*/
        //如果是新增子项
        if (objectVo.getSearch().getDocumentId() != null) {
            addSubCttDocument(objectVo);
        }
        return objectVo;
    }

    /**
     * 查詢父項
     *
     * @param objectVo
     */
    private void addSubCttDocument(CttDocumentI18nVo objectVo) {
        if (objectVo.getSearch().getDocumentId() != null) {
            CttDocumentVo cttDocumentVo = new CttDocumentVo();
            cttDocumentVo.getSearch().setId(objectVo.getSearch().getDocumentId());
            cttDocumentVo = this.getService().getCttDocumentById(cttDocumentVo);
            objectVo.setParentVo(cttDocumentVo.getResult());
        }
    }

    @Override
    protected CttDocumentI18nVo doEdit(CttDocumentI18nVo objectVo, Model model) {
        SiteLanguageListVo siteLanguageVo = new SiteLanguageListVo();
        siteLanguageVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageVo);//TODO 站长语言
        model.addAttribute("languageList", languageList);
        objectVo.setDocumentId(objectVo.getSearch().getDocumentId());
        //獲取主表數據
        CttDocumentVo cttDocumentVo = new CttDocumentVo();
        cttDocumentVo.getSearch().setId(objectVo.getSearch().getDocumentId());
        cttDocumentVo = this.getService().getCttDocumentById(cttDocumentVo);
        objectVo.setCttDocumentVo(cttDocumentVo.getResult());
        if (cttDocumentVo.getResult().getParentId() != null) {
            CttDocument parent = new CttDocument();
            parent.setId(cttDocumentVo.getResult().getParentId());
            objectVo.setParentVo(parent);
        }
        //獲取國際化數據
        CttDocumentI18nListVo listVo = new CttDocumentI18nListVo();
        listVo.getSearch().setDocumentId(objectVo.getSearch().getDocumentId());
        listVo = this.getService().search(listVo);
        listVo = genI18nData(languageList, listVo);
        objectVo.setDocumentI18ns(listVo.getResult());
        objectVo.setValidateRule(JsRuleCreator.create(CttDocumentI18nForm.class));
        return objectVo;
    }

    /**
     * 如果有新增语言版本，添加该版本
     *
     * @param languageList
     * @param listVo
     * @return
     */
    private CttDocumentI18nListVo genI18nData(List<SiteLanguage> languageList, CttDocumentI18nListVo listVo) {
        if (languageList == null || languageList.size() == 0) {
            return listVo;
        }
        if (listVo.getResult() == null || listVo.getResult().size() == 0) {
            List<CttDocumentI18n> list = new ArrayList<>();
            for (SiteLanguage language : languageList) {
                CttDocumentI18n i18n = new CttDocumentI18n();
                i18n.setLocal(language.getLanguage());
                i18n.setDocumentId(listVo.getSearch().getDocumentId());
                list.add(i18n);
            }
            listVo.setResult(list);
        } else {
            for (SiteLanguage language : languageList) {
                boolean languageFlag = false;
                for (CttDocumentI18n i18n : listVo.getResult()) {
                    if (language.getLanguage().equals(i18n.getLocal())) {
                        languageFlag = true;
                    }
                }
                if (!languageFlag) {
                    CttDocumentI18n i18n = new CttDocumentI18n();
                    i18n.setLocal(language.getLanguage());
                    i18n.setDocumentId(listVo.getSearch().getDocumentId());
                    listVo.getResult().add(i18n);
                }
            }
        }
        return listVo;
    }

    @RequestMapping(value = "savePreview")
    public String savePreview(CttDocumentI18nVo objectVo, Model model) {
        if (objectVo.getCttDocumentVo().getId() != null) {
            objectVo = toUpdateDocument(objectVo);
        } else {
            objectVo = saveNewCttDocument(objectVo);
        }
        SiteLanguageListVo siteLanguageVo = new SiteLanguageListVo();
        siteLanguageVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageVo);
        model.addAttribute("languageList", languageList);
        model.addAttribute("command", objectVo);
        return getViewBasePath() + "Preview";
    }

    @Override
    @Token(valid = true)
    public Map persist(CttDocumentI18nVo objectVo, @FormModel("result") @Valid CttDocumentI18nForm form, BindingResult result) {
        Map map = new HashMap();
        try{
            map = super.persist(objectVo, form, result);
            map.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
        }catch (Exception ex){
            LogFactory.getLog(this.getClass()).error(ex,"");
            map.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
            map.put("state",false);
        }

        return map;
    }
    @RequestMapping(value = "saveFromEditContent")
    @ResponseBody
    @Token(valid = true)
    public Map saveFromEditContent(CttDocumentI18nVo objectVo, @FormModel("result") @Valid CttDocumentForm form, BindingResult result){
        Map map = new HashMap();
        try{
            if (!result.hasErrors()) {
                objectVo = doPersist(objectVo);
            }else{
                objectVo.setSuccess(false);
            }
        }catch (Exception ex){
            LogFactory.getLog(this.getClass()).error(ex,"");
            map.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
            map.put("state",false);
        }
        return getVoMessage(objectVo);
    }

    @Override
    protected CttDocumentI18nVo doPersist(CttDocumentI18nVo objectVo) {

        if (objectVo.getCttDocumentVo().getId() == null) {
            //新增
            objectVo = saveNewCttDocument(objectVo);
            objectVo = this.getService().saveCttDocument(objectVo);
        } else {
            //修改
            objectVo = toUpdateDocument(objectVo);
            objectVo = this.getService().updateCttDocument(objectVo);
        }
        if (objectVo.isSuccess() && objectVo.isPublish()) {
            updateSiteContentAudit();
            //推送任务给运营商
            SendMessageTool.addTaskReminder(UserTaskEnum.COPYWRITER);
            SendMessageTool.sendAuditMessageToCcenter();
        }
        Cache.refreshContentDocument();
        Cache.refreshContentDocumentI18n();
        CachePage.refreshCurrentSitePageCache();
        return objectVo;
    }
    private void updateSiteContentAudit() {
        SiteContentAudit contentAudit = ServiceSiteTool.vCttDocumentUserService().countCompanyAuditCount(new CttDocumentVo());
        if(contentAudit==null){
            return;
        }
        SiteContentAudit oldRecord = getSiteContentAuditBySiteId();
        if(oldRecord==null){
            oldRecord = new SiteContentAudit();
            oldRecord.setSiteId(SessionManager.getSiteId());
            oldRecord.setDocumentReadCount(contentAudit.getDocumentTotalCount());
            oldRecord.setDocumentRemoveCount(contentAudit.getDocumentRemoveCount());
            oldRecord.setDocumentTotalCount(contentAudit.getDocumentTotalCount());
            SiteContentAuditVo vo = new SiteContentAuditVo();
            vo.setResult(oldRecord);
            ServiceTool.siteContentAuditService().insert(vo);
        }else{
            oldRecord.setDocumentReadCount(contentAudit.getDocumentReadCount());
            oldRecord.setDocumentRemoveCount(contentAudit.getDocumentRemoveCount());
            oldRecord.setDocumentTotalCount(contentAudit.getDocumentTotalCount());
            SiteContentAuditVo vo = new SiteContentAuditVo();
            vo.setResult(oldRecord);
            vo.setProperties(SiteContentAudit.PROP_DOCUMENT_READ_COUNT,SiteContentAudit.PROP_DOCUMENT_REMOVE_COUNT,SiteContentAudit.PROP_DOCUMENT_TOTAL_COUNT);
            ServiceTool.siteContentAuditService().updateOnly(vo);
        }
    }
    private SiteContentAudit getSiteContentAuditBySiteId(){
        SiteContentAuditVo siteContentAuditVo = new SiteContentAuditVo();
        siteContentAuditVo.getSearch().setSiteId(SessionManager.getSiteId());
        siteContentAuditVo = ServiceTool.siteContentAuditService().search(siteContentAuditVo);
        return siteContentAuditVo.getResult();
    }
    private CttDocumentI18nVo toUpdateDocument(CttDocumentI18nVo objectVo) {
        CttDocumentVo cttDocumentVo = new CttDocumentVo();
        cttDocumentVo.getSearch().setId(objectVo.getCttDocumentVo().getId());
        cttDocumentVo = ServiceSiteTool.cttDocumentService().get(cttDocumentVo);
        CttDocument cttDocument = cttDocumentVo.getResult();
        if (cttDocument != null) {
            cttDocument.setCode(objectVo.getCttDocumentVo().getCode());
            cttDocument.setUpdateUserId(SessionManager.getAuditUserId());
            cttDocument.setUpdateTime(new Date());
            cttDocument.setIsRead(false);
            cttDocument.setIsRemove(false);
        }
        if (objectVo.isPublish()) {
            cttDocument.setCheckStatus(ContentCheckEnum.PASS.getCode());
        }
        objectVo.setCttDocumentVo(cttDocument);
        return objectVo;
    }

    @Override
    protected Map getVoMessage(BaseVo baseVo) {
        Map map = super.getVoMessage(baseVo);
        map.put("doc", baseVo);
        return map;
    }

    /**
     * 新增
     *
     * @param objectVo
     * @author River
     */
    private CttDocumentI18nVo saveNewCttDocument(CttDocumentI18nVo objectVo) {
        //构造大项
        CttDocument cttDocument = buildNewCttDocument();
        cttDocument.setCode(objectVo.getCttDocumentVo().getCode());
        if (objectVo.getParentVo().getId() != null) {
            //新增子項
            cttDocument.setParentId(objectVo.getParentVo().getId());
        }
        //是否发布
        if (objectVo.isPublish()) {
            cttDocument.setPublishTime(new Date());
            //不需要审核直接通过
            cttDocument.setCheckStatus(ContentCheckEnum.PASS.getCode());
        }
        objectVo.setCttDocumentVo(cttDocument);

        return objectVo;
    }

    /**
     * 装组一个新的文案并初始化默认数据
     * 不带父ID，相当于自定义大类。
     *
     * @return
     */
    private CttDocument buildNewCttDocument() {
        CttDocument cttDocument = new CttDocument();
        cttDocument.setBuildIn(false);
        cttDocument.setCreateTime(new Date());
        cttDocument.setCreateUserId(SessionManager.getAuditUserId());
        cttDocument.setStatus(CttDocumentEnum.ON.getCode());
        cttDocument.setIsDelete(false);
        cttDocument.setIsRead(false);
        cttDocument.setIsRemove(false);
        return cttDocument;
    }

    /**
     * 初始空国际化數據
     *
     * @param objectVo
     * @param languageList
     * @author River
     */
    private void initData(CttDocumentI18nVo objectVo, List<SiteLanguage> languageList) {
        if (languageList == null || languageList.size() == 0) {
            return;
        }
        List<so.wwb.gamebox.model.master.content.po.CttDocumentI18n> tempList = new ArrayList<so.wwb.gamebox.model.master.content.po.CttDocumentI18n>();
        for (SiteLanguage lang : languageList) {
            so.wwb.gamebox.model.master.content.po.CttDocumentI18n i18n = new so.wwb.gamebox.model.master.content.po.CttDocumentI18n();
            i18n.setLocal(lang.getLanguage());
            i18n.setContent("");
            tempList.add(i18n);
        }
        objectVo.setDocumentI18ns(tempList);
    }

    /**
     * 下一步前将值缓存session
     *
     * @param objectVo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "saveInSession")
    @ResponseBody
    public Map<String, Object> saveInSession(CttDocumentI18nVo objectVo, Model model, HttpServletRequest request) {
        SessionManager.setCttDocument(objectVo);
        Map<String, Object> res = new HashMap<String, Object>();
        res.put("success", "true");
        return res;
    }

    /**
     * 编辑内容
     *
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "editContent")
    @Token(generate = true)
    public String editContent(CttDocumentI18nListVo cttDocumentI18NListVoListVo, Model model, HttpServletRequest request) {
        SiteLanguageListVo siteLanguageVo = new SiteLanguageListVo();
        siteLanguageVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageVo);
        CttDocumentI18nVo objectVo = SessionManager.getCttDocument();
        if (objectVo != null) {
            if (objectVo.getParentVo() != null && objectVo.getParentVo().getId() != null) {
                CttDocumentVo pvo = new CttDocumentVo();
                pvo.getSearch().setId(objectVo.getParentVo().getId());
                pvo = ServiceSiteTool.cttDocumentService().get(pvo);
                objectVo.setParentVo(pvo.getResult());
                CttDocumentI18nListVo i18nListVo = new CttDocumentI18nListVo();
                i18nListVo.getSearch().setDocumentId(objectVo.getParentVo().getId());
                i18nListVo.getSearch().setLocal(SessionManager.getLocale().toString());
                i18nListVo = ServiceSiteTool.cttDocumentI18nService().search(i18nListVo);
                if (i18nListVo != null && i18nListVo.getResult().size() > 0) {
                    objectVo.setParentTitle(i18nListVo.getResult().get(0).getTitle());
                }
            }

            if (objectVo.getCttDocumentVo().getId() != null) {
                cttDocumentI18NListVoListVo.getSearch().setDocumentId(objectVo.getCttDocumentVo().getId());
                cttDocumentI18NListVoListVo = this.getService().search(cttDocumentI18NListVoListVo);
            }
            List<so.wwb.gamebox.model.master.content.po.CttDocumentI18n> resultList = cttDocumentI18NListVoListVo.getResult();
            List<so.wwb.gamebox.model.master.content.po.CttDocumentI18n> tempList = objectVo.getDocumentI18ns();
            if (tempList != null && tempList.size() > 0 && resultList != null && resultList.size() > 0) {
                buildContent(resultList, tempList);
            }
        } else {
            objectVo = new CttDocumentI18nVo();

            cttDocumentI18NListVoListVo = this.getService().search(cttDocumentI18NListVoListVo);
            List<CttDocumentI18n> resultList = cttDocumentI18NListVoListVo.getResult();
            CttDocumentI18nListVo i18nListVo = new CttDocumentI18nListVo();
            i18nListVo.getSearch().setDocumentId(cttDocumentI18NListVoListVo.getSearch().getDocumentId());
            i18nListVo.setResult(resultList);
            i18nListVo = genI18nData(languageList, i18nListVo);
            objectVo.setDocumentI18ns(i18nListVo.getResult());

            CttDocumentVo cttDocumentVo = new CttDocumentVo();
            cttDocumentVo.getSearch().setId(cttDocumentI18NListVoListVo.getSearch().getDocumentId());
            cttDocumentVo = this.getService().getCttDocumentById(cttDocumentVo);
            CttDocument cttDocument = cttDocumentVo.getResult();
            objectVo.setCttDocumentVo(cttDocument);
            objectVo.setDocumentId(cttDocument == null ? null : cttDocument.getId());
        }

        Map<Object, so.wwb.gamebox.model.master.content.po.CttDocumentI18n> typeI18nMap = CollectionTool.toEntityMap(objectVo.getDocumentI18ns(), so.wwb.gamebox.model.master.content.po.CttDocumentI18n.PROP_LOCAL);
        model.addAttribute("i18nMap", typeI18nMap);
        setLocalTitle(model, objectVo.getDocumentI18ns());
        objectVo.setValidateRule(JsRuleCreator.create(CttDocumentForm.class));

        model.addAttribute("languageList", languageList);
        model.addAttribute("command", objectVo);
        SessionManager.setCttDocument(null);
        return EDIT_CONTENT;
    }

    /**
     * 设置本地化语言标题
     *
     * @param model
     * @param resultList
     */
    public void setLocalTitle(Model model, List<so.wwb.gamebox.model.master.content.po.CttDocumentI18n> resultList) {
        for (so.wwb.gamebox.model.master.content.po.CttDocumentI18n i18n : resultList) {
            if (SessionManager.getLocale().toString().equals(i18n.getLocal())) {
                model.addAttribute("localTitle", i18n.getTitle());
            }
        }
    }

    public void buildContent(List<so.wwb.gamebox.model.master.content.po.CttDocumentI18n> resultList, List<so.wwb.gamebox.model.master.content.po.CttDocumentI18n> tempList) {
        for (so.wwb.gamebox.model.master.content.po.CttDocumentI18n tempI18n : tempList) {
            setContent(resultList, tempI18n);
        }
    }

    /**
     * 设置原内容值和默认值
     *
     * @param resultList
     * @param tempI18n
     */
    public void setContent(List<so.wwb.gamebox.model.master.content.po.CttDocumentI18n> resultList, so.wwb.gamebox.model.master.content.po.CttDocumentI18n tempI18n) {
        for (so.wwb.gamebox.model.master.content.po.CttDocumentI18n i18n : resultList) {
            if (tempI18n.getLocal().equals(i18n.getLocal())) {
                tempI18n.setContent(i18n.getContent());
                tempI18n.setContentDefault(i18n.getContentDefault());
            }
        }
    }

    @RequestMapping(value = "/checkTitle")
    @ResponseBody
    public boolean checkTitle(@FormModel CttDocumentI18nForm cttDocumentI18nForm, HttpServletRequest request) {
        if (cttDocumentI18nForm != null) {
            if (cttDocumentI18nForm.getResult_id() == null) {
                cttDocumentI18nForm.setResult_id(request.getParameter("id"));
            }
            return checkSingleTitle(cttDocumentI18nForm.getDocumentI18ns$$_title()[0], cttDocumentI18nForm.getResult_id());
        } else {
            Map<String, String[]> paramMap = request.getParameterMap();
            if (paramMap != null) {
                Iterator<String> iterator = paramMap.keySet().iterator();
                String documentId = "";
                boolean flag = true;
                while (iterator.hasNext()) {
                    String key = iterator.next();
                    String[] val = paramMap.get(key);
                    documentId = paramMap.get("documentId")[0];
                    if (key.endsWith("].title")) {
                        flag = checkSingleTitle(val[0], documentId);
                        if (flag == false) {
                            break;
                        }
                    }
                }
                return flag;
            }
            return true;
        }


    }

    public boolean checkSingleTitle(String title, String documentId) {
        CttDocumentI18nListVo listVo = new CttDocumentI18nListVo();
        listVo.getSearch().setTitle(title);
        List<CttDocumentI18n> documentI18nList = this.getService().findCttDocumentI18n(listVo);
        if (documentI18nList != null && documentI18nList.size() > 0) {
            if (StringTool.isNotBlank(documentId)) {
                boolean flag = true;
                for (CttDocumentI18n i18n : documentI18nList) {
                    if (!documentId.equals(i18n.getDocumentId().toString())) {
                        flag = false;
                        break;
                    }
                }
                return flag;
            } else {
                return false;
            }
        }
        return true;
    }

    /**
     * 验证文案code是否唯一
     *
     * @param code
     * @return
     */
    @RequestMapping("/checkCode")
    @ResponseBody
    public boolean checkCode(@RequestParam("cttDocumentVo.code") String code, @RequestParam("result.id") String id, HttpServletRequest request) {
        CttDocumentListVo cttDocumentListVo = new CttDocumentListVo();
        cttDocumentListVo.getSearch().setCode(code);
        if (StringTool.isNotBlank(id)) {
            cttDocumentListVo.getSearch().setId(NumberTool.toInt(id));
        } else {
            String did = request.getParameter("documentId");
            if (StringTool.isNotBlank(did)) {
                cttDocumentListVo.getSearch().setId(NumberTool.toInt(did));
            }
        }
        return ServiceSiteTool.cttDocumentService().getCountByCode(cttDocumentListVo) <= 0;
    }
    //endregion your codes 3

}
