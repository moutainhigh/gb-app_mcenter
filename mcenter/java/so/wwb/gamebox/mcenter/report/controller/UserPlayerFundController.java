package so.wwb.gamebox.mcenter.report.controller;

import org.soul.commons.lang.DateTool;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.net.ServletTool;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordListVo;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;


/**
 * 控制器
 *
 * @author younger
 * @time 2018-1-7 14:42:07
 */
@Controller
//region your codes 1
@RequestMapping("/userPlayerFund")
public class UserPlayerFundController {
//endregion your codes 1

    @RequestMapping(value = "search")
    public String search(VPlayerFundsRecordListVo listVo, Model model, HttpServletRequest request){
        Date today = DateQuickPicker.getInstance().getTomorrow();
        if(listVo.getFundSearch().getSearchStartDate()==null){
            Date startDate = DateTool.addDays(today, -60);
            listVo.getFundSearch().setSearchStartDate(startDate);
        }
        if(listVo.getFundSearch().getSearchEndDate()==null){
            listVo.getFundSearch().setSearchEndDate(today);
        }
        listVo = ServiceSiteTool.vPlayerFundsRecordService().queryUserPlayerFund(listVo);
        model.addAttribute("command",listVo);
        if(!ServletTool.isAjaxSoulRequest(request)){
            return "/report/playerFund/Index";
        }else{
            return "/report/playerFund/IndexPartial";
        }

    }

}