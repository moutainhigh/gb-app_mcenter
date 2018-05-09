<%--@elvariable id="objectVo" type="so.wwb.gamebox.model.master.operation.vo.RebateBillVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<html lang="zh-CN">
<head>
    <title>${views.operation['Rebate.confirmSettlement']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>
<body>
<form:form>
    <div class="modal-body">

        <c:if test="${activityType eq 'first_deposit'}">
            <%@include file="FirstDepositContent.jsp"%>
        </c:if>
        <c:if test="${activityType eq 'second_deposit'}">
            <%@include file="SecondDepositContent.jsp"%>
        </c:if>
        <c:if test="${activityType eq 'third_deposit'}">
            <%@include file="ThirdDepositContent.jsp"%>
        </c:if>
        <c:if test="${activityType eq 'everyday_first_deposit'}">
            <%@include file="EveryDayFirstDepositContent.jsp"%>
        </c:if>
        <c:if test="${activityType eq 'money'}">
            <%@include file="MoneyContent.jsp"%>
        </c:if>
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