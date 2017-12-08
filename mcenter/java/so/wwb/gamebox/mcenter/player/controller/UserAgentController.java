package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.collections.CollectionQueryTool;
import org.soul.commons.collections.CollectionTool;
import org.soul.commons.collections.ListTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.query.sort.Order;
import org.soul.model.security.privilege.po.SysUser;
import org.soul.model.security.privilege.po.SysUserStatus;
import org.soul.model.security.privilege.so.SysUserSo;
import org.soul.model.security.privilege.vo.SysUserListVo;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.model.sys.po.SysParam;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.enums.UserTypeEnum;
import so.wwb.gamebox.model.master.player.enums.UserAgentEnum;
import so.wwb.gamebox.model.master.player.vo.PlayerRankVo;
import so.wwb.gamebox.model.master.player.vo.UserAgentVo;
import so.wwb.gamebox.model.master.setting.po.FieldSort;
import so.wwb.gamebox.web.agent.controller.BaseUserAgentController;

import java.util.ArrayList;
import java.util.List;


/**
 * 代理子账号控制器
 *
 * @author loong
 * @time 2015-9-6 9:48:09
 */
@Controller
//region your codes 1
@RequestMapping("/userAgent")
public class UserAgentController extends BaseUserAgentController {

    //endregion your codes 1
    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/player/agent/";
        //endregion your codes 2
    }

    //region your codes 3

    public void createOrEdit(UserAgentVo userAgentVo){
        /*站长子账号*/
        String userType = SessionManager.getUser().getUserType();
        if(userType.equals(UserTypeEnum.MASTER_SUB.getCode())){
            /*只有站长子账号 可以选择总代 （user_agent parent_id == null）*/
            userAgentVo.setEditSelectAgent(true);
        } else if(userType.equals(UserTypeEnum.AGENT.getCode())){
            /*总代 及 代理*/
            if(SessionManager.getUser().getOwnerId() == null){
                /*总代*/
                userAgentVo.getSearch().setUserId(SessionManager.getUserId());
            }else{
                /*代理子账号*/
                userAgentVo.getSearch().setUserId(SessionManager.getUser().getOwnerId());
            }
            getService().getForAgent(userAgentVo);
        }

        /*层级*/
        /*PlayerRankListVo playerRankListVo = new PlayerRankListVo();

        playerRankListVo.getQuery().setCriterions(new Criterion[]{
                new Criterion(PlayerRank.PROP_STATUS, Operator.EQ, RankStatusEnum.NORMAL.getCode()),
                new Criterion(PlayerRank.PROP_WITHDRAW_MAX_NUM, Operator.IS_NOT_NULL,null),
                new Criterion(PlayerRank.PROP_ONLINE_PAY_MAX,Operator.IS_NOT_NULL,null)
        });

        playerRankListVo.setProperties(PlayerRank.PROP_ID, PlayerRank.PROP_RANK_NAME);

        userAgentVo.setSomePlayerRanks(ServiceTool.playerRankService().searchProperties(playerRankListVo));*/

        SysParam param= ParamTool.getSysParam(SiteParamEnum.SETTING_REG_SETTING_FIELD_SETTING_AGENT);
        List<FieldSort> fieldSortAll = (List<FieldSort>) JsonTool.fromJson(param.getParamValue(),JsonTool.createCollectionType(ArrayList.class,FieldSort.class));

        /*使用中的注册项*/
        List<FieldSort> fieldSorts = CollectionQueryTool.andQuery(fieldSortAll, ListTool.newArrayList(new Criterion(FieldSort.PROP_IS_REGFIELD, Operator.NE, "2"),
                new Criterion(FieldSort.PROP_NAME, Operator.NOT_IN, userAgentVo.getDefaultCode())), Order.asc(FieldSort.PROP_SORT));
        /*List<String> fieldNameList = CollectionTool.extractToList(fieldSorts, FieldSort.PROP_NAME);
        userAgentVo.setFieldNameList(fieldNameList);*/
        /*必填的注册项*/
        List<FieldSort> requiredFieldSorts = CollectionQueryTool.andQuery(fieldSorts, ListTool.newArrayList(new Criterion(FieldSort.PROP_IS_REGFIELD, Operator.NE, "2"), new Criterion(FieldSort.PROP_IS_REQUIRED, Operator.NE, "2")), Order.asc(FieldSort.PROP_SORT));

        /*必填的注册项name的json*/
        String required = JsonTool.toJson(CollectionTool.extractToList(requiredFieldSorts, FieldSort.PROP_NAME));

        userAgentVo.setRequired(required);
//        userAgentVo.setFieldSorts(fieldSorts);
        userAgentVo.setFieldSorts(fieldSorts);

        /* 时区 */
        userAgentVo.setTimeZone(getDefaultTimezone());

        /* 联系方式 */
        userAgentVo.setContact(DictTool.get(DictEnum.COMMON_CONTACT_WAY_TYPE));

        /*查出所有总代*/


        SysUserListVo sysUserListVo = new SysUserListVo();
        sysUserListVo.setSearch(new SysUserSo());
        sysUserListVo.setProperties(SysUser.PROP_ID, SysUser.PROP_USERNAME);


        if(userAgentVo.getResult().getParentId()!=null){
            SysUserVo sysUserVo = new SysUserVo();
            sysUserVo.getSearch().setId(userAgentVo.getResult().getParentId());
            sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
            if(sysUserVo!=null&&sysUserVo.getResult()!=null){
                userAgentVo.setTopAgentName(sysUserVo.getResult().getUsername());
            }else{
                userAgentVo.setTopAgentName("");
            }
        }
        userAgentVo.setDictConstellation(DictTool.get(DictEnum.COMMON_CONSTELLATION));
        if(UserAgentEnum.EDIT_TYPE_SUB_AGENT.getCode().equals(userAgentVo.getEditType())){
            sysUserListVo.getQuery().setCriterions(new Criterion[]{new Criterion(SysUser.PROP_ID, Operator.EQ, userAgentVo.getSearch().getParentId())});
            userAgentVo.setTopAgents(ServiceTool.sysUserService().searchProperties(sysUserListVo));
            userAgentVo.setAgentUserId(userAgentVo.getSearch().getParentId());

            if(userAgentVo.getResult().getParentId()!=null){
                UserAgentVo parentAgent = new UserAgentVo();
                parentAgent.getSearch().setId(userAgentVo.getResult().getParentId());
                parentAgent = ServiceTool.userAgentService().get(parentAgent);
                if(parentAgent.getResult()!=null&&parentAgent.getResult().getPlayerRankId()!=null){
                    PlayerRankVo playerRankVo = new PlayerRankVo();
                    playerRankVo.getSearch().setId(parentAgent.getResult().getPlayerRankId());
                    userAgentVo.setSomePlayerRanks(ServiceTool.playerRankService().queryUsableRankList(playerRankVo));
                }
            }

        }else{
            sysUserListVo.getQuery().setCriterions(new Criterion[]{new Criterion(SysUser.PROP_USER_TYPE, Operator.EQ, UserTypeEnum.TOP_AGENT.getCode()),
                    new Criterion(SysUser.PROP_STATUS,Operator.EQ,SysUserStatus.NORMAL.getCode())});
            userAgentVo.setTopAgents(ServiceTool.sysUserService().searchProperties(sysUserListVo));

            PlayerRankVo playerRankVo = new PlayerRankVo();
            userAgentVo.setSomePlayerRanks(ServiceTool.playerRankService().queryUsableRankList(playerRankVo));

        }
        getAnswer(userAgentVo);
    }
    //endregion your codes 3

}