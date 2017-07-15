

package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.commons.tree.ListToTreeConvertor;
import org.soul.model.security.privilege.po.VSysUserResource;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.session.SessionManagerBase;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.setting.IUserShortcutMenuService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.UserShortcutMenuForm;
import so.wwb.gamebox.mcenter.setting.form.UserShortcutMenuSearchForm;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.master.setting.po.UserShortcutMenu;
import so.wwb.gamebox.model.master.setting.vo.UserShortcutMenuListVo;
import so.wwb.gamebox.model.master.setting.vo.UserShortcutMenuVo;
import so.wwb.gamebox.model.master.setting.vo.VUserShortcutMenuListVo;

import java.util.List;
import java.util.Map;


/**
 * 用户快捷菜单表控制器
 *
 * Created by jeff using soul-code-generator on 2015-6-18 9:54:11
 */
@Controller
//region your codes 1
@RequestMapping("/userShortcutMenu")
public class UserShortcutMenuController extends BaseCrudController<IUserShortcutMenuService, UserShortcutMenuListVo, UserShortcutMenuVo, UserShortcutMenuSearchForm, UserShortcutMenuForm, UserShortcutMenu, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/mcenter/userShortcutMenu/";
        //endregion your codes 2
    }

    //region your codes 3

    private static final String GET_SHORTCUT_MENU ="/setting/shortcutmenu/GetShortcutMenu";

    private static final String ADD_SHORTCUT_MENU = "/setting/shortcutmenu/AddShortcutMenu";

    private static final Integer USER_MAX_SHORTCUT_MENU = 20;

    /**
     * 根据userId获取所有快捷菜单，如果为空(默认)去默认值
     * @param model
     * @return
     */
    @RequestMapping("/getShortcutMenu")
    public String getShortcutMenu(Model model){
        VUserShortcutMenuListVo vUserShortcutMenuListVo = new VUserShortcutMenuListVo();
        vUserShortcutMenuListVo.getSearch().setUserId(SessionManager.getUserId());
        vUserShortcutMenuListVo.getSearch().setPosition("1");

        model.addAttribute("listVo", ServiceTool.vUserShortcutMenuService().searchByUser(vUserShortcutMenuListVo));
        return GET_SHORTCUT_MENU;
    }
    /**
     * 重置为默认快捷菜单
     * @param vo
     * @return
     */
    @RequestMapping("/revertDefault")
    @ResponseBody
    public boolean revertDefault(UserShortcutMenuVo vo){
        vo.getSearch().setUserId(SessionManagerBase.getUserId());
        return this.getService().revertDefault(vo);
    }

    /**
     * 添加菜单页面
     * @param model
     * @return
     */
    @RequestMapping("/getAllMenu")
    public String getAllMenu(@RequestParam(defaultValue = "1")String position,Model model){
        /*已经选中的*/
        VUserShortcutMenuListVo vUserShortcutMenuListVo = new VUserShortcutMenuListVo();
        vUserShortcutMenuListVo.getSearch().setUserId(SessionManager.getUserId());
        vUserShortcutMenuListVo.getSearch().setPosition(position);
        vUserShortcutMenuListVo = ServiceTool.vUserShortcutMenuService().search(vUserShortcutMenuListVo);
        model.addAttribute("vUserShortcutMenuListVo",vUserShortcutMenuListVo);
        /*根据userid 取权限内的菜单*/
        UserShortcutMenuListVo userShortcutMenuListVo = new UserShortcutMenuListVo();
        userShortcutMenuListVo.getSearch().setUserId(SessionManager.getUserId());
        List<VSysUserResource> vSysUserResources = this.getService().getMenuByUser(userShortcutMenuListVo);
        model.addAttribute("vSysUserResources",ListToTreeConvertor.convert(vSysUserResources));
        model.addAttribute("userMaxShortcutMenu",USER_MAX_SHORTCUT_MENU);
        model.addAttribute("position",position);
        return ADD_SHORTCUT_MENU;
    }

    /**
     * 判断当前是否为默认菜单
     * @return true 是默认菜单
     */
    @RequestMapping("/isDefaultMenu")
    @ResponseBody
    public boolean isDefaultMenu(){
        UserShortcutMenuVo vo = new UserShortcutMenuVo();
        vo.getSearch().setUserId(SessionManagerBase.getUserId());
        return super.getService().isDefaultMenu(vo);
    }//headers = {"Content-type=application/json"}

    /**
     * 逻辑删除
     * @param userShortcutMenuListVo
     * @return
     */
    @RequestMapping(value = "/updateShortcutMenuSort")
    @ResponseBody
    public boolean updateShortcutMenuSort(@RequestBody UserShortcutMenuListVo userShortcutMenuListVo){
         return this.getService().updateShortMenuSort(userShortcutMenuListVo);
    }
    @RequestMapping(value = "updateShortcutMenu")
    @ResponseBody
    public boolean updateShortcutMenu(@RequestBody UserShortcutMenuListVo userShortcutMenuListVo){
        userShortcutMenuListVo.setUserId(SessionManager.getUserId());
        return this.getService().updateShortMenu(userShortcutMenuListVo);
    }

    @RequestMapping("/deleteShortcutMenu")
    @ResponseBody
    public Map deleteShortcutMenu(UserShortcutMenuVo userShortcutMenuVo){
        userShortcutMenuVo.getResult().setIsDelete(true);
        userShortcutMenuVo.setProperties(UserShortcutMenu.PROP_IS_DELETE);
        userShortcutMenuVo = getService().updateOnly(userShortcutMenuVo);
        return getVoMessage(userShortcutMenuVo);
    }
    //endregion your codes 3

 }