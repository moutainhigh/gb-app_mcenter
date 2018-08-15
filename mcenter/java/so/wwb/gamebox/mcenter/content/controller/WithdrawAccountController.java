package so.wwb.gamebox.mcenter.content.controller;


import org.soul.commons.collections.CollectionTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.dict.DictTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.locale.LocaleTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.query.sort.Direction;
import org.soul.commons.security.CryptoTool;
import org.soul.iservice.pay.IOnlinePayService;
import org.soul.model.pay.vo.OnlinePayVo;
import org.soul.model.sys.po.SysParam;
import org.soul.web.controller.BaseCrudController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.iservice.master.content.IWithdrawAccountService;
import so.wwb.gamebox.mcenter.content.form.WithdrawAccountForm;
import so.wwb.gamebox.mcenter.content.form.WithdrawAccountSearchForm;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.BossParamEnum;
import so.wwb.gamebox.model.DictEnum;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.company.enums.BankEnum;
import so.wwb.gamebox.model.company.enums.BankPayTypeEnum;
import so.wwb.gamebox.model.company.enums.ResolveStatusEnum;
import so.wwb.gamebox.model.company.po.Bank;
import so.wwb.gamebox.model.company.sys.po.SysDomain;
import so.wwb.gamebox.model.company.sys.vo.SysDomainListVo;
import so.wwb.gamebox.model.company.vo.BankListVo;
import so.wwb.gamebox.model.master.content.enums.PayAccountStatusEnum;
import so.wwb.gamebox.model.master.content.po.WithdrawAccount;
import so.wwb.gamebox.model.master.content.vo.WithdrawAccountListVo;
import so.wwb.gamebox.model.master.content.vo.WithdrawAccountVo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * 出款(代付)账户表控制器
 *
 * @author linsen
 * @time 2018-8-10 14:57:24
 */
@Controller
//region your codes 1
@RequestMapping("/withdrawAccount")
public class WithdrawAccountController extends BaseCrudController<IWithdrawAccountService, WithdrawAccountListVo, WithdrawAccountVo, WithdrawAccountSearchForm, WithdrawAccountForm, WithdrawAccount, Integer> {
//endregion your codes 1

    private static final Log LOG = LogFactory.getLog(WithdrawAccountController.class);

    @Override
    protected String getViewBasePath() {
        //region your codes 2
        return "/content/withdrawAccount/";
        //endregion your codes 2
    }

    //region your codes 3
    @Override
    protected WithdrawAccountListVo doList(WithdrawAccountListVo listVo,WithdrawAccountSearchForm form, BindingResult result, Model model) {
        listVo = super.doList(listVo ,form, result, model);
        Map<String, Serializable> status = DictTool.get(DictEnum.PAY_ACCOUNT_STATUS);
        status.remove(PayAccountStatusEnum.DELETED.getCode());
        status.remove(PayAccountStatusEnum.FREEZE.getCode());
        model.addAttribute("statusMap", status);
        return listVo;
    }
    //endregion your codes 3


    @Override
    protected WithdrawAccountVo doEdit(WithdrawAccountVo objectVo, Model model) {
        model.addAttribute("bankList", getBankList());
        objectVo = this.getService().get(objectVo);
        objectVo.setSysDomains(getSysDomainList());
        String channelJson = objectVo.getResult().getChannelJson();
        List<Map<String, String>> channelJsonList = JsonTool.fromJson(channelJson, List.class);
        if (CollectionTool.isNotEmpty(channelJsonList)) {
            for (Map<String, String> map : channelJsonList) {
                if (map.get("column").equals("key")) {
                    String key = map.get("value");
                    CryptoTool.aesEncrypt(key);
                    map.put("value", CryptoTool.aesDecrypt(key));
                }
            }
        }
        model.addAttribute("channelJson", channelJsonList);
        return objectVo;
    }

    @Override
    protected WithdrawAccountVo doCreate(WithdrawAccountVo objectVo, Model model) {
        objectVo = super.doCreate(objectVo, model);
        objectVo = getWithdrawAccountCode(objectVo);
        objectVo.setSysDomains(getSysDomainList());
        model.addAttribute("bankList", getBankList());
        return objectVo;
    }


    @Override
    public Map delete(WithdrawAccountVo objectVo, Integer id) {
        doDelete(objectVo);
        return getVoMessage(objectVo);
    }

