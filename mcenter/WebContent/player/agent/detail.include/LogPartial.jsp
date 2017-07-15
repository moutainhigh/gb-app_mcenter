<%@ page import="org.soul.model.sys.po.SysAuditLog" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= SysAuditLog.class %>"></c:set>
<!--日志-->
<div class="scope_wrap clearfix">
    <div>
        <div class="input-group date">
            <span class="input-group-addon abroder-no"><b>${views.common['timeRange']}：</b></span>
            <gb:dateRange format="${DateFormat.DAY}" style="width:100px" useRange="true" callback="query"
                          startName="search.operatorBegin" endName="search.operatorEnd" maxDate="${maxDate}"
                          endDate="${command.search.operatorEnd}" startDate="${command.search.operatorBegin}"/>
        </div>
    </div>
    <%--<a class="pull-right" href="/report/log/logList.html?keys=search.operator&search.roleType=player&search.entityUserId=${command.search.entityUserId}" nav-target="mainFrame">${views.role['Player.detail.log.playerLog']}</a>--%>
</div>

<table class="table table-striped table-bordered table-hover  dataTable" id="editable" aria-describedby="editable_info">
    <thead>
    <tr>
        <soul:orderColumn poType="${poType}" property="id" column="${views.column['SysAuditLog.operateTime']}"/>
        <th class="form-inline">
            <select class="co-gray form-control input-sm" name="search.operatorUserType"
                    data-target="journal${command.search.operatorId}">
                <option value="">${views.column["SysAuditLog.roles"]}</option>
                <c:forEach items="${dicts.player.user_type}" var="t">
                    <option value="${t.key}" ${command.search.operatorUserType == t.key ? "selected" : ""} >${dicts.player.user_type[t.key]}</option>
                </c:forEach>
            </select>
        </th>
        <th class="form-inline">
            <select class="co-gray form-control input-sm" name="search.operateType"
                    data-target="journal${command.search.operatorId}">
                <option value="">${views.column["SysAuditLog.operateType"]}</option>
                <c:forEach items="${dicts.player.operate_type}" var="t">
                    <option value="${t.key}" ${command.search.operateType == t.key ? "selected" : ""} >${dicts.player.operate_type[t.key]}</option>
                </c:forEach>
            </select>
        </th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${command.result}" var="l" varStatus="vs">
        <tr>
            <td>${soulFn:formatDateTz(l.operateTime, DateFormat.DAY_SECOND, timeZone)}</td>
            <td>${dicts.common.user_type[l.operatorUserType]}${l.operatorUserType!=24?'_'.concat(l.operator) : ''}</td>
            <td>
                    ${soulFn:formatLogDesc(l)}
            </td>

                <%--<td><fmt:formatDate value="${l.operateTime}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td>&lt;%&ndash;${dicts.player.user_type[l.operatorUserType]}${l.operatorUserType!=24?'_'.concat(l.operateUserAccountNumber) : ''}&ndash;%&gt;</td>
                <td>
                        ${dicts.player.operate_type[l.operateType]}
                                ${messages.log[l.description]}
                    &lt;%&ndash;<c:forEach items="${l.operateContentMap}" var="m">
                        <span class="co-gray9"> ${dicts.player.operate_content[m.key]}</span>  ${m.value}
                    </c:forEach>&ndash;%&gt;
                </td>--%>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="clearfix remark-wrap" style="text-align: right">
    <c:if test="${command.paging.totalCount > 10}">
        <c:if test="${empty roleType}">
            <a href="/report/log/logList.html?search.roleType=agent&search.entityUserId=${command.search.operatorId}"
               cssClass="pull-right" nav-target="mainFrame">${views.common['viewMore']} &gt;&gt;</a>
        </c:if>
        <c:if test="${not empty roleType}">
            <a href="/report/log/logList.html?search.roleType=top_agent&search.entityUserId=${command.search.operatorId}"
               cssClass="pull-right" nav-target="mainFrame">${views.common['viewMore']} &gt;&gt;</a>
        </c:if>
        <%--<soul:button target="${root}/player/view/journalMore.html?search.operatorId=${command.search.operatorId}&paging.pageSize=10" opType="dialog" cssClass="pull-right" text="${views.common['viewMore']} &gt;&gt;"/>--%>
    </c:if>
</div>
<%--<soul:import res="gb/components/dateField"/>--%>