package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.ArrayTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.query.sort.Direction;
import org.soul.commons.support._Module;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.company.site.IVSiteContactsService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.VSiteContactsForm;
import so.wwb.gamebox.mcenter.setting.form.VSiteContactsSearchForm;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.company.site.po.VSiteContacts;
import so.wwb.gamebox.model.company.site.vo.*;
import so.wwb.gamebox.web.common.token.Token;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.Serializable;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * 系统联系人视图-lorne控制器
 *
 * @author loong
 * @time 2015-8-11 14:25:59
 */
@Controller
//region your codes 1
@RequestMapping("/vSiteContacts")
public class VSiteContactsController extends BaseCrudController<IVSiteContactsService, VSiteContactsListVo, VSiteContactsVo, VSiteContactsSearchForm, VSiteContactsForm, VSiteContacts, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/contacts/";
        //endregion your codes 2
    }

    //region your codes 3
    @Override
    protected VSiteContactsListVo doList(VSiteContactsListVo listVo, VSiteContactsSearchForm form, BindingResult result, Model model) {
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo._setDataSourceId(SessionManager.getSiteParentId());
        listVo.getQuery().addOrder(VSiteContacts.PROP_CREATE_TIME, Direction.DESC);
        VSiteContactsListVo search = this.getService().search(listVo);
        Map<String, Serializable> sexDict = DictTool.get(DictEnum.COMMON_SEX);
        search.setSexDict(sexDict);
        return search;
    }

    @Override
    protected VSiteContactsVo doCreate(VSiteContactsVo objectVo, Model model) {
        Map<String, Serializable> sexDict = DictTool.get(DictEnum.COMMON_SEX);
        objectVo = super.doCreate(objectVo,model);
        objectVo.setSexDict(sexDict);
        return objectVo;
    }

    @Override
    @Token(generate = true)
    public String create(VSiteContactsVo objectVo, Model model, HttpServletRequest request, HttpServletResponse response) {
        return super.create(objectVo, model, request, response);
    }

    @Override
    protected VSiteContactsVo doEdit(VSiteContactsVo objectVo, Model model) {
        objectVo = this.getService().get(objectVo);
        Map<String, Serializable> sexDict = DictTool.get(DictEnum.COMMON_SEX);
        objectVo.setSexDict(sexDict);
        return objectVo;
    }

    /**
     * 保存联系人
     * @param objectVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping({"/save"})
    @ResponseBody
    @Token(valid = true)
    public Map save(VSiteContactsVo objectVo, @FormModel("result") @Valid VSiteContactsForm form, BindingResult result) {
         if(!result.hasErrors()) {
             if(objectVo.isSuccess()) {
                 Object id = objectVo.getResult().getId();
                 if(id != null && !"".equals((id + "").trim())) {
                     objectVo = this.getService().updateContacts(objectVo);
                 } else {
                     objectVo.getResult().setCreateTime(new Date());
                     objectVo.getResult().setCreateUser(SessionManager.getUserId());
                     objectVo.getResult().setSiteId(SessionManager.getSiteId());
                     objectVo._setDataSourceId(SessionManager.getSiteParentId());
                     objectVo = this.getService().save(objectVo);
                 }
             }

            return this.getVoMessage(objectVo);
        } else {
            return null;
        }
    }

    /**
     *删除联系人
     * @param ids
     * @return
     */
    @RequestMapping({"/batchDelete"})
    @ResponseBody
    public Map batchDelete(Integer[] ids) {
        SiteContactsVo vo = new SiteContactsVo();
        if(ArrayTool.isEmpty(ids)){
            vo.setSuccess(false);
            return this.getVoMessage(vo);
        }
        vo.setIds(Arrays.asList(ids));
        vo = this.getService().batchDelete(vo);
        if(vo.isSuccess()){
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_SUCCESS));
        }
        return this.getVoMessage(vo);
    }

    /**
     * 跳转到职位管理
     * @param model
     * @return
     */
    @RequestMapping({"/toPosition"})
    @Token(generate = true)
    public String toPosition(Model model,SiteContactsPositionListVo siteContactsPositionListVo){
        siteContactsPositionListVo.getSearch().setSiteId(SessionManager.getSiteId());
        List list = ServiceTool.siteContactsPositionService().findAllPosition(siteContactsPositionListVo);
        model.addAttribute("list",list);
        return this.getViewBasePath()+"Position";
    }

    /**
     * 保存职位
     * @param vo
     * @return
     */
    @RequestMapping({"/savePosition"})
    @ResponseBody
    @Token(valid = true)
    public Map savePosition(SiteContactsPositionVo vo){
        vo.setCreateTime(new Date());
        vo.setCreateUser(SessionManager.getUserId());
        vo._setDataSourceId(SessionManager.getSiteParentId());
        vo.getSearch().setSiteId(SessionManager.getSiteId());
        vo = ServiceTool.siteContactsPositionService().savePosition(vo);
        return this.getVoMessage(vo);
    }

    /**
     * Ajax查询职位列表
     * @return
     */
    @RequestMapping({"/queryPositionList"})
    @ResponseBody
    public String queryPositionList(SiteContactsPositionListVo siteContactsPositionListVo){
        siteContactsPositionListVo._setDataSourceId(SessionManager.getSiteParentId());
        siteContactsPositionListVo.getSearch().setSiteId(SessionManager.getSiteId());
        siteContactsPositionListVo.setPaging(null);
        siteContactsPositionListVo= ServiceTool.siteContactsPositionService().search(siteContactsPositionListVo);
        return JsonTool.toJson(siteContactsPositionListVo.getResult());
    }


    //endregion your codes 3

}