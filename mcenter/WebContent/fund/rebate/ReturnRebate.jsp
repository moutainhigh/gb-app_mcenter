<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.rebate.vo.AgentRebateGradsListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<html lang="zh-CN">
<head>
    <title>${views.fund_auto['可获返佣明细']}</title>
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
                            <th>${views.fund_auto['游戏']}</th>
                            <th>${views.fund_auto['总损益']}</th>
                            <th>${views.fund_auto['代理承担费用']}</th>
                            <th>${views.fund_auto['所剩费用']}</th>
                            <th>${views.fund_auto['剩余损益']}</th>
                            <th>${views.fund_auto['返佣比例']}(%)</th>
                            <th>${views.fund_auto['小计']}</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:set var="total" value="${0}"></c:set>
                        <c:forEach var="s" items="${command.result}"  varStatus="status">
                            <c:set var="total" value="${total + s.remainPayoutAmount * s.radio/100}"></c:set>
                            <tr>
                                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                                <td>${s.apiName}</td>
                                <td>${soulFn:formatCurrency(s.payoutAmount + s.payoutAmountHistory)}</td>
                                <td>${soulFn:formatCurrency(s.expenseAmount)}</td>
                                <td>${soulFn:formatCurrency(s.remainExpenseAmount)}</td>
                                <td>${soulFn:formatCurrency(s.remainPayoutAmount)}</td>
                                <td>${soulFn:formatCurrency(s.radio)}</td>
                                <td>${soulFn:formatCurrency(s.remainPayoutAmount * s.radio/100)}</td>
                                <c:if test="${status.last}">
                                    <c:set value="${s.remainExpenseAmount}" var="l"></c:set>
                                </c:if>
                            </tr>
                        </c:forEach>
                        <tr class="co-red">
                            <td colspan="7" class="al-center">${views.fund_auto['可获返佣']}</td>
                            <td>${soulFn:formatCurrency(total - l)}</td>
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