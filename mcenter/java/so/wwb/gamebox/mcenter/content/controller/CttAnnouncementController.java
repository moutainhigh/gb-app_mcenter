package so.wwb.gamebox.mcenter.content.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.enums.EnumTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.query.sort.Direction;
import org.soul.commons.support._Module;
import org.soul.model.log.audit.enums.OpType;
import org.soul.model.sys.po.SysDict;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import so.wwb.gamebox.common.cache.Cache;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.content.ICttAnnouncementService;
import so.wwb.gamebox.mcenter.content.form.CttAnnouncementForm;
import so.wwb.gamebox.mcenter.content.form.CttAnnouncementSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.ModuleType;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.company.site.po.SiteLanguage;
import so.wwb.gamebox.model.company.site.vo.SiteLanguageListVo;
import so.wwb.gamebox.model.master.content.enums.CttAnnouncementTypeEnum;
import so.wwb.gamebox.model.master.content.enums.IntervalTimeEnum;
import so.wwb.gamebox.model.master.content.po.CttAnnouncement;
import so.wwb.gamebox.model.master.content.vo.CttAnnouncementListVo;
import so.wwb.gamebox.model.master.content.vo.CttAnnouncementVo;
import so.wwb.gamebox.web.BussAuditLogTool;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;
import so.wwb.gamebox.web.init.ConfigBase;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 内容管理-公告表控制器
 *
 * @author snekey
 * @time 2015-8-19 14:25:39
 */
