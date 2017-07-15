package so.wwb.gamebox.mcenter.report.betting.controller;

import org.soul.commons.collections.MapTool;
import org.soul.commons.currency.CurrencyTool;
import org.soul.commons.net.ServletTool;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.gameapi.enums.ApiProviderEnum;
import so.wwb.gamebox.model.site.report.vo.VPlayerGameTipOrderListVo;
import so.wwb.gamebox.web.cache.Cache;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;


/**
 * Created by bill on 16-11-7.
 */
@Controller
@RequestMapping("/report/betting/vPlayerGameTipOrder")
public class VPlayerGameTipOrderController {
    /**
     * 查询最大时间间隔，以天为单位
     */
    private static final int TIME_INTERVAL = -40;

    /**
     * 默认查询近7天数据
     */
    private static final int DEFAULT_TIME = -7;

    protected String getViewBasePath() {
        return "/report/betting/tip/";
    }


    @RequestMapping("/vPlayerGameTipOrderList")
    public String vPlayerGameTipOrderList(Model model, VPlayerGameTipOrderListVo vPlayerGameTipOrderListVo, HttpServletRequest request) {
        initPage(model, vPlayerGameTipOrderListVo);
        vPlayerGameTipOrderListVo = ServiceTool.vPlayerGameTipOrderService().search(vPlayerGameTipOrderListVo);
        model.addAttribute("command", vPlayerGameTipOrderListVo);
        return ServletTool.isAjaxSoulRequest(request) ? getViewBasePath() + "IndexPartial" : getViewBasePath() + "Index";
    }

    private void initPage(Model model, VPlayerGameTipOrderListVo vPlayerGameTipOrderListVo) {
        initDate(vPlayerGameTipOrderListVo);
        apiMap(model);
        model.addAttribute("minDate", SessionManager.getDate().addDays(TIME_INTERVAL));
    }

    /***
     * 进入小费查询页面
     *
     * @param model
     * @param vPlayerGameTipOrderListVo
     * @return
     */
    @RequestMapping("/init")
    public String init(Model model, VPlayerGameTipOrderListVo vPlayerGameTipOrderListVo) {
        initPage(model, vPlayerGameTipOrderListVo);
        model.addAttribute("command", vPlayerGameTipOrderListVo);
        return getViewBasePath() + "Index";
    }

    private void initDate(VPlayerGameTipOrderListVo vPlayerGameTipOrderListVo) {
        if (vPlayerGameTipOrderListVo.getSearch().getBeginTime() == null) {
            vPlayerGameTipOrderListVo.getSearch().setBeginTime(SessionManager.getDate().addDays(DEFAULT_TIME));
        }
        if (vPlayerGameTipOrderListVo.getSearch().getEndTime() == null) {
            vPlayerGameTipOrderListVo.getSearch().setEndTime(SessionManager.getDate().getNow());
        }
    }

    /**
     * 游戏类型查询
     *
     * @param model
     */
    private void apiMap(Model model) {
        //展示api固定
        Map<String, String> apiMap = new HashMap<>(2);
        apiMap.put(ApiProviderEnum.AG.getCode(), Cache.getSiteApiName(ApiProviderEnum.AG.getCode()));
        apiMap.put(ApiProviderEnum.BBIN.getCode(), Cache.getSiteApiName(ApiProviderEnum.BBIN.getCode()));
        model.addAttribute("apiMap", apiMap);
    }

    /**
     * 统计小费
     *
     * @param listVo
     * @return
     */
    @RequestMapping("/statisticalData")
    @ResponseBody
    public Map<String, String> statisticalData(VPlayerGameTipOrderListVo listVo) {
        Map<String, String> map = new HashMap<>(1);
        if (listVo.getPaging().getTotalCount() > 0) {
            Map<String, Object> sum = ServiceTool.vPlayerGameTipOrderService().querySumTip(listVo);
            map.put("sumTip", CurrencyTool.formatCurrency(MapTool.getDouble(sum, "tip")));
        } else {
            map.put("sumTip", "0.00");
        }
        return map;
    }
}
