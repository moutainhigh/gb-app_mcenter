<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-10-14
  Time: 下午8:18
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerTransactionVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="col-lg-12 m-t">
    <div class="wrapper white-bg shadow clearfix">
        <div class="sys_tab_wrap"><div class="m-sm"><b>${views.report['fund.detail.favorable']}</b></div></div>
        <div class="p-sm p-b-xxs">${views.report['fund.detail.playerAccount']}<span class="co-blue">${command.result.username}</span>
            <a class="btn btn-filter btn-outline btn-sm m-l-sm" href="/report/fundsLog/list.html?search.username=${command.result.username}&search.fundTypes=favourable" nav-target="mainFrame">${views.operation['backwater.settlement.view.queryAllBill']}</a>
        </div>


        <div class="dataTables_wrapper p-x" role="grid">


            <div class="panel-body">

                <div class="table-responsive">
                    <table class="table border m-b-none">
                        <thead>
                        <tr class="bg-gray">
                            <th colspan="5"><div class="al-left">${views.report['fund.detail.orderInfo']}</div></th>
                        </tr>
                       <tr>
                            <th>${views.report['fund.detail.transactionNo']}</th>
                            <th>${views.report['fund.detail.transactionInfo']}</th>
                            <th>${views.report['fund.detail.money']}</th>
                            <th>${views.report['fund.detail.balance']}</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>
                                ${command.result.transactionNo}
                                <c:if test="${command.result.origin eq 'MOBILE'}">
                                    <span class="fa fa-mobile mobile" data-content="${views.report_auto['手机订单']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                                    </span>
                                </c:if>
                            </td>
                            <td>
                                <c:set var="_hadLanguage" value="0"></c:set>
                                <%--<c:forEach items="${command.result.tr}" var="favorableName">--%>
                                    <%--<c:if test="${favorableName.local eq language}">--%>
                                        <%--${favorableName.name}--%>
                                        <%--<c:set var="hadLanguage" value="1"></c:set>--%>
                                    <%--</c:if>--%>
                                <%--</c:forEach>--%><%--为什么会有三种写法呢 这是因为它们是互补的 。优惠描述的来源不单一 --%>
                                    ${command.result._describe[language]}${dicts.common.transaction_way[command.result._describe['transaction_way']]}${dicts.common.fund_type[command.result._describe['transaction_way']]}</span></td>
                            </td>
                            <td class="co-green">+${soulFn:formatCurrency(command.result.transactionMoney)}</td>
                            <td>${soulFn:formatCurrency(command.result.balance)}</td>
                        </tr>
                        <tr class="bg-gray">
                            <td colspan="5" class="al-left"><b>${views.report['fund.detail.failReason']}</b> ${empty command.result.failureReason ? '---':command.result.failureReason}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="dataTables_wrapper p-x" role="grid">
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table border m-b-none">
                        <tr>
                            <th>${views.report['fund.detail.createTime']}</th>
                            <th>${views.report['fund.detail.operateUser']}</th>
                            <th>${views.report['fund.detail.completionTime']}</th>
                            <th>${views.report['fund.detail.status']}</th>
                        </tr>
                        <tr>
                            <td>
                                <c:if test="${empty command.result.createTime}">
                                ---
                                </c:if>
                                ${soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                            <td>
                                <c:if test="${empty command.operator}">
                                ---
                                </c:if>
                                <%-- 救济金优惠为系统自动发放--%>
                                <c:choose >
                                    <c:when test="${command.operator eq '__admin__'}">
                                        ${views.report['fund.detail.systemAuto']}
                                    </c:when>
                                    <c:otherwise>
                                        ${command.operator}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${empty command.result.completionTime}">
                                    ${empty command.result.createTime?'---':""}
                                    ${soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)}
                                </c:if>
                                ${soulFn:formatDateTz(command.result.completionTime, DateFormat.DAY_SECOND,timeZone)}</td>
                            <td>${dicts.common.status[command.result.status]}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>