<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form>
    <div id="validateRule" style="display: none">${validate}</div>
    <input name="result.nickname" type="hidden" value="${command.result.realName}"/>
    <input name="result.username" type="hidden" value="${command.result.username}"/>
    <!--修改真实姓名-->
    <div class="modal-body">
        <div class="form-group clearfix line-hi34">
            <label class="col-xs-3 al-right">${views.role['Player.detail.info.realName']}</label>
            <div class="col-xs-8 p-x"><input class="form-control" name="result.realName"></div>
        </div>
        <div class="form-group clearfix line-hi34">
            <label class="col-xs-3 al-right">${views.role['Player.detail.info.okRealName']}</label>
            <div class="col-xs-8 p-x"><input class="form-control" name="result.newRealName"></div>
        </div>
    </div>
    <div class="modal-footer">
        <input type="hidden" name="result.id" value="${command.result.id}">
        <soul:button cssClass="btn btn-filter" text="${views.common.OK}" opType="function" precall="validateForm" target="editRealName"/>
        <soul:button cssClass="btn btn-outline btn-filter" target="closePage" opType="function" text="${views.common.cancel}"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/player/editPlayerRealName/editRealName"/>
</html>