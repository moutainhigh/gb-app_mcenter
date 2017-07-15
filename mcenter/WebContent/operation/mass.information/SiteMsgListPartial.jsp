<%--@elvariable id="command" type="org.soul.model.msg.notice.vo.VNoticeReceivedTextListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable m-b-none">
            <thead>
            <tr role="row" class="bg-gray">
                <th>${views.common['number']}</th>
                <th>${views.column['VNoticeSendText.title']}</th>
                <th>${views.column['VNoticeSendText.status']}</th>
                <th>${views.column['VNoticeSendText.sendTime']}</th>
                <th>${views.column['VNoticeSendText.createUsername']}</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${not empty command.result}">
                <c:forEach items="${command.result}" var="i" varStatus="status">
                    <tr>
                        <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                        <td class="al-left">
                            <a href="/operation/massInformation/playerSiteMsgDetail.html?search.id=${i.id}" nav-target="mainFrame">${i.title}</a>
                            <%--<a href="/operation/massInformation/noticeInfo.html?search.textId=${i.textId}&search.status=${i.status}" nav-target="mainFrame">${i.title}</a>--%>
                            <%--<c:if test="${i.status eq '00'}">
                                <a href="/operation/massInformation/noticeInfo.html?search.textId=${i.textId}&search.status=${i.status}" class="btn btn-outline btn-filter btn-xs m-l-sm">${views.operation_auto['编辑']}</a>
                            </c:if>--%>
                        </td>
                        <td>
                            <c:if test="${i.receiveStatus=='01'}">
                                <span class="label label-warning">
                                        ${dicts.notice.receive_status[i.receiveStatus]}
                                </span>
                            </c:if>
                            <c:if test="${i.receiveStatus=='11'}">
                                <span class="label label-info">
                                        ${dicts.notice.receive_status[i.receiveStatus]}
                                </span>
                            </c:if>
                            <c:if test="${i.receiveStatus=='12'}">
                                <span class="label label-success">
                                        ${dicts.notice.receive_status[i.receiveStatus]}
                                </span>
                            </c:if>
                            <c:if test="${i.receiveStatus=='21'}">
                                <span class="label label-danger">
                                        ${dicts.notice.receive_status[i.receiveStatus]}
                                </span>
                            </c:if>

                        </td>
                        <td class="co-grayc2">
                            ${soulFn:formatDateTz(i.receiveTime, DateFormat.DAY_SECOND, timeZone )}
                                <%--${i.status eq '00'?views.operation['MassInformation.expected']:''}${soulFn:formatDateTz(i.sendTime, DateFormat.DAY_SECOND, timeZone)}${i.status eq '00'?views.common['send']:''}--%>
                        </td>
                        <td>
                            ${i.createUsername}
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
            </tbody>
        </table>
    </div>

<soul:pagination/>
