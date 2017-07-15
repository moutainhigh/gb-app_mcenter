<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.RemarkListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
    <table class="table table-bordered dataTable m-b-sm">
        <thead>
        <tr class="tab-title">
            <th>${views.column["Remark.remarkTime"]}</th>
            <th>${views.column["Remark.remarkTitle"]}</th>
            <th>${views.column["Remark.username"]}</th>
            <th>${views.column["Remark.operate"]}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="s" varStatus="vs">
            <tr>
                <td>${soulFn:formatDateTz(s.remarkTime, DateFormat.DAY_SECOND,timeZone)}</td>
                <td title="${s.remarkTitle}">${fn:substring(s.remarkTitle, 0, 20)}<c:if
                        test="${fn:length(s.remarkTitle)>20}">...</c:if></td>
                <td>${s.operator}</td>
                <td>
                    <soul:button target="${root}/playerRemark/edit.html?id=${s.id}"
                                 text="${views.common['edit']}"
                                 callback="queryAgentWithdrawRemark" opType="dialog"/>
                    <soul:button target="${root}/playerRemark/delete.html?id=${s.id}"
                                 text="${views.common['delete']}" opType="ajax"
                                 callback="queryAgentWithdrawRemark"
                                 dataType="json"
                                 confirm="${views.role['player.view.remark.sureToDelete']}？"/>
                    <soul:button target="${root}/playerRemark/view.html?id=${s.id}"
                                 text="${views.common['detail']}" opType="dialog"/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <%--<c:if test="${command.paging.totalCount>10}">
        <soul:button
                target="${root}/playerRemark/moreRemark.html?search.playerId=${command.search.playerId}&search.remarkType=${command.search.remarkType}&search.model=${command.search.model}&search.modelId=${command.search.modelId}"
                opType="dialog" cssClass="co-blue pull-right" callback="queryAgentWithdrawRemark"
                text="${views.common['viewMore']} &gt;&gt;"/>
    </c:if>--%>
<soul:pagination/>