    @Override
    protected void doDelete(WithdrawAccountVo objectVo) {
        if (CollectionTool.isEmpty(objectVo.getIds())) {
            return;
        }
        String status = PayAccountStatusEnum.DELETED.getCode();
        List<WithdrawAccount> list = new ArrayList<>(objectVo.getIds().size());
        WithdrawAccount withdrawAccount;
        for (Integer id : objectVo.getIds()) {
            withdrawAccount = new WithdrawAccount();
            withdrawAccount.setId(id);
            withdrawAccount.setStatus(status);
            withdrawAccount.setUpdateUser(SessionManager.getUserId());
            withdrawAccount.setUpdateTime(new Date());
            list.add(withdrawAccount);
        }
        objectVo.setEntities(list);
        objectVo.setProperties(WithdrawAccount.PROP_STATUS,WithdrawAccount.PROP_UPDATE_USER,WithdrawAccount.PROP_UPDATE_TIME);
        this.getService().batchUpdateOnly(objectVo);
        LOG.info("站点ID：{0}，删除出款账户id：{1}，操作人：{2}",SessionManager.getSiteId(),objectVo.getIds(),SessionManager.getUserName());
    }


    @Override
    protected WithdrawAccountVo doView(WithdrawAccountVo objectVo, Model model) {
        objectVo = this.getService().get(objectVo);
        String channelJson = objectVo.getResult().getChannelJson();
        List<Map<String, String>> channelJsonList = JsonTool.fromJson(channelJson, List.class);
        if (CollectionTool.isNotEmpty(channelJsonList)) {
            for (Map<String, String> map : channelJsonList) {
                if (map.get("column").equals("key")) {
                    String key = map.get("value");
                    CryptoTool.aesEncrypt(key);
                    map.put("value", CryptoTool.aesDecrypt(key));
                }
            }
        }
        model.addAttribute("channelJson", channelJsonList);
        return objectVo;
    }


    /**
     * 出款账户代号
     *
     * @param objectVo
     * @return
     */
    private WithdrawAccountVo getWithdrawAccountCode(WithdrawAccountVo objectVo) {
        WithdrawAccount withdrawAccount = new WithdrawAccount();
        objectVo.setResult(withdrawAccount);
        objectVo = this.getService().getCode(objectVo);
        return objectVo;
    }

    /**
     * 获取出款渠道
     *
     * @return
     */
    private List<Bank> getBankList(){
        List<Bank> list = new ArrayList();
        List<Bank> bankList = getWithdrawBankList(BankPayTypeEnum.WITHDRAW_PAYMENT.getCode());
        if (bankList != null && bankList.size() > 0) {
            for (Bank bank : bankList) {
                //bankName国际化处理
                String interlingua = LocaleTool.tranDict(DictEnum.BANKNAME, bank.getBankName());
                if (StringTool.isNotEmpty(interlingua)) {
                    bank.setInterlinguaBankName(interlingua);
                } else {
                    bank.setInterlinguaBankName(bank.getBankShortName());
                }
                list.add(bank);
            }
        }
       return list;
    }

    /**
     * 获取出款银行列表
     *
     * @param paytype
     * @return
     */
    private List<Bank> getWithdrawBankList(String paytype) {
        BankListVo bankListVo = new BankListVo();
        bankListVo.getSearch().setType(BankEnum.TYPE_ONLINE.getCode());
        bankListVo.getSearch().setIsUse(true);
        bankListVo.setPaging(null);
        bankListVo.getSearch().setPayType(paytype);
        bankListVo.getQuery().addOrder(Bank.PROP_ORDER_NUM, Direction.ASC).addOrder(Bank.PROP_BANK_NAME, Direction.ASC);
        bankListVo = ServiceTool.bankService().queryBankByPayType(bankListVo);
        return bankListVo.getResult();
    }

    /**
     * 获取站点支付域名
     *
     * @return
     */
    private List<SysDomain> getSysDomainList() {
        //查询该站点的支付域名列表
        SysParam sysParam = ParamTool.getSysParam(BossParamEnum.CONTENT_DOMAIN_TYPE_ONLINEPAY);
        if (sysParam == null) {
            return null;
        }
        SysDomainListVo sysDomainListVo = new SysDomainListVo();
        sysDomainListVo.getSearch().setSiteId(SessionManager.getSiteId());
        sysDomainListVo.getSearch().setPageUrl(sysParam.getParamValue());
        sysDomainListVo.getSearch().setType(null);
        sysDomainListVo.setPaging(null);
        sysDomainListVo.getSearch().setResolveStatus(ResolveStatusEnum.SUCCESS.getCode());
        sysDomainListVo = ServiceTool.sysDomainService().search(sysDomainListVo);
        return sysDomainListVo.getResult();
    }

