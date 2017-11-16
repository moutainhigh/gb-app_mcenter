package so.wwb.gamebox.mcenter.setting.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.collections.ListTool;
import org.soul.commons.collections.MapTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.init.context.Const;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.support._Module;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.session.SessionManagerBase;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.setting.IRebateSetService;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.setting.form.RebateSetFeeForm;
import so.wwb.gamebox.mcenter.setting.form.RebateSetForm;
import so.wwb.gamebox.mcenter.setting.form.RebateSetSearchForm;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.SubSysCodeEnum;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.company.site.vo.VGameTypeListVo;
import so.wwb.gamebox.model.master.player.enums.UserAgentEnum;
import so.wwb.gamebox.model.master.player.po.UserAgentRebate;
import so.wwb.gamebox.model.master.player.vo.UserAgentRebateListVo;
import so.wwb.gamebox.model.master.player.vo.VUserAgentManageVo;
import so.wwb.gamebox.model.master.setting.po.RebateGrads;
import so.wwb.gamebox.model.master.setting.po.RebateSet;
import so.wwb.gamebox.model.master.setting.vo.RebateSetListVo;
import so.wwb.gamebox.model.master.setting.vo.RebateSetVo;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.*;

import static so.wwb.gamebox.model.ParamTool.getSysParam;


/**
 * 返佣设置表控制器
 *
 * @author loong
 * @time 2015-9-6 10:06:37
 */
@Controller
//region your codes 1
@RequestMapping("/rebateSet")
public class RebateSetController extends BaseCrudController<IRebateSetService, RebateSetListVo, RebateSetVo, RebateSetSearchForm, RebateSetForm, RebateSet, Integer> {

