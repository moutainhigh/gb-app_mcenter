<%@ page import="org.soul.web.session.SessionManagerBase" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.vplayerwithdrawvo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<head>
    <title>${views.fund['despoit.check.confirmCheck']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <c:set var="locale" value="<%=SessionManagerBase.getLocale()%>" />
    <style type="text/css">
        .show-edit-field{
            padding-right:98px;
        }
        .hide-edit-field{
            padding-right:20px;
        }
    </style>
</head>
<body>
<form:form>
    <div class="modal-body" style="">
        <input type="hidden" name="counterFee" value="${withdrawRecord.counterFee}">
        <input type="hidden" name="search.playerId" value="${command.search.playerId}">
        <input type="hidden" name="withdrawAmount" value="${withdrawRecord.withdrawAmount}">
        <div class="audit-records-list m-sm" style="display: block;">
            <div class="clearfix line-hi34">
                    <span class="m-r fs18 co-gray">${user.username}</span>
            </div>
            <ul class="examine-list-modal">
                <li class="line-hi25">
                    <span class="m-r">${fn:replace(views.fund['存款记录共'],"[0]",listVo.size())}，${views.fund['有效投注额共']} <span class="co-red">${soulFn:formatCurrency(totalEffTrade)}</span></span>
                </li>
                <li class="line-hi25">
                    <span class="m-r">
                        ${views.fund['withdraw.edit.playerWithdraw.despoitAudit']}
                        <c:if test="${map.depositFailCount==0}"><span>${views.fund['withdraw.edit.playerWithdraw.allPassThrough']}</span></c:if>
                        <c:if test="${map.depositFailCount!=0}">${views.fund['withdraw.edit.playerWithdraw.have']}
                            <span style="padding: 0 3px">${map.depositFailCount}</span>${views.fund['withdraw.edit.playerWithdraw.noPassThrough']}</c:if>
                        ,
                            ${views.fund['withdraw.edit.playerWithdraw.needDeductedForAdministrationCost']}<span
                            class="co-red"> ${dicts.common.currency_symbol[user.defaultCurrency]} ${map.depositSum == null?0:soulFn:formatInteger(map.depositSum).concat(soulFn:formatDecimals(map.depositSum))}</span>
                    </span>
                </li>
                <li class="line-hi25">
                    <span class="m-r">
                        ${views.fund['withdraw.edit.playerWithdraw.favourableAudit']}
                        <c:if test="${map.favorableFailCount==0}"><span>${views.fund['withdraw.edit.playerWithdraw.allPassThrough']}</span></c:if>
                        <c:if test="${map.favorableFailCount!=0}">${views.fund['withdraw.edit.playerWithdraw.have']}<span style="padding: 0 3px">${map.favorableFailCount}</span>${views.fund['withdraw.edit.playerWithdraw.noPassThrough']}</c:if>
                        ,
                            ${views.fund['withdraw.edit.playerWithdraw.needDeductedFavourable']}
                            <span class="co-red">${dicts.common.currency_symbol[user.defaultCurrency]} ${map.favorableSum==null?0:soulFn:formatInteger(map.favorableSum).concat(soulFn:formatDecimals(map.favorableSum))}</span>
                    </span>
                </li>
                <c:if test="${fn:length(listVo)>0 && user.status ne '2'}">
                    <soul:button  permission="fund:playerwithdraw_editAudit" target="showEditField" text="${views.fund['withdraw.index.editAudit']}" opType="function"  style="right:80px" cssClass="pull-right-examine edit-field-btn show-edit-field btndist"/>
                    <soul:button  permission="fund:playerwithdraw_editAudit" target="hideEditField" text="${views.player_auto['取消修改']}" opType="function"  cssClass="pull-right-examine cancel-field-btn show-edit-field hide"/>

                    <soul:button permission="fund:playerwithdraw_editAudit" cssClass="pull-right-examine clear-all hide-edit-field " opType="ajax" target="${root}/fund/withdraw/clearAudit.html"
                             post="buildPostData" precall="clearAllAuditPoing" text="${views.player_auto['清除稽核点']}" callback="clearCallback"/>
                    <span id="disable-clear-all" class="pull-right-examine hide-edit-field hide">${views.player_auto['清除稽核点']}</span>
                    <span tabindex="0" class=" help-popover pull-right-examine" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-html="true" data-content="${views.player_auto['将该玩家当前列表所有存款的稽核全部通过，通过后将不会扣除行政费和优惠。']}"><i class="fa fa-question-circle"></i></span>
                </c:if>
            </ul>
            <c:if test="${fn:length(listVo)>0}">
            <div class="table-responsive m-t-sm tab-border-1">
                <table class="table table-desc-list table-bordered table-hover dataTable m-b-none" aria-describedby="editable_info">
                    <thead>
                    <tr>
                        <th>${views.fund['number']}</th>
                        <th>${views.fund['withdraw.edit.playerWithdraw.despoitTime']}</th>
                        <th>${views.fund['withdraw.edit.playerWithdraw.effectiveTransation']}</th>
                        <th>${views.fund['withdraw.edit.playerWithdraw.despoitAmount']}</th>
                        <th>${views.fund['withdraw.edit.playerWithdraw.relaxedAmounts']}</th>

                        <th>${views.fund['withdraw.edit.playerWithdraw.despoitAudit']}</th>
                        <th>${views.fund['withdraw.check.playerWithdraw.forAdministrationCost']}</th>
                        <th>${views.fund['withdraw.edit.playerWithdraw.favourableAmount']}</th>
                        <th>${views.fund['withdraw.edit.playerWithdraw.favourableAudit']}</th>
                        <th>${views.fund['withdraw.edit.playerWithdraw.favourableDeduction']}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="depositComleteTime" value="${dateQPicker.now}"></c:set>
                    <c:forEach items="${listVo}" var="s" varStatus="vs">
                        <tr>
                            <td>${vs.index+1}</td>
                            <td>
                                            ${soulFn:formatDateTz(s.completionTime, DateFormat.DAY_SECOND,timeZone)}
                                <input type="hidden" name="feeList[${vs.index}].id" value="${s.id}" >
                            </td>
                            <td>
                                <c:if test="${not empty s.effectiveTransaction && s.effectiveTransaction>0}">
                                    <soul:button target="toGameOrder" text="${s.effectiveTransaction}" opType="function"
                                                 startTime="${soulFn:formatDateTz(s.completionTime, DateFormat.DAY_SECOND,timeZone)}"
                                                 endTime="${empty depositComleteTime?'':soulFn:formatDateTz(depositComleteTime, DateFormat.DAY_SECOND,timeZone)}">
                                        ${soulFn:formatInteger(s.effectiveTransaction).concat(soulFn:formatDecimals(s.effectiveTransaction))}
                                    </soul:button>

                                </c:if>
                                <c:if test="${empty s.effectiveTransaction || s.effectiveTransaction==0}">
                                    0
                                </c:if>

                            </td>
                            <td>
                                <c:if test="${s.transactionType!='deposit'}">--</c:if>
                                <c:if test="${s.transactionType=='deposit'}">
                                    <c:if test="${s.transactionMoney eq null}"><li class="co-grayc2">${views.fund['withdraw.edit.playerWithdraw.no']}</li></c:if>
                                    <c:if test="${s.transactionMoney != null}">${dicts.common.currency_symbol[user.defaultCurrency]}${soulFn:formatInteger(s.transactionMoney)}${soulFn:formatDecimals(s.transactionMoney)}</c:if>
                                </c:if>
                            </td>
                            <td>${soulFn:formatInteger(s.relaxingQuota)}${soulFn:formatDecimals(s.relaxingQuota)}</td>

                            <td>
                                <c:if test="${s.rechargeAuditPoints eq null}">
                                    <c:if test="${s.transactionType=='deposit'}">
                                        <span class="fee-show-span">--</span>
                                        <input type="text" name="feeList[${vs.index}].rechargeAuditPoints" class="fee-money hide" style="width: 70px"/>
                                    </c:if>
                                    <c:if test="${s.transactionType!='deposit'}">--</c:if>
                                </c:if>
                                <c:if test="${s.rechargeAuditPoints != null}">
                                        <span class="fee-show-span">
                                            <c:if test="${empty s.effectiveTransaction}">
                                                <c:set var="sub" value="${s.remainderEffectiveTransaction+s.relaxingQuota}"></c:set>
                                            </c:if>
                                            <c:if test="${not empty s.effectiveTransaction}">
                                                <c:set var="sub" value="${s.effectiveTransaction+s.remainderEffectiveTransaction+s.relaxingQuota}"></c:set>
                                            </c:if>

                                            <c:set var="parent" value="${s.rechargeAuditPoints<0?0:s.rechargeAuditPoints}"></c:set>
                                            ${soulFn:formatInteger(sub)}${soulFn:formatDecimals(sub)}
                                            /
                                            ${soulFn:formatInteger(parent)}${soulFn:formatDecimals(parent)}
                                        </span>
                                    <c:set var="rap" value="${soulFn:formatInteger(s.rechargeAuditPoints)}${soulFn:formatDecimals(s.rechargeAuditPoints)}"></c:set>
                                        <input type="text" name="feeList[${vs.index}].rechargeAuditPoints" 
                                               placeholder="${soulFn:formatInteger(s.rechargeAuditPoints)}${soulFn:formatDecimals(s.rechargeAuditPoints)}"
                                               value="${rap}" class="hide input input-money m-45 fee-money" style="width: 70px">

                                        <input type="hidden" name="feeList[${vs.index}].maxRechargeAuditPoints"
                                               value="${rap}">

                                </c:if>
                                <c:set var="depositComleteTime" value="${s.completionTime}"></c:set>
                            </td>
                            <td>
                                <c:if test="${s.administrativeFee eq null}">
                                    --
                                </c:if>
                                <c:if test="${s.administrativeFee==0}">
                                    <li class="co-green">${views.fund['withdraw.edit.playerWithdraw.passThrough']}</li>
                                </c:if>
                                <c:if test="${s.administrativeFee>0}">
                                    <li class="co-red3">
                                            ${dicts.common.currency_symbol[user.defaultCurrency]}
                                        -${soulFn:formatInteger(s.administrativeFee)}${soulFn:formatDecimals(s.administrativeFee)}
                                    </li>
                                </c:if>
                            </td>

                            <td>
                                <c:if test="${s.transactionType!='deposit'}">
                                    <c:if test="${s.transactionMoney eq null}"><li class="co-grayc2">${views.fund['withdraw.edit.playerWithdraw.no']}</li></c:if>
                                    <c:if test="${s.transactionMoney != null}">${dicts.common.currency_symbol[user.defaultCurrency]}${soulFn:formatInteger(s.transactionMoney)}${soulFn:formatDecimals(s.transactionMoney)}</c:if>
                                </c:if>
                                <c:if test="${s.transactionType=='deposit'}">
                                    --
                                </c:if>

                            </td>
                            <td>
                                <c:if test="${s.favorableAuditPoints eq null}">--</c:if>
                                <c:if test="${s.favorableAuditPoints != null}">
                                    <span class="fee-show-span">
                                        <c:if test="${empty s.effectiveTransaction}">
                                            <c:set var="sub" value="${s.favorableRemainderEffectiveTransaction}"></c:set>
                                        </c:if>
                                        <c:if test="${not empty s.effectiveTransaction}">
                                            <c:set var="sub" value="${s.effectiveTransaction+s.favorableRemainderEffectiveTransaction}"></c:set>
                                        </c:if>

                                        <c:set var="parent" value="${s.favorableAuditPoints<0?0:s.favorableAuditPoints}"></c:set>
                                        ${soulFn:formatInteger(sub)}${soulFn:formatDecimals(sub)}
                                        /
                                        ${soulFn:formatInteger(parent)}${soulFn:formatDecimals(parent)}
                                    </span>
                                    <c:set var="fap" value="${soulFn:formatInteger(s.favorableAuditPoints)}${soulFn:formatDecimals(s.favorableAuditPoints)}"></c:set>
                                        <input type="text" name="feeList[${vs.index}].favorableAuditPoints" placeholder="${soulFn:formatCurrency(s.favorableAuditPoints)}"
                                               value="${fap}" class="hide input input-money m-45 fee-money" style="width: 70px">
                                        <input type="hidden" name="feeList[${vs.index}].maxFavorableAuditPoints"
                                               value="${fap}">


                                </c:if>
                            </td>
                            <td>
                                <c:if test="${s.deductFavorable eq null}">
                                    --
                                </c:if>
                                <c:if test="${s.deductFavorable==0}">
                                    <li class="co-green">${views.fund['withdraw.edit.playerWithdraw.passThrough']}</li>
                                </c:if>
                                <c:if test="${s.deductFavorable>0}">
                                    <li class="co-red3">
                                        ${dicts.common.currency_symbol[user.defaultCurrency]}
                                        -${soulFn:formatInteger(s.deductFavorable)}${soulFn:formatDecimals(s.deductFavorable)}
                                    </li>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            </c:if>
        </div>

    </div>
    <div class="modal-footer">
        <c:if test="${fn:length(listVo)>0 && user.status ne '2'}">
        <soul:button permission="fund:playerwithdraw_editAudit" cssClass="btn btn-filter btn-edit-audit" opType="ajax" target="${root}/fund/withdraw/clearAudit.html"
             post="buildPostData" precall="myValidateForm" text="${views.common['save']}" callback="clearCallback"/>
        </c:if>
        <soul:button cssClass="btn btn-outline btn-filter" opType="function" target="closePage" text="${views.common['cancel']}"/>
    </div>
</form:form>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/view.include/ImmediateAudit"/>
</body>
</html>