    /**
     * 查询接口需要的字段
     */
    @RequestMapping({"/queryChannelColumn"})
    @ResponseBody
    public WithdrawAccountVo queryChannelColumn(OnlinePayVo onlinePayVo, WithdrawAccountVo vo) {
        if (StringTool.isBlank(onlinePayVo.getChannelCode())) {
            return null;
        }
        IOnlinePayService onlinePayService = ServiceTool.onlinePayService();
        //获取接口参数
        onlinePayVo = onlinePayService.getAccountList(onlinePayVo);
        vo.setPayApiParams(onlinePayVo.getAccountParams());
        return vo;
    }

    @Override
    protected WithdrawAccountVo doSave(WithdrawAccountVo objectVo) {
        WithdrawAccount withdrawAccount = objectVo.getResult();
        withdrawAccount.setStatus(PayAccountStatusEnum.USING.getCode());
        withdrawAccount.setCreateUser(SessionManager.getUserId());
        withdrawAccount.setCreateTime(new Date());
        withdrawAccount.setWithdrawCount(0);
        withdrawAccount.setWithdrawTotal(0.0);
        setParam(withdrawAccount);
        return this.getService().saveAccount(objectVo);
    }

    @Override
    protected WithdrawAccountVo doUpdate(WithdrawAccountVo objectVo) {
        WithdrawAccount withdrawAccount = objectVo.getResult();
        withdrawAccount.setUpdateUser(SessionManager.getUserId());
        withdrawAccount.setUpdateTime(new Date());
        setParam(withdrawAccount);
        return this.getService().saveAccount(objectVo);
    }


    /**
     * 设置接口参数
     *
     * @param withdrawAccount
     */
    private void setParam(WithdrawAccount withdrawAccount) {
        ArrayList<Map<String, String>> arrayList = JsonTool.fromJson(withdrawAccount.getChannelJson(), ArrayList.class);
        for (Map<String, String> map : arrayList) {
            if (map.get("column").equals("key")) {
                String key = map.get("value");
                CryptoTool.aesEncrypt(key);
                map.put("value", CryptoTool.aesEncrypt(key));
            }
        }
        withdrawAccount.setChannelJson(JsonTool.toJson(arrayList));
    }

    /**
     * 启用/禁用出款账户
     *
     * @param vo
     * @param state
     * @return
     */
    @RequestMapping("/changeStatus")
    @ResponseBody
    public Map<String, Object> changeStatus(WithdrawAccountVo vo, Boolean state) {
        Integer accountId = vo.getResult().getId();
        if (accountId == null){
            LOG.error("站点：{0}，更新出款账户状态失败，出款账户ID为空",SessionManager.getSiteId());
            vo.setSuccess(false);
            return getVoMessage(vo);
        }
        String status = PayAccountStatusEnum.DISABLED.getCode();
        if (state != null && state) {
            status = PayAccountStatusEnum.USING.getCode();
        }
        vo.getResult().setStatus(status);
        vo.setProperties(WithdrawAccount.PROP_STATUS);
        vo = this.getService().updateOnly(vo);
        LOG.error("站点：{0}，更新出款账户ID：{1}，状态为：{2}，是否更新成功：{3}，操作人：{4}",
                SessionManager.getSiteId(),accountId,status,vo.isSuccess(),SessionManager.getUserName());
        return getVoMessage(vo);
    }

    /**
     * 验证该名称是否存在
     */
    @RequestMapping("/checkWithdrawName")
    @ResponseBody
    public boolean checkWithdrawName(@RequestParam("result.withdrawName") String withdrawName, @RequestParam("result.id") Integer id, @RequestParam("result.bankCode") String bankCode) {
        WithdrawAccountListVo listVo = new WithdrawAccountListVo();
        listVo.getSearch().setWithdrawName(withdrawName);
        listVo.getSearch().setId(id);
        listVo.getSearch().setBankCode(bankCode);
        boolean isExist = this.getService().withdrawNameIsExist(listVo);
        return !isExist;
    }

    /**
     * 远程验证 - account唯一验证
     */
    @RequestMapping("/checkChannel")
    @ResponseBody
    public boolean checkChannel(@RequestParam("result.bankCode") String channel, @RequestParam("result.account") String account, @RequestParam("result.id") Integer id) {
        WithdrawAccountListVo listVo = new WithdrawAccountListVo();
        listVo.getSearch().setAccount(account);
        listVo.getSearch().setBankCode(channel);
        if (id != null) {
            listVo.getSearch().setId(Integer.valueOf(id));
        }
        return this.getService().checkAccountUniqueUnderBankCode(listVo);
    }
}