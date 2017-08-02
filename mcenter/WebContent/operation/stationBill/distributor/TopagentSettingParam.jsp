<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form>
    <input type="hidden" name="sysParam[0].id" value="${preferentialParam.id}">
    <input type="hidden" name="sysParam[1].id" value="${poundageParam.id}">
    <input type="hidden" name="sysParam[2].id" value="${rakbackParam.id}">
    <input type="hidden" name="sysParam[3].id" value="${rebateParam.id}">
    <div id="validateRule" style="display: none">${validateRule}</div>
    <div class="modal-body">
        <div class="m-b">${views.operation_auto['设置总代分摊比例']}</div>
        <div class="m-t-xs">
            <div class="input-group content-width-limit-400" style="padding: 10px 0px">
                <span class="input-group-addon abroder-no p-x"><b>${views.operation_auto['优惠费用']}:</b></span>
                <input type="number" class="form-control" name="sysParam[0].paramValue" value="${empty preferentialParam.paramValue ? preferentialParam.defaultValue : preferentialParam.paramValue}">
                <span class="input-group-addon">%</span>
                <span class="input-group-addon abroder-no p-x"><b>${views.operation_auto['手续费用']}:</b></span>
                <input type="number" class="form-control" name="sysParam[1].paramValue" value="${empty poundageParam.paramValue ? poundageParam.defaultValue : poundageParam.paramValue}">
                <span class="input-group-addon">%</span>
            </div>
            <div class="input-group content-width-limit-400"  style="padding: 10px 0px">
                <span class="input-group-addon abroder-no p-x"><b>${views.operation_auto['返水费用']}:</b></span>
                <input type="number" class="form-control" name="sysParam[2].paramValue" value="${empty rakbackParam.paramValue ? rakbackParam.defaultValue : rakbackParam.paramValue}">
                <span class="input-group-addon">%</span>
                <span class="input-group-addon abroder-no p-x"><b>${views.operation_auto['返佣费用']}:</b></span>
                <input type="number" class="form-control" name="sysParam[3].paramValue" value="${empty rebateParam.paramValue ? rebateParam.defaultValue : rebateParam.paramValue}">
                <span class="input-group-addon">%</span>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" precall="validateForm" text="${views.common.OK}" opType="ajax"
                     target="${root}/operation/stationbill/saveParam.html" dataType="json" post="getCurrentFormData"
                     callback="saveCallbak"/>
        <soul:button cssClass="btn btn-outline btn-filter" target="closePage" opType="function"
                     text="${views.common.cancel}"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import type="edit"/>
</html>