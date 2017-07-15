<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerAdvisoryReplyListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="form-group over clearfix m-b-n-xs">
    <input type="hidden" name="search.playerAdvisoryId" value="${listVo.search.playerAdvisoryId}"/>
    <table class="table table-striped table-bordered table-hover dataTable" aria-describedby="editable_info">
        <thead>
        <tr>
            <th>${listVo.search.playerAdvisoryId}${views.column["PlayerAdvisoryReply.replyTime"]}</th>
            <th>${views.column["PlayerAdvisoryReply.replyTitle"]}</th>
            <th>${views.column["PlayerAdvisoryReply.replyContent"]}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="s" varStatus="vs">
            <tr>
                <td>${soulFn:formatDateTz(s.replyTime, DateFormat.DAY_SECOND,timeZone)}</td>
                <td>${s.replyTitle}</td>
                <td title="${s.replyContent}">${fn:substring(s.replyContent, 0, 20)}<c:if test="${fn:length(s.replyContent)>20}">...</c:if></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination mode="mini"/>