package so.wwb.gamebox.mcenter.fee.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.collections.MapTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.lang.DateQuickPickerTool;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.model.log.audit.enums.OpType;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.fee.IRechargeFeeSchemaService;
import so.wwb.gamebox.mcenter.fee.form.RechargeFeeSchemaForm;
import so.wwb.gamebox.mcenter.fee.form.RechargeFeeSchemaSearchForm;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.ModuleType;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.master.fee.po.RechargeFeeSchema;
import so.wwb.gamebox.model.master.fee.vo.RechargeFeeSchemaListVo;
import so.wwb.gamebox.model.master.fee.vo.RechargeFeeSchemaVo;
import so.wwb.gamebox.web.BussAuditLogTool;
import so.wwb.gamebox.web.SessionManagerCommon;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.Map;

/**
 * 存款手续费方案表
 * @author martin
 * @time 2018-9-2 17:59:50
 */
@Controller
@RequestMapping("/rechargeFeeSchema")
public class RechargeFeeSchemaController extends BaseCrudController<IRechargeFeeSchemaService,
        RechargeFeeSchemaListVo, RechargeFeeSchemaVo, RechargeFeeSchemaSearchForm, RechargeFeeSchemaForm,
        RechargeFeeSchema, Integer> {

    @Override
    protected String getViewBasePath() {
        return "/operation/fee/";
    }


    @Override
    public String list(RechargeFeeSchemaListVo listVo, @FormModel("search") @Valid RechargeFeeSchemaSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        return super.list(listVo, form, result, model, request, response);
    }

    @Override
    public String create(RechargeFeeSchemaVo objectVo, Model model, HttpServletRequest request, HttpServletResponse response) {
        return super.create(objectVo, model, request, response);
    }

    @Audit(module = Module.MASTER_OPERATION, moduleType = ModuleType.RECHARGE_FEE_SCHEMA, opType = OpType.UPDATE)
    @Override
    public Map persist(RechargeFeeSchemaVo objectVo, @FormModel("result") @Valid RechargeFeeSchemaForm form, BindingResult bindingResult) {

        //页面数据转换
        RechargeFeeSchema fee = objectVo.getResult();

        //收取
        if (fee.getIsFee()) {
            String feeType = fee.getFeeType() == null ? "1" : fee.getFeeType();
            if ("1".equals(feeType)) {
                fee.setFeeMoney(objectVo.getPercentageAmount());
            } else {
                fee.setFeeMoney(objectVo.getFixedAmount());
            }
        }
        //返还
        if (fee.getIsReturnFee()) {
            String returnType = fee.getReturnType() == null ? "1" : fee.getReturnType();
            if ("1".equals(returnType)) {
                fee.setReturnMoney(objectVo.getReturnPercentageAmount());
            } else {
                fee.setReturnMoney(objectVo.getReturnFixedAmount());
            }
        }
        //创建时间，修改时间
        if (fee.getId() != null){
            fee.setUpdateTime(DateQuickPickerTool.getInstance().getNow());
            fee.setUpdateUser(SessionManagerCommon.getUserId().toString());
        }else{
            fee.setCreateTime(DateQuickPickerTool.getInstance().getNow());
            fee.setCreateUser(SessionManagerCommon.getUserId().toString());
        }
        //保存
        Map persist = super.persist(objectVo, form, bindingResult);
        //日志
        if (MapTool.getBoolean(persist,"state")){
            BussAuditLogTool.addLog("RECHARGE_FEE_SCHEMA", "["+JsonTool.toJson(objectVo.getResult())+"]");
        }
        return persist;
    }

    @Override
    public Map delete(RechargeFeeSchemaVo objectVo, Integer id) {
        this.getService().updateOnly(null);
        return super.delete(objectVo, id);
    }


    /**
     * 验证该名称是否存在
     */
    @RequestMapping("/checkSchemaNameExist")
    @ResponseBody
    public boolean checkSchemaNameExist(@RequestParam("result.schemaName") String schemaName, @RequestParam("result.id") Integer id) {
        RechargeFeeSchemaListVo listVo = new RechargeFeeSchemaListVo();
        listVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(RechargeFeeSchema.PROP_SCHEMA_NAME, Operator.EQ, schemaName),
                new Criterion(RechargeFeeSchema.PROP_ID, Operator.NE, id)
        });
        listVo = this.getService().search(listVo);
        if (listVo.isSuccess() && CollectionTool.isEmpty(listVo.getResult())){
            return true;
        }else{
            return false;
        }
    }
}