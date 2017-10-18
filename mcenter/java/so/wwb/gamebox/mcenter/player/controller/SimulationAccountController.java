package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.RandomStringTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.commons.validation.form.PasswordRule;
import org.soul.model.log.audit.enums.OpMode;
import org.soul.model.security.privilege.po.SysUser;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.session.RedisSessionDao;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.player.IUserPlayerService;
import so.wwb.gamebox.mcenter.player.form.SimulationAddNewPlayerForm;
import so.wwb.gamebox.mcenter.player.form.SimulationEditPlayerForm;
import so.wwb.gamebox.mcenter.player.form.UserPlayerForm;
import so.wwb.gamebox.mcenter.player.form.UserPlayerSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.CacheBase;
import so.wwb.gamebox.model.SubSysCodeEnum;
import so.wwb.gamebox.model.common.Const;
import so.wwb.gamebox.model.enums.DemoModelEnum;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.enums.PlayerStatusEnum;
import so.wwb.gamebox.model.master.fund.enums.RechargeTypeEnum;
import so.wwb.gamebox.model.master.fund.po.PlayerRecharge;
import so.wwb.gamebox.model.master.fund.vo.PlayerRechargeVo;
import so.wwb.gamebox.model.master.player.po.UserPlayer;
import so.wwb.gamebox.model.master.player.vo.*;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.shiro.common.filter.KickoutFilter;
import sun.rmi.runtime.Log;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.text.MessageFormat;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;


/**`
 * 控制器
 *
 * Created by snekey using soul-code-generator on 2015-6-19 virtualAccountSiteId:51:46
 */
@Controller
@RequestMapping("/simulationAccount")
public class SimulationAccountController extends BaseCrudController<IUserPlayerService, UserPlayerListVo, UserPlayerVo, UserPlayerSearchForm, UserPlayerForm, UserPlayer, Integer> {
    @Override
    //region your codes
    protected String getViewBasePath() {
        return "/player/simulationAccount/";
    }
    private static final org.soul.commons.log.Log LOG = LogFactory.getLog(SimulationAccountController.class);

    @Value("${ds.id.model.mock.account}")
    private Integer virtualAccountSiteId;
    @Autowired
    private RedisSessionDao redisSessionDao;

    @RequestMapping("/playerView")
    protected String playerView(VUserPlayerListVo listVo, Model model, HttpServletRequest request) {
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo._setDataSourceId(virtualAccountSiteId);
        VUserPlayerListVo vUserPlayerListVo = ServiceTool.vUserPlayerService().search(listVo);
        model.addAttribute("foreverTime",Const.Platform_Forever_Date);
        model.addAttribute("command",vUserPlayerListVo);
        if (ServletTool.isAjaxSoulRequest(request)) {
            return getViewBasePath() + "IndexPartial";
        } else {
            return getViewBasePath() + "Index";
        }
    }

    @RequestMapping("/addPlayer")
    public String addPlayer(UserPlayerVo Vo,Model model){
        model.addAttribute("accountSiteId",virtualAccountSiteId);
        model.addAttribute("validateRule", JsRuleCreator.create(SimulationAddNewPlayerForm.class));
        return getViewBasePath()+"Add";
    }

    @RequestMapping("/savePlayer")
    @ResponseBody
    public Map savePlayer(UserPlayerVo Vo, @FormModel("result") @Valid SimulationAddNewPlayerForm form){
        Map map=new HashMap(2, 1f);
        UserPlayer userPlayer=new UserPlayer();
        SysUser sysUser=new SysUser();
        UserRegisterVo userRegisterVo=new UserRegisterVo();
        userPlayer.setWalletBalance(Vo.getResult().getWalletBalance());
        userPlayer.setRankId(-1);
        sysUser.setUsername(Vo.getSysUser().getUsername());
        sysUser.setPassword(Vo.getSysUser().getPassword());
        if (Vo.getSysUser().getFreezeStartTime()!=null){
            sysUser.setFreezeStartTime(Vo.getSysUser().getFreezeStartTime());
            sysUser.setFreezeEndTime(DateTool.addYears(sysUser.getFreezeStartTime(),3000));
        }else {
            sysUser.setFreezeStartTime(null);
            sysUser.setFreezeEndTime(null);
        }
        sysUser.setMemo(Vo.getSysUser().getMemo());
        userRegisterVo.setUserPlayer(userPlayer);
        userRegisterVo.setSysUser(sysUser);
        userRegisterVo._setDataSourceId(virtualAccountSiteId);
        userRegisterVo.setDemoModel(DemoModelEnum.MODEL_4_MOCK_ACCOUNT);
        userRegisterVo = ServiceTool.userPlayerService().registerModelAccount(userRegisterVo);
        /*Vo._setDataSourceId(virtualAccountSiteId);
        userPlayer.setId(userRegisterVo.getSysUser().getId());
        Vo.setResult(userPlayer);
        Vo.setProperties(UserPlayer.PROP_WALLET_BALANCE);
        UserPlayerVo userPlayerVo = ServiceTool.userPlayerService().updateOnly(Vo);*/
        if (userRegisterVo.isSuccess()){
            map.put("state",true);
            map.put("msg","成功");
        }else {
            map.put("state",false);
            map.put("msg","失败");
        }
        return map;
    }

