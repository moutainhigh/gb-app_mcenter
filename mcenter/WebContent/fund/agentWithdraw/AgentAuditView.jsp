<%--@elvariable id="command" type="so.wwb.gamebox.model.master.agent.vo.AgentTradingOrderListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<!DOCTYPE html>
<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>
<body>

    <form id="auditForm" action="${root}/fund/vAgentWithdrawOrder/showAgentAuditView.html&search.id=${command.result.id}" method="post">
        <input type="hidden" name="result.id" value="${command.result.id}"/>
        <input type="hidden" name="search.id" value="${command.result.id}"/>
        <input type="hidden" name="result.agentId" value="${command.result.agentId}"/>
        <input type="hidden" name="withdrawAmount" value="${command.result.withdrawAmount}"/>
        <input type="hidden" name="transactionStatus" value="${command.result.transactionStatus}"/>
        <div class="modal-body clearfix">
            <table class="table no-border table-desc-list">
                <tbody>
                <c:choose>
                <c:when test="${command.result.isLock==null}">
                    <tr>
                        <td colspan="2">
                            <div class="pull-left">
                                <soul:button target="lockOrder" text="${views.fund['withdraw.edit.playerWithdraw.lockOrder']}" opType="function" cssClass="btn btn-blueshow m-r-sm">
                                    <i class="fa fa-lock"></i>${views.fund['withdraw.edit.playerWithdraw.lockOrder']}
                                </soul:button>
                                    ${views.fund['锁定后才可查看完整的收款账号']}
                            </div>
                            <div class="pull-right">
                                    ${views.fund['交易号：']}${command.result.transactionNo}
                                <a name="copy" data-clipboard-text="${command.result.transactionNo}" id="transactionNo-copy"
                                   class="btn btn-sm btn-info btn-stroke m-l-sm" title="${views.fund_auto['复制']}"><li class="fa fa-copy" ></li></a>
                            </div>
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:if test="${command.result.isLock eq 1}">
                        <c:if test="${command.result.lockPersonId == command.thisUserId || command.userType eq '2'}">
                            <tr>
                                <td colspan="2">
                                    <div class="pull-left">
                                        <soul:button target="${root}/fund/vAgentWithdrawOrder/cancelLockOrder.html?search.id=${command.result.id}"
                                                text="${views.fund['withdraw.edit.playerWithdraw.cancelLockOrder']}" opType="ajax" dataType="json"
                                                cssClass="btn btn-primary-hide m-r-sm ${command.result.transactionStatus!='1'?'ui-button-disable disabled':''}"
                                                post="getCurrentFormData" callback="withdrawRefresh">
                                            <i class="fa fa-unlock"></i>&nbsp;${views.fund['withdraw.edit.playerWithdraw.cancelLockOrder']}
                                        </soul:button>
                                            ${views.fund['锁定人：']}${command.result.lockPersonName}
                                    </div>
                                    <div class="pull-right">
                                            ${views.fund['交易号：']}${command.result.transactionNo}
                                        <a name="copy" data-clipboard-text="${command.result.transactionNo}" id="transactionNo-copy"
                                           class="btn btn-sm btn-info btn-stroke m-l-sm" title="${views.fund_auto['复制']}"><li class="fa fa-copy" ></li></a>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${command.result.lockPersonId != command.thisUserId && command.userType eq '21'}">
                            <tr>
                                <td colspan="2">
                                    <div class="pull-left">
                                    <a href="javascript:void(0)" class="btn btn-primary-hide m-r-sm ui-button-disable disabled"><i class="fa fa-unlock"></i>&nbsp;${views.fund['withdraw.edit.playerWithdraw.cancelLockOrder']}</a>
                                            ${views.fund['锁定人：']}${command.result.lockPersonName}
                                    </div>
                                    <div class="pull-right">
                                            ${views.fund['交易号：']}${command.result.transactionNo}
                                        <a name="copy" data-clipboard-text="${command.result.transactionNo}" id="transactionNo-copy"
                                           class="btn btn-sm btn-info btn-stroke m-l-sm" title="${views.fund_auto['复制']}"><li class="fa fa-copy" ></li></a>
                                    </div>
                                </td>
                            </tr>

                        </c:if>
                        <c:if test="${command.result.lockPersonId != command.thisUserId}">

                        </c:if>
                    </c:if>
                </c:otherwise>
                </c:choose>


                <tr>
                    <th scope="row" class="text-right" width="150">${views.fund['代理账号：']}</th>
                    <td>
                        <%--<a class="co-blue" href="/userAgent/agent/detail.html?search.id=${command.result.agentId}" nav-Target="mainFrame">
                            ${command.result.username}
                        </a>--%>${command.result.username}
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.fund['上层总代：']}</th>
                    <td>
                        <%--<a class="co-blue" href="/userAgent/topagent/detail.html?search.id=${topAgentVo.result.id}" nav-Target="mainFrame">
                            ${topAgentVo.result.username}
                        </a>--%>${topAgentVo.result.username}
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="text-right vtop">${views.fund['代理收款账号：']}</th>
                    <td>
                        <table class="table table-bordered width-response">
                            <tbody>
                            <tr>
                                <th scope="row" class="text-right active" width="120">${views.fund['真实姓名：']}</th>
                                <td>${command.result.agentRealname}
                                    <a name="copy" data-clipboard-text="${command.result.agentRealname}"
                                       class="btn btn-sm btn-info btn-stroke m-l-sm"><li class="fa fa-copy" title="${views.fund_auto['复制']}"></li></a>
                            </tr>
                            <tr>
                                <th scope="row" class="text-right active">${views.fund['银行：']}</th>
                                <td>${dicts.common.bankname[command.result.agentBank]}</td>
                            </tr>
                            <tr>
                                <th scope="row" class="text-right active">${views.fund['开户行：']}</th>
                                <td>
                                    <c:if test="${not empty userBankcardVo.result && not empty userBankcardVo.result.bankDeposit}">
                                        ${userBankcardVo.result.bankDeposit}
                                        <a name="copy" data-clipboard-text="${userBankcardVo.result.bankDeposit}"
                                           class="btn btn-sm btn-info btn-stroke m-l-sm"><li class="fa fa-copy" title="${views.fund_auto['复制']}"></li></a>
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row" class="text-right active">${views.fund['银行账号：']}</th>
                                <td>
                                    <c:if test="${command.result.isLock!='1'}">
                                        ${soulFn:overlayString(command.result.agentBankcard)}
                                    </c:if>
                                    <c:if test="${command.result.isLock=='1'}">
                                        <c:if test="${command.result.lockPersonId == command.thisUserId}">
                                            ${soulFn:formatBankCard(command.result.agentBankcard)}
                                            <a name="copy" data-clipboard-text="${command.result.agentBankcard}"
                                               class="btn btn-sm btn-info btn-stroke m-l-sm"><li class="fa fa-copy" title="${views.fund_auto['复制']}"></li></a>
                                        </c:if>
                                        <c:if test="${command.result.lockPersonId != command.thisUserId}">
                                            ${soulFn:overlayString(command.result.agentBankcard)}
                                        </c:if>

                                    </c:if>
                                    <c:if test="${userBankcardVo.result.useCount=='0'}">
                                        【${views.fund['withdraw.edit.playerWithdraw.firstUse']}】
                                    </c:if>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="text-right">${views.fund['创建时间：']}</th>
                    <td>${soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)} - <span class="co-grayc2">${command.result.createTimeMemo}</span></td>
                </tr>
                <c:if test="${command.result.transactionStatus=='1'}">
                    <tr class="warning">
                        <th scope="row" class="text-right">${views.fund['取款金额：']}</th>
                        <td class="money"><strong>${siteCurrencySign}${soulFn:formatInteger(command.result.withdrawAmount)}<i>${soulFn:formatDecimals(command.result.withdrawAmount)}</i></strong>
                            <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${soulFn:formatInteger(command.result.withdrawAmount)}${soulFn:formatDecimals(command.result.withdrawAmount)}" name="copy"><i class="fa fa-copy"></i></a>

                            <c:choose>
                                <c:when test="${command.result.isLock == 1}">
                                    <c:if test="${command.result.lockPersonId == command.thisUserId}">
                                        <%--<soul:button target="${root}/fund/vAgentWithdrawOrder/putAuditStatus.html?search.transactionStatus=2" opType="ajax"
                                                     cssClass="btn btn-primary p-x-sm m-l-sm" precall="isAudit" post="getCurrentFormData"
                                                     tag="button" text="${views.fund['withdraw.edit.playerWithdraw.okWithdrawAudit']}" callback="withdrawAuditOk">
                                            ${views.common['checkPass']}
                                        </soul:button>--%>
                                        <soul:button target="${root}/fund/vAgentWithdrawOrder/putConfirmCheck.html?search.id=${command.result.id}" opType="dialog"
                                                     cssClass="btn btn-primary p-x-sm m-l-sm" precall="isAudit" callback="withdrawAuditOk"
                                                     tag="button" text="${views.fund['withdraw.edit.playerWithdraw.okWithdrawAudit']}">
                                            ${views.common['checkPass']}
                                        </soul:button>
                                        <soul:button target="${root}/fund/vAgentWithdrawOrder/putCheckFailure.html?search.id=${command.result.id}" opType="dialog"
                                                     cssClass="btn btn-danger p-x-sm m-l-sm" precall="showErrorReason" post="getCurrentFormData"
                                                     text="${views.common['checkFailure']}" title="${views.fund['withdraw.edit.playerWithdraw.checkWithdrawFailReason']}" callback="failToReturn"/>
                                        <soul:button target="${root}/fund/vAgentWithdrawOrder/putConfirmRefuses.html?search.id=${command.result.id}" opType="dialog"
                                                     cssClass="btn btn-warning p-x-sm m-l-sm " precall="showRefuseReason"
                                                     text="${views.common['checkRefuses']}" title="${views.fund['withdraw.edit.playerWithdraw.checkRefusedWithdrawReason']}" callback="failToReturn"/>
                                    </c:if>
                                    <c:if test="${command.result.lockPersonId != command.thisUserId}">
                                        <a class="btn btn-primary p-x-sm m-l-sm ui-button-disable disabled">
                                                ${views.common['checkPass']}
                                        </a>
                                        <a class="btn btn-danger p-x-sm m-l-sm ui-button-disable disabled">
                                                ${views.common['checkFailure']}
                                        </a>
                                        <a class="btn btn-warning p-x-sm m-l-sm ui-button-disable disabled">
                                                ${views.common['checkRefuses']}
                                        </a>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <a class="btn btn-primary p-x-sm m-l-sm ui-button-disable disabled">
                                            ${views.common['checkPass']}
                                    </a>
                                    <a class="btn btn-danger p-x-sm m-l-sm ui-button-disable disabled">
                                            ${views.common['checkFailure']}
                                    </a>
                                    <a class="btn btn-warning p-x-sm m-l-sm ui-button-disable disabled">
                                            ${views.common['checkRefuses']}
                                    </a>
                                </c:otherwise>
                            </c:choose>
                            <span class="co-gray9 m-l-md">${views.fund['已成功取款']}<span class="co-yellow">${not empty command.result.withdrawCount?command.result.withdrawCount:'0'}</span>${views.fund_auto['次']}</span>
                        </td>
                    </tr>
                </c:if>

                <c:if test="${command.result.transactionStatus=='2'}">
                    <tr class="success">
                        <th scope="row" class="text-right">${views.fund['实际取款：']}</th>
                        <td class="money"><strong>${dicts.common.currency_symbol[command.result.currency]} ${soulFn:formatInteger(command.result.withdrawAmount)}<i>${soulFn:formatDecimals(command.result.withdrawAmount)}</i></strong>
                            <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${soulFn:formatInteger(command.result.withdrawAmount)}${soulFn:formatDecimals(command.result.withdrawAmount)}" name="copy"><i class="fa fa-copy"></i></a>
                            <span class="co-green">${views.fund['成功']}</span> <span class="co-gray9 m-l-md">${views.fund['已成功取款']}<span class="co-yellow">${not empty command.result.withdrawCount?command.result.withdrawCount:'0'}</span>${views.fund_auto['次']}</span>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${command.result.transactionStatus=='3'}">
                    <tr class="danger">
                        <th scope="row" class="text-right">${views.fund['实际取款：']}</th>
                        <td class="money"><strong>${dicts.common.currency_symbol[command.result.currency]} ${soulFn:formatInteger(command.result.withdrawAmount)}<i>${soulFn:formatDecimals(command.result.withdrawAmount)}</i></strong>
                            <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${soulFn:formatInteger(command.result.withdrawAmount)}${soulFn:formatDecimals(command.result.withdrawAmount)}" name="copy"><i class="fa fa-copy"></i></a>
                            <span class="co-red">${views.fund['失败']}</span> <span class="co-gray9 m-l-md">${views.fund['已成功取款']}<span class="co-yellow">${not empty command.result.withdrawCount?command.result.withdrawCount:'0'}</span>${views.fund_auto['次']}</span>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${command.result.transactionStatus=='4'}">
                    <tr class="warning">
                        <th scope="row" class="text-right">${views.fund['实际取款：']}</th>
                        <td class="money"><strong>${dicts.common.currency_symbol[command.result.currency]} ${soulFn:formatInteger(command.result.withdrawAmount)}<i>${soulFn:formatDecimals(command.result.withdrawAmount)}</i></strong>
                            <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${soulFn:formatInteger(command.result.withdrawAmount)}${soulFn:formatDecimals(command.result.withdrawAmount)}" name="copy"><i class="fa fa-copy"></i></a>
                            <span class="co-orange">${views.fund['拒绝']}</span>
                            <span class="co-gray9 m-l-md">${views.fund['已成功取款']}<span class="co-yellow">${not empty command.result.withdrawCount?command.result.withdrawCount:'0'}</span>${views.fund_auto['次']}</span>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${command.result.transactionStatus!='1'}">
                    <c:if test="${command.result.transactionStatus=='3'||command.result.transactionStatus=='4'}">
                        <tr>
                            <th scope="row" class="text-right" style="vertical-align: top;">${views.fund['失败原因：']}</th>
                            <td>
                                ${command.result.reasonContent}
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <th scope="row" class="text-right" style="vertical-align: top;">${views.fund['审核时间：']}</th>
                        <td>
                                ${soulFn:formatDateTz(command.result.auditTime, DateFormat.DAY_SECOND,timeZone)} - <span class="co-grayc2">${command.result.timeMemo}</span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" class="text-right" style="vertical-align: top;">${views.fund['审核人：']}</th>
                        <td>
                            ${command.result.auditname}
                        </td>
                    </tr>
                </c:if>
                <tr>
                    <th scope="row" class="text-right" style="vertical-align: top;">${views.fund['备注：']}</th>
                    <td>
                        <textarea class="form-control width-response" rows="4" name="remarkContent" maxlength="200"
                        ${command.result.transactionStatus!='1'?'readonly':''}>${command.result.auditRemark}</textarea>
                        <input type="hidden" name="auditRemark" id="auditRemark" value="${command.result.auditRemark}">
                        <div class="btn-groups p-t-xs width-response">
                            <soul:button target="editRemark" opType="function" cssClass="btn btn-link co-blue edit-btn-css" text="${views.common['edit']}">
                                <span class="fa fa-edit"></span> ${views.common['edit']}
                            </soul:button>
                            <soul:button target="${root}/fund/vAgentWithdrawOrder/saveAuditRemark.html" opType="ajax" callback="afterSaveRemark"
                                         post="getCurrentFormData" cssClass="btn btn-link co-blue save-btn-css hide" text="${views.common['save']}">
                                <span class="fa fa-save"></span> ${views.common['save']}
                            </soul:button>
                            <soul:button target="cancelEdit" opType="function" cssClass="btn btn-link co-blue cancel-btn-css hide" text="${views.common['cancel']}">
                                <span class="fa fa-undo"></span> ${views.common['cancel']}
                            </soul:button>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>
    </form>

</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/fund/agent/AgentAuditView"/>
</html>