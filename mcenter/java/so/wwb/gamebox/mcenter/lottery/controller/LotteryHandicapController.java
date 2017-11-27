package so.wwb.gamebox.mcenter.lottery.controller;

import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.iservice.company.lottery.ILotteryHandicapService;
import so.wwb.gamebox.mcenter.lottery.form.LotteryHandicapForm;
import so.wwb.gamebox.mcenter.lottery.form.LotteryHandicapSearchForm;
import so.wwb.gamebox.model.company.lottery.po.LotteryHandicap;
import so.wwb.gamebox.model.company.lottery.vo.LotteryHandicapListVo;
import so.wwb.gamebox.model.company.lottery.vo.LotteryHandicapVo;


/**
 * 彩种盘口控制器
 *
 * @author admin
 * @time 2017-4-11 20:35:57
 */
@Controller
//region your codes 1
@RequestMapping("/lotteryHandicap")
public class LotteryHandicapController extends BaseCrudController<ILotteryHandicapService, LotteryHandicapListVo, LotteryHandicapVo, LotteryHandicapSearchForm, LotteryHandicapForm, LotteryHandicap, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/lottery/";
        //endregion your codes 2
    }

    //region your codes 3

    //endregion your codes 3

}