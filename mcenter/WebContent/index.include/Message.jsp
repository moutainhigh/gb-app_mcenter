<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<dt>${views.index.include_auto['系统消息']}</dt>
<%--没有最新消息--%>
<c:if test="${unReadCount<=0}">
    <dd class="infos-none"><i class="fa fa-exclamation-circle"></i>${views.home['no new message']}</dd>
</c:if>
<%--有最新消息--%>
<c:if test="${unReadCount>0}">
    <c:forEach items="${msg}" var="m" end="4" varStatus="s">
        <%--游戏公告直接展示消息内容,其他展示标题--%>
        <c:if test="${m.announcementType=='system_msg'}">
            <dd>
                <a href="/operation/announcementMessage/announcementDetail.html?search.id=${m.id}"
                   title="${m.title}" nav-target="mainFrame">
                    【${dicts.message.msg_type[m.announcementType]}】 ${m.shortContentText20}</a>
                <span>${soulFn:formatDateTz(m.publishTime, DateFormat.DAY,timeZone)}</span>
            </dd>
        </c:if>
        <%--系统公告--%>
        <c:if test="${m.announcementType=='system_announcement'}">
            <dd>
                <a href="/operation/announcementMessage/systemNoticeDetail.html?search.id=${m.id}"
                   title="${m.shortContentText50}" nav-target="mainFrame">
                   【${dicts.message.msg_type[m.announcementType]}】 ${m.shortContentText20}</a>
                <span>${soulFn:formatDateTz(m.publishTime, DateFormat.DAY,timeZone)}</span>
            </dd>
        </c:if>
        <%--游戏公告--%>
        <c:if test="${m.announcementType=='game_announcement'}">
            <dd>
                <a href="/operation/announcementMessage/messageDetail.html?search.id=${m.id}"
                   title="${m.shortContentText50}" nav-target="mainFrame">
                   【${dicts.message.msg_type[m.announcementType]}】 ${m.shortContentText20}</a>
                <span>${soulFn:formatDateTz(m.publishTime, DateFormat.DAY,timeZone)}</span>
            </dd>
        </c:if>
        <%--运营公告--%>
        <c:if test="${m.announcementType=='operator_announcement'}">
            <dd>
                <a href="/operation/announcementMessage/systemNoticeDetail.html?search.id=${m.id}"
                   title="${m.shortContentText50}" nav-target="mainFrame">
                   【${dicts.message.msg_type[m.announcementType]}】 ${m.shortContentText20}</a>
                   <span>${soulFn:formatDateTz(m.publishTime, DateFormat.DAY,timeZone)}</span>
            </dd>
        </c:if>

    </c:forEach>

</c:if>
<dd class="more">
    <shiro:hasPermission name="index:announcementMessage">
        <a nav-target="mainFrame" href="/operation/announcementMessage/messageList.html">${views.home['view more news']}>></a>
    </shiro:hasPermission>
</dd>