    @RequestMapping(value = "/checkUserNameExist")
    @ResponseBody
    public String checkUserNameExist(@RequestParam("sysUser.username") String userName,@RequestParam("accountSiteId")Integer virtualAccountSiteId) {
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setSubsysCode(SubSysCodeEnum.PCENTER.getCode());
        sysUserVo.getSearch().setUsername(userName);
        sysUserVo._setDataSourceId(virtualAccountSiteId);
        String existAgent = ServiceTool.userAgentService().isExistAgent(sysUserVo);
        return existAgent;
    }

    @RequestMapping("/passwordNotWeak")
    @ResponseBody
    public String passwordNotWeak(@RequestParam("sysUser.password")String password,@RequestParam("sysUser.username") String username){
        if(StringTool.isBlank(password))
            return "false";
        if(password.equals(username)){
            return "false";
        }
        if(PasswordRule.isWeak(password)){
            return "false";
        }

        return "true";
    }

    @RequestMapping("/editaAccount")
    public String editAccount(VUserPlayerVo vUserPlayerVo, Model model){
        model.addAttribute("validateRule", JsRuleCreator.create(SimulationEditPlayerForm.class));
        vUserPlayerVo._setDataSourceId(virtualAccountSiteId);
        VUserPlayerVo playerVo = ServiceTool.vUserPlayerService().get(vUserPlayerVo);
        model.addAttribute("command",playerVo);
        return getViewBasePath()+"Edit";
    }

    @RequestMapping("/updatePlayer")
    @ResponseBody
    public Map updatePlayer(VUserPlayerVo vUserPlayerVo){
        Map map=new HashMap(2,1f);
        SysUserVo sysUserVo=new SysUserVo();
        SysUser sysUser=new SysUser();
        sysUser.setId(vUserPlayerVo.getSearch().getId());
        if (vUserPlayerVo.getSysUser().getFreezeStartTime()!=null){
            sysUser.setFreezeStartTime(vUserPlayerVo.getSysUser().getFreezeStartTime());
        }else {
            sysUser.setFreezeStartTime(Const.Platform_Forever_Date);
        }
        sysUser.setMemo(vUserPlayerVo.getSysUser().getMemo());
        sysUserVo.setResult(sysUser);
        sysUserVo._setDataSourceId(virtualAccountSiteId);
        sysUserVo.setProperties(SysUser.PROP_FREEZE_START_TIME,SysUser.PROP_MEMO);
        SysUserVo userVo = ServiceTool.sysUserService().updateOnly(sysUserVo);
        if (userVo.isSuccess()){
            map.put("state",true);
            map.put("msg","成功");
        }else {
            map.put("state",false);
            map.put("msg","失败");
        }
        return map;
    }

    @RequestMapping("/addQuota")
    public String addQuota(VUserPlayerVo vUserPlayerVo,Model model){
        model.addAttribute("validateRule", JsRuleCreator.create(SimulationEditPlayerForm.class));
        model.addAttribute("id",vUserPlayerVo.getSearch().getId());
        return getViewBasePath()+"AddQuota";
    }

    @RequestMapping("/saveAddQuota")
    @ResponseBody
    public Map saveAddQuota(VUserPlayerVo vUserPlayerVo,double walletBalance){
        Map map=new HashMap(2,1f);
        PlayerRechargeVo playerRechargeVo=new PlayerRechargeVo();
        PlayerRecharge playerRecharge=new PlayerRecharge();
        SysUser sysUser=new SysUser();
        playerRechargeVo.setAuditType(PlayerRechargeVo.FREE_AUDIT);
        if ((vUserPlayerVo.getSearch().getId())!=null){
            sysUser.setId(vUserPlayerVo.getSearch().getId());
            playerRechargeVo.setSysUser(sysUser);
            map=insertQuota(playerRechargeVo, playerRecharge,walletBalance);
        }else {
            for (Integer id : vUserPlayerVo.getSearch().getIds()){
                SysUser user=new SysUser();
                PlayerRechargeVo rechargeVo=new PlayerRechargeVo();
                rechargeVo.setAuditType(PlayerRechargeVo.FREE_AUDIT);
                user.setId(id);
                rechargeVo.setSysUser(user);
                map=insertQuota(rechargeVo, playerRecharge,walletBalance);
            }
        }

        return map;
    }

