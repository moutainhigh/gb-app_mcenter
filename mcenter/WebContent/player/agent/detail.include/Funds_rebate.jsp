<%--@elvariable id="listVo" type="so.wwb.gamebox.model.master.player.vo.RemarkListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form id="fundForm" action="${root}/userAgent/agent/funds.html" method="post">
    <input type="hidden" name="search.agentId" value="${command.search.agentId}">
    <div class="clearfix history-wrap">
        <span class="pull-left">
          <a data-toggle="tab" class="tab-left-a current" href="#funds${command.search.agentId}" aria-expanded="false" data-href="${root}/userAgent/agent/funds.html?search.agentId=${command.search.agentId}">${views.column['userAgent.funds.type.rebate']}</a>
            |
          <a data-toggle="tab" class="tab-right-a" href="#funds${command.search.agentId}" aria-expanded="false" data-href="${root}/userAgent/agent/withdraw.html?search.agentId=${command.search.agentId}">${views.column['userAgent.funds.type.withdraw']}</a>
        </span>
    </div>

    <div class="tab-left-b">
    <div role="grid" class="dataTables_wrapper" id="editable_wrapper">
        <div class="table-responsive table-min-h">
        <table class="table table-striped table-bordered table-hover dataTable m-t" aria-describedby="editable_info">
            <thead>
            <tr>
                <th>${views.column['userAgent.funds.tradeNo']}</th>
                <th>${views.column['userAgent.funds.settlementName']}</th>
                <th>${views.column['userAgent.funds.range']}</th>
                <th>${views.column['userAgent.funds.type']}</th>
                <th>${views.column['userAgent.funds.amount']}</th>
                <th class="inline">
                    <div>
                        <select name="search.settlementState" value="${command.search.settlementState}" data-placeholder="${views.column['userAgent.funds.status']}" class="btn-group chosen-select-no-single" tabindex="9" callback="funds.query">
                            <option value="">${views.column['userAgent.funds.status']}</option>
                            <c:forEach items="${fundsStatus}" var="st">
                                <c:if test="${st.value.code != 'pending_lssuing'}">
                                    <option value="${st.value.code}" ${(command.search.settlementState == st.value.code) ? 'selected' : ''}>${dicts.operation.settlement_state[st.value.code]}</option>
                                </c:if>
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
                    <td>${s.settlementName}</td>
                    <td>${soulFn:formatDateTz(s.startTime, DateFormat.DAY,timeZone)}~${soulFn:formatDateTz(s.endTime, DateFormat.DAY,timeZone)}</td>
                    <td>${views.column['userAgent.funds.type.rebate']}</td>
                    <td class="${s.actualAmount>=0?'co-green':'co-red'}">${soulFn:formatCurrency(s.actualAmount)}</td>
                    <td>
                        <c:choose>
                            <c:when test="${s.settlementState == 'reject_lssuing'}"><span class="label label-danger">${dicts.operation.settlement_state[s.settlementState]}</span></c:when>
                            <c:when test="${s.settlementState == 'lssuing'}"><span class="label label-success">${dicts.operation.settlement_state[s.settlementState]}</span></c:when>
                            <%--<c:when test="${s.settlementState == 'pending_lssuing'}"><span class="label">${dicts.operation.settlement_state[s.settlementState]}</span></c:when>--%>
                        </c:choose>
                    </td>
                    <td>
                        <a href="/userAgent/rebateDetail.html?search.id=${s.id}" nav-target="mainFrame">${views.common.detail}</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="7"><div class="pull-left">
                        <span>${views.column['userAgent.funds.rebateTotal']}：${siteCurrency}<b class="co-red2"> ${soulFn:formatCurrency(rebateTotalAmount)}</b></span>
                    </div></td>
                </tr>
            </tfoot>
        </table>
        </div>
        <soul:pagination/>
    </div>
    </div>
</form:form>
<script type="text/javascript">
    curl(["site/player/agent/Funds"], function (Funds) {
        page.funds = new Funds();
    });
</script>