package so.wwb.gamebox.mcenter.fund.controller;


import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.ArrayTool;
import org.soul.commons.query.Criterion;
import org.soul.commons.query.enums.Operator;
import org.soul.model.comet.vo.MessageVo;
import org.soul.model.security.privilege.vo.SysResourceListVo;
import org.soul.model.sys.po.SysDict;
import org.soul.model.sys.po.SysParam;
import org.soul.web.session.SessionManagerBase;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.mcenter.enmus.ListOpEnum;
import so.wwb.gamebox.mcenter.fund.form.VPlayerDepositSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.mcenter.tools.ServiceTool;
import so.wwb.gamebox.model.CacheBase;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.boss.enums.TemplateCodeEnum;
import so.wwb.gamebox.model.common.Const;
import so.wwb.gamebox.model.common.notice.enums.CometSubscribeType;
import so.wwb.gamebox.model.master.dataRight.DataRightModuleType;
import so.wwb.gamebox.model.master.fund.enums.RechargeTypeParentEnum;
import so.wwb.gamebox.model.master.fund.po.VPlayerDeposit;
import so.wwb.gamebox.model.master.fund.vo.PlayerRechargeVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerDepositListVo;
import so.wwb.gamebox.model.master.fund.vo.VPlayerDepositVo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 线上支付列表控制器
 *
 * @author fei
 *         2016-7-6 11:36:16
 */
@Controller
@RequestMapping("/fund/deposit/online")
public class OnlineDepositController extends BaseDepositController {

    @Override
    protected String getViewBasePath() {
        return "/fund/deposit/online/";
    }

    @Override
    protected VPlayerDepositListVo doList(VPlayerDepositListVo listVo, VPlayerDepositSearchForm form, BindingResult result, Model model) {
        // 初始化筛选条件
        this.initQuery(listVo);
        // 初始化ListVo
        super.initListVo(listVo);
        // 线上支付声音参数
        SysParam sysParam = ParamTool.getSysParam(SiteParamEnum.WARMING_TONE_ONLINEPAY);
        model.addAttribute("sysParam", sysParam);
        String templateCode = TemplateCodeEnum.fund_deposit_online_check.getCode();
        model.addAttribute("searchTempCode", templateCode);
        model.addAttribute("searchTemplates", CacheBase.getSysSearchTempByCondition(SessionManagerBase.getUserId(), TemplateCodeEnum.fund_deposit_online_check.getCode()));
        if (SessionManager.getOnlineVoiceNotice() != null) {
            sysParam.setActive(SessionManager.getOnlineVoiceNotice());
        }
        listVo.setTone(sysParam);
        listVo.setRechargeType(onlineRechargeType());

        String moduleType = DataRightModuleType.ONLINEDEPOSIT.getCode();
        listVo = getPlayerDeposit(listVo, moduleType, form, result, model);
        // 查询结果
        return listVo;
    }

    @Override
    protected void initQuery(VPlayerDepositListVo listVo) {
        listVo.getSearch().setRechargeTypeParent(RechargeTypeParentEnum.ONLINE_DEPOSIT.getCode());
        if (listVo.getQuery().getCriterions().length > 0) {
            listVo.getQuery().setCriterions(ArrayTool.add(listVo.getQuery().getCriterions(),
                    new Criterion(VPlayerDeposit.PROP_RECHARGE_TYPE_PARENT, Operator.EQ, listVo.getSearch().getRechargeTypeParent())));
        }
    }

    /**
     * 启用停用声音提醒
     */
    @RequestMapping({"/toneSwitch"})
    @ResponseBody
    public Map<String, Object> toneSwitch(@RequestParam("paramVal") String paramVal) {
        SessionManager.setOnlineVoiceNotice(paramVal);
        Map<String, Object> map = new HashMap<>(1,1f);
        map.put("state", true);
        return map;//toneSwitch(SiteParamEnum.WARMING_TONE_ONLINEPAY);
    }

    /**
     * 线上支付详情
     */
    @Override
    protected VPlayerDepositVo doView(VPlayerDepositVo vo, Model model) {
        return queryView(vo, model);
    }

    /**
     * 线上支付-筛选
     */
    @RequestMapping("/filter")
    public String filter(VPlayerDepositListVo listVo, Model model) {
        listVo.getSearch().setRechargeTypeParent(RechargeTypeParentEnum.ONLINE_DEPOSIT.getCode());

        listVo = initFilter(listVo);

        model.addAttribute("filters", listVo.getOperators());
        model.addAttribute("keyClassName", ListOpEnum.OnlineDepositListVo.getClassName());
        model.addAttribute("filterList", listVo.getFilterRows());
        model.addAttribute("jsonFilterList", JsonTool.toJson(listVo.getFilterRows()));
        model.addAttribute("goFilterUrl", getViewBasePath() + "list.html");

        return FILTER_URL;
    }

    /**
     * 查询人工存入类型
     *
     * @return
     */
    private Map<Object, SysDict> onlineRechargeType() {
        Map<String, SysDict> rechargeTypeMap = DictTool.get(so.wwb.gamebox.model.DictEnum.FUND_RECHARGE_TYPE);
        Map<Object, SysDict> manualRechargeTypeList = new HashMap<>();
        String rechargeTypeParent = RechargeTypeParentEnum.ONLINE_DEPOSIT.getCode();
        for (String key : rechargeTypeMap.keySet()) {

            if (rechargeTypeParent.equals(rechargeTypeMap.get(key).getParentCode())) {
                manualRechargeTypeList.put(key, rechargeTypeMap.get(key));
            }
        }
        return manualRechargeTypeList;
    }

    @RequestMapping("/confirmCheck")
    @ResponseBody
    public Map confirmOnlineCheck(PlayerRechargeVo vo) {
//        fundCheckReminder("fund/deposit/online/confirmCheck.html",vo.getSearch().getRechargeTypeParent());
        return confirmCheck(vo);
    }


}