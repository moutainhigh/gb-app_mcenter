<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.RemarkListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form  action="${root}/fund/vAgentWithdrawOrder/agentDetail.html?search.id=${vo.result.id}" method="POST">
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['资金']}</span>
            <span>/</span><span>${views.sysResource['代理取款审核']}</span>
            <soul:button  target="goToLastPage" refresh="" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn"
                         text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="/fund/vAgentWithdrawOrder/showAgentAuditDetail.html?search.id=${vo.result.id}" nav-target="mainFrame" name="returnView" style="display: none"></a>
            <a href="/fund/vAgentWithdrawOrder/agentList.html" name="gotoList" nav-target="mainFrame" style="display: none"></a>
            <input type="hidden" name="result.id" value="${vo.result.id}"/>
            <input type="hidden" name="search.id" value="${vo.result.id}"/>
            <input type="hidden" name="result.agentId" value="${vo.result.agentId}"/>
            <input type="hidden" name="nextRecordId" value="${commandNextId.result.id}">
            <input type="hidden" name="transactionStatus" value="${vo.result.transactionStatus}"/>
            <gb:token></gb:token>
        </div>
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="co-gray6">${views.fund['代理取款详细']}</h3>
                </div>
                <div class="panel-body p-sm">
                    <table class="table no-border table-desc-list">
                        <tbody>
                        <c:if test="${vo.result.transactionStatus=='1'}">
                            <c:choose>
                                <c:when test="${vo.result.isLock==null}">
                                    <tr>
                                        <td colspan="2">
                                            <div class="pull-left">
                                                <soul:button target="lockOrder" text="${views.fund['withdraw.edit.playerWithdraw.lockOrder']}" opType="function"
                                                        cssClass="btn btn-blueshow m-r-sm">
                                                    <i class="fa fa-lock"></i>${views.fund['withdraw.edit.playerWithdraw.lockOrder']}
                                                </soul:button>
                                                    ${views.fund['锁定后才可查看完整的收款账号']}
                                            </div>
                                            <div class="pull-right">
                                                    ${views.fund['交易号：']}${vo.result.transactionNo}
                                                <a name="copy" data-clipboard-placement="left" data-clipboard-text="${vo.result.transactionNo}" id="transactionNo-copy"
                                                   class="btn btn-sm btn-info btn-stroke m-l-sm" ><li class="fa fa-copy" ></li></a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${vo.result.isLock eq 1}">
                                        <c:if test="${vo.result.lockPersonId == vo.thisUserId || vo.userType eq '2'}">
                                            <tr>
                                                <td colspan="2">
                                                    <div class="pull-left">
                                                        <soul:button target="${root}/fund/vAgentWithdrawOrder/cancelLockOrder.html?search.id=${vo.result.id}"
                                                                text="${views.fund['withdraw.edit.playerWithdraw.cancelLockOrder']}" opType="ajax" dataType="json"
                                                                cssClass="btn btn-primary-hide m-r-sm ${vo.result.transactionStatus!='1'?'ui-button-disable disabled':''}"
                                                                post="getCurrentFormData" callback="reloadDetailPage">
                                                            <i class="fa fa-unlock"></i>&nbsp;${views.fund['withdraw.edit.playerWithdraw.cancelLockOrder']}
                                                        </soul:button>
                                                            ${views.fund['锁定人：']}${vo.result.lockPersonName}
                                                    </div>
                                                    <div class="pull-right">
                                                            ${views.fund['交易号：']}${vo.result.transactionNo}
                                                        <a name="copy" data-clipboard-placement="left" data-clipboard-text="${vo.result.transactionNo}" id="transactionNo-copy"
                                                           class="btn btn-sm btn-info btn-stroke m-l-sm" ><li class="fa fa-copy" ></li></a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${vo.result.lockPersonId != vo.thisUserId && vo.userType eq '21'}">
                                            <tr>
                                                <td colspan="2">
                                                    <div class="pull-left">
                                                        <a href="javascript:void(0)" class="btn btn-primary-hide m-r-sm ui-button-disable disabled"><i class="fa fa-unlock"></i>&nbsp;${views.fund['withdraw.edit.playerWithdraw.cancelLockOrder']}</a>
                                                            ${views.fund['锁定人：']}${vo.result.lockPersonName}
                                                    </div>
                                                    <div class="pull-right">
                                                            ${views.fund['交易号：']}${vo.result.transactionNo}
                                                        <a name="copy" data-clipboard-placement="left" data-clipboard-text="${vo.result.transactionNo}" id="transactionNo-copy"
                                                           class="btn btn-sm btn-info btn-stroke m-l-sm" ><li class="fa fa-copy" ></li></a>
                                                    </div>
                                                </td>
                                            </tr>

                                        </c:if>
                                        <c:if test="${vo.result.lockPersonId != vo.thisUserId}">

                                        </c:if>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        <c:if test="${vo.result.transactionStatus!='1'}">
                            <tr>
                                <td colspan="2">
                                    <div class="pull-right">
                                            ${views.fund['交易号：']}${vo.result.transactionNo}
                                        <a name="copy" data-clipboard-text="${vo.result.transactionNo}" id="transactionNo-copy"
                                           class="btn btn-sm btn-info btn-stroke m-l-sm" ><li class="fa fa-copy" ></li></a>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                        <tr>
                            <th scope="row" class="text-right">${views.fund['代理账号：']}</th>
                            <td>
                                <%--<a class="co-blue" href="/userAgent/agent/detail.html?search.id=${vo.result.agentId}" nav-Target="mainFrame">
                                    ${vo.result.username}
                                </a>--%>${vo.result.username}
                                    <a href="/fund/vAgentWithdrawOrder/agentList.html?search.username=${vo.result.username}&search.userNameEqual=true" nav-target="mainFrame"
                                       class="p-x-lg co-blue">${views.fund['查看所有订单']}</a>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">${views.fund['上层总代：']}</th>
                            <td>
                                <a class="co-blue" href="/userAgent/topagent/detail.html?search.id=${topAgentVo.result.id}" nav-Target="mainFrame">
                                    ${topAgentVo.result.username}
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right vtop">${views.fund['代理收款账号：']}</th>
                            <td>
                                <table class="table table-bordered width-response">
                                    <tbody>
                                    <tr>
                                        <th scope="row" class="text-right active" width="120">${views.fund['真实姓名：']}</th>
                                        <td>${vo.result.agentRealname}
                                            <a name="copy" data-clipboard-text="${vo.result.agentRealname}"
                                               class="btn btn-sm btn-info btn-stroke m-l-sm"><li class="fa fa-copy" ></li></a>
                                            <%--<a type="button" class="btn btn-sm btn-info btn-stroke m-l-sm"><i class="fa fa-copy" ></i></a></td>--%>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="text-right active">${views.fund['银行：']}</th>
                                        <td>${dicts.common.bankname[vo.result.agentBank]}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="text-right active">${views.fund['开户行：']}</th>
                                        <td>
                                            <c:if test="${not empty userBankcardVo.result && not empty userBankcardVo.result.bankDeposit}">
                                                ${userBankcardVo.result.bankDeposit}
                                                <a name="copy" data-clipboard-text="${userBankcardVo.result.bankDeposit}"
                                                   class="btn btn-sm btn-info btn-stroke m-l-sm"><li class="fa fa-copy" ></li></a>
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="text-right active">${views.fund['银行账号：']}</th>
                                        <td>
                                            <c:if test="${vo.result.isLock!='1'}">
                                                ${soulFn:overlayString(vo.result.agentBankcard)}
                                            </c:if>
                                            <c:if test="${vo.result.isLock=='1'}">
                                                <c:if test="${vo.result.lockPersonId == vo.thisUserId}">
                                                    ${soulFn:formatBankCard(vo.result.agentBankcard)}
                                                    <a name="copy" data-clipboard-text="${vo.result.agentBankcard}"
                                                       class="btn btn-sm btn-info btn-stroke m-l-sm"><li class="fa fa-copy" ></li></a>
                                                    <c:if test="${userBankcardVo.result.useCount=='0'}">
                                                        【${views.fund['withdraw.edit.playerWithdraw.firstUse']}】
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${vo.result.lockPersonId != vo.thisUserId}">
                                                    ${soulFn:overlayString(vo.result.agentBankcard)}
                                                </c:if>

                                            </c:if>

                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">${views.fund['创建时间：']}</th>
                            <td>${soulFn:formatDateTz(vo.result.createTime, DateFormat.DAY_SECOND,timeZone)} - <span class="co-grayc2">${vo.result.createTimeMemo}</span></td>
                        </tr>
                        <c:if test="${vo.result.transactionStatus=='1'}">
                            <tr class="warning">
                                <th scope="row" class="text-right">${views.fund['取款金额：']}</th>
                                <td class="money">
                                    <strong>${dicts.common.currency_symbol[vo.result.currency]} ${soulFn:formatInteger(vo.result.withdrawAmount)}<i>${soulFn:formatDecimals(vo.result.withdrawAmount)}</i></strong>
                                    <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${soulFn:formatInteger(vo.result.withdrawAmount)}${soulFn:formatDecimals(vo.result.withdrawAmount)}" name="copy"><i class="fa fa-copy"></i></a>
                                    <shiro:hasPermission name="fund:agentwithdraw_check">
                                    <c:choose>
                                        <c:when test="${vo.result.isLock == 1}">
                                            <c:if test="${vo.result.lockPersonId == vo.thisUserId}">
                                                <soul:button permission="fund:agentwithdraw_check" target="${root}/fund/vAgentWithdrawOrder/putConfirmCheck.html?search.id=${vo.result.id}" opType="dialog"
                                                             cssClass="btn btn-primary p-x-sm m-l-sm" precall="isAudit" callback="showNextRecord"
                                                             tag="button" text="${views.fund['withdraw.edit.playerWithdraw.okWithdrawAudit']}">
                                                    ${views.common['checkPass']}
                                                </soul:button>
                                                <soul:button permission="fund:agentwithdraw_check" target="${root}/fund/vAgentWithdrawOrder/putCheckFailure.html?search.id=${vo.result.id}" opType="dialog"
                                                             cssClass="btn btn-danger p-x-sm m-l-sm" precall="showErrorReason" post="getCurrentFormData"
                                                             text="${views.common['checkFailure']}" title="${views.fund['withdraw.edit.playerWithdraw.checkWithdrawFailReason']}"
                                                             callback="showNextRecord"/>
                                                <soul:button permission="fund:agentwithdraw_check" target="${root}/fund/vAgentWithdrawOrder/putConfirmRefuses.html?search.id=${vo.result.id}" opType="dialog"
                                                             cssClass="btn btn-warning p-x-sm m-l-sm " precall="showRefuseReason"
                                                             text="${views.common['checkRefuses']}" title="${views.fund['withdraw.edit.playerWithdraw.checkRefusedWithdrawReason']}" callback="showNextRecord"/>
                                            </c:if>
                                            <c:if test="${vo.result.lockPersonId != vo.thisUserId}">
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
                                    </shiro:hasPermission>
                                    <span class="co-gray9 m-l-md">${views.fund['已成功取款']}<span class="co-yellow">${not empty vo.result.withdrawCount?vo.result.withdrawCount:'0'}</span>${views.fund_auto['次']}</span>
                                </td>
                            </tr>
                        </c:if>

                        <c:if test="${vo.result.transactionStatus=='2'}">
                            <tr class="success">
                                <th scope="row" class="text-right">${views.fund['实际取款：']}</th>
                                <td class="money">
                                    <strong>${dicts.common.currency_symbol[vo.result.currency]} ${soulFn:formatInteger(vo.result.withdrawAmount)}<i>${soulFn:formatDecimals(vo.result.withdrawAmount)}</i></strong>
                                    <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${soulFn:formatInteger(vo.result.withdrawAmount)}${soulFn:formatDecimals(vo.result.withdrawAmount)}" name="copy"><i class="fa fa-copy"></i></a>
                                    <span class="co-green">${views.fund['[成功]']}</span> <span class="co-gray9 m-l-md">${views.fund['已成功取款']}<span class="co-yellow">${not empty vo.result.withdrawCount?vo.result.withdrawCount:'0'}</span>${views.fund_auto['次']}</span>
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${vo.result.transactionStatus=='3'}">
                            <tr class="danger">
                                <th scope="row" class="text-right">${views.fund['实际取款：']}</th>
                                <td class="money"><strong>${dicts.common.currency_symbol[vo.result.currency]} ${soulFn:formatInteger(vo.result.withdrawAmount)}<i>${soulFn:formatDecimals(vo.result.withdrawAmount)}</i></strong>
                                    <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${soulFn:formatInteger(vo.result.withdrawAmount)}${soulFn:formatDecimals(vo.result.withdrawAmount)}" name="copy"><i class="fa fa-copy"></i></a>
                                    <span class="co-red">${views.fund['失败']}</span> <span class="co-gray9 m-l-md">${views.fund['已成功取款']}<span class="co-yellow">${not empty vo.result.withdrawCount?vo.result.withdrawCount:'0'}</span>${views.fund_auto['次']}</span>
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${vo.result.transactionStatus=='4'}">
                            <tr class="warning">
                                <th scope="row" class="text-right">${views.fund['实际取款：']}</th>
                                <td class="money"><strong>${dicts.common.currency_symbol[vo.result.currency]} ${soulFn:formatInteger(vo.result.withdrawAmount)}<i>${soulFn:formatDecimals(vo.result.withdrawAmount)}</i></strong>
                                    <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${soulFn:formatInteger(vo.result.withdrawAmount)}${soulFn:formatDecimals(vo.result.withdrawAmount)}" name="copy"><i class="fa fa-copy"></i></a>
                                    <span class="co-orange">${views.fund['拒绝']}</span>
                                    <span class="co-gray9 m-l-md">${views.fund['已成功取款']}<span class="co-yellow">${not empty vo.result.withdrawCount?vo.result.withdrawCount:'0'}</span>${views.fund_auto['次']}</span>
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${vo.result.transactionStatus!='1'}">
                            <c:if test="${vo.result.transactionStatus=='3'||vo.result.transactionStatus=='4'}">
                                <tr>
                                    <th scope="row" class="text-right" style="vertical-align: top;">
                                        <c:if test="${vo.result.transactionStatus=='3'}">
                                            ${views.fund['失败原因：']}
                                        </c:if>
                                        <c:if test="${vo.result.transactionStatus=='4'}">
                                            ${views.fund['拒绝原因：']}
                                        </c:if>
                                    </th>
                                    <td>
                                            ${vo.result.reasonContent}
                                    </td>
                                </tr>
                            </c:if>
                            <tr>
                                <th scope="row" class="text-right" style="vertical-align: top;">${views.fund['审核时间：']}</th>
                                <td>
                                        ${soulFn:formatDateTz(vo.result.auditTime, DateFormat.DAY_SECOND,timeZone)} - <span class="co-grayc2">${vo.result.timeMemo}</span>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row" class="text-right" style="vertical-align: top;">${views.fund['审核人：']}</th>
                                <td>
                                        ${vo.result.auditname}
                                </td>
                            </tr>
                        </c:if>
                        <tr>
                            <th scope="row" class="text-right" style="vertical-align: top;">${views.fund['备注：']}</th>
                            <td>
                                <textarea class="form-control width-response" rows="4" name="remarkContent" maxlength="200"
                                ${vo.result.transactionStatus!='1'?'readonly':''}>${vo.result.auditRemark}</textarea>
                                <input type="hidden" name="auditRemark" id="auditRemark" value="${vo.result.auditRemark}">
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
                        <tr class="active">
                            <td colspan="2">
                                <div class="btn-groups text-center">
                                    <a href="/fund/vAgentWithdrawOrder/agentList.html?search.transactionStatus=3&search.username=${vo.result.username}" nav-target="mainFrame"
                                       class="btn btn-primary-hide p-x-lg"><span class="fa fa-close"></span>${views.fund['查看所有失败订单']}</a>
                                    <a href="/fund/vAgentWithdrawOrder/agentList.html?search.transactionStatus=4&search.username=${vo.result.username}" nav-target="mainFrame"
                                       class="btn btn-primary-hide p-x-lg"><span class="fa fa-ban"></span>${views.fund['查看所有拒绝订单']}</a>

                                    <c:if test="${commandNextId.result.id!=null}">
                                        <shiro:hasPermission name="fund:agentwithdraw_check">
                                            <a href="/fund/vAgentWithdrawOrder/showAgentAuditDetail.html?search.id=${commandNextId.result.id}"
                                               nav-target="mainFrame" class="btn btn-primary-hide p-x-lg pull-right commandNextId">${views.fund['despoit.index.next']}</a>
                                        </shiro:hasPermission>
                                    </c:if>
                                    <%--<c:if test="${commandNextId.result==null}">
                                        <a href="/fund/vAgentWithdrawOrder/agentList.html" nav-target="mainFrame" class="btn btn-primary-hide p-x-lg co-blue pull-right commandNextId">${views.fund['withdraw.agent.toList']}</a>
                                    </c:if>--%>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <!-- <footer class="panel-footer">
                </footer> -->
            </div>
        </div>
    </div>
</form>
<soul:import res="site/fund/agent/Agent"/>