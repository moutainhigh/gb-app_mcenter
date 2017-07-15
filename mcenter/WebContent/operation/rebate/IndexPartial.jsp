<%@ page import="so.wwb.gamebox.model.master.operation.po.RebateBill" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RebateBillVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set value="<%=RebateBill.class%>" var="poType"></c:set>
<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
            <tr role="row" class="bg-gray">
                <th>${views.common['number']}</th>
                <th>${views.column['RebateBill.settlementName']}</th>
                <th>${views.column['RebateBill.startAndEndTime']}</th>
                <th>${views.column['RebateBill.count']}</th>
                <th>
                    ${views.column['RebateBill.rebateTotal']}<span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                            data-content="${views.report['rebate.help.total']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                </th>
                <th>
                    ${views.column['RebateBill.rebateActual']}<span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                            data-content="${views.report['rebate.help.actual']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                </th>
                <th class="inline">
                    <gb:select name="search.lssuingState" value="${command.search.lssuingState}" cssClass="btn-group chosen-select-no-single" callback="query" prompt="${views.common['all']}" list="${lssuingState}"></gb:select>
                </th>
                <th>${views.common['operate']}</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr>
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                    <td>
                        ${p.settlementName}
                    </td>
                    <td>${soulFn:formatDateTz(p.startTime, DateFormat.DAY,timeZone)} ~ ${soulFn:formatDateTz(p.endTime, DateFormat.DAY,timeZone)}</td>
                    <td>
                        <%--<span class="${p.agentCount eq 0?'':'co-blue'}">--%>
                            <c:choose>
                                <c:when test="${p.agentCount eq 0}">
                                    ${p.agentCount}
                                </c:when>
                                <c:otherwise>
                                    <a href="/operation/rebate/detail.html?id=${p.id}&settlementState=pending_lssuing" nav-target="mainFrame">${p.agentCount}</a>
                                </c:otherwise>
                            </c:choose>
                        <%--</span>--%>
                        /
                        <%--<span class="${p.agentLssuingCount eq 0?'':'co-blue'}">--%>
                            <c:choose>
                                <c:when test="${p.agentLssuingCount eq 0}">
                                    ${p.agentLssuingCount}
                                </c:when>
                                <c:otherwise>
                                    <a href="/operation/rebate/detail.html?id=${p.id}&settlementState=lssuing" nav-target="mainFrame">${p.agentLssuingCount}</a>
                                </c:otherwise>
                            </c:choose>
                        <%--</span>--%>
                        /
                        <%--<span class="${p.agentRejectCount eq 0?'':'co-blue'}">--%>
                            <c:choose>
                                <c:when test="${p.agentRejectCount eq 0}">
                                    ${p.agentRejectCount}
                                </c:when>
                                <c:otherwise>
                                    <a href="/operation/rebate/detail.html?id=${p.id}&settlementState=reject_lssuing" nav-target="mainFrame">${p.agentRejectCount}</a>
                                </c:otherwise>
                            </c:choose>
                        <%--</span>--%>
                    </td>
                    <td class="${p.rebateTotal ge 0 ?'co-red':'co-green'}">
                        <c:if test="${p.rebateTotal ge 0}">+</c:if>
                        ${soulFn:formatCurrency(p.rebateTotal)}
                    </td>
                    <td class="${p.rebateActual ge 0 ?'co-red':'co-green'}">
                        <c:if test="${p.rebateActual ge 0}">+</c:if>
                        ${soulFn:formatCurrency(p.rebateActual)}
                    </td>
                    <td>
                        <span
                        <c:choose>
                            <c:when test="${p.lssuingState eq 'pending_pay'}">
                                class="label label-orange"
                            </c:when>
                            <c:when test="${p.lssuingState eq 'part_pay'}">
                                class="label label-success"
                            </c:when>
                            <c:when test="${p.lssuingState eq 'all_pay'}">
                                class="label"
                            </c:when>
                            <c:when test="${p.lssuingState eq 'next_pay'}">
                                class="label"
                            </c:when>
                        </c:choose>
                        >
                            <c:choose>
                                <c:when test="${p.lssuingState eq 'next_pay'}">
                                    ${views.operation['Rebate.list.nextPay']}
                                </c:when>
                                <c:otherwise>
                                    ${dicts.operation.lssuing_state[p.lssuingState]}</span>
                                </c:otherwise>
                            </c:choose>

                    </td>
                    <td>
                        <c:if test="${p.lssuingState ne 'next_pay'}">
                            <a href="/operation/rebate/detail.html?id=${p.id}" nav-target="mainFrame">${views.common['detail']}</a>
                            <c:if test="${(p.lssuingState eq 'pending_pay') or p.lssuingState eq 'part_pay'}">
                                <shiro:hasPermission name="operate:rebate_settle">
                                    <span class="dividing-line m-r-xs m-l-xs">|</span>
                                    <a href="/operation/rebate/clearing.html?id=${p.id}" nav-target="mainFrame">${views.common['clearing']}</a>
                                </shiro:hasPermission>
                            </c:if>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
