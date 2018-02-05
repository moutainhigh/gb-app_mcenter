package so.wwb.gamebox.mcenter.fund.controller;

import org.soul.commons.collections.MapTool;
import org.soul.commons.data.json.JsonTool;
import org.soul.commons.init.context.CommonContext;
import org.soul.commons.lang.DateTool;
import org.soul.commons.lang.string.StringTool;
import org.soul.commons.log.Log;
import org.soul.commons.log.LogFactory;
import org.soul.commons.net.IpTool;
import org.soul.commons.net.ServletTool;
import org.soul.model.pay.enums.CommonFieldsConst;
import org.soul.model.pay.enums.PayResultStatus;
import org.soul.model.pay.vo.OnlinePayVo;
import org.soul.model.security.privilege.vo.SysUserVo;
import org.soul.model.sys.po.SysParam;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import so.wwb.gamebox.common.dubbo.ServiceSiteTool;
import so.wwb.gamebox.common.dubbo.ServiceTool;
import so.wwb.gamebox.mcenter.session.SessionManager;
import so.wwb.gamebox.model.ParamTool;
import so.wwb.gamebox.model.SiteParamEnum;
import so.wwb.gamebox.model.company.sys.po.SysSite;
import so.wwb.gamebox.model.company.sys.vo.SysSiteListVo;
import so.wwb.gamebox.model.master.fund.enums.onlineWithdrawStatusEnum;
import so.wwb.gamebox.model.master.fund.po.PlayerWithdraw;
import so.wwb.gamebox.model.master.fund.vo.PlayerWithdrawVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * 易收付出款
 *
 */
@Controller
@RequestMapping("/onlineWithdraw")
public class OnlineWithdrawController {
    //记录日志
    private static final Log LOG = LogFactory.getLog(OnlineWithdrawController.class);

    /**
     * 后台通知
     */
    private static final String PAY_BCB = "bcb";



    /**
     * 线上支付后台调用
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping({"/bcb"})
    public String doPayBackCallback(HttpServletRequest request, Model model, HttpServletResponse response) {
        return handlePayByParameter(request, response, model, PAY_BCB);
    }

    /**
     * @param c        channel_code
     * @param m        商户号
     * @param request
     * @param response
     * @return
     */
    @RequestMapping({"/{c}/{m}/bcb"})
    public String cmbcb(@PathVariable(value = "c") String c, @PathVariable(value = "m") String m, HttpServletRequest request, HttpServletResponse response) {
        return handlePayBack(request, c, m, null, response);
    }

    /**
     * @param c        channel_code
     * @param m        商户号
     * @param o        订单号
     * @param request
     * @param response
     * @return
     */
    @RequestMapping({"/{c}/{m}/{o}/bcb"})
    public String cmobcb(@PathVariable(value = "c") String c, @PathVariable(value = "m") String m, @PathVariable(value = "o") String o, HttpServletRequest request, HttpServletResponse response) {
        return handlePayBack(request, c, m, o, response);
    }


    @RequestMapping("/withdraw")
    public void withdraw(PlayerWithdrawVo vo, HttpServletRequest request, Model model) {
        LOG.info("易收付出款：交易号[{0}]", vo.getSearch().getTransactionNo());
        if (StringTool.isBlank(vo.getSearch().getTransactionNo())) {
            return;
        }
        vo = ServiceSiteTool.playerWithdrawService().getByTransactionNo(vo);
        if (vo.getResult() == null) {
            return;
        }
        String onlineWithdrawStatus = vo.getResult().getOnlineWithdrawStatus();
        if (onlineWithdrawStatusEnum.SUCCESS.getCode().equals(onlineWithdrawStatus) ||onlineWithdrawStatusEnum.DEAL.getCode().equals(onlineWithdrawStatus)) {
            return;
        }
        doWithdraw(model, request, vo);
        return;
    }

    /**
     * 获取头部信息
     *
     * @param request
     * @return
     */
    private Map<String, String> getHeadersInfo(HttpServletRequest request) {
        Map<String, String> map = new HashMap<String, String>();
        try {
            Enumeration headerNames = request.getHeaderNames();
            while (headerNames.hasMoreElements()) {
                String key = (String) headerNames.nextElement();
                String value = request.getHeader(key);
                map.put(key, value);
            }
        } catch (Exception e) {
            LOG.error("支付获取头部信息出错");
        }

        return map;
    }


