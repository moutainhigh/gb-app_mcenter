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
    <form:form method="post">
        <div id="validateRule" style="display: none">${validate}</div>
        <form:input path="result.id" type="hidden"/>
        <form:input path="result.userId" type="hidden"/>
        <form:input path="result.bankcardMasterName" type="hidden"/>
        <div class="modal-body">
            <div class="form-group over clearfix">
                <label class="col-xs-3 al-right">${views.column['UserBankcard.bankcardMasterName']}：</label>
                <div class="col-xs-9 p-x">${command.result.bankcardMasterName}</div>
            </div>
            <div class="form-group over clearfix">
                <label class="col-xs-3 al-right">${views.column['UserBankcard.bankName']}：</label>
                <div class="col-xs-9 p-x">
                    <form:select class="btn-group chosen-select-no-single" path="result.bankName">
                        <c:forEach items="${bankListVo.result}" var="i">
                            <option value="${i.bankName}" ${command.result.bankName==i.bankName?'selected':''}>${dicts.common.bankname[i.bankName]}</option>
                        </c:forEach>
                    </form:select>
                </div>
            </div>
            <div class="form-group over clearfix">
                <label class="col-xs-3 al-right" for="result.bankcardNumber">${views.column['UserBankcard.bankcardNumber']}：</label>
                <div class="col-xs-9 p-x">
                    <form:input type="text" class="form-control" path="result.bankcardNumber" value="${command.result.bankcardNumber}"/>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <soul:button precall="validateForm" cssClass="btn btn-filter" callback="saveCallbak" text="${views.common['OK']}" opType="ajax" dataType="json" target="${root}/userAgent/topagent/bankCardSave.html" post="getCurrentFormData"/>
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
        </div>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import type="edit"/>
</html>