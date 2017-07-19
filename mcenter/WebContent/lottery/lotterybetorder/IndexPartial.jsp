<%@ page import="so.wwb.gamebox.model.master.lottery.po.LotteryBetOrder" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.lottery.vo.LotteryBetOrderListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%@taglib uri="http://soul/tags" prefix="soul" %>

<!--//region your codes 1-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
            <c:set var="poType" value="<%= LotteryBetOrder.class %>"></c:set>
            <thead>
            <tr role="row" class="bg-gray">
                <th style="width: 80px">${views.lottery_auto['序号']}</th>
                <th>${views.lottery_auto['投注帐号']}</th>
                <th>${views.lottery_auto['所属彩种']}</th>
                <th>${views.lottery_auto['注单号']}</th>
                <th>${views.lottery_auto['彩票期号']}</th>
                <th>${views.lottery_auto['投注玩法']}</th>
                <th>${views.lottery_auto['投注内容']}</th>
                <th>${views.lottery_auto['投注金额']}</th>
                <th>${views.lottery_auto['赔率']}</th>
                <th>${views.lottery_auto['派彩']}</th>
                <th>${views.lottery_auto['投注时间']}</th>
                <th>
                    <gb:select name="search.status" cssClass="btn-group chosen-select-no-single" prompt="${views.common['status']}"
                               list="${orderStatus}" value="${command.search.status}" callback="query"/>
                </th>
                <th>${views.lottery_auto['操作']}</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${empty command.result}">
                <td colspan="13" class="no-content_wrap">
                    <div>
                        <i class="fa fa-exclamation-circle"></i> ${views.common['noResult']}
                    </div>
                </td>
            </c:if>
            <c:set var="allBetAmount" value="${0}"></c:set>
            <c:set var="allPayout" value="${0}"></c:set>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                    <td>${p.username}</td>
                    <td>${dicts.lottery.lottery[p.code]}</td>
                    <td>${p.id}</td>
                    <td>${p.expect}</td>
                    <td>${dicts.lottery.lottery_betting[p.betCode]}</td>
                    <td>${dicts.lottery.lottery_betting[p.betCode]}-${p.betNum}</td>
                    <td>${p.betAmount}</td>
                    <c:set var="allBetAmount" value="${allBetAmount+p.betAmount}"></c:set>
                    <td>${p.odd}</td>
                    <td>${p.payout}</td>
                    <c:set var="allPayout" value="${allPayout+p.payout}"></c:set>
                    <td>${soulFn:formatDateTz(p.betTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    <td>
                        <c:if test="${p.status=='1'}">
                            <span class="label label-orange">${dicts.lottery.order_status[p.status]}</span>
                        </c:if>
                        <c:if test="${p.status=='2'}">
                            <span class="label label-green">${dicts.lottery.order_status[p.status]}</span>
                        </c:if>
                        <c:if test="${p.status=='3'}">
                            <span class="label label-danger">${dicts.lottery.order_status[p.status]}</span>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${p.status=='1'}">
                            <soul:button text="${views.lottery_auto['撤销']}" opType="ajax" target="${root}/lotteryBetOrder/cancelOrder.html?search.id=${p.id}"
                                         confirm="${views.lottery_auto['撤销注单将会扣除派彩金额,返回投注金额,有可能导致玩家余额为负数,请谨慎操作！']}" callback="query"></soul:button>
                        </c:if>
                        <c:if test="${p.status!='1'}"><span class="co-gray">${views.lottery_auto['撤销']}</span></c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="p-sm all-statistics">
    <b>${views.lottery_auto['本页投注总金额']}：</b><span class="co-red3">${soulFn:formatCurrency(allBetAmount)}</span> ${views.lottery_auto['元']}
    <b class="m-l">${views.lottery_auto['派彩总金额']}：</b><span class="co-red3">${soulFn:formatCurrency(allPayout)}</span>${views.lottery_auto['元']}
    <b class="m-l">${views.lottery_auto['赢利总金额']}：</b><span class="co-red3">${soulFn:formatCurrency(allPayout-allBetAmount)}</span>${views.lottery_auto['元']}
</div>
<soul:pagination cssClass="bdtop3"/>
<!--//endregion your codes 1-->
