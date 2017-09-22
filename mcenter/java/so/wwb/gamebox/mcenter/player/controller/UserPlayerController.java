package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.dict.DictTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.support._Module;
import org.soul.model.log.audit.enums.OpType;
import org.soul.model.log.audit.vo.BaseLog;
import org.soul.model.log.audit.vo.LogVo;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.model.sys.po.SysAuditLog;
import org.soul.model.sys.po.SysDict;
import org.soul.model.sys.po.SysParam;
import org.soul.model.sys.vo.SysParamVo;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import so.wwb.gamebox.iservice.master.player.IUserPlayerService;
import so.wwb.gamebox.mcenter.init.ConfigManager;
import so.wwb.gamebox.mcenter.player.form.UserPlayerForm;
import so.wwb.gamebox.mcenter.player.form.UserPlayerSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.ModuleType;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.common.Audit;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.master.player.po.PlayerRank;
import so.wwb.gamebox.model.master.player.po.UserPlayer;
import so.wwb.gamebox.model.master.player.vo.PlayerRankVo;
import so.wwb.gamebox.model.master.player.vo.UserPlayerListVo;
import so.wwb.gamebox.model.master.player.vo.UserPlayerVo;
import so.wwb.gamebox.model.master.player.vo.VUserPlayerVo;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.util.*;


/**`
 * 控制器
 *
 * Created by snekey using soul-code-generator on 2015-6-19 13:51:46
 */
@Controller
@RequestMapping("/userPlayer")
public class UserPlayerController extends BaseCrudController<IUserPlayerService, UserPlayerListVo, UserPlayerVo, UserPlayerSearchForm, UserPlayerForm, UserPlayer, Integer> {
    @Override
    //region your codes
    protected String getViewBasePath() {
        return "/player/player/addPlayer/AddPlayer";
    }

    private static final String CLEAR_CONTACT_INFO_URI = "/player/player/clearContact/ClearContactInfo";
    private static final String RANK_LIST="/player/player/setRank/RankList";
    private static final String EXPORT="/player/player/clearContact/Export";

