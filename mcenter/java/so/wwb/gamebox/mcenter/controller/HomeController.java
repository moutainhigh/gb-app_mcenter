package so.wwb.gamebox.mcenter.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.support._Module;
import org.soul.commons.tree.TreeNode;
import org.soul.model.common.BaseVo;
import org.soul.model.security.privilege.po.VSysUserResource;
import org.soul.model.security.privilege.vo.SysResourceVo;
import org.soul.web.session.RedisSessionDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.player.IVPlayerOnlineService;
import so.wwb.gamebox.mcenter.init.ConfigManager;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.SubSysCodeEnum;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.player.vo.UserPlayerVo;
import so.wwb.gamebox.model.master.player.vo.VPlayerOnlineListVo;
import so.wwb.gamebox.model.master.setting.po.VUserShortcutMenu;
import so.wwb.gamebox.model.master.setting.vo.UserShortcutMenuListVo;
import so.wwb.gamebox.model.master.setting.vo.VUserShortcutMenuListVo;
import so.wwb.gamebox.web.home.controller.SiteHomeController;

import java.util.*;

/**
 * 新版首页
 * Created by fei on 16-9-4.
 */
@Controller
@RequestMapping("/home")
public class HomeController extends SiteHomeController{

    private static final String INDEX_URL = "/home/Index";

    @Override
    protected Integer fetchSiteId() {
        return null;
    }

    @Override
    protected String homePageTabeleUrl() {
        return "/home/include/Table";
    }

    @Override
    protected String homePageOperateUrl() {
        return "/home/include/Operate";
    }

    @Override
    protected String homePageEffectiveUrl() {
        return "/home/include/EffectiveTd";
    }

    //首页-新增菜单
    public static final String ADD_MENU_URI = "/home/AddMenu";
    private static final Log LOG = LogFactory.getLog(HomeController.class);
    //private static final String DATE_FMT_MM_DD = "MM月dd日";

    @Autowired
    private RedisSessionDao redisSessionDao;

    @RequestMapping("/homeIndex")
    public String home(Model model) {
        // 在线玩家数
        model.addAttribute("onlinePlayerNum", calcOnlinePlayerNum());
        // 今日活跃玩家
        model.addAttribute("activePlayerNum", calcActivePlayerNum());
        // 总资产
        model.addAttribute("assets", getAssets());
        // 更新时间
        model.addAttribute("updateTime", SessionManager.getDate().getNow());
        // 游戏盈亏日期
        model.addAttribute("days", getFmtDays());

        return INDEX_URL;
    }

    /**
     * 计算在线玩家数
     */
    private Long calcOnlinePlayerNum() {
        VPlayerOnlineListVo listVo = new VPlayerOnlineListVo();
        IVPlayerOnlineService ivPlayerOnlineService = ServiceTool.vPlayerOnlineService();
        return ivPlayerOnlineService.count(listVo);
    }

//    /**
//     * 计算在线玩家数
//     */
//    private Long calcOnlinePlayerNum() {
//        VPlayerOnlineListVo listVo = new VPlayerOnlineListVo();
//        List<Integer> userIds = listVo.getSearch().getUserIds();
//        List<String> keys = redisSessionDao.getUserTypeActiveSessions(UserTypeEnum.PLAYER.getCode());
//
//        if (CollectionTool.isNotEmpty(keys)) {
//            for (String key : keys) {
//                String[] str = key.split(",");
//                if (str.length == 3 && !userIds.contains(Integer.valueOf(str[1]))) {
//                    userIds.add(Integer.valueOf(str[1]));
//                    listVo.getSearch().getSessionKeys().add(str[2]);
//                }
//            }
//            return ServiceTool.vPlayerOnlineService().count(listVo);
//        }
//        return 0L;
//    }

    /**
     * 今日活跃玩家
     */
    private Long calcActivePlayerNum() {
        Date day = DateQuickPicker.getInstance().getDay(SessionManager.getTimeZone());
        UserPlayerVo userPlayerVo = new UserPlayerVo();
        userPlayerVo.setStartTime(day);
        userPlayerVo.setEndTime(DateQuickPicker.getInstance().getNow());
        return ServiceTool.userPlayerService().queryActivePlayer(userPlayerVo);
    }

    /**
     * 查找站点资产(钱包余额 + API余额 + 冻结余额）
     */
    private Map<String, Object> getAssets() {
        return ServiceTool.userPlayerService().queryAssets(new UserPlayerVo());
    }



