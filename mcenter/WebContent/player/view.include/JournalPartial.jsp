<%@ page import="org.soul.model.sys.po.SysAuditLog" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%--@elvariable id="command" type="org.soul.model.sys.vo.SysAuditLogListVo"--%>
<c:set var="poType" value="<%= SysAuditLog.class %>"></c:set>
<div class="scope_wrap clearfix">
    <div>
        <div class="input-group date">
            <span class="input-group-addon abroder-no"><b> ${views.role['Player.detail.log.timeRange']}</b></span>
            <gb:dateRange format="${DateFormat.DAY}" style="width:100px" useRange="true" callback="query"
                          startName="search.operatorBegin" endName="search.operatorEnd" maxDate="${nowTime}"
                          endDate="${command.search.operatorEnd}" startDate="${command.search.operatorBegin}"/>
        </div>
        <soul:button text="" target="query" opType="function" cssClass="btn btn-outline btn-filter" tag="button">
            <i class="fa fa-search"></i>
            <span class="hd">&nbsp;${views.common['search']}</span>
        </soul:button>
    </div>
    <%--<a class="pull-right" href="/report/log/logList.html?keys=search.operator&search.roleType=player&search.entityUserId=${command.search.entityUserId}" nav-target="mainFrame">${views.role['Player.detail.log.playerLog']}</a>--%>
</div>
<div class="table-responsive  table-min-h">
    <table class="table table-striped table-bordered table-hover dataTable m-b-none" name="journalTable">
        <thead>
        <tr>
            <th>${views.report['log.query.username']}</th>
            <th>${views.report['log.title.oprtime']}</th>
            <th>${views.report['log.query.ip']}</th>
            <th>${views.report['log.title.client']}</th>
            <th class="inline">
                <gb:select callback="journal.query" name="search.operateType" cssClass="btn-group chosen-select-no-single" prompt="${views.column['SysAuditLog.operateType']}" list="${opType}" listKey="key" listValue="${dicts.log.op_type[key]}" value="${command.search.operateType}"/>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="l" varStatus="vs">
            <tr>
                <td>${l.operator}</td>
                <td>${soulFn:formatDateTz(l.operateTime, DateFormat.DAY_SECOND, timeZone)}</td>
                <td>
                    <a href="/fund/playerDetect/userPlayView.html?search.username=${l.operator}" nav-target="mainFrame">
                        ${soulFn:formatIp(l.operateIp)}
                    </a>
                    <br>
                    ${gbFn:getIpRegion(l.operateIpDictCode)}
                </td>
                <td>${views.report['log.label.os']}${l.clientOs}&nbsp;&nbsp;${views.report['log.label.browser']}${l.clientBrowser}</td>
                <td>${soulFn:formatLogDesc(l)}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="clearfix remark-wrap" style="text-align: right;">
    <c:if test="${command.paging.totalCount > 10}" >
        <a href="/report/log/logList.html?search.roleType=player&search.entityUserId=${command.search.entityUserId}" cssClass="pull-right" nav-target="mainFrame">${views.common['viewMore']} &gt;&gt;</a>
        <%--<soul:button target="${root}/player/view/journalMore.html?search.operatorId=${command.search.operatorId}&search.entityUserId=${command.search.entityUserId}" opType="dialog" cssClass="pull-right" text="${views.common['viewMore']} &gt;&gt;"/>--%>
    </c:if>
</div>