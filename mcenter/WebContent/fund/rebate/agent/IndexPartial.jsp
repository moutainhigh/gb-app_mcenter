<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.rebate.vo.AgentRebatePlayerListVo"--%>
<%--@elvariable id="agentRebateVo" type="so.wwb.gamebox.model.master.fund.rebate.vo.AgentRebateVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set value="${agentRebateVo.result}" var="a"></c:set>
<!--//region your codes 1-->
<div class="table-responsive">
    <table class="table table-striped table-hover dataTable" id="editable" aria-describedby="editable_info">
        <thead>
            <tr>
                <td colspan="5" class="al-center">${views.fund_auto['费用总计细单']}</td>
            </tr>
            <tr role="row" class="bg-gray">
                <th>${views.fund_auto['玩家账号']}</th>
                <th>${views.fund_auto['行政费用']}</th>
                <th>${views.fund_auto['返水费用']}</th>
                <th>${views.fund_auto['存款优惠']}</th>
                <th>${views.fund_auto['其他费用']}</th>
                <th>${views.fund_auto['小计金额']}</th>
            </tr>

            <tr class="co-red">
                <td>${views.fund_auto['本期小计']}</td>
                <td>${soulFn:formatCurrency(a.feeAmount)}</td>
                <td>${soulFn:formatCurrency(a.rakebackAmount)}</td>
                <td>${soulFn:formatCurrency(a.favorableAmount)}</td>
                <td>${soulFn:formatCurrency(a.otherAmount)}</td>
                <c:set value="${a.feeAmount + a.rakebackAmount + a.favorableAmount + a.otherAmount}" var="b"></c:set>
                <td>${soulFn:formatCurrency(b)}</td>
            </tr>
            <tr class="co-red">
                <td>${views.fund_auto['上期累计']}</td>
                <td>${soulFn:formatCurrency(a.feeAmountHistory)}</td>
                <td>${soulFn:formatCurrency(a.rakebackAmountHistory)}</td>
                <td>${soulFn:formatCurrency(a.favorableAmountHistory)}</td>
                <td>${soulFn:formatCurrency(a.otherAmountHistory)}</td>
                <c:set value="${a.feeAmountHistory + a.rakebackAmountHistory + a.favorableAmountHistory + a.otherAmountHistory}" var="c"></c:set>
                <td>${soulFn:formatCurrency(c)}</td>
            </tr>
            <tr class="co-red">
                <td>${views.fund_auto['费用总计']}</td>
                <td>${soulFn:formatCurrency(a.feeAmount + a.feeAmountHistory)}</td>
                <td>${soulFn:formatCurrency(a.rakebackAmount + a.rakebackAmountHistory)}</td>
                <td>${soulFn:formatCurrency(a.favorableAmount + a.favorableAmountHistory)}</td>
                <td>${soulFn:formatCurrency(a.otherAmount + a.otherAmountHistory)}</td>
                <td>${soulFn:formatCurrency(b + c)}</td>
            </tr>
        </thead>
        <tbody>
        <tr>
            <td colspan="6"></td>
        </tr>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr class="tab-detail">
                <td>${p.username}</td>
                <td>${soulFn:formatCurrency(p.depositAmount * (p.depositRadio/100) + p.withdrawAmount * (p.withdrawRadio/100))}</td>
                <td>${soulFn:formatCurrency(p.rakebackAmount)}</td>
                <td>${soulFn:formatCurrency(p.favorableAmount)}</td>
                <td>${soulFn:formatCurrency(p.recommendAmount)}</td>
                <td>${soulFn:formatCurrency((p.depositAmount * (p.depositRadio/100) + p.withdrawAmount * (p.withdrawRadio/100)) + p.rakebackAmount + p.favorableAmount + p.recommendAmount)}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
