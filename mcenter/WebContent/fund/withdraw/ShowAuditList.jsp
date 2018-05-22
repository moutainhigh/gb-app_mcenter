<%@ page import="org.soul.web.session.SessionManagerBase" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.vplayerwithdrawvo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.fund['despoit.check.confirmCheck']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form>
    <input type="hidden" name="playerId" value="${user.id}"/>
    <div class="modal-body" style="" id="modal-body">
        <%@include file="AuditListRecord.jsp"%>
    </div>
    <div class="modal-footer">
        <c:if test="${withdrawRecord.withdrawStatus=='1'&&withdrawRecord.isLock=='1'&&not empty listVo}">
            <c:if test="${withdrawRecord.lockPersonId==currentUser.id}">
                <soul:button cssClass="btn btn-filter btn-edit-audit" opType="ajax" target="${root}/fund/withdraw/updateAuditFee.html"
                             post="buildPostData" callback="changeAuditFeeCallback"
                             precall="myValidateForm" text="${views.common['save']}"/>
            </c:if>
        </c:if>
            <%--<button type="button" class="btn btn-filter">${views.fund_auto['保存']}</button>--%>
        <soul:button cssClass="btn btn-outline btn-filter" opType="function" target="closePage"
                     text="${views.common['cancel']}"/>
    </div>
</form:form>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/fund/withdraw/ShowAuditList"/>
</body>
</html>
