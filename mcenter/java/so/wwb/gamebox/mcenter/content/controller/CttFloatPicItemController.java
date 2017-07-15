package so.wwb.gamebox.mcenter.content.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.content.ICttFloatPicItemService;
import so.wwb.gamebox.mcenter.content.form.CttFloatPicItemForm;
import so.wwb.gamebox.mcenter.content.form.CttFloatPicItemSearchForm;
import so.wwb.gamebox.model.master.content.po.CttFloatPicItem;
import so.wwb.gamebox.model.master.content.vo.CttFloatPicItemListVo;
import so.wwb.gamebox.model.master.content.vo.CttFloatPicItemVo;


/**
 * 浮动图子项表控制器
 *
 * @author River
 * @time 2016-1-12 11:54:09
 */
@Controller
//region your codes 1
@RequestMapping("/cttFloatPicItem")
public class CttFloatPicItemController extends BaseCrudController<ICttFloatPicItemService, CttFloatPicItemListVo, CttFloatPicItemVo, CttFloatPicItemSearchForm, CttFloatPicItemForm, CttFloatPicItem, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/";
        //endregion your codes 2
    }

    //region your codes 3

    //endregion your codes 3

}