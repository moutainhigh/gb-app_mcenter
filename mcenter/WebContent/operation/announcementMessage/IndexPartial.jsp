<%--@elvariable id="command" type="org.soul.model.msg.notice.vo.VNoticeReceivedTextListVo "--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
        <thead>
        <tr class="bg-gray">
            <th><input type="checkbox" class="i-checks"></th>
            <th>${views.role['player.sendMessage.text.title']}</th>
            <th>${views.role['player.sendMessage.text.time']}</th>
            <div class="clearfix filter-wraper border-b-1">
                <div class="function-menu-show hide">
                    <soul:button target="deleteMessage" text="${views.common['delete']}" opType="function"
                                 cssClass="btn btn-outline btn-filter"
                                 confirm="${views.role['player.view.advisory.sureToDelete']}？"/>
                    <soul:button target="getSelectMessageIds" text="${views.common['markRead']}" opType="function"
                                 cssClass="btn btn-outline btn-filter"/>
                </div>
            </div>

        </tr>
        <tr class="bd-none hide">
            <th colspan="${fn:length(command.fields)+3}">
                <div class="select-records"><i class="fa fa-exclamation-circle"></i>${views.role['player.cancelSelectAll.prefix']}&nbsp;<span id="page_selected_total_record"></span>${views.role['player.cancelSelectAll.middlefix']}
                    <soul:button target="cancelSelectAll" opType="function" text="${views.role['player.cancelSelectAll']}"/>${views.role['player.cancelSelectAll.suffix']}
                </div>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="s" varStatus="status" >
            <tr>
                <td style="width: 40px"><input type="checkbox" value="${s.id}" class="i-checks"></td>
                <td>
                    <c:if test="${s.receiveStatus=='12'}">
                        <div class="elli hide">
                            <a href="/operation/announcementMessage/announcementDetail.html?search.id=${s.id}&paging.pageNumber=${(command.paging.pageNumber-1)*command.paging.pageSize+status.index+1}" nav-target="mainFrame" class="co-gray6">
                                    ${s.title}
                            </a>
                        </div>

                    </c:if>
                    <c:if test="${s.receiveStatus=='01'}">
                        <div class="elli hide"><a href="/operation/announcementMessage/announcementDetail.html?search.id=${s.id}&paging.pageNumber=${(command.paging.pageNumber-1)*command.paging.pageSize+status.index+1}" nav-target="mainFrame" class="co-gray6">
                            <b>${s.title}</b>
                        </a>
                        </div>
                    </c:if>
                </td>
                <td style="width: 200px;">${soulFn:formatDateTz(s.receiveTime, DateFormat.DAY_SECOND,timeZone)}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination/>


