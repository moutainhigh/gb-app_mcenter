<%--@elvariable id="command" type="org.soul.model.msg.notice.vo.VNoticeSendTextListVo"--%>
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
            <c:forEach items="${command.result}" var="i" varStatus="status">
                <tr>
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                    <td class="al-left">
                        <a href="/operation/massInformation/noticeInfo.html?search.textId=${i.textId}&search.status=${i.status}" nav-target="mainFrame">${i.title}</a>
                        <%--<c:if test="${i.status eq '00'}">
                            <a href="/operation/massInformation/noticeInfo.html?search.textId=${i.textId}&search.status=${i.status}" class="btn btn-outline btn-filter btn-xs m-l-sm">${views.operation_auto['编辑']}</a>
                        </c:if>--%>
                    </td>
                    <td>
                        <span class="label ${i.status eq'33' || i.status eq '32' || i.status eq '31' ?  'label-success':''} ${i.status eq'11'?'label-orange':''}">
                            ${dicts.notice.notice_send_status[i.status]}</span>
                    </td>
                    <td class="co-grayc2">${i.status eq '00'?views.operation['MassInformation.expected']:''}${soulFn:formatDateTz(i.sendTime, DateFormat.DAY_SECOND, timeZone)}${i.status eq '00'?views.common['send']:''}</td>
                    <td>
                        <span class="co-blue">${i.createUsername}&nbsp;&nbsp;</span>
                        <c:if test="${i.status eq '00'}">
                            <soul:button target="${root}/operation/massInformation/cancelPublish.html?search.textId=${i.textId}" text="${views.operation['MassInformation.step3.cancleSend']}" opType="ajax" dataType="json" confirm="${messages.operation['mass.info.cancel.confirm']}" callback="query"/>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

<soul:pagination/>