    /**
     * 清除联系人
     * @param
     * @param userPlayerVo
     * @return
     */
    @RequestMapping("/clear")
    @ResponseBody
    public Map playerView(UserPlayerVo userPlayerVo) {
        boolean success = this.getService().clearContact(userPlayerVo);
        String msg;
        if (success) {
            msg = LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_SUCCESS);
        } else {
            msg = LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_FAILED);
        }
        HashMap map = new HashMap(2,1f);
        map.put("msg", msg);
        map.put("state", success);
        return map;
    }

    /**
     * 跳转到清除联系人页面，带入参数ids，即勾选玩家的id
     * @param userPlayerVo
     * @param model
     * @return
     */
    @RequestMapping("/export")
    public String export(UserPlayerVo userPlayerVo,Model model) {
        //查自己站点sys_param表的param_value值
        SysParam sysParam =getExportParam();
        model.addAttribute("queryparamValue", sysParam);
        model.addAttribute("model", userPlayerVo);
        return EXPORT;
    }
    public SysParam getExportParam(){
        SysParamVo sysParamVo = new SysParamVo();
        //sysParamVo._setDataSourceId(sysParamVo._getSiteId());//设置数据源为各个站点
        sysParamVo.getSearch().setModule(SiteParamEnum.SITE_PLAYER_EXPORT.getModule().getCode());//设置查询条件的值
        sysParamVo.getSearch().setParamType(SiteParamEnum.SITE_PLAYER_EXPORT.getType());
        sysParamVo.getSearch().setParamCode(SiteParamEnum.SITE_PLAYER_EXPORT.getCode());
        List<SysParam> sysParams = ServiceTool.getSysParamService().byCodeAndActive(sysParamVo);//查询并返回结果
        if(!sysParams.isEmpty()){
            SysParam sysParam = sysParams.get(0);
            return sysParam;
        }
        return null;
    }

    @RequestMapping(value = "/findExportedPlayers",method = RequestMethod.POST,headers = {"Content-type=application/json"})
    @ResponseBody
    public Map<String,Object> findExportedPlayers(@RequestBody UserPlayerVo userPlayerVo,Model model){
        /*UserPlayerVo userPlayerVo = new UserPlayerVo();
        userPlayerVo.setIds(userPlayerVo.getIds());*/
        Integer count = calExportedPlayers(userPlayerVo);
        String exportIds = getNeedExportIds(userPlayerVo);
        Map<String,Object> result = new HashMap<>();
        result.put("count",count);
        result.put("exportIds",exportIds);
        result.put("success","true");
        return result;
    }
    private UserPlayerListVo queryUserPlayerList(UserPlayerVo userPlayerVo){
        UserPlayerListVo listVo = new UserPlayerListVo();
        if(userPlayerVo.getIds()==null||userPlayerVo.getIds().size()==0){
            return listVo;
        }
        listVo.setPaging(null);
        listVo.getSearch().setIds(userPlayerVo.getIds());
        listVo = this.getService().search(listVo);
        return listVo;
    }
    private Integer calExportedPlayers(UserPlayerVo userPlayerVo){
        UserPlayerListVo listVo = queryUserPlayerList(userPlayerVo);
        if(listVo.getResult()!=null){
            return listVo.getResult().size();
        }
        return 0;
    }

    private String getNeedExportIds(UserPlayerVo userPlayerVo){
        UserPlayerListVo listVo = queryUserPlayerList(userPlayerVo);
        if(listVo==null||listVo.getResult()==null){
            return "";
        }
        String ids = "";
        for(UserPlayer userPlayer : listVo.getResult()){
            ids = ids + userPlayer.getId()+",";
        }
        if(ids.length()>0){
            ids = ids.substring(0,ids.length()-1);
        }
        return ids;
    }

    /**
     * 清除联系方式
     * @param userPlayerVo
     * @param model
     * @return
     */
    @RequestMapping("/clearContact")
    public String clearContact(UserPlayerVo userPlayerVo,Model model){
        Map<String, SysDict> contactType = DictTool.get(DictEnum.COMMON_CONTACT_WAY_TYPE);
        userPlayerVo.setContactTypeMap(contactType);
        model.addAttribute("model", userPlayerVo);
        return CLEAR_CONTACT_INFO_URI;
    }

    /**
     * 新增玩家中
     * 将区号和号码拼在一起放到实体里
     * @param userPlayerVo
     * @return
     */
    @Override
    public UserPlayerVo doSave(UserPlayerVo userPlayerVo) {
//        String s = userPlayerVo.getAreaCode() + userPlayerVo.getTel();
//        userPlayerVo.getResult().setMobilePhone(s);
//
//        userPlayerVo.getSysUser().setCreateTime(new Date());
//        userPlayerVo.getSysUser().setSubsysCode(ConfigManager.getConfigration().getSubsysCode());
//        if(userPlayerVo.getResult().getSex().isEmpty()){
//            userPlayerVo.getResult().setSex(SexEnum.SECRET.getCode());
//        }
        return this.getService().insert(userPlayerVo);
    }

    /**
     * 页面部分下拉框的字典和国际化
     * @param userPlayerVo
     * @param model
     * @return
     */
    @Override
    protected UserPlayerVo doCreate(UserPlayerVo userPlayerVo, Model model) {
        Map<String, SysDict> sex = DictTool.get(DictEnum.COMMON_SEX );
        userPlayerVo.setSex(sex);
        List<PlayerRank> rankList = ServiceTool.playerRankService().getRankName(new PlayerRankVo());
        model.addAttribute("rankList",rankList);
        Map<String, Serializable> imTypeMaps = DictTool.get(DictEnum.COMMON_CONTACT_WAY_TYPE);
        userPlayerVo.setContactTypeMap(imTypeMaps);
        Map<String, Serializable> phoneCodeMaps = DictTool.get(DictEnum.REGION_CALLING_CODE);
        model.addAttribute("phoneCodeMaps",phoneCodeMaps);
        return userPlayerVo;
    }

    /**
     * 解锁玩家层级
     * @param ids
     * @return
     */
    @RequestMapping("/unlock")
    @ResponseBody
    public Map unlockLevel(Integer[] ids){
        UserPlayerVo userPlayerVo= new UserPlayerVo();
        String msg ;
        boolean success =ids.length>1;
        userPlayerVo.setIds(Arrays.asList(ids));
        ServiceTool.playerRankService().unlockPlayerRank(userPlayerVo);
        if(ids.length==1){
            Integer playerId = ids[0];
            VUserPlayerVo vUserPlayerVo = new VUserPlayerVo();
            vUserPlayerVo.setType(playerId);
            List<String> rankName = ServiceTool.vUserPlayerService().getRankNameById(vUserPlayerVo);
            String rank = rankName.get(0);
            msg = LocaleTool.tranMessage(_Module.COMMON, "unlockRank.success");
            msg = msg +rank;

        }else {

            if (success) {
                msg = LocaleTool.tranMessage(_Module.COMMON, "unlockRank.success.plu");
            } else {
                msg = LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_FAILED);
            }

        }
        HashMap<String,Object> map = new HashMap(2,1f);
        map.put("msg", msg);
        map.put("state", success);
        return map;
    }

    /**
     * 拿到层级列表
     * @param playerRankVo
     * @param model
     * @return
     */
    @RequestMapping("/getRankList")
    public String getRankList(PlayerRankVo playerRankVo,Model model){
        if(playerRankVo.getSearch().getPlayerIds().size() == 1){
            Integer playerId = playerRankVo.getSearch().getPlayerIds().get(0);
            UserPlayerVo userPlayerVo = new UserPlayerVo();
            userPlayerVo.getSearch().setId(playerId);
            userPlayerVo = ServiceTool.userPlayerService().get(userPlayerVo);
            model.addAttribute("userPlayerVo",userPlayerVo);
        }
        List<PlayerRank> rankList = ServiceTool.playerRankService().getRankName(playerRankVo);
        model.addAttribute("rankList",rankList);
        return RANK_LIST;
    }

    /**
     * 设置玩家层级
     * @param userPlayerVo
     * @return
     */
    @RequestMapping("/setRank")
    @Audit(module = Module.PLAYER, moduleType = ModuleType.PLAYER_PLAYERRANK_SUCCESS, opType = OpType.UPDATE)
    @ResponseBody
    protected Map setRank(HttpServletRequest request,UserPlayerVo userPlayerVo) {
        Map maps = this.getService().setRank(userPlayerVo);
        String msg;
        if (maps.get("status").equals(true)) {
            msg = LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_SUCCESS);
            //操作日志
            maps.remove("status");
            LogVo logVo = new LogVo();
            for(Object obj:maps.values()){
                addLog(request, "player.playerRank.success",obj,logVo);
            }
        } else {
            msg = LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.OPERATION_FAILED);
        }
        HashMap map = new HashMap(2,1f);
        map.put("msg", msg);
        map.put("state", maps.get("status"));
        return map;
    }

    /**
     * 日志
     * @param request
     * @param description 日志描述
     */
    private void addLog(HttpServletRequest request, String description,Object obj,LogVo logVo) {
        String entityId = ((HashMap) obj).get("entityId").toString();
        String player = ((HashMap) obj).get("player").toString();

        List<String> params = new ArrayList<>();
        params.add(((HashMap) obj).get("player").toString());
        params.add(((HashMap) obj).get("oldRankName").toString());
        params.add(((HashMap) obj).get("newRankName").toString());
        params.add(((HashMap) obj).get("oldSetName").toString());
        params.add(((HashMap) obj).get("newSetName").toString());

        BaseLog baseLog = logVo.addBussLog();
        baseLog.setDescription(description);
        baseLog.setEntityId(entityId);
        baseLog.setEntityUserId(Integer.valueOf(entityId));
        baseLog.setEntityUsername(player);
        for (String param : params){
            baseLog.addParam(param);
        }
        request.setAttribute(SysAuditLog.AUDIT_LOG, logVo);
    }

    /**
     * 新增玩家页面的远程验证,用户名不能重复
     * @param userName
     * @return
     */
    @RequestMapping(value = "/checkUserName")
    @ResponseBody
    public String checkUserName(@RequestParam("sysUser.username") String userName){
        SysUserVo sysUserVo = new SysUserVo();
        String subsysCode = ConfigManager.getConfigration().getSubsysCode();
        sysUserVo.getSearch().setSubsysCode(subsysCode);
        sysUserVo.getSearch().setUsername(userName);
        sysUserVo.getSearch().setSiteId(SessionManager.getSiteId());
        boolean exists = ServiceTool.sysUserService().isExists(sysUserVo);
        return exists ? "false" : "true";
    }
//    endregion your codes

}