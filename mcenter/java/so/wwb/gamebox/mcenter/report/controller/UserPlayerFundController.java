package so.wwb.gamebox.mcenter.report.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.locale.DateQuickPicker;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.net.ServletTool;
import org.soul.commons.query.sort.Direction;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.mcenter.report.form.UserPlayerFundSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.CacheBase;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.boss.enums.TemplateCodeEnum;
import so.wwb.gamebox.model.master.report.vo.UserPlayerFund;
import so.wwb.gamebox.model.master.report.vo.VPlayerFundsRecordListVo;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


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

        String templateCode = TemplateCodeEnum.USER_PLAYER_FUND.getCode();
        model.addAttribute("searchTempCode", templateCode);
        model.addAttribute("searchTemplates", CacheBase.getSysSearchTempByCondition(SessionManager.getUserId(), templateCode));
        List<Pair> userTypeSearchKeys = initUserTypeSearchKeys();
        model.addAttribute("userTypeSearchKeys", userTypeSearchKeys);
        String queryParamsJson = JsonTool.toJson(listVo.getSearch());
        model.addAttribute("queryParamsJson", queryParamsJson);
        model.addAttribute("validateRule", JsRuleCreator.create(UserPlayerFundSearchForm.class));

        Date today = DateQuickPicker.getInstance().getTomorrow();
        if(listVo.getFundSearch().getSearchStartDate()==null){
            Date startDate = DateTool.addDays(today, -7);
            listVo.getFundSearch().setSearchStartDate(startDate);
        }
        if(listVo.getFundSearch().getSearchEndDate()==null){
            listVo.getFundSearch().setSearchEndDate(today);
        }
        listVo.getQuery().addOrder(UserPlayerFund.PROP_CREATE_TIME, Direction.DESC);
        listVo = ServiceSiteTool.vPlayerFundsRecordService().queryUserPlayerFund(listVo);
        model.addAttribute("command",listVo);
        if(!ServletTool.isAjaxSoulRequest(request)){
            return "/report/playerFund/Index";
        }else{
            return "/report/playerFund/IndexPartial";
        }

    }

    private List<Pair> initUserTypeSearchKeys() {
        List<Pair> searchKeys;
        searchKeys = new ArrayList<>();
        searchKeys.add(new Pair("fundSearch.playerName", LocaleTool.tranView(Module.COLUMN.getCode(), "playerAccount")));
        searchKeys.add(new Pair("fundSearch.agentName", LocaleTool.tranView(Module.COLUMN.getCode(), "agentAccount")));
        searchKeys.add(new Pair("fundSearch.topagentName", LocaleTool.tranView(Module.COLUMN.getCode(), "agentTopAccount")));
        return searchKeys;
    }

}