package so.wwb.gamebox.mcenter.analyze.controller;


import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.analyze.IVAnalyzePlayerService;
import so.wwb.gamebox.mcenter.analyze.form.AnalyzeParamForm;
import so.wwb.gamebox.mcenter.analyze.form.VAnalyzePlayerForm;
import so.wwb.gamebox.mcenter.analyze.form.VAnalyzePlayerSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.master.analyze.po.VAnalyzePlayer;
import so.wwb.gamebox.model.master.analyze.vo.VAnalyzePlayerListVo;
import so.wwb.gamebox.model.master.analyze.vo.VAnalyzePlayerVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.Date;
import java.util.Map;


/**
 * 控制器
 *
 * @author jerry
 * @time 2016-12-7 16:12:12
 */
@Controller
//region your codes 1
@RequestMapping("/vAnalyzePlayer")
public class VAnalyzePlayerController extends BaseCrudController<IVAnalyzePlayerService, VAnalyzePlayerListVo, VAnalyzePlayerVo, VAnalyzePlayerSearchForm, VAnalyzePlayerForm, VAnalyzePlayer, Integer> {

    private static final Log LOG = LogFactory.getLog(VAnalyzePlayerController.class);
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/analyze/";
        //endregion your codes 2
    }

    //region your codes 3

    /**
     * 代理新近
     *
     * @param listVo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/analyze")
    public String analyze(VAnalyzePlayerListVo listVo,VAnalyzePlayerSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        initVo(listVo);
        //默认昨天的统计
        defaultStaticTime(listVo);
        if (ServletTool.isAjaxSoulRequest(request)) {
            listVo = resetFormatTime(listVo);
            listVo = this.getService().analyze(listVo);
            model.addAttribute("command",listVo);
            return getViewBasePath() + "AnalyzePartial";
        } else {
            listVo.setValidateRule(JsRuleCreator.create(form.getClass(), "search"));
            model.addAttribute("command",listVo);
            return getViewBasePath()+"Analyze";
        }
    }
    /**
     * 代理新近-总况
     *
     * @param listVo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/analyzeSurvey")
    public String analyzeSurvey(VAnalyzePlayerListVo listVo,VAnalyzePlayerSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        initVo(listVo);
        //近期损益（仅统计近40天的数据,不包含今天）
        Date today = SessionManager.getDate().getToday();
        Date todayEnd = DateTool.addDays(SessionManager.getDate().getToday(),-40);
        listVo.getSearch().setStartStaticTime(todayEnd);
        listVo.getSearch().setEndStaticTime(today);
        if (ServletTool.isAjaxSoulRequest(request)) {
            listVo = resetFormatTime(listVo);
            listVo = this.getService().analyzeSurvey(listVo);
            model.addAttribute("command",listVo);
            return getViewBasePath() + "AnalyzeSurveyPartial";
        } else {
            listVo.setValidateRule(JsRuleCreator.create(form.getClass(), "search"));
            model.addAttribute("command",listVo);
            return getViewBasePath()+"AnalyzeSurvey";
        }
    }

    /**
     * 代理链接
     *
     * @param listVo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/analyzeLink")
    public String analyzeLink(VAnalyzePlayerListVo listVo,VAnalyzePlayerSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        //默认检索完成时间:最近1天
        initVo(listVo);
        defaultStaticTime(listVo);
        listVo = this.getService().analyzeLink(listVo);
        model.addAttribute("command",listVo);
        if (ServletTool.isAjaxSoulRequest(request)) {
            listVo = this.getService().analyzeLink(listVo);
            model.addAttribute("command",listVo);
            return getViewBasePath() + "link/AnalyzeLinkPartial";
        } else {
            listVo.setValidateRule(JsRuleCreator.create(form.getClass(), "search"));
            //Date endStaticTime = listVo.getSearch().getEndStaticTime();
            //listVo.getSearch().setEndStaticTime(DateTool.addSeconds(endStaticTime,-1));
            model.addAttribute("command",listVo);
            return getViewBasePath()+"link/AnalyzeLink";
        }
    }
    /**
     * 代理链接-总况
     *
     * @param listVo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/analyzeLinkSurvey")
    public String analyzeLinkSurvey(VAnalyzePlayerListVo listVo,VAnalyzePlayerSearchForm form, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) {
        initVo(listVo);
        if (ServletTool.isAjaxSoulRequest(request)) {
            listVo = resetFormatTime(listVo);
            listVo = this.getService().analyzeLinkSurvey(listVo);
            model.addAttribute("command",listVo);
            return getViewBasePath() + "link/AnalyzeLinkSurveyPartial";
        } else {
            listVo.setValidateRule(JsRuleCreator.create(form.getClass(), "search"));
            model.addAttribute("command",listVo);
            return getViewBasePath()+"link/AnalyzeLinkSurvey";
        }
    }

    private VAnalyzePlayerListVo resetFormatTime(VAnalyzePlayerListVo listVo) {
        Date startStaticTime = listVo.getSearch().getStartStaticTime();
        if(startStaticTime!=null){
            String s = DateTool.formatDate(startStaticTime, SessionManager.getLocale(), SessionManager.getTimeZone(), CommonContext.getDateFormat().getDAY());
            Date parse = LocaleDateTool.parse(s);
            listVo.getSearch().setStartStaticTime(parse);
        }

        Date endStaticTime = listVo.getSearch().getEndStaticTime();
        if(endStaticTime!=null){
            String s1 = DateTool.formatDate(endStaticTime, SessionManager.getLocale(), SessionManager.getTimeZone(), CommonContext.getDateFormat().getDAY());
            Date parse1 = LocaleDateTool.parse(s1);
            listVo.getSearch().setEndStaticTime(parse1);
        }

        return listVo;
    }

    private void defaultStaticTime(VAnalyzePlayerListVo listVo) {
        //默认昨天的统计
        if (listVo.getSearch().getStartStaticTime() == null && listVo.getSearch().getEndStaticTime() == null) {
            listVo.getSearch().setStartStaticTime(SessionManager.getDate().getYestoday());
            listVo.getSearch().setEndStaticTime(SessionManager.getDate().getToday());
        }else{
            //listVo.getSearch().setEndStaticTime(DateTool.addDays(listVo.getSearch().getEndStaticTime(),1));
        }
    }
    /**
     * 有效玩家设置
     *
     * @return
     * jerry
     */
    @RequestMapping("/analyzeParam")
    public String analyzeParam(Model model,VAnalyzePlayerListVo vo){
        vo.setValidateRule(JsRuleCreator.create(AnalyzeParamForm.class));
        initVo(vo);
        model.addAttribute("command",vo);
        return getViewBasePath() +"/AnalyzeParam";
    }

    private void initVo(VAnalyzePlayerListVo vo) {
        String username = vo.getSearch().getUsername();
        if(StringTool.isNotBlank(username)){
            String[] split = username.split(",");
            if(split.length==1){
                vo.getSearch().setUsername(split[0]);
                vo.getSearch().setUsernames(null);
            }else{
                vo.getSearch().setUsernames(split);
                vo.getSearch().setUsername(null);
            }
        }
        SysParam depositCount = ParamTool.getSysParam(SiteParamEnum.ANALYZE_PLAYER_DEPOSIT_COUNT);
        if(depositCount == null){
            depositCount = new SysParam();
            depositCount.setParamValue("0");
        }
        SysParam deposit = ParamTool.getSysParam(SiteParamEnum.ANALYZE_PLAYER_DEPOSIT);
        if(deposit == null){
            deposit = new SysParam();
            deposit.setParamValue("0");
        }
        SysParam effective = ParamTool.getSysParam(SiteParamEnum.ANALYZE_PLAYER_EFFECTIVE);
        if(effective == null){
            effective = new SysParam();
            effective.setParamValue("0");
        }
        ParamTool.refresh(SiteParamEnum.ANALYZE_PLAYER_STATIC_TIME_END);
        SysParam staticTime = ParamTool.getSysParam(SiteParamEnum.ANALYZE_PLAYER_STATIC_TIME_END);
        Date date = DateTool.parseDate(staticTime.getParamValue(), DateTool.yyyy_MM_dd_HH_mm_ss);
        Date date1 = SessionManager.getDate().getToday();
        //如果是昨天的时间
        if(date.getTime()<date1.getTime()){
            staticTime.setParamValue("00:00:00");
        }else{
            staticTime.setParamValue(DateTool.formatDate(date,DateTool.HH_mm_ss));
        }
        vo.setDepositCountParam(depositCount);
        vo.setDepositParam(deposit);
        vo.setEffectiveParam(effective);
        vo.setStaticTimeParam(staticTime);


        Date today = SessionManager.getDate().getToday();
        Date todayEnd = DateTool.addDays(SessionManager.getDate().getToday(),1);
        String s = DateTool.formatDate(today, DateTool.yyyy_MM_dd);
        vo.getSearch().setDay(DateTool.parseDate(s,DateTool.yyyy_MM_dd));
        vo.getSearch().setDaySecondStart(today);
        vo.getSearch().setDaySecondEnd(todayEnd);
        LOG.debug("调用分析函数的三个参数为 day:{0},DaySecondStart:{1},DaySecondEnd{2}",s,DateTool.formatDate(today,DateTool.yyyy_MM_dd_HH_mm_ss),DateTool.formatDate(todayEnd,DateTool.yyyy_MM_dd_HH_mm_ss));
    }

    /**
     * 有效玩家设置
     *
     * @return
     * jerry
     */
    @RequestMapping("/saveAnalyzeParam")
    @ResponseBody
    public Map saveAnalyzeParam(VAnalyzePlayerListVo vo, @FormModel("result") @Valid AnalyzeParamForm form, BindingResult result){
        if(!result.hasErrors()){
            SysParamVo sysParamVo = new SysParamVo();
            sysParamVo.setProperties(SysParam.PROP_PARAM_VALUE);
            if(StringTool.isBlank(vo.getDepositCountParam().getParamValue())){
                vo.getDepositCountParam().setParamValue("0");
            }
            sysParamVo.setResult(vo.getDepositCountParam());
            ServiceTool.siteSysParamService().updateOnly(sysParamVo);
            if(StringTool.isBlank(vo.getDepositParam().getParamValue())){
                vo.getDepositParam().setParamValue("0");
            }
            sysParamVo.setResult(vo.getDepositParam());
            ServiceTool.siteSysParamService().updateOnly(sysParamVo);
            if(StringTool.isBlank(vo.getEffectiveParam().getParamValue())){
                vo.getEffectiveParam().setParamValue("0");
            }
            sysParamVo.setResult(vo.getEffectiveParam());
            ServiceTool.siteSysParamService().updateOnly(sysParamVo);

            ParamTool.refresh(SiteParamEnum.ANALYZE_PLAYER_DEPOSIT_COUNT);
            ParamTool.refresh(SiteParamEnum.ANALYZE_PLAYER_DEPOSIT);
            ParamTool.refresh(SiteParamEnum.ANALYZE_PLAYER_EFFECTIVE);
            return getVoMessage(vo);
        }
        return null;
    }


    //endregion your codes 3

}