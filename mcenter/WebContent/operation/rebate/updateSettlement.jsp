<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RebateAgentVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
    <title>${views.operation['Rebate.pop.modifyActually']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>

<body>

<form:form id="editForm" action="" method="post">
    <gb:token/>
    <form:hidden path="result.id" />
    <div id="validateRule" style="display: none">${command.validateRule}</div>

    <!--//region your codes 3-->
    <!--修改佣金-->
    <div class="modal-body">
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right">${views.operation['Rebate.agentName']}：</label>
            <div class="col-xs-8 p-x co-blue">${command.result.agentName}</div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right">${views.operation['Rebate.pop.commissionPayable']}：</label>
            <form:hidden path="result.rebateTotal"/>
            <div class="col-xs-8 p-x"><b class="fs25">${soulFn:formatCurrency(command.result.rebateTotal)}</b></div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-sm">
            <label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>${views.operation['Rebate.pop.realCommission']}：</label>
            <div class="col-xs-8 p-x input-group">
                <form:input path="result.rebateActual" cssClass="form-control" placeholder="${views.operation['Rebate.pop.enterAmount']}"/>
            </div>
        </div>
        <%--<div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>${views.operation['Rebate.pop.remark']}：</label>
            <div class="col-xs-8 p-x">
                <form:textarea path="result.remark" placeholder="${views.operation['Rebate.pop.message1']}" cssClass="form-control"/>
            </div>
        </div>--%>
    </div>
    <div class="modal-footer">
        <soul:button target="${root}/rebateAgent/persist.html" text="${views.common['OK']}" opType="ajax" cssClass="btn btn-outline btn-filter" post="getCurrentFormData" callback="saveCallbak" precall="validateForm"/>
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