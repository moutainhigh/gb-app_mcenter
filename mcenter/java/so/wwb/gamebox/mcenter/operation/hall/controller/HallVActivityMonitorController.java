package so.wwb.gamebox.mcenter.operation.hall.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.string.I18nTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.query.sort.Direction;
import org.soul.model.sys.po.SysDict;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceActivityTool;
import so.wwb.gamebox.iservice.master.operation.IVActivityMonitorService;
import so.wwb.gamebox.mcenter.operation.form.VActivityMonitorForm;
import so.wwb.gamebox.mcenter.operation.form.VActivityMonitorSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.TerminalEnum;
import so.wwb.gamebox.model.master.enums.ActivityApplyCheckStatusEnum;
import so.wwb.gamebox.model.master.enums.ActivityTypeEnum;
import so.wwb.gamebox.model.master.fund.enums.TransactionWayEnum;
import so.wwb.gamebox.model.master.operation.po.VActivityMonitor;
import so.wwb.gamebox.model.master.operation.po.VActivityMonitorDetail;
import so.wwb.gamebox.model.master.operation.vo.VActivityMonitorDetailVo;
import so.wwb.gamebox.model.master.operation.vo.VActivityMonitorListVo;
import so.wwb.gamebox.model.master.operation.vo.VActivityMonitorVo;
import so.wwb.gamebox.web.SessionManagerCommon;

import java.text.MessageFormat;
import java.util.Map;


/**
 * 活动效果监控视图控制器
 *
 * @author steffan
 * @time 2018-3-18 11:13:42
 */
