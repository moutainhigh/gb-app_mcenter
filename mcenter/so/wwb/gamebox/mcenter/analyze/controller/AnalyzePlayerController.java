package so.wwb.gamebox.mcenter.analyze.controller;


import org.soul.commons.dubbo.DubboTool;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.analyze.IAnalyzePlayerService;
import so.wwb.gamebox.iservice.master.analyze.IVAnalyzePlayerService;
import so.wwb.gamebox.mcenter.analyze.form.AnalyzeParamForm;
import so.wwb.gamebox.mcenter.analyze.form.AnalyzePlayerForm;
import so.wwb.gamebox.mcenter.analyze.form.AnalyzePlayerSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.company.enums.SysSiteStatusEnum;
import so.wwb.gamebox.model.company.sys.vo.SysSiteVo;
import so.wwb.gamebox.model.master.analyze.po.AnalyzePlayer;
import so.wwb.gamebox.model.master.analyze.vo.AnalyzePlayerListVo;
import so.wwb.gamebox.model.master.analyze.vo.AnalyzePlayerVo;
import so.wwb.gamebox.model.master.analyze.vo.VAnalyzePlayerListVo;

import javax.validation.Valid;
import java.text.ParseException;
import java.util.Date;
import java.util.TimeZone;

import static org.soul.commons.lang.DateTool.convertDateByTimezone;


/**
 * 玩家分析控制器
 *
 * @author jerry
 * @time 2016-12-26 19:44:20
 */
@Controller
//region your codes 1
@RequestMapping("/analyzePlayer")
public class AnalyzePlayerController extends BaseCrudController<IAnalyzePlayerService, AnalyzePlayerListVo, AnalyzePlayerVo, AnalyzePlayerSearchForm, AnalyzePlayerForm, AnalyzePlayer, Integer> {

