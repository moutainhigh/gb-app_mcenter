package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.model.log.audit.enums.OpType;
import org.soul.model.log.audit.vo.BaseLog;
import org.soul.model.log.audit.vo.LogVo;
import org.soul.model.sys.po.SysAuditLog;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.iservice.master.setting.IRakebackSetService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.RakebackSetForm;
import so.wwb.gamebox.mcenter.setting.form.RakebackSetSearchForm;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.ModuleType;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.company.site.vo.VGameTypeListVo;
import so.wwb.gamebox.model.master.player.enums.UserAgentEnum;
import so.wwb.gamebox.model.master.setting.po.RakebackSet;
import so.wwb.gamebox.model.master.setting.vo.RakebackSetListVo;
import so.wwb.gamebox.model.master.setting.vo.RakebackSetVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * 返水设置表控制器
 *
 * @author loong
 * @time 2015-9-6 10:06:13
 */
@Controller
//region your codes 1
@RequestMapping("/setting/rakebackSet")
public class RakebackSetController extends BaseCrudController<IRakebackSetService, RakebackSetListVo, RakebackSetVo, RakebackSetSearchForm, RakebackSetForm, RakebackSet, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/rakeback/";
        //endregion your codes 2
    }

    //region your codes 3

    @RequestMapping("/changeStatus")
    @ResponseBody
    public Map changeStatus(RakebackSetVo rakebackSetVo) {
//        getProperties
        rakebackSetVo.setProperties(RakebackSet.PROP_STATUS);
        rakebackSetVo = getService().updateOnly(rakebackSetVo);
        return getVoMessage(rakebackSetVo);
    }

    @Override
    @Token(generate = true)
    public String create(RakebackSetVo objectVo, Model model, HttpServletRequest request, HttpServletResponse response) {
        return super.create(objectVo, model, request, response);
    }

    @Override
    protected RakebackSetVo doCreate(RakebackSetVo objectVo, Model model) {
        objectVo = getService().get(objectVo);
        return setGame(super.doCreate(objectVo, model));
    }

    @RequestMapping("/backWaterSave")
    @Audit(module = Module.MASTER_OPERATION, moduleType = ModuleType.OPERATER_BACKWATER_SUCCESS, opType = OpType.UPDATE)
    @Token(valid = true)
    @ResponseBody
    public Map persist(HttpServletRequest request, RakebackSetVo objectVo, @FormModel("result") @Valid RakebackSetForm form, BindingResult result) {
        Map map = super.persist(objectVo, form, result);
        if (map.get("state").equals(true)) {
            //操作日志
            addLog(request, "operater.backwater.success", objectVo);
        }
        return map;
    }

    /**
     * 日志
     *
     * @param request
     * @param description 日志描述
     */
    private void addLog(HttpServletRequest request, String description, RakebackSetVo objectVo) {
        LogVo logVo = new LogVo();
        BaseLog baseLog = logVo.addBussLog();
        baseLog.setDescription(description);
        baseLog.addParam(objectVo.getResult().getName());
        request.setAttribute(SysAuditLog.AUDIT_LOG, logVo);
    }

    @Override
    protected RakebackSetVo doSave(RakebackSetVo objectVo) {
        objectVo.getResult().setCreateTime(new Date());
        objectVo.getResult().setStatus(UserAgentEnum.PROGRAM_STATUS_USING.getCode());
        objectVo.getResult().setCreateUserId(SessionManager.getUserId());
        return super.doSave(objectVo);
    }

    @Override
    @Token(generate = true)
    public String edit(RakebackSetVo objectVo, Integer id, Model model, HttpServletRequest request, HttpServletResponse response) {
        return super.edit(objectVo, id, model, request, response);
    }

    @Override
    protected RakebackSetVo doEdit(RakebackSetVo objectVo, Model model) {
        return setGame(super.doEdit(objectVo, model));
    }

    public RakebackSetVo setGame(RakebackSetVo objectVo) {
        VGameTypeListVo vGameTypeListVo = new VGameTypeListVo();
        vGameTypeListVo.getSearch().setSiteId(SessionManager.getSiteId());
        vGameTypeListVo.setCahceApiMap(Cache.getApi());
        vGameTypeListVo.setCahceSiteApiMap(Cache.getSiteApi());
        List<Map<String, Object>> someGames = ServiceSiteTool.rebateSetService().queryGameData(vGameTypeListVo);
        objectVo.setSomeGames(someGames);
        return objectVo;
    }
    //endregion your codes 3

}