<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerAdvisoryReplyListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="form-group over clearfix m-b-n-xs">
    <input type="hidden" name="search.playerId" value="${command.search.playerId}"/>
    <table class="table table-striped table-bordered table-hover dataTable" aria-describedby="editable_info">
        <thead>
        <tr>
            <th>${views.column["VPlayerAdvisory.advisoryType"]}</th>
            <th>${views.column["VPlayerAdvisory.advisoryTitle"]}</th>
            <th>${views.column["VPlayerAdvisory.advisoryContent"]}</th>
            <th>${views.column["VPlayerAdvisory.advisoryTime"]}</th>
            <th>${views.column["VPlayerAdvisory.operate"]}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="s" varStatus="vs">
            <tr>
                <td>${dicts.player.advisory_type[s.advisoryType]}</td>
                <td><c:out value="${s.advisoryTitle}" escapeXml="true" /></td>
                <td title='<c:out value="${s.advisoryContent}" escapeXml="true" />'>
                    <c:out value="${fn:substring(s.advisoryContent,0,20)}" escapeXml="true" />
                    <c:if test="${fn:length(s.advisoryContent)>20}">...</c:if>
                </td>
                <td>${soulFn:formatDateTz(s.advisoryTime, DateFormat.DAY_SECOND,timeZone)}</td>
                <td>
                    <soul:button cssClass="btn a-lit" target="${root}/player/view/playerAdvisory.html?id=${s.id}" text="${views.role['view']}" opType="dialog"/>
                    <soul:button cssClass="btn a-lit" target="${root}/player/delete/reply.html?id=${s.id}" text="${views.common['delete']}" opType="ajax" dataType="json" confirm="${views.role['player.view.advisory.sureToDelete']}？" callback="query"/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination  mode="mini"/>