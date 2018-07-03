package so.wwb.gamebox.mcenter.operation.controller;


import com.alibaba.fastjson.JSONObject;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.enums.YesNot;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.commons.net.http.HttpClientParam;
import org.soul.commons.net.http.HttpClientTool;
import org.soul.commons.net.http.HttpRequestMethod;
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
import java.util.*;


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

    private static final String MANUAL_CHECK_ERROR = "0";
    //private static final String DOMAIN_CHECK_URL = "http://data-ops.gbboss.com:20111";//地址是写死的，OP修改接口地址
//    private static final String DOMAIN_CHECK_URL = "http://domaincheck.dayu-boss.com:20111";
//    private static final String DOMAIN_CHECK_URL_CREATE_TASK = DOMAIN_CHECK_URL + "/check_domain";
//    private static final String DOMAIN_CHECK_URL_TASK_STATE = DOMAIN_CHECK_URL + "/get_task_state";

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
        return manualCheck(requestVo);
    }

    @RequestMapping(value = "/checkTaskStatus")
    @ResponseBody
    public String checkTaskStatus(HttpServletRequest request, HttpServletResponse response) {
        String taskId = request.getParameter("taskId");
        DomainCheckResultBatchLogListVo logListVo = new DomainCheckResultBatchLogListVo();
        logListVo.getSearch().setTaskId(taskId);
        logListVo.getSearch().setSiteId(SessionManagerCommon.getSiteId());
        logListVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(DomainCheckResultBatchLog.PROP_SITE_ID, Operator.EQ, SessionManagerCommon.getSiteId()),
                new Criterion(DomainCheckResultBatchLog.TASK_ID, Operator.EQ,taskId)
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
//            requestVo.setTaskId(taskId);
            String taskState = getOPTaskState(requestVo,taskId);
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


    /**
     * 手动触发检测
     * @param requestVo
     * @return
     */
    public String manualCheck(DomainCheckRequestVo requestVo) {
        //验证是否可以进行请求：避免同个站点不同账号同时触发
        if (domainCheckValidate(requestVo.getSiteId())) {
            LOG.info("已经有域名检测任务在运行中了");
            return MANUAL_CHECK_ERROR;
        }
        //进行http请求
        //gb生成reqTaskId
        String reqTaskId = UUID.randomUUID().toString().replace("-","");
        String domainCheckUrl = getDomainCheckUrl();
        if (StringTool.isBlank(domainCheckUrl)){
            LOG.error("未获取到域名检测地址参数OP_DOMAIN_CHECK_ADDR");
            return MANUAL_CHECK_ERROR;
        }
        String domainCheckCreateTaskUrl = domainCheckUrl + "/check_domain" + "?platform=gb&site_id=" + requestVo.getSiteId() + "&task_id=" + reqTaskId;
        //TODO 测试使用start 直接访问的是OP的生产地址，OP默认会把检测后的数据写入到生产库，所以测试时候加一个回调到对外的测试环境地址
//        String domainCheckCreateTaskUrl = domainCheckCreateTaskUrl + "?platform=gb&site_id=65" + "&task_id=" + reqTaskId;
//        domainCheckCreateTaskUrl = domainCheckCreateTaskUrl
// +"&callback=http://boss.ampinplayopt0matrix.com/boss-api/facade/domain/import.html";
        //TODO 测试使用end
        LOG.info("域名检测调用,请求地址：{0}", new Object[]{domainCheckCreateTaskUrl});
        HttpClientParam param = new HttpClientParam(domainCheckCreateTaskUrl);
        param.setMethod(HttpRequestMethod.GET);
        String result = HttpClientTool.sync(param);
        LOG.info("域名检测返回值内容：{0}", new Object[]{result});
        //{"error_code":"0/1","error":"only value at code=1","task_id":"sucess return","pedding":"wait for pedding"}
        //当task_id有值，则返回。否则提示错误信息
        JSONObject jsonObj = JSONObject.parseObject(result);
        if (YesNot.NOT.getCode().equals(jsonObj.getString("error_code")) && StringTool.isNotBlank(jsonObj.getString("task_id"))) {
            String taskId = jsonObj.getString("task_id");
            if (reqTaskId.equals(taskId)){//请求taskId和返回taskId一致
                //保存域名检测处理表
                saveBatchLog(requestVo.getSiteId(), taskId);
                return taskId;
            }
        }
        return MANUAL_CHECK_ERROR;
    }


    /**
     * 查询OP任务状态
     * @param requestVo
     * @return
     */
    private String getOPTaskState(DomainCheckRequestVo requestVo, String taskId) {

        //进行http请求
        String domainCheckUrl = getDomainCheckUrl();
        if (StringTool.isBlank(domainCheckUrl)){
            LOG.error("未获取到域名检测地址参数OP_DOMAIN_CHECK_ADDR");
            return "error";
        }
        String domainCheckUrlTaskState = domainCheckUrl + "/get_task_state" + "?platform=gb&site_id=" + requestVo.getSiteId() + "&task_id=" + taskId;
        //TODO 测试使用start
//        String domain_check_url = DOMAIN_CHECK_URL_TASK_STATE + "?platform=gb&site_id=65" + "&task_id=" + requestVo.getTaskId();
//        domain_check_url = domain_check_url+"&callback=http://boss.ampinplayopt0matrix.com/boss-api/facade/domain/import.html";
        //TODO 测试使用end
        LOG.info("域名检测状态调用,请求地址：{0}", new Object[]{domainCheckUrlTaskState});
        HttpClientParam param = new HttpClientParam(domainCheckUrlTaskState);
        param.setMethod(HttpRequestMethod.GET);
        String result = HttpClientTool.sync(param);
        LOG.info("域名检测状态返回值内容：{0}", new Object[]{result});
        //{"error_code":"0/1","error":"only value at code=1","task_id":"sucess return","pedding":"wait for pedding"}
        //当task_id有值，则返回。否则提示错误信息
        JSONObject jsonObj = JSONObject.parseObject(result);
        return jsonObj.getString("data");
    }

    /**
     * 有运行中的任务
     * @param siteId
     * @return
     */
    private boolean domainCheckValidate(Integer siteId) {
        DomainCheckResultBatchLogListVo batchLogVo = new DomainCheckResultBatchLogListVo();
        batchLogVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(DomainCheckResultBatchLog.PROP_SITE_ID, Operator.EQ, siteId),
                new Criterion(DomainCheckResultBatchLog.PROP_STATUS, Operator.EQ, Integer.parseInt(DomainCheckResultImportStatusEnum.PROCESS.getCode())),
        });
        DomainCheckResultBatchLogListVo search = ServiceTool.domainCheckResultBatchLogService().search(batchLogVo);
        if (search.getResult() != null && !CollectionTool.isEmpty(search.getResult())) {
            return true;
        }
        return false;
    }

    /**
     * 保存日志
     *
     * @param siteId
     * @param taskId
     */
    private void saveBatchLog(Integer siteId, String taskId) {
        DomainCheckResultBatchLogVo batchLogVo = new DomainCheckResultBatchLogVo();
        DomainCheckResultBatchLog batchLog = new DomainCheckResultBatchLog();
        batchLog.setCreateTime(new Date());
        batchLog.setTaskId(taskId);
        batchLog.setStatus(Integer.valueOf(DomainCheckResultImportStatusEnum.PROCESS.getCode()));
        batchLog.setSiteId(siteId);
        batchLog.setCheckPointCount(0);
        batchLogVo.setResult(batchLog);
        LOG.info("保存任务日志表batchLogVo bean:{0}", batchLogVo);
        ServiceTool.domainCheckResultBatchLogService().insert(batchLogVo);
    }

    /**
     * 获取OP域名检测地址
     * @return
     */
    public String getDomainCheckUrl(){
        SysParam sysParam = ParamTool.getSysParam(BossParamEnum.OP_DOMAIN_CHECK_ADDR);
        if (sysParam != null && StringTool.isNotBlank(sysParam.getParamValue())){
            return sysParam.getParamValue();
        }
        return "";
    }


    //endregion your codes 3

}