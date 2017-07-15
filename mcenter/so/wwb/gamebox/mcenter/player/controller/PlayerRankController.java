package so.wwb.gamebox.mcenter.player.controller;

import org.soul.commons.collections.MapTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.exception.SystemException;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.ServletTool;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.commons.query.sort.Direction;
import org.soul.commons.support._Module;
import org.soul.web.controller.BaseCrudController;
import org.soul.web.session.SessionManagerBase;
import org.soul.web.validation.form.annotation.FormModel;
import org.soul.web.validation.form.js.JsRuleCreator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.iservice.master.player.IPlayerRankService;
import so.wwb.gamebox.mcenter.player.form.PlayerRankAddForm;
import so.wwb.gamebox.mcenter.player.form.PlayerRankForm;
import so.wwb.gamebox.mcenter.player.form.PlayerRankSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.Module;
import so.wwb.gamebox.model.RankStatusEnum;
import so.wwb.gamebox.model.master.content.enums.PayAccountStatusEnum;
import so.wwb.gamebox.model.master.content.po.PayAccount;
import so.wwb.gamebox.model.master.content.vo.PayAccountListVo;
import so.wwb.gamebox.model.master.enums.PlayerStatusEnum;
import so.wwb.gamebox.model.master.player.enums.PlayerRankEnum;
import so.wwb.gamebox.model.master.player.enums.UserAgentEnum;
import so.wwb.gamebox.model.master.player.po.PlayerRank;
import so.wwb.gamebox.model.master.player.po.VPayRank;
import so.wwb.gamebox.model.master.player.vo.PlayerRankListVo;
import so.wwb.gamebox.model.master.player.vo.PlayerRankVo;
import so.wwb.gamebox.model.master.player.vo.VPayRankVo;
import so.wwb.gamebox.model.master.setting.po.RakebackSet;
import so.wwb.gamebox.model.master.setting.vo.RakebackSetListVo;
import so.wwb.gamebox.web.common.token.Token;
import so.wwb.gamebox.web.common.token.TokenHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.*;


/**
 * 玩家层级表控制器
 * <p/>
 * Created by loong using soul-code-generator on 2015-7-14 15:40:56
 */
@Controller
//region your codes 1
@RequestMapping("/playerRank")
public class PlayerRankController extends BaseCrudController<IPlayerRankService, PlayerRankListVo, PlayerRankVo, PlayerRankSearchForm, PlayerRankForm, PlayerRank, Integer> {

