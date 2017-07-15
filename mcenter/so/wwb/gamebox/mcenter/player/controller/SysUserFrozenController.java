package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.bean.Pair;
import org.soul.commons.enums.YesNot;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.model.msg.notice.po.VNoticeSendText;
import org.soul.model.msg.notice.vo.NoticeLocaleTmpl;
import org.soul.model.msg.notice.vo.NoticeVo;
import org.soul.model.msg.notice.vo.VNoticeSendTextListVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.session.SessionManagerBase;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.player.IVSysUserPlayerFrozenService;
import so.wwb.gamebox.mcenter.player.form.VSysUserPlayerFrozenForm;
import so.wwb.gamebox.mcenter.player.form.VSysUserPlayerFrozenSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.common.Const;
import so.wwb.gamebox.model.common.notice.enums.ManualNoticeEvent;
import so.wwb.gamebox.model.listop.AccountBalance;
import so.wwb.gamebox.model.listop.FreezeTime;
import so.wwb.gamebox.model.listop.FreezeType;
import so.wwb.gamebox.model.master.enums.RemarkEnum;
import so.wwb.gamebox.model.master.player.po.Remark;
import so.wwb.gamebox.model.master.player.po.VSysUserPlayerFrozen;
import so.wwb.gamebox.model.master.player.vo.RemarkVo;
import so.wwb.gamebox.model.master.player.vo.VSysUserPlayerFrozenListVo;
import so.wwb.gamebox.model.master.player.vo.VSysUserPlayerFrozenVo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author: tom
 * @date: 15-6-30
 */
@Controller
@RequestMapping("/sysuser/frozen")
public class SysUserFrozenController extends BaseCrudController<IVSysUserPlayerFrozenService, VSysUserPlayerFrozenListVo, VSysUserPlayerFrozenVo, VSysUserPlayerFrozenSearchForm, VSysUserPlayerFrozenForm, VSysUserPlayerFrozen, Integer>{

    private static final Log LOG = LogFactory.getLog(SysUserFrozenController.class);

    // 永久冻结固定日期
    private final static Date foreverDate = Const.Platform_Forever_Date;

    @Override
    protected String getViewBasePath() {
        return "/player/frozen/";
    }

    private final static List<Pair> selectList = new ArrayList<>();

    /**
     * 冻结时间间隔固定
     */
    static{
        selectList.add(new Pair("-99","page.frozen.forever"));
        selectList.add(new Pair("72","page.frozen.st"));
        selectList.add(new Pair("24","page.frozen.tf"));
        selectList.add(new Pair("12","page.frozen.ot"));
        selectList.add(new Pair("6","page.frozen.six"));
        selectList.add(new Pair("3","page.frozen.three"));
    }

    /**
     * 手动冻结弹出框
     * 功能融合：账户冻结和余额冻结；包括账户和余额未冻结和已冻结不同状态展示
     * 冻结信息统一接口管理
     * @param userId　用户ID
     * @param flag  01:账号冻结;02:余额冻结
     * @param model
     * @return
     */
    @RequestMapping("/manualfrozen")
    public String frozenAccountOrBalance(Integer userId,String flag,Model model) {
        // 获取用户冻结信息
        VSysUserPlayerFrozenVo frozenEntityVo = getSysUserPlayerFrozen(userId);
        if (frozenEntityVo==null || frozenEntityVo.getResult()==null) {
            LOG.error("用户{0}不存在\n",userId);
            return "";
        }

        if (AccountBalance.ACCOUNT.getCode().equals(flag)){
            // 账号冻结
            frozeTime(flag, frozenEntityVo);
            model.addAttribute("controller","accountFrozen.html");
        } else {
            // 余额冻结
            frozeTime(flag, frozenEntityVo);
            model.addAttribute("controller","balanceFrozen.html");
        }
        // 获取最新发送通知信息
        VNoticeSendTextListVo listVo = new VNoticeSendTextListVo();
        listVo.getSearch().setReceiverGroupId(userId);
        listVo.getSearch().setEventType(AccountBalance.ACCOUNT.getCode().equals(flag)?ManualNoticeEvent.PLAYER_ACCOUNT_FREEZON.getCode():ManualNoticeEvent.BALANCE_FREEZON.getCode());
        listVo.getSearch().setLocale(SessionManager.getLocale().toString());
        VNoticeSendText send = ServiceTool.noticeService().fetchNoticeReason(listVo);
        model.addAttribute("send", send);
        // 获取发送模板
        NoticeVo noticeVo = new NoticeVo();
        noticeVo.setEventType(AccountBalance.ACCOUNT.getCode().equals(flag)?ManualNoticeEvent.PLAYER_ACCOUNT_FREEZON:ManualNoticeEvent.BALANCE_FREEZON);
        List<NoticeLocaleTmpl> noticeLocaleTmpls = ServiceTool.noticeService().fetchLocaleTmpls(noticeVo);
        model.addAttribute("noticeLocaleTmpls", noticeLocaleTmpls);

        model.addAttribute("frozenEntityVo",frozenEntityVo);
        model.addAttribute("flag",flag);
        model.addAttribute("selectList",selectList);
        /*if (Boolean.valueOf(true).equals(frozenEntityVo.getIsCheck())) {
            // 已冻结
            return getViewBasePath()+"FrozenAccount";
        } else {
            // 未冻结
            return getViewBasePath()+"FrozenAccount";
        }*/
        return getViewBasePath()+"FrozenAccount";
    }

