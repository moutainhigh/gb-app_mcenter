package so.wwb.gamebox.mcenter.operation.controller;


import org.soul.commons.collections.CollectionTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.model.sys.po.SysDict;
import org.soul.model.sys.po.SysParam;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.company.sys.IVDomainCheckResultStatisticsService;
import so.wwb.gamebox.mcenter.operation.form.VDomainCheckResultStatisticsForm;
import so.wwb.gamebox.mcenter.operation.form.VDomainCheckResultStatisticsSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.BossParamEnum;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.company.enums.DomainCheckResultImportStatusEnum;
import so.wwb.gamebox.model.company.enums.DomainCheckResultStatusEnum;
import so.wwb.gamebox.model.company.sys.po.DomainCheckResultBatchLog;
import so.wwb.gamebox.model.company.sys.po.VDomainCheckResultStatistics;
import so.wwb.gamebox.model.company.sys.vo.*;
import so.wwb.gamebox.web.SessionManagerCommon;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;


/**
 * 控制器
 * 域名检测视图
 *
 * @author lock
 * @time 2018-1-8 11:21:38
 */
@Controller
//region your codes 1
@RequestMapping("/operation/domainCheckData")
public class VDomainCheckResultStatisticsController extends BaseCrudController<IVDomainCheckResultStatisticsService, VDomainCheckResultStatisticsListVo, VDomainCheckResultStatisticsVo, VDomainCheckResultStatisticsSearchForm, VDomainCheckResultStatisticsForm, VDomainCheckResultStatistics, String> {
    //endregion your codes 1
    private static final Log LOG = LogFactory.getLog(VDomainCheckResultStatisticsController.class);

