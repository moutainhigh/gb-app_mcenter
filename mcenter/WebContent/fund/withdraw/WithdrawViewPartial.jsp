<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.RemarkListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="table-responsive">
    <table class="table table-striped table-hover dataTable m-b-none">
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
                                 text="${views.common['edit']}" callback="queryWithdrawRemark" opType="dialog"/>
                    <soul:button target="${root}/playerRemark/delete.html?id=${s.id}"
                                 text="${views.common['delete']}" opType="ajax" callback="queryWithdrawRemark"
                                 dataType="json"
                                 confirm="${views.role['player.view.remark.sureToDelete']}？"/>
                    <soul:button target="${root}/playerRemark/view.html?id=${s.id}"
                                 text="${views.common['detail']}" opType="dialog"/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination/>



