<%@ page import="so.wwb.gamebox.model.master.report.po.VRebateReport" %><%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VRebateReportListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<c:set var="type" value="<%= VRebateReport.class %>" />
<c:set var="totalEt" value="0"/> <%-- 总计有效交易量 --%>
<c:set var="totalEp" value="0"/> <%-- 有效玩家 --%>
<c:set var="totalPl" value="0"/> <%-- 总计交易盈亏 --%>
<c:set var="totalDa" value="0"/> <%-- 总计存款 --%>
<c:set var="totalWa" value="0"/> <%-- 总计取款 --%>
<c:set var="totalBw" value="0"/> <%-- 总计返水 --%>
<c:set var="totalRf" value="0"/> <%-- 总计返手续费 --%>
<c:set var="totalPv" value="0"/> <%-- 总计优惠 --%>
<c:set var="totalDe" value="0"/> <%-- 总计分摊费用 --%>
<c:set var="totalRt" value="0"/> <%-- 总计应付佣金 --%>
<c:set var="totalRa" value="0"/> <%-- 总计实付佣金 --%>
<c:set var="totalHa" value="0"/> <%-- 历史分摊未结 --%>
<input type="hidden" value="${conditionJson}" id="conditionJson">
<div class="search-params-div hide"></div>
<div class="sys_tab_wrap clearfix">
    <div class="m-sm">
        <b>${views.report['rebate.detail.detail']}</b>
        <soul:button permission="report:rebate_export" tag="button" cssClass="btn btn-export-btn btn-primary-hide pull-right" callback="gotoExportHistory"
                     text="${views.report['operate.list.export']}" precall="validExportCount" post="getCurrentFormData"
                     title="${views.report['operate.list.export']}" target="${root}/report/rebate/detail/exportRecords.html?result.siteId=${command.siteId}" opType="ajax">
            <i class="fa fa-sign-out"></i><span class="hd">${views.report['operate.list.export']}</span>
        </soul:button>
    </div>
