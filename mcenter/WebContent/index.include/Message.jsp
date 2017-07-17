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
                   nav-target="mainFrame"
                   title="${m.title}">【${dicts.message.msg_type[m.announcementType]}】 ${fn:substring(m.title, 0, 15)}<c:if test="${fn:length(m.title)>15}">...</c:if></a>
                <span>${soulFn:formatDateTz(m.publishTime, DateFormat.DAY,timeZone)}</span>
            </dd>
        </c:if>
        <%--系统公告--%>
        <c:if test="${m.announcementType=='system_announcement'}">
            <dd>
                <c:set var="noHtmlContent" value="${soulFn.replaceHtml(s.content)}"/>
                <a href="/operation/announcementMessage/systemNoticeDetail.html?search.id=${m.id}"
                   nav-target="mainFrame">【${dicts.message.msg_type[m.announcementType]}】 ${fn:substring(noHtmlContent, 0, 15)}<c:if test="${fn:length(noHtmlContent)>15}">...</c:if></a>
                <span>${soulFn:formatDateTz(m.publishTime, DateFormat.DAY,timeZone)}</span>
            </dd>
        </c:if>
        <%--游戏公告--%>
        <c:if test="${m.announcementType=='game_announcement'}">
            <dd>
                <a href="/operation/announcementMessage/messageDetail.html?search.id=${m.id}"
                   title="${m.content}" nav-target="mainFrame">【${dicts.message.msg_type[m.announcementType]}】 ${fn:substring(m.content, 0, 15)}<c:if test="${fn:length(m.content)>15}">...</c:if></a>
                <span>${soulFn:formatDateTz(m.publishTime, DateFormat.DAY,timeZone)}</span>
            </dd>
        </c:if>
        <%--运营公告--%>
        <c:if test="${m.announcementType=='operator_announcement'}">
            <dd>
                <a href="/operation/announcementMessage/systemNoticeDetail.html?search.id=${m.id}"
                   nav-target="mainFrame">【${dicts.message.msg_type[m.announcementType]}】 ${fn:substring(m.content, 0, 15)}<c:if test="${fn:length(m.content)>15}">...</c:if></a>
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



