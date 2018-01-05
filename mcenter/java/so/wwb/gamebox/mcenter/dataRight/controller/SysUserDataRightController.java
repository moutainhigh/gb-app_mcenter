package so.wwb.gamebox.mcenter.dataRight.controller;

import org.soul.commons.collections.CollectionTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.support._Module;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.iservice.master.dataRight.ISysUserDataRightService;
import so.wwb.gamebox.mcenter.dataRight.form.SysUserDataRightForm;
import so.wwb.gamebox.mcenter.dataRight.form.SysUserDataRightSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.common.MessageI18nConst;
import so.wwb.gamebox.model.master.dataRight.DataRightModuleType;
import so.wwb.gamebox.model.master.dataRight.SysResourceEnum;
import so.wwb.gamebox.model.master.dataRight.po.SysUserDataRight;
import so.wwb.gamebox.model.master.dataRight.vo.SysUserDataRightListVo;
import so.wwb.gamebox.model.master.dataRight.vo.SysUserDataRightVo;
import so.wwb.gamebox.model.master.player.po.PlayerRank;
import so.wwb.gamebox.model.master.player.vo.PlayerRankListVo;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 数据权限控制器
 *
 * @author bruce
 * @time 2016-11-15 15:25:38
 */
@Controller
//region your codes 1
@RequestMapping("/sysUserDataRight")
public class SysUserDataRightController extends BaseCrudController<ISysUserDataRightService, SysUserDataRightListVo,
        SysUserDataRightVo, SysUserDataRightSearchForm, SysUserDataRightForm, SysUserDataRight, Integer> {
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/dataRight/";
        //endregion your codes 2
    }

    //region your codes 3

    @RequestMapping("/editDataRights")
    @Token(generate = true)
    public String editDataRights(SysUserDataRightVo objectVo, Model model) {
        List<PlayerRank> playerRanks = ServiceSiteTool.playerRankService().allSearch(new PlayerRankListVo());
        model.addAttribute("playerRanks",playerRanks);
        model.addAttribute("subAccountName",objectVo.getSearch().getSubAccountName());

        hasPermissions(objectVo, model);

        Map<String,Map<Integer,SysUserDataRight>> sudr = getDataRightsByUserId(objectVo);
        model.addAttribute("sysUserDataRightMap",sudr);
        model.addAttribute("userId",objectVo.getSearch().getUserId());

        return getViewBasePath()+"Edit";
    }

    private void hasPermissions(SysUserDataRightVo objectVo, Model model) {
        String hasPermissions = objectVo.getSearch().getPermissions();
        List<String> moduleTypes = new ArrayList<>(0);
        boolean isCompanyDeposit = StringTool.contains(hasPermissions, SysResourceEnum.FUND_COMPANYDEPOSIT.getResId()+",");
        if (isCompanyDeposit) {
            moduleTypes.add(DataRightModuleType.COMPANYDEPOSIT.getCode());
        }
        model.addAttribute("isCompanyDeposit", isCompanyDeposit);
        boolean isOnlineDeposit = StringTool.contains(hasPermissions,SysResourceEnum.FUND_ONLINEDEPOSIT.getResId()+",");
        if (isOnlineDeposit) {
            moduleTypes.add(DataRightModuleType.ONLINEDEPOSIT.getCode());
        }
        model.addAttribute("isOnlineDeposit",isOnlineDeposit);
        boolean isPlayerWithdraw = StringTool.contains(hasPermissions,SysResourceEnum.FUND_PLAYERWITHDRAW.getResId()+",");
        if (isPlayerWithdraw) {
            moduleTypes.add(DataRightModuleType.PLAYERWITHDRAW.getCode());
        }
        model.addAttribute("isPlayerWithdraw",isPlayerWithdraw);

        objectVo.setModuleTypes(moduleTypes);
    }

    private Map<String,Map<Integer,SysUserDataRight>> getDataRightsByUserId(SysUserDataRightVo objectVo) {
        Map<String,Map<Integer,SysUserDataRight>> sysUserDataRightMap = new HashMap<>(0,1f);
        if (objectVo.getSearch().getUserId() != null) {
            List<SysUserDataRight> list = ServiceSiteTool.sysUserDataRightService().searchDataRightsByUserId(objectVo);
            Map<String,List<SysUserDataRight>> tempMap = CollectionTool.groupByProperty(list,SysUserDataRight.PROP_MODULE_TYPE,String.class);

            for (Map.Entry<String,List<SysUserDataRight>> entry :tempMap.entrySet()) {
                Map<Integer,SysUserDataRight> map = CollectionTool.toEntityMap(entry.getValue(),SysUserDataRight.PROP_ENTITY_ID,Integer.class);
                sysUserDataRightMap.put(entry.getKey(),map);
            }
        }

        return sysUserDataRightMap;
    }

    @RequestMapping("/saveAndUpdate")
    @ResponseBody
    @Token(valid = true)
    public Map saveAndUpdateDataRight(SysUserDataRightVo sysUserDataRightVo) {
        Map<String,Object> map = new HashMap<>(3,1f);
        //if (checkDataRights(sysUserDataRightVo, map)) return map;
        sysUserDataRightVo.setCreateUserId(SessionManager.getUserId());
        boolean isSuccess = ServiceSiteTool.sysUserDataRightService().saveAndUpdateDataRight(sysUserDataRightVo);
        if (isSuccess) {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_SUCCESS));
        } else {
            map.put("msg",LocaleTool.tranMessage(_Module.COMMON, MessageI18nConst.SAVE_FAILED));
        }
        map.put("state", isSuccess);
        return map;
    }

    private boolean checkDataRights(SysUserDataRightVo sysUserDataRightVo, Map<String, Object> map) {
        if (CollectionTool.isEmpty(sysUserDataRightVo.getCompanyDepositRank())
                && CollectionTool.isEmpty(sysUserDataRightVo.getOnlineDepositRank())
                && CollectionTool.isEmpty(sysUserDataRightVo.getPlayerWithdrawRank())) {
            map.put("msg", LocaleTool.tranMessage(_Module.COMMON,"请选择数据权限"));
            map.put("state", false);
            map.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
            return true;
        }
        return false;
    }

    //endregion your codes 3

}