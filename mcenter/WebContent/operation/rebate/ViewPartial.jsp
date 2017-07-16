<%@ page import="so.wwb.gamebox.model.master.operation.po.RebateAgent" %>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set value="<%=RebateAgent.class%>" var="poType"></c:set>
<div class="table-responsive dataTables_wrapper m-t-sm">
    <table class="table table-condensed table-hover table-striped  dataTable m-b-none" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.common['number']}</th>
            <th>${views.column['RebateAgent.agentName']}</th>
            <th>${views.column['RebateAgent.balance']}</th>
            <th>${views.column['RebateAgent.effectivePlayer']}</th>
            <th>${views.column['RebateAgent.effectiveTransaction']}</th>
            <th>${views.column['RebateAgent.profitLoss']}<span tabindex="0" class="m-l-sm help-popover" role="button"
                                                               data-container="body" data-toggle="popover"
                                                               data-html="true"
                                                               data-trigger="focus" data-placement="top"
                                                               data-content="${views.operation['Rebate.list.profitLoss']}"><i class="fa fa-question-circle"></i></span></th>
            <th>${views.column['RebateAgent.depositAmount']}<span tabindex="0" class="m-l-sm help-popover" role="button"
                                                                  data-container="body" data-toggle="popover"
                                                                  data-html="true"
                                                                  data-trigger="focus" data-placement="top"
                                                                  data-content="${views.operation['Rebate.list.deposit']}"><i class="fa fa-question-circle"></i></span></th>
            <th>${views.column['RebateAgent.withdrawalAmount']}<span tabindex="0" class="m-l-sm help-popover"
                                                                     role="button"
                                                                     data-container="body" data-toggle="popover"
                                                                     data-html="true"
                                                                     data-trigger="focus" data-placement="top"
                                                                     data-content="${views.operation['Rebate.list.withdraw']}"><i class="fa fa-question-circle"></i></span></th>
            <th>${views.column['RebateAgent.rakeback']}<span tabindex="0" class="m-l-sm help-popover" role="button"
                                                             data-container="body" data-toggle="popover"
                                                             data-html="true"
                                                             data-trigger="focus" data-placement="top"
                                                             data-content="${views.operation['Rebate.list.rakeback']}"><i class="fa fa-question-circle"></i></span></th>
            <th>${views.column['RebateAgent.preferentialAndrecommend']}<span tabindex="0" class="m-l-sm help-popover"
                                                                             role="button" data-html="true"
                                                                             data-container="body" data-toggle="popover"
                                                                             data-trigger="focus" data-placement="top"
                                                                             data-content="${views.operation['Rebate.list.favorable']}"><i class="fa fa-question-circle"></i></span></th>
            <th>${views.column['RebateAgent.refundFee']}<span tabindex="0" class="m-l-sm help-popover" role="button"
                                                              data-container="body" data-html="true"
                                                              data-toggle="popover" data-trigger="focus"
                                                              data-placement="top"
                                                              data-content="${views.operation['Rebate.list.returnFee']}"
            ><i class="fa fa-question-circle"></i></span></th>
            <th>${views.column['RebateAgent.apportion']}<span tabindex="0" class="m-l-sm help-popover" role="button"
                                                              data-container="body" data-toggle="popover"
                                                              data-trigger="focus" data-placement="top"
                                                              data-content="${views.operation['Rebate.list.apportion']}"
            ><i class="fa fa-question-circle"></i></span></th>
            <th>${views.operation['Rebate.list.peroid.pending']}<span tabindex="0" class="m-l-sm help-popover"
                                                                      role="button" data-container="body"
                                                                      data-toggle="popover" data-html="true"
                                                                      data-trigger="focus" data-placement="top"
                                                                      data-content="${views.operation['Rebate.list.peroid.pending.tips']}"
            ><i class="fa fa-question-circle"></i></span></th>
            <c:set value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rebate.help.total']}\"><i class=\"fa fa-question-circle\"></i></span>" var="tips1"></c:set>
            <soul:orderColumn poType="${poType}" property="rebateTotal"
                              column="${tips1} ${views.column['RebateAgent.rebateTotal']}"></soul:orderColumn>
            <c:set value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rebate.help.actual']}\"><i class=\"fa fa-question-circle\"></i></span>" var="tips2"></c:set>
            <soul:orderColumn poType="${poType}" property="rebateActual"
                              column="${tips2} ${views.column['RebateAgent.rebateActual']}"></soul:orderColumn>

            <%--<th>${views.column['RebateAgent.rebateTotal']}</th>
            <th>${views.column['RebateAgent.rebateActual']}</th>--%>
            <th>${views.column['RebateAgent.settlementState']}</th>
            <th>${views.common['operate']}</th>
        </tr>
        </thead>
        <tbody>
        <c:set var="sum1" value="${0}"></c:set>
        <c:set var="sum2" value="${0}"></c:set>
        <c:set var="sum3" value="${0}"></c:set>
        <c:set var="sum4" value="${0}"></c:set>
        <c:set var="sum5" value="${0}"></c:set>
        <c:set var="sum6" value="${0}"></c:set>
        <c:set var="sum7" value="${0}"></c:set>
        <c:set var="sum8" value="${0}"></c:set>
        <c:set var="sum9" value="${0}"></c:set>
        <c:set var="sum10" value="${0}"></c:set>
        <c:set var="sum11" value="${0}"></c:set>
        <c:set var="sum12" value="${0}"></c:set>
        <c:set var="sum13" value="${0}"></c:set>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <c:set var="sum1" value="${sum1+p.balance}"></c:set>
            <c:set var="sum2" value="${sum2+p.effectivePlayer}"></c:set>
            <c:set var="sum3" value="${sum3+p.effectiveTransaction}"></c:set>
            <c:set var="sum4" value="${sum4+p.profitLoss}"></c:set>
            <c:set var="sum5" value="${sum5+p.depositAmount}"></c:set>
            <c:set var="sum6" value="${sum6+p.withdrawalAmount}"></c:set>
            <c:set var="sum7" value="${sum7+p.rakeback}"></c:set>
            <c:set var="sum8" value="${sum8+p.preferentialValue+p.recommend}"></c:set>
            <c:set var="sum9" value="${sum9+p.apportion}"></c:set>
            <c:set var="sum10" value="${sum10+p.rebateTotal}"></c:set>
            <c:set var="sum11" value="${sum11+p.rebateActual}"></c:set>
            <c:set var="sum12" value="${sum12+p.refundFee}"></c:set>
            <c:set var="sum13" value="${sum13+p.historyApportion}"></c:set>
            <tr>
                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                <td><a href="/userAgent/agent/detail.html?search.id=${p.agentId}"
                       nav-target="mainFrame">${p.agentName}</a></td>
                    <%--<c:if test="${p.agentId eq map[p.agentId].id}">--%>
                    <%--<td class="${map[p.agentId].accountBalance ge 0 ?"co-red":"co-green"}">--%>
                    <%--<c:if test="${map[p.agentId].accountBalance ge 0}">+</c:if>--%>
                    <%--${soulFn:formatCurrency(map[p.agentId].accountBalance)}--%>
                    <%--</td>--%>
                    <%--<c:set var="sum1" value="${sum1+map[p.agentId].accountBalance}"></c:set>--%>
                    <%--</c:if>--%>
                <td class="${p.balance ge 0 ?"co-red":"co-green"}">
                        ${soulFn:formatCurrency(p.balance)}
                </td>
                <td class="co-blue"><a href="/player/list.html.html?search.agentId=${p.agentId}"
                                       nav-target="mainFrame">${p.effectivePlayer}</a></td>
                <td class="co-blue3">${soulFn:formatCurrency(p.effectiveTransaction)}</td>
                <td>${soulFn:formatCurrency(p.profitLoss)}</td>
                <td class="co-blue3">${soulFn:formatCurrency(p.depositAmount)}</td>
                <td class="co-blue3">${soulFn:formatCurrency(p.withdrawalAmount)}</td>
                <td class="co-blue">${soulFn:formatCurrency(p.rakeback)}</td>
                <td class="co-blue3">${soulFn:formatCurrency(p.preferentialValue+p.recommend)}</td>
                <td>${soulFn:formatCurrency(p.refundFee)}</td>
                <td>${soulFn:formatCurrency(p.apportion)}</td>
                <td>${soulFn:formatCurrency(p.historyApportion)}</td>
                <td style="padding-left: 40px;">${soulFn:formatCurrency(p.rebateTotal)}</td>
                <td style="padding-left: 40px;">${soulFn:formatCurrency(p.rebateActual)}</td>
                <td><span
                        <c:choose>
                            <c:when test="${p.settlementState eq 'pending_lssuing'}">
                                class="label label-orange"
                            </c:when>
                            <c:when test="${p.settlementState eq 'lssuing'}">
                                class="label label-success"
                            </c:when>
                            <c:when test="${p.settlementState eq 'reject_lssuing'}">
                                class="label label-danger"
                            </c:when>
                        </c:choose>
                >
                        ${dicts.operation.settlement_state[p.settlementState]}</span>
                    </span>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${(p.settlementState eq 'lssuing' || p.settlementState eq 'reject_lssuing') && not empty agentRebateOrderList}">
                            <a href="/userAgent/rebateDetail.html?search.id=${agentRebateOrderMap[p.agentId].id}"
                               nav-target="mainFrame">${views.common['detail']}</a>
                        </c:when>
                        <c:otherwise>
                            ---
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
        <tr>
            <th>${views.operation['operation.total']}</th>
            <td class="co-yellow"></td>
            <td class="co-yellow">${soulFn:formatCurrency(sum1)}</td>
            <td class="co-yellow">${sum2}</td>
            <td class="co-yellow">${soulFn:formatCurrency(sum3)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(sum4)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(sum5)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(sum6)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(sum7)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(sum8)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(sum12)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(sum9)}</td>
            <td class="co-yellow">${soulFn:formatCurrency(sum13)}</td>
            <td class="co-yellow" style="padding-left: 40px;">${soulFn:formatCurrency(sum10)}</td>
            <td class="co-yellow" style="padding-left: 40px;">${soulFn:formatCurrency(sum11)}</td>
            <td class="co-yellow"></td>
            <td class="co-yellow"></td>
        </tr>
    </table>
</div>
<soul:pagination/>
