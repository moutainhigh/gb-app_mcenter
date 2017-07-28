package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.commons.dict.DictTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.support._Module;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.support.BaseWebConf;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.BossParamEnum;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.company.sys.po.SysSite;
import so.wwb.gamebox.model.company.sys.vo.SysSiteVo;
import so.wwb.gamebox.model.master.setting.po.UserShortcutMenu;
import so.wwb.gamebox.model.master.setting.vo.PreferenceVo;

import java.util.HashMap;
import java.util.Map;

/**
 * @author: tom
 * @date: 15-8-13
 */
@Controller
@RequestMapping("/setting/preference")
public class PreferenceController {

    private static final Log LOG = LogFactory.getLog(PreferenceController.class);

    @Autowired
    private BaseWebConf baseWebConf;

    /**
     * 偏好设置
     * @param model
     * @return
     */
    @RequestMapping("/index")
    public String index(Model model) {
        refreshSysParam();
        // 权限密码设置时间
        model.addAttribute("privilagePassTime", ParamTool.getSysParam(SiteParamEnum.SETTING_PRIVILAGE_PASS_TIME));
        model.addAttribute("privilagePassMap",DictTool.get(DictEnum.PRIVILAGE_PASS_TIME));
        // 提示音设置

        model.addAttribute("warmToneMap", DictTool.get(DictEnum.WARMING_TONE_PROJECT));
        model.addAttribute("toneDeposit",ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DEPOSIT));
        model.addAttribute("tonePay",ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_ONLINEPAY));
        model.addAttribute("toneDraw",ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DRAW));
        model.addAttribute("toneAudit",ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_AUDIT));
        model.addAttribute("toneWarm",ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_WARM));
        model.addAttribute("toneNotice", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_NOTICE));
        findEnableImportPlayerParam(model);

        return "/setting/preferences/Index";
    }
    /**
     * 查询是否可转站参数
     * @param model
     * @return
     */
    private void findEnableImportPlayerParam(Model model){
        SysSiteVo sysSiteVo = new SysSiteVo();
        sysSiteVo.getSearch().setId(SessionManager.getSiteId());
        SysSite sysSite = ServiceTool.sysSiteService().getSiteImport(sysSiteVo);
        if(sysSite!=null){
            model.addAttribute("isEnableImport","1");
            model.addAttribute("endImportTime",sysSite.getImportPlayersTime());
        }
    }

    /**
     * 保存偏好设置
     * @param preferenceVo
     * @return
     */
    @RequestMapping("/savePreference")
    @ResponseBody
    public Map savePreference(PreferenceVo preferenceVo) {
        HashMap map = new HashMap(2,1f);
        boolean result = ServiceTool.preferenceService().savePreference(preferenceVo);
        if (result) {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, "save.success"));
            refreshSysParam();
        } else {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, "save.failed"));
        }
        map.put("state", Boolean.valueOf(result));
        return map;
    }

    /**
     * 恢复系统设置
     */
    @RequestMapping("/resetPreference")
    @ResponseBody
    public Boolean resetPreference() {
        PreferenceVo preferenceVo = new PreferenceVo();
        UserShortcutMenu userShortcutMenu = new UserShortcutMenu();
        userShortcutMenu.setUserId(SessionManager.getUserId());
        preferenceVo.setUserShortcutMenu(userShortcutMenu);
        try {
            ServiceTool.preferenceService().resetPreference(preferenceVo);
        } catch (Exception e) {
            LOG.error(e);
            return false;
        }
        refreshSysParam();
        return true;
    }

    /**
     * 提示音新仔or修改
     * @param paramCode 提示音参数code
     * @param id  id大于0表示修改；等于0表示新增
     * @param model
     * @return
     */
    @RequestMapping("/editTone")
    public String editTone(String paramCode,Integer id,Model model) {
        ParamTool.refresh(BossParamEnum.SYS_TONE_DEPOSIT);
        switch (paramCode) {
            case "deposit":
                model.addAttribute("sysTones",ParamTool.getSysParams(BossParamEnum.SYS_TONE_DEPOSIT));
                model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DEPOSIT));
                break;
            case "onlinePay":
                model.addAttribute("sysTones", ParamTool.getSysParams(BossParamEnum.SYS_TONE_ONLINEPAY));
                model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_ONLINEPAY));
                break;
            case "draw":
                model.addAttribute("sysTones", ParamTool.getSysParams(BossParamEnum.SYS_TONE_DRAW));
                model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DRAW));
                break;
            case "audit":
                model.addAttribute("sysTones", ParamTool.getSysParams(BossParamEnum.SYS_TONE_AUDIT));
                model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_AUDIT));
                break;
            case "warm":
                model.addAttribute("sysTones", ParamTool.getSysParams(BossParamEnum.SYS_TONE_WARM));
                model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_WARM));
                break;
            case "notice":
                model.addAttribute("sysTones", ParamTool.getSysParams(BossParamEnum.SYS_TONE_NOTICE));
                model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_NOTICE));
                break;
        }
        return "/setting/preferences/EditTone";
    }

    /**
     * 上传提示音设置
     * @param sysParamVo
     * @return
     */
    @RequestMapping("/uploadTone")
    @ResponseBody
    public Map uploadTone(SysParamVo sysParamVo) {
        HashMap map = new HashMap(2,1f);
        try {
            ServiceTool.preferenceService().uploadTone(sysParamVo);
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, "save.success"));
            map.put("state", Boolean.valueOf(true));
            ParamTool.refresh( SiteParamEnum.WARMING_TONE_DEPOSIT);
        } catch (Exception e) {
            LOG.error(e);
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, "save.failed"));
            map.put("state", Boolean.valueOf(false));
        }
        return map;
    }

    /**
     * 刷新缓存
     */
    private void refreshSysParam() {
        ParamTool.refresh( SiteParamEnum.SETTING_PRIVILAGE_PASS_TIME);
        ParamTool.refresh( SiteParamEnum.WARMING_TONE_DEPOSIT);
    }

}
