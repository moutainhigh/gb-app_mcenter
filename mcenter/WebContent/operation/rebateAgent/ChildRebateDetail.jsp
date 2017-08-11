<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RebateAgentListVo"--%>
<%--@elvariable id="rebateAgent" type="so.wwb.gamebox.model.master.operation.po.RebateAgent"--%>
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
            <div class="table-responsive" id="table-content">
                <table class="table table-striped table-hover dataTable m-b-none">
                    <thead>
                        <tr>
                            <th>下级代理</th>
                            <th>自身损益</th>
                            <th>抽佣</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:set var="sum1" value="${0}"></c:set>
                    <c:set var="sum2" value="${0}"></c:set>
                        <c:forEach var="s" items="${command.result}">
                            <c:set var="sum1" value="${sum1 + s.profitLoss}"></c:set>
                            <tr>
                                <td>${s.agentName}</td>
                                <td>${soulFn:formatCurrency(s.profitLoss)}</td>
                                <td>
                                    <soul:button target="showChildProfitLoss" agentId="${s.agentId}" rebateBillId="${s.rebateBillId}" rebateAgentId="${s.id}"
                                                 text="${soulFn:formatCurrency(s.rebateParent)}" opType="function"></soul:button>

                                </td>
                                <c:set var="sum2" value="${sum2+s.rebateParent}"></c:set>
                            </tr>
                        </c:forEach>
                        <tr class="co-red">
                            <td>本期小计</td>
                            <td>${soulFn:formatCurrency(sum1)}</td>
                            <td>${soulFn:formatCurrency(sum2)}</td>
                        </tr>
                        <tr>
                            <td>上期累计</td>
                            <td colspan="2">${soulFn:formatCurrency(rebateAgent.rebateSunHistory)}</td>
                        </tr>
                        <tr>
                            <td>本期可获总佣金</td>
                            <td colspan="2">${soulFn:formatCurrency(sum2+rebateAgent.rebateSunHistory)}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button target="closePage" text="${views.common['cancel']}" opType="function" cssClass="btn btn-outline btn-filter"/>

        <a href="javascript:void(0)" class="btn btn-outline btn-filter hide" id="return-back" >返回</a>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/operation/rebate/ChildRebate"/>
<!--//endregion your codes 4-->
</html>