@Controller
//region your codes 1
@RequestMapping("/cttAnnouncement")
public class CttAnnouncementController extends BaseCrudController<ICttAnnouncementService, CttAnnouncementListVo, CttAnnouncementVo, CttAnnouncementSearchForm, CttAnnouncementForm, CttAnnouncement, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/announcement/";
        //endregion your codes 2
    }

    //region your codes 3
    private static final String EDIT = "/content/announcement/Edit";

    private final static String ORDER_URL = "/content/announcement/OrderAnnouncement";

    @Override
    protected CttAnnouncementListVo doList(CttAnnouncementListVo listVo, CttAnnouncementSearchForm form, BindingResult result, Model model) {
        if(StringTool.isBlank(listVo.getSearch().getAnnouncementType())){
            listVo.getSearch().setAnnouncementType(CttAnnouncementTypeEnum.SITE_ANNOUNCEMENT.getCode());
        }
        String s = SessionManager.getLocale().toString();
        listVo.getSearch().setLocalLanguage(s);
        String announcementType = listVo.getSearch().getAnnouncementType();
        if (CttAnnouncementTypeEnum.SITE_ANNOUNCEMENT.getCode().equals(announcementType) ||
                CttAnnouncementTypeEnum.BANK_ANNOOUNCEMENT.getCode().equals(announcementType)){
            listVo.getQuery().addOrder(CttAnnouncement.PROP_ORDER_NUM, Direction.ASC);
        }
        Map<String, SysDict> types = DictTool.get(DictEnum.CONTENT_CTTANNOUNCEMENT_TYPE);
        model.addAttribute("types", types);
        return this.getService().search(listVo);
    }

    /**
     * 新增公告；
     *
     * @param listVo
     * @param model
     * @return
     */
    @RequestMapping("/addAnnouncement")
    @Token(generate = true)
    public String addAnnouncement(CttAnnouncementListVo listVo, Model model) {
        listVo.setValidateRule(JsRuleCreator.create(CttAnnouncementForm.class, "result"));
        SiteLanguageListVo siteLanguageVo = new SiteLanguageListVo();
        siteLanguageVo.getSearch().setSiteId(SessionManager.getSiteId());
        Map<String, SysDict> types = DictTool.get(DictEnum.CONTENT_CTTANNOUNCEMENT_TYPE);
        //从公司入款和线上支付添加公告
        if (StringTool.isNotBlank(listVo.getAnnouncementType())) {
            SysDict dict = types.get(listVo.getAnnouncementType());
            if (dict != null) {
                types.clear();
                types.put(listVo.getAnnouncementType(), dict);
            }

        } else {
            //设置默认显示的公告
            listVo.setAnnouncementType(CttAnnouncementTypeEnum.SITE_ANNOUNCEMENT.getCode());
        }
        model.addAttribute("types", types);
        List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageVo);//TODO 站长语言
        Map<Object, CttAnnouncement> cttAnnouncementMap = CollectionTool.toEntityMap(listVo.getResult(), CttAnnouncement.PROP_LANGUAGE);
        model.addAttribute("cttAnnouncementMap",cttAnnouncementMap);
        model.addAttribute("languageList", languageList);
        model.addAttribute("command", listVo);
        List intervalTime = EnumTool.getEnumList(IntervalTimeEnum.class);
        if(CttAnnouncementTypeEnum.LOGIN_ANNOUNCEMENT.getCode().equals(listVo.getAnnouncementType())){
            intervalTime.remove(0);
        }
        model.addAttribute("intervalTime", intervalTime);
        return EDIT;
    }

    /**
     * 新增和编辑公告的保存功能；
     *
     * @param listVo
     * @return
     */
    @RequestMapping("/batchSave")
    @ResponseBody
    @Token(valid = true)
    public Map batchSave(CttAnnouncementListVo listVo) {
        listVo.setUserId(SessionManager.getUserId());
        listVo = ServiceTool.cttAnnouncementService().updateAnnouncement(listVo);
        Cache.refreshSiteAnnouncement();
        Cache.refreshCurrentSitePageCache(ConfigBase.get().getPageKey());
        Map<String, Object> map = getVoMessage(listVo);
        if (!listVo.isSuccess()) {
            map.put(TokenHandler.TOKEN_VALUE, TokenHandler.generateGUID());
        }
        return map;
    }

    @RequestMapping("/preview")
    public String preview(CttAnnouncementListVo listVo) {

        return EDIT;
    }

    /**
     * 批量删除公告；
     *
     * @param announcementVo
     * @return
     */
    @RequestMapping("/batchDeleteAnn")
    @ResponseBody
    @Audit(module = Module.MASTER_CONTENT, moduleType = ModuleType.MASTER_CONTENT_BATCHDELETEANN_SUCCESS, opType = OpType.DELETE)
    public Map batchDeleteAnn(CttAnnouncementVo announcementVo) {
        //拿到页面上带过来的uuid；
        List<String> uuidCode = announcementVo.getSearch().getUuidCodes();
        String msg;
        boolean success;
        if (uuidCode.size() != 0) {
            success = getService().deleteByCodes(announcementVo) > 0;
            msg = LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_SUCCESS);
        } else {
            success = false;
            msg = LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_FAILED);
        }
        //日志
        if (success) {
            BussAuditLogTool.addBussLog(Module.MASTER_CONTENT, ModuleType.MASTER_CONTENT_BATCHDELETEANN_SUCCESS, OpType.DELETE,
                    "MASTER_CONTENT_BATCHDELETEANN_SUCCESS", Integer.valueOf(uuidCode.size()).toString());
        }
        HashMap map = new HashMap(2,1f);
        map.put("msg", msg);
        map.put("state", success);
        //
        Cache.refreshSiteAnnouncement();
        Cache.refreshCurrentSitePageCache(ConfigBase.get().getPageKey());
        return map;
    }

    /**
     * 编辑公告；
     *
     * @param cttAnnouncementListVo
     * @param model
     * @return
     */
    @RequestMapping("/editByCode")
    @Token(generate = true)
    public String editByCode(CttAnnouncementListVo cttAnnouncementListVo, Model model) {
//        List<SysSiteLanguage> languageList = ServiceTool.sysSiteLanguageService().getBySiteId(new SysSiteLanguageVo());TODO 站长语言
//        model.addAttribute("languageList",languageList);TODO 站长语言
        cttAnnouncementListVo = this.getService().search(cttAnnouncementListVo);
        cttAnnouncementListVo.setUuid(cttAnnouncementListVo.getSearch().getUuidCodes().get(0));
        model.addAttribute("command", cttAnnouncementListVo);
        SiteLanguageListVo siteLanguageVo = new SiteLanguageListVo();
        siteLanguageVo.getSearch().setSiteId(SessionManager.getSiteId());
        List<SiteLanguage> languageList = ServiceTool.siteLanguageService().availableLanguage(siteLanguageVo);//TODO 站长语言
        model.addAttribute("languageList", languageList);
        cttAnnouncementListVo.setValidateRule(JsRuleCreator.create(CttAnnouncementForm.class, ""));
        cttAnnouncementListVo.setTiming(cttAnnouncementListVo.getResult().get(0).getPublishTime());
        cttAnnouncementListVo.setTask(cttAnnouncementListVo.getResult().get(0).getIsTask());
        cttAnnouncementListVo.setAnnouncementType(cttAnnouncementListVo.getResult().get(0).getAnnouncementType());
        Map<String, SysDict> types = DictTool.get(DictEnum.CONTENT_CTTANNOUNCEMENT_TYPE);
        model.addAttribute("types", types);
        Map<Object, CttAnnouncement> cttAnnouncementMap = CollectionTool.toEntityMap(cttAnnouncementListVo.getResult(), CttAnnouncement.PROP_LANGUAGE);
        model.addAttribute("cttAnnouncementMap",cttAnnouncementMap);
        model.addAttribute("countdown", cttAnnouncementListVo.getResult().get(0).getCountdown());
        List intervalTime = EnumTool.getEnumList(IntervalTimeEnum.class);
        intervalTime.remove(0);
        model.addAttribute("intervalTime", intervalTime);
        return EDIT;
    }

    /**
     * 远程验证，定时发送时间需要大于本地时间
     *
     * @param request
     * @param timing
     * @return
     */
    @RequestMapping("/checkTime")
    @ResponseBody
    public String checkTime(HttpServletRequest request, @RequestParam("timing") Date timing, @RequestParam("task") String task) {
        if (task.equals("true")) {
            return timing.getTime() > new Date().getTime() ? "true" : "false";
        }
        return "true";
    }

    @RequestMapping("/changeStatus")
    @ResponseBody
    public Map changeStatus(CttAnnouncementVo vo){
        vo.setProperties(CttAnnouncement.PROP_DISPLAY);
        vo = getService().changeAnnouncementStatus(vo);
        Cache.refreshSiteAnnouncement();
        Cache.refreshCurrentSitePageCache(ConfigBase.get().getPageKey());
        return getVoMessage(vo);
    }

    @RequestMapping("/orderCttAnnouncement")
    public String orderCttAnnouncement(CttAnnouncementListVo cttAnnouncementListVo, Model model){
        cttAnnouncementListVo.setPaging(null);
        String s = SessionManager.getLocale().toString();
        cttAnnouncementListVo.getSearch().setLocalLanguage(s);
        cttAnnouncementListVo.getQuery().addOrder(CttAnnouncement.PROP_ORDER_NUM, Direction.ASC);
        cttAnnouncementListVo = this.getService().search(cttAnnouncementListVo);
        model.addAttribute("command",cttAnnouncementListVo);
        return ORDER_URL;
    }

    @RequestMapping(value = "/saveCttAnnouncementOrder",method = RequestMethod.POST ,headers = {"Content-type=application/json"})
    @ResponseBody
    public boolean saveCttAnnouncementOrder(@RequestBody CttAnnouncementVo cttAnnouncementVo, Model model){
        this.getService().saveCttAnnouncementOrder(cttAnnouncementVo);
        Cache.refreshSiteAnnouncement();
        Cache.refreshCurrentSitePageCache(ConfigBase.get().getPageKey());
        return true;
    }
    //endregion your codes 3

}
