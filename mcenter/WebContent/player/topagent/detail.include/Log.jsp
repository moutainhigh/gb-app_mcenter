<%@ page import="org.soul.model.sys.po.SysAuditLog" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= SysAuditLog.class %>"></c:set>
<!--日志-->
<form name="journalForm" action="${root}/userAgent/agent/log.html?search.operatorId=${command.search.operatorId}">
    <div class="scope_wrap clearfix">
        <div class="col-sm-6 form-inline al-left">
            ${views.common['timeRange']}：
            <div class="input-group date">
                <gb:dateRange format="${DateFormat.DAY}" style="width:100px" useRange="true"  callback="query"
                              startDate="${command.search.startTime}" endDate="${command.search.endTime}"
                              startName="search.startTime" endName="search.endTime"/>
            </div>
        </div>
    </div>
    <table class="table table-striped table-bordered table-hover  dataTable" id="editable" aria-describedby="editable_info">
        <thead>
        <tr>
            <soul:orderColumn poType="${poType}" property="id" column="${views.column['SysAuditLog.operateTime']}"/>
            <th class="form-inline">
                <select class="co-gray form-control input-sm" name="search.operatorUserType" data-target="journal${command.search.playerId}">
                    <option value="">${views.column["SysAuditLog.roles"]}</option>
                    <C:forEach items="${dicts.player.user_type}" var="t">
                        <option value="${t.key}" ${command.search.operatorUserType == t.key ? "selected" : ""} >${dicts.player.user_type[t.key]}</option>
                    </C:forEach>
                </select>
            </th>
            <th class="form-inline">
                <select class="co-gray form-control input-sm" name="search.operateType" data-target="journal${command.search.playerId}" >
                    <option value="">${views.column["SysAuditLog.operateType"]}</option>
                    <C:forEach items="${dicts.player.operate_type}" var="t">
                        <option value="${t.key}" ${command.search.operateType == t.key ? "selected" : ""} >${dicts.player.operate_type[t.key]}</option>
                    </C:forEach>
                </select>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="l" varStatus="vs">
            <tr>
                <%--<td><fmt:formatDate value="${l.operateTime}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td>&lt;%&ndash;${dicts.player.user_type[l.operatorUserType]}${l.operatorUserType!=24?'_'.concat(l.operateUserAccountNumber) : ''}&ndash;%&gt;</td>
                <td>
                        ${dicts.player.operate_type[l.operateType]}
                    &lt;%&ndash;<c:forEach items="${l.operateContentMap}" var="m">
                        <span class="co-gray9"> ${dicts.player.operate_content[m.key]}</span>  ${m.value}
                    </c:forEach>&ndash;%&gt;
                </td>--%>
                    <td>${soulFn:formatDateTz(l.operateTime, DateFormat.DAY_SECOND, timeZone)}</td>
                    <td>${dicts.common.user_type[l.operatorUserType]}${l.operatorUserType!=24?'_'.concat(l.operator) : ''}</td>
                    <td>
                            ${soulFn:formatLogDesc(l)}
                    </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="clearfix remark-wrap">
        <c:if test="${command.paging.totalCount > 10}" >
            <soul:button target="${root}/player/view/journalMore.html?search.playerId=${command.search.playerId}&paging.pageSize=10" opType="dialog" cssClass="pull-right" text="${views.common['viewMore']} &gt;&gt;"/>
        </c:if>
    </div>
</form>
<script type="text/javascript">
    curl(["site/player/view.include/Journal"], function (Journal) {
        page.journal = new Journal();
    });
</script>

<%--<soul:import res="gb/components/dateField"/>--%>