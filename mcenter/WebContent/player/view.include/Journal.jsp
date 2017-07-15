<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%--@elvariable id="command" type="org.soul.model.sys.vo.SysAuditLogListVo"--%>
<c:set var="poType" value="<%= SysAuditLog.class %>"></c:set>
<!--日志-->
<form name="journalForm" action="${root}/player/view/journal.html?search.operatorId=${command.search.operatorId}&search.entityUserId=${command.search.entityUserId}">
<%@include file="JournalPartial.jsp"%>
</form>
<script type="text/javascript">
    curl(["site/player/view.include/Journal"], function (Journal) {
        page.journal = new Journal();
    });
</script>
