<%--@elvariable id="<command>" type="so.wwb.gamebox.model.master.fund.rebate.vo.AgentRebateGradsListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<html lang="zh-CN">
<head>
    <title>${views.fund_auto['损益明细']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>
<body>
<form:form>
    <div class="modal-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-hover dataTable m-b-none">
                    <thead>
                        <tr>
                            <th></th>
                            <th>${views.fund_auto['本期损益']}</th>
                            <th>${views.fund_auto['上期累计损益']}</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:set var="sum1" value="${0}"></c:set>
                    <c:set var="sum2" value="${0}"></c:set>
                        <c:forEach var="s" items="${command.result}">
                            <c:set var="sum1" value="${sum1 + s.payoutAmount}"></c:set>
                            <c:set var="sum2" value="${sum2 + s.payoutAmountHistory}"></c:set>
                            <tr>
                                <td>${s.apiName}</td>
                                <td>${soulFn:formatCurrency(s.payoutAmount)}</td>
                                <td>${soulFn:formatCurrency(s.payoutAmountHistory)}</td>
                            </tr>
                        </c:forEach>
                        <tr class="co-red">
                            <td>${views.fund_auto['合计']}</td>
                            <td>${soulFn:formatCurrency(sum1)}</td>
                            <td>${soulFn:formatCurrency(sum2)}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button target="closePage" text="${views.common['cancel']}" opType="function" cssClass="btn btn-outline btn-filter"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import type="view"/>
<!--//endregion your codes 4-->
</html>