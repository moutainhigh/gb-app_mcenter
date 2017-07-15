<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
    <title>${views.operation['Bill.station.pop.updateMoney']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>

<body>

<form:form id="editForm" action="" method="post">
    <gb:token/>
    <input type="hidden" name="result.id" value="${command.result.id}">
    <div id="validateRule" style="display: none">${validateRule}</div>

    <!--//region your codes 3-->

    <div class="modal-body">
        <div class="line-hi34 col-sm-12 bg-gray m-b-sm">
            <span class="co-yellow"><i class="fa fa-exclamation-circle"></i></span>
            ${views.operation['Bill.station.pop.message']}
        </div>

        <div class="form-group clearfix line-hi34 m-b-sm col-xs-12">
            <label class="col-xs-4 al-right">${views.operation['Bill.station.pop.message1']}<%=SessionManager.getUser().getDefaultCurrency()%>：</label>
            <div class="col-xs-8 p-x">
                <span class="co-orange">${soulFn:formatCurrency(command.result.amountPayable)}</span>
            </div>
        </div>
        <c:if test="${not empty command.result.remark}">
            <div class="form-group clearfix line-hi34 m-b-sm col-xs-12">
                <label class="col-xs-4 al-right">${views.operation['Bill.station.pop.message2']}<%=SessionManager.getUser().getDefaultCurrency()%>：</label>
                <div class="col-xs-8 p-x">
                    <span class="co-orange">${soulFn:formatCurrency(command.result.amountActual)}</span>
                </div>
            </div>
        </c:if>
        <div class="form-group clearfix m-b-sm col-xs-12">
            <label class="col-xs-3 al-right line-hi34 p-x">${views.operation['Bill.station.pop.message3']}<%=SessionManager.getUser().getDefaultCurrency()%>：</label>
            <div class="col-xs-9 p-x">
                <input type="text" class="form-control" name="result.amountActual">
            </div>
        </div>
        <div class="form-group clearfix m-b-sm col-xs-12">
            <label class="col-xs-3 al-right line-hi34 p-x">${views.operation['operation.remark']}：</label>
            <div class="col-xs-9 p-x"><textarea class="form-control" name="result.remark"></textarea></div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button target="${root}/operation/stationbill/updateAmountPayable.html" text="${views.common['OK']}" opType="ajax" cssClass="btn btn-filter" post="getCurrentFormData" callback="saveCallbak" precall="validateForm">${views.common['OK']}</soul:button>
        <soul:button target="closePage" text="${views.common['cancel']}" opType="function" cssClass="btn btn-outline btn-filter"/>
    </div>
    <!--//endregion your codes 3-->
</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import type="edit"/>
<!--//endregion your codes 4-->
</html>