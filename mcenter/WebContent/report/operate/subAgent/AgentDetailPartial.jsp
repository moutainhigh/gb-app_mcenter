<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.OperatePlayerListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="dataTables_wrapper" role="grid">
    <div class="form-group clearfix pull-left" style="padding-left: 20px;">
        <div class="form-group clearfix m-t-sm m-b-none">
            <span>${views.report['代理线']}:</span>
            <span>${command.agentLines}</span>
        </div>
    </div>
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <input type="hidden" id="agentId" value="${command.search.agentId}">
                <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
                    <thead>
                    <tr class="bg-gray">
                        <th colspan="6">
                            <span class="pull-left">${views.report['operate.list.info']}</span>
                        </th>
                    </tr>
                    <tr>
                        <th>${views.report['fund.list.agent']}</th>
                        <th>${views.report['operate.list.price']}</th>
                        <th>${views.report['operate.list.orderprice']}</th>
                        <th>${views.report['operate.list.effePrice']}</th>
                        <th>${views.report['operate.list.prosfit']}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${command.result}" var="p" varStatus="index">
                        <tr>
                            <td >
                                <a href="/report/operate/operateIndex.html?search.agentId=${p.agentId}&search.startDate=${command.search.startDate}&search.endDate=${command.search.endDate}&roleName=search.agentName&subSysCode=pcenter" nav-target="mainFrame">${p.agentName}</a>
                            </td>
                            <td>${soulFn:formatNumber(p.transactionOrder)}</td>
                            <td>${soulFn:formatCurrency(p.transactionVolume)}</td>
                            <td>${soulFn:formatCurrency(p.effectiveTransaction)}</td>
                            <td>${soulFn:formatCurrency(p.profitLoss)}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>




