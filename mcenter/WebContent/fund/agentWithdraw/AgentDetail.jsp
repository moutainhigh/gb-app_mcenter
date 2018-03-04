<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.RemarkListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form  action="${root}/fund/vAgentWithdrawOrder/agentDetail.html?search.id=${vo.result.id}" method="POST">
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['资金']}</span>
            <span>/</span><span>${views.sysResource['代理取款审核']}</span>
            <%--<a href="/fund/vAgentWithdrawOrder/agentList.html" nav-target="mainFrame"--%>
               <%--class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">--%>
                <%--<em class="fa fa-caret-left"></em>返回--%>
            <%--</a>--%>
            <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="/fund/vAgentWithdrawOrder/agentDetail.html?search.id=${vo.result.id}&random=<%=Math.random()%>"
               nav-target="mainFrame" name="returnView" style="display: none"></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg clearfix shadow">
                <div class="sys_tab_wrap clearfix line-hi34 p-sm">
                    <div class="pull-left">
                        <h3 class="pull-left m-t-none m-b-none">${views.fund['withdraw.edit.AgentWithdraw.agentWithdrawDetail']}</h3>
                    </div>
                </div>
                <div class="table-responsive">
                    <div class="panel blank-panel">
                        <div class="panel-body">
                            <div class="tab-content">
                                <div class="tab-pane active">
                                    <div class="al-left">
                                        <label class=""><b>${views.fund['withdraw.index.AgentWithdraw.agentAccount']}：</b>
                                            <span class="co-blue">
                                                <a href="/userAgent/agent/detail.html?search.id=${vo.result.agentId}"
                                                   nav-Target="mainFrame">
                                                    ${vo.result.username}
                                                </a>
                                                </span>
                                        </label>
                                    </div>
                                    <div class="det-title"><b>${views.fund['withdraw.edit.AgentWithdraw.orderInfo']}</b></div>
                                    <table class="table table-bordered dataTable">
                                        <thead>
                                        <tr>
                                            <th>${views.fund['withdraw.edit.AgentWithdraw.trade_description']}</th>
                                            <th>${views.fund['withdraw.edit.AgentWithdraw.currency']}</th>
                                            <th>${views.fund['withdraw.edit.AgentWithdraw.withdrawAmount']}</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>
                                                ${views.fund['withdraw.edit.AgentWithdraw.commissionBalanceWithdrawal']} ${views.column["VPlayerWithdraw.transactionNo"]}：${vo.result.transactionNo}</td>
                                            <td>${vo.result.currency}</td>
                                            <td class="co-blue"><fmt:formatNumber
                                                    value="${vo.result.withdrawAmount}" pattern="0.00"/></td>
                                        </tr>
                                        </tbody>
                                    </table>

                                    <table class="table table-bordered dataTable">
                                        <thead>
                                        <tr>
                                            <th>${views.fund['withdraw.edit.AgentWithdraw.status']}</th>
                                            <th>${views.fund['withdraw.edit.AgentWithdraw.withdrawTime']}</th>
                                            <th>${views.fund['withdraw.index.AgentWithdraw.withdrawSuccessCount']}</th>
                                            <th>${views.fund['withdraw.edit.AgentWithdraw.agentWithdrawAccount']}</th>
                                            <th>${views.fund['withdraw.edit.AgentWithdraw.auditPerson']}</th>
                                            <th>${views.fund['withdraw.edit.AgentWithdraw.auditTime']}</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>${dicts.fund.transaction_status[vo.result.transactionStatus]}
                                                <c:choose>
                                                    <c:when test="${vo.result.transactionStatus=='1'}">
                                                        <input type="hidden" name="id" value="${vo.result.id}"/>
                                                        <soul:button permission="fund:agentwithdraw_check" target="agentWithdrawAuditView" text="${views.fund['withdraw.index.AgentWithdraw.audit']}" opType="function" id="mainFrame" ></soul:button>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>${soulFn:formatDateTz(vo.result.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                                            <td>${vo.result.withdrawCount}</td>
                                            <td>
                                                ${dicts.common.bankname[vo.result.agentBank]}&nbsp;&nbsp;
                                                ${vo.result.agentRealname}&nbsp;&nbsp;
                                                    <c:choose>
                                                        <c:when test="${vo.result.isLock eq 1}">
                                                            <c:if test="${vo.result.lockPersonId == vo.thisUserId}">
                                                                ${vo.result.agentBankcard}
                                                                &nbsp;
                                                                <a data-clipboard-text="${vo.result.agentBankcard}" name="copy">${views.fund['withdraw.edit.AgentWithdraw.copy']}</a>
                                                            </c:if>
                                                            <c:if test="${vo.result.lockPersonId != vo.thisUserId}">
                                                                ${soulFn:overlayString(vo.result.agentBankcard)}
                                                            </c:if>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:choose>
                                                                <c:when test="${vo.result.transactionStatus eq '1'}">
                                                                    ${soulFn:overlayString(vo.result.agentBankcard)}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${vo.result.agentBankcard}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:otherwise>
                                                    </c:choose>
                                            </td>
                                            <td>${vo.result.auditname}</td>
                                            <td>${soulFn:formatDateTz(vo.result.auditTime, DateFormat.DAY_SECOND,timeZone)}</td>
                                        </tr>
                                        <c:if test="${vo.result.transactionStatus==3 ||vo.result.transactionStatus==4}">
                                            <tr>
                                                <th>${views.fund['withdraw.edit.AgentWithdraw.failReason']}</th>
                                                <td colspan="6" class="al-left">${vo.result.reasonContent}</td>
                                            </tr>
                                        </c:if>
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="wrapper white-bg clearfix shadow m-t-md">
                <div class="panel blank-panel">
                    <div class="panel-body">
                        <div class="sys_tab_wrap clearfix p-xs">
                            <div class="pull-left  line-hi34">
                                <h3 class="pull-left m-t-xs m-b-none">${views.fund['withdraw.edit.AgentWithdraw.remark']}</h3>
                            </div>
                            <div class="pull-right">
                                <soul:button text="${views.fund['withdraw.view.addRemark']}"
                                             target="${root}/playerRemark/create.html?result.entityUserId=${command.search.entityUserId}&result.remarkType=${command.search.remarkType}&result.model=${command.search.model}&result.entityId=${command.search.entityId}"
                                             opType="dialog" cssClass="btn btn-outline btn-filter pull-left"
                                             callback="queryAgentWithdrawRemark">
                                    <i class="fa fa-flag"></i> ${views.fund['withdraw.view.addRemark']}
                                </soul:button>
                            </div>
                        </div>
                        <div class="search-list-container">
                            <%@include file="AgentDetailPartial.jsp" %>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</form>
<soul:import res="site/fund/agent/Agent"/>