    private static final String PROP_ACTIVITY_INDEX = "/operation/domainCheck/Index";

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/domainCheck/";
        //endregion your codes 2
    }

    //region your codes 3


    /**
     * 根据域名状态、类型 统计数据
     */
    @RequestMapping("/getDomainCount")
    public String getDomainCount(VDomainCheckResultStatisticsListVo statisticsListVo, @FormModel("search") @Valid VDomainCheckResultStatisticsForm form, BindingResult result, Model model, HttpServletRequest request) {
        Integer siteId = SessionManager.getSiteId();
        //获取统计域名状态列表
        statisticsListVo.setSiteId(siteId);
        statisticsListVo = ServiceTool.vDomainCheckResultStatisticsService().getDomainCount(statisticsListVo);
        //获取总条件
        DomainCheckResultListVo listVo = new DomainCheckResultListVo();

        listVo.getSearch().setSiteId(siteId);
        //查询综合信息(获取检测时间，监测点,状态总信息)
        listVo = ServiceTool.domainCheckResultService().getComprehensiveInfo(listVo);
        //获取字典信息列表前台下拉显示
        listVo = getDictInfo(listVo);
        statisticsListVo.setDomainCheckResultListVo(listVo);
        //控制120分钟一次
        long minuts = 0;
//        if (listVo.getCheckTime() != null) {
//            minuts = 120 - DateTool.minutesBetween(new Date(), listVo.getCheckTime());
//            //上次时间比当前时间大
//            if (minuts >= 120) {
//                minuts = 120;
//            }
//            if (minuts < 0) {
//                minuts = 0;
//            }
//        }
        model.addAttribute("leave_minus", minuts);
        model.addAttribute("command", statisticsListVo);


        if (ServletTool.isAjaxSoulRequest(request)) {
            return PROP_ACTIVITY_INDEX + "Partial";
        } else {
            return PROP_ACTIVITY_INDEX;
        }
    }

    /**
     * 获取字典信息列表前台显示
     *
     * @param listVo
     */
    private DomainCheckResultListVo getDictInfo(DomainCheckResultListVo listVo) {
        //域名类型对应的描述
        Collection<SysParam> sysParams = ParamTool.getSysParams(BossParamEnum.CONTENT_DOMAIN_TYPE_INDEX);
        Map<String, String> pageUrl = new HashMap<>();
        Collection<SysParam> sysParams1 = new ArrayList<>();
        for (SysParam sysParam : sysParams) {
            pageUrl.put(sysParam.getParamValue(), sysParam.getResourceKey());
            if (!"creditPay".equals(sysParam.getParamCode())) {
                sysParams1.add(sysParam);
            }
        }
        listVo.setPageUrl(pageUrl);
        listVo.setDomainTypes(sysParams1);

        //状态
        Map<String, SysDict> domainStatus = DictTool.get(DictEnum.COMMON_DOMAIN_CHECK_RESULT_STATUS);
        domainStatus.remove(DomainCheckResultStatusEnum.NORMAL.getCode());//删掉正常状态
        listVo.setDomainStatus(domainStatus);

        return listVo;
    }

    @RequestMapping(value = "/manualcheck")
    @ResponseBody
    public String domainManualCheck(HttpServletRequest request, HttpServletResponse response) {
        LOG.info("手动触发域名检测....");
        String domainStr = request.getParameter("domain");
        DomainCheckRequestVo requestVo = new DomainCheckRequestVo();
        requestVo.setSiteId(SessionManager.getSiteId());
        requestVo.setDomainStr(domainStr);
        return getService().manualCheck(requestVo);
    }

    @RequestMapping(value = "/checkTaskStatus")
    @ResponseBody
    public String manualCheckTaskStatus(HttpServletRequest request, HttpServletResponse response) {
        String taskId = request.getParameter("taskId");
        DomainCheckResultBatchLogListVo logListVo = new DomainCheckResultBatchLogListVo();
        logListVo.getSearch().setTaskId(taskId);
        logListVo.getSearch().setSiteId(SessionManagerCommon.getSiteId());
        logListVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(DomainCheckResultBatchLog.PROP_SITE_ID, Operator.EQ, SessionManagerCommon.getSiteId()),
                new Criterion(DomainCheckResultBatchLog.TASK_ID,Operator.EQ,taskId)
        });
        DomainCheckResultBatchLogListVo search = ServiceTool.domainCheckResultBatchLogService().search(logListVo);
        if (CollectionTool.isEmpty(search.getResult())) {
            return DomainCheckResultImportStatusEnum.EXCEPTION.getCode();
        }
        //GB,OP同为运行中为正常状态，提示运行中;状态不一致为异常
        else if (new Integer(DomainCheckResultImportStatusEnum.PROCESS.getCode()).equals(search.getResult().get(0).getStatus())) {
            //httpclient查询OP任务情况
            String domainStr = request.getParameter("domain");
            DomainCheckRequestVo requestVo = new DomainCheckRequestVo();
            requestVo.setSiteId(SessionManager.getSiteId());
            requestVo.setDomainStr(domainStr);
            requestVo.setTaskId(taskId);
            String taskState = ServiceTool.vDomainCheckResultStatisticsService().getTaskState(requestVo);
            if ("pedding".equals(taskState)){
                return DomainCheckResultImportStatusEnum.PROCESS.getCode();
            }
            else{
                //GB,OP状态不一致为异常，GB端终止任务，提示失败
                LOG.warn("[域名检测]GB和OP两端域名检测任务状态不一致，修改GB端任务状态为失败");
                DomainCheckResultBatchLogVo batchLogVo = new DomainCheckResultBatchLogVo();
                batchLogVo.setResult(search.getResult().get(0));
                batchLogVo.getResult().setStatus(new Integer(DomainCheckResultImportStatusEnum.EXCEPTION.getCode()));
                batchLogVo.setProperties(DomainCheckResultBatchLog.PROP_STATUS);
                batchLogVo = ServiceTool.domainCheckResultBatchLogService().updateOnly(batchLogVo);
                return DomainCheckResultImportStatusEnum.EXCEPTION.getCode();
            }
        }
        return search.getResult().get(0).getStatus() + "";
    }


    //endregion your codes 3

}