    /**
     * 提交并预览
     * @param id
     * @param frozeTimeType
     * @param freezeCode
     * @param flag
     * @param model
     * @return
     */
    @RequestMapping("/preview")
    public String preview(Integer id,String frozeTimeType,String freezeCode,String flag,Model model) {
        VSysUserPlayerFrozenVo vSysUserPlayerFrozenVo = new VSysUserPlayerFrozenVo();
        vSysUserPlayerFrozenVo.getSearch().setId(id);
        vSysUserPlayerFrozenVo.getSearch().setLocale(SessionManager.getLocale().toString());
        vSysUserPlayerFrozenVo.getSearch().setCode(freezeCode);
        VSysUserPlayerFrozenVo sysUserPlayerFrozenVo = ServiceTool.sysUserPlayerFrozenService().previewPlayerFrozen(vSysUserPlayerFrozenVo);
        sysUserPlayerFrozenVo.setSysUser(SessionManager.getUser());
        sysUserPlayerFrozenVo.setFrozeTimeType(frozeTimeType);
        calFreezeEndTime(sysUserPlayerFrozenVo,flag);
        model.addAttribute("sysUserPlayerFrozenVo",sysUserPlayerFrozenVo);
        model.addAttribute("frozeTimeType",frozeTimeType);
        model.addAttribute("selectList",selectList);
        model.addAttribute("flag",flag);
        model.addAttribute("currentDate",new Date());
        return getViewBasePath()+"Preview";
    }

