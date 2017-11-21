package so.wwb.gamebox.mcenter.operation.controller;

import org.soul.commons.collections.MapTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.LogFactory;
import org.soul.model.security.privilege.po.SysUser;
import org.soul.model.security.privilege.po.SysUserStatus;
import org.soul.model.security.privilege.vo.SysUserListVo;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.validation.form.annotation.FormModel;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.operation.IActivityMoneyDefaultWinService;
import so.wwb.gamebox.mcenter.operation.form.ActivityMoneyDefaultWinForm;
import so.wwb.gamebox.mcenter.operation.form.ActivityMoneyDefaultWinSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.SubSysCodeEnum;
import so.wwb.gamebox.model.master.operation.po.ActivityMoneyAwardsRules;
import so.wwb.gamebox.model.master.operation.po.ActivityMoneyDefaultWin;
import so.wwb.gamebox.model.master.operation.vo.ActivityMoneyAwardsRulesVo;
import so.wwb.gamebox.model.master.operation.vo.ActivityMoneyDefaultWinListVo;
import so.wwb.gamebox.model.master.operation.vo.ActivityMoneyDefaultWinVo;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;

import javax.validation.Valid;
import java.text.MessageFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 红包内定表控制器
 *
 * @author Administrator
 * @time 2017-3-29 9:08:44
 */
@Controller
//region your codes 1
@RequestMapping("/activityMoneyDefaultWin")
public class ActivityMoneyDefaultWinController extends BaseCrudController<IActivityMoneyDefaultWinService, ActivityMoneyDefaultWinListVo, ActivityMoneyDefaultWinVo, ActivityMoneyDefaultWinSearchForm, ActivityMoneyDefaultWinForm, ActivityMoneyDefaultWin, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/operation/";
        //endregion your codes 2
    }

    //region your codes 3
    @Override
    @Token(valid = true)
    public Map persist(ActivityMoneyDefaultWinVo objectVo, @FormModel("result") @Valid ActivityMoneyDefaultWinForm form, BindingResult result) {
        Map resultMap = new HashMap();
        try{
            resultMap = super.persist(objectVo, form, result);
            if(!MapTool.getBoolean(resultMap,"state")){
                resultMap.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
            }
        }catch (Exception ex){
            resultMap.put("state",false);
            resultMap.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
            LogFactory.getLog(this.getClass()).error(ex,"设置内定玩家出错");
        }


        return resultMap;
    }

    @Override
    protected ActivityMoneyDefaultWinVo doPersist(ActivityMoneyDefaultWinVo objectVo) {
        return super.doPersist(objectVo);
    }

    @Override
    protected ActivityMoneyDefaultWinVo doSave(ActivityMoneyDefaultWinVo objectVo) {

        try{
            if(StringTool.isBlank(objectVo.getUsernames())){
                objectVo.setSuccess(false);
                objectVo.setErrMsg(LocaleTool.tranMessage("operation_auto","内定玩家账号为空"));
                return objectVo;
            }
            if(objectVo.getResult().getActivityMessageId()==null){
                objectVo.setSuccess(false);
                objectVo.setErrMsg(LocaleTool.tranMessage("operation_auto","红包活动ID为空"));
                return objectVo;
            }
            String[] usernameArr = objectVo.getUsernames().split(",");
            String noExistName = "";
            for(int i=0;i<usernameArr.length;i++){
                if(StringTool.isNotBlank(usernameArr[i])){
                    boolean existUsername = isExistUsername(usernameArr[i]);
                    if(!existUsername){
                        noExistName += usernameArr[i]+",";
                    }
                }
            }
            if(noExistName.length()>0){
                noExistName = noExistName.substring(0,noExistName.length()-1);
                objectVo.setSuccess(false);
                objectVo.setErrMsg(MessageFormat.format(LocaleTool.tranMessage("operation_auto","不存在玩家账号")+"{0}",noExistName));
                return objectVo;
            }

            objectVo.getResult().setOperateId(SessionManager.getUserId());
            objectVo.getResult().setOperateUsername(SessionManager.getUserName());
            objectVo.getResult().setOperateTime(new Date());
            objectVo.getResult().setStatus(ActivityMoneyDefaultWin.STATUS_NORMAL);
            objectVo = getService().saveActivityMoneyDefaultWinPlayer(objectVo);
        }catch (Exception ex){
            objectVo.setSuccess(false);
            objectVo.setErrMsg(LocaleTool.tranMessage("operation_auto","设置内定玩家出错")+ex.getMessage());
            LogFactory.getLog(this.getClass()).error(ex,"设置内定玩家出错：{0}",ex.getMessage());
        }

        return objectVo;
    }

    private boolean isExistUsername(String username){
        SysUser sysUser = getSysUserByUsernameForMoney(username);
        return sysUser!=null;
    }

    private SysUser getSysUserByUsername(String username){
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setUsername(username);
        sysUserVo.getSearch().setSiteId(SessionManager.getSiteId());
        sysUserVo.getSearch().setSubsysCode(SubSysCodeEnum.PCENTER.getCode());
        SysUser byUsername = ServiceTool.sysUserService().findByUsername(sysUserVo);
        return byUsername;
    }

    private SysUser getSysUserByUsernameForMoney(String username){
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setUsername(username);
        sysUserVo.getSearch().setSiteId(SessionManager.getSiteId());
        sysUserVo.getSearch().setSubsysCode(SubSysCodeEnum.PCENTER.getCode());
        sysUserVo.getSearch().setStatus(SysUserStatus.NORMAL.getCode());
        SysUserListVo sysUserListVo = ServiceTool.userPlayerService().findByUsernameForMoney(sysUserVo);
        return sysUserListVo.getResult().isEmpty()? null:sysUserListVo.getResult().get(0);
    }

    @RequestMapping(value = "/cancelDefaultWin")
    @ResponseBody
    public Map cancelDefaultWin(ActivityMoneyDefaultWinVo defaultWinVo){
        Map resultMap = new HashMap();
        if(defaultWinVo.getSearch().getId()==null){
            resultMap.put("state",false);
            resultMap.put("msg",LocaleTool.tranMessage("operation_auto","取消内定ID为空"));
            return resultMap;
        }
        defaultWinVo.getSearch().setOperateId(SessionManager.getUserId());
        defaultWinVo.getSearch().setOperateUsername(SessionManager.getUserName());
        defaultWinVo = getService().cancelDefaultWin(defaultWinVo);
        resultMap = getVoMessage(defaultWinVo);
        return resultMap;
    }
    @RequestMapping(value = "/fetchActivityAwardsRules")
    @ResponseBody
    public ActivityMoneyAwardsRules fetchActivityAwardsRules(Integer id){
        if(id==null){
            return null;
        }
        ActivityMoneyAwardsRulesVo awardsRulesVo = new ActivityMoneyAwardsRulesVo();
        awardsRulesVo.getSearch().setId(id);
        awardsRulesVo = ServiceTool.activityMoneyAwardsRulesService().get(awardsRulesVo);
        if(awardsRulesVo.getResult()!=null){
            return awardsRulesVo.getResult();
        }
        return null;

    }
    @RequestMapping(value = "/hasUseDefaultWinPlayer")
    @ResponseBody
    public String hasUseDefaultWinPlayer(ActivityMoneyDefaultWinVo defaultWinVo){
        List<String> usernameList = getService().hasUseDefaultWinPlayer(defaultWinVo);
        if(usernameList!=null){
            return usernameList.toString();
        }
        return "";
    }

    //endregion your codes 3

}