<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%--@elvariable id="command" type="org.soul.model.sys.vo.SysAuditLogListVo"--%>
<!DOCTYPE html>
<html>
<head>
    <title>${views.common['viewMore']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<!--日志查看更多-->
<div class="modal-body" id="mainFrame">
    <form action="${root}/player/view/journalMore.html" method="post">
        <div class="search-list-container">
                <div class="form-group over clearfix m-b-n-xs">
                    <input type="hidden" name="search.operatorId" value="${command.search.operatorId}"/>
                    <table class="table table-striped table-bordered table-hover dataTable" aria-describedby="editable_info">
                        <thead>
                        <tr>
                            <th>${views.role["player.logs.operateTime"]}</th>
                            <th>${views.role["player.logs.roles"]}</th>
                            <th>${views.role["player.logs.operate"]}</th>
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
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <soul:pagination mode="mini"/>
        </div>
    </form>
</div>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import type="list"/>
</html>