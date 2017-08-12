<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.RebateSetListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
        <thead>
        <tr class="bg-gray">
            <%--<th><input type="checkbox" class="i-checks"></th>--%>
            <th>${views.column['rebate.name']}</th>
            <th>${views.column['rebate.createTime']}</th>
            <th>${views.column['rebate.agentCount']}</th>
            <th>${views.common['operate']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr>
                <%--<td><label><input type="checkbox" class="i-checks" value="${p.id}"></label></td>--%>
                <td><a href="/rebateSet/view.html?id=${p.id}" nav-target="mainFrame" class="co-blue">${p.name}</a></td>
                <td>${soulFn:formatDateTz(p.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                <td>
                    <c:choose>
                    <c:when test="${p.userAgentNum>0}">
                        <a href="/vUserAgentManage/list.html?search.rebateId=${p.id}&search.hasReturn=true" nav-target="mainFrame" class="co-blue">${p.userAgentNum}</a>
                    </c:when>
                    <c:otherwise>
                        ${p.userAgentNum}
                    </c:otherwise>
                    </c:choose>

                </td>
                <td>
                    <c:if test="${p.userAgentNum==0&&p.id!=0}">
                        <%--//所属自己才能编辑--%>
                        <c:if test="${siteMasterId eq p.ownerId }">
                            <a href="/rebateSet/edit.html?id=${p.id}" nav-target="mainFrame">${views.common['edit']}</a>
                            <span class="dividing-line m-r-xs m-l-xs">|</span>
                        </c:if>

                        <soul:button target="${root}/rebateSet/${p.id}/deleterebate.html" text="${views.common['delete']}" opType="ajax" dataType="json" confirm="${views.common['confirm.deletescheme']}" callback="query" />
                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                    </c:if>
                    <a href="/rebateSet/view.html?id=${p.id}" nav-target="mainFrame">${views.common['detail']}</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
