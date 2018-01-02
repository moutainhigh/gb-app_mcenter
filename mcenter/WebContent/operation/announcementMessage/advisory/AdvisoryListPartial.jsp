<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerAdvisoryListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--咨询-->

<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
        <thead>
        <tr class="bg-gray">
            <th><input type="checkbox" class="i-checks"></th>
            <th>
                <gb:select name="search.advisoryType" value="${command.search.advisoryType}" cssClass="btn-group chosen-select-no-single" prompt="${views.common['all']}"
                           list="${advisoryType}" listKey="key" listValue="${dicts.common.advisory_type[key]}" callback="query"/>
            </th>
            <th>${views.column["VUserPlayer.username"]}</th>
            <th>${views.column["VPlayerAdvisory.advisoryTitle"]}</th>
            <th>${views.column["VPlayerAdvisory.advisoryAndReplyTime"]}</th>
            <th>${views.column["VPlayerAdvisory.advisoryReplyTitle"]}</th>
            <th>${views.column["VPlayerAdvisory.advisoryReplyTime"]}</th>
            <th>${views.column["VPlayerAdvisory.operate"]}</th>
        </tr>
        <tr class="bd-none hide">
            <th colspan="8">
                <div class="select-records"><i class="fa fa-exclamation-circle"></i>${views.role['player.cancelSelectAll.prefix']}&nbsp;<span id="page_selected_total_record"></span>${views.role['player.cancelSelectAll.middlefix']}
                    <soul:button target="cancelSelectAll" opType="function" text="${views.role['player.cancelSelectAll']}"/>${views.role['player.cancelSelectAll.suffix']}
                </div>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="s" varStatus="status">
            <c:if test="${s.questionType=='1'}">
            <tr>
                <td><input type="checkbox" value="${s.id}" class="i-checks"/></td>
                <td>
                    <c:choose>
                        <c:when test="${!s.read}">
                            <b>${dicts.player.advisory_type[s.advisoryType]}</b>
                        </c:when>
                        <c:otherwise>
                            ${dicts.player.advisory_type[s.advisoryType]}
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <shiro:hasPermission name="role:player_detail"><a href="/player/playerView.html?search.id=${s.playerId}" nav-target="mainFrame"></shiro:hasPermission>
                    ${s.username}
                    <shiro:hasPermission name="role:player_detail"></a></shiro:hasPermission>
                </td>
                <td>

                    <c:choose>
                        <c:when test="${!s.read}">

                            <b title='<c:out value="${s.advisoryTitle}" escapeXml="true" />'>
                                ${s.continueQuizCount>0?views.operation['SystemAnnouncement.playersAdvisory.inquiry']:""}
                                <c:out value=" ${ fn:substring(s.advisoryTitle, 0, 30) } "  escapeXml="true" />
                                <c:if test="${fn:length(s.advisoryTitle)>30}">...</c:if></b>
                        </c:when>
                        <c:otherwise>
                            <span title='<c:out value=" ${s.advisoryTitle} "  escapeXml="true" />'>
                            ${s.continueQuizCount>0?views.operation['SystemAnnouncement.playersAdvisory.inquiry']:""}
                            <c:out value=" ${ fn:substring(s.advisoryTitle, 0, 30) } "  escapeXml="true" /><c:if test="${fn:length(s.advisoryTitle)>30}">...</c:if>
                                </span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${!s.read}">
                            <b> ${soulFn:formatDateTz(s.advisoryTime, DateFormat.DAY_SECOND,timeZone)}</b>
                        </c:when>
                        <c:otherwise>
                            ${soulFn:formatDateTz(s.advisoryTime, DateFormat.DAY_SECOND,timeZone)}
                        </c:otherwise>
                    </c:choose>
                </td>
                <c:set value='${fn:replace(s.replyTitle, " ", "")}' var="replyTitle"></c:set>
                <td title="${replyTitle}">
                    <c:choose>
                        <c:when test="${!s.read}">
                            <b>${fn:substring(replyTitle, 0, 30)}<c:if test="${fn:length(replyTitle)>30}">...</c:if></b>
                        </c:when>
                        <c:otherwise>
                            ${fn:substring(replyTitle, 0, 30)}<c:if test="${fn:length(replyTitle)>30}">...</c:if>
                        </c:otherwise>
                    </c:choose>

                </td>
                <td>
                    <c:choose>
                        <c:when test="${!s.read}">
                            <b>  ${soulFn:formatDateTz(s.replyTime, DateFormat.DAY_SECOND,timeZone)}</b>
                        </c:when>
                        <c:otherwise>
                            ${soulFn:formatDateTz(s.replyTime, DateFormat.DAY_SECOND,timeZone)}
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <soul:button cssClass="btn a-lit"
                                 target="${root}/player/view/playerAdvisory.html?id=${s.id}&continueQuizId=${s.continueQuizId}"
                                 text="${views.operation['SystemAnnouncement.playersAdvisory.reply']}" opType="dialog" callback="callBackQuery"/>
                </td>
            </tr>
            </c:if>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination/>