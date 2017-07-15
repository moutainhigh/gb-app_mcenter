<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.vplayerwithdrawvo"--%>
<%--@elvariable id="userBankcard" type="so.wwb.gamebox.model.master.player.po.UserBankcard"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<form name="withdrawViewForm" action="${root}/fund/withdraw/WithdrawAuditView.html?search.id=${command.result.id}&pageType=detail">
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['资金']}&nbsp;&nbsp;&nbsp;&nbsp;/ </span>
            <span>${views.sysResource['玩家取款审核']}</span>
            <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <shiro:hasPermission name="fund:playerwithdraw_check">
                <a href="/fund/withdraw/withdrawAuditView.html?search.id=${command.result.id}&pageType=detail" nav-target="mainFrame" name="returnView" style="display: none"></a>
            </shiro:hasPermission>
        </div>
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div id="validateRule" style="display: none">${validateRule}</div>
                <input type="hidden" name="transactionNo" value="${command.result.transactionNo}">
                <input type="hidden" name="counterFee" value="${command.result.counterFee}">
                <input type="hidden" name="withdrawStatus" value="${command.result.withdrawStatus}"/>
                <input type="hidden" name="search.id" value="${command.result.id}"/>
                <input type="hidden" name="allFee"/>
                <a href="" nav-target="mainFrame" id="toGameOrder"></a>
                <input type="hidden" value="${command.result.username}" name="username" id="username">
                <div class="panel-heading">
                    <h3 class="co-gray6">
                        <c:choose>
                            <c:when test="${command.result.withdrawStatus=='1' || command.result.withdrawStatus=='2'}">
                                ${views.fund_auto['玩家取款审核']}
                            </c:when>
                            <c:otherwise>${views.fund_auto['玩家取款详细']}</c:otherwise>
                        </c:choose>
                    </h3>
                </div>
                <input type="hidden" name="withdrawStatus" value="${command.result.withdrawStatus}"/>
                <input type="hidden" name="withdrawActualAmount" value="${fn:replace(soulFn:formatCurrency(command.result.withdrawActualAmount),",","")}">
                <div class="panel-body p-sm">
                    <table class="table no-border table-desc-list">
                        <tbody>
                        <tr>
                            <td colspan="2" class="text-right">
                                <%--锁定订单--%>
                                <c:if test="${command.result.withdrawStatus =='1'}">
                                    <div class="pull-left">
                                        <c:choose>
                                            <c:when test="${command.result.isLock!=1}">
                                                <c:if test="${isDataRight}">
                                                    <soul:button target="lockOrder" text="" opType="function" callback="refreshBack" cssClass="lockRefresh btn btn-blueshow m-r-sm">
                                                        <i class="fa fa-lock"></i>${views.fund['withdraw.edit.playerWithdraw.lockOrder']}
                                                    </soul:button>${views.fund_auto['锁定后才可查看完整的收款账号']}
                                                </c:if>
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
                                　<%--交易号--%>
                                <div class="pull-right"> ${views.column["VPlayerWithdraw.transactionNo"]}：<span id="transactionNo">${command.result.transactionNo}</span>
                                    <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" id="transactionNo-copy"
                                       data-clipboard-target="transactionNo" data-clipboard-text="Default clipboard text from attribute" name="copy"><i class="fa fa-copy"></i></a>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">${views.fund['withdraw.edit.playerWithdraw.playerAccount']}：</th>
                            <td>
                                <a class="btn btn-link co-blue" id="showPlayerDetail" href="/player/playerView.html?search.id=${command.result.playerId}" nav-target="mainFrame"> ${command.result.username}</a>
                                <c:if test="${command.result.withdrawStatus =='1'||command.result.withdrawStatus =='2'}">
                                    <soul:button target="${root}/fund/withdraw/detect.html?playerId=${command.result.playerId}" text="${views.fund_auto['检测']}" opType="dialog" cssClass="btn btn-info-hide">
                                        <i class="fa fa-search"></i>${views.fund_auto['检测']}
                                    </soul:button>
                                </c:if>

                                <a href="/fund/withdraw/withdrawList.html?search.userNameEqual=true&search.username=${command.result.username}" nav-target="mainFrame" class="btn btn-info-hide">
                                    ${views.fund_auto['查看所有订单']}
                                </a>


                                <a href="/report/gameTransaction/list.html?isLink=true&search.username=${command.result.username}&searchKey=search.username" nav-target="mainFrame" class="btn btn-info-hide">
                                    ${views.fund_auto['查看投注记录']}
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">${views.fund_auto['所属代理']}：</th>
                            <td>
                                <a href="/userAgent/agent/detail.html?search.id=${command.result.agentId}" nav-target="mainFrame" class="btn btn-link co-blue">${command.result.agentName}</a>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">${views.fund_auto['玩家层级']}：</th>
                            <td>
                                <c:choose>
                                    <c:when test="${command.result.riskMarker}">
                                        <span data-content="${views.fund_auto['危险层级']}" data-placement="right" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                                            <span class="label label-danger">${command.result.rankName}</span>
                                        </span>
                                        <span class="text-danger">${views.fund_auto['危险层级']}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="label label-info">${command.result.rankName}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
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
                                            <td colspan="2" class="warning">
                                                <i class="fa fa-exclamation-circle m-r-xs co-yellow" style="font-size: 1.4em;"></i>
                                                ${fn:replace(fn:replace(fn:replace(views.fund['withdraw.edit.playerWithdraw.playerWithdrawAmount'], "{0}", "<strong class='co-yellow'>".concat(paramValue).concat("</strong>")), "{1}", dicts.common.currency_symbol[command.result.withdrawMonetary]), "{2}",paramValue*rechargeAmount)}
                                                <%--<strong class="co-yellow">${paramValue}</strong>
                                                ${views.fund['withdraw.index.playerWithdraw.multiple']}--%>
                                            </td>
                                        </tr>
                                    </c:if>
                                    <tr>
                                        <th scope="row" class="text-right active" width="33%">${views.fund_auto['真实姓名']}：</th>
                                        <td><span class="co-black" id="realName">${command.result.realName}</span>
                                            <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-target="realName" data-clipboard-text="${command.result.realName}" name="copy"><i class="fa fa-copy"></i></a>
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
                                                <a type="button" class="btn btn-sm btn-info btn-stroke m-l-sm"  data-clipboard-target="depositBank" data-clipboard-text="${bankDeposit}" name="copy"><i class="fa fa-copy"></i></a>
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
                            <td>${soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)}- <span class="co-grayc2">${soulFn:formatTimeMemo(command.result.createTime, locale)}</span></td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">${views.fund_auto['申请取款']}：</th>
                            <td class="money">
                                ${dicts.common.currency_symbol[command.result.withdrawMonetary]} ${soulFn:formatInteger(command.result.withdrawAmount)}<i>${soulFn:formatDecimals(command.result.withdrawAmount)}</i>
                                <%--取款成功次数--%>
                                <c:if test="${empty command.result.successCount || command.result.successCount<1}">
                                    <span class="co-gray9 m-l-md">${views.fund_auto['首次取款']}</span>
                                </c:if>
                                <c:if test="${command.result.successCount>=1}">
                                    <span class="co-gray9 m-l-md">${views.fund_auto['已成功取款']}<span class="co-yellow">${command.result.successCount}</span>${views.fund_auto['次']}</span>
                                </c:if>
                            </td>
                        </tr>
                        <c:if test="${command.result.bitAmount>0}">
                            <tr>
                            <th scope="row" class="text-right">比特币金额：</th>
                            <td class="money">
                                Ƀ<fmt:formatNumber value="${command.result.bitAmount}" pattern="#.########"/>
                            </td>
                            </tr>
                        </c:if>
                        <c:if test="${!empty transactionData['result']}">
                            <tr>
                            <th scope="row" class="text-right">兑换美元金额：</th>
                            <td><fmt:formatNumber value="${transactionData['result'].total}" pattern="#.########"/></td>
                            </tr>
                        </c:if>
                        <c:if test="${!empty transactionData['rate']}">
                            <th scope="row" class="text-right">${command.result.withdrawMonetary}转换USD汇率：</th>
                            <td>${transactionData['rate'].askRate}</td>
                        </c:if>
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
                                    <div>
                                        <div style="float: left">${dicts.common.currency_symbol[command.result.withdrawMonetary]} </div>
                                        <div style="float: left" id="admin-fee-div">${command.result.administrativeFee>0?'-':''}
                                                ${soulFn:formatInteger(command.result.administrativeFee)}<i>${soulFn:formatDecimals(command.result.administrativeFee)}</i>
                                        </div>
                                    </div>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-right">${views.fund_auto['扣除优惠']}：</th>
                            <td class="money negative">
                                <c:if test="${not empty command.result.deductFavorable && command.result.deductFavorable ne 0}">
                                    <div>
                                        <div style="float: left">${dicts.common.currency_symbol[command.result.withdrawMonetary]} </div>
                                        <div style="float: left" id="fav-fee-div">${command.result.deductFavorable>0?'-':''}
                                        ${soulFn:formatInteger(command.result.deductFavorable)}<i>${soulFn:formatDecimals(command.result.deductFavorable)}</i>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${empty command.result.deductFavorable || command.result.deductFavorable eq 0}">--</c:if>
                            </td>
                        </tr>
                        <tr class="warning major">
                            <th scope="row" class="text-right">${views.fund_auto['实际取款']}：</th>
                            <td class="money">
                                <div style="float: left;padding-top: 7px" ><strong>${dicts.common.currency_symbol[command.result.withdrawMonetary]} </strong></div>
                                <div id="actual-amount-div" style="float: left;padding-top: 7px" >
                                    <strong> ${soulFn:formatInteger(command.result.withdrawActualAmount)}</strong><i>${soulFn:formatDecimals(command.result.withdrawActualAmount)}</i>
                                </div>

                                <a class="btn btn-sm btn-info btn-stroke m-l-sm amount-copy-data" type="button" data-clipboard-text="${command.result.withdrawActualAmount}" name="copy"><i class="fa fa-copy"></i></a>
                                <c:if test="${isDataRight}">
                                    <c:choose>
                                        <c:when test="${command.result.withdrawStatus=='1'||command.result.withdrawStatus=='2'}">
                                            <c:set var="isCheck" value="${command.result.lockPersonId==command.thisUserId}"/>
                                            <soul:button precall="myValidateForm" permission="fund:playerwithdraw_check" opType="function" isCheck="${isCheck}" target="withdrawSuccess" cssClass="btn btn-primary p-x-sm m-l-sm ${isCheck?'':'ui-button-disable disabled'}" tag="button" text="" title="${views.fund['withdraw.edit.playerWithdraw.okWithdrawAudit']}">
                                                <span class="fa fa-check"></span> ${views.common['checkPass']}
                                            </soul:button>
                                            <soul:button precall="myValidateForm" permission="fund:playerwithdraw_check" isCheck="${isCheck}"  target="withdrawFailure"  opType="function" cssClass="btn btn-danger p-x-sm m-l-sm  ${isCheck?'':'ui-button-disable disabled'}" title="${views.fund['withdraw.edit.playerWithdraw.checkWithdrawFailReason']}" text="">
                                                <span class="fa fa-close"></span> ${views.common['checkFailure']}
                                            </soul:button>
                                            <soul:button precall="myValidateForm" permission="fund:playerwithdraw_check"  isCheck="${isCheck}" target="withdrawReject" opType="function" cssClass="btn btn-warning p-x-sm m-l-sm ${isCheck?'':'ui-button-disable disabled'}" text=""  title="${views.fund['withdraw.edit.playerWithdraw.checkRefusedWithdrawReason']}">
                                                <span class="fa fa-ban"></span> ${views.common['checkRefuses']}
                                            </soul:button>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="${command.result.withdrawStatus=='4'?'co-green':'co-red'}">【${dicts.fund.withdraw_status[command.result.withdrawStatus]}】</span>
                                            <c:if test="${command.result.checkStatus=='success'&&command.result.remittanceWay eq '2'}">
                                                <soul:button permission="fund:playerwithdraw_check" callback="refreshBack" target="${root}/fund/withdraw/exchange.html?search.id=${command.result.id}" text="兑币" opType="dialog"
                                                             cssClass="btn p-x-sm m-l-sm btn-success-hide" tag="button">
                                                    <i class="fa fa-check"></i>兑币
                                                </soul:button>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>

                                <c:if test="${command.result.origin eq 'MOBILE'}">
                                    <span class="fa fa-mobile mobile" data-content="${views.fund_auto['手机取款']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                                    </span>
                                </c:if>
                            </td>
                        </tr>
                        <c:if test="${!empty command.result.reasonContent}">
                            <tr>
                                <th scope="row" class="text-right" style="vertical-align: top;">${views.fund_auto['失败原因']}：</th>
                                <td style="max-width:400px;">
                                        ${command.result.reasonContent}
                                </td>
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
                            <th scope="row" class="text-right" style="vertical-align: top;" for="remarkContent">${views.fund_auto['备注']}：</th>
                            <td>
                                <textarea  name="remarkContent" id="remarkContent" maxlength="200" class="form-control model-w-response" rows="4" ${command.result.withdrawStatus!='1'?'readonly':''}>${command.result.checkRemark}</textarea>
                                <div class="btn-groups text-left p-t-xs width-response">

                                    <soul:button target="editRemark" opType="function" cssClass="btn btn-link co-blue edit-btn-css ${command.result.withdrawStatus=='1'?'hide':''}" text="${views.common['edit']}">
                                        <span class="fa fa-edit"></span> ${views.common['edit']}
                                    </soul:button>
                                    <soul:button target="${root}/fund/withdraw/saveAuditRemark.html" opType="ajax" callback="afterSaveRemark"
                                                 post="getCurrentFormData" cssClass="btn btn-link co-blue save-btn-css ${command.result.withdrawStatus!='1'?'hide':''}"
                                                 text="${views.common['save']}">
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
                                    <c:if test="${command.result.withdrawStatus=='1'}">
                                        <soul:button target="${root}/fund/withdraw/showAuditList.html?withdraw.id=${comand.result.id}&search.id=${command.result.id}"
                                                     size="open-dialog-1000" title="${views.fund_auto['稽核详细']}" callback="gotoGameOrder"
                                                     cssClass="btn btn-primary-hide p-x-sm m-r-sm " text="" opType="dialog">
                                            <span class="fa fa-flag-checkered"></span> ${views.fund_auto['查看稽核记录']}
                                        </soul:button>
                                    </c:if>
                                    <c:if test="${command.result.withdrawStatus!='1'}">
                                        <soul:button target="${root}/fund/withdraw/showAuditList.html?auditPass=true&withdraw.id=${comand.result.id}&search.id=${command.result.id}"
                                                     size="open-dialog-1000" title="${views.fund_auto['稽核详细']}" callback="gotoGameOrder"
                                                     cssClass="btn btn-primary-hide p-x-sm m-r-sm " text="" opType="dialog">
                                            <span class="fa fa-flag-checkered"></span> ${views.fund_auto['查看稽核记录']}
                                        </soul:button>
                                    </c:if>
                                    <a href="/fund/withdraw/withdrawList.html?search.userNameEqual=true&search.username=${command.result.username}&search.withdrawStatus=5" nav-target="mainFrame" class="btn btn-primary-hide p-x-sm m-r-sm">${views.fund_auto['查看所有失败订单']}</a>
                                    <a href="/fund/withdraw/withdrawList.html?search.userNameEqual=true&search.username=${command.result.username}&search.withdrawStatus=6" nav-target="mainFrame" class="btn btn-primary-hide p-x-sm m-r-sm">${views.fund_auto['查看所有拒绝订单']}</a>
                                    <c:if test="${command.result.status=='1'||command.result.status=='2'}">
                                        <soul:button target="checkNext" text="${views.fund['withdraw.index.next']}" opType="function" cssClass="btn btn-outline btn-filter pull-right"/>
                                    </c:if>
                                    <a nav-target="mainFrame" style="display: none" name="editTmpl" href="/noticeTmpl/tmpIndex.html?lastPage=t"><span></span></a>
                                </div>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <c:if test="${not empty listVo}">
        <table style="display: none;">
            <c:forEach var="s" items="${listVo}" varStatus="vs">
                <tr>
                    <td>
                        <input type="text" name="feeList[${vs.index}].id" value="${s.id}">
                    </td>
                    <td>
                        <c:if test="${not empty s.deductFavorable}">
                            <input type="text" name="feeList[${vs.index}].deductFavorable" value="<fmt:formatNumber value="${s.deductFavorable}" pattern="0.00"/>" class="input input-money m-45 fee-money" style="width: 70px">
                            <input type="hidden" name="feeList[${vs.index}].maxDeductFavorable" value="<fmt:formatNumber value="${s.deductFavorable}" pattern="0.00"/>">
                        </c:if>
                        <c:if test="${not empty s.administrativeFee}">
                            <input type="text" name="feeList[${vs.index}].administrativeFee" value="<fmt:formatNumber value="${s.administrativeFee}" pattern="0.00"/>" class="input input-money m-45 fee-money" style="width: 70px">
                            <input type="hidden" name="feeList[${vs.index}].maxAdministrativeFee" value="<fmt:formatNumber value="${s.administrativeFee}" pattern="0.00"/>">
                        </c:if>
                    </td>
                </tr
            </c:forEach>
        </table>
    </c:if>
</form>
<soul:import res="site/fund/withdraw/WithdrawView"/>
