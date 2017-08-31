package so.wwb.gamebox.mcenter.content.controller;

import org.soul.commons.collections.MapTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.LogFactory;
import org.soul.commons.support._Module;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.content.ICttLogoService;
import so.wwb.gamebox.mcenter.content.form.CttLogoForm;
import so.wwb.gamebox.mcenter.content.form.CttLogoSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.SendMessageTool;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.common.ContentCheckEnum;
import so.wwb.gamebox.model.company.serve.po.SiteContentAudit;
import so.wwb.gamebox.model.company.serve.vo.SiteContentAuditVo;
import so.wwb.gamebox.model.master.content.po.CttLogo;
import so.wwb.gamebox.model.master.content.vo.CttLogoListVo;
import so.wwb.gamebox.model.master.content.vo.CttLogoVo;
import so.wwb.gamebox.model.master.content.vo.VCttLogoUserVo;
import so.wwb.gamebox.model.master.enums.UserTaskEnum;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


/**
 * 内容管理-LOGO表控制器
 *
 * @author snekey
 * @time 2015-8-3 9:56:48
 */
@Controller
//region your codes 1
@RequestMapping("/cttLogo")
public class CttLogoController extends BaseCrudController<ICttLogoService, CttLogoListVo, CttLogoVo, CttLogoSearchForm, CttLogoForm, CttLogo, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/cttlogo/";
        //endregion your codes 2
    }
    private static final String EDIT="/content/cttlogo/Edit";

    //region your codes 3


    @Override
    @Token(generate = true)
    public String create(CttLogoVo objectVo, Model model, HttpServletRequest request, HttpServletResponse response) {
        return super.create(objectVo, model, request, response);
    }

    @Override
    @Token(valid = true)
    public Map persist(CttLogoVo objectVo, @FormModel("result") @Valid CttLogoForm form, BindingResult result) {
        Map map = new HashMap();
        try {
            if(!result.hasErrors()){
                map = super.persist(objectVo, form, result);
                if(!MapTool.getBoolean(map,"state")){
                    map.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
                }else{
                    updateSiteContentAudit();
                }
            }else{
                map.put("state",false);
            }

        }catch (Exception ex){
            map.put("state",false);
            map.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
            LogFactory.getLog(this.getClass()).error(ex,"保存LOGO出错");
        }
        Cache.refreshSiteLogo(SessionManager.getSiteId());
        Cache.refreshCurrentSitePageCache();
        return map;
    }

    private void updateSiteContentAudit() {
        SiteContentAudit contentAudit = getService().countCompanyAuditCount(new CttLogoVo());
        if(contentAudit==null){
            return;
        }
        SiteContentAudit oldRecord = getSiteContentAuditBySiteId();
        if(oldRecord==null){
            oldRecord = new SiteContentAudit();
            oldRecord.setSiteId(SessionManager.getSiteId());
            oldRecord.setLogoReadCount(contentAudit.getLogoReadCount());
            oldRecord.setLogoRemoveCount(contentAudit.getLogoRemoveCount());
            oldRecord.setLogoTotalCount(contentAudit.getLogoTotalCount());
            SiteContentAuditVo vo = new SiteContentAuditVo();
            vo.setResult(oldRecord);
            ServiceTool.siteContentAuditService().insert(vo);
        }else{
            oldRecord.setLogoReadCount(contentAudit.getLogoReadCount());
            oldRecord.setLogoRemoveCount(contentAudit.getLogoRemoveCount());
            oldRecord.setLogoTotalCount(contentAudit.getLogoTotalCount());
            SiteContentAuditVo vo = new SiteContentAuditVo();
            vo.setResult(oldRecord);
            vo.setProperties(SiteContentAudit.PROP_LOGO_READ_COUNT,SiteContentAudit.PROP_LOGO_REMOVE_COUNT,SiteContentAudit.PROP_LOGO_TOTAL_COUNT);
            ServiceTool.siteContentAuditService().updateOnly(vo);
        }
    }

    private SiteContentAudit getSiteContentAuditBySiteId(){
        SiteContentAuditVo siteContentAuditVo = new SiteContentAuditVo();
        siteContentAuditVo.getSearch().setSiteId(SessionManager.getSiteId());
        siteContentAuditVo = ServiceTool.siteContentAuditService().search(siteContentAuditVo);
        return siteContentAuditVo.getResult();
    }

    @Override
    protected CttLogoVo doCreate(CttLogoVo objectVo, Model model) {
        //新增前先从数据生成一个主键
        objectVo.setLogoId(this.getService().getCttLogoId(objectVo));
        //设置最大可用时间
        Date maxTime= this.getService().getMaxDate(new CttLogoVo());;
        model.addAttribute("maxEndTime", DateTool.addSeconds(maxTime,1));
        return super.doCreate(objectVo, model);
    }

    /**
     * 编辑页面
     * @param objectVo
     * @param id
     * @param model
     * @param request
     * @param response
     * @return
     */
    @RequestMapping({"/edit"})
    @Token(generate = true)
    public String edit(CttLogoVo objectVo, Integer id, Model model, HttpServletRequest request, HttpServletResponse response) {
        this.checkResult(objectVo);
        objectVo.setLogoId(id);
        objectVo.getSearch().setId(id);
        objectVo = this.doEdit(objectVo, model);
        //Date maxTime= this.getService().getMaxDate(new CttLogoVo());
        //maxTime = DateTool.addSeconds(maxTime,1);
        //model.addAttribute("maxEndTime",maxTime);
        model.addAttribute("command", objectVo);
        if(objectVo.getResult().getIsDefault()) {
        } else {
            objectVo.setValidateRule(JsRuleCreator.create(CttLogoForm.class, "result"));
        }
        return EDIT;
    }

    @Override
    protected CttLogoListVo doList(CttLogoListVo listVo, CttLogoSearchForm form, BindingResult result, Model model) {
        setCommonData(model);
        CttLogoListVo newListVo = this.getService().doCttLogoList(listVo);
        newListVo.setHasReturn(listVo.getHasReturn());
        return newListVo;//this.getService().search(listVo);
    }

    private void setCommonData(Model model) {
        Date date = new Date();
        model.addAttribute("date",date);
        CttLogo usingLogo = this.getService().getCustomerLogoUsing(new CttLogoVo());
        if(usingLogo!=null){
            model.addAttribute("hasUsing","true");
        }else{
            model.addAttribute("hasUsing","false");
        }
    }

    @Override
    protected CttLogoVo doUpdate(CttLogoVo objectVo) {
        objectVo.getSearch().setId(objectVo.getResult().getId());
        objectVo = setLogoCheckStatus(objectVo);
        //如果状态更新为了待审核,那表示重新提交了审核
        /*if(ContentCheckEnum.CHECKING.getCode().equals(objectVo.getResult().getCheckStatus())){
            String msg = LocaleTool.tranMessage("content","logo.waitForMessage");
            objectVo.setOkMsg(msg);
        }*/
        objectVo.setProperties(CttLogo.PROP_UPDATE_TIME, CttLogo.PROP_UPDATE_USER, CttLogo.PROP_PUBLISH_TIME,CttLogo.PROP_FLASH_LOGO_PATH,
                CttLogo.PROP_IS_READ,CttLogo.PROP_IS_REMOVE,
                CttLogo.PROP_START_TIME, CttLogo.PROP_END_TIME, CttLogo.PROP_NAME, CttLogo.PROP_PATH, CttLogo.PROP_CHECK_STATUS);
        objectVo = this.getService().updateLogo(objectVo);
        //推送任务给运营商
        SendMessageTool.addTaskReminder(UserTaskEnum.ACTIVITY);
        SendMessageTool.sendAuditMessageToCcenter();
        return objectVo;
    }

    private CttLogoVo setLogoCheckStatus(CttLogoVo objectVo){
        CttLogoVo oldLogo = this.getService().get(objectVo);
        if(oldLogo.getResult()==null||objectVo.getResult()==null){
            return objectVo;
        }
        Date date = new Date();
        objectVo.getResult().setUpdateTime(date);
        objectVo.getResult().setUpdateUser(SessionManager.getAuditUserId());
        objectVo.getResult().setIsRemove(false);
        objectVo.getResult().setIsRead(false);
        objectVo.getResult().setPublishTime(date);
        return objectVo;

    }

    @Override
    protected CttLogoVo doSave(CttLogoVo objectVo) {
        Date date = new Date();
        objectVo.getResult().setId(objectVo.getLogoId());
        objectVo.getResult().setIsDefault(false);
        objectVo.getResult().setCreateTime(date);
        objectVo.getResult().setPublishTime(date);
        objectVo.getResult().setCreateUser(SessionManager.getAuditUserId());
        objectVo.getResult().setCheckStatus(ContentCheckEnum.PASS.getCode());
        objectVo.getResult().setIsDelete(false);
        objectVo.getResult().setIsRead(false);
        objectVo.getResult().setIsRemove(false);

        //推送任务给运营商
        SendMessageTool.addTaskReminder(UserTaskEnum.ADDLOGO);
        SendMessageTool.sendAuditMessageToCcenter();
        return this.getService().saveLogo(objectVo);
    }

    /**
     * 编辑默认logo
     * @param objectVo
     * @param result
     * @return
     */
    @RequestMapping("/editDefault")
    @ResponseBody
    @Token(valid = true)
    public Map editDefault(CttLogoVo objectVo, BindingResult result) {
        Map map = new HashMap();
        if(!result.hasErrors()) {
            try{
                objectVo.getSearch().setId(objectVo.getResult().getId());
                objectVo = setLogoCheckStatus(objectVo);
                objectVo = this.getService().updateLogo(objectVo);
                map = this.getVoMessage(objectVo);
                if(!objectVo.isSuccess()){
                    map.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
                }
            }catch (Exception ex){
                map.put("state",false);
                map.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
                LogFactory.getLog(this.getClass()).error(ex,"编辑默认LOGO出错");
            }
        } else {
            map.put("state",false);
            map.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
            return map;
        }
        Cache.refreshSiteLogo(SessionManager.getSiteId());
        Cache.refreshCurrentSitePageCache();
        return map;
    }

    /**
     * 远程验证开始时间；
     * @param request
     * @param startTime
     * @return
     */
    @RequestMapping("/checkStartTime")
    @ResponseBody
    public String checkStartTime(HttpServletRequest request,@RequestParam("result.startTime")Date startTime,@RequestParam("result.endTime")Date endTime,@RequestParam("result.id")Integer id){
        CttLogoListVo cttLogoListVo=new CttLogoListVo();
        cttLogoListVo.getSearch().setCreateTime(startTime);
        cttLogoListVo.getSearch().setEndTime(endTime);
        cttLogoListVo.getSearch().setId(id);
        Integer num=this.getService().IntervalExistence(cttLogoListVo);
        if(num>0){
            return "false";
        }
        return "true";
    }
    /**
     * 远程验证开始时间；
     * @param request
     * @param startTime
     * @return
     */
    @RequestMapping("/checkEndTime")
    @ResponseBody
    public String checkEndTime(HttpServletRequest request,@RequestParam("result.startTime")Date startTime,@RequestParam("result.endTime")Date endTime,@RequestParam("result.id")Integer id){
        CttLogoListVo cttLogoListVo=new CttLogoListVo();
        cttLogoListVo.getSearch().setCreateTime(startTime);
        cttLogoListVo.getSearch().setEndTime(endTime);
        cttLogoListVo.getSearch().setId(id);
        Integer num=this.getService().IntervalExistence(cttLogoListVo);
        if(num>0){
            return "false";
        }
        return "true";
    }
    /**
     * 结束时间应大于开始时间；
     * @param request
     * @param startTime
     * @param endTime
     * @return
     */
    @RequestMapping("/checkTime")
    @ResponseBody
    public String checkTime(HttpServletRequest request,@RequestParam("result.startTime")Date startTime,@RequestParam("result.endTime")Date endTime){
        return startTime.getTime() >= endTime.getTime() ? "false" : "true";
    }

    /**
     * 批量删除logo；
     * @param cttLogoVo
     * @return
     */
    @RequestMapping("/batchDeleteLogo")
    @ResponseBody
    public Map batchDeleteLogo(CttLogoVo cttLogoVo){
        cttLogoVo = this.getService().batchDeleteLogo(cttLogoVo);
        String msg = LocaleTool.tranMessage(_Module.COMMON, "delete.success");
        if(!cttLogoVo.isSuccess()){
            msg = LocaleTool.tranMessage(_Module.COMMON, "delete.failed");
        }
        Cache.refreshSiteLogo();
        Cache.refreshCurrentSitePageCache();
        HashMap map = new HashMap(2,1f);
        map.put("msg", msg);
        map.put("state", cttLogoVo.isSuccess());
        return map;
    }
    @RequestMapping("/showLogoDetail")
    public String showLogoDetail(CttLogoVo cttLogoVo,Model model){
        setCommonData(model);
        VCttLogoUserVo logoUserVo = new VCttLogoUserVo();
        logoUserVo.getSearch().setId(cttLogoVo.getSearch().getId());
        logoUserVo = ServiceTool.vCttLogoUserService().get(logoUserVo);
        //cttLogoVo = this.getService().get(cttLogoVo);
        model.addAttribute("command",logoUserVo);
        return getViewBasePath() +"LogoDetail";
    }
    //endregion your codes 3

}