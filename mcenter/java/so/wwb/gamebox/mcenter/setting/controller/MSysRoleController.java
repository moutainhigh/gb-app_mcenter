package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.model.listop.po.SysListOperator;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.session.SessionManagerBase;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.iservice.master.setting.ISysRoleService;
import so.wwb.gamebox.mcenter.init.ConfigManager;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.SysRoleForm;
import so.wwb.gamebox.mcenter.setting.form.SysRoleSearchForm;
import so.wwb.gamebox.model.listop.StatusEnum;
import so.wwb.gamebox.model.master.setting.po.SysRole;
import so.wwb.gamebox.model.master.setting.vo.SysRoleListVo;
import so.wwb.gamebox.model.master.setting.vo.SysRoleVo;

import java.util.Date;
import java.util.HashMap;

/**
 * @author: tom
 * @date: 15-7-10
 */
@Controller
@RequestMapping("/msysRole")
public class MSysRoleController extends BaseCrudController<ISysRoleService, SysRoleListVo, SysRoleVo, SysRoleSearchForm, SysRoleForm, SysRole, Integer> {

    private static final Log LOG = LogFactory.getLog(MSysRoleController.class);

    @Override
    protected String getViewBasePath() {
        return "/setting/privilege/sysRole/";
    }

    /*private final static List<Pair<String,String>> statusItems = new ArrayList<>();

    static {
        statusItems.add(new Pair<String, String>("启用","1"));
        statusItems.add(new Pair<String, String>("禁用","2"));
    }*/

    @Override
    protected SysRoleListVo doList(SysRoleListVo listVo, SysRoleSearchForm form, BindingResult result, Model model) {
        listVo.getSearch().setCreateUser(SessionManager.getUserId());
        listVo.getSearch().setSubsysCode(ConfigManager.getConfigration().getSubsysCode());
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo = super.doList(listVo, form, result, model);
        listVo.setAllFieldLists(new HashMap<String, SysListOperator>());
        return listVo;
    }

    @Override
    protected SysRoleVo doCreate(SysRoleVo objectVo, Model model) {
        try {
            SysRole sysRole = new SysRole();
            sysRole.setSubsysCode(ConfigManager.getConfigration().getSubsysCode());

            objectVo.setResult(sysRole);
        } catch (Exception e) {
            LOG.error(e);
        }

        return objectVo;
    }

    /**
     * 编辑角色
     * @param sysRoleVo
     * @return
     */
    @Override
    protected SysRoleVo doPersist(SysRoleVo sysRoleVo) {
        Integer id = sysRoleVo.getResult().getId();

        sysRoleVo.getResult().setSubsysCode(ConfigManager.getConfigration().getSubsysCode());
        sysRoleVo.getResult().setBuiltIn(false);
        if (sysRoleVo.getResult().getStatus()==null) {
            //TODO: bool 类型统一使用 YesNot enum
            sysRoleVo.getResult().setStatus(Integer.valueOf(StatusEnum.ROLE_ENABLE.getCode()));
        }
        sysRoleVo.getResult().setSiteId(SessionManager.getSiteId());

        SysRoleVo result;
        if(id != null && !"".equals((id + "").trim())) {
            SysRole _sysRole = getSysroleById(id);
            sysRoleVo.getResult().setCreateTime(_sysRole.getCreateTime());
            sysRoleVo.getResult().setCreateUser(_sysRole.getCreateUser());
            sysRoleVo.getResult().setUpdateTime(new Date());
            sysRoleVo.getResult().setUpdateUser(SessionManager.getUserId());
            result = this.doUpdate(sysRoleVo);
        } else {
            sysRoleVo.getResult().setCreateTime(new Date());
            sysRoleVo.getResult().setCreateUser(SessionManagerBase.getUserId());
            result = this.doSave(sysRoleVo);
        }

        sysRoleVo.setSuccess(result != null);
        return sysRoleVo;
    }

    @RequestMapping("/role_permission")
    protected String rolePermission(Integer roleId,Model model) {
        model.addAttribute("roleId",roleId);
        return "/setting/privilege/sysResource/Index";
    }

    @Override
    protected SysRoleVo doEdit(SysRoleVo objectVo, Model model) {
        /*model.addAttribute("statusItems",statusItems);*/
        return super.doEdit(objectVo, model);
    }

    @Override
    protected SysRoleVo doView(SysRoleVo objectVo, Model model) {
        /*model.addAttribute("statusItems",statusItems);*/
        return super.doView(objectVo, model);
    }

    /**
     * 查询角色
     * @param id
     * @return
     */
    private SysRole getSysroleById(Integer id) {
        SysRoleVo sysRoleVo = new SysRoleVo();
        sysRoleVo.getSearch().setId(id);
        sysRoleVo = getService().get(sysRoleVo);
        return sysRoleVo.getResult();
    }

    /**
     * 角色与用户关联不能删除，删除角色要删除角色资源关联表信息
     * @param sysRoleVo
     */
    @Override
    protected void doDelete(SysRoleVo sysRoleVo) {
        boolean success = ServiceSiteTool.mSysRoleService().deleteRole(sysRoleVo);
        if (!success) {
            sysRoleVo.setErrMsg(LocaleTool.tranMessage("privilege","exist.user"));
        }
        sysRoleVo.setSuccess(success);
    }

    @RequestMapping(value = "/checkSameRoleName")
    @ResponseBody
    public String checkSameRoleName(@RequestParam("result.name") String name) {
        SysRoleVo vo = new SysRoleVo();
        vo.getSearch().setName(name);
        vo.getSearch().setSubsysCode(ConfigManager.getConfigration().getSubsysCode());
        return ServiceSiteTool.mSysRoleService().checkSameRoleName(vo);
    }

}
