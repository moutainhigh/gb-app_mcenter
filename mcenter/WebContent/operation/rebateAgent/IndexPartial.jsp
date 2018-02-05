<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RebateAgentListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
    <div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable table-multiple-header-row table-bordered m-b-none" id="editable" aria-describedby="editable_info">
        <thead>
        <tr class="bg-gray">
            <th rowspan="2">${views.fund_auto['序号']}</th>
            <th rowspan="2"><input type="checkbox" class="i-checks"></th>
            <%--<th rowspan="2" >${views.wc_fund['operation.rebate.agentPath']}</th>--%>
            <th rowspan="2">${views.wc_fund['代理账号']}</th>
            <th rowspan="2">${views.wc_fund['代理层级']}</th>
            <th rowspan="2">${views.wc_fund['rebate.edit.validPlayerNum']}</th>
            <th>${views.wc_fund["达到梯度"]}</th>
            <th rowspan="2">${views.wc_fund['佣金上限']}
                <span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                      data-content="${views.wc_fund['max_rebate']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
            </th>
            <th class="multiple-row" colspan="2">
                <div class="title">${views.wc_fund['effective_transaction']}</div>
                <div class="two-col">${views.wc_fund['operation.rebate.self']}</div>
                <div class="two-col">${views.wc_fund['operation.rebate.childagent']}</div>
            </th>
            <th class="multiple-row" colspan="2">
                <div class="title">${views.wc_fund['损益']}</div>
                <div class="two-col">${views.wc_fund['operation.rebate.self']}</div>
                <div class="two-col">${views.wc_fund['operation.rebate.childagent']}</div>
            </th>
            <th class="multiple-row" colspan="2">
                <div class="title">${views.wc_fund['operation.rebate.ratio']}</div>
                <div class="two-col">${views.wc_fund['累计']}</div>
                <div class="two-col">${views.wc_fund['当期']}</div>
            </th>
            <th class="multiple-row" colspan="2">
                <div class="title">${views.wc_fund['operation.rebate.childrebate']}</div>
                <div class="two-col">${views.wc_fund['累计']}</div>
                <div class="two-col">${views.wc_fund['当期']}</div>
            </th>
            <th class="multiple-row" colspan="2" style="width: 150px">
                <div class="title">${views.wc_fund['费用']}</div>
                <div class="two-col">${views.wc_fund['累计']}</div>
                <div class="two-col">${views.wc_fund['当期']}</div>
            </th>

            <th rowspan="2">${views.wc_fund['本期返佣']}
                <span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                      data-content="${views.wc_fund['this_rebate']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
            </th>
            <th rowspan="2">${views.wc_fund['可获返佣']}
                <span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                      data-content="${views.wc_fund['total_rebate']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
            </th>
            <th rowspan="2">${views.wc_fund['已获返佣']}</th>
            <th rowspan="2">${views.wc_fund['状态']}</th>
            <th rowspan="2">${views.common['operate']}</th>
        </tr>
        <tbody>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                    <c:set var="status" value="kobe"></c:set>
                    <c:if test="${p.settlementState != 'pending_lssuing'}">
                        <c:set var="status" value="disabled"></c:set>
                    </c:if>
                    <td><input type="checkbox" class="i-checks" ${status} value="${p.id}"></td>
                    <%--<td style="text-align: left"  >
                        <a href="/rebateAgent/list.html?search.agentId=${p.agentId}" nav-target="mainFrame">${p.parentNameArray}</a>
                    </td>--%>
                    <td>
                        <a href="/userAgent/agent/detail.html?search.id=${p.agentId}" nav-target="mainFrame">${p.agentName}</a>
                    </td>
                    <td>
                        <span data-content="${p.parentNameArray}" style="padding: 3px;"
                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                              role="button" class="help-popover co-red3" tabindex="0"
                              data-original-title="" title="">
                            <a href="/rebateAgent/list.html?search.agentId=${p.agentId}" nav-target="mainFrame">${p.agentRank}</a>
                        </span>

                    </td>
                    <td>${p.effectivePlayer}</td>
                    <td>${empty p.rebateGradsId ?dicts.common.flag['false']:dicts.common.flag['true']}</td>
                    <td>${p.maxRebate==-1?views.operation_auto['无上限']:soulFn:formatCurrency(p.maxRebate)}</td>
                    <td colspan="2" class="multiple-row-td">
                        <div class="${p.effectiveSelf<0?'co-red':''}">${soulFn:formatCurrency(p.effectiveSelf)}</div>
                        <div class="${p.effectiveTransaction-p.effectiveSelf<0?'co-red':''}">${soulFn:formatCurrency(p.effectiveTransaction-p.effectiveSelf)}</div>
                    </td>
                    <td colspan="2" class="multiple-row-td">
                        <div class="${p.profitSelf<0?'co-red':''}">
                            <soul:button target="${root}/rebateAgent/showAgentRebate.html?search.agentId=${p.agentId}&rebateAgentId=${p.id}&search.rebateBillId=${p.rebateBillId}"
                                         title="${views.wc_fund['自身损益']}" text="${soulFn:formatCurrency(p.profitSelf)}" opType="dialog">
                                ${soulFn:formatCurrency(p.profitSelf)}
                            </soul:button></div>
                        <div class="${p.profitLoss-p.profitSelf<0?'co-red':''}">${soulFn:formatCurrency(p.profitLoss-p.profitSelf)}</div>
                    </td>
                    <td colspan="2" class="multiple-row-td">
                        <div class="${p.rebateSelfHistory<0?'co-red':''}">${soulFn:formatCurrency(p.rebateSelfHistory)}</div>
                        <div class="${p.rebateSelf<0?'co-red':''}">
                            <soul:button target="${root}/rebateAgent/showAgentRebate.html?search.agentId=${p.agentId}&rebateAgentId=${p.id}&search.rebateBillId=${p.rebateBillId}"
                                         title="${views.wc_fund['operation.rebate.ratio']}" text="${soulFn:formatCurrency(p.rebateSelf)}" opType="dialog">
                                ${soulFn:formatCurrency(p.rebateSelf)}
                            </soul:button>

                        </div>
                    </td>
                    <td colspan="2" class="multiple-row-td">
                        <div class="${p.rebateSunHistory<0?'co-red':''}">${soulFn:formatCurrency(p.rebateSunHistory)}</div>
                        <div class="${p.rebateSun<0?'co-red':''}">
                            <soul:button target="${root}/rebateAgent/showAgentChildRebate.html?search.agentId=${p.agentId}&search.id=${p.id}&search.rebateBillId=${p.rebateBillId}"
                                         title="${views.wc_fund['operation.rebate.childrebate']}" text="${soulFn:formatCurrency(p.rebateSun)}" opType="dialog">
                                ${soulFn:formatCurrency(p.rebateSun)}
                            </soul:button>
                        </div>
                    </td>
                    <td colspan="2" class="multiple-row-td">
                        <div class="${p.feeHistory<0?'co-red':''}">${soulFn:formatCurrency(p.feeHistory)}</div>
                        <div class="${p.feeAmount<0?'co-red':''}">
                            <a href="/rebateAgent/queryRebateAgentPlayer.html?search.rebateBillId=${p.rebateBillId}&rebateAgentId=${p.id}&search.agentId=${p.agentId}" nav-target="mainFrame">${soulFn:formatCurrency(p.feeAmount)}</a>
                        </div>
                    </td>

                    <td><div class="${p.rebateAmount<0?'co-red':''}">${soulFn:formatCurrency(p.rebateAmount)}</div></td>
                    <td><div class="${p.rebateTotal<0?'co-red':''}">${soulFn:formatCurrency(p.rebateTotal)}</div></td>
                    <td><div class="${p.rebateActual<0?'co-red':''}">${soulFn:formatCurrency(p.rebateActual)}</div></td>
                    <td>
                        <span
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
                                <c:otherwise>
                                    class="label label-info"
                                </c:otherwise>
                            </c:choose>
                        >
                            ${dicts.operation.settlement_state[p.settlementState]}
                        </span>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${p.settlementState eq 'pending_lssuing'}">
                                <soul:button target="${root}/rebateAgent/toSettled.html?search.id=${p.id}" permission="operate:rebatesettle"
                                             text="${views.fund_auto['结算']}" opType="dialog" callback="query">
                                    ${views.wc_fund['结算']}
                                </soul:button>
                                <soul:button target="${root}/rebateAgent/clear.html?id=${p.id}" permission="operate:rebateclear"
                                             text="${views.fund_auto['清除']}" opType="ajax" callback="query"  confirm="${views.wc_fund['清除后数据将不会被累计到下一期']}">
                                    ${views.wc_fund['清除']}
                                </soul:button>
                                <soul:button target="${root}/rebateAgent/signBill.html?id=${p.id}" text="${views.wc_fund['挂账']}" permission="operate:rebatesignbill"
                                             confirm="${views.fund['rebate.signbill.tips']}" opType="ajax" callback="query"></soul:button>
                            </c:when>
                            <c:otherwise>

                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>

<soul:pagination/>
<!--//endregion your codes 1-->