@Controller
//region your codes 1
@RequestMapping("/activityHall/vActivityMonitor")
public class HallVActivityMonitorController extends BaseCrudController<IVActivityMonitorService, VActivityMonitorListVo, VActivityMonitorVo, VActivityMonitorSearchForm, VActivityMonitorForm, VActivityMonitor, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/activityHall/monitor/";
        //endregion your codes 2
    }

    //region your codes 3
    Log LOG = LogFactory.getLog(HallVActivityMonitorController.class);

    @Override
    protected VActivityMonitorListVo doList(VActivityMonitorListVo listVo, VActivityMonitorSearchForm form, BindingResult result, Model model) {

        HallVActivityMessageHallController.setActivitySelectBtnDicts(model);
        listVo.getSearch().setActivityVersion(SessionManager.getLocale().toString());
        listVo.getSearch().setActivityTerminalType(TerminalEnum.PC.getCode());

        //状态列表

        //审核状态字典
        Map<String, SysDict> checkStatusDicts = DictTool.get(DictEnum.ACTIVITY_APPLY_CHECK_STATUS);
        model.addAttribute("checkStatusDicts", checkStatusDicts);
        listVo.getQuery().addOrder(VActivityMonitor.PROP_CHECK_STATE, Direction.ASC).addOrder(VActivityMonitor.PROP_APPLY_TIME, Direction.DESC);
        return super.doList(listVo, form, result, model);
    }

    /**
     * 查看活动监控详情
     *
     * @param vo
     * @return
     */
    @RequestMapping("/showMonitorDetail")
    @ResponseBody
    public Map showMonitorDetail(VActivityMonitorDetailVo vo) {
        vo = ServiceActivityTool.vActivityMonitorDetailService().get(vo);
        VActivityMonitorDetail result = vo.getResult();
        Map voMessage = getVoMessage(vo);
        String activityType = vo.getResult().getActivityTypeCode();
        String msg = I18nTool.getI18nMap(SessionManagerCommon.getLocale().toString()).get("views").get("operation").get("monitor_detail_" + activityType);

        Map<String, String> operationMsg = I18nTool.getI18nMap(SessionManagerCommon.getLocale().toString()).get("views").get("operation");

        //返回字符串转换;
        //状态
        String checkState = "";
        if (ActivityApplyCheckStatusEnum.PENDING.getCode().equals(result.getCheckState())) {
            checkState = operationMsg.get("待处理");
        } else if (ActivityApplyCheckStatusEnum.SUCCESS.getCode().equals(result.getCheckState())) {
            checkState = operationMsg.get("已通过");
        } else if (ActivityApplyCheckStatusEnum.FAIL.getCode().equals(result.getCheckState())) {
            checkState = operationMsg.get("已拒绝");
        }


        if (activityType.contains("deposit")) {
            //存款类型
            String rechargeType = "";
            if (TransactionWayEnum.MANUAL_DEPOSIT.getCode().equals(result.getRechargeType())) {
                rechargeType = operationMsg.get("Activity.step.depositWay.manual_deposit");
            } else {
                rechargeType = I18nTool.getDictMapByEnum(SessionManager.getLocale(), DictEnum.COMMON_FUND_TYPE).get(result.getRechargeType());
            }

            msg = MessageFormat.format(msg,
                    result.getRechargeAmount(),//金额
                    result.getTransactionNo(),
                    rechargeType,//存款类型
                    LocaleDateTool.formatDate(result.getCheckTime(), LocaleDateTool.getFormat("DAY_SECOND"), SessionManagerCommon.getTimeZone()), "",
                    LocaleDateTool.formatDate(result.getApplyTime(), LocaleDateTool.getFormat("DAY_SECOND"), SessionManagerCommon.getTimeZone()),
                    result.getApplyTransactionNo(),
                    result.getPreferentialValue(),//金额
                    checkState);//状态
            voMessage.put("msg", msg);
            return voMessage;
        }

        //优惠数据详情的json
        JSONObject preferentialDataJson = null;
        try {
            preferentialDataJson = JSON.parseObject(result.getPreferentialData());
        } catch (Exception e) {
            LOG.error(e, "解析数据异常,不是json格式:{0}", result.getPreferentialData());
            voMessage.put("msg", "data");
            return voMessage;
        }
        //注册送
        if (ActivityTypeEnum.REGIST_SEND.getCode().equals(activityType)) {
            msg = MessageFormat.format(msg,
                    LocaleDateTool.formatDate(result.getRegisterTime(), LocaleDateTool.getFormat("DAY_SECOND"), SessionManagerCommon.getTimeZone()), //注册时间
                    LocaleDateTool.formatDate(result.getApplyTime(), LocaleDateTool.getFormat("DAY_SECOND"), SessionManagerCommon.getTimeZone()), //申请时间
                    StringTool.isBlank(preferentialDataJson.getString("bankCard")) ? operationMsg.get("null") : preferentialDataJson.getString("bankCard"),//卡号
                    StringTool.isBlank(preferentialDataJson.getString("realName")) ? operationMsg.get("null") : preferentialDataJson.getString("realName"),//名
                    StringTool.isBlank(preferentialDataJson.getString("registerIp")) ? operationMsg.get("null") : preferentialDataJson.getString("registerIp"),//ip
                    result.getPreferentialValue(),//金额
                    result.getApplyTransactionNo(),//单号
                    checkState);//状态
        }
        //有效投注额
        else if (ActivityTypeEnum.EFFECTIVE_TRANSACTION.getCode().equals(activityType)) {
            msg = MessageFormat.format(msg,
                    result.getStartTime(),
                    result.getEndTime(),
                    StringTool.isBlank(preferentialDataJson.getString("effective")) ? operationMsg.get("null") : preferentialDataJson.getString("effective"),//投注总金额
                    result.getApplyTime(),
                    checkState
                    );
        } else if (ActivityTypeEnum.PROFIT.getCode().equals(activityType)) {
            msg = MessageFormat.format(msg, result.getRechargeAmount(), result.getTransactionNo(), result.getRechargeType(), result.getCheckState(), ""
                    , result.getApplyTime(), result.getApplyTransactionNo(), result.getPreferentialValue(), result.getCheckState());
        } else if (ActivityTypeEnum.RELIEF_FUND.getCode().equals(activityType)) {
            msg = MessageFormat.format(msg, result.getRechargeAmount(), result.getTransactionNo(), result.getRechargeType(), result.getCheckState(), ""
                    , result.getApplyTime(), result.getApplyTransactionNo(), result.getPreferentialValue(), result.getCheckState());
        } else if (ActivityTypeEnum.MONEY.getCode().equals(activityType)) {
            msg = MessageFormat.format(msg, result.getRechargeAmount(), result.getTransactionNo(), result.getRechargeType(), result.getCheckState(), ""
                    , result.getApplyTime(), result.getApplyTransactionNo(), result.getPreferentialValue(), result.getCheckState());
        }
        voMessage.put("msg", msg);
        return voMessage;
    }


    //endregion your codes 3

}