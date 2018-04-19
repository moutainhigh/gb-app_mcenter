<%@ include file="/include/include.inc.jsp" %>
<c:choose>
    <c:when test="${empty command.floatType}">
        <%@ include file="FloatEdit.jsp" %>
    </c:when>
    <c:otherwise>
        <%@ include file="ActivityEdit.jsp" %>
    </c:otherwise>
</c:choose>