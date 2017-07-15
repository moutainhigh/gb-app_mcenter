<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%@page import="java.util.TimeZone"%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sport.vo.VSportRecommendedListVo"--%>
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
        <thead>
        <tr class="bg-gray">
            <th>${view.common['number']}</th>
            <th>${views.column['VSportRecommended.timeStone']}</th>
            <th>${views.column['VSportRecommended.startTime']}</th>
            <th class="inline">
                <gb:select callback="query" prompt="${views.common['all_type']}" cssClass="chosen-select-no-single" name="search.matchType" value="${command.search.matchType}" list="${command.matchType}" listKey="key" listValue="value"></gb:select>
            </th>
            <th>${views.column['VSportRecommended.hostTeamId']}</th>
            <th>${views.column['VSportRecommended.hostTeamOdds']}</th>
            <th>${views.column['VSportRecommended.concedePoints']}</th>
            <th>${views.column['VSportRecommended.guestTeamId']}</th>
            <th>${views.column['VSportRecommended.guestTeamOdds']}</th>
            <th>${views.column['VSportRecommended.gameId']}</th>
            <th>${views.column['VSportRecommended.showStartTime']}</th>
            <th>${views.common['operate']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="r" varStatus="status">
            <tr>
                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                <td>${dicts.common.time_zone[r.timeStone]}</td>
                <c:set value="${soulFn:formatDateTz(r.startTime, DateFormat.DAY_MINUTE,gbFn:getTimezoneByGmt(r.timeStone))}" var="startTime"/>
                <td>${startTime.substring(5)}</td>
                <td>${command.matchTypeMap[r.matchType]}</td>
                <td><img src="${soulFn:getThumbPath(domain,r.hostTeamLogo,66,24)}">${r.hostTeamNameMap[language]}</td>
                <td>${r.hostTeamOdds}</td>
                <td>${r.concedePoints}</td>
                <td><img src="${soulFn:getThumbPath(domain,r.guestTeamLogo,66,24)}">${r.guestTeamNameMap[language]}</td>
                <td>${r.guestTeamOdds}</td>
                <td>${gbFn:getApiName(r.apiId.toString())}-${gbFn:getGameName(r.gameId.toString())}</td>
                <td>
                        ${soulFn:formatDateTz(r.showStartTime, DateFormat.DAY_SECOND,timeZone)}
                         ${views.common['TO']}
                        ${soulFn:formatDateTz(r.showEndTime, DateFormat.DAY_SECOND,timeZone)}
                </td>
                <td>
                    <input type="checkbox" recomendId="${r.id}" name="my-checkbox" data-size="mini" <c:forEach items="${command.recId}" var="recId"><c:if test="${recId eq r.id}">checked</c:if></c:forEach>>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination/>