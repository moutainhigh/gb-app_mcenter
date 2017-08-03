<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.UserBankcardVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form method="post" name="addBankForm">
    <gb:token/>
    <div id="validateRule" style="display: none">${validate}</div>
    <input type="hidden" name="result.userId" value="${command.search.userId}"/>
    <div class="modal-body">
        <div class="form-group over clearfix">
            <label class="col-xs-3 al-right">${views.player_auto['比特币地址']}：</label>
            <div class="col-xs-9 p-x">
                <input type="text" name="result.bankcardNumber" value="${command.result.bankcardNumber}" class="form-control"/>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button precall="validateForm" cssClass="btn btn-filter" callback="saveCallbak" text="${views.common['OK']}" opType="ajax" dataType="json" target="${root}/player/bindBtcByManager.html" post="getCurrentFormData"/>
        <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import type="edit"/>
</html>