    private static final Log log = LogFactory.getLog(AnalyzePlayerController.class);
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/analyze/";
        //endregion your codes 2
    }

    //region your codes 3
    @RequestMapping("/effectivePlayerCount")
    @ResponseBody
    public long effectivePlayerCount(AnalyzePlayerListVo listVo) throws ParseException {
//        SELECT gb_analyze_player('2016-12-19', '2016-12-18 16:00:00', '2016-12-19 16:00:00');
//        Date date = DateTool.parseDate("2017-02-01 16:00:00", DateTool.FMT_HYPHEN_DAY_CLN_SECOND);
//        Date date1 = new Date();
//
//        long l = DateTool.daysBetween(date1,date );
//
//        for (int i=0;i<=l;i++) {
//            Date date2 = DateTool.addDays(date, i);
//
//
//            String day = DateTool.formatDate(date2,DateTool.FMT_HYPHEN_DAY);
//            String start = DateTool.formatDate(DateTool.addDays(date2,-1),DateTool.FMT_HYPHEN_DAY_CLN_SECOND);
//            String end = DateTool.formatDate(DateTool.addSeconds(date2,0),DateTool.FMT_HYPHEN_DAY_CLN_SECOND);
//
//            System.out.println("SELECT gb_analyze('"+day+"', '"+start+"', '"+end+"'); ");
//
//        }

        Date startTime = DateTool.addDays(listVo.getSearch().getStartStaticTime(), 1);
        listVo.getSearch().setStartStaticTime(startTime);
        Date endTime = DateTool.addDays(listVo.getSearch().getEndStaticTime(), 1);
        listVo.getSearch().setEndStaticTime(endTime);
        if(StringTool.isNotBlank(listVo.getSearch().getPromoteLink())){
            listVo.getSearch().setPromoteLink(listVo.getSearch().getPromoteLink().replaceAll(",",""));
        }
        SysParam deposit = ParamTool.getSysParam(SiteParamEnum.ANALYZE_PLAYER_DEPOSIT);
        SysParam depositCount = ParamTool.getSysParam(SiteParamEnum.ANALYZE_PLAYER_DEPOSIT_COUNT);
        SysParam effective = ParamTool.getSysParam(SiteParamEnum.ANALYZE_PLAYER_EFFECTIVE);
        listVo.getSearch().setDepositAmount(Double.valueOf(deposit.getParamValue()));
        listVo.getSearch().setDepositCount(Integer.valueOf(depositCount.getParamValue()));
        listVo.getSearch().setEffectiveAmount(Double.valueOf(effective.getParamValue()));
        listVo.getSearch().setIsNewPlayer(true);
        long count = this.getService().count(listVo);
        return count;
    }
    /**
     * 有效玩家设置
     *
     * @return
     * jerry
     */
    @RequestMapping("/staticToday")
    @ResponseBody
    public String staticToday(VAnalyzePlayerListVo vo, @FormModel("result") @Valid AnalyzeParamForm form, BindingResult result) throws ParseException {
        SysParam param = ParamTool.getSysParam(SiteParamEnum.ANALYZE_PLAYER_STATIC_TIME_END);
        Date date = DateTool.parseDate(param.getParamValue(), DateTool.FMT_HYPHEN_DAY_CLN_SECOND);
        String staticTime = DateTool.formatDate(date,DateTool.FMT_CLN_SECOND);
//        if(DateTool.minutesBetween(date,new Date())<10){
            Date today = SessionManager.getDate().getToday();
            String s = DateTool.formatDate(today,SessionManager.getLocale(),SessionManager.getTimeZone(), DateTool.FMT_HYPHEN_DAY);
            vo.getSearch().setDay(DateTool.parseDate(s,DateTool.FMT_HYPHEN_DAY));
            vo.getSearch().setDaySecondStart(SessionManager.getDate().getToday());
            vo.getSearch().setDaySecondEnd(SessionManager.getDate().getTomorrow());
            String count = ServiceTool.vAnalyzePlayerService().staticToday(vo);
             log.debug("执行代理分析：站点ID:{0},日期：{1}，开始时间：{2},结束时间：{3},记录数:{4}",
                SessionManager.getSiteId(),
                DateTool.formatDate(vo.getSearch().getDay(), DateTool.FMT_HYPHEN_DAY),
                DateTool.formatDate(vo.getSearch().getDaySecondStart(), DateTool.FMT_HYPHEN_DAY_CLN_SECOND),
                DateTool.formatDate(vo.getSearch().getDaySecondEnd(), DateTool.FMT_HYPHEN_DAY_CLN_SECOND),
                count);
            Date cdate = convertDateByTimezone(new Date(), SessionManager.getTimeZone());
            staticTime = DateTool.formatDate(cdate,DateTool.FMT_CLN_SECOND);


            param.setParamValue(DateTool.formatDate(cdate,DateTool.FMT_HYPHEN_DAY_CLN_SECOND));
            SysParamVo sysParamVo = new SysParamVo();
            sysParamVo.setResult(param);
            ServiceTool.getSysParamService().update(sysParamVo);
            ParamTool.refresh(SiteParamEnum.ANALYZE_PLAYER_STATIC_TIME_END);
//        }
        return staticTime;
    }

    //analyzePlayer/reAnalyze.html?time=2017-02-18&times=2&siteId=1
    @RequestMapping("/reAnalyze")
    @ResponseBody
    public String reAnalyze(String time,int times,int siteId){
        Date date = DateTool.parseDate(time, DateTool.FMT_HYPHEN_DAY);

        SysSiteVo siteVo = new SysSiteVo();
        siteVo._setDataSourceId(-1);
        siteVo.getSearch().setId(siteId);
        siteVo = ServiceTool.sysSiteService().get(siteVo);

        Date convertDate = DateTool.changeTimeZone(date, TimeZone.getTimeZone(siteVo.getResult().getTimezone()),TimeZone.getTimeZone("GMT+0"));
        if(siteVo.getResult().getStatus().equals(SysSiteStatusEnum.NORMAL.getCode()) && siteVo.getResult().getId()>0){
            VAnalyzePlayerListVo vo = new VAnalyzePlayerListVo();
            for(int i=1;i<=times;i++){
                convertDate = DateTool.addDays(convertDate,1);
                Date start = DateTool.addDays(convertDate, -1);
                String s = DateTool.formatDate(convertDate, DateTool.FMT_HYPHEN_DAY);
                Date day = DateTool.parseDate(s, DateTool.FMT_HYPHEN_DAY);
                vo._setDataSourceId(siteVo.getResult().getId());
                vo.getSearch().setDay(day);
                vo.getSearch().setDaySecondStart(start);
                vo.getSearch().setDaySecondEnd(convertDate);
                IVAnalyzePlayerService service = DubboTool.getService(IVAnalyzePlayerService.class);
                log.debug("执行代理分析：站点ID:{0},日期：{1}，开始时间：{2},结束时间：{3},记录数:{4}",
                        siteVo.getResult().getId(),
                        DateTool.formatDate(vo.getSearch().getDay(), DateTool.FMT_HYPHEN_DAY),
                        DateTool.formatDate(vo.getSearch().getDaySecondStart(), DateTool.FMT_HYPHEN_DAY_CLN_SECOND),
                        DateTool.formatDate(vo.getSearch().getDaySecondEnd(), DateTool.FMT_HYPHEN_DAY_CLN_SECOND),
                        0);
                String count = service.staticToday(vo);
            }
        }
        return "执行成功--"+DateTool.formatDate(new Date(),DateTool.FMT_HYPHEN_DAY_CLN_SECOND);
    }
    //endregion your codes 3

}