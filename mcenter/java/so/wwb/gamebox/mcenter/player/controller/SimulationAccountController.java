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
import so.wwb.gamebox.model.SubSysCodeEnum;
import so.wwb.gamebox.model.common.Const;
import so.wwb.gamebox.model.enums.DemoModelEnum;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.enums.CreateChannelEnum;
import so.wwb.gamebox.model.master.enums.PlayerStatusEnum;
import so.wwb.gamebox.model.master.fund.enums.RechargeTypeEnum;
import so.wwb.gamebox.model.master.fund.po.PlayerRecharge;
import so.wwb.gamebox.model.master.fund.vo.PlayerRechargeVo;
import so.wwb.gamebox.model.master.player.po.UserPlayer;
import so.wwb.gamebox.model.master.player.vo.*;
import so.wwb.gamebox.web.SessionManagerCommon;
import so.wwb.gamebox.web.cache.Cache;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.text.MessageFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


/**`
 * 控制器
 *
 * Created by snekey using soul-code-generator on 2015-6-19 mockAccountSiteId:51:46
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
    private Integer mockAccountSiteId;
    @Autowired
    private RedisSessionDao redisSessionDao;

    @RequestMapping("/playerView")
    protected String playerView(VUserPlayerListVo listVo, Model model, HttpServletRequest request) {
        listVo.getSearch().setSiteId(SessionManager.getSiteId());
        listVo._setDataSourceId(mockAccountSiteId);
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
        model.addAttribute("accountSiteId",mockAccountSiteId);
        model.addAttribute("validateRule", JsRuleCreator.create(SimulationAddNewPlayerForm.class));
        return getViewBasePath()+"Add";
    }

    @RequestMapping("/savePlayer")
    @ResponseBody
    public Map savePlayer(UserPlayerVo Vo, HttpServletRequest request, @FormModel("result") @Valid SimulationAddNewPlayerForm form){
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
        String domain = SessionManagerCommon.getDomain(request);
        sysUser.setRegisterSite(domain);
        sysUser.setCreateUser(SessionManager.getUser().getId());
        //UserRegisterVo 的result没有用到。暂时用来传参
        userRegisterVo.getSearch().setImportUsername(SessionManager.getUser().getUsername());
        userRegisterVo.getSearch().setId(SessionManager.getSiteId());
        sysUser.setCreateTime(new Date());
        userPlayer.setCreateChannel(CreateChannelEnum.BACKSTAGE_MANAGEMENT.getCode());
        userRegisterVo.setUserPlayer(userPlayer);
        userRegisterVo.setSysUser(sysUser);
        userRegisterVo._setDataSourceId(mockAccountSiteId);
        userRegisterVo.setDemoModel(DemoModelEnum.MODEL_4_MOCK_ACCOUNT);
        userRegisterVo = ServiceTool.userPlayerService().registerModelAccount(userRegisterVo);
        /*Vo._setDataSourceId(mockAccountSiteId);
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
    public String checkUserNameExist(@RequestParam("sysUser.username") String userName,@RequestParam("accountSiteId")Integer mockAccountSiteId) {
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setSubsysCode(SubSysCodeEnum.PCENTER.getCode());
        sysUserVo.getSearch().setUsername(userName);
        sysUserVo._setDataSourceId(mockAccountSiteId);
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
        vUserPlayerVo._setDataSourceId(mockAccountSiteId);
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
        Date date=new Date();
        sysUser.setId(vUserPlayerVo.getSearch().getId());
        if (vUserPlayerVo.getSysUser().getFreezeStartTime()!=null){
            sysUser.setFreezeStartTime(vUserPlayerVo.getSysUser().getFreezeStartTime());
            sysUser.setFreezeEndTime(DateTool.addYears(sysUser.getFreezeStartTime(),3000));
        }else {
            sysUser.setFreezeStartTime(null);

        }
        sysUser.setMemo(vUserPlayerVo.getSysUser().getMemo());
        sysUserVo.setResult(sysUser);
        sysUserVo._setDataSourceId(mockAccountSiteId);
        sysUserVo.setProperties(SysUser.PROP_FREEZE_START_TIME,SysUser.PROP_FREEZE_END_TIME,SysUser.PROP_MEMO);
        SysUserVo userVo = ServiceTool.sysUserService().updateOnly(sysUserVo);
        if (userVo.isSuccess()){
            if (vUserPlayerVo.getSysUser()!=null&&vUserPlayerVo.getSysUser().getFreezeStartTime()!=null&&vUserPlayerVo.getSysUser().getFreezeStartTime().before(date) ){
                kickOutPlayer(vUserPlayerVo);
            }
            map.put("state",true);
            map.put("msg","成功");
        }else {
            map.put("state",false);
            map.put("msg","失败");
        }
        return map;
    }

    private void kickOutPlayer(VUserPlayerVo vUserPlayerVo) {
        String targetSiteId= CommonContext.get().getSiteId().toString();
        String key= MessageFormat.format("{0}{1},{2},{3}:{4},{5},*",
                redisSessionDao.getSessionKeyPreFix(),
                String.valueOf(Cache.getSysSite().get(targetSiteId).getParentId()),
                String.valueOf(Cache.getSysSite().get(targetSiteId).getSysUserId()),
                String.valueOf(targetSiteId),
                UserTypeEnum.PLAYER.getCode(),String.valueOf(vUserPlayerVo.getSearch().getId()));
        redisSessionDao.kickOutSession(key, OpMode.MANUAL,"站长中心玩家强制踢出");
        LOG.info("踢出玩家key:{0}",key);
    }

    @RequestMapping("/addQuota")
    @Token(generate = true)
    public String addQuota(VUserPlayerVo vUserPlayerVo,Model model){
        model.addAttribute("validateRule", JsRuleCreator.create(SimulationEditPlayerForm.class));
        model.addAttribute("id",vUserPlayerVo.getSearch().getId());
        return getViewBasePath()+"AddQuota";
    }

    @RequestMapping("/saveAddQuota")
    @ResponseBody
    @Token(valid = true)
    public Map saveAddQuota(VUserPlayerVo vUserPlayerVo){
        Map map=new HashMap(2,1f);
        try{
            PlayerRechargeVo playerRechargeVo=new PlayerRechargeVo();
            PlayerRecharge playerRecharge=new PlayerRecharge();
            SysUser sysUser=new SysUser();
            playerRechargeVo.setAuditType(PlayerRechargeVo.FREE_AUDIT);
            if ((vUserPlayerVo.getSearch().getId())!=null){
                vUserPlayerVo._setDataSourceId(mockAccountSiteId);
                VUserPlayerVo userPlayerVo = ServiceTool.vUserPlayerService().get(vUserPlayerVo);
                Double totalAssets = userPlayerVo.getResult().getTotalAssets();
                Double walletBalance = vUserPlayerVo.getSearch().getWalletBalance();
                double quota = walletBalance + totalAssets;
                if (quota >1000000){
                    map.put("state",false);
                    map.put("msg","总额度不能超过100万，请重新添加！");
                    map.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
                    return map;
                }
                sysUser.setId(vUserPlayerVo.getSearch().getId());
                playerRechargeVo.setSysUser(sysUser);
                map=insertQuota(playerRechargeVo, playerRecharge,walletBalance);
            }else {
                vUserPlayerVo.setSysUser(new SysUser());
                vUserPlayerVo.getSysUser().setCreateUser(SessionManager.getUser().getId());
                vUserPlayerVo.getSysUser().setUsername(SessionManager.getUser().getUsername());
                vUserPlayerVo._setDataSourceId(mockAccountSiteId);
                vUserPlayerVo = getService().batchAddQuota(vUserPlayerVo);

                map = getVoMessage(vUserPlayerVo);
            }
        }catch (Exception ex){
            map.put("state",false);
            map.put("msg",ex.getMessage());
            map.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
            LOG.error(ex,"批量调整额度异常：{0}",ex.getMessage());
        }

        return map;
    }

    private Map insertQuota(PlayerRechargeVo playerRechargeVo, PlayerRecharge playerRecharge,double walletBalance) {
        Map map=new HashMap(2,1f);
        initCheckData(playerRecharge);
        playerRecharge.setRechargeAmount(walletBalance);
        playerRecharge.setRechargeType(RechargeTypeEnum.MANUAL_DEPOSIT.getCode());
        playerRechargeVo.setResult(playerRecharge);
        playerRechargeVo._setDataSourceId(mockAccountSiteId);
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

    private void initCheckData(PlayerRecharge playerRecharge) {
        playerRecharge.setCheckUserId(SessionManager.getUser().getId());
        playerRecharge.setCheckUsername(SessionManager.getUser().getUsername());
        String remark = "站点ID：{0}，操作人ID：{1}，操作人账号：{2}，操作时间：{3}";
        String time = DateTool.formatDate(new Date(), CommonContext.get().getTimeZone(),DateTool.yyyy_MM_dd_HH_mm_ss);
        remark = MessageFormat.format(remark,SessionManager.getSiteId().toString(),playerRecharge.getCheckUserId().toString(),playerRecharge.getCheckUsername(),time);
        playerRecharge.setCheckRemark(remark);
    }

    @RequestMapping("/deletePlayer")
    @ResponseBody
    public Map deletePlayer(Integer[] ids){
        Map map=new HashMap(2,1f);
        VUserPlayerListVo listVo=new VUserPlayerListVo();
        listVo.getSearch().setIds( Arrays.asList(ids));
        listVo._setDataSourceId(mockAccountSiteId);
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
        sysUserVo.setResult(sysUser);
        sysUserVo._setDataSourceId(mockAccountSiteId);
        sysUserVo.setProperties(SysUser.PROP_STATUS);
        SysUserVo userVo = ServiceTool.sysUserService().updateOnly(sysUserVo);
        if (userVo.isSuccess()){
            kickOutPlayer(vUserPlayerVo);
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
        if (resetPwdVo.getInformType()=="false"){
            model.addAttribute("newPwd",newPwd);
        }else {
            model.addAttribute("status","false");
        }

        return getViewBasePath()+"SuccessPassword";
    }
    /**
     * 重置密码
     * @param resetPwdVo
     * @return
     */
    private Map resetUserPwd(ResetPwdVo resetPwdVo) {
        Map map = new HashMap();
        resetPwdVo._setDataSourceId(mockAccountSiteId);
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