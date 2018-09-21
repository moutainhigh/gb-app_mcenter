<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerWithdrawVo"--%>
<%--@elvariable id="userBankcard" type="so.wwb.gamebox.model.master.player.po.UserBankcard"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<head>
    <title>${views.fund['despoit.check.confirmCheck']}</title>
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
<form name="withdrawAuditViewForm">
    <input type="hidden" id="funds_error" value="${funds_error}"/>
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
                        <%--锁定订单--%>
                    <c:if test="${command.result.withdrawStatus =='1'}">
                        <div class="pull-left">
                            <c:choose>
                                <c:when test="${command.result.isLock!=1}">
                                    <soul:button target="lockOrder" text="" opType="function" callback="refreshBack" cssClass="lockRefresh btn btn-blueshow m-r-sm" permission="fund:playerwithdraw_check">
                                        <i class="fa fa-lock"></i>${views.fund['withdraw.edit.playerWithdraw.lockOrder']}
                                    </soul:button>${views.fund_auto['锁定后才可查看完整的收款账号']}
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${command.result.isLock eq 1}">
                                        <soul:button target="cancelLockOrder" text="" opType="function" dataType="json" cssClass="cancelLockOrder btn btn-primary-hide m-r-sm" post="getCurrentFormData" callback="refreshBack">
                                            <i class="fa fa-unlock"></i>${views.fund['withdraw.edit.playerWithdraw.cancelLockOrder']}
                                        </soul:button>
                                        <i class="cancelPerson">${views.fund['withdraw.edit.playerWithdraw.LockPerson']}：${command.result.lockPersonName}</i>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                    <%--订单号--%>
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
                    ${gbFn:riskImgByName(command.result.username)}

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
                    <c:if test="${command.result.checkStatus == 'pending'}">
                        <soul:button target="${root}/fund/withdraw/detect.html?playerId=${command.result.playerId}" text="${views.fund_auto['检测']}" opType="dialog" cssClass="btn btn-info-hide">
                            <i class="fa fa-search"></i>${views.fund_auto['检测']}
                        </soul:button>
                    </c:if>
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
                        <c:if test="${multiple>=paramValue && paramValue>0}">
                            <%--该玩家本次取款金额已达到上次存款金额的X倍--%>
                            <tr>
                                <td colspan="2" class="warning"><i class="fa fa-exclamation-circle m-r-xs co-yellow" style="font-size: 1.4em;"></i>
                                        ${fn:replace(fn:replace(fn:replace(views.fund['withdraw.edit.playerWithdraw.playerWithdrawAmount'], "{0}", "<strong class='co-yellow'>".concat(paramValue).concat("</strong>")), "{1}", dicts.common.currency_symbol[command.result.withdrawMonetary]), "{2}",paramValue*rechargeAmount)}
                                </td>
                            </tr>
                        </c:if>
                        <tr>
                            <th scope="row" class="text-right active" width="33%">${views.fund_auto['真实姓名']}：</th>
                            <td><span class="co-black" id="realName">${command.result.realName}</span>
                                <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${command.result.realName}" name="copy"><i class="fa fa-copy"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right active">${views.fund_auto['银行']}：</th>
                            <td><span>${dicts.common.bankname[command.result.payeeBank]}</span>
                                <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${dicts.common.bankname[command.result.payeeBank]}" name="copy"><i class="fa fa-copy"></i></a>
                            </td>
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
                <th scope="row" class="text-right">${views.fund['withdraw.edit.playerWithdraw.okWithdrawTime']}：</th>
                <td>
                        ${soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)}-
                    <span class="co-grayc2">${soulFn:formatTimeMemo(command.result.createTime, locale)}</span>
                </td>
            </tr>
            <tr>
                <th scope="row" class="text-right">${views.fund_auto['申请取款']}：</th>
                <td class="money">
                        ${dicts.common.currency_symbol[command.result.withdrawMonetary]}
                        ${soulFn:formatInteger(command.result.withdrawAmount)}<i>${soulFn:formatDecimals(command.result.withdrawAmount)}</i>
                        <%--取款成功次数--%>
                    <c:if test="${empty command.result.successCount||command.result.successCount<1}">
                        <span class="co-gray9 m-l-md">${views.fund_auto['首次取款']}</span>
                    </c:if>
                    <c:if test="${command.result.successCount>0}">
                        <span class="co-gray9 m-l-md">${views.fund_auto['已成功取款']}<span class="co-yellow">${command.result.successCount}</span>${views.fund_auto['次']}</span>
                    </c:if>
                </td>
            </tr>
            <tr>
                <th scope="row" class="text-right">${views.fund_auto['手续费']}：</th>
                <td class="money negative">
                    <c:set var="countFee" value="${soulFn:formatInteger(command.result.counterFee)}<i>${soulFn:formatDecimals(command.result.counterFee)}</i>"></c:set>
                    <c:if test="${empty command.result.counterFee || command.result.counterFee eq 0}">-- </c:if>
                    <c:if test="${not empty command.result.counterFee && command.result.counterFee ne 0}">
                        ${dicts.common.currency_symbol[command.result.withdrawMonetary]} ${command.result.counterFee>0?'-':''}${countFee}
                    </c:if>
                </td>
            </tr>
            <tr>
                <th scope="row" class="text-right">${views.fund_auto['行政费']}：</th>
                <td class="money negative">
                    <c:if test="${empty command.result.administrativeFee || command.result.administrativeFee eq 0}">--</c:if>
                    <c:if test="${not empty command.result.administrativeFee && command.result.administrativeFee ne 0}">
                        ${dicts.common.currency_symbol[command.result.withdrawMonetary]} ${command.result.administrativeFee>0?'-':''}
                        ${soulFn:formatInteger(command.result.administrativeFee)}<i>${soulFn:formatDecimals(command.result.administrativeFee)}</i>
                    </c:if>
                </td>
            </tr>
            <tr>
                <th scope="row" class="text-right">${views.fund_auto['扣除优惠']}：</th>
                <td class="money negative">
                    <c:if test="${not empty command.result.deductFavorable && command.result.deductFavorable ne 0}">
                        ${dicts.common.currency_symbol[command.result.withdrawMonetary]}
                        ${command.result.deductFavorable>0?'-':''}
                        ${soulFn:formatInteger(command.result.deductFavorable)}<i>${soulFn:formatDecimals(command.result.deductFavorable)}</i>
                    </c:if>
                    <c:if test="${empty command.result.deductFavorable || command.result.deductFavorable eq 0}">--</c:if>
                </td>
            </tr>
            <tr class="warning major">
                <th scope="row" class="text-right">${views.fund_auto['实际取款']}：</th>
                <td class="money">
                    <strong> ${dicts.common.currency_symbol[command.result.withdrawMonetary]}${soulFn:formatInteger(command.result.withdrawActualAmount)}</strong>
                    <i>${soulFn:formatDecimals(command.result.withdrawActualAmount)}</i>
                    <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${command.result.withdrawActualAmount}" name="copy"><i class="fa fa-copy"></i></a>
                    <c:choose>
                        <c:when test="${command.result.withdrawStatus=='1'||command.result.withdrawStatus=='2'}">
                            <c:set var="isCheck" value="${command.result.lockPersonId==command.thisUserId}"/>
                            <soul:button permission="fund:playerwithdraw_check" opType="function" isCheck="${isCheck}" target="withdrawSuccess" callback="closePage" cssClass="btn btn-primary p-x-sm m-l-sm ${isCheck?'':'ui-button-disable disabled'}" tag="button" text="" title="${views.fund['withdraw.edit.playerWithdraw.okWithdrawAudit']}">
                                <span class="fa fa-check"></span> ${views.common['checkPass']}
                            </soul:button>
                            <soul:button permission="fund:playerwithdraw_check" isCheck="${isCheck}" callback="closePage" target="withdrawFailure"  opType="function" cssClass="btn btn-danger p-x-sm m-l-sm  ${isCheck?'':'ui-button-disable disabled'}" title="${views.fund['withdraw.edit.playerWithdraw.checkWithdrawFailReason']}" text="">
                                <span class="fa fa-close"></span> ${views.common['checkFailure']}
                            </soul:button>
                            <soul:button permission="fund:playerwithdraw_check"  isCheck="${isCheck}" callback="closePage" target="withdrawReject" opType="function" cssClass="btn btn-warning p-x-sm m-l-sm ${isCheck?'':'ui-button-disable disabled'}" text=""  title="${views.fund['withdraw.edit.playerWithdraw.checkRefusedWithdrawReason']}">
                                <span class="fa fa-ban"></span> ${views.common['checkRefuses']}
                            </soul:button>
                        </c:when>
                        <c:otherwise>
                            <span class="${command.result.withdrawStatus=='4'?'co-green':'co-red'}">
                                【${dicts.fund.withdraw_status[command.result.withdrawStatus]}】
                                 <c:if test="${command.result.checkStatus == 'automatic_pay'}">&nbsp; [已成功打款]</c:if>
                            </span>
                            <c:if test="${command.result.checkStatus=='success'&&command.result.remittanceWay eq '2'}">
                                <soul:button permission="fund:playerwithdraw_exchange" callback="refreshBack" target="${root}/fund/withdraw/exchange.html?search.id=${command.result.id}"  text="${views.fund_auto['兑币']}" opType="dialog"
                                             cssClass="btn p-x-sm m-l-sm btn-success-hide" tag="button">
                                    <i class="fa fa-check"></i>${views.fund_auto['兑币']}
                                </soul:button>
                            </c:if>
                            <c:if test="${command.result.checkStatus=='exchange_bit'&&command.result.remittanceWay eq '2'}">
                                <soul:button permission="fund:playerwithdraw_automaticPay" callback="refreshBack" confirm="${views.fund_auto['确认自动打款']}?" target="${root}/fund/withdraw/automaticPay.html?search.id=${command.result.id}" text="${views.fund_auto['自动打款']}" opType="ajax"
                                             cssClass="btn p-x-sm m-l-sm btn-success-hide" tag="button">
                                    <i class="fa fa-check"></i>${views.fund_auto['自动打款']}
                                </soul:button>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${command.result.origin eq 'MOBILE'}">
                        <span class="fa fa-mobile mobile" data-content="${views.fund_auto['手机取款']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                        </span>
                    </c:if>
                </td>
            </tr>
            <c:if test="${command.result.bitAmount>0}">
                <tr>
                    <th scope="row" class="text-right">${views.fund_auto['比特币金额']}：</th>
                    <td class="money">
                        Ƀ<fmt:formatNumber value="${command.result.bitAmount}" pattern="#.########"/>
                    </td>
                </tr>
            </c:if>
            <c:if test="${!empty transactionData['result']}">
                <tr>
                <th scope="row" class="text-right">${views.fund_auto['兑换美元金额']}：</th>
                <td><fmt:formatNumber value="${transactionData['result'].total}" pattern="#.########"/></td>
                </tr>
            </c:if>
            <c:if test="${!empty transactionData['rate']}">
                <th scope="row" class="text-right">${command.result.withdrawMonetary}转换USD汇率：</th>
                <td>${transactionData['rate'].askRate}</td>
            </c:if>
            <c:if test="${!empty command.result.reasonContent}">
                <tr>
                    <th scope="row" class="text-right" style="vertical-align: top;">${views.fund_auto['失败原因']}：</th>
                    <td style="max-width:400px;">${command.result.reasonContent}</td>
                </tr>
            </c:if>
            <c:if test="${command.result.withdrawStatus=='4'||command.result.withdrawStatus=='5'||command.result.withdrawStatus=='6'}">
                <tr>
                    <th scope="row" class="text-right" style="vertical-align: top;">${views.fund_auto['审核时间']}：</th>
                    <td>
                            ${soulFn:formatDateTz(command.result.checkTime, DateFormat.DAY_SECOND,timeZone)} - <span class="co-grayc2">${command.result.checkTimeMemo}</span>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="text-right" style="vertical-align: top;">${views.fund_auto['审核人']}：</th>
                    <td>${command.result.checkUserName}</td>
                </tr>
            </c:if>
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
    <soul:import res="site/fund/withdraw/WithdrawAuditView"/>

</body>
</html>
