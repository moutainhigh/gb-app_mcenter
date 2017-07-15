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
        ${fn:replace(fn:replace(views.fund['成功存入'],"[0}" ,successNum ), "[1]", failNum)}
        <div class="line-hi34 m-sm">
            <span class="m-r">${views.fund['以下玩家存款失败：']}</span>
        </div>
        <div class="m-sm">
            <div class="gray-chunk remind-chunk clearfix">
                <c:set var="len" value="${fn:length(operateFails)-1}"/>
                <c:forEach items="${operateFails}" var="i" varStatus="vs">
                    ${i}
                    <c:if test="${vs.index!=len}">
                        ,
                    </c:if>
                </c:forEach>
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

