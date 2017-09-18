<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<dt>${views.index_auto['任务提醒']}</dt>
<%--没有最新消息--%>
<%--<c:if test="${userTaskReminderList.size()<=0}">
    <dd class="infos-none"><i class="fa fa-exclamation-circle"></i>${views.home['no new task']}</dd>
</c:if>
&lt;%&ndash;任务&ndash;%&gt;
<c:if test="${userTaskReminderList.size()>0}">
    <c:forEach items="${userTaskReminderList}" var="m">
        <c:if test="${m.taskNum>0}">
            ${m.view}
        </c:if>
    </c:forEach>
</c:if>--%>

<c:set value="0" var="i"></c:set>
<c:choose>
    <c:when test="${userTaskReminderList.size()>0}">
        <c:forEach items="${userTaskReminderList}" var="m">
            <c:if test="${m.taskNum>0}">
                <c:set value="${i+1}" var="i"></c:set>
                ${m.view}
            </c:if>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <dd class="infos-none"><i class="fa fa-exclamation-circle"></i>${views.home['no.new.task']}</dd>
    </c:otherwise>
</c:choose>
<c:if test="${i<=0}">
    <dd class="infos-none"><i class="fa fa-exclamation-circle"></i>${views.home['no.new.task']}</dd>
</c:if>
<%--<dd class="more"><a href="javascript:void(0)">${views.home['view more news']}>></a></dd>--%>