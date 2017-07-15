<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/include/include.inc.jsp" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerRankVo"--%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form>
    <div id="validateRule" style="display: none">${rule}</div>
    <input type="hidden" name="pv[11].id" value="${p11.id}">
    <input type="hidden" name="pv[12].id" value="${p12.id}">
    <div class="modal-body">
        <div>
            <input type="checkbox" name="p11.active" class="i-checks" ${p11.active ? 'checked' : ''} value="true">
            ${views.content['warningSetting.account.unusual.case1']}：
            <span class="co-orange">X</span>
            ${views.content['warningSetting.account.unusual.inhour1']}
            <span class="co-orange">X</span>
            ${views.content['warningSetting.account.unusual.inhour2']}
            <span class="co-orange">X</span>
            ${views.content['warningSetting.account.unusual.inhour3']}
        </div>
        <br>
        <div class="form-group clearfix">
            <label class="col-xs-3  al-right line-hi34">${views.content['warningSetting.account.unusual.time']}：</label>
            <div class="col-xs-8 p-x">
                <input type="text" class="form-control" name="pv[11].v1" value="${fn:split(p11.paramValue, ',')[0]}" maxlength="10">
            </div>
        </div>
        <div class="form-group clearfix">
            <label class="col-xs-3  al-right line-hi34">${views.content['warningSetting.account.unusual.playerCount']}：</label>
            <div class="col-xs-8 p-x">
                <input type="text" class="form-control" name="pv[11].v2" value="${fn:split(p11.paramValue, ',')[1]}" maxlength="10">
            </div>
        </div>
        <div class="form-group clearfix">
            <label class="col-xs-3  al-right line-hi34">${views.content['warningSetting.account.unusual.errorCount']}：</label>
            <div class="col-xs-8 p-x">
                <input type="text" class="form-control" name="pv[11].v3" value="${fn:split(p11.paramValue, ',')[2]}" maxlength="10">
            </div>
        </div>
        <div>
            <input type="checkbox" name="p12.active" class="i-checks" ${p12.active ? 'checked' : ''} value="true">
            ${views.content['warningSetting.account.unusual.case2']}：<span class="co-orange">X</span>${views.content['warningSetting.account.unusual.inhour4']}
        </div>
        <br>
        <div class="form-group clearfix">
            <label class="col-xs-3  al-right line-hi34">${views.content['warningSetting.account.unusual.time']}：</label>
            <div class="col-xs-8 p-x">
                <input type="text" class="form-control" name="pv[12].paramValue" value="${p12.paramValue}" maxlength="10">
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.common.OK}" opType="ajax" precall="validateFormAndSubmit" target="${root}/payAccount/saveWarningUnusualSettings.html" dataType="json" post="getCurrentFormData" callback="closePage"/>
        <soul:button cssClass="btn btn-outline btn-filter" target="closePage" opType="function" text="${views.common.cancel}"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/payaccount/WarningSettingsOfUnusual"/>
</html>