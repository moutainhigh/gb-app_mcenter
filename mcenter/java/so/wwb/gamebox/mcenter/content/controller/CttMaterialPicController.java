package so.wwb.gamebox.mcenter.content.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.agent.ICttMaterialPicService;
import so.wwb.gamebox.mcenter.content.form.CttMaterialPicForm;
import so.wwb.gamebox.mcenter.content.form.CttMaterialPicSearchForm;
import so.wwb.gamebox.model.master.agent.po.CttMaterialPic;
import so.wwb.gamebox.model.master.agent.vo.CttMaterialPicListVo;
import so.wwb.gamebox.model.master.agent.vo.CttMaterialPicVo;


/**
 * 推广素材表控制器
 *
 * @author tom
 * @time 2015-10-29 11:22:14
 */
@Controller
//region your codes 1
@RequestMapping("/cttMaterial")
public class CttMaterialPicController extends BaseCrudController<ICttMaterialPicService, CttMaterialPicListVo, CttMaterialPicVo, CttMaterialPicSearchForm, CttMaterialPicForm, CttMaterialPic, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/agent/account/material/";
        //endregion your codes 2
    }

    //region your codes 3

    //endregion your codes 3

}