    /**
     * 编辑余额冻结
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping("/balanceFrozen")
    @ResponseBody
    public Map frozenBalance(VSysUserPlayerFrozenVo vo,Model model) {
        VSysUserPlayerFrozenVo sysUserPlayerFrozen = getSysUserPlayerFrozen(vo.getId());
        // 余额冻结不能修改
        if (foreverDate.equals(sysUserPlayerFrozen.getResult().getBalanceFreezeEndTime())
                ||FreezeType.AUTO.getCode().equals(sysUserPlayerFrozen.getResult().getBalanceType())) {
            vo.setSuccess(false);
            vo.setErrMsg(LocaleTool.tranMessage("common","operation.failed"));
            return getVoMessage(vo);
        }
        vo.setBalanceType(FreezeType.MANUAL.getCode());
        vo.setCreateUser(SessionManagerBase.getUserId());
        vo.setBalanceFreezeStartTime(new Date());
        calFreezeEndTime(vo,AccountBalance.BALANCE.getCode());
        vo = getService().saveUserPlayerBalanceFrozen(vo);
        if (vo.isSuccess()) {
            saveRemarkAndNotice(AccountBalance.ACCOUNT.getCode(),vo);
        }

        return getVoMessage(vo);
    }

    /**
     * 编辑账号冻结
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping("/accountFrozen")
    @ResponseBody
    public Map accountFrozen(VSysUserPlayerFrozenVo vo,Model model) {
        VSysUserPlayerFrozenVo sysUserPlayerFrozenVo = getSysUserPlayerFrozen(vo.getId());
        // 账户冻结不能修改
        if (foreverDate.equals(sysUserPlayerFrozenVo.getResult().getFreezeEndTime())
                ||FreezeType.AUTO.getCode().equals(sysUserPlayerFrozenVo.getResult().getFreezeType())) {
            vo.setSuccess(false);
            vo.setErrMsg(LocaleTool.tranMessage("common","operation.failed"));
            return getVoMessage(vo);
        }
        vo.setFreezeType(FreezeType.MANUAL.getCode());
        vo.setCreateUser(SessionManagerBase.getUserId());
        vo.setFreezeStartTime(new Date());
        calFreezeEndTime(vo,AccountBalance.ACCOUNT.getCode());
        vo = getService().saveUserPlayerAccountFrozen(vo);

        if (vo.isSuccess()) {
            saveRemarkAndNotice(AccountBalance.ACCOUNT.getCode(),vo);
        }
        return getVoMessage(vo);
    }

    private void calFreezeEndTime(VSysUserPlayerFrozenVo vo,String flag) {
        if (FreezeTime.FORERVE.getCode().equals(vo.getFrozeTimeType())) {
            if (AccountBalance.ACCOUNT.getCode().equals(flag)) {
                vo.setFreezeEndTime(foreverDate);
            } else {
                vo.setBalanceFreezeEndTime(foreverDate);
            }
        } else {
            if (AccountBalance.ACCOUNT.getCode().equals(flag)) {
                vo.setFreezeEndTime(DateTool.addHours(new Date(), Integer.parseInt(vo.getFrozeTimeType())));
            } else {
                vo.setBalanceFreezeEndTime(DateTool.addHours(new Date(), Integer.parseInt(vo.getFrozeTimeType())));
            }

        }
    }


    /**
     * 冻结下拉框选中值及是否禁用
     * @param flag 标识账号冻结，余额冻结
     * @param vo
     */
    private void frozeTime(String flag , VSysUserPlayerFrozenVo vo) {
        Date startTime = null;
        Date endTime = null;
        if (AccountBalance.ACCOUNT.getCode().equals(flag)) {
            startTime = vo.getResult().getFreezeStartTime();
            endTime = vo.getResult().getFreezeEndTime();
        } else {
            startTime = vo.getResult().getBalanceFreezeStartTime();
            endTime = vo.getResult().getBalanceFreezeEndTime();
        }
        Long hours = DateTool.hoursBetween(endTime,startTime);
        String frozeTime = "";

        if (hours.intValue()>0) {
            switch (hours.intValue()) {
                case 3:
                    frozeTime = FreezeTime.THREE.getCode();
                    break;
                case 6:
                    frozeTime = FreezeTime.SIX.getCode();
                    break;
                case 12:
                    frozeTime = FreezeTime.OT.getCode();
                    break;
                case 24:
                    frozeTime = FreezeTime.TF.getCode();
                    break;
                case 72:
                    frozeTime = FreezeTime.ST.getCode();
                    break;
                default:
                    frozeTime = FreezeTime.FORERVE.getCode();
            }
        }
        vo.setFrozeTime(frozeTime);
        // 是否启用
        if (endTime !=null && endTime.compareTo(new Date())>=0 && startTime.compareTo(new Date())<=0) {
            vo.setIsCheck(true);
        }
        // 自动冻结或永久冻结　功能禁用
        if (foreverDate.equals(endTime)||FreezeType.AUTO.getCode().equals(vo.getResult().getFreezeType())) {
            vo.setDisabled(YesNot.YES.getCode());
            vo.setIsCheck(true);
        } else {
            vo.setDisabled(YesNot.NOT.getCode());
        }
    }

    /**
     * 查询用户冻结信息
     * @param userId
     * @return
     */
    private VSysUserPlayerFrozenVo getSysUserPlayerFrozen(Integer userId) {
        VSysUserPlayerFrozenVo vo = new VSysUserPlayerFrozenVo();
        vo.getSearch().setId(userId);
        return ServiceTool.sysUserPlayerFrozenService().getSysUserPlayerFrozen(vo);
    }


    private void saveRemarkAndNotice(String flag, VSysUserPlayerFrozenVo vSysUserPlayerFrozenVo) {
        String remark = vSysUserPlayerFrozenVo.getRemarks();
        RemarkEnum remarkEnum =  AccountBalance.ACCOUNT.getCode().equals(flag)?RemarkEnum.PLAYER_USER_FREEZE:RemarkEnum.PLAYER_BALANCE_FREEZE;
        //保存备注
        if (StringTool.isNotEmpty(remark)) {
            RemarkVo vo = new RemarkVo();
            Remark remarkEntity = new Remark();
            remarkEntity.setRemarkTime(new Date());
            remarkEntity.setRemarkType(remarkEnum.getType());
            remarkEntity.setModel(remarkEnum.getModel());
            remarkEntity.setOperatorId(SessionManager.getUserId());
            remarkEntity.setOperator(SessionManager.getUserName());
            remarkEntity.setRemarkTitle(SessionManager.getUser().getUsername() + "对玩家" + vSysUserPlayerFrozenVo.getUsername() + "进行账号停用");
            vo.setResult(remarkEntity);
            ServiceTool.getRemarkService().insert(vo);
        }
        //发送信息
        NoticeVo noticeVo = NoticeVo.manualNotify(vSysUserPlayerFrozenVo.getGroupCode(), null, vSysUserPlayerFrozenVo.getId());
        noticeVo.setRemarks(remark);
        try{
            ServiceTool.noticeService().publish(noticeVo);
        }catch (Exception ex){
            LogFactory.getLog(this.getClass()).error(ex,"发布消息不成功");
        }
        //保存日志 TODO
    }

}
