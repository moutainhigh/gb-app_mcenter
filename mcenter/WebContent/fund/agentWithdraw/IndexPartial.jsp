<%@ page import="org.soul.commons.net.IpTool" %><%--@elvariable id="command" type="so.wwb.gamebox.model.master.agent.vo.AgentTradingOrderListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="table-responsive table-min-h">
    <span id="totalSumSource" hidden>${command.totalSum}</span>
    <span id="todayTotalSource" hidden>${command.todayTotal}</span>
    <input id="todaySales" value="${command.search.todaySales}" hidden>
    <table class="table table-striped table-hover dataTable m-b-none" id="editable" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.common['orderNum']}</th>
            <th>${views.fund['withdraw.index.AgentWithdraw.agentAccount']}</th>
            <th>${views.fund['withdraw.index.AgentWithdraw.withdrawTime']}</th>
            <th>${views.fund['withdraw.index.AgentWithdraw.withdrawSuccessCount']}</th>
            <th>${views.fund['withdraw.index.AgentWithdraw.plaseWithdraw']}</th>

            <th class="inline">
                <gb:select name="search.transactionStatus" cssClass="btn-group chosen-select-no-single" prompt="${views.fund['withdraw.index.AgentWithdraw.all']}" list="${transactionStatus}" value="${command.search.transactionStatus}" callback="query" />
            </th>
            <th>${views.fund['审核人']}</th>
            <th>${views.fund['审核时间']}</th>
            <%--<th>${views.fund['withdraw.index.AgentWithdraw.operation']}</th>--%>
            <th>${views.fund['备注']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="s" varStatus="status">
            <tr class="tab-detail">
                <td><input type="hidden" name="id" value="${s.id}"/>
                    <a href="/fund/vAgentWithdrawOrder/showAgentAuditDetail.html?search.id=${s.id}" nav-target="mainFrame" class="co-blue">${s.transactionNo}</a></td>
                <td>
                    <div class="al-cleft">
                        <a  href="/userAgent/agent/detail.html?search.id=${s.agentId}" nav-Target="mainFrame">
                                ${s.username}
                        </a>
                    </div>
                </td>
                <td>
                    <span data-content="${soulFn:formatDateTz(s.createTime, DateFormat.DAY_SECOND,timeZone)}" data-placement="top" data-trigger="focus" data-toggle="popover"
                      data-container="body" role="button" class="help-popover" tabindex="0">
                        <span class="co-grayc2" >${s.createTimeMemo}</span>
                    </span>
                </td>
                <td>${empty s.withdrawCount?'0':s.withdrawCount}${views.fund['次']}</td>
                <td class="money">
                        ${siteCurrencySign}&nbsp;${soulFn:formatInteger(s.withdrawAmount)}<i>${soulFn:formatDecimals(s.withdrawAmount)}</i>
                    <a name="copy" data-clipboard-text="${s.withdrawAmount}" class="btn btn-xs btn-info btn-stroke"><li class="fa fa-copy" ></li></a>
                </td>
                <td>
                    <c:set var="status_css" value=""></c:set>
                    <c:if test="${s.transactionStatus == '1'}">
                        <c:set var="status_css" value="label-info"></c:set>
                    </c:if>
                    <c:if test="${s.transactionStatus == '2'}">
                        <c:set var="status_css" value="label-success"></c:set>
                    </c:if>
                    <c:if test="${s.transactionStatus == '3'}">
                        <c:set var="status_css" value="label-warning"></c:set>
                    </c:if>
                    <c:if test="${s.transactionStatus == '4'}">
                        <c:set var="status_css" value="label-danger"></c:set>
                    </c:if>
                    <shiro:hasPermission name="fund:agentwithdraw_check">
                        <soul:button target="${root}/fund/vAgentWithdrawOrder/showAgentAuditView.html?search.id=${s.id}"
                                     size="open-dialog-50" title="${views.fund_auto['快速取款审核']}" cssClass="co-blue" callback="auditCallBack"
                                     text="${dicts.fund.transaction_status[s.transactionStatus]}" opType="dialog">
                            <span class="label ${status_css} p-x-md">${dicts.fund.transaction_status[s.transactionStatus]}</span>
                        </soul:button>
                    </shiro:hasPermission>
                    <shiro:lacksPermission name="fund:agentwithdraw_check">
                        <span class="label ${status_css} p-x-md">${dicts.fund.transaction_status[s.transactionStatus]}</span>
                    </shiro:lacksPermission>
                </td>
                <td>${not empty s.auditname?s.auditname:'--'}</td>
                <td>
                    <c:if test="${not empty s.auditTime}">
                        <span data-content="${soulFn:formatDateTz(s.auditTime, DateFormat.DAY_SECOND, timeZone)}"
                              data-placement="top" data-trigger="focus"
                              data-toggle="popover"
                              data-container="body" role="button"
                              class="help-popover co-grayc2" tabindex="0">
                                <a name="copy"
                                   data-clipboard-text="${soulFn:formatDateTz(s.auditTime, DateFormat.DAY_SECOND, timeZone)}">
                                    <apan class="co-grayc2">${s.timeMemo}</apan>
                                </a>
                            </span>
                    </c:if>
                    <c:if test="${empty s.auditTime}">
                        --
                    </c:if>
                </td>
                <%--<td>
                    <input type="hidden" name="id" value="${s.id}"/>
                    <a href="/fund/vAgentWithdrawOrder/showAgentAuditDetail.html?search.id=${s.id}" nav-target="mainFrame" class="co-blue">${views.common['detail']}</a>
                </td>--%>
                <td>
                    <c:if test="${not empty s.ipWithdraw}">
                        IP:
                        <span data-content="${gbFn:getIpRegion(s.ipDictCode)}" data-placement="bottom" data-trigger="focus" data-toggle="popover"
                              data-container="body" role="button" class="help-popover" tabindex="0">
                            <span>
                                <a nav-target="mainFrame" href="/report/log/logList.html?search.roleType=agent&search.ip=${gbFn:ipv4LongToString(s.ipWithdraw)}&keys=search.ip&hasReturn=true">${gbFn:ipv4LongToString(s.ipWithdraw)}</a>
                            </span>
                        </span>
                        <br/>
                    </c:if>
                    <c:choose>
                        <c:when test="${fn:length(s.auditRemark)>20}">
                                    <span data-content="${s.auditRemark}" data-placement="bottom" data-trigger="focus" data-toggle="popover"
                                          data-container="body" role="button" class="help-popover" tabindex="0">
                                        ${fn:substring(s.auditRemark, 0, 20)}...
                                    </span>
                        </c:when>
                        <c:otherwise>
                            ${s.auditRemark}
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination/>
