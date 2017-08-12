<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form>
    <input type="hidden" name="sysParam[0].id" value="${depositFee.id}">
    <input type="hidden" name="sysParam[1].id" value="${withdrawFee.id}">
    <input type="hidden" name="sysParamLimit[0].id" value="${withdrawLimitMin.id}">
    <input type="hidden" name="sysParamLimit[1].id" value="${withdrawLimitMax.id}">
    <div id="validateRule" style="display: none">${validateRule}</div>
    <div class="modal-body">
        <div class="m-b">${views.setting_auto['设置存取款手续费']}</div>
        <div class="m-t-xs">
            <div class="input-group content-width-limit-400">
                <span class="input-group-addon abroder-no p-x"><b>${views.setting_auto['存款']}:</b></span>
                <input type="text" class="form-control" name="sysParam[0].paramValue" value="${empty depositFee.paramValue ? depositFee.defaultValue : depositFee.paramValue}">
                <span class="input-group-addon">%</span>
                <span class="input-group-addon abroder-no p-x"><b>${views.setting_auto['取款']}:</b></span>
                <input type="text" class="form-control" name="sysParam[1].paramValue" value="${empty withdrawFee.paramValue ? withdrawFee.defaultValue : withdrawFee.paramValue}">
                <span class="input-group-addon">%</span>
            </div>
        </div>
        <div class="m-b" style="margin-top: 20px;">${views.setting_auto['设置取款上下限']}</div>
        <div class="m-t-xs">
            <div class="input-group content-width-limit-400">
                <span class="input-group-addon abroder-no p-x"><b>${views.setting_auto['最小值']}:</b></span>
                <input type="text" class="form-control" name="sysParamLimit[0].paramValue" value="${empty withdrawLimitMin.paramValue ? withdrawLimitMin.defaultValue : withdrawLimitMin.paramValue}">
                <span class="input-group-addon abroder-no p-x"><b>${views.setting_auto['最大值']}:</b></span>
                <input type="text" class="form-control" name="sysParamLimit[1].paramValue" value="${empty withdrawLimitMax.paramValue ? withdrawLimitMax.defaultValue : withdrawLimitMax.paramValue}">
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" precall="validateForm" text="${views.common.OK}" opType="ajax"
                     target="${root}/rebateSet/save.html" dataType="json" post="getCurrentFormData"
                     callback="saveCallbak"/>
        <soul:button cssClass="btn btn-outline btn-filter" target="closePage" opType="function"
                     text="${views.common.cancel}"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import type="edit"/>
</html>