    private static final Log LOG = LogFactory.getLog(PlayerRankController.class);
    private static final String PLAYER_RANK_ADD = "/player/playerrank/Add";
    private static final String PLAYER_RANK_EDIT = "/player/playerrank/Edit";
    private static final String PLAYER_RANK_ADD_PAY_LIMIT = "/player/playerrank/AddPayLimit";
    private static final String PLAYER_RANK_PAY_LIMIT = "/player/playerrank/PayLimit";
    private static final String PLAYER_RANK_ADD_MORE_ACCOUNT = "/player/playerrank/AddMoreAccount";
    private static final String PLAYER_RANK_ADD_WITHDRAWLIMIT = "/player/playerrank/WithdrawLimit";
//endregion your codes 1

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/player/playerrank/";
        //endregion your codes 2
    }
    //region your codes 3

    /**
     * @return Created by ke
     */
    @Override
    protected String getCreateViewName() {
        return PLAYER_RANK_ADD;
    }

    @Override
    @Token(generate = true)
    public String create(PlayerRankVo objectVo, Model model, HttpServletRequest request, HttpServletResponse response) {
        return super.create(objectVo, model, request, response);
    }

    /**
     * @param objectVo
     * @param model
     * @return Created by ke
     */
    @Override
    protected PlayerRankVo doCreate(PlayerRankVo objectVo, Model model) {
        objectVo = super.doCreate(objectVo, model);
        objectVo = this.getService().generationRankCode(objectVo);
        setRakebackList(objectVo);
        return objectVo;
    }

    private void setRakebackList(PlayerRankVo objectVo) {
        RakebackSetListVo rakebackSetListVo = new RakebackSetListVo();
        rakebackSetListVo.getQuery().setCriterions(new Criterion[]{new Criterion(RakebackSet.PROP_STATUS, Operator.EQ, UserAgentEnum.SET_STATUS_NORMAL.getCode())});
        rakebackSetListVo.setProperties(RakebackSet.PROP_ID, RakebackSet.PROP_NAME);
        objectVo.setRakebackSetList(ServiceTool.rakebackSetService().searchProperties(rakebackSetListVo));
    }

    @Override
    protected PlayerRankVo doSave(PlayerRankVo objectVo) {
        PlayerRank rank=objectVo.getResult();
        rank.setCreateUser(SessionManager.getUser().getId());
        rank.setCreateTime(new Date());
        rank.setRiskMarker(rank.getRiskMarker()!=null?true:false);
        rank.setBuiltIn(false);
        rank.setStatus(RankStatusEnum.NORMAL.getCode());
        rank.setFeeType(PlayerRankEnum.PROPORTION.getCode());
        rank.setReturnType(PlayerRankEnum.PROPORTION.getCode());
        objectVo.setResult(rank);
        objectVo = this.getService().generationRankCode(objectVo);
        objectVo = getService().saveNewRank(objectVo);
        return objectVo;
        //return super.doSave(objectVo);
    }

    /**
     * 只有层级下未含有玩家的才能删除
     * @param id
     * @return
     */
    @RequestMapping({"/rank_delete"})
    @ResponseBody
    public Map delete(Integer id) {
        PlayerRankVo playerRankVo = new PlayerRankVo();
        try {
            if (id == null) {
                throw new SystemException("please select delete rows！", new Object[0]);
            }
            PlayerRank playerRank = new PlayerRank();
            playerRank.setId(id);
            playerRank.setStatus(PlayerStatusEnum.ENABLE.getCode());
            playerRankVo.setResult(playerRank);
            boolean isSuccess = ServiceTool.playerRankService().deletePlayerRank(playerRankVo);
            playerRankVo.setSuccess(isSuccess);
            if (isSuccess) {
                playerRankVo.setOkMsg(LocaleTool.tranMessage(_Module.COMMON, "delete.success"));
            } else if (!isSuccess) {
                playerRankVo.setErrMsg(LocaleTool.tranMessage(Module.PLAYER, "playerRank.exist.player"));
            }
        } catch (Exception e) {
            LOG.error(e);
            playerRankVo.setSuccess(false);
            playerRankVo.setErrMsg(LocaleTool.tranMessage(_Module.COMMON, "delete.failed"));
        }
        return this.getVoMessage(playerRankVo);
    }

    /**
     * 跳转到支付限制-添加账号
     *
     * @param model
     * @return
     */
    @RequestMapping({"/addPayLimit"})
    public String addPayLimit(Model model, Integer rankId) {
        VPayRankVo vo = new VPayRankVo();
        vo.getSearch().setPlayerRankId(rankId);
        //根据层级查询支付账户列表
        List<VPayRank> list = this.getService().queryPayRank(vo);
        model.addAttribute("list", list);
        model.addAttribute("rankId", rankId);
        return PLAYER_RANK_ADD_PAY_LIMIT;
    }

    /**
     * 跳转到支付限制-参数设置
     *
     * @param model
     * @return
     */
    @RequestMapping({"/payLimit"})
    public String payLimit(Model model, String strPayId, Integer rankId) {
        VPayRankVo vo = new VPayRankVo();
        vo.getSearch().setPlayerRankId(rankId);
        vo.getSearch().setCreateUser(SessionManagerBase.getUserId());
        vo.getSearch().setCreateTime(new Date());
        List<Integer> li = new ArrayList<>();
        /*if (StringTool.isNotEmpty(strPayId)) {
            String[] str = strPayId.split(",");
            for (int j = 0; j < str.length; j++) {
                if (str[j] != null) {
                    li.add(Integer.parseInt(str[j]));
                }
                vo.getSearch().setPayIds(li);
            }
        }*/
        //this.getService().saveMoreAccount(vo);
        PlayerRankVo v = new PlayerRankVo();
        v.getSearch().setId(rankId);
        v = this.getService().get(v);
        v.setValidateRule(JsRuleCreator.create(PlayerRankSearchForm.class, "result"));
        v.setCurrency(SessionManager.getUser().getDefaultCurrency());
        //v.getResult().setIsFee(v.getResult().getIsFee()==null||!v.getResult().getIsFee()?false:true);
        //v.getResult().setIsReturnFee(v.getResult().getIsReturnFee()==null||!v.getResult().getIsReturnFee()?false:true);
        model.addAttribute("command", v);
        //model.addAttribute("strPayId", strPayId);
        return PLAYER_RANK_PAY_LIMIT;
    }

    /**
     * 保存支付限制
     *
     * @param vo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping({"/savePayLimit"})
    @ResponseBody
    public Map savePayLimit(PlayerRankVo vo, @FormModel("result") @Valid PlayerRankSearchForm form, BindingResult result) {
        if (!result.hasErrors()) {
            vo = this.getService().savePayLimit(vo);
        } else {
            vo.setSuccess(false);
        }
        return this.getVoMessage(vo);
    }
    //endregion your codes 2

    /**
     * 跳转到-添加更多收款账号页面
     *
     * @param model
     * @param strPayId
     * @param rankId
     * @return
     */
    @RequestMapping({"/addMoreAccount"})
    public String addMoreAccount(Model model, String strPayId, Integer rankId) {
        VPayRankVo vo = new VPayRankVo();
        //List<VPayRank> list = this.getService().queryAllPayAccount(vo);
        //上面的service方法查询的也是pay_account表
        List<PayAccount> list = queryAllPayAccount();
        model.addAttribute("list", list);
        model.addAttribute("rankId", rankId);
        model.addAttribute("strPayId", strPayId);
        return PLAYER_RANK_ADD_MORE_ACCOUNT;
    }

    private List<PayAccount> queryAllPayAccount(){
        PayAccountListVo listVo = new PayAccountListVo();
        listVo.setPaging(null);
        listVo.getSearch().setStatus(PayAccountStatusEnum.USING.getCode());
        listVo.getQuery().addOrder(PayAccount.PROP_TYPE, Direction.DESC).addOrder(PayAccount.PROP_ACCOUNT_TYPE,Direction.DESC).addOrder(PayAccount.PROP_BANK_CODE,Direction.ASC);
        listVo = ServiceTool.payAccountService().search(listVo);
        return listVo.getResult();
    }

    /**
     * 加载玩家层级提现限制
     *
     * @return Created by ke
     */
    @RequestMapping({"/withdrawLimit"})
    public String withdrawLimit(Model model, PlayerRankVo vo) {
        vo = this.getService().getNonItselfRank(vo);
        vo.setCurrency(SessionManager.getUser().getDefaultCurrency());
        model.addAttribute("command", vo);

        vo.setValidateRule(JsRuleCreator.create(PlayerRankForm.class, "result"));
        return PLAYER_RANK_ADD_WITHDRAWLIMIT;
    }
    /**
     * 保存并加载玩家层级提现限制
     *
     * @return Created by ke
     */
    @RequestMapping({"/saveAndWithdrawLimit"})
    public String saveAndWithdrawLimit(Model model, PlayerRankVo vo) {
       this.doPersist(vo);
        return this.withdrawLimit(model,vo);
    }
    @RequestMapping({"/copyParameter"})
    @ResponseBody
    public String copyParameter(Integer id, PlayerRankVo objectVo) {
        objectVo = this.getService().get(objectVo);
        String json = JsonTool.toJson(objectVo);
        return json;
    }

    /**
     * 提交并设置层级，先保存后获取ID
     * @param objectVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping({"/saveGetVo"})
    @ResponseBody
    public PlayerRankVo saveGetVo(PlayerRankVo objectVo, @FormModel("result") @Valid PlayerRankAddForm form, BindingResult result) {
        if (!result.hasErrors()) {
            if(objectVo.getResult().getId()==null){
                objectVo= super.doPersist(objectVo);
            }else {
                String[] array=new String[4];
                array[0] = PlayerRank.PROP_RANK_NAME;
                array[1] = PlayerRank.PROP_RISK_MARKER;
                array[2] = PlayerRank.PROP_REMARK;
                array[3] = PlayerRank.PROP_RAKEBACK_ID;
                objectVo.setProperties(array);
                objectVo= this.getService().updateRank(objectVo);
            }
            return objectVo;
        }else{
            objectVo.setSuccess(false);
        }
        return objectVo;
    }
    @RequestMapping({"/add"})
    @Token(generate = true)
    public String add(PlayerRankVo objectVo, Model model, HttpServletRequest request, HttpServletResponse response) {
        objectVo = this.doCreate(objectVo, model);
        model.addAttribute("command", objectVo);
        if(ServletTool.isAjaxSoulRequest(request)) {
            return this.getCreateViewName() + "Partial";
        } else {
            objectVo.setValidateRule(JsRuleCreator.create(PlayerRankAddForm.class, "result"));
            return this.getCreateViewName();
        }
    }
    @RequestMapping({"/childEdit"})
    @Token(generate = true)
    public String childEdit(PlayerRankVo objectVo, Model model, HttpServletRequest request, Integer id) {
        objectVo.getSearch().setId(id);
        objectVo = this.doEdit(objectVo, model);
        setRakebackList(objectVo);
        model.addAttribute("command", objectVo);
        objectVo.setValidateRule(JsRuleCreator.create(PlayerRankAddForm.class, "result"));
        return PLAYER_RANK_EDIT;
    }
    /**
     * 提交并设置层级
     * @param objectVo
     * @param form
     * @param result
     * @return
     */
    @RequestMapping({"/addPlayerRank"})
    @ResponseBody
    @Token(valid = true)
    public Map addPlayerRank(PlayerRankVo objectVo, @FormModel("result") @Valid PlayerRankAddForm form, BindingResult result) {
        Map map = new HashMap();
        if(!result.hasErrors()) {
            try{
                if(objectVo.getResult().getId()==null){
                    this.doPersist(objectVo);
                }else {
                    String[] array=new String[4];
                    array[0] = PlayerRank.PROP_RANK_NAME;
                    array[1] = PlayerRank.PROP_RISK_MARKER;
                    array[2] = PlayerRank.PROP_REMARK;
                    array[3] = PlayerRank.PROP_RAKEBACK_ID;
                    objectVo.setProperties(array);
                    this.getService().updateRank(objectVo);
                }

                map = this.getVoMessage(objectVo);
            }catch (Exception ex){
                map.put("state",false);
                map.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
                LOG.error(ex,"保存层级出错");
            }

        }else{
            objectVo.setSuccess(false);
        }
        map  = this.getVoMessage(objectVo);
        if(!MapTool.getBoolean(map,"state")){
            map.put(TokenHandler.TOKEN_VALUE,TokenHandler.generateGUID());
        }
        return map;
    }
    @RequestMapping({"/updateWithdrawLimit"})
    @ResponseBody
    public Map updateWithdrawLimit(PlayerRankVo objectVo, @FormModel("result") @Valid PlayerRankAddForm form, BindingResult result) {
        String[] array=new String[18];
        array[0] = PlayerRank.PROP_WITHDRAW_TIME_LIMIT;
        array[1] = PlayerRank.PROP_WITHDRAW_FREE_COUNT;
        array[2] = PlayerRank.PROP_IS_WITHDRAW_LIMIT;
        array[3] = PlayerRank.PROP_WITHDRAW_MAX_FEE;
        array[4] = PlayerRank.PROP_WITHDRAW_COUNT;
        array[5] = PlayerRank.PROP_WITHDRAW_CHECK_STATUS;
        array[6] = PlayerRank.PROP_WITHDRAW_EXCESS_CHECK_STATUS;
        array[7] = PlayerRank.PROP_WITHDRAW_MAX_NUM;
        array[8] = PlayerRank.PROP_WITHDRAW_MIN_NUM;
        array[9] = PlayerRank.PROP_WITHDRAW_NORMAL_AUDIT;
        array[10] = PlayerRank.PROP_WITHDRAW_ADMIN_COST;
        array[11] = PlayerRank.PROP_WITHDRAW_RELAX_CREDIT;
        array[12] = PlayerRank.PROP_WITHDRAW_DISCOUNT_AUDIT;
        array[13] = PlayerRank.PROP_WITHDRAW_FEE_TYPE;
        array[14] = PlayerRank.PROP_WITHDRAW_CHECK_TIME;
        array[15] = PlayerRank.PROP_WITHDRAW_EXCESS_CHECK_NUM;
        array[16] = PlayerRank.PROP_WITHDRAW_EXCESS_CHECK_TIME;
        array[17] = PlayerRank.PROP_WITHDRAW_FEE_NUM;
        objectVo.setProperties(array);
        this.getService().updateOnly(objectVo);
        return this.getVoMessage(objectVo);
    }
    //endregion your codes 3
}