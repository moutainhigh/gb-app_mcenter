<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerOnlineListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
        <thead>
        <tr class="bg-gray">
            <th>${views.common['number']}</th>
            <th>${views.column['ActivityMoneyDefaultWin.username']}</th>
            <th>${views.column['抽取红包时间']}</th>
            <th>${views.column['是否内定']}</th>
            <th>${views.column['中奖金额']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr class="tab-detail">
                <td>${status.index+1}</td>
                <td>${p.username}</td>
                <td>
                        ${soulFn:formatDateTz(p.operateTime, DateFormat.DAY_SECOND,timeZone)}
                </td>
                <td>
                    <c:if test="${p.isDefault eq true}">
                        ${views.content_auto['是']}
                    </c:if>
                    <c:if test="${! p.isDefault eq true}">
                        --
                    </c:if>
                </td>
                <td>
                    <c:if test="${p.winAmount le 0}">
                        ${views.column['未中奖']}
                    </c:if>
                    <c:if test="${p.winAmount gt 0}">
                        ${siteCurrencySign}${soulFn:formatCurrency(p.winAmount)}
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->