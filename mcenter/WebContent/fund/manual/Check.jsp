<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
    <%@ include file="/include/include.js.jsp" %>
</head>

<body>
<form:form>
    <div class="modal-body">
        <div class="line-hi34 m-sm">
            <span class="m-r">${views.fund['以下玩家账号不存在，请先修改']}</span>
        </div>
        <div class="m-sm">
            <div class="gray-chunk remind-chunk clearfix">
                <c:set var="len" value="${fn:length(illegalNames)-1}"/>
                ${fn:endsWith(illegalNames,",")?fn:substring(illegalNames, 0, len-1):illegalNames}
                <%--<c:set var="len" value="${fn:length(illegalNames)-1}"/>
                <c:forEach items="${illegalNames}" var="i" varStatus="vs">
                    ${i}
                    <c:if test="${vs.index!=len}">
                        ,
                    </c:if>
                </c:forEach>--%>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button target="closePage" text="${views.fund_auto['返回修改']}" opType="function" tag="button" cssClass="btn btn-filter"/>
    </div>
</form:form>
</body>
<soul:import type="edit"/>
</html>

