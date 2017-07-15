<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--咨询-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="table-responsive" id="tab-1">
    <table class="table table-striped table-bordered table-hover  dataTable" id="editable"
           aria-describedby="editable_info">
        <thead>
        <tr>
            <th>${views.column["VPlayerAdvisory.advisoryType"]}</th>
            <th>${views.column["VPlayerAdvisory.advisoryTitle"]}</th>
            <th>${views.column["VPlayerAdvisory.advisoryTime"]}</th>
            <th>${views.column["VPlayerAdvisory.advisoryReplyTitle"]}</th>
            <th>${views.column["VPlayerAdvisory.advisoryReplyTime"]}</th>
            <th>${views.column["VPlayerAdvisory.operate"]}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="s" varStatus="status">
            <c:if test="${s.questionType=='1'}">
            <tr class="tab-detail ${s.read==false?' ft-bold':''}">
                <td>${dicts.player.advisory_type[s.advisoryType]}</td>
                <td title='<c:out value="${s.advisoryTitle}" escapeXml="true" />'>
                    ${s.continueQuizCount>0?views.role['Player.detail.advisory.question']:""}
                        <c:out value="${fn:substring(s.advisoryTitle,0,20)}" escapeXml="true" />
                    <c:if test="${fn:length(s.advisoryTitle)>20}">...</c:if>
                </td>
                <td>${soulFn:formatDateTz(s.advisoryTime, DateFormat.DAY_SECOND,timeZone)}</td>
                <td title="${s.replyTitle}">${fn:substring(s.replyTitle,0,20)}<c:if test="${fn:length(s.replyTitle)>20}">. . .</c:if></td>
                <td>${soulFn:formatDateTz(s.replyTime, DateFormat.DAY_SECOND,timeZone)}</td>
                <td>
                    <soul:button cssClass="btn a-lit"
                                 target="${root}/player/view/playerAdvisory.html?id=${s.id}&continueQuizId=${s.continueQuizId}"
                                 text="${views.role['Player.detail.advisory.Reply']}" title="${views.role['Player.detail.advisory.contact']}" opType="dialog" callback="loadAdvisory.query"/>
                </td>
            </tr>
            </c:if>
        </c:forEach>
        </tbody>
    </table>
        </div></div>
    <soul:pagination/>