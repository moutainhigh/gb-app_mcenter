<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-11-12
  Time: 下午9:51
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerTransactionVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="col-lg-12 m-t">
    <div class="wrapper white-bg shadow clearfix">
        <div class="sys_tab_wrap"><div class="m-sm"><b>${views.report_auto['推荐详细']}</b></div></div>
        <div class="p-sm p-b-xxs">${views.report_auto['玩家账号']}：<span class="co-blue">${command.result.username}</span>
            <a class="btn btn-filter btn-outline btn-sm m-l-sm" href="/report/fundsLog/list.html?search.username=${command.result.username}&search.fundTypes=recommend" nav-target="mainFrame">${views.operation['backwater.settlement.view.queryAllBill']}</a>
        </div>
        <div class="dataTables_wrapper p-x" role="grid">


            <div class="panel-body">

                <div class="table-responsive">
                    <table class="table border m-b-none">
                        <thead>
                        <tr class="bg-gray">
                            <th colspan="5"><div class="al-left">${views.report_auto['订单信息']}</div></th>
                        </tr>
                        <tr>
                            <th>${views.report_auto['订单号']}</th>
                            <th>${views.report_auto['交易描述']}</th>
                            <th>${views.report_auto['金额']}</th>
                            <th>${views.report_auto['钱包余额']}</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>${command.result.transactionNo}</td>
                            <td>
                                ${views.report_auto['推荐']}-${dicts.common.transaction_way[command.result.transactionWay]}
                                <%-- 红利-单次奖励 --%>
                                <c:if test="${command.result.transactionWay eq 'single_reward'}">
                                    <c:if test="${command.result._describe['rewardType'] eq 2}">
                                        <dd class="co-orange"> ${messages.fund['FundRecord.record.friend']}&nbsp; ${command.result._describe['username']}</dd>
                                    </c:if>
                                    <c:if test="${command.result._describe['rewardType'] eq 3}">
                                        <dd class="co-orange"> ${messages.fund['FundRecord.record.recmTip1']}${messages.fund['FundRecord.record.friend']}&nbsp;${command.result._describe['username']}${messages.fund['FundRecord.record.recmTip2']}</dd>
                                    </c:if>
                                </c:if>
                                <%-- 天天返 --%>
                                <c:if test="${command.result.transactionWay eq 'bonus_awards'}">
                                <dd class="co-orange"> ${messages.fund['FundRecord.record.singleReward']}</dd>
                                </c:if>
                            </td>
                            <td class="co-green">+${soulFn:formatCurrency(command.result.transactionMoney)}</td>
                            <td>${soulFn:formatCurrency(command.result.balance)}</td>
                        </tr>
                        <c:if test="${not empty command.result.failureReason}">
                            <tr class="bg-gray">
                                <td colspan="5" class="al-left"><b>${views.report_auto['失败原因']}:</b> command.result.failureReason</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div></div></div>
        <div class="dataTables_wrapper p-x" role="grid">


            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table border m-b-none">
                        <tbody><tr>
                            <th>${views.report_auto['创建时间']}</th>
                            <th>${views.report_auto['操作人']}</th>
                            <th>${views.report_auto['完成时间']}</th>
                            <th>${views.report_auto['状态']}</th>
                        </tr>
                        <tr>
                            <td>${soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                            <td>${views.report['fund.detail.systemAuto']}</td>
                            <td>
                                <c:set var="completionTime" value="${soulFn:formatDateTz(command.result.completionTime, DateFormat.DAY_SECOND,timeZone)}"/>
                                <c:set var="createTime" value="${soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)}"/>
                                ${completionTime==''?createTime:completionTime}
                            </td>
                            <td>${dicts.common.status[command.result.status]}</td>
                        </tr>
                        </tbody></table>
                </div></div></div>

    </div>
</div>