    /**
     * 处理出款结果
     *
     * @param onlinePayVo
     */
    private void onlineWithdrawResult(OnlinePayVo onlinePayVo) {
        String orderId = onlinePayVo.getCommonFieldMap().get(CommonFieldsConst.ORDER_ID);
        if (StringTool.isBlank(orderId)) {
            return;
        }
        String siteCode = StringTool.substring(orderId, 7, 11);
        Integer siteId = CommonContext.get().getSiteId();
        PlayerWithdrawVo playerWithdrawVo = new PlayerWithdrawVo();
        LOG.info("通过订单号{0}截取的siteCode[{1}],上下文获取的siteCode[{2}]", orderId, siteCode, CommonContext.get().getSiteCode());
        if (!siteCode.equalsIgnoreCase(CommonContext.get().getSiteCode())) {
            SysSite site = getSiteByCode(siteCode);
            LOG.info("通过订单号{0}获取站点siteId[{1}],上下文获取的siteId[{2}]", orderId, site == null ? null : site.getId(), CommonContext.get().getSiteId());
            if (site != null && siteId != null && site.getId().intValue() != siteId) {
                playerWithdrawVo._setDataSourceId(site.getId());
                LOG.info("通过订单号{0}重新设置vo的siteId[{1}]", orderId, site.getId());
            }
        }
        playerWithdrawVo.getResult().setTransactionNo(orderId);
        playerWithdrawVo = ServiceSiteTool.playerWithdrawService().getByTransactionNo(playerWithdrawVo);
        //处理存款结果
        playerWithdrawVo.getResult().setOnlineWithdrawStatus(onlineWithdrawStatusEnum.SUCCESS.getCode());
        ServiceSiteTool.playerWithdrawService().updateWithdraw(playerWithdrawVo);

    }


    private SysSite getSiteByCode(String code) {
        SysSiteListVo sysSiteListVo = new SysSiteListVo();
        sysSiteListVo.getSearch().setCode(StringTool.upperCase(code));
        return ServiceTool.sysSiteService().searchCodeToid(sysSiteListVo);
    }

    /**
     * 获取出款账户
     * @return
     */
    private Map getWithdrawAccountMap(){
        SysParam siteParam = ParamTool.getSysParam(SiteParamEnum.WITHDRAW_ACCOUNT);
        Map<String,String> withdrawAccountMap = JsonTool.fromJson(siteParam.getParamValue(),Map.class);
        return withdrawAccountMap;
    }

    /**
     * 调用第三方出款接口
     * @param
     * @param model
     */
    public PlayerWithdrawVo doWithdraw(Model model, HttpServletRequest request, PlayerWithdrawVo vo) {
        PlayerWithdraw playerWithdraw = vo.getResult();
        playerWithdraw.setWithdrawCheckUserId(SessionManager.getUserId());
        playerWithdraw.setWithdrawCheckTime(new Date());

        Map<String,String> withdrawAccountMap = getWithdrawAccountMap();
        OnlinePayVo onlinePayVo = new OnlinePayVo();
        onlinePayVo.setChannelCode(MapTool.getString(withdrawAccountMap,"withdrawChannel"));
        onlinePayVo.setApiType("doWithdraw");

        //出款信息
        Map<String, String> commonFieldMap = joinRecharge(vo, request, withdrawAccountMap);
        commonFieldMap.putAll(withdrawAccountMap);

        onlinePayVo.setCommonFieldMap(commonFieldMap);
        try {
            onlinePayVo = ServiceTool.onlinePayService().callPay(onlinePayVo);
        } catch (Exception e) {
            LOG.error(e);
        }

        if (PayResultStatus.SUCCESS == onlinePayVo.getPayResultStatus()) {
            //提现请求成功，将订单状态置为出款处理中
            playerWithdraw.setOnlineWithdrawStatus(onlineWithdrawStatusEnum.DEAL.getCode());
            vo=ServiceSiteTool.playerWithdrawService().updateWithdraw(vo);
        }
        return vo;
    }

    /**
     * 提现-组装信息
     *
     * @param
     * @param request
     * @return
     */
    private Map<String, String> joinRecharge(PlayerWithdrawVo vo, HttpServletRequest request, Map withdrawAccountMap) {
        PlayerWithdraw withdraw = vo.getResult();
        SysUserVo sysUserVo = new SysUserVo();
        sysUserVo.getSearch().setId(withdraw.getPlayerId());
        sysUserVo = ServiceTool.sysUserService().get(sysUserVo);
        String withdrawChannel = MapTool.getString(withdrawAccountMap,"withdrawChannel");
        String merchantCode = MapTool.getString(withdrawAccountMap,"merchantCode");
        String platformId = MapTool.getString(withdrawAccountMap,"platformId");
        String key = MapTool.getString(withdrawAccountMap,"key");
        Map<String, String> commonFieldMap = new HashMap<>(7, 1f);
        commonFieldMap.put(CommonFieldsConst.CHANNEL_CODE, withdrawChannel);//选择收款渠道
        commonFieldMap.put(CommonFieldsConst.MERCHANT_CODE, merchantCode);
        commonFieldMap.put(CommonFieldsConst.BANK_ID, withdraw.getPayeeBank());//玩家支付银行
        commonFieldMap.put(CommonFieldsConst.ORDER_MONEY, new DecimalFormat("0.00").format(withdraw.getWithdrawActualAmount()));
        commonFieldMap.put(CommonFieldsConst.ORDER_DATE, DateTool.formatDate(withdraw.getWithdrawCheckTime(), DateTool.yyyyMMddHHmmss));
        commonFieldMap.put(CommonFieldsConst.ORDER_ID, withdraw.getTransactionNo());
        commonFieldMap.put(CommonFieldsConst.CURRENCY, sysUserVo.getResult().getDefaultCurrency());//玩家主货币
        commonFieldMap.put(CommonFieldsConst.IP, ServletTool.getIpAddr(request));
        commonFieldMap.put(CommonFieldsConst.KEY,key);
        commonFieldMap.put("userName", sysUserVo.getResult().getUsername());
        commonFieldMap.put("userId", String.valueOf(withdraw.getPlayerId()));
        commonFieldMap.put("platformId",platformId);
        commonFieldMap.put("bankCardNum",withdraw.getPayeeBankcard());
        commonFieldMap.put("bankCarkUsername",withdraw.getPayeeName());
        return commonFieldMap;
    }

