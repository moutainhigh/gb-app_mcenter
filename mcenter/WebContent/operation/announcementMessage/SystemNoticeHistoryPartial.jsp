<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="table-responsive table-min-h">
    <table class="table m-b-none">
        <tbody>
        <c:forEach items="${command.result}" var="s">
            <tr>
                <td class="al-left">
                    <div class="elli hide">
                        <a href="/operation/announcementMessage/systemNoticeDetail.html?search.id=${s.id}" nav-target="mainFrame">${s.content}</a>
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