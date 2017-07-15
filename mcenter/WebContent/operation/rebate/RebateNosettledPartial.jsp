<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RebateAgentNosettledListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="table-responsive m-t-sm table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.column['RebateAgent.agentName']}</th>
            <th>${views.column['RebateAgent.effectivePlayer']}</th>
            <th>${views.column['RebateAgent.effectiveTransaction']}</th>
            <th>${views.column['RebateAgent.profitLoss']}<span tabindex="0" class="m-l-sm help-popover" role="button"
                                                               data-container="body" data-toggle="popover"
                                                               data-html="true"
                                                               data-trigger="focus" data-placement="top"
                                                               data-content="${views.operation['Rebate.list.profitLoss']}"
            ><i
                    class="fa fa-question-circle"></i></span></th>
            <th>${views.column['RebateAgent.depositAmount']}<span tabindex="0" class="m-l-sm help-popover" role="button"
                                                                  data-container="body" data-toggle="popover"
                                                                  data-html="true"
                                                                  data-trigger="focus" data-placement="top"
                                                                  data-content="${views.operation['Rebate.list.deposit']}"
            ><i
                    class="fa fa-question-circle"></i></span></th>
            <th>${views.column['RebateAgent.withdrawalAmount']}<span tabindex="0" class="m-l-sm help-popover"
                                                                     role="button"
                                                                     data-container="body" data-toggle="popover"
                                                                     data-html="true"
                                                                     data-trigger="focus" data-placement="top"
                                                                     data-content="${views.operation['Rebate.list.withdraw']}"
            ><i
                    class="fa fa-question-circle"></i></span></th>
            <th>${views.column['RebateAgent.rakeback']}<span tabindex="0" class="m-l-sm help-popover" role="button"
                                                             data-container="body" data-toggle="popover"
                                                             data-html="true"
                                                             data-trigger="focus" data-placement="top"
                                                             data-content="${views.operation['Rebate.list.rakeback']}"
            ><i
                    class="fa fa-question-circle"></i></span></th>
            <th>${views.column['RebateAgent.preferentialAndrecommend']}<span tabindex="0" class="m-l-sm help-popover"
                                                                             role="button" data-html="true"
                                                                             data-container="body" data-toggle="popover"
                                                                             data-trigger="focus" data-placement="top"
                                                                             data-content="${views.operation['Rebate.list.favorable']}"
            ><i
                    class="fa fa-question-circle"></i></span></th>
            <th>${views.column['RebateAgent.refundFee']}<span tabindex="0" class="m-l-sm help-popover" role="button"
                                                              data-container="body" data-html="true"
                                                              data-toggle="popover" data-trigger="focus"
                                                              data-placement="top"
                                                              data-content="${views.operation['Rebate.list.returnFee']}"><i
                    class="fa fa-question-circle"></i></span></th>
            <th>
                ${views.column['RebateAgent.apportion']}
                <span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-content="${views.operation['Rebate.list.apportion']}" data-original-title="" title="">
                    <i class="fa fa-question-circle"></i>
                </span>
            </th>
            <th>${views.operation['Rebate.list.peroid.pending']}<span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-html="true" data-trigger="focus" data-placement="top" data-content="${views.operation['Rebate.list.peroid.pending.tips']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></th>
            <th>
                ${views.operation['Rebate.list.rebateTotal']}
                <span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-content="${views.operation['Rebate.list.expctedCommission']}" data-original-title="" title="">
                    <i class="fa fa-question-circle"></i>
                </span>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="i">
            <tr>
                <td><a>${i.agentName}</a></td>
                <td class="co-blue">${soulFn:formatNumber(i.effectivePlayer)}</td>
                <td class="co-blue3">${soulFn:formatCurrency(i.effectiveTransaction)}</td>
                <td>${soulFn:formatCurrency(i.profitLoss)}</td>
                <td class="co-blue3">${soulFn:formatCurrency(i.depositAmount)}</td>
                <td class="co-blue3">${soulFn:formatCurrency(i.withdrawalAmount)}</td>
                <td class="co-blue">${soulFn:formatCurrency(i.rakeback)}</td>
                <td class="co-blue3">${soulFn:formatCurrency(i.preferentialValue+i.recommend)}</td>
                <td>${soulFn:formatCurrency(i.refundFee)}</td>
                <td>${soulFn:formatCurrency(i.apportion)}</td>
                <td>${soulFn:formatCurrency(i.historyApportion)}</td>
                <td>${soulFn:formatCurrency(i.rebateTotal)}</td>
            </tr>
        </c:forEach>
        <tr>
            <th>${views.operation['operation.total']}</th>
            <td class="co-yellow">${soulFn:formatNumber(total[0])}</td>
            <c:forEach items="${total}" begin="1" var="i" varStatus="vs">
                <td class="co-yellow">${soulFn:formatCurrency(total[vs.index])}</td>
            </c:forEach>
        </tr>
        </tbody>
    </table>
</div>
<soul:pagination/>
