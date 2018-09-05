package so.wwb.gamebox.mcenter.fee.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.fee.IRechargeFeeSchemaService;
import so.wwb.gamebox.mcenter.fee.form.RechargeFeeSchemaForm;
import so.wwb.gamebox.mcenter.fee.form.RechargeFeeSchemaSearchForm;
import so.wwb.gamebox.model.master.fee.po.RechargeFeeSchema;
import so.wwb.gamebox.model.master.fee.vo.RechargeFeeSchemaListVo;
import so.wwb.gamebox.model.master.fee.vo.RechargeFeeSchemaVo;

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
        return "/mcenter/";
    }
}