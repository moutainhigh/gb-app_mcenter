<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerOnlineListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
        <thead>
        <tr class="bg-gray">
            <th>${views.common['number']}</th>
            <th>${views.column['ActivityMoneyOpenPeriod.startTime']}</th>
            <th>${views.column['ActivityMoneyOpenPeriod.endTime']}</th>
            <th>${views.column['参与人数']}</th>
            <th>${views.column['中奖金额']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.recordByTime}" var="p" varStatus="status">
            <tr class="tab-detail">
                <td>${status.index+1}</td>
                <td>${soulFn:formatDateTz(p.startTime, DateFormat.DAY_SECOND,timeZone)}</td>
                <td>
                    ${soulFn:formatDateTz(p.endTime, DateFormat.DAY_SECOND,timeZone)}
                </td>
                <td>
　　　　　　　　　　　　　${p.allPlayerCount}
                </td>
                <td>
                    ${siteCurrencySign}${p.allWinAmount}
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->