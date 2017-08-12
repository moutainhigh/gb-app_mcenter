package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.collections.ListTool;
import org.soul.commons.collections.MapTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.session.SessionManagerBase;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.setting.IVRakebackSetService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.VRakebackSetForm;
import so.wwb.gamebox.mcenter.setting.form.VRakebackSetSearchForm;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.company.enums.GameStatusEnum;
import so.wwb.gamebox.model.company.setting.po.Api;
import so.wwb.gamebox.model.company.site.po.SiteApi;
import so.wwb.gamebox.model.company.site.po.VGameType;
import so.wwb.gamebox.model.company.site.vo.VGameTypeListVo;
import so.wwb.gamebox.model.master.setting.po.VRakebackSet;
import so.wwb.gamebox.model.master.setting.vo.VRakebackSetListVo;
import so.wwb.gamebox.model.master.setting.vo.VRakebackSetVo;
import so.wwb.gamebox.web.cache.Cache;

import java.util.*;


/**
 * 控制器
 *
 * @author jeff
 * @time 2015-9-22 15:47:47
 */
@Controller
//region your codes 1
@RequestMapping("/setting/vRakebackSet")
public class VRakebackSetController extends BaseCrudController<IVRakebackSetService, VRakebackSetListVo, VRakebackSetVo, VRakebackSetSearchForm, VRakebackSetForm, VRakebackSet, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/rakeback/";
        //endregion your codes 2
    }

    @Override
    protected VRakebackSetListVo doList(VRakebackSetListVo listVo, VRakebackSetSearchForm form, BindingResult result, Model model) {
        return super.doList(listVo, form, result, model);
    }

    //region your codes 3
    /*系统设置-返水设置:只用到列表 其他方法 在 RakebackSetController 中*/

    /**
     * 返水设置-结算周期-view
     *
     * @param model Model
     * @return url
     */
    @RequestMapping("rakebackPeriod/view")
    public String rakebackPeriod(Model model) {
        Date today = SessionManagerBase.getDate().getNow();
        model.addAttribute("today", today);

        // 设置本月天数及排版
        model.addAttribute("dates", setMonthDays(today));

        // 获取返水参数
        initParam(model);
        return this.getViewBasePath() + "/RakebackPeriod";
    }

    /**
     * 设置本月天数及排版
     */
    private List<Object> setMonthDays(Date today) {
        List<Object> dates = ListTool.newArrayList();
        // 初始化Calendar
        Calendar calendar = initCalendar(today);
        int prevMonthDays = calendar.get(Calendar.DAY_OF_WEEK) - 1;
        int currMonthDays = calendar.getActualMaximum(Calendar.DATE);
        int nextMonthDays = 42 - currMonthDays - prevMonthDays;
        // 上月天数
        prevMonthDays(dates, calendar, prevMonthDays);
        // 本月天数
        currMonthDays(dates, currMonthDays);
        // 下月天数
        nextMonthDays(dates, calendar, nextMonthDays);
        return dates;
    }

    /**
     * 初始化Calendar
     *
     * @return Calendar
     */
    private Calendar initCalendar(Date today) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(today);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        return calendar;
    }

    /**
     * 上月天数
     */
    private static void prevMonthDays(List<Object> dates, Calendar calendar, int prevMonthDays) {
        calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH) - 1);
        int prevDays = calendar.getActualMaximum(Calendar.DATE);
        Map<String, Object> map;
        for (int i = prevDays - prevMonthDays + 1; i <= prevDays; i++) {
            map = MapTool.newHashMap();
            map.put("type", "last");
            map.put("value", i);
            dates.add(map);
        }
    }

    /**
     * 本月天数
     */
    private static void currMonthDays(List<Object> dates, int currMonthDays) {
        Map<String, Object> map;
        for (int i = 1; i <= currMonthDays; i++) {
            map = MapTool.newHashMap();
            map.put("type", "this");
            map.put("value", i);
            dates.add(map);
        }
    }

    /**
     * 下月天数
     */
    private static void nextMonthDays(List<Object> dates, Calendar calendar, int nextMonthDays) {
        calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH) + 1);
        Map<String, Object> map;
        for (int i = 1; i <= nextMonthDays; i++) {
            map = MapTool.newHashMap();
            map.put("type", "next");
            map.put("value", i);
            dates.add(map);
        }
    }

    /**
     * 获取返水参数
     */
    private void initParam(Model model) {
        SysParam effectTimeParam = ParamTool.getSysParam(SiteParamEnum.SETTING_RAKEBACKSETTING_SETTLEMENTPERIODEFFECTIVETIME);
        SysParam curParam = ParamTool.getSysParam(SiteParamEnum.SETTING_RAKEBACKSETTING_SETTLEMENTPERIODTIMES);
        SysParam newParam = ParamTool.getSysParam(SiteParamEnum.SETTING_RAKEBACKSETTING_SETTLEMENTPERIODTIMESNEW);
        //生效日期大于当前时间，说明返水设置已经生效
        if (effectTimeParam != null && StringTool.isNotBlank(effectTimeParam.getParamValue()) && DateTool.parseDate(effectTimeParam.getParamValue(), DateTool.yyyy_MM_dd_HH_mm_ss).getTime() <= SessionManager.getDate().getNow().getTime()) {
            curParam = newParam;
        }
        model.addAttribute("curParam", curParam);
        if (newParam != null) {
            model.addAttribute("newParam", newParam);
        }
    }

    /**
     * 返水设置-结算周期-save
     *
     * @param sysParamVo
     * @return
     */
    @RequestMapping("rakebackPeriod/save")
    @ResponseBody
    public Map SaveRakebackPeriod(SysParamVo sysParamVo) {
        SysParam param = sysParamVo.getResult();
        String paramValue = param.getParamValue();

        Map map = checkData(paramValue);
        if (map != null) return map;

        sysParamVo.setEntities(initParams(param));
        sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE, SysParam.PROP_ACTIVE);
        int result = ServiceTool.getSysParamService().batchUpdateOnly(sysParamVo);
        if (result > 0) {
            ParamTool.refresh(SiteParamEnum.SETTING_RAKEBACKSETTING_SETTLEMENTPERIODTIMESNEW);
            ParamTool.refresh(SiteParamEnum.SETTING_RAKEBACKSETTING_SETTLEMENTPERIODEFFECTIVETIME);
            ParamTool.refresh(SiteParamEnum.SETTING_RAKEBACKSETTING_SETTLEMENTPERIODTIMES);
        }
        return this.getVoMessage(sysParamVo);
    }

    private List<SysParam> initParams(SysParam newParam) {
        List<SysParam> params = new ArrayList<>(3);
        params.add(newParam);
        SysParam effParam = ParamTool.getSysParam(SiteParamEnum.SETTING_RAKEBACKSETTING_SETTLEMENTPERIODEFFECTIVETIME);
        SysParam nParam = ParamTool.getSysParam(SiteParamEnum.SETTING_RAKEBACKSETTING_SETTLEMENTPERIODTIMESNEW);
        if (effParam != null && nParam != null && StringTool.isNotBlank(nParam.getParamValue()) && StringTool.isNotBlank(effParam.getParamValue()) && DateTool.parseDate(effParam.getParamValue(), DateTool.yyyy_MM_dd_HH_mm_ss).getTime() <= SessionManager.getDate().getNow().getTime()) {
            SysParam curParam = ParamTool.getSysParam(SiteParamEnum.SETTING_RAKEBACKSETTING_SETTLEMENTPERIODTIMES);
            curParam.setParamValue(nParam.getParamValue());
            params.add(curParam);
        }
        if (effParam != null) {
            Date effeDate = DateTool.addMilliseconds(DateTool.ceiling(new Date(), Calendar.MONTH),
                    -CommonContext.get().getTimeZone().getRawOffset());
            effParam.setParamValue(DateTool.formatDate(effeDate, DateTool.yyyy_MM_dd_HH_mm_ss));
            effParam.setActive(true);
            params.add(effParam);
        }
        return params;
    }


    private Map checkData(String paramValue) {
        Map<String, Object> map = new HashMap<>(2,1f);
        if (StringTool.isBlank(paramValue)) {
            map.put("msg", LocaleTool.tranMessage("setting", "rakebackSetting.SettleAccountsCycleSetting.notBlank"));
            map.put("state", false);
            return map;
        } else if (!paramValue.equals("0") && !paramValue.equals("1") && !paramValue.equals("2") && !paramValue.equals("3") && !paramValue.equals("4")) {
            map.put("msg", LocaleTool.tranMessage("setting", "rakebackSetting.SettleAccountsCycleSetting.worngSubmit"));
            map.put("state", false);
            return map;
        }
        return null;
    }

    @Override
    protected VRakebackSetVo doView(VRakebackSetVo objectVo, Model model) {
        return super.doView(setGameType4rakeback(objectVo), model);
    }

    public VRakebackSetVo setGameType4rakeback(VRakebackSetVo objectVo) {
        VGameTypeListVo vGameTypeListVo = new VGameTypeListVo();
        vGameTypeListVo.getQuery().setCriterions(new Criterion[]{new Criterion(VGameType.PROP_SITE_ID, Operator.EQ, SessionManager.getSiteId())});
        vGameTypeListVo.setProperties(VGameType.PROP_GAME_TYPE, VGameType.PROP_API_ID);
        List<Map<String, Object>> someGames = ServiceTool.vGameTypeService().searchProperties(vGameTypeListVo);
        if (CollectionTool.isNotEmpty(someGames)) {
            Map<String, Api> apiMap = Cache.getApi();
            Map<String, SiteApi> siteApiMap = Cache.getSiteApi();
            String disable = GameStatusEnum.DISABLE.getCode();
            Iterator it = someGames.iterator();
            while (it.hasNext()) {
                Map<String, Object> game = (Map<String, Object>) it.next();
                Api api = apiMap.get(MapTool.getString(game, VGameType.PROP_API_ID));
                SiteApi siteApi = siteApiMap.get(MapTool.getString(game, VGameType.PROP_API_ID));
                if (api == null || siteApi == null || disable.equals(api.getSystemStatus()) || disable.equals(siteApi.getSystemStatus())) {
                    it.remove(); //移除该对象
                }
            }
        }
        objectVo.setSomeGames(someGames);
        return objectVo;
    }
    //endregion your codes 3

}