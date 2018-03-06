<%--@elvariable id="command" type="so.wwb.gamebox.model.company.operator.vo.SystemAnnouncementListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="table-responsive table-min-h">
    <table class="table m-b-none">
        <tbody>
        <c:forEach items="${command.result}" var="s" varStatus="status">
            <tr>
                <td class="al-left">
                    <div class="elli hide">
                        <a href="/operation/announcementMessage/systemNoticeDetail.html?search.id=&search.startTime=${soulFn:formatDateTz(command.search.startTime, DateFormat.DAY_SECOND,timeZone)}&search.endTime=${soulFn:formatDateTz(command.search.endTime, DateFormat.DAY_SECOND,timeZone)}&paging.pageNumber=${(command.paging.pageNumber-1)*command.paging.pageSize+status.index+1}" nav-target="mainFrame">
                                ${s.contentText}</a>
                    </div>
                </td>
                <td style="width: 200px" class="co-grayc2">
                        ${soulFn:formatDateTz(s.publishTime, DateFormat.DAY_SECOND,timeZone)}
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination/>