<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RebatePlayerFeeListVo"--%>
<%--@elvariable id="agentRebateVo" type="so.wwb.gamebox.model.master.operation.vo.RebateAgentVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set value="${agentRebateVo.result}" var="a"></c:set>
<!--//region your codes 1-->
<div class="table-responsive">
    <table class="table table-striped table-hover dataTable" id="editable" aria-describedby="editable_info">
        <thead>
            <tr>
                <td colspan="5" class="al-center">${views.wc_fund['费用总计细单']}</td>
            </tr>
            <tr role="row" class="bg-gray">
                <th>${views.wc_fund['玩家账号']}</th>
                <th>${views.report_auto['存款金额']}</th>
                <th>${views.fund['取款金额']}</th>
                <th>${views.wc_fund['行政费用']}</th>
                <th>${views.wc_fund['返水费用']}</th>
                <th>${views.wc_fund['存款优惠']}</th>
                <th>${views.wc_fund['其他费用']}</th>
                <th>${views.wc_fund['小计金额']}</th>
            </tr>

            <tr class="co-red">
                <td>${views.wc_fund['本期小计']}</td>
                <td>${soulFn:formatCurrency(a.depositAmount)}</td>
                <td>${soulFn:formatCurrency(a.withdrawAmount)}</td>
                <td>${soulFn:formatCurrency(a.depositFee+a.withdrawFee)}</td>
                <td>${soulFn:formatCurrency(a.rakebackFee)}</td>
                <td>${soulFn:formatCurrency(a.favorableFee)}</td>
                <td>${soulFn:formatCurrency(a.otherFee)}</td>
                <c:set value="${a.depositFee+a.withdrawFee + a.rakebackFee + a.favorableFee + a.otherFee}" var="b"></c:set>
                <td>${soulFn:formatCurrency(b+a.feeHistory)}</td>
            </tr>
            <tr>
                <td>${views.wc_fund['上期未结']}</td>
                <td colspan="7">${soulFn:formatCurrency(a.feeHistory)}</td>
            </tr>
        </thead>
        <tbody>
        <tr>
            <td colspan="6"></td>
        </tr>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr class="tab-detail">
                <td>${p.playerName}</td>
                <td>${soulFn:formatCurrency(p.depositAmount)}</td>
                <td>${soulFn:formatCurrency(p.withdrawAmount)}</td>
                <td>${soulFn:formatCurrency(p.depositAmount * (a.depositRatio/100) + p.withdrawAmount * (a.withdrawRatio/100))}</td>
                <td>${soulFn:formatCurrency(p.rakebackAmount*(a.rakebackRatio/100))}</td>
                <td>${soulFn:formatCurrency(p.favorableAmount*(a.favorableRatio/100))}</td>
                <td>${soulFn:formatCurrency(p.otherAmount*(a.otherRatio/100))}</td>
                <td>${soulFn:formatCurrency((p.depositAmount * (a.depositRatio/100) + p.withdrawAmount * (a.withdrawRatio/100)) + p.rakebackAmount *(a.rakebackRatio/100) + p.favorableAmount*(a.favorableRatio/100) + p.otherAmount*(a.otherRatio/100))}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
