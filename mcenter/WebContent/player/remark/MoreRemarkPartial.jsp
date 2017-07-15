<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.RemarkListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="form-group over clearfix m-b-n-xs">
    <input type="hidden" name="search.entityUserId" value="${command.search.entityUserId}"/>
    <input type="hidden" name="search.model" value="${command.search.model}"/>
    <input type="hidden" name="search.remarkType" value="${command.search.remarkType}"/>
    <input type="hidden" name="search.entityId" value="${command.search.entityId}"/>
    <table class="table table-striped table-bordered table-hover dataTable" aria-describedby="editable_info">
        <thead>
        <tr>
            <th>${views.column["Remark.remarkTime"]}</th>
            <th>${views.column["Remark.remarkType"]}</th>
            <th>${views.column["Remark.remarkTitle"]}</th>
            <th>${views.column["Remark.username"]}</th>
            <th>${views.column["Remark.operate"]}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="s" varStatus="vs">
            <tr>
                <td>${soulFn:formatDateTz(s.remarkTime, DateFormat.DAY_SECOND,timeZone)}</td>
                <td>${dicts.common.remark_type[s.remarkType]}</td>
                <td title="${s.remarkTitle}">${fn:substring(s.remarkTitle, 0, 20)}<c:if test="${fn:length(s.remarkTitle)>20}">...</c:if></td>
                <td>${s.operator}</td>
                <td>
                    <a href="${root}/playerRemark/edit.html?id=${s.id}" target="_self">${views.common['edit']}</a>
                    <soul:button target="${root}/playerRemark/delete.html?id=${s.id}" text="${views.common['delete']}" opType="ajax" callback="query" dataType="json" confirm="${views.role['player.view.remark.sureToDelete']}？"/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination  mode="mini"/>