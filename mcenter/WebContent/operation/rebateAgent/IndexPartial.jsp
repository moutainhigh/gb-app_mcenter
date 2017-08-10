<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RebateAgentListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<div class="table-responsive">
    <table class="table table-striped table-hover dataTable table-multiple-header-row table-bordered" id="editable" aria-describedby="editable_info">
        <thead>
        <tr class="bg-gray">
            <th rowspan="2">${views.fund_auto['序号']}</th>
            <th rowspan="2">代理路径</th>
            <th rowspan="2">${views.fund_auto['代理账号']}</th>
            <th rowspan="2">有效投注人数</th>
            <th class="multiple-row" colspan="2">
                <div class="title">有效投注额</div>
                <div class="two-col">自身</div>
                <div class="two-col">下级</div>
            </th>
            <th class="multiple-row" colspan="2">
                <div class="title">损益</div>
                <div class="two-col">自身</div>
                <div class="two-col">下级</div>
            </th>
            <th class="multiple-row" colspan="2">
                <div class="title">佣金占成</div>
                <div class="two-col">累计</div>
                <div class="two-col">当期</div>
            </th>
            <th class="multiple-row" colspan="2">
                <div class="title">下级抽佣</div>
                <div class="two-col">累计</div>
                <div class="two-col">当期</div>
            </th>
            <th class="multiple-row" colspan="2">
                <div class="title">费用</div>
                <div class="two-col">累计</div>
                <div class="two-col">当期</div>
            </th>
            <th rowspan="2">可获返佣</th>
            <th rowspan="2">已获返佣</th>
            <th rowspan="2">状态</th>
            <th rowspan="2">操作</th>
        </tr>
        <tbody>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr>
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                    <td style="text-align: left">
                        ${gbFn:formatParentArrayToAgentName(p.parentArray)}
                    </td>
                    <td>
                        <a href="/userAgent/agent/detail.html?search.id=${p.agentId}" nav-target="mainFrame">${p.agentName}</a>
                    </td>
                    <td>${p.effectivePlayer}</td>
                    <td colspan="2" class="multiple-row-td">
                        <div>${soulFn:formatCurrency(p.effectiveSelf)}</div>
                        <div>${soulFn:formatCurrency(p.effectiveTransaction)}</div>
                    </td>
                    <td colspan="2" class="multiple-row-td">
                        <div>${soulFn:formatCurrency(p.profitSelf)}</div>
                        <div>${soulFn:formatCurrency(p.profitLoss)}</div>
                    </td>
                    <td colspan="2" class="multiple-row-td">
                        <div>${soulFn:formatCurrency(p.rebateSelfHistory)}</div>
                        <div>${soulFn:formatCurrency(p.rebateSelf)}</div>
                    </td>
                    <td colspan="2" class="multiple-row-td">
                        <div>${soulFn:formatCurrency(p.rebateSunHistory)}</div>
                        <div>${soulFn:formatCurrency(p.rebateSun)}</div>
                    </td>
                    <td colspan="2" class="multiple-row-td">
                        <div>${soulFn:formatCurrency(p.feeHistory)}</div>
                        <div>${soulFn:formatCurrency(p.feeAmount)}</div>
                    </td>
                    <td>${soulFn:formatCurrency(p.rebateTotal)}</td>
                    <td>${soulFn:formatCurrency(p.rebateActual)}</td>
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
                                    ${views.fund_auto['结算']}
                                </soul:button>
                                <soul:button target="${root}/rebateAgent/clear.html?id=${p.id}" permission="operate:rebateclear"
                                             text="${views.fund_auto['清除']}" opType="ajax" callback="query"  confirm="${views.fund_auto['清除后数据将不会被累计到下一期']}">
                                    ${views.fund_auto['清除']}
                                </soul:button>
                                <soul:button target="${root}/rebateAgent/signBill.html?id=${p.id}" text="${views.fund_auto['挂账']}" permission="operate:rebatesignbill"
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
    <%--<table class="table table-striped table-hover dataTable table-multiple-header-row table-bordered" id="editable" aria-describedby="editable_info">
        <thead>
            <tr class="bg-gray">
                <th>${views.fund_auto['序号']}</th>
                <th>${views.fund_auto['代理账号']}</th>
                <th>${views.fund_auto['有效会员']}</th>
                <th class="multiple-row" colspan="2">
                    <div class="title">${views.fund_auto['损益']}</div>
                    <div class="two-col">${views.fund_auto['累计']}</div>
                    <div class="two-col">${views.fund_auto['当期']}</div>
                </th>
                <th class="multiple-row" colspan="2">
                    <div class="title">${views.fund_auto['有效投注']}</div>
                    <div class="two-col">${views.fund_auto['累计']}</div>
                    <div class="two-col">${views.fund_auto['当期']}</div>
                </th>
                <th class="multiple-row" colspan="2">
                    <div class="title">${views.fund_auto['费用']}</div>
                    <div class="two-col">${views.fund_auto['累计']}</div>
                    <div class="two-col">${views.fund_auto['当期']}</div>
                </th>
                <th>${views.fund_auto['可获返佣']}</th>
                <th>${views.fund_auto['已获返佣']}</th>
                <th>${views.fund_auto['状态']}<span tabindex="0" class="m-l-sm help-popover" role="button"
                            data-container="body" data-toggle="popover"
                            data-html="true"
                            data-trigger="focus" data-placement="top"
                            data-content="${views.fund['rebate.rebateStatus.tips']}"
                ><i
                        class="fa fa-question-circle"></i></span></th>
                <th>${views.fund_auto['操作']}</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr>
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                    <td>
                        <a href="/userAgent/agent/detail.html?search.id=${p.agentId}" nav-target="mainFrame">${p.agentName}</a>
                    </td>
                    <td>${p.effectivePlayer}</td>
                    <td colspan="2" class="multiple-row-td">
                        <div>
                            <soul:button target="${root}/fund/rebate/agent/grads/payOut.html?search.agentId=${p.agentId}&search.rebateYear=${p.rebateBillId}&search.rebateMonth=${p.rebateBillId}"
                                         text="${views.fund_auto['损益明细']}" opType="dialog">
                                         ${soulFn:formatCurrency(p.payoutAmountHistory)}
                            </soul:button>
                        </div>
                        <div>
                            <soul:button target="${root}/fund/rebate/agent/grads/payOut.html?search.agentId=${p.agentId}&search.rebateYear=${p.rebateBillId}&search.rebateMonth=${p.rebateBillId}"
                                          text="${views.fund_auto['损益明细']}" opType="dialog">
                                          ${soulFn:formatCurrency(p.payoutAmount)}
                            </soul:button>
                        </div>
                    </td>
                    <td colspan="2" class="multiple-row-td">
                        <div>${soulFn:formatCurrency(p.effectiveAmountHistory)}</div>
                        <div>${soulFn:formatCurrency(p.effectiveAmount)}</div>
                    </td>
                    <td colspan="2" class="multiple-row-td">
                        <div>
                            <a href="/fund/rebate/agent/list.html?search.agentId=${p.agentId}&search.rebateYear=${p.rebateYear}&search.rebateMonth=${p.rebateMonth}"
                               nav-target="mainFrame" class="co-blue">
                                    ${soulFn:formatCurrency(p.feeAmountHistory + p.otherAmountHistory + p.favorableAmountHistory + p.rakebackAmountHistory)}
                            </a>
                        </div>
                        <div>
                            <a href="/fund/rebate/agent/list.html?search.agentId=${p.agentId}&search.rebateYear=${p.rebateYear}&search.rebateMonth=${p.rebateMonth}"
                               nav-target="mainFrame" class="co-blue">
                                    ${soulFn:formatCurrency(p.feeAmount + p.otherAmount + p.favorableAmount + p.rakebackAmount)}
                            </a>
                        </div>
                    </td>
                    <td>
                        <soul:button target="${root}/fund/rebate/agent/grads/retrunRebateDetail.html?search.agentId=${p.agentId}&search.rebateYear=${p.rebateYear}&search.rebateMonth=${p.rebateMonth}"
                                     text="${views.fund_auto['可获返佣明细']}" opType="dialog" size="size-wide">
                            ${soulFn:formatCurrency(p.rebateAmount)}
                        </soul:button>
                    </td>
                    <td>
                        <span class="${p.rebateAmountActual gt 0 ? 'co-red':''}">
                            ${soulFn:formatCurrency(p.rebateAmountActual)}
                        </span>
                    </td>
                    <td>${dicts.fund.rebate_status[p.rebateStatus]}</td>
                    <td>
                        <c:choose>
                            <c:when test="${p.rebateStatus eq '0'}">
                                <soul:button target="${root}/fund/rebate/toSettled.html?search.id=${p.id}" permission="operate:rebatesettle"
                                             text="${views.fund_auto['结算']}" opType="dialog" callback="query">
                                ${views.fund_auto['结算']}
                                </soul:button>
                                <soul:button target="${root}/fund/rebate/cleared/untreated.html?search.id=${p.id}" permission="operate:rebateclear"
                                             text="${views.fund_auto['清除']}" opType="ajax" callback="query"  confirm="${views.fund_auto['清除后数据将不会被累计到下一期']}">
                                    ${views.fund_auto['清除']}
                                </soul:button>
                                <soul:button target="${root}/fund/rebate/signBill.html?id=${p.id}" text="${views.fund_auto['挂账']}" permission="operate:rebatesignbill"
                                             confirm="${views.fund['rebate.signbill.tips']}" opType="ajax" callback="query"></soul:button>
                            </c:when>
                            <c:when test="${p.rebateStatus eq '1'}">
                                <soul:button target="${root}/fund/rebate/cleared/notreached.html?search.id=${p.id}" permission="operate:rebateclear"
                                             text="${views.fund_auto['清除']}" opType="ajax" callback="query" confirm="${views.fund_auto['清除后数据将不会被累计到下一期']}">
                                ${views.fund_auto['清除']}
                                </soul:button>
                                <soul:button target="${root}/fund/rebate/signBill.html?id=${p.id}" text="${views.fund_auto['挂账']}" permission="operate:rebatesignbill"
                                             confirm="${views.fund['rebate.signbill.tips']}" opType="ajax" callback="query"></soul:button>
                            </c:when>
                            <c:otherwise>

                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>--%>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
