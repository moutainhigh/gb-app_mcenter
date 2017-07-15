<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.PayAccountVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<html>
<!--//endregion your codes 1-->
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form id="editForm" action="${root}/payAccount/edit.html" method="post">
    <form:hidden path="result.id"/>
    <form:hidden path="result.payName"/>
    <form:hidden path="result.type"/>
    <input type="hidden" name="search.id" value="${command.result.id}">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>${views.content['payAccount.toImprove.disableAmount']}：${command.result.disableAmount}</label>
                    </div>
                    <div class="form-group">
                        <label>${views.content['payAccount.adjustTo']}</label>
                        <form:input id="disableAmount" path="result.disableAmount" maxlength="8" cssClass="form-control" amount="${command.result.disableAmount}"/>
                        <div class="m-t-sm"><i class="fa fa-exclamation-circle"></i> ${views.content['payAccount.toImprove.Estimate']} <span class="co-yellow">${soulFn:formatCurrency(totalAmount)}</span></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <soul:button target="${root}/payAccount/toImproveAmount.html?originalDisableAmount=${command.result.disableAmount}&reminder.id=${taskId}" text="${views.common['OK']}" precall="validateForm"  dataType="json"
                                 opType="ajax" cssClass="btn btn-filter" post="getCurrentFormData"
                                 callback="saveDisable"/>
                </div>
</form:form>
</body>
<!--//region your codes 4-->
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/payaccount/toImprove"/>
</html>
<!--//endregion your codes 4-->
