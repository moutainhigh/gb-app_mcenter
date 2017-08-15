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
    <input type="hidden" name="sysParam[4].id" value="${otherParam.id}">
    <input type="hidden" name="sysParam[5].id" value="${preferentialParam.id}">
    <input type="hidden" name="sysParam[6].id" value="${rakbackParam.id}">
    <input type="hidden" name="sysParam[7].id" value="${topOtherParam.id}">
    <input type="hidden" name="sysParamLimit[0].id" value="${withdrawLimitMin.id}">
    <input type="hidden" name="sysParamLimit[1].id" value="${withdrawLimitMax.id}">
    <div id="validateRule" style="display: none">${validateRule}</div>
    <div class="modal-body">
        <div class="m-b"><b>${views.setting_auto['设置存取款手续费']}</b></div>
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
        <div class="m-b" style="margin-top: 20px;"><b>${views.setting_auto['设置取款上下限']}</b></div>
        <div class="m-t-xs">
            <div class="input-group content-width-limit-400">
                <span class="input-group-addon abroder-no p-x"><b>${views.setting_auto['最小值']}:</b></span>
                <input type="number" class="form-control" name="sysParamLimit[0].paramValue" value="${empty withdrawLimitMin.paramValue ? withdrawLimitMin.defaultValue : withdrawLimitMin.paramValue}">
                <span class="input-group-addon abroder-no p-x"><b>${views.setting_auto['最大值']}:</b></span>
                <input type="number" class="form-control" name="sysParamLimit[1].paramValue" value="${empty withdrawLimitMax.paramValue ? withdrawLimitMax.defaultValue : withdrawLimitMax.paramValue}">
            </div>
        </div>
        <div class="m-b abroder-no p-x" style="margin-top: 20px;"><b>${views.operation_auto['设置返佣分摊比例']}</b></div>
        <div class="m-t-xs">
            <table class="" width="100%">
                <thead>
                    <tr>
                        <td width="15%"></td>
                        <td width="30%"><span class="input-group-addon abroder-no p-x" style="padding: 5px 0px">${views.setting['apportion.page.item.agent.percent']}</span></td>
                        <td width="30%"><span class="input-group-addon abroder-no p-x" style="padding: 5px 0px">${views.setting['apportion.page.item.topagent.percent']}</span></td>
                        <td></td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><span class="input-group-addon abroder-no p-x"><b>${views.operation_auto['返水费用']}</b></span></td>
                        <td><div class="input-group content-width-limit-10" style="padding: 5px 0px"><input type="number" class="form-control ratio" name="sysParam[2].paramValue" value="${empty rakebackParam.paramValue ? rakebackParam.defaultValue : rakebackParam.paramValue}"><span class="input-group-addon">%</span></div></td>
                        <td class="top_agent"><div class="input-group content-width-limit-10" style="padding: 5px 0px"><input type="number" class="form-control ratio" readonly name="sysParam[6].paramValue" value="${empty rakbackParam.paramValue ? rakbackParam.defaultValue : rakbackParam.paramValue}"><span class="input-group-addon">%</span></div></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><span class="input-group-addon abroder-no p-x"><b>${views.operation_auto['优惠费用']}</b></span></td>
                        <td><div class="input-group content-width-limit-10" style="padding: 5px 0px"><input type="number" class="form-control ratio" name="sysParam[3].paramValue" value="${empty favorableParam.paramValue ? favorableParam.defaultValue : favorableParam.paramValue}"><span class="input-group-addon">%</span></div></td>
                        <td class="top_agent"><div class="input-group content-width-limit-10" style="padding: 5px 0px"><input type="number" class="form-control ratio" readonly name="sysParam[5].paramValue" value="${empty preferentialParam.paramValue ? preferentialParam.defaultValue : preferentialParam.paramValue}"><span class="input-group-addon">%</span></div></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><span class="input-group-addon abroder-no p-x"><b>${views.operation_auto['其它费用']}</b></span></td>
                        <td><div class="input-group content-width-limit-10" style="padding: 5px 0px"><input type="number" class="form-control ratio" name="sysParam[4].paramValue" value="${empty otherParam.paramValue ? otherParam.defaultValue : otherParam.paramValue}"><span class="input-group-addon">%</span></div></td>
                        <td class="top_agent"><div class="input-group content-width-limit-10" style="padding: 5px 0px"><input type="number" class="form-control ratio" readonly name="sysParam[7].paramValue" value="${empty topOtherParam.paramValue ? topOtherParam.defaultValue : topOtherParam.paramValue}"><span class="input-group-addon">%</span></div></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>

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
<soul:import res="site/setting/rebate/EditParam"/>
</html>