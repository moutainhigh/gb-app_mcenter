<%@ page import="so.wwb.gamebox.model.master.player.po.VUserPlayerImport" %>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
        <c:set var="poType" value="<%= VUserPlayerImport.class %>"></c:set>
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.common['number']}</th>
            <th>${views.column['VUserPlayerImport.fileName']}</th>
            <th>${views.column['VUserPlayerImport.importPlayerCount']}</th>
            <th>${views.column['VUserPlayerImport.notActiveCount']}</th>
            <th>${views.column['VUserPlayerImport.importTime']}</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty command.result}">
            <td colspan="5" class="no-content_wrap" style="text-align: center">
                <div>
                    <i class="fa fa-exclamation-circle"></i> ${views.common['noResult']}
                </div>
            </td>
        </c:if>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr class="tab-detail">
                <td>
                    ${(command.paging.pageNumber-1)*command.paging.pageSize+status.index+1}
                </td>
                <td>
                    ${p.fileName}
                </td>
                <td>
                    ${p.importPlayerCount}
                </td>
                <td>
                    <c:if test="${p.notActiveCount==0}">0</c:if>
                    <c:if test="${p.notActiveCount>0}">
                        <a href="/userPlayerTransfer/list.html?search.importId=${p.id}&search.isActive=0" nav-target="mainFrame">${p.notActiveCount}</a>

                    </c:if>

                </td>
                <td>
                    ${soulFn:formatDateTz(p.importTime, DateFormat.DAY_SECOND,timeZone)}
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
