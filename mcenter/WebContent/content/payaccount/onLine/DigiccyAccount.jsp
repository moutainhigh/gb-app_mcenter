<%--@elvariable id="info" type="so.wwb.gamebox.model.master.digiccy.po.DigiccyAccountInfo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form method="post" name="digiccyAccountForm">
    <div class="modal-body">
        <div class="form-group over clearfix">
            <label for="code" class="col-xs-3 al-right">${views.content_auto['渠道']}：</label>
            <div class="col-xs-9 p-x">
                <select name="code" id="code" class="btn-group chosen-select-no-single">
                    <c:forEach items="${providers}" var="i">
                        <option value="${i.key}">${dicts.common.digiccy_provider[i.key]}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="form-group over clearfix">
            <label for="account" class="col-xs-3 al-right">${views.content_auto['用户名']}：</label>
            <div class="col-xs-9 p-x">
                <input name="account" id="account" type="text" class="form-control" value="${info.decAccount}"/>
            </div>
        </div>
        <div class="form-group over clearfix">
            <label for="pwd" class="col-xs-3 al-right">${views.content_auto['密码']}：</label>
            <div class="col-xs-9 p-x">
                <input name="pwd" id="pwd" type="text" class="form-control" value="${info.decPwd}"/>
            </div>
        </div>
        <div class="form-group over clearfix">
            <label class="col-xs-3 al-right">${views.content_auto['状态']}：</label>
            <div class="col-xs-9 p-x">
                <input type="checkbox" name="status" value="1" data-size="mini" ${info.status eq '1'?'checked':''}>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button precall="validateForm" cssClass="btn btn-filter" callback="saveCallbak" text="${views.common['OK']}" opType="ajax" dataType="json" target="${root}/payAccount/saveDigiccyAccount.html" post="getCurrentFormData"/>
        <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
    </div>
</form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/payaccount/onLine/DigiccyAccount"/>
</html>