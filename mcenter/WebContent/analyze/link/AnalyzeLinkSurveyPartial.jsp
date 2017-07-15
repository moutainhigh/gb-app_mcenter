<%@ page import="so.wwb.gamebox.model.master.analyze.po.VAnalyzePlayer" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.analyze.vo.VAnalyzePlayerListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= VAnalyzePlayer.class %>"></c:set>
<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable" id="editable" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.analyze['序号']}</th>
            <th >${views.analyze['推广链接']}</th>
            <th >${views.analyze['代理账号']}</th>
            <soul:orderColumn poType="${poType}" property="agentNewPlayerCount" column='${views.analyze_auto[\'玩家总数\']}'/>
            <%--<soul:orderColumn poType="${poType}" property="agentNewEffectivePlayerCount" column='${views.analyze_auto['总有效玩家']}'/>--%>
            <soul:orderColumn poType="${poType}" property="agentNewDepositPlayerCount" column='${views.analyze_auto[\'总存款玩家\']}'/>
            <soul:orderColumn poType="${poType}" property="allDepositCount" column='${views.analyze_auto[\'存款总额\']}'/>
            <soul:orderColumn poType="${poType}" property="allWithdrawCount" column='${views.analyze_auto[\'取款总额\']}'/>
            <soul:orderColumn poType="${poType}" property="payoutAmount" column='
            <span
                tabindex="0" class="m-l-sm help-popover analyze" role="button" data-container="body"
                data-toggle="popover" data-trigger="focus" data-placement="top"
                data-content="${views.analyze_auto[\'这个代理旗下玩家总派彩\']}" data-original-title="" title=""><i
                class="fa fa-question-circle"></i>
            </span>
            ${views.analyze[\'损益\']}'/>
            <soul:orderColumn poType="${poType}" property="difference" column='${views.analyze_auto[\'存取差额\']}'/>
            <%--<soul:orderColumn poType="${poType}" property="accountBalance" column='${views.analyze_auto['账户余额']}'/>--%>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr>
                    <td>${(command.paging.pageNumber - 1) * command.paging.pageSize + status.count}</td>
                    <td>${p.promoteLink}</td>
                    <td>${p.agentName}</td>
                    <td>${p.agentNewPlayerCount}</td>
                    <%--<td>${p.agentNewEffectivePlayerCount}</td>--%>
                    <td>${p.agentNewDepositPlayerCount}</td>
                    <td>${soulFn:formatCurrency(p.allDepositCount)}</td>
                    <td>${soulFn:formatCurrency(p.allWithdrawCount)}</td>
                    <td>${soulFn:formatCurrency(p.payoutAmount)}</td>
                    <td>${soulFn:formatCurrency(p.difference)}</td>
                    <%--<td>${soulFn:formatCurrency(p.accountBalance)}</td>--%>
                </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
