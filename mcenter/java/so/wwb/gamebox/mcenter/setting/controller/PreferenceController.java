package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.support._Module;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.support.BaseWebConf;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.BossParamEnum;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.common.MessageI18nConst;
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
    public String index(PreferenceVo preferenceVo,Model model) {
        refreshSysParam();
        //玩家中心弹框开关
        model.addAttribute("popUp", ParamTool.getSysParam(SiteParamEnum.SETTING_SYSTEM_SETTINGS_POPUP_SWITCH));
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
        //自定义提示音
        model.addAttribute("toneDepositDefined",ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DEPOSIT_DEFINED));
        model.addAttribute("tonePayDefined",ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_ONLINEPAY_DEFINED));
        model.addAttribute("toneDrawDefined",ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DRAW_DEFINED));
        model.addAttribute("toneAuditDefined",ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_AUDIT_DEFINED));
        model.addAttribute("toneWarmDefined",ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_WARM_DEFINED));
        model.addAttribute("toneNoticeDefined", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_NOTICE_DEFINED));

        model.addAttribute("webtype", "2");
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
        boolean result = ServiceSiteTool.preferenceService().savePreference(preferenceVo);
        if (result) {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_SUCCESS));
            refreshSysParam();
        } else {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
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
            ServiceSiteTool.preferenceService().resetPreference(preferenceVo);
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
                model.addAttribute("toneDefined", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DEPOSIT_DEFINED));
                break;
            case "onlinePay":
                model.addAttribute("sysTones", ParamTool.getSysParams(BossParamEnum.SYS_TONE_ONLINEPAY));
                model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_ONLINEPAY));
                model.addAttribute("toneDefined", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_ONLINEPAY_DEFINED));
                break;
            case "draw":
                model.addAttribute("sysTones", ParamTool.getSysParams(BossParamEnum.SYS_TONE_DRAW));
                model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DRAW));
                model.addAttribute("toneDefined", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DRAW_DEFINED));
                break;
            case "audit":
                model.addAttribute("sysTones", ParamTool.getSysParams(BossParamEnum.SYS_TONE_AUDIT));
                model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_AUDIT));
                model.addAttribute("toneDefined", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_AUDIT_DEFINED));
                break;
            case "warm":
                model.addAttribute("sysTones", ParamTool.getSysParams(BossParamEnum.SYS_TONE_WARM));
                model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_WARM));
                model.addAttribute("toneDefined", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_WARM_DEFINED));
                break;
            case "notice":
                model.addAttribute("sysTones", ParamTool.getSysParams(BossParamEnum.SYS_TONE_NOTICE));
                model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_NOTICE));
                model.addAttribute("toneDefined", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_NOTICE_DEFINED));
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
            ServiceSiteTool.preferenceService().uploadTone(sysParamVo);
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_SUCCESS));
            map.put("state", Boolean.valueOf(true));
            String paramCode = sysParamVo.getResult().getParamCode();
            switch (paramCode) {
                case "deposit":
                    ParamTool.refresh(SiteParamEnum.WARMING_TONE_DEPOSIT);
                    break;
                case "onlinePay":
                    ParamTool.refresh(SiteParamEnum.WARMING_TONE_ONLINEPAY);
                    break;
                case "draw":
                    ParamTool.refresh(SiteParamEnum.WARMING_TONE_DRAW);
                    break;
                case "audit":
                    ParamTool.refresh(SiteParamEnum.WARMING_TONE_AUDIT);
                    break;
                case "warm":
                    ParamTool.refresh(SiteParamEnum.WARMING_TONE_WARM);
                    break;
                case "notice":
                    ParamTool.refresh(SiteParamEnum.WARMING_TONE_NOTICE);
                    break;
                default:
                    LOG.error("站点{0}，更换站点提示音，缓存刷新失败,参数paramCode为:{1}",SessionManager.getSiteId(),paramCode);
            }
        } catch (Exception e) {
            LOG.error(e);
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));//LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
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
        //ParamTool.refresh(SiteParamEnum.SETTING_SYSTEM_SETTINGS_OPENPLAYER_STATISTICS);
    }

    /**
     * 上传用户自定义提示音
     * @param sysParamVo
     * @return
     */
    @RequestMapping("/uploadUserDefinedTone")
    public String uploadUserDefinedTone(SysParamVo sysParamVo,Model model) {
        String paramCode = sysParamVo.getResult().getParamCode();
        if (StringTool.isNotBlank(paramCode)){
            switch (paramCode) {
                case "deposit_defined":
                    model.addAttribute("toneDefined", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DEPOSIT_DEFINED));
                    model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DEPOSIT));
                    break;
                case "onlinePay_defined":
                    model.addAttribute("toneDefined", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_ONLINEPAY_DEFINED));
                    model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_ONLINEPAY));
                    break;
                case "draw_defined":
                    model.addAttribute("toneDefined", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DRAW_DEFINED));
                    model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_DRAW));

                    break;
                case "audit_defined":
                    model.addAttribute("toneDefined", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_AUDIT_DEFINED));
                    model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_AUDIT));

                    break;
                case "warm_defined":
                    model.addAttribute("toneDefined", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_WARM_DEFINED));
                    model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_WARM));

                    break;
                case "notice_defined":
                    model.addAttribute("toneDefined", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_NOTICE_DEFINED));
                    model.addAttribute("tone", ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_NOTICE));

                    break;
            }
        }
        return "/setting/preferences/UploadUserDefinedTone";
    }

    /**
     * 保存上传自定义提示音
     * @param sysParamVo
     * @return
     */
    @RequestMapping("/saveUserDefinedTone")
    @ResponseBody
    public SysParamVo saveUserDefinedTone(SysParamVo sysParamVo) {
        Integer id = sysParamVo.getResult().getId();
        if (id==null){
            LOG.info("保存上传自定义提示音，站点ID{0}，更新参数id为空",SessionManager.getSiteId());
            sysParamVo.setSuccess(false);
            return sysParamVo;
        }
        String paramCode = sysParamVo.getResult().getParamCode();
        if (StringTool.isBlank(paramCode)){
            LOG.info("保存上传自定义提示音，站点ID{0}，paramCode为空",SessionManager.getSiteId());
            sysParamVo.setSuccess(false);
            return sysParamVo;
        }
        String paramValue = sysParamVo.getResult().getParamValue();
        if (StringTool.isBlank(paramValue)){
            LOG.info("保存上传自定义提示音，站点ID{0}，更新参数值为空",SessionManager.getSiteId());
            sysParamVo.setSuccess(false);
            return sysParamVo;
        }
        paramValue = "files/"+paramValue;//拼接路径
        sysParamVo.getResult().setParamValue(paramValue);
        sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE);
        sysParamVo = ServiceSiteTool.siteSysParamService().updateOnly(sysParamVo);
        if (sysParamVo.isSuccess()) {
            if (StringTool.isNotBlank(paramCode)){
                switch (paramCode) {
                    case "deposit_defined":
                        ParamTool.refresh(SiteParamEnum.WARMING_TONE_DEPOSIT_DEFINED);
                        break;
                    case "onlinePay_defined":
                        ParamTool.refresh(SiteParamEnum.WARMING_TONE_ONLINEPAY_DEFINED);
                        break;
                    case "draw_defined":
                        ParamTool.refresh(SiteParamEnum.WARMING_TONE_DRAW_DEFINED);
                        break;
                    case "audit_defined":
                        ParamTool.refresh(SiteParamEnum.WARMING_TONE_AUDIT_DEFINED);
                        break;
                    case "warm_defined":
                        ParamTool.refresh(SiteParamEnum.WARMING_TONE_WARM_DEFINED);
                        break;
                    case "notice_defined":
                        ParamTool.refresh(SiteParamEnum.WARMING_TONE_NOTICE_DEFINED);
                        break;
                }
            }
            return sysParamVo;
        }else {
            LOG.info("保存上传自定义提示音，站点ID{0}，更新参数失败",SessionManager.getSiteId());
            sysParamVo.setSuccess(false);
        }
        return sysParamVo;
    }

}