    private static final Log LOG = LogFactory.getLog(RebateSetController.class);

//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/setting/rebate/";
        //endregion your codes 2
    }

    //region your codes 3

    @Override
    protected RebateSetListVo doList(RebateSetListVo listVo, RebateSetSearchForm form, BindingResult result, Model model) {
        listVo.getSearch().setSearchFrom(SubSysCodeEnum.MCENTER.getCode());
        listVo = searchFromTopAgent(listVo);
        searchByOwnerName(listVo);
        return this.getService().searchCalRebateSet(listVo);
    }

    private RebateSetListVo searchByOwnerName(RebateSetListVo listVo){
        if(StringTool.isBlank(listVo.getSearch().getOwnerName())){
            return listVo;
        }
        if(String.valueOf(Const.MASTER_BUILT_IN_ID).equals(listVo.getSearch().getOwnerName())){
            listVo.getSearch().setOwnerId(Const.MASTER_BUILT_IN_ID);
            return listVo;
        }
        VUserAgentManageVo agentManageVo = new VUserAgentManageVo();
        agentManageVo.getSearch().setUsername(listVo.getSearch().getOwnerName());
        agentManageVo = ServiceTool.vUserAgentManageService().search(agentManageVo);
        if(agentManageVo.getResult()==null){
            listVo.getSearch().setOwnerId(-1);
        }else{
            listVo.getSearch().setOwnerId(agentManageVo.getResult().getId());
        }
        return listVo;
    }

    private RebateSetListVo searchFromTopAgent(RebateSetListVo listVo) {
        if (listVo.getTopAgentId() == null) {
            return listVo;
        }
        UserAgentRebateListVo rebateListVo = new UserAgentRebateListVo();
        rebateListVo.getSearch().setUserId(listVo.getTopAgentId());
        rebateListVo.setPaging(null);
        rebateListVo = ServiceTool.userAgentRebateService().search(rebateListVo);
        if (rebateListVo.getResult() != null) {
            List<Integer> ids = new ArrayList<>();
            for (UserAgentRebate rebate : rebateListVo.getResult()) {
                ids.add(rebate.getRebateId());
            }
            listVo.getSearch().setIds(ids);
        }

        return listVo;
    }

    @RequestMapping("/{id}/deleterebate")
    @ResponseBody
    protected Map batchDelete(@PathVariable Integer id) {
        RebateSetVo setVo = new RebateSetVo();
        setVo.setId(id);
        try {
            ServiceTool.rebateSetService().deleteRebateSet(setVo);
            setVo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_SUCCESS));
        } catch (Exception e) {
            setVo.setSuccess(false);
            setVo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.DELETE_FAILED));
            LOG.error(e);
        }
        return this.getVoMessage(setVo);
    }

    /**
     * 返佣设置-结算周期-view
     *
     * @param model Model
     * @return url
     */
    @RequestMapping("rebatePeriod/view")
    public String rebatePeriod(Model model) {
        Date today = SessionManagerBase.getDate().getNow();
        model.addAttribute("today", today);

        // 设置本月天数及排版
        model.addAttribute("dates", setMonthDays(today));

        // 获取返佣参数
        initParam(model);
        return this.getViewBasePath() + "RebatePeriod";
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
     * 获取返佣参数
     */
    private void initParam(Model model) {
        SysParam rebatePeriodParam = getSysParam(SiteParamEnum.SETTING_REBATESETTING_SETTLEMENTPERIODTIMES);
        SysParam agentWithdrawMinParam = getSysParam(SiteParamEnum.SETTING_AGENT_WITHDRAWAL_LIMIT_MIN);
        SysParam agentWithdrawMaxParam = getSysParam(SiteParamEnum.SETTING_AGENT_WITHDRAWAL_LIMIT_MAX);
        model.addAttribute("rebatePeriodParam", rebatePeriodParam);

        SysParam newParam = getSysParam(SiteParamEnum.SETTING_REBATESETTING_SETTLEMENTPERIODTIMESNEW);
        if (newParam != null) {
            model.addAttribute("rebatePeriodNew", newParam);
        }

        model.addAttribute("agentWithdrawMinParam", agentWithdrawMinParam);
        model.addAttribute("agentWithdrawMaxParam", agentWithdrawMaxParam);
    }

    /**
     * 返佣设置-结算周期-save
     *
     * @param rebateSetVo RebateSetVo
     * @return Map
     */
    @RequestMapping("rebatePeriod/save")
    @ResponseBody
    public Map saveRebatePeriod(RebateSetVo rebateSetVo) {
        SysParam[] sysParams = rebateSetVo.getSysParam();

        Map map = checkData(sysParams, sysParams[0].getParamValue());
        if (map != null) return map;

        List<SysParam> params = new ArrayList<>(4);
        for (SysParam sysParam : sysParams) {
            params.add(sysParam);
        }
        //params.addAll(Arrays.asList(sysParams));
        // 设置生效时间
        params.add(setEffectiveTime());

        // 初始化要修改的参数
        SysParamVo paramVo = initParamVo(params);

        int result = ServiceTool.getSysParamService().batchUpdateOnly(paramVo);
        refreshPram(result);

        return this.getVoMessage(paramVo);
    }

    /**
     * 设置生效时间
     */
    private SysParam setEffectiveTime() {
        SysParam param = getSysParam(SiteParamEnum.SETTING_REBATESETTING_SETTLEMENTPERIODEFFECTIVETIME);
        Date effeDate = DateTool.addMilliseconds(DateTool.ceiling(new Date(), Calendar.MONTH),
                -CommonContext.get().getTimeZone().getRawOffset());
        param.setParamValue(DateTool.formatDate(effeDate, DateTool.FMT_HYPHEN_DAY_CLN_SECOND));
        param.setActive(true);
        return param;
    }

    /**
     * 初始化要修改的参数
     *
     * @return SysParamVo
     */
    private SysParamVo initParamVo(List<SysParam> sysParamList) {
        SysParamVo sysParamVo = new SysParamVo();
        sysParamVo.setEntities(sysParamList);
        sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE, SysParam.PROP_ACTIVE);
        return sysParamVo;
    }

    /**
     * 刷新参数缓存
     */
    private void refreshPram(int result) {
        if (result > 0) {
            ParamTool.refresh(SiteParamEnum.SETTING_REBATESETTING_SETTLEMENTPERIODTIMESNEW);
            ParamTool.refresh(SiteParamEnum.SETTING_REBATESETTING_SETTLEMENTPERIODEFFECTIVETIME);
            ParamTool.refresh(SiteParamEnum.SETTING_AGENT_WITHDRAWAL_LIMIT_MIN);
            ParamTool.refresh(SiteParamEnum.SETTING_AGENT_WITHDRAWAL_LIMIT_MAX);
        }
    }

    private Map checkData(SysParam[] sysParams, String rebatePeriodParamValue) {
        Map<String, Object> map = new HashMap<>(2,1f);
        if (StringTool.isBlank(rebatePeriodParamValue)) {
            map.put("msg", LocaleTool.tranMessage(Module.COMPANY_SETTING, "rakebackSetting.SettleAccountsCycleSetting.notBlank"));
            map.put("state", false);
            return map;
        } else if (!rebatePeriodParamValue.equals("0") && !rebatePeriodParamValue.equals("1")
                && !rebatePeriodParamValue.equals("2") && !rebatePeriodParamValue.equals("3") && !rebatePeriodParamValue.equals("4")) {
            map.put("msg", LocaleTool.tranMessage(Module.COMPANY_SETTING, "rakebackSetting.SettleAccountsCycleSetting.worngSubmit"));
            map.put("state", false);
            return map;
        }
        if (StringTool.isBlank(sysParams[1].getParamValue())) {
            map.put("msg", LocaleTool.tranMessage(Module.COMPANY_SETTING, "rebate.setting.minNotNull"));
            map.put("state", false);
            return map;
        }
        if (StringTool.isBlank(sysParams[2].getParamValue())) {
            map.put("msg", LocaleTool.tranMessage(Module.COMPANY_SETTING, "rebate.setting.maxNotNull"));
            map.put("state", false);
            return map;
        }
        if (Long.valueOf(sysParams[2].getParamValue()).compareTo(Long.valueOf(sysParams[1].getParamValue())) <= 0) {
            map.put("msg", LocaleTool.tranMessage(Module.COMPANY_SETTING, "rebate.setting.minPassMax"));
            map.put("state", false);
            return map;
        }
        return null;
    }


    /**
     * 复制返佣方案 -younger
     * @param objectVo
     * @param model
     * @return
     */
    @RequestMapping(value = "copyRebateSet")
    @Token(generate = true)
    public String copyRebateSet(RebateSetVo objectVo, Model model){
        objectVo = doEdit(objectVo,model);
        objectVo.getResult().setId(null);
        objectVo.getResult().setName(objectVo.getResult().getName()+"_copy");
        objectVo.setShowDeleteBtn(true);
        List<RebateGrads> rebateGrads = objectVo.getRebateGrads();
        CollectionTool.batchUpdate(rebateGrads, RebateGrads.PROP_ID, null);
        objectVo.setValidateRule(JsRuleCreator.create(RebateSetForm.class));
        model.addAttribute("command",objectVo);
        return getViewBasePath() + "Edit";
    }

    @Override
    protected RebateSetVo doCreate(RebateSetVo objectVo, Model model) {
        objectVo = super.doCreate(objectVo, model);

        return setGame(objectVo);
    }

    @Override
    protected RebateSetVo doEdit(RebateSetVo objectVo, Model model) {
        objectVo = getService().queryRebateById(objectVo);
        boolean canBeDelete = getService().isRebateGradsCanBeDelete(objectVo);
        objectVo.setShowDeleteBtn(canBeDelete);
        return setGame(objectVo);
    }

    @Override
    protected RebateSetVo doSave(RebateSetVo objectVo) {
        objectVo.getResult().setCreateUserId(SessionManager.getUserId());
        objectVo.getResult().setCreateTime(new Date());
        objectVo.getResult().setStatus(UserAgentEnum.PROGRAM_STATUS_USING.getCode());
        objectVo.getResult().setOwnerId(Const.MASTER_BUILT_IN_ID);
        objectVo = getService().saveNewRebateSet(objectVo);
        return objectVo;
    }

    @Override
    protected RebateSetVo doUpdate(RebateSetVo objectVo) {
        objectVo.getResult().setStatus(UserAgentEnum.PROGRAM_STATUS_USING.getCode());
        objectVo.getSearch().setSearchFrom(SubSysCodeEnum.MCENTER.getCode());
        objectVo = getService().updateNewRebateSet(objectVo);
        return objectVo;
    }

    @Override
    protected RebateSetVo doView(RebateSetVo objectVo, Model model) {
        return setGame(getService().queryRebateById(objectVo));
    }

    /**
     * 新增/编辑需要的游戏信息
     *
     * @param objectVo
     * @return
     */
    public RebateSetVo setGame(RebateSetVo objectVo) {
        VGameTypeListVo vGameTypeListVo = new VGameTypeListVo();
        vGameTypeListVo.getSearch().setSiteId(SessionManager.getSiteId());
        vGameTypeListVo.setCahceApiMap(Cache.getApi());
        vGameTypeListVo.setCahceSiteApiMap(Cache.getSiteApi());
        List<Map<String, Object>> someGames = getService().queryGameData(vGameTypeListVo);
        objectVo.setSomeGames(someGames);
        return objectVo;
    }

    @Override
    @Token(generate = true)
    public String create(RebateSetVo objectVo, Model model, HttpServletRequest request, HttpServletResponse response) {
        return super.create(objectVo, model, request, response);
    }

    @Override
    @Token(generate = true)
    public String edit(RebateSetVo objectVo, Integer id, Model model, HttpServletRequest request, HttpServletResponse response) {
        return super.edit(objectVo, id, model, request, response);
    }

    @Override
    @Token(valid = true)
    public Map persist(RebateSetVo objectVo, @FormModel("result") @Valid RebateSetForm form, BindingResult result) {
        Map persist = new HashMap(3,1f);
        try{
            persist = super.persist(objectVo, form, result);
            if(!MapTool.getBoolean(persist,"state")){
                persist.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
            }
        }catch (Exception ex){
            persist.put("state",false);
            String msg = LocaleTool.tranMessage(Module.COMMON, MessageI18nConst.SAVE_FAILED);
            if("返佣比例不能小于下级代理设置的比例".equals(ex.getMessage())){
                String errMsg = LocaleTool.tranMessage(Module.MASTER_SETTING, MessageI18nConst.REBATE_EDIT_VALIDSUBAGENTREBATE);
                msg += ":"+errMsg;
            }
            persist.put("msg",msg);
            persist.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
            LOG.error(ex,"保存返佣方案出错:{0}",ex.getMessage());
        }

        return  persist;
    }

    /**
     * 代理存取款手续费设置
     * add by Bruce
     *
     * @param model
     * @return
     */
    @RequestMapping("agentRebateDAWF")
    public String agentRebateDepositAndWithdrawFee(Model model) {
        model.addAttribute("validateRule", JsRuleCreator.create(RebateSetFeeForm.class));

        // 获取存取款手续费
        SysParam depositFee = ParamTool.getSysParam(SiteParamEnum.SETTLEMENT_DEPOSIT_FEE);
        SysParam withdrawFee = ParamTool.getSysParam(SiteParamEnum.SETTLEMENT_WITHDRAW_FEE);
        SysParam withdrawLimitMin = ParamTool.getSysParam(SiteParamEnum.SETTING_AGENT_WITHDRAWAL_LIMIT_MIN);
        SysParam withdrawLimitMax = ParamTool.getSysParam(SiteParamEnum.SETTING_AGENT_WITHDRAWAL_LIMIT_MAX);

        model.addAttribute("depositFee", depositFee);
        model.addAttribute("withdrawFee", withdrawFee);
        model.addAttribute("withdrawLimitMin", withdrawLimitMin);
        model.addAttribute("withdrawLimitMax", withdrawLimitMax);

        SysParam rakebackParam = ParamTool.getSysParam(SiteParamEnum.SETTING_APPORTIONSETTING_AGENT_RAKEBACK_PERCENT);
        SysParam favorableParam = ParamTool.getSysParam(SiteParamEnum.SETTING_APPORTIONSETTING_AGENT_PREFERENTIAL_PERCENT);
        SysParam adminParam = ParamTool.getSysParam(SiteParamEnum.SETTING_APPORTIONSETTING_AGENT_ADMINISTRATOR_PERCENT);
        SysParam otherParam = ParamTool.getSysParam(SiteParamEnum.SETTING_APPORTIONSETTING_AGENT_OTHER_PERCENT);
        model.addAttribute("rakebackParam", rakebackParam);
        model.addAttribute("favorableParam", favorableParam);
        model.addAttribute("adminParam", adminParam);
        model.addAttribute("otherParam", otherParam);

        SysParam rakbackParam = ParamTool.getSysParam(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_RAKEBACK_PERCENT);
        SysParam preferentialParam = ParamTool.getSysParam(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_PREFERENTIAL_PERCENT);
        SysParam topAdminParam = ParamTool.getSysParam(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_ADMINISTRATOR_PERCENT);
        SysParam topOtherParam = ParamTool.getSysParam(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_OTHER_PERCENT);
        model.addAttribute("rakbackParam",rakbackParam);
        model.addAttribute("preferentialParam",preferentialParam);
        model.addAttribute("topAdminParam",topAdminParam);
        model.addAttribute("topOtherParam",topOtherParam);

        SysParam rebateParam = ParamTool.getSysParam(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_REBATE_PERCENT);
        model.addAttribute("rebateParam", rebateParam);
        return this.getViewBasePath() + "AgentRebateDepositAndWithdrawFee";
    }

    /**
     * 保存代理存取款手续费设置
     * add by Bruce
     *
     * @param rebateSetVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping("save")
    @ResponseBody
    public Map<String, Object> saveAgentRebateDepositAndWithdrawFee(RebateSetVo rebateSetVo, @Valid @FormModel RebateSetFeeForm form, BindingResult result, Model model) {
        Map<String, Object> map = new HashMap<>(2,1f);
        if (result.hasErrors()) {
            map.put("state", false);
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
            return map;
        }
        SysParam [] sysParams = rebateSetVo.getSysParam();
        double sysParam2 = Double.parseDouble(sysParams[2].getParamValue());
        double sysParam3 = Double.parseDouble(sysParams[3].getParamValue());
        double sysParam4 = Double.parseDouble(sysParams[4].getParamValue());
        double sysParam5 = Double.parseDouble(sysParams[5].getParamValue());
        double sysParam6 = Double.parseDouble(sysParams[6].getParamValue());
        double sysParam7 = Double.parseDouble(sysParams[7].getParamValue());
        double rakeback = sysParam2 + sysParam6;
        double promot = sysParam3 + sysParam5;
        double other = sysParam4 + sysParam7;
        boolean flag = true;
        if (rakeback>100 || promot>100 || other>100){
            flag = false;
        }
        if(!flag){
            map.put("state", false);
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
            return map;
        }
        List<SysParam> sysParamList = new ArrayList<>();
        SysParam[] sysParamLimit = rebateSetVo.getSysParamLimit();
        for (SysParam sysParam : sysParams) {
            sysParamList.add(sysParam);
        }
        for (SysParam sysParam : sysParamLimit) {
            sysParamList.add(sysParam);
        }
        SysParamVo paramVo = new SysParamVo();
        paramVo.setEntities(sysParamList);
        paramVo.setProperties(SysParam.PROP_PARAM_VALUE);
        int res = ServiceTool.getSysParamService().batchUpdateOnly(paramVo);
        if (res > 0) {
            map.put("state", true);
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_SUCCESS));
            ParamTool.refresh(SiteParamEnum.SETTLEMENT_DEPOSIT_FEE);
            ParamTool.refresh(SiteParamEnum.SETTLEMENT_WITHDRAW_FEE);
            ParamTool.refresh(SiteParamEnum.SETTING_AGENT_WITHDRAWAL_LIMIT_MIN);
            ParamTool.refresh(SiteParamEnum.SETTING_AGENT_WITHDRAWAL_LIMIT_MAX);

            ParamTool.refresh(SiteParamEnum.SETTING_APPORTIONSETTING_AGENT_ADMINISTRATOR_PERCENT);
            ParamTool.refresh(SiteParamEnum.SETTING_APPORTIONSETTING_AGENT_RAKEBACK_PERCENT);
            ParamTool.refresh(SiteParamEnum.SETTING_APPORTIONSETTING_AGENT_OTHER_PERCENT);
            ParamTool.refresh(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_PREFERENTIAL_PERCENT);

            ParamTool.refresh(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_PREFERENTIAL_PERCENT);
            ParamTool.refresh(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_ADMINISTRATOR_PERCENT);
            ParamTool.refresh(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_RAKEBACK_PERCENT);
            ParamTool.refresh(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_OTHER_PERCENT);
            ParamTool.refresh(SiteParamEnum.SETTING_APPORTIONSETTING_TOPAGENT_REBATE_PERCENT);
        } else {
            map.put("state", false);
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
        }
        return map;
    }

    //endregion your codes 3

}