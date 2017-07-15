package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.player.IRemarkService;
import so.wwb.gamebox.mcenter.player.form.RemarkForm;
import so.wwb.gamebox.mcenter.player.form.RemarkSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.master.player.po.Remark;
import so.wwb.gamebox.model.master.player.vo.RemarkListVo;
import so.wwb.gamebox.model.master.player.vo.RemarkVo;
import so.wwb.gamebox.web.common.token.Token;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;


/**
 * 控制器:玩家详细-备注
 * <p/>
 * Author:orange
 * 2015-6-30 11:35:38
 */
@Controller
@RequestMapping("/playerRemark")
public class PlayerRemarkController extends BaseCrudController<IRemarkService, RemarkListVo, RemarkVo, RemarkSearchForm, RemarkForm, Remark, Integer> {
    private static String REMARK_URI = "/player/view.include/Remark";
    private static String MORE_REMARK_URI = "/player/remark/MoreRemark";
    private static String AGENT_REMARK_URI = "/player/agent/detail.include/Remark";
    private static String TOP_AGENT_REMARK_URI = "/player/topagent/detail.include/Remark";

    @Override
    protected String getViewBasePath() {
        return "/player/remark/";
    }

    /**
     * 玩家详细-备注页面
     *
     * @param listVo
     * @param model
     * @return
     */

    @RequestMapping("/remark")
    public String remark(RemarkListVo listVo, Model model, HttpServletRequest request) {
        listVo = getService().search(listVo);
        model.addAttribute("command", listVo);
        return ServletTool.isAjaxSoulRequest(request) ? REMARK_URI + "Partial" : REMARK_URI;
    }

    /**
     * 查看更多备注
     *
     * @param listVo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/moreRemark")
    public String viewMore(RemarkListVo listVo, Model model, HttpServletRequest request) {
        listVo = getService().search(listVo);
        model.addAttribute("command", listVo);
        return ServletTool.isAjaxSoulRequest(request) ? MORE_REMARK_URI + "Partial" : MORE_REMARK_URI;
    }

    @Override
    protected RemarkVo doCreate(RemarkVo objectVo, Model model) {
        return objectVo;
    }

    @Override
    protected RemarkVo doUpdate(RemarkVo objectVo) {
        Remark remark = objectVo.getResult();
        remark.setOperatorId(SessionManager.getUserId());
        remark.setRemarkTime(SessionManager.getDate().getNow());
        remark.setOperator(SessionManager.getAuditUserName());
        return this.getService().update(objectVo);
    }

    @Override
    protected RemarkVo doSave(RemarkVo objectVo) {
        Remark remark = objectVo.getResult();
        remark.setOperatorId(SessionManager.getUserId());
        remark.setRemarkTime(SessionManager.getDate().getNow());
        remark.setOperator(SessionManager.getAuditUserName());
        return this.getService().insert(objectVo);
    }

    @Override
    @Token(generate = true)
    public String create(RemarkVo objectVo, Model model, HttpServletRequest request, HttpServletResponse response) {
        return super.create(objectVo, model, request, response);
    }

    @Override
    @Token(generate = true)
    public String edit(RemarkVo objectVo, Integer id, Model model, HttpServletRequest request, HttpServletResponse response) {
        return super.edit(objectVo, id, model, request, response);
    }

    @Override
    @Token(valid = true)
    public Map persist(RemarkVo objectVo, @FormModel("result") @Valid RemarkForm form, BindingResult result) {
        return super.persist(objectVo, form, result);
    }

    /**
     * 代理的备注
     * @param listVo
     * @param model
     * @return
     */
    @RequestMapping("/agentRemark")
    public String agentRemark(RemarkListVo listVo, Model model) {
        listVo = getService().search(listVo);
        model.addAttribute("command", listVo);
        return AGENT_REMARK_URI;
    }

    /**
     * 总代理的备注
     * @param listVo
     * @param model
     * @return
     */
    @RequestMapping("/topagentRemark")
    public String yopagentRemark(RemarkListVo listVo, Model model) {
        listVo = getService().search(listVo);
        model.addAttribute("command", listVo);
        return TOP_AGENT_REMARK_URI;
    }

    @RequestMapping("/editPlayerRemark")
    @Token(generate = true)
    public String editPlayerRemark(RemarkVo remarkVo,Model model){
        remarkVo = super.doEdit(remarkVo,model);
        if(remarkVo.getResult()==null){
            Remark remark = new Remark();
            remark.setEntityId(remarkVo.getSearch().getEntityUserId());
            remark.setEntityUserId(remarkVo.getSearch().getEntityUserId());
            remark.setModel(remarkVo.getSearch().getModel());
            remark.setRemarkType(remarkVo.getSearch().getRemarkType());
            remarkVo.setResult(remark);
        }
        remarkVo.setValidateRule(JsRuleCreator.create(RemarkForm.class));
        model.addAttribute("command",remarkVo);
        return "/player/remark/Edit";
    }

    @RequestMapping("/deletePlayerRemark")
    @ResponseBody
    public Map deletePlayerRemark(RemarkVo remarkVo){
        Map map = new HashMap();
        try{
            if(remarkVo.getSearch().getId()==null){
                map.put("state",false);
                return map;
            }
            remarkVo = getService().get(remarkVo);
            boolean delete = getService().delete(remarkVo);
            map.put("state",delete);
        }catch (Exception ex){
            map.put("state",false);
            LogFactory.getLog(PlayerRemarkController.class).error(ex,"删除备注出错");
        }

        return map;
    }
}