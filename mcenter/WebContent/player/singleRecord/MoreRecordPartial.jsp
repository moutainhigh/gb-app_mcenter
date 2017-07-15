<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerGameOrderListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="form-group over clearfix m-b-n-xs">
    <%--<input type="hidden" name="playerId" value="${command.search.playerId}"/>--%>
    <input type="hidden" name="playerId" value="${command.search.playerId}"/>
    <table class="table table-striped table-bordered table-hover dataTable" aria-describedby="editable_info">
        <thead>
        <tr>
            <th>${views.column['PlayerApiOrder.apiName']}</th>
            <th>${views.column['PlayerApiOrder.count']}</th>
            <th>${views.column['PlayerApiOrder.effective']}/${views.column['PlayerApiOrder.tranaction']}</th>
            <th>${views.column['PlayerApiOrder.breakeven']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.playerApiOrders}" var="item" varStatus="status">
            <tr>
                <td>
                    <a href="javascript:void(0)">
                        <span class="content-width-no content-width-limit-10">
                            ${gbFn:getApiName(item.apiId.toString())}
                        </span>
                    </a>
                </td>
                <td>${item.count}</td>
                <td><span class="co-blue"><fmt:formatNumber value="${item.effective}" pattern="0.00"></fmt:formatNumber></span> / <fmt:formatNumber value="${item.tranaction}" pattern="0.00"></fmt:formatNumber></td>
                <td class="<c:if test="${item.breakeven>=0}">co-green</c:if>
                    <c:if test="${item.breakeven<0}">co-red</c:if>">
                    ${item.breakeven}
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination mode="mini"/>