    /**
     * 处理后台回调
     *
     * @param request
     * @param channel
     * @param merNo
     * @param orderId
     * @param response
     * @return
     */
    private String handlePayBack(HttpServletRequest request, String channel, String merNo, String orderId, HttpServletResponse response) {
        OnlinePayVo onlinePayVo = this.doPayCallBack(request, channel, merNo, orderId, PAY_BCB);
        Map<String, String> commonFieldMap = onlinePayVo.getCommonFieldMap();
        String orderMoney = onlinePayVo.getCommonFieldMap().get(CommonFieldsConst.ORDER_MONEY);
        LOG.debug("收到回调后台通知：订单号:{0}，订单金额:{1},渠道:{2},商户号:{3},状态:{4}", commonFieldMap.get(CommonFieldsConst.ORDER_ID), orderMoney, channel, merNo, onlinePayVo.getPayResultStatus());
        onlineWithdrawResult(onlinePayVo);
        try {
            if (StringTool.isNotBlank(onlinePayVo.getResponseText())) {
                response.getOutputStream().write(onlinePayVo.getResponseText().getBytes());
            }
        } catch (IOException var7) {
            LOG.error(var7);
        }
        return null;
    }


    /**
     * 处理回调
     *
     * @param request
     * @param channel
     * @param merNo
     * @param orderId
     * @param type
     * @return
     */
    private OnlinePayVo doPayCallBack(HttpServletRequest request, String channel, String merNo, String orderId, String type) {
        LOG.info("易收付出款,回调成功，渠道：{0}，商户号：{1}，交易号：{2}，对调类型：{3}", channel, merNo, orderId, type);
        Map<String,String> withdrawAccountMap = getWithdrawAccountMap();

        OnlinePayVo onlinePayVo = new OnlinePayVo();
        onlinePayVo.setOperatorIp(IpTool.ipv4StringToLong(ServletTool.getIpAddr(request)));
        onlinePayVo.setOperatorName(SessionManager.getUserName());
        onlinePayVo.setRequestParamMap(request.getParameterMap());
        onlinePayVo.setCommonFieldMap(withdrawAccountMap);
        if (StringTool.isNotBlank(orderId)) {
            onlinePayVo.getCommonFieldMap().put(CommonFieldsConst.ORDER_ID, orderId);
        }
        try {
            java.io.ByteArrayOutputStream inBuffer = new java.io.ByteArrayOutputStream();
            java.io.InputStream input = request.getInputStream();
            byte[] tmp = new byte[1024];
            int len = 0;
            while ((len = input.read(tmp)) > 0) {
                inBuffer.write(tmp, 0, len);
            }
            byte[] requestData = inBuffer.toByteArray();
            String requestJsonStr = new String(requestData, "UTF-8");
            onlinePayVo.getCommonFieldMap().put("requestJsonStr", requestJsonStr);
        } catch (Exception e) {
            LOG.error(e);
        }
        //获取头部信息
        Map<String, String> headersInfo = getHeadersInfo(request);
        if (MapTool.isNotEmpty(headersInfo)) {
            onlinePayVo.getCommonFieldMap().putAll(getHeadersInfo(request));
        }
        onlinePayVo.setApiType("doWithdrawCallback");
        onlinePayVo = ServiceTool.onlinePayService().callPay(onlinePayVo);
        return onlinePayVo;
    }


    /**
     * 处理带c参数的回调：参数c=channelCode-merchantCode-orderId
     *
     * @param request
     * @param response
     * @param model
     * @param type
     * @return
     */
    private String handlePayByParameter(HttpServletRequest request, HttpServletResponse response, Model model, String type) {
        String c = request.getParameter("c");
        //环迅、商银信、币币支付格式与其他不一致，但这三个支付都改为走c/m/o/bcb,不走这里，所以不影响
        String[] split = c.split("-");
        String channel = split[0];
        String merNo = split[1];
        String orderId = null;
        if (split.length > 2) {
            orderId = split[2];
        }
        return handlePayBack(request, channel, merNo, orderId, response);
    }
}
