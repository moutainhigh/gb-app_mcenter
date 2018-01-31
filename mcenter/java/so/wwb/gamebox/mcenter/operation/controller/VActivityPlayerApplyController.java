package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleDateTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.commons.support._Module;
import org.soul.model.msg.notice.vo.NoticeLocaleTmpl;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.model.security.privilege.po.SysUser;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceActivityTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.operation.IVActivityPlayerApplyService;
import so.wwb.gamebox.mcenter.operation.form.VActivityPlayerApplyForm;
import so.wwb.gamebox.mcenter.operation.form.VActivityPlayerApplySearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.common.notice.enums.AutoNoticeEvent;
import so.wwb.gamebox.model.common.notice.enums.ManualNoticeEvent;
import so.wwb.gamebox.model.master.enums.*;
import so.wwb.gamebox.model.master.operation.po.*;
import so.wwb.gamebox.model.master.operation.vo.*;
import so.wwb.gamebox.model.master.player.po.Remark;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 活动申请玩家表控制器
 *
 * @author orange
 * @time 2015-10-12 10:45:02
 */
@Controller
@RequestMapping("/operation/vActivityPlayerApply")
public class VActivityPlayerApplyController extends BaseCrudController<IVActivityPlayerApplyService,
        VActivityPlayerApplyListVo, VActivityPlayerApplyVo, VActivityPlayerApplySearchForm,
        VActivityPlayerApplyForm, VActivityPlayerApply, Integer> {

    private static final Log LOG = LogFactory.getLog(VActivityPlayerApplyController.class);
    private static final String PROP_ACTIVITY_INDEX = "/operation/activity/activityPlayerApply/Index";
    private static final String PROP_ACTIVITY_SUCCESS_DIALOG = "/operation/activity/activityPlayerApply/SuccessDialog";
    private static final String PROP_ACTIVITY_FAIL_DIALOG = "/operation/activity/activityPlayerApply/FailDialog";

    @Override
    protected String getViewBasePath() {
        return "/operation/activity/activityPlayerApply";
    }

    /**
     * 审核列表
     *
     * @param listVo
     * @param model
     * @return
     */
    @RequestMapping("/activityPlayerApply")
    public String activityPlayerApply(VActivityMessageVo vMessageVo, VActivityPlayerApplyListVo listVo,
                                      Model model, HttpServletRequest request) {
        ActivityMessageVo messageVo = new ActivityMessageVo();
        messageVo.getSearch().setId(vMessageVo.getSearch().getId());
        messageVo = ServiceActivityTool.activityMessageService().get(messageVo);
        listVo.getSearch().setActivityTypeCode(messageVo.getResult().getActivityTypeCode());
        listVo.getSearch().setActivityMessageId(vMessageVo.getSearch().getId());
        listVo = ServiceActivityTool.vActivityPlayerApplyService().search(listVo);
        if (listVo.getResult() == null) {
            return null;
        }
        model.addAttribute("command", listVo);

        vMessageVo.getSearch().setActivityVersion(SessionManager.getLocale().toString());
        List<VActivityMessage> messageList = ServiceActivityTool.vActivityMessageService().searchActivityMessage(vMessageVo);
        model.addAttribute("command1", messageList);

        //activity_way_relation活动优惠方式关系表--查询优惠形式
        ActivityWayRelationVo activityWayRelationVo = new ActivityWayRelationVo();
        activityWayRelationVo.getSearch().setActivityMessageId(vMessageVo.getSearch().getId());
        List<ActivityWayRelation> activityWayRelationList = ServiceActivityTool.activityWayRelationService()
                .searchActivityWayRelation(activityWayRelationVo);
        ActivityWayRelation activityWayRelation = null;
        if (activityWayRelationList != null && activityWayRelationList.size() > 0) {//此处是基于现在有的需求，只会出现固定彩金和比例彩金
            activityWayRelation = activityWayRelationList.get(0);
            model.addAttribute("activityWayRelation", activityWayRelation);
        }else{
            if(ActivityTypeEnum.MONEY.getCode().equals(messageVo.getResult().getActivityTypeCode())){
                activityWayRelation = new ActivityWayRelation();
                activityWayRelation.setPreferentialForm(ActivityPreferentialFormEnum.REGULAR_HANDSEL.getCode());
                model.addAttribute("activityWayRelation", activityWayRelation);
            }
        }

        //查询activityPlayerPreferential玩家优惠信息表--优惠形式
        List<Integer> activityPlayerApplyIds = CollectionTool.extractToList(listVo.getResult(), ActivityPlayerApply.PROP_ID);
        ActivityPlayerPreferentialVo activityPlayerPreferentialVo = new ActivityPlayerPreferentialVo();
        activityPlayerPreferentialVo.getSearch().setActivityPlayerApplyIds(activityPlayerApplyIds);
        List<ActivityPlayerPreferential> activityPlayerPreferentialList = ServiceActivityTool.activityPlayerPreferentialService()
                .searchActivityPlayerPreferentialByIds(activityPlayerPreferentialVo);
        Map<Object, ActivityPlayerPreferential> vactivityPlayerApplyMap = CollectionTool.toEntityMap(
                activityPlayerPreferentialList, ActivityPlayerPreferential.PROP_ACTIVITY_PLAYER_APPLY_ID);

        for (VActivityPlayerApply vActivityPlayerApply : listVo.getResult()) {
            ActivityPlayerPreferential activityPlayerPreferential = vactivityPlayerApplyMap.get(vActivityPlayerApply.getId());
            if (activityPlayerPreferential != null) {
                vActivityPlayerApply.setPreferentialValue(activityPlayerPreferential.getPreferentialValue());
            } else {
                vActivityPlayerApply.setPreferentialValue(0.0d);
            }
        }
        model.addAttribute("vActivityPlayerApplyListVo", listVo);
        Map<String, Serializable> stringSerializableMap = DictTool.get(DictEnum.ACTIVITY_APPLY_CHECK_STATUS);
        stringSerializableMap.remove("4");
        model.addAttribute("checkStatus",stringSerializableMap);
        if (ServletTool.isAjaxSoulRequest(request)) {
            return PROP_ACTIVITY_INDEX + "Partial";
        } else {
            return PROP_ACTIVITY_INDEX;
        }
    }

    /**
     * 审核成功弹窗
     *
     * @param ids
     * @return
     */
    @RequestMapping("/successDialog")
    public String successDialog(VActivityMessageListVo vMessageListVo, String ids, String code, String sumPerson, Model model) {
        String[] id = ids.split(",");
        ActivityPlayerApplyListVo plistVo = new ActivityPlayerApplyListVo();
        plistVo.getSearch().setId(Integer.valueOf(id[0]));
        plistVo = ServiceActivityTool.activityPlayerApplyService().search(plistVo);
        vMessageListVo.getSearch().setId(plistVo.getResult().get(0).getActivityMessageId());
        vMessageListVo.getSearch().setActivityVersion(SessionManager.getLocale().toString());
        vMessageListVo = ServiceActivityTool.vActivityMessageService().search(vMessageListVo);
        Double total = Double.valueOf(0);
        for (String ActivityPlayerApplyId : id) {
            ActivityPlayerPreferentialListVo plistVo2 = new ActivityPlayerPreferentialListVo();
            plistVo2.getSearch().setActivityPlayerApplyId(Integer.valueOf(ActivityPlayerApplyId));
            plistVo2 = ServiceActivityTool.activityPlayerPreferentialService().search(plistVo2);
            for (ActivityPlayerPreferential obj : plistVo2.getResult()) {
                if (ActivityPreferentialFormEnum.REGULAR_HANDSEL.getCode().equals(obj.getPreferentialForm())
                        || ActivityPreferentialFormEnum.PERCENTAGE_HANDSEL.getCode().equals(obj.getPreferentialForm())) {
                    if (obj.getPreferentialValue() != null) {
                        total += obj.getPreferentialValue();
                    }
                }
            }
        }

        model.addAttribute("ids", ids);
        model.addAttribute("code", code);
        model.addAttribute("command", vMessageListVo.getResult().get(0));
        model.addAttribute("total", total);
        model.addAttribute("length", id.length);
        model.addAttribute("sumPerson", Integer.valueOf(sumPerson));

        return PROP_ACTIVITY_SUCCESS_DIALOG;
    }

    /**
     * 审核失败弹窗
     *
     * @param ids
     * @return
     */
    @RequestMapping("/failDialog")
    public String failDialog(VActivityPlayerApplyVo vo, String ids, Model model) {
        //查询失败原因模板
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.PREFERENCE_AUDIT_FAIL);
        List<NoticeLocaleTmpl> failReasons = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);

        model.addAttribute("failReasons", failReasons);
        model.addAttribute("ids", ids);
        model.addAttribute("command", vo);
        return PROP_ACTIVITY_FAIL_DIALOG;
    }

    @RequestMapping("/hasReason")
    @ResponseBody
    public Map hasReason(VActivityPlayerApplyVo vo) {
        Map result = new HashMap();
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(ManualNoticeEvent.PREFERENCE_AUDIT_FAIL);
        List<NoticeLocaleTmpl> failReasons = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);
        if (failReasons != null && failReasons.size() > 0) {
            result.put("state", true);
        } else {
            result.put("state", false);
        }
        return result;
    }

    /**
     * 审核成功和审核失败
     *
     * @param vo
     * @param ids
     * @return
     */
    @RequestMapping("/auditStatus")
    @ResponseBody
    public Map auditStatus(ActivityPlayerApplyVo vo, String ids, String activityType) {
        HashMap map = new HashMap(2,1f);
        if (ids == null || "".equals(ids)) {
            map.put("state", false);
            return map;
        }

        vo.getResult().setCheckTime(SessionManager.getDate().getNow());
        vo.getResult().setCheckUserId(SessionManager.getUserId());

        String paramValue = ParamTool.getSysParam(SiteParamEnum.SETTING_SYSTEM_SETTINGS_DISCOUNT).getParamValue();
        String[] id = ids.split(",");
        for (String activityPlayerApplyId : id) {
            //活动玩家申请表
            ActivityPlayerApplyVo activityPlayerApplyVo = new ActivityPlayerApplyVo();
            activityPlayerApplyVo.getSearch().setId(Integer.valueOf(activityPlayerApplyId));
            activityPlayerApplyVo = ServiceActivityTool.activityPlayerApplyService().get(activityPlayerApplyVo);

            //获取活动名称
            ActivityMessageI18nVo activityMessageI18nVo = new ActivityMessageI18nVo();
            activityMessageI18nVo.getSearch().setActivityVersion(SessionManager.getLocale().toString());
            activityMessageI18nVo.getSearch().setActivityMessageId(activityPlayerApplyVo.getResult().getActivityMessageId());
            activityMessageI18nVo = ServiceActivityTool.activityMessageI18nService().search(activityMessageI18nVo);
            //获取用户的默认时区
            SysUserVo sysUserVo = new SysUserVo();
            sysUserVo.setResult(new SysUser());
            sysUserVo.getSearch().setId(activityPlayerApplyVo.getResult().getUserId());
            sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
            String times = LocaleDateTool.formatDate(activityPlayerApplyVo.getResult().getApplyTime(),
                    CommonContext.getDateFormat().getDAY_SECOND(), sysUserVo.getResult().getDefaultTimezone());
            activityPlayerApplyVo.setTime(times);
            activityPlayerApplyVo.setActivityName(activityMessageI18nVo.getResult().getActivityName());

            if (StringTool.isNotBlank(vo.getResult().getRemark())) {
                activityPlayerApplyVo.setRemark(addRemark(vo.getResult().getRemark(),activityPlayerApplyId,
                        activityPlayerApplyVo.getResult().getUserId()));
            }

            vo = ServiceActivityTool.activityPlayerApplyService().auditStatus(vo, activityPlayerApplyVo, activityType, paramValue);

            if (vo.isSuccess()) {
                NoticeVo noticeVo = new NoticeVo();
                if (vo.getResult().getCheckState().equals(ActivityStateEnum.SUCCESS.getCode())) {//审核成功
                    //发送站内信模板内容
                    noticeVo = NoticeVo.autoNotify(AutoNoticeEvent.PREFERENCE_AUDIT_SUCCESS,
                            activityPlayerApplyVo.getResult().getUserId());
                    noticeVo.addParams(new Pair[]
                            {
                                    new Pair<>("time", times),
                                    new Pair<>("name", activityMessageI18nVo.getResult().getActivityName()),
                            }
                    );
                    try {
                        ServiceTool.noticeService().publish(noticeVo);
                    } catch (Exception ex) {
                        LOG.error(ex, "发布消息不成功");
                    }
                }
                if (vo.getResult().getCheckState().equals(ActivityStateEnum.FAIL.getCode())) {//审核失败
                    //发送站内信模板内容
                    noticeVo = NoticeVo.manualNotify(vo.getGroupCode(), null, activityPlayerApplyVo.getResult().getUserId());
                    noticeVo.addParams(new Pair[]
                            {
                                    new Pair<>("time", times),
                                    new Pair<>("activityName", activityMessageI18nVo.getResult().getActivityName()),
                            }
                    );
                    try {
                        if (StringTool.isNotBlank(vo.getGroupCode())) {
                            ServiceTool.noticeService().publish(noticeVo);
                        }
                    } catch (Exception ex) {
                        LOG.error(ex, "发布消息不成功");
                    }
                }

            }

        }

        if (vo.isSuccess()) {
            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "check.success"));
        } else {
            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "check.failed"));
        }

        map.put("msg", StringTool.isNotBlank(vo.getOkMsg()) ? vo.getOkMsg() : vo.getErrMsg());
        map.put("state", vo.isSuccess());
        return map;
    }

    /**
     * 添加备注
     *
     * @param remarkContent
     * @param activityPlayerApplyId
     * @return
     */
    private Remark addRemark(String remarkContent,String activityPlayerApplyId,Integer userId) {
        Remark remark = new Remark();
        remark.setEntityUserId(userId);
        remark.setRemarkTime(SessionManager.getDate().getNow());
        remark.setEntityId(Integer.valueOf(activityPlayerApplyId));
        remark.setModel(RemarkEnum.OPERATION_ACTIVITY.getModel());
        remark.setRemarkType(RemarkEnum.OPERATION_ACTIVITY.getType());
        remark.setOperatorId(SessionManager.getUserId());
        remark.setOperator(SessionManager.getAuditUserName());
        remark.setRemarkContent(remarkContent);
        return remark;
    }

    //TODO eagle
    @RequestMapping("/auditStatus2")
    @ResponseBody
    public Map auditStatus2(ActivityPlayerApplyVo vo, String ids, String activityType) {

        if (ids == null || "".equals(ids)) {
            return null;
        }

        //1.先更新状态
        vo.getSearch().setIds(convertIdToInteger(ids));
        vo.getSearch().setCheckState(ActivityApplyCheckStatusEnum.PENDING.getCode());
        List<ActivityPlayerApply> activityPlayerApplyList = ServiceActivityTool.activityPlayerApplyService().searchActivityPlayerByIds(vo);
        for (ActivityPlayerApply activityPlayerApply : activityPlayerApplyList) {
            activityPlayerApply.setCheckTime(SessionManager.getDate().getNow());
            activityPlayerApply.setCheckUserId(SessionManager.getUserId());
        }


        //2.发送通知


//        String paramValue = ParamTool.getSysParam(SiteParamEnum.SETTING_SYSTEM_SETTINGS_DISCOUNT).getParamValue();
//        for (String activityPlayerApplyId : id) {
//            //活动玩家申请表
//            ActivityPlayerApplyVo activityPlayerApplyVo = new ActivityPlayerApplyVo();
//            activityPlayerApplyVo.getSearch().setId(Integer.valueOf(activityPlayerApplyId));
//            activityPlayerApplyVo = ServiceSiteTool.activityPlayerApplyService().get(activityPlayerApplyVo);
//
//            vo = ServiceSiteTool.activityPlayerApplyService().auditStatus(vo, activityPlayerApplyVo, activityType, paramValue);
//
//            if (vo.isSuccess()==true && vo.getResult().getCheckState().equals(ActivityStateEnum.SUCCESS.getCode())) {//审核成功
//                //发送站内信模板内容
//                NoticeVo noticeVo = NoticeVo.autoNotify(AutoNoticeEvent.PREFERENCE_AUDIT_SUCCESS, activityPlayerApplyVo.getResult().getUserId());
//                noticeVo.addParams(new Pair("优惠活动审批成功", activityPlayerApplyVo.getResult().getUserName()));
//                ServiceTool.noticeService().publish(noticeVo);
//            }
//            if (vo.isSuccess()==true && vo.getResult().getCheckState().equals(ActivityStateEnum.FAIL.getCode())) {//审核失败
//                //发送站内信模板内容
//                NoticeVo noticeVo = NoticeVo.manualNotify(vo.getGroupCode(), null, vo.getResult().getUserId());
//                noticeVo.addParams(new Pair("优惠活动审批失败", activityPlayerApplyVo.getResult().getUserName()));
//                ServiceTool.noticeService().publish(noticeVo);
//            }
//        }
//
//        if (vo.isSuccess()) {
//            vo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "check.success"));
//        } else {
//            vo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "check.failed"));
//        }
        HashMap map = new HashMap(2,1f);
//        map.put("msg", StringTool.isNotBlank(vo.getOkMsg()) ? vo.getOkMsg() : vo.getErrMsg());
//        map.put("state", Boolean.valueOf(vo.isSuccess()));
        return map;
    }

    /**
     * 字符串id转为整型
     *
     * @param ids
     * @return
     */
    private List<Integer> convertIdToInteger(String ids) {
        String[] idarray = StringTool.split(ids, ",");
        List<Integer> rids = new ArrayList<>();
        for (int i = 0; i < idarray.length; i++) {
            Integer temp = Integer.parseInt(idarray[i]);
            rids.add(temp);
        }
        return rids;
    }


}