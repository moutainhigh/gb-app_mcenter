package so.wwb.gamebox.mcenter.share.controller;

import org.soul.commons.data.json.JsonTool;
import org.soul.commons.exception.SystemException;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.validation.form.support.ValidateTool;
import org.soul.model.listop.po.SysListOperator;
import org.soul.model.listop.vo.SysListOperatorListVo;
import org.soul.model.listop.vo.SysListOperatorVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.listop.ListOpTool;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.company.filter.ISysMasterListOperatorService;
import so.wwb.gamebox.mcenter.enmus.ListOpEnum;
import so.wwb.gamebox.mcenter.init.ConfigManager;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.share.form.SysListOperatorForm;
import so.wwb.gamebox.mcenter.share.form.SysListOperatorSearchForm;

import javax.validation.ConstraintViolation;
import java.util.Collection;
import java.util.Map;
import java.util.Set;

/**
 * @author: tom
 * @date: 15-6-1
 */
@Controller
@RequestMapping("/share/filters")
public class ListFiltersController extends BaseCrudController<ISysMasterListOperatorService,SysListOperatorListVo, SysListOperatorVo, SysListOperatorSearchForm, SysListOperatorForm, SysListOperator, Integer> {

    private static final Log LOG = LogFactory.getLog(ListFiltersController.class);

    @Override
    protected String getViewBasePath() {
        return "/share/filter/";
    }

    public final static Integer OPTYPE = 1;

    /**
     * 确定编辑
     * @param operator
     * @param model
     */
    @RequestMapping(value = "/edit", method= RequestMethod.POST ,headers = {"Content-type=application/json"})
    @ResponseBody
    public String edit(@RequestBody SysListOperator operator,Model model) {
        SysListOperatorForm sysListOperatorForm = new SysListOperatorForm();
        sysListOperatorForm.set$description(operator.getDescription());
        Set<ConstraintViolation<SysListOperatorForm>> results = ValidateTool.validate(sysListOperatorForm);
        if (results.isEmpty()) {
            SysListOperatorVo objectVo = new SysListOperatorVo();
            Map<String,SysListOperator> listOp = ListOpTool.getFilter(ListOpEnum.enumOf(operator.getClassFullName()));
            if (listOp!=null && listOp.size()>0) {
                if (operator.getId()==null && listOp.values().size()>=10) {
                    return "{\"code\":\"WARMING\"}";
                }
            }
            try{
                operator.setSiteId(SessionManager.getSiteId());
                operator.setSubsysCode(SessionManager.getUser() != null ? SessionManager.getUser().getSubsysCode() : ConfigManager.getConfigration().getSubsysCode());
                operator.setOpType(OPTYPE);
                objectVo.setResult(operator);
                objectVo = this.doPersist(objectVo);

                ListOpTool.refreshFilter(ListOpEnum.enumOf(operator.getClassFullName()));
            } catch (SystemException e) {
                LOG.error(e);
            }
            return JsonTool.toJson(objectVo);
        } else {
            return null;
        }
    }

    /**
     * 点击单个过滤选项，查询JSON内容
     * @param id
     * @return
     */
    @RequestMapping(value = "/singleContent",method = RequestMethod.POST)
    @ResponseBody
    public String singleContent(Integer id,String keyClassName) {
        if (id == null) {
            throw new SystemException("Illegal parameter");
        }
        Map<String,SysListOperator> listOp = ListOpTool.getFilter(ListOpEnum.enumOf(keyClassName));
        SysListOperatorVo objectVo = new SysListOperatorVo();
        Collection<SysListOperator> listOperator = listOp.values();
        for (SysListOperator operator : listOperator) {
            if (id.equals(operator.getId())) {
                objectVo.setResult(operator);
                break;
            }
        }

        return JsonTool.toJson(objectVo);
    }
    @Override
    protected void doDelete(SysListOperatorVo objectVo) {
        super.doDelete(objectVo);
        ListOpTool.refreshFilter(ListOpEnum.enumOf(objectVo.getKeyClassName()));
    }
}
