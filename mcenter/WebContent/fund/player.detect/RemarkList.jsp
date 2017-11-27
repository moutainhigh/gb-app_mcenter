<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="detect-title">${views.fund['fund.playerDetect.index.remarkRecord']}</div>
<div class="table-responsive">
    <table class="table table-striped table-bordered table-desc-list">
        <thead>
        <tr>
            <th>${views.column["Remark.remarkType"]}</th>
            <th>${views.column["Remark.remarkTime"]}</th>
            <th>${views.column["Remark.remarkContent"]}</th>
            <th>${views.column["Remark.username"]}</th>
            <th>${views.column["Remark.operate"]}</th>
            <%--<th>${views.column["Remark.remarkContent"]}</th>--%>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="remark" varStatus="status">
            <tr>
                <td>${dicts.common.remark_type[remark.remarkType]}</td>
                <td>${soulFn:formatDateTz(remark.remarkTime, DateFormat.DAY_SECOND,timeZone)}</td>
                <td>${remark.remarkContent}</td>
                <td>${remark.operator}</td>
                <%--<td>${remark.remarkContent}</td>--%>
                <td>
                    <soul:button target="${root}/playerRemark/edit.html?id=${remark.id}" cssClass="m-r-xs" text="${views.common['edit']}" callback="callBackQuery" opType="dialog"/>
                    <soul:button target="${root}/playerRemark/delete.html?id=${remark.id}" cssClass="m-r-xs" text="${views.common['delete']}" opType="ajax" callback="query" dataType="json" confirm="${views.role['player.view.remark.sureToDelete']}？"/>
                    <soul:button target="${root}/playerRemark/view.html?id=${remark.id}" cssClass="m-r-xs" text="${views.common['detail']}" opType="dialog"/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<%--<soul:pagination/>--%>
<%--&lt;%&ndash;查看更多&ndash;%&gt;--%>
<div class="clearfix p-xs">
    <%--<soul:button target="${root}/playerRemark/moreRemark.html?search.entityUserId=${command.search.entityUserId}&search.operatorId=${command.search.operatorId}" opType="dialog" cssClass="pull-right co-blue" text="查看全部 &gt;&gt;"/>--%>
<shiro:hasPermission name="role:player_detail">
    <a href="/player/playerView.html?search.id=${command.search.entityUserId}&extendedLinks=yes" nav-target="mainFrame" class="pull-right co-blue"></shiro:hasPermission>
    ${views.fund['fund.playerDetect.index.showAll']} &gt;&gt;<shiro:hasPermission name="role:player_detail"></a></shiro:hasPermission>
</div>
