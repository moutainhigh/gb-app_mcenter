<%@ page import="so.wwb.gamebox.model.master.lottery.po.LotteryBetOrder" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.lottery.vo.LotteryBetOrderListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%@taglib uri="http://soul/tags" prefix="soul" %>

<!--//region your codes 1-->
<div class="table-responsive">
    <table class="table table-condensed table-hover table-striped table-bordered">
        <thead>
        <tr>
            <th>彩种</th>
            <th>玩法</th>
            <th>投注单量</th>
            <th>投注金额</th>
            <th>返点金额</th>
            <th>派彩金额</th>
            <th>损益</th>
        </tr>
        </thead>
        <tbody>
        <c:set var="allBetAmount" value="${0}"></c:set>
        <c:set var="allPayout" value="${0}"></c:set>
        <c:set var="allRebateAmount" value="${0}"></c:set>
        <c:if test="${empty command.reportList}">
            <td colspan="13" class="no-content_wrap">
                <div>
                    <i class="fa fa-exclamation-circle"></i> ${views.common['noResult']}
                </div>
            </td>
        </c:if>
        <c:forEach items="${command.reportList}" var="p" varStatus="status">
            <c:set var="allRebateAmount" value="${allRebateAmount+p.rebateamount}"/>
            <c:set var="allBetAmount" value="${allBetAmount+p.amount}"/>
            <c:set var="allPayout" value="${allPayout+p.payout}"></c:set>
            <tr class="tab-detail">
            <td>${dicts.lottery.lottery[p.code]}</td>
            <td>${dicts.lottery.lottery_play[p.play_code]}-${dicts.lottery.lottery_betting[p.bet_code]}</td>
            <td>${p.betcount}</td>
            <td>${p.amount}</td>
            <td>${soulFn:formatCurrency(p.rebateamount)}</td>
            <td>${p.payout}</td>
            <c:if test="${p.amount>=p.payout}"><td><span class="co-green">+${p.amount-p.payout}</span></td></c:if>
            <c:if test="${p.amount<p.payout}"><td><span class="co-red">${p.amount-p.payout}</span></td></c:if>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="p-sm all-statistics">
    <b>${views.lottery_auto['本页投注总金额']}：</b><span class="co-red3">${soulFn:formatCurrency(allBetAmount)}</span> ${views.lottery_auto['元']}
    <b class="m-l">${views.lottery_auto['返点总金额']}：</b><span class="co-red3">${soulFn:formatCurrency(allRebateAmount)}</span>${views.lottery_auto['元']}
    <b class="m-l">${views.lottery_auto['派彩总金额']}：</b><span class="co-red3">${soulFn:formatCurrency(allPayout)}</span>${views.lottery_auto['元']}
    <b class="m-l">${views.lottery_auto['赢利总金额']}：</b><span class="co-red3">${soulFn:formatCurrency(allPayout-allBetAmount+allRebateAmount)}</span>${views.lottery_auto['元']}
</div>
<soul:pagination />
<!--//endregion your codes 1-->
