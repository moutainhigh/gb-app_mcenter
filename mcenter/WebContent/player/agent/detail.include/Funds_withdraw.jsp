<%--@elvariable id="listVo" type="so.wwb.gamebox.model.master.player.vo.RemarkListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form id="fundForm" action="${root}/userAgent/agent/withdraw.html" method="post">
    <input type="hidden" name="search.agentId" value="${command.search.agentId}">
    <div class="clearfix history-wrap">
        <span class="pull-left">
          <a data-toggle="tab" class="tab-left-a" href="#funds${command.search.agentId}" aria-expanded="false" data-href="${root}/userAgent/agent/funds.html?search.agentId=${command.search.agentId}">${views.column['userAgent.funds.type.rebate']}</a>
            |
          <a data-toggle="tab" class="tab-right-a current" href="#funds${command.search.agentId}" aria-expanded="false" data-href="${root}/userAgent/agent/withdraw.html?search.agentId=${command.search.agentId}">${views.column['userAgent.funds.type.withdraw']}</a>
        </span>
    </div>
    <div class="tab-left-b">
    <div role="grid" class="dataTables_wrapper" id="editable_wrapper">
        <div class="table-responsive table-min-h">
        <table class="table table-striped table-bordered table-hover dataTable m-t" aria-describedby="editable_info">
            <thead>
            <tr>
                <th>${views.column['userAgent.funds.tradeNo']}</th>
                <th>${views.column['userAgent.funds.createTime']}</th>
                <th>${views.column['userAgent.funds.type']}</th>
                <th>${views.column['userAgent.funds.amount']}</th>
                <th class="inline">
                    <div>
                        <select name="search.transactionStatus" value="${command.search.transactionStatus}" data-placeholder="${views.column['userAgent.funds.status']}" class="btn-group chosen-select-no-single" tabindex="9" callback="funds.query">
                            <option value="">${views.role['player.view.funds.allStatus']}</option>
                            <c:forEach items="${status}" var="st">
                                <option value="${st.value.code}" ${(command.search.transactionStatus == st.value.code) ? 'selected' : ''}>${dicts.fund.transaction_status[st.value.code]}</option>
                            </c:forEach>
                        </select>
                    </div>
                </th>
                <th>${views.column['userAgent.funds.operate']}</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${command.result}" var="s" varStatus="vs">
                <tr>
                    <td>${s.transactionNo}</td>
                    <td>${soulFn:formatDateTz(s.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    <td>${views.column['userAgent.funds.type.withdraw']}</td>
                    <td class="co-red">-${soulFn:formatCurrency(s.withdrawAmount)}</td>
                    <td>
                        <c:choose>
                            <c:when test="${s.transactionStatus == '1'}"><span class="label label-warning">${dicts.fund.transaction_status[s.transactionStatus]}</span></c:when>
                            <c:when test="${s.transactionStatus == '2'}"><span class="label label-success">${dicts.fund.transaction_status[s.transactionStatus]}</span></c:when>
                            <c:when test="${s.transactionStatus == '3'}"><span class="label">${dicts.fund.transaction_status[s.transactionStatus]}</span></c:when>
                            <c:when test="${s.transactionStatus == '4'}"><span class="label label-danger">${dicts.fund.transaction_status[s.transactionStatus]}</span></c:when>
                        </c:choose>
                    </td>
                    <td>
                        <a href="/fund/vAgentWithdrawOrder/agentDetail.html?search.id=${s.id}" nav-target="mainFrame">${views.common.detail}</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="7">
                        <div class="pull-left">
                            <span class="m-r-md">${views.column['userAgent.funds.currentToal']}${command.paging.totalCount}${views.column['userAgent.funds.bi']}</span>
                            <span>${views.column['userAgent.funds.withdrawalsTotal']}：${siteCurrency}<b class="co-red2"> ${soulFn:formatCurrency(withdrawTotalAmount)}</b></span>
                        </div>
                        <c:if test="${command.paging.totalCount > 10}">
                            <a href="/fund/vAgentWithdrawOrder/agentList.html?search.agentId=${command.search.agentId}" nav-target="mainFrame" class="pull-right">${views.column['userAgent.funds.more']} &gt;&gt;</a>
                        </c:if>
                    </td>
                </tr>
            </tfoot>
        </table>
        </div>
        <div class="row bdtop3"></div>
    </div>
    </div>
</form:form>
<script type="text/javascript">
    curl(["site/player/agent/Funds"], function (Funds) {
        page.funds = new Funds();
    });
</script>