    /**
     * 新增菜单
     */
    @RequestMapping("/addMenu")
    public String addMenu(Model model) {
        SysResourceVo o = new SysResourceVo();
        switch (UserTypeEnum.enumOf(SessionManager.getUser().getUserType())) {
            case MASTER_SUB:
                o.getSearch().setUserId(SessionManager.getUserId());
                break;
            case TOP_AGENT:
            case TOP_AGENT_SUB:
            case AGENT:
            case AGENT_SUB:
                if (SessionManager.getUser().getOwnerId() != null) {
                    o.getSearch().setUserId(SessionManager.getUserId());
                }
                break;
        }

        o.getSearch().setSubsysCode(SubSysCodeEnum.MCENTER.getCode());
        List<TreeNode<VSysUserResource>> menus = ServiceTool.sysResourceService().getAllMenus(o);
        model.addAttribute("menus", menus);
        //左侧菜单栏
        VUserShortcutMenuListVo menuListVo = new VUserShortcutMenuListVo();
        menuListVo.getSearch().setUserId(SessionManager.getUserId());
        List<VUserShortcutMenu> vUserShortcutMenus = ServiceTool.vUserShortcutMenuService().queryShortMenuByUser(menuListVo);
        menuListVo.setResult(vUserShortcutMenus);
        //menuListVo = ServiceTool.vUserShortcutMenuService().search(menuListVo);
        model.addAttribute("menuListVo", menuListVo);
        return ADD_MENU_URI;
    }

    /**
     * 确认菜单
     *
     * @param menus 选中菜单的json
     */
    @RequestMapping("/confirmMenu")
    @ResponseBody
    public Map confirmMenu(String menus) {
        List<Integer> resourceIds = JsonTool.fromJson(menus, new TypeReference<ArrayList<Integer>>() {
        });//选中的菜单id集合

        return addMenu(resourceIds);
    }

    /**
     * 恢复默认菜单
     */
    @RequestMapping("/recoveryDefault")
    @ResponseBody()
    public Map recoveryDefault() {
        // 查询默认菜单
        UserShortcutMenuListVo userShortcutMenuListVo = new UserShortcutMenuListVo();
        if (UserTypeEnum.MASTER.getCode().equals(SessionManager.getUserType().getCode())) {
            userShortcutMenuListVo.getSearch().setUserId(SessionManager.getMasterUserId());
        } else {
            userShortcutMenuListVo.getSearch().setUserId(SessionManager.getUserId());
        }
        userShortcutMenuListVo = ServiceTool.userShortcutMenuService().revertDefaultMenu(userShortcutMenuListVo);
        return getVoMessage(userShortcutMenuListVo);
    }

    /**
     * 新增菜单公共方法
     *
     * @param resourceIds 新增菜单的resourceId集合
     */
    private Map addMenu(List<Integer> resourceIds) {
        UserShortcutMenuListVo userShortcutMenuListVo = new UserShortcutMenuListVo();
        if (UserTypeEnum.MASTER.getCode().equals(SessionManager.getUserType().getCode())) {
            userShortcutMenuListVo.getSearch().setUserId(SessionManager.getMasterUserId());
        } else {
            userShortcutMenuListVo.getSearch().setUserId(SessionManager.getUserId());
        }
        userShortcutMenuListVo.setResourceIds(resourceIds);
        userShortcutMenuListVo = ServiceTool.userShortcutMenuService().saveLeftMenu(userShortcutMenuListVo);
        return getVoMessage(userShortcutMenuListVo);
    }

    private Map getVoMessage(BaseVo baseVo) {
        Map<String, Object> map = new HashMap<>(2, 1f);
        if (baseVo.isSuccess() && StringTool.isBlank(baseVo.getOkMsg())) {
            baseVo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_SUCCESS));

        } else if (!baseVo.isSuccess() && StringTool.isBlank(baseVo.getErrMsg())) {
            baseVo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_FAILED));
        }
        map.put("msg", StringTool.isNotBlank(baseVo.getOkMsg()) ? baseVo.getOkMsg() : baseVo.getErrMsg());
        map.put("state", baseVo.isSuccess());
        return map;
    }

    @RequestMapping("/playerNum")
    @ResponseBody
    public Map playerNum() {
        Map<String, Long> objectObjectHashMap = new HashMap<>();
        // 在线玩家数
        objectObjectHashMap.put("onlinePlayerNum", calcOnlinePlayerNum());
        // 今日活跃玩家
        objectObjectHashMap.put("activePlayerNum", calcActivePlayerNum());
        return objectObjectHashMap;
    }

}