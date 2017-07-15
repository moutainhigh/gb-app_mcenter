<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.PayWarningListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<hr class="m-t m-b-sm">
<ul class="warningRecord-wrap m-b table-min-h">
    <c:forEach items="${command.result}" var="p" varStatus="status">
        <li class="warningRecord-list">
            <div class="warningRecord-square">
                <div class="warningRecord-addon">${p.getView()}</div>
            </div>
            <div class="warningRecord-addon">${soulFn:formatDateTz(p.warningTime, DateFormat.DAY_SECOND,timeZone)}</div>
        </li>
    </c:forEach>
</ul>
<soul:pagination/>
<!--//endregion your codes 1-->