    private Map insertQuota(PlayerRechargeVo playerRechargeVo, PlayerRecharge playerRecharge,double walletBalance) {
        Map map=new HashMap(2,1f);
        playerRecharge.setRechargeAmount(walletBalance);
        playerRecharge.setRechargeType(RechargeTypeEnum.MANUAL_DEPOSIT.getCode());
        playerRechargeVo.setResult(playerRecharge);
        playerRechargeVo._setDataSourceId(virtualAccountSiteId);
        PlayerRechargeVo rechargeVo = ServiceTool.playerRechargeService().manualRecharge(playerRechargeVo);
        if (rechargeVo.isSuccess()){
            map.put("state",true);
            map.put("msg","成功");
        }else {
            map.put("state",false);
            map.put("msg","失败");
        }
        return map;
    }

    @RequestMapping("/deletePlayer")
    @ResponseBody
    public Map deletePlayer(Integer[] ids){
        Map map=new HashMap(2,1f);
        VUserPlayerListVo listVo=new VUserPlayerListVo();
        listVo.getSearch().setIds( Arrays.asList(ids));
        listVo._setDataSourceId(virtualAccountSiteId);
        VUserPlayerListVo vUserPlayerListVo = ServiceTool.userPlayerService().deletePlayer(listVo);
        if (vUserPlayerListVo.isSuccess()){
            map.put("state",true);
            map.put("msg","成功");
        }else {
            map.put("state",false);
            map.put("msg","失败");
        }
        return map;
    }

    @RequestMapping("/disablePlayer")
    @ResponseBody
    public Map disablePlayer(VUserPlayerVo vUserPlayerVo){
        Map map=new HashMap(2,1f);
        SysUserVo sysUserVo=new SysUserVo();
        SysUser sysUser=new SysUser();
        sysUser.setStatus(PlayerStatusEnum.DISABLE.getCode());
        sysUser.setId(vUserPlayerVo.getSearch().getId());
        String targetSiteId= CommonContext.get().getSiteId().toString();
        String key= MessageFormat.format("{0}{1},{2},{3}:{4},{5},*",
                redisSessionDao.getSessionKeyPreFix(),
                String.valueOf(Cache.getSysSite().get(targetSiteId).getParentId()),
                String.valueOf(Cache.getSysSite().get(targetSiteId).getSysUserId()),
                String.valueOf(targetSiteId),
                UserTypeEnum.PLAYER.getCode(),String.valueOf(vUserPlayerVo.getSearch().getId()));
        redisSessionDao.kickOutSession(key, OpMode.MANUAL,"站长中心停用玩家强制踢出");
        LOG.info("踢出玩家key:{0}",key);
        sysUserVo.setResult(sysUser);
        sysUserVo._setDataSourceId(virtualAccountSiteId);
        sysUserVo.setProperties(SysUser.PROP_STATUS);
        SysUserVo userVo = ServiceTool.sysUserService().updateOnly(sysUserVo);
        if (userVo.isSuccess()){
            map.put("state",true);
            map.put("msg","成功");
        }else {
            map.put("state",false);
            map.put("msg","失败");
        }
        return map;
    }

    @RequestMapping("/autoResetPwd")
    public String autoResetPwd(ResetPwdVo resetPwdVo, Model model){
        // 重置密码
        String newPwd = RandomStringTool.randomNumeric(6);
        resetPwdVo.setResetType("loginPwd");
        resetPwdVo.setPassword(newPwd);
        resetUserPwd(resetPwdVo);
        model.addAttribute("newPwd",newPwd);
        return getViewBasePath()+"SuccessPassword";
    }
    /**
     * 重置密码
     * @param resetPwdVo
     * @return
     */
    private Map resetUserPwd(ResetPwdVo resetPwdVo) {
        Map map = new HashMap();
        resetPwdVo._setDataSourceId(virtualAccountSiteId);
        Boolean isOk = ServiceTool.userPlayerService().resetPassword(resetPwdVo);
        map.put("state",isOk);
        if(StringTool.isBlank(resetPwdVo.getInformType())){
            resetPwdVo.setInformType("false");
        }else{
            resetPwdVo.setInformType("true");
        }
        return map;
    }
    //    endregion your codes

}