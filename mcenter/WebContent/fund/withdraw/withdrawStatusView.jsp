<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerWithdrawVo"--%>
<%--@elvariable id="userBankcard" type="so.wwb.gamebox.model.master.player.po.UserBankcard"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<style>
    .table-desc-list td {
        height: 40px;
        padding-top: 8px!important;
        padding-bottom: 8px!important;
    }
    .table-desc-list th {
        padding-top: 0px !important;
        padding-bottom: 8px !important;
    }
</style>
<body>
<form name="withdrawStatusViewForm">
    <div class="modal-body clearfix">
        <div id="validateRule" style="display: none">${validateRule}</div>
        <input type="hidden" name="transactionNo" value="${command.result.transactionNo}">
        <input type="hidden" name="counterFee" value="${command.result.counterFee}">
        <input type="hidden" name="search.id" value="${command.result.id}"/>
        <input type="hidden" name="allFee" value="${command.allFee}"/>
        <input type="hidden" name="withdrawStatus" value="${command.result.withdrawStatus}"/>
        <input type="hidden" name="withdrawActualAmount" value="${fn:replace(soulFn:formatCurrency(command.result.withdrawActualAmount),",","")}">
        <input type="hidden" name="playerId" value="${command.result.playerId}">
        <input type="hidden" name="agentId" value="${command.result.agentId}">
        <table class="table no-border table-desc-list">
            <tbody>
            <tr>
                <td colspan="2" class="text-right">
                    <%--交易号--%>
                    <div class="pull-right">
                        ${views.column["VPlayerWithdraw.transactionNo"]}：
                            <span id="transactionNo">${command.result.transactionNo}</span>
                            <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-placement="left" data-clipboard-text="${command.result.transactionNo}" name="copy"><i class="fa fa-copy"></i></a>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="text-right" width="25%">${views.fund['withdraw.edit.playerWithdraw.playerAccount']}：</th>
                <td>
                    <soul:button target="userDetail" text="${command.result.username}" opType="function">${command.result.username}</soul:button>
                    ${gbFn:riskImgByName( command.result.username)}
                    <c:choose>
                        <c:when test="${command.result.riskMarker}">
                            <span style="margin-right:0px 5px" data-content="${views.fund_auto['危险层级']}" data-placement="right" data-trigger="focus" data-toggle="popover"
                                  data-container="body" role="button" class="help-popover" tabindex="0">
                                <span class="label label-danger">${command.result.rankName}</span>
                            </span>
                            <span style="margin:0px 5px" class="text-danger">${views.fund_auto['危险层级']}</span>
                        </c:when>
                        <c:otherwise>
                            <span style="margin:0px 5px" class="label label-info">${command.result.rankName}</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th scope="row" class="text-right">${views.fund_auto['所属代理']}：</th>
                <td><soul:button target="agentDetail" text="${command.result.agentName}" opType="function">${command.result.agentName}</soul:button></td>
            </tr>
            <%--玩家收款账号--%>
            <tr>
                <th scope="row" class="text-right vtop">${views.fund['withdraw.edit.playerWithdraw.playerWithdrawAccount']}：</th>
                <td>
                    <table class="table table-bordered width-response">
                        <tbody>

                        <tr>
                            <th scope="row" class="text-right active" width="33%">${views.fund_auto['真实姓名']}：</th>
                            <td><span class="co-black" id="realName">${command.result.realName}</span>
                                <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${command.result.realName}" name="copy"><i class="fa fa-copy"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right active">${views.fund_auto['银行']}：</th>
                            <td><span>${dicts.common.bankname[command.result.payeeBank]}</span> </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right active">${views.fund_auto['开户行']}：</th>
                            <td>
                                <c:if test="${!empty userBankcard.bankDeposit}">
                                    <span id="depositBank">${userBankcard.bankDeposit}</span>
                                    <a type="button" class="btn btn-sm btn-info btn-stroke m-l-sm" data-clipboard-text="${userBankcard.bankDeposit}" name="copy"><i class="fa fa-copy"></i></a>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right active">${views.fund_auto['银行账户']}：</th>
                            <td>
                                <span class="co-black">
                                    <c:choose>
                                        <%--非审核、和该玩家锁定直接展示银行--%>
                                        <c:when test="${command.result.withdrawStatus!='1'||(command.result.isLock eq 1&&(command.result.lockPersonId == command.thisUserId||command.result.lockPersonId==0))}">
                                            <span id="payeeBankcard">${soulFn:formatBankCard(command.result.payeeBankcard)}</span>
                                            &nbsp;
                                            <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${command.result.payeeBankcard}" name="copy"><i class="fa fa-copy"></i></a>
                                        </c:when>
                                        <c:otherwise>
                                            <span>${soulFn:overlayString(command.result.payeeBankcard)}</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${userBankcard.useCount=='0'}">
                                        【${views.fund['withdraw.edit.playerWithdraw.firstUse']}】
                                    </c:if>
                                </span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <th scope="row" class="text-right">${views.fund_auto['确认出款时间']}：</th>
                <td>
                    ${soulFn:formatDateTz(command.result.withdrawCheckTime, DateFormat.DAY_SECOND,timeZone)}-
                        <span class="co-grayc2">${soulFn:formatTimeMemo(command.result.withdrawCheckTime, locale)}</span>
                </td>
            </tr>
            <tr class="warning major">
                <th scope="row" class="text-right">${views.fund_auto['出款金额']}：</th>
                <td class="money">
                    <strong> ${dicts.common.currency_symbol[command.result.withdrawMonetary]}${soulFn:formatInteger(command.result.withdrawActualAmount)}</strong>
                    <i>${soulFn:formatDecimals(command.result.withdrawActualAmount)}</i>
                    <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${command.result.withdrawActualAmount}" name="copy"><i class="fa fa-copy"></i></a>
                    <span class="${command.result.withdrawStatus=='4'?'co-green':'co-red'}">
                        【${dicts.fund.check_status[command.result.checkStatus]}】
                    </span>
                    <c:if test="${command.result.checkStatus eq 'payment_fail'}">
                        <shiro:hasPermission name="fund:withdraw_payment">
                            <%--<soul:button target="${root}/fund/withdraw/checkWithdrawStatus.html?search.transactionNo=${command.result.transactionNo}" callback="refreshBack" text="${views.fund_auto['重新出款']}" opType="dialog" title="${views.fund_auto['出款查询']}" cssClass="label label-info p-x-md"/>--%>
                            <soul:button target="${root}/fund/withdraw/selectWithdrawAccount.html?search.transactionNo=${command.result.transactionNo}" callback="refreshBack" text="${views.fund_auto['重新出款']}" opType="dialog" title="${views.fund_auto['出款查询']}" cssClass="label label-info p-x-md"/>
                            &nbsp;
                            <soul:button target="${root}/fund/withdraw/setPaymentStatus.html?search.transactionNo=${command.result.transactionNo}&search.checkStatus=payment_success" callback="closePageAndRefresh" confirm="${views.fund_auto['确认将该笔订单手动置为出款成功？']}" cssClass="label label-info p-x-md" text="${views.fund_auto['手动置为成功']}" opType="ajax" />
                        </shiro:hasPermission>
                    </c:if>
                    <c:if test="${command.result.checkStatus eq 'payment_processing'}">
                        <shiro:hasPermission name="fund:withdraw_payment">
                            <soul:button target="${root}/fund/withdraw/setPaymentStatus.html?search.transactionNo=${command.result.transactionNo}&search.checkStatus=payment_fail" callback="closePageAndRefresh" confirm="${views.fund_auto['确认将该笔订单手动置为出款失败？']}" cssClass="label label-info p-x-md" text="${views.fund_auto['手动置为失败']}" opType="ajax" />
                            &nbsp;
                            <soul:button target="${root}/fund/withdraw/setPaymentStatus.html?search.transactionNo=${command.result.transactionNo}&search.checkStatus=payment_success" callback="closePageAndRefresh" confirm="${views.fund_auto['确认将该笔订单手动置为出款成功？']}" cssClass="label label-info p-x-md" text="${views.fund_auto['手动置为成功']}" opType="ajax" />
                        </shiro:hasPermission>
                    </c:if>
                    <c:if test="${command.result.origin eq 'MOBILE'}">
                        <span class="fa fa-mobile mobile" data-content="${views.fund_auto['手机取款']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                        </span>
                    </c:if>
                </td>
            </tr>
            <c:if test="${command.result.checkStatus eq 'payment_fail'}">
                <tr>
                    <th scope="row" class="text-right" style="vertical-align: top;">${views.fund_auto['失败原因']}：</th>
                    <td style="max-width:400px;">${command.result.withdrawFailureReason}</td>
                </tr>
            </c:if>
            <tr>
                <th scope="row" class="text-right" style="vertical-align: top;">${views.fund_auto['出款人']}：</th>
                <td>${command.result.withdrawCheckUsername}</td>
            </tr>

            <tr>
                <th scope="row" class="text-right" style="vertical-align: top;">${views.fund_auto['备注']}：</th>
                <td>
                    <textarea maxlength="200" name="remarkContent" class="form-control width-response" rows="4" ${command.result.withdrawStatus!='1'?'readonly':''}>${command.result.checkRemark}</textarea>
                    <div class="btn-groups text-left p-t-xs width-response">
                        <soul:button target="editRemark" opType="function" cssClass="btn btn-link co-blue edit-btn-css ${command.result.withdrawStatus=='1'?'hide':''}" text="${views.common['edit']}">
                            <span class="fa fa-edit"></span> ${views.common['edit']}
                        </soul:button>
                        <soul:button target="${root}/fund/withdraw/saveAuditRemark.html" opType="ajax" callback="afterSaveRemark" post="getCurrentFormData" cssClass="btn btn-link co-blue save-btn-css ${command.result.withdrawStatus!='1'?'hide':''}" text="${views.common['save']}">
                            <span class="fa fa-save"></span> ${views.common['save']}
                        </soul:button>
                        <soul:button target="cancelEdit" opType="function" cssClass="btn btn-link co-blue cancel-btn-css hide" text="${views.common['cancel']}">
                            <span class="fa fa-undo"></span> ${views.common['cancel']}
                        </soul:button>
                        <input name="checkRemark" value="${command.result.checkRemark}" type="hidden"/>
                    </div>
                </td>
            </tr>

            </tbody>
        </table>
    </div>
</form>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/fund/withdraw/WithdrawStatusView"/>
</body>
</html>