</div>
<div class="table-responsive">
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.column['VRebateReport.agentName']}</th>
            <th>${views.column['VRebateReport.effectivePlayer']}</th>
            <th>${views.column['VRebateReport.effectiveTransaction']}</th>
            <th>${views.column['VRebateReport.profitLoss']}</th>
            <th>${views.column['VRebateReport.depositAmount']}</th>
            <th>${views.column['VRebateReport.withdrawalAmount']}</th>
            <th>${views.column['VRebateReport.backwater']}</th>
            <th>${views.column['VRebateReport.preferentialValue']}</th>
            <th>${views.column['VRebateReport.refundFee']}</th>
            <th>${views.column['VRebateReport.deductExpenses']}</th>
            <th>${views.column['VRebateReport.prevUnsettled']}</th>

            <c:set value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rebate.help.total']}\"><i class=\"fa fa-question-circle\"></i></span>" var="tips1"></c:set>
            <soul:orderColumn poType="${type}" property="rebateTotal"
                              column="${tips1} ${views.column['VRebateReport.rebateTotal']}"></soul:orderColumn>
            <c:set value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rebate.help.actual']}\"><i class=\"fa fa-question-circle\"></i></span>" var="tips2"></c:set>
            <soul:orderColumn poType="${type}" property="rebateActual"
                              column="${tips2} ${views.column['VRebateReport.rebateActual']}"></soul:orderColumn>
            <%--<th>${views.column['VRebateReport.rebateTotal']}</th>
            <th>${views.column['VRebateReport.rebateActual']}</th>--%>
            <th>${views.common['status']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <c:set var="et" value="${p.effectiveTransaction}"/>
            <c:set var="totalEt" value="${totalEt + et}"/>
            <c:set var="ep" value="${p.effectivePlayer}"/>
            <c:set var="totalEp" value="${totalEp + ep}"/>
            <c:set var="pl" value="${p.profitLoss}"/>
            <c:set var="totalPl" value="${totalPl + pl}"/>
            <c:set var="da" value="${p.depositAmount}"/>
            <c:set var="totalDa" value="${totalDa + da}"/>
            <c:set var="wa" value="${p.withdrawalAmount}"/>
            <c:set var="totalWa" value="${totalWa + wa}"/>
            <c:set var="bw" value="${p.rakeback}"/>
            <c:set var="totalBw" value="${totalBw + bw}"/>
            <c:set var="rf" value="${p.refundFee}"/>
            <c:set var="totalRf" value="${totalRf + rf}"/>
            <c:set var="pv" value="${p.preferentialValue}"/>
            <c:set var="totalPv" value="${totalPv + pv}"/>
            <c:set var="de" value="${p.apportion}"/>
            <c:set var="totalDe" value="${totalDe + de}"/>
            <c:set var="rt" value="${p.rebateTotal}"/>
            <c:set var="totalRt" value="${totalRt + rt}"/>
            <c:set var="ra" value="${p.rebateActual}"/>
            <c:set var="totalRa" value="${totalRa + ra}"/>
            <c:set var="ha" value="${p.historyApportion}"/>
            <c:set var="totalHa" value="${totalHa + ha}"/>
            <%--
                pending_pay：待发放、part_pay：部分已发放、all_pay：全部已发放
            --%>
            <c:if test="${p.settlementState eq 'reject_lssuing'}">
                <c:set var="clz" value="label label-danger" />
            </c:if>
            <c:if test="${p.settlementState eq 'pending_lssuing'}">
                <c:set var="clz" value="label label-orange" />
            </c:if>
            <c:if test="${p.settlementState eq 'lssuing'}">
                <c:set var="clz" value="label label-success" />
            </c:if>
            <c:set var="sta" value="${dicts.operation.settlement_state[p.settlementState]}" />
            <tr>
                <td class="co-blue">${p.agentName}</td>
                <td class="co-blue">${soulFn:formatNumber(ep)}</td>
                <td class="co-blue">${soulFn:formatCurrency(et)}</td>
                <td>${soulFn:formatCurrency(p.profitLoss)}</td>
                <td class="co-blue">${soulFn:formatCurrency(da)}</td>
                <td class="co-blue">${soulFn:formatCurrency(wa)}</td>
                <td class="co-blue">${soulFn:formatCurrency(bw)}</td>
                <td class="co-blue">${soulFn:formatCurrency(pv)}</td>
                <td class="co-blue">${soulFn:formatCurrency(rf)}</td>
                <td>${soulFn:formatCurrency(de)}</td>
                <td>${soulFn:formatCurrency(ha)}</td>
                <td style="padding-left: 40px">${soulFn:formatCurrency(rt)}</td>
                <td style="padding-left: 40px">${soulFn:formatCurrency(ra)}</td>
                <td><span class="${clz}">${empty sta ?dicts.common.status[c.status]:sta}</span></td>
            </tr>
        </c:forEach>
        <tr>
            <td>${views.report['rebate.detail.currCount']}</td>
            <td class="co-yellow">${soulFn:formatNumber(totalEp == '0' ? 0 : totalEp)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(totalEt == '0' ? 0 : totalEt)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(totalPl == '0' ? 0 : totalPl)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(totalDa == '0' ? 0 : totalDa)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(totalWa == '0' ? 0 : totalWa)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(totalBw == '0' ? 0 : totalBw)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(totalPv == '0' ? 0 : totalPv)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(totalRf == '0' ? 0 : totalRf)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(totalDe == '0' ? 0 : totalDe)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(totalHa == '0' ? 0 : totalHa)}</td>
            <td class="co-yellow" style="padding-left: 40px">${soulFn:formatCurrency(totalRt == '0' ? 0 : totalRt)}</td>
            <td class="co-yellow" style="padding-left: 40px">${soulFn:formatCurrency(totalRa == '0' ? 0 : totalRa)}</td>
            <td>&nbsp;</td>
        </tr>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
