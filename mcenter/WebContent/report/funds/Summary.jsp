<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<%@ page import="so.wwb.gamebox.model.master.report.po.VPlayerFundsRecord" %>
<c:set var="poType" value="<%= VPlayerFundsRecord.class %>" />
<div class="sys_tab_wrap clearfix">
    <div class=" clearfix m-sm"><b>${views.report_auto['资金账目汇总']}</b>
    </div>
</div>
<div class="filter-wraper clearfix">
    <span title="" data-original-title="" data-content="${views.report_auto['通过优惠活动获得的优惠']}
    <br><span class='ps-color'>PS：${views.report_auto['人工存入的派彩']}</span>" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0">
        <i class="fa fa-question-circle"></i>
    </span>
    <span>${views.report_auto['发放玩家优惠']}:
        <a href="/report/vPlayerFundsRecord/fundsLog.html?search.transactionWays=first_deposit&search.transactionWays=deposit_send&search.transactionWays=regist_send&search.transactionWays=relief_fund&search.transactionWays=profit_loss&search.transactionWays=effective_transaction&search.transactionWays=back_water&search.transactionWays=single_reward&search.transactionWays=bonus_awards&search.transactionWays=refund_fee&search.transactionWays=money&search.manualSaves=manual_favorable&search.manualSaves=manual_rakeback&search.manualSaves=manual_payout&search.manualSaves=manual_other&search.startTime=${soulFn:formatDateTz(command.search.startTime, DateFormat.DAY_SECOND, timeZone )}&search.endTime=${soulFn:formatDateTz(command.search.endTime, DateFormat.DAY_SECOND, timeZone )}&search.outer=-1&search.orderType=fundsLog" nav-target="mainFrame">
            ${soulFn:formatCurrency(empty fundsSum.favourable?0:fundsSum.favourable)}
        </a>
    </span>
    <span title="" data-original-title="" data-content="${views.report_auto['所有玩家取款订单']}" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span>
    <span>${views.report_auto['玩家稽核扣除']}:
        <a href="/fund/withdraw/withdrawList.html?open=true&search.deductSum=0&search.withdrawType=player&search.withdrawStatus=4&search.checkTimeStart=${soulFn:formatDateTz(command.search.startTime, DateFormat.DAY_SECOND, timeZone )}&search.checkTimeEnd=${soulFn:formatDateTz(command.search.endTime, DateFormat.DAY_SECOND, timeZone )}" nav-target="mainFrame">
            ${soulFn:formatCurrency(empty fundsSum.check_sum?0:fundsSum.check_sum)}
        </a>
    </span>
</div>
<div class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
                    <thead>
                        <tr class="bg-gray">
                            <th>${views.report_auto['收入']}</th>
                            <th>${views.report_auto['收入金额']}</th>
                            <th>${views.report_auto['支出明细']}</th>
                            <th>${views.report_auto['支出金额']}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>${views.report_auto['公司入款']}<span title="" data-original-title="" data-content="${views.report_auto['所有玩家公司入款的实际存款总额']}" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span></th>
                            <td class="co-blue3">
                                <a href="/report/vPlayerFundsRecord/fundsLog.html?search.transactionWays=online_bank&search.transactionWays=wechatpay_fast&search.transactionWays=alipay_fast&search.transactionWays=other_fast&search.transactionWays=atm_counter&search.transactionWays=atm_money&search.transactionWays=atm_recharge&search.startTime=${soulFn:formatDateTz(command.search.startTime, DateFormat.DAY_SECOND, timeZone )}&search.endTime=${soulFn:formatDateTz(command.search.endTime, DateFormat.DAY_SECOND, timeZone )}&search.outer=-1" nav-target="mainFrame">
                                    ${soulFn:formatCurrency(empty fundsSum.company_import?0:fundsSum.company_import)}
                                </a>
                            </td>
                            <th>${views.report_auto['玩家取款']}<span title="" data-original-title="" data-content="${views.report_auto['所有玩家申请的取款总额']}" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span></th>
                            <td class="co-blue3">
                                <a href="/report/vPlayerFundsRecord/fundsLog.html?search.transactionWays=player_withdraw&search.startTime=${soulFn:formatDateTz(command.search.startTime, DateFormat.DAY_SECOND, timeZone )}&search.endTime=${soulFn:formatDateTz(command.search.endTime, DateFormat.DAY_SECOND, timeZone )}&search.outer=-1" nav-target="mainFrame">
                                    ${soulFn:formatCurrency(fundsSum.player_withdraw)}
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <th>${views.report_auto['线上支付']}<span title="" data-original-title="" data-content="${views.report_auto['所有玩家线上支付的实际存款总额']}" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span></th>
                            <td class="co-blue3">
                                <a href="/report/vPlayerFundsRecord/fundsLog.html?search.transactionWays=online_deposit&search.transactionWays=wechatpay_scan&search.transactionWays=alipay_scan&search.startTime=${soulFn:formatDateTz(command.search.startTime, DateFormat.DAY_SECOND, timeZone )}&search.endTime=${soulFn:formatDateTz(command.search.endTime, DateFormat.DAY_SECOND, timeZone )}&search.outer=-1" nav-target="mainFrame">
                                    ${soulFn:formatCurrency(empty fundsSum.online_deposit?0:fundsSum.online_deposit)}
                                </a>
                            </td>
                            <th>${views.report_auto['人工取出']}<span title="" data-original-title="" data-content="${views.report_auto['所有玩家人工取出']}" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span></th>
                            <td class="co-blue3">
                                <a href="/report/vPlayerFundsRecord/fundsLog.html?search.manualWithdraws=manual_deposit&search.startTime=${soulFn:formatDateTz(command.search.startTime, DateFormat.DAY_SECOND, timeZone )}&search.endTime=${soulFn:formatDateTz(command.search.endTime, DateFormat.DAY_SECOND, timeZone )}&search.outer=-1" nav-target="mainFrame">
                                    ${soulFn:formatCurrency(empty fundsSum.arti_withdraw?0:-fundsSum.arti_withdraw)}
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <th>${views.report_auto['人工存入']}<span title="" data-original-title="" data-content="${views.report_auto['所有玩家人工存入']}" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span></th>
                            <td class="co-blue3">
                                <a href="/report/vPlayerFundsRecord/fundsLog.html?search.manualSaves=manual_deposit&search.manualSaves=manual_payout&search.manualSaves=manual_other&search.startTime=${soulFn:formatDateTz(command.search.startTime, DateFormat.DAY_SECOND, timeZone )}&search.endTime=${soulFn:formatDateTz(command.search.endTime, DateFormat.DAY_SECOND, timeZone )}&search.outer=-1&search.orderType=manualSave" nav-target="mainFrame">
                                    ${soulFn:formatCurrency(empty fundsSum.arti_deposit?0:fundsSum.arti_deposit)}
                                </a>
                            </td>
                            <th><span tabindex="0" class=" help-popover m-l-sm" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-content=""></span></th>
                            <td class="co-blue3"></td>
                        </tr>
                        <tr>
                            <td colspan="4" style="text-align: right;">
                                ${views.report_auto['总计']}：<span class="co-red">
                                ${soulFn:formatCurrency(fundsSum.company_import+fundsSum.online_deposit+fundsSum.arti_deposit+fundsSum.player_withdraw-fundsSum.arti_withdraw)}
                                </span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>