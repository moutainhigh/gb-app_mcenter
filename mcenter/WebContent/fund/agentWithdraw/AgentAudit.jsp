<%--@elvariable id="command" type="so.wwb.gamebox.model.master.agent.vo.AgentTradingOrderListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <form>
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['资金']}</span>
            <span>/</span><span>${views.sysResource['代理取款审核']}</span>
            <a href="/fund/vAgentWithdrawOrder/agentList.html" nav-target="mainFrame" name="return"
               class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn"><em class="fa fa-caret-left"></em>${views.sysResource['返回']}</a>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
            <shiro:hasPermission name="fund:agentwithdraw_check">
                <a href="/fund/vAgentWithdrawOrder/agentAudit.html?search.id=${command.result.id}&random=<%=Math.random()%>"
                   nav-target="mainFrame" name="returnView" style="display: none"></a>
            </shiro:hasPermission>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div class="present_wrap"><b>${views.fund['withdraw.edit.AgentWithdraw.AgentWithdrawAudit']}</b></div>
                <div class="btn-group m-t-sm">
                    <button data-toggle="dropdown" class="btn btn-link dropdown-toggle account-pull-down m-l-xs"
                            aria-expanded="true">
                        ${views.fund['withdraw.index.AgentWithdraw.agentAccount']}：
                        <a class="co-blue" href="/userAgent/agent/detail.html?search.id=${command.result.agentId}"
                           nav-Target="mainFrame">
                            ${command.result.username}
                        </a>
                    </button>
                    <div class="pull-right m-l-sm line-hi34">
                        <c:choose>
                            <c:when test="${command.result.isLock==null}">
                                <soul:button
                                        target="lockOrder" text="${views.fund['withdraw.edit.playerWithdraw.lockOrder']}" opType="function"
                                        cssClass="lockRefresh btn btn-outline btn-filter btn-sm" callback="withdrawRefresh"
                                        confirm="${views.fund['withdraw.edit.playerWithdraw.isOkLockOrder']}"/>
                                <soul:button
                                        target="${root}/fund/vAgentWithdrawOrder/cancelLockOrder.html?search.id=${command.result.id}"
                                        text="${views.fund['withdraw.edit.playerWithdraw.cancelLockOrder']}" opType="ajax" dataType="json"
                                        cssClass="cancelLockOrder btn btn-outline btn-filter btn-sm hidden"
                                        post="getCurrentFormData" callback="withdrawRefresh" confirm="${views.fund['withdraw.edit.playerWithdraw.isOkCancelLockOrder']}"/>
                                <i class="cancelPerson" style="display:none">${views.fund['withdraw.edit.playerWithdraw.LockPerson']}：${command.result.lockPersonName}</i>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${command.result.isLock eq 1}">
                                    <c:if test="${command.result.lockPersonId == command.thisUserId}">
                                        <soul:button
                                                target="lockOrder" text="${views.fund['withdraw.edit.playerWithdraw.lockOrder']}" opType="function"
                                                cssClass="lockRefresh btn btn-outline btn-filter btn-sm hidden" callback="withdrawRefresh"
                                                confirm="${views.fund['withdraw.edit.playerWithdraw.isOkLockOrder']}"/>
                                        <soul:button
                                                target="${root}/fund/vAgentWithdrawOrder/cancelLockOrder.html?search.id=${command.result.id}"
                                                text="${views.fund['withdraw.edit.playerWithdraw.cancelLockOrder']}" opType="ajax" dataType="json"
                                                cssClass="cancelLockOrder btn btn-outline btn-filter btn-sm"
                                                post="getCurrentFormData" callback="withdrawRefresh"
                                                confirm="${views.fund['withdraw.edit.playerWithdraw.isOkCancelLockOrder']}"/>
                                        <i class="cancelPerson">${views.fund['withdraw.edit.playerWithdraw.LockPerson']}：${command.result.lockPersonName}</i>
                                    </c:if>
                                    <c:if test="${command.result.lockPersonId != command.thisUserId}">
                                        <soul:button
                                                target="lockOrder" text="${views.fund['withdraw.edit.playerWithdraw.lockOrder']}" opType="function"
                                                cssClass="lockRefresh btn btn-outline btn-filter btn-sm hidden" callback="withdrawRefresh"
                                                confirm="${views.fund['withdraw.edit.playerWithdraw.isOkLockOrder']}"/>
                                        <soul:button
                                                target="${root}/fund/vAgentWithdrawOrder/cancelLockOrder.html?search.id=${command.result.id}"
                                                text="${views.fund['withdraw.edit.playerWithdraw.cancelLockOrder']}" opType="ajax" dataType="json"
                                                cssClass="cancelLockOrder btn btn-outline btn-filter btn-sm ui-button-disable"
                                                post="getCurrentFormData" callback="withdrawRefresh"
                                                confirm="${views.fund['withdraw.edit.playerWithdraw.isOkCancelLockOrder']}"/>
                                        <i class="cancelPerson">${views.fund['withdraw.edit.playerWithdraw.LockPerson']}：${command.result.lockPersonName}</i>
                                    </c:if>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="p-sm">
                    <div class="table-responsive tab-border-1">
                        <table class="table  table-striped table-hover dataTable m-b-none"
                               aria-describedby="editable_info">
                            <thead>
                            <tr class="bg-gray">
                                <th class="co-yellow">${views.fund['withdraw.edit.AgentWithdraw.trade_description']}</th>
                                <th>${views.fund['withdraw.edit.AgentWithdraw.currency']}</th>
                                <th>${views.fund['withdraw.edit.AgentWithdraw.withdrawAmount']}</th>
                                <th>${views.fund['withdraw.edit.AgentWithdraw.agentWithdrawAccount']}</th>
                                <th>${views.fund['withdraw.index.AgentWithdraw.withdrawSuccessCount']}</th>
                                <th>${views.fund['withdraw.edit.AgentWithdraw.withdrawTime']}</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    ${views.fund['withdraw.edit.AgentWithdraw.commissionBalanceWithdrawal']} ${views.column["VPlayerWithdraw.transactionNo"]}：${command.result.transactionNo}</td>
                                <td>${command.result.currency}</td>
                                <td class="co-blue"><fmt:formatNumber value="${command.result.withdrawAmount}"
                                                                      pattern="0.00"/></td>
                                <td>
                                    <b>${views.fund['withdraw.edit.AgentWithdraw.agentWithdrawAccount']}：</b>${dicts.common.bankname[command.result.agentBank]}&nbsp;&nbsp;${command.result.agentRealname}&nbsp;&nbsp;
                                    <c:choose>
                                        <c:when test="${command.result.isLock==null}">
                                            <c:if test="${userBankcardVo.result.useCount=='0'}">
                                                <span class="co-red">${soulFn:overlayString(command.result.agentBankcard)}</span>【${views.fund['withdraw.edit.playerWithdraw.firstUse']}】
                                            </c:if>
                                            <c:if test="${userBankcardVo.result.useCount!='0'}">
                                                ${soulFn:overlayString(command.result.agentBankcard)}
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${command.result.isLock eq 1}">
                                                <c:if test="${command.result.lockPersonId == command.thisUserId}">
                                                    <c:if test="${userBankcardVo.result.useCount=='0'}">
                                                        <span class="co-red">${command.result.agentBankcard}</span>【${views.fund['withdraw.edit.playerWithdraw.firstUse']}】
                                                    </c:if>
                                                    <c:if test="${userBankcardVo.result.useCount!='0'}">
                                                        ${command.result.agentBankcard}
                                                    </c:if>
                                                    &nbsp;
                                                    <a data-clipboard-target="p0_agentBankcard" data-clipboard-text="${command.result.agentBankcard}" name="copy">${views.fund['withdraw.edit.playerWithdraw.copy']}</a>
                                                </c:if>
                                                <c:if test="${command.result.lockPersonId != command.thisUserId}">
                                                    <c:if test="${userBankcardVo.result.useCount=='0'}">
                                                        <span class="co-red">${soulFn:overlayString(command.result.agentBankcard)}</span>【${views.fund['withdraw.edit.playerWithdraw.firstUse']}】
                                                    </c:if>
                                                    <c:if test="${userBankcardVo.result.useCount!='0'}">
                                                        ${soulFn:overlayString(command.result.agentBankcard)}
                                                    </c:if>
                                                </c:if>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${command.result.withdrawCount}</td>
                                <td>${soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="addNotes m-t"><label class="line-hi34 ft-bold">${views.fund['withdraw.edit.AgentWithdraw.remark']} : </label></div>
                    <div class="addNotes"><textarea class="form-control" name="remarkContent" maxlength="200"></textarea></div>
                </div>
                <div class="operate-btn al-center">
                        <input type="hidden" name="id" value="${command.result.id}"/>
                        <input type="hidden" name="withdrawAmount" value="${command.result.withdrawAmount}"/>
                    <c:choose>
                        <c:when test="${command.result.isLock == 1}">
                            <c:if test="${command.result.lockPersonId == command.thisUserId}">
                                <soul:button target="${root}/fund/vAgentWithdrawOrder/putConfirmRefuses.html?search.id=${command.result.id}" opType="dialog"
                                             cssClass="btn btn-outline btn-filter btn-lg pull-left"
                                             text="${views.common['checkRefuses']}" title="${views.fund['withdraw.edit.playerWithdraw.checkRefusedWithdrawReason']}" callback="withdrawAuditOk"/>
                                <soul:button target="${root}/fund/vAgentWithdrawOrder/putConfirmCheck.html?search.id=${command.result.id}" opType="dialog" cssClass="btn btn-filter btn-lg"
                                             tag="button" text="${views.fund['withdraw.edit.playerWithdraw.okWithdrawAudit']}" callback="withdrawAuditOk">${views.common['checkPass']}</soul:button>
                                <soul:button target="${root}/fund/vAgentWithdrawOrder/putCheckFailure.html?search.id=${command.result.id}" opType="dialog" cssClass="btn btn-outline btn-filter btn-lg"
                                             text="${views.common['checkFailure']}" title="${views.fund['withdraw.edit.playerWithdraw.checkWithdrawFailReason']}" callback="withdrawAuditOk"/>
                            </c:if>
                            <c:if test="${command.result.lockPersonId != command.thisUserId}">
                                <soul:button target="${root}/fund/vAgentWithdrawOrder/putConfirmRefuses.html?search.id=${command.result.id}" opType="dialog"
                                             cssClass="btn btn-outline btn-filter btn-lg pull-left ui-button-disable disabled"
                                             text="${views.common['checkRefuses']}" title="${views.fund['withdraw.edit.playerWithdraw.checkRefusedWithdrawReason']}" callback="withdrawAuditOk"/>
                                <soul:button target="${root}/fund/vAgentWithdrawOrder/putConfirmCheck.html?search.id=${command.result.id}" opType="dialog" cssClass="btn btn-filter btn-lg ui-button-disable disabled"
                                             tag="button" text="${views.fund['withdraw.edit.playerWithdraw.okWithdrawAudit']}" callback="withdrawAuditOk">${views.common['checkPass']}</soul:button>
                                <soul:button target="${root}/fund/vAgentWithdrawOrder/putCheckFailure.html?search.id=${command.result.id}" opType="dialog" cssClass="btn btn-outline btn-filter btn-lg ui-button-disable disabled"
                                             text="${views.common['checkFailure']}" title="${views.fund['withdraw.edit.playerWithdraw.checkWithdrawFailReason']}" callback="withdrawAuditOk"/>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <soul:button target="${root}/fund/vAgentWithdrawOrder/putConfirmRefuses.html?search.id=${command.result.id}" opType="dialog"
                                         cssClass="btn btn-outline btn-filter btn-lg pull-left ui-button-disable disabled"
                                         text="${views.common['checkRefuses']}" title="${views.fund['withdraw.edit.playerWithdraw.checkRefusedWithdrawReason']}" callback="withdrawAuditOk"/>
                            <soul:button target="${root}/fund/vAgentWithdrawOrder/putConfirmCheck.html?search.id=${command.result.id}" opType="dialog" cssClass="btn btn-filter btn-lg ui-button-disable disabled"
                                         tag="button" text="${views.fund['withdraw.edit.playerWithdraw.okWithdrawAudit']}" callback="withdrawAuditOk">${views.common['checkPass']}</soul:button>
                            <soul:button target="${root}/fund/vAgentWithdrawOrder/putCheckFailure.html?search.id=${command.result.id}" opType="dialog" cssClass="btn btn-outline btn-filter btn-lg ui-button-disable disabled"
                                         text="${views.common['checkFailure']}" title="${views.fund['withdraw.edit.playerWithdraw.checkWithdrawFailReason']}" callback="withdrawAuditOk"/>
                        </c:otherwise>
                    </c:choose>

                    <c:if test="${commandNextId.result.id!=null}">
                        <shiro:hasPermission name="fund:agentwithdraw_check">
                        <a href="/fund/vAgentWithdrawOrder/agentAudit.html?search.id=${commandNextId.result.id}"
                           nav-target="mainFrame" class="btn btn-outline btn-filter btn-lg pull-right commandNextId">${views.fund['despoit.index.next']}</a>
                        </shiro:hasPermission>
                    </c:if>
                    <c:if test="${commandNextId.result==null}">
                        <a href="/fund/vAgentWithdrawOrder/agentList.html" nav-target="mainFrame" class="btn btn-outline btn-filter pull-right commandNextId">${views.fund['withdraw.agent.toList']}</a>
                    </c:if>
                    <a nav-target="mainFrame" style="display: none" name="editTmpl" href="/noticeTmpl/tmpIndex.html?lastPage=t"><span></span></a>
                </div>
            </div>
        </div>
    </form>
</div>

<soul:import res="site/fund/agent/AgentAuditView"/>
