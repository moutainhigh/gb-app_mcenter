package so.wwb.gamebox.mcenter.content.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.master.content.ICttCarouselI18nService;
import so.wwb.gamebox.mcenter.content.form.CttCarouselI18nForm;
import so.wwb.gamebox.mcenter.content.form.CttCarouselI18nSearchForm;
import so.wwb.gamebox.model.master.content.po.CttCarouselI18n;
import so.wwb.gamebox.model.master.content.vo.CttCarouselI18nListVo;
import so.wwb.gamebox.model.master.content.vo.CttCarouselI18nVo;


/**
 * 轮播广告国际化表 by River控制器
 *
 * @author River
 * @time 2015-12-1 10:22:07
 */
@Controller
//region your codes 1
@RequestMapping("/cttCarouselI18n")
public class CttCarouselI18nController extends BaseCrudController<ICttCarouselI18nService, CttCarouselI18nListVo, CttCarouselI18nVo, CttCarouselI18nSearchForm, CttCarouselI18nForm, CttCarouselI18n, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/carousel/";
        //endregion your codes 2
    }

    //region your codes 3

    //endregion your codes 3

}