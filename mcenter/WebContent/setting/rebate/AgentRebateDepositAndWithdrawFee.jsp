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
    <input type="hidden" name="sysParam[2].id" value="${rakebackParam.id}">
    <input type="hidden" name="sysParam[3].id" value="${favorableParam.id}">
    <input type="hidden" name="sysParam[4].id" value="${adminParam.id}">
    <input type="hidden" name="sysParam[5].id" value="${otherParam.id}">
    <input type="hidden" name="sysParamLimit[0].id" value="${withdrawLimitMin.id}">
    <input type="hidden" name="sysParamLimit[1].id" value="${withdrawLimitMax.id}">
    <div id="validateRule" style="display: none">${validateRule}</div>
    <div class="modal-body">
        <div class="m-b">${views.setting_auto['设置存取款手续费']}</div>
        <div class="m-t-xs">
            <div class="input-group content-width-limit-400">
                <span class="input-group-addon abroder-no p-x"><b>${views.setting_auto['存款']}:</b></span>
                <input type="number" class="form-control" name="sysParam[0].paramValue" value="${empty depositFee.paramValue ? depositFee.defaultValue : depositFee.paramValue}">
                <span class="input-group-addon">%</span>
                <span class="input-group-addon abroder-no p-x"><b>${views.setting_auto['取款']}:</b></span>
                <input type="number" class="form-control" name="sysParam[1].paramValue" value="${empty withdrawFee.paramValue ? withdrawFee.defaultValue : withdrawFee.paramValue}">
                <span class="input-group-addon">%</span>
            </div>
        </div>
        <div class="m-b" style="margin-top: 20px;">${views.setting_auto['设置取款上下限']}</div>
        <div class="m-t-xs">
            <div class="input-group content-width-limit-400">
                <span class="input-group-addon abroder-no p-x"><b>${views.setting_auto['最小值']}:</b></span>
                <input type="number" class="form-control" name="sysParamLimit[0].paramValue" value="${empty withdrawLimitMin.paramValue ? withdrawLimitMin.defaultValue : withdrawLimitMin.paramValue}">
                <span class="input-group-addon abroder-no p-x"><b>${views.setting_auto['最大值']}:</b></span>
                <input type="number" class="form-control" name="sysParamLimit[1].paramValue" value="${empty withdrawLimitMax.paramValue ? withdrawLimitMax.defaultValue : withdrawLimitMax.paramValue}">
            </div>
        </div>
        <div class="m-b" style="margin-top: 20px;">设置返佣分摊比例</div>
        <div class="m-t-xs">
            <div class="input-group content-width-limit-400" style="padding: 10px 0px">
                <span class="input-group-addon abroder-no p-x"><b>返水费用:</b></span>
                <input type="number" class="form-control" name="sysParam[2].paramValue" value="${empty rakebackParam.paramValue ? rakebackParam.defaultValue : rakebackParam.paramValue}">
                <span class="input-group-addon">%</span>
                <span class="input-group-addon abroder-no p-x"><b>优惠费用:</b></span>
                <input type="number" class="form-control" name="sysParam[3].paramValue" value="${empty favorableParam.paramValue ? favorableParam.defaultValue : favorableParam.paramValue}">
                <span class="input-group-addon">%</span>
            </div>
            <div class="input-group content-width-limit-400"  style="padding: 10px 0px">
                <span class="input-group-addon abroder-no p-x"><b>行政费用:</b></span>
                <input type="number" class="form-control" name="sysParam[4].paramValue" value="${empty adminParam.paramValue ? adminParam.defaultValue : adminParam.paramValue}">
                <span class="input-group-addon">%</span>
                <span class="input-group-addon abroder-no p-x"><b>其它费用:</b></span>
                <input type="number" class="form-control" name="sysParam[5].paramValue" value="${empty otherParam.paramValue ? otherParam.defaultValue : otherParam.paramValue}">
                <span class="input-group-addon">%</span>
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