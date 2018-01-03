<%--@elvariable id="command" type="org.soul.model.sys.vo.SysAuditLogListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<!--暂不启用-->
<%--<div class="pull-right m-t-n-xxs" style="padding: 10px 10px">
    <soul:button tag="button" cssClass="btn btn-primary-hide" callback="toExportHistory"
                 text="${views.report['fund.list.export']}" precall="validateData" title="${views.report['fund.list.export']}"
                 target="${root}/report/log/exportRecords.html" opType="dialog">
        <i class="fa fa-sign-out"></i><span class="hd">${views.report['operate.list.export']}</span>
    </soul:button>
    <a href="/share/exports/exportHistoryList.html" nav-target="mainFrame" class="hide" id="toExportHistory"></a>
</div>
<input type="hidden" value="${conditionJson}" id="conditionJson">--%>
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.report['log.title.no']}</th>
            <th>
                <c:choose>
                    <c:when test="${command.search.roleType ne 'player'}">
                        <gb:select name="search.operatorUserType" list="${roleKeys}" callback="query" prompt="${views.report['log.query.username']}" value="${command.search.operatorUserType}" cssClass="chosen-select-no-single" listKey="key" listValue="value" />
                    </c:when>
                    <c:otherwise>
                        ${views.report['log.query.username']}
                    </c:otherwise>
                </c:choose>
            </th>
            <th>${views.report['log.title.oprtime']}</th>
            <th>${views.report['log.query.ip']}</th>
            <th>${views.report['log.title.client']}</th>
            <th class="inline">
                <gb:select name="search.operateType" value="${command.search.operateType}" cssClass="btn-group chosen-select-no-single" prompt="${views.report['log.title.allopr']}" list="${opType}" callback="query"/>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="cmd" items="${command.result}" varStatus="vs">
            <c:choose>
                <c:when test="${command.search.roleType == 'top_agent'}">
                    <c:set var="url" value="/userAgent/topagent/detail.html?search.id=${cmd.operatorId}" />
                </c:when>
                <c:when test="${command.search.roleType == 'agent'}">
                    <c:set var="url" value="/userAgent/agent/detail.html?search.id=${cmd.operatorId}" />
                </c:when>
                <c:when test="${command.search.roleType == 'player'}">
                    <shiro:hasPermission name="role:player_detail"><c:set var="url" value="/player/playerView.html?search.id=${cmd.operatorId}" /></shiro:hasPermission>
                </c:when>
            </c:choose>
        <tr class="tab-detail">
            <td>${vs.count + ((command.paging.pageNumber - 1) * command.paging.pageSize)}</td>
            <td>
                <c:choose>
                    <c:when test="${command.search.roleType != 'master'}">
                        <a href="${url}" nav-target="mainFrame">${cmd.operator}</a>
                    </c:when>
                    <c:otherwise>
                        ${cmd.operator}
                    </c:otherwise>
                </c:choose>
            </td>
            <td>${soulFn:formatDateTz(cmd.operateTime, DateFormat.DAY_SECOND, timeZone)}</td>
            <td>${soulFn:formatIp(cmd.operateIp)}<br>${gbFn:getIpRegion(cmd.operateIpDictCode)}</td>
            <td>${views.report['log.label.os']}${cmd.clientOs}&nbsp;&nbsp;${views.report['log.label.browser']}${cmd.clientBrowser}</td>
            <c:choose>
                <c:when test="${'39'.equals(cmd.moduleType) || '40'.equals(cmd.moduleType)}">
                    <td >
                        <c:set var="id" value="${cmd.id}"/>
                        <soul:button target="${root}/report/log/descDetail.html?id=${id}" text="详情" opType="dialog"></soul:button>
                    </td>
                </c:when>
                <c:otherwise>
                    <td>${soulFn:formatLogDesc(cmd)}</td>
                </c:otherwise>
            </c:choose>
        </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
