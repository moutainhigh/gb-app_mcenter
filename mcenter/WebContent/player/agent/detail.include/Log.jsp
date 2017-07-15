<%@ page import="org.soul.model.sys.po.SysAuditLog" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= SysAuditLog.class %>"></c:set>
<!--日志-->
<form name="agentLogForm" action="${root}/userAgent/agent/log.html?search.operatorId=${command.search.operatorId}">
    <%@include file="LogPartial.jsp"%>
</form>
<script type="text/javascript">
    curl(["site/player/agent/AgenteLog"], function (AgenteLog) {
        page.agenteLog = new AgenteLog();
    });
</script>

<%--<soul:import res="gb/components/dateField"/>--%>