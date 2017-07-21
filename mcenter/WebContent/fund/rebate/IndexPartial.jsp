<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.rebate.vo.AgentRebateListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<div class="table-responsive">
    <table class="table table-striped table-hover dataTable table-multiple-header-row table-bordered" id="editable" aria-describedby="editable_info">
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
                        ${p.agentusername}
                    </td>
                    <td>${p.effectivePlayerNum}</td>
                    <td colspan="2" class="multiple-row-td">
                        <div>
                            <soul:button target="${root}/fund/rebate/agent/grads/payOut.html?search.agentId=${p.agentId}&search.rebateYear=${p.rebateYear}&search.rebateMonth=${p.rebateMonth}"
                                         text="${views.fund_auto['损益明细']}" opType="dialog">
                                         ${soulFn:formatCurrency(p.payoutAmountHistory)}
                            </soul:button>
                        </div>
                        <div>
                            <soul:button target="${root}/fund/rebate/agent/grads/payOut.html?search.agentId=${p.agentId}&search.rebateYear=${p.rebateYear}&search.rebateMonth=${p.rebateMonth}"
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
                                <soul:button target="${root}/fund/rebate/toSettled.html?search.id=${p.id}"
                                             text="${views.fund_auto['结算']}" opType="dialog" callback="query">
                                ${views.fund_auto['结算']}
                                </soul:button>
                                <soul:button target="${root}/fund/rebate/cleared/untreated.html?search.id=${p.id}"
                                             text="${views.fund_auto['清除']}" opType="ajax" callback="query"  confirm="${views.fund_auto['清除后数据将不会被累计到下一期']}">
                                    ${views.fund_auto['清除']}
                                </soul:button>
                                <soul:button target="${root}/fund/rebate/signBill.html?id=${p.id}" text="${views.fund_auto['挂账']}"
                                             confirm="${views.fund['rebate.signbill.tips']}" opType="ajax" callback="query"></soul:button>
                            </c:when>
                            <c:when test="${p.rebateStatus eq '1'}">
                                <soul:button target="${root}/fund/rebate/cleared/notreached.html?search.id=${p.id}"
                                             text="${views.fund_auto['清除']}" opType="ajax" callback="query" confirm="${views.fund_auto['清除后数据将不会被累计到下一期']}">
                                ${views.fund_auto['清除']}
                                </soul:button>
                                <soul:button target="${root}/fund/rebate/signBill.html?id=${p.id}" text="${views.fund_auto['挂账']}"
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
