<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <dd class="p-xs"><b>${views.operation['Activity.apply.list.title']}</b></dd>
    <table class="table table-striped table-hover dataTable m-b-none"
           aria-describedby="editable_info">
        <thead>
        <th><input type="checkbox" class="i-checks"></th>
        <th>${views.common['number']}</th>
        <th>${views.column['VActivityPlayerApply.playerName']}</th>
        <th>${views.column['VActivityPlayerApply.applyTime']}</th>
        <th>${views.column['VActivityPlayerApply.registerTime']}</th>
        <th>${views.column['VActivityPlayerApply.rankName']}</th>
        <%--<c:forEach items="${activityWayRelationListVo}" var="column">--%>
        <%--<th>${dicts.operation.activity[column.preferentialForm]}</th>--%>
        <%--</c:forEach>--%>
        <th>${dicts.operation.activity[activityWayRelation.preferentialForm]}</th>
        <th>
            <gb:select name="search.checkState" value="${command.search.checkState}" cssClass="btn-group chosen-select-no-single" callback="query"
                       prompt="${views.operation['Activity.list.allType']}" list="${checkStatus}"></gb:select>
        </th>
        <th>${views.operation_auto['备注']}</th>
        </thead>
        <tbody>
        <c:forEach var="s" items="${command.result}" varStatus="status">
            <tr>
            <td><input data-id="${s.playerRechargeId}" ${s.checkState ne '1'?'disabled="disabled"':''}  type="checkbox" value="${s.id}" class="i-checks"></td>
            <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
            <td>
                <a href="/player/playerView.html?search.id=${s.playerId}"
                   nav-Target="mainFrame">${s.playerName}</a>
                                <span class="ico-lock co-red3">
                                    <c:if test="${s.riskMarker == true}"><i
                                            class="fa fa-warning"></i>
                                    </c:if>
                                </span>
                <a href="/fund/playerDetect/userPlayView.html?search.username=${s.playerName}"
                   nav-target="mainFrame"
                   class="btn btn-outline btn-filter btn-sm">${views.fund['despoit.check.detect']}</a>
            </td>
            <td>${soulFn:formatDateTz(s.applyTime,DateFormat.DAY_SECOND,timeZone)}</td>
            <td>${soulFn:formatDateTz(s.registerTime,DateFormat.DAY_SECOND,timeZone)}</td>
            <td>${s.rankName}</td>
            <td>
                    <%--<c:forEach items="${activityWayRelationListVo}" var="column">--%>
                    <%--<c:forEach items="${map}" var="pListVomap">--%>
                    <%--<c:if test="${pListVomap.key == s.id}">--%>
                    <%--<c:forEach items="${pListVomap.value.result}" var="vo">--%>
                    <%--<c:if test="${vo.preferentialForm == column.preferentialForm}">--%>
                    <%--${vo.preferentialValue}--%>
                    <%--</c:if>--%>
                    <%--</c:forEach>--%>
                    <%--</c:if>--%>
                    <%--</c:forEach>--%>
                    <%--</c:forEach>--%>
                    ${soulFn:formatCurrency(s.preferentialValue)}
            </td>
            <td>
                <c:if test="${s.checkState eq '0'}">
                    <span class="label label-info">${dicts.operation.activity_apply_check_status[s.checkState]}</span>
                </c:if>
                <c:if test="${s.checkState eq '1'}">
                    <span class="label label-warning">${dicts.operation.activity_apply_check_status[s.checkState]}</span>
                </c:if>
                <c:if test="${s.checkState eq '2'}">
                    <span class="label label-success">${dicts.operation.activity_apply_check_status[s.checkState]}</span>
                </c:if>
                <c:if test="${s.checkState eq '3'}">
                    <span class="label label-danger">${dicts.operation.activity_apply_check_status[s.checkState]}</span>
                </c:if>
            </td>
             <td>
                 <c:if test="${not empty s.ipApply}">
                     IP:
                        <span data-content="${gbFn:getIpRegion(s.ipDictCode)}" data-placement="bottom" data-trigger="focus" data-toggle="popover"
                              data-container="body" role="button" class="help-popover" tabindex="0">
                            <span>
                                <a nav-target="mainFrame" href="/report/log/logList.html?search.roleType=player&search.ip=${gbFn:ipv4LongToString(s.ipApply)}&keys=search.ip&hasReturn=true">${gbFn:ipv4LongToString(s.ipApply)}</a>
                            </span>
                        </span>
                     <br/>
                 </c:if>
                 <c:choose>
                     <c:when test="${fn:length(s.remark)>20}">
                                    <span data-content="${s.remark}" data-placement="bottom" data-trigger="focus" data-toggle="popover"
                                          data-container="body" role="button" class="help-popover" tabindex="0">
                                        ${fn:substring(s.remark, 0, 20)}...
                                    </span>
                     </c:when>
                     <c:otherwise>
                         ${s.remark}
                     </c:otherwise>
                 </c:choose>
             </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination/>
<!--//endregion your codes 1-->
