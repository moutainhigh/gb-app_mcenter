<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<input type="hidden" name="counterFee" value="${withdrawRecord.counterFee}">
<input type="hidden" name="withdrawAmount" value="${withdrawRecord.withdrawAmount}">
<div class="audit-records-list m-sm" style="display: block;">
    <div class="clearfix line-hi34">
        <span class="m-r">
            ${views.fund_auto['此次取款由']} <span class="co-blue">${user.username}</span> ${views.fund_auto['于']}
            <span class="co-grayc2">
                    ${soulFn:formatDateTz(withdrawRecord.createTime, DateFormat.DAY_SECOND,timeZone)}
            </span>${views.fund['所申请']} - ${soulFn:formatTimeMemo(withdrawRecord.createTime, locale)}
        </span>
        <c:if test="${withdrawRecord.withdrawStatus=='1'&&withdrawRecord.isLock=='1'}">
            <c:if test="${withdrawRecord.lockPersonId==currentUser.id}">
                <soul:button cssClass="btn btn-filter pull-right update-audit-btn" withdrawId="${withdrawRecord.id}" opType="function" target="refreshAuditList" text="${views.fund_auto['更新稽核']}"/>
            </c:if>
        </c:if>
    </div>
    <ul class="examine-list-modal">
        <li class="line-hi25">
            <span class="m-r">${fn:replace(views.fund['存款记录共'],"[0]",listVo.size())}，${views.fund['有效投注额共']}<span class="co-red">${soulFn:formatCurrency(totalEffTrade)}</span></span>
        </li>
        <li class="line-hi25">
            <span class="m-r">
                ${views.fund['withdraw.edit.playerWithdraw.despoitAudit']}
                <c:if test="${map.depositFailCount==0||map.depositFailCount==null}"><span>${views.fund['withdraw.edit.playerWithdraw.allPassThrough']}</span></c:if>
                <c:if test="${map.depositFailCount!=0&&map.depositFailCount!=null}">${views.fund['withdraw.edit.playerWithdraw.have']}
                    <span style="padding: 0 3px">${map.depositFailCount}</span>${views.fund['withdraw.edit.playerWithdraw.noPassThrough']}</c:if>
                ,
                    ${views.fund['withdraw.edit.playerWithdraw.needDeductedForAdministrationCost']}<span
                    class="co-red"> ${dicts.common.currency_symbol[user.defaultCurrency]} ${map.depositSum == null?0:soulFn:formatInteger(map.depositSum).concat(soulFn:formatDecimals(map.depositSum))}</span>
            </span>
        </li>
        <li class="line-hi25">
            <span class="m-r">
                ${views.fund['withdraw.edit.playerWithdraw.favourableAudit']}
                <c:if test="${map.favorableFailCount==0||map.favorableFailCount==null}"><span>${views.fund['withdraw.edit.playerWithdraw.allPassThrough']}</span></c:if>
                <c:if test="${map.favorableFailCount!=0&&map.favorableFailCount!=null}">${views.fund['withdraw.edit.playerWithdraw.have']}<span style="padding: 0 3px">${map.favorableFailCount}</span>${views.fund['withdraw.edit.playerWithdraw.noPassThrough']}</c:if>
                ,
                    ${views.fund['withdraw.edit.playerWithdraw.needDeductedFavourable']}
                    <span class="co-red">${dicts.common.currency_symbol[user.defaultCurrency]} ${map.favorableSum==null?0:soulFn:formatInteger(map.favorableSum).concat(soulFn:formatDecimals(map.favorableSum))}</span>
            </span>
        </li>
        <c:if test="${withdrawRecord.withdrawStatus=='1'&&withdrawRecord.isLock=='1'&&not empty listVo&&(map.depositFailCount>0||map.favorableFailCount>0)}">
            <c:if test="${withdrawRecord.lockPersonId==currentUser.id}">
                <soul:button target="showEditField" text="${views.fund['withdraw.index.editAudit']}" opType="function"  cssClass="pull-right-examine show-edit-field"/>
                <soul:button target="hideEditField" text="${views.fund_auto['取消修改']}" opType="function"  cssClass="pull-right-examine hide-edit-field hide"/>
            </c:if>
        </c:if>
            <%--<a href="javascript:void(0)" class="pull-right-examine">${views.fund_auto['修改稽核']}</a>--%>
    </ul>
    <div class="table-responsive m-t-sm tab-border-1">
        <table class="table table-desc-list table-bordered table-hover dataTable m-b-none" aria-describedby="editable_info">
            <thead>
            <tr>
                <th>${views.common['number']}</th>
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
            <c:if test="${withdrawRecord.withdrawStatus=='1'}"><c:set var="depositComleteTime" value="${dateQPicker.now}"></c:set></c:if>
            <c:if test="${withdrawRecord.withdrawStatus!='1'}"><c:set var="depositComleteTime" value="${withdrawRecord.createTime}"></c:set></c:if>
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
                        <c:if test="${s.transactionType!='deposit'}"><li class="co-grayc2">${views.fund['withdraw.edit.playerWithdraw.no']}</li></c:if>
                        <c:if test="${s.transactionType=='deposit'}">
                            <c:if test="${s.transactionMoney eq null}"><li class="co-grayc2">${views.fund['withdraw.edit.playerWithdraw.no']}</li></c:if>
                            <c:if test="${s.transactionMoney != null}">${dicts.common.currency_symbol[user.defaultCurrency]}${soulFn:formatInteger(s.transactionMoney)}${soulFn:formatDecimals(s.transactionMoney)}</c:if>
                        </c:if>
                    </td>
                    <td>${soulFn:formatInteger(s.relaxingQuota)}${soulFn:formatDecimals(s.relaxingQuota)}</td>

                    <td>
                        <c:if test="${s.rechargeAuditPoints eq null}">
                            <li class="co-grayc2">${views.fund['withdraw.edit.playerWithdraw.avoidsAudit']}</li>
                        </c:if>
                        <c:if test="${s.rechargeAuditPoints != null}">
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
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${s.administrativeFee eq null}">
                            <li class="co-grayc2">${views.fund['withdraw.edit.playerWithdraw.no']}</li>
                        </c:if>
                        <c:if test="${s.administrativeFee==0}">
                            <li class="co-green">${views.fund['withdraw.edit.playerWithdraw.passThrough']}</li>
                        </c:if>
                        <c:if test="${s.administrativeFee>0}">
                            <li class="co-red3">
                                    ${dicts.common.currency_symbol[user.defaultCurrency]}
                                -<span class="fee-show-span">${soulFn:formatInteger(s.administrativeFee)}${soulFn:formatDecimals(s.administrativeFee)}</span>
                                <input type="text" name="feeList[${vs.index}].administrativeFee" placeholder="${soulFn:formatCurrency(s.administrativeFee)}" value="<fmt:formatNumber value="${s.administrativeFee}" pattern="0.00"/>" class="hide input input-money m-45 fee-money" style="width: 70px">
                                <input type="hidden" name="feeList[${vs.index}].maxAdministrativeFee" value="<fmt:formatNumber value="${s.administrativeFee}" pattern="0.00"/>">
                            </li>
                        </c:if>
                    </td>

                    <td>
                        <c:if test="${s.transactionType!='deposit'}">
                            <c:if test="${s.transactionMoney eq null}"><li class="co-grayc2">${views.fund['withdraw.edit.playerWithdraw.no']}</li></c:if>
                            <c:if test="${s.transactionMoney != null}">${dicts.common.currency_symbol[user.defaultCurrency]}${soulFn:formatInteger(s.transactionMoney)}${soulFn:formatDecimals(s.transactionMoney)}</c:if>
                        </c:if>
                        <c:if test="${s.transactionType=='deposit'}">
                            <li class="co-grayc2">${views.fund['withdraw.edit.playerWithdraw.no']}</li>
                        </c:if>

                    </td>
                    <td>
                        <c:if test="${s.favorableAuditPoints eq null}"><li class="co-grayc2">${views.fund['withdraw.edit.playerWithdraw.avoidsAudit']}</li></c:if>
                        <c:if test="${s.favorableAuditPoints != null}">

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
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${s.deductFavorable eq null}">
                            <li class="co-grayc2">${views.fund['withdraw.edit.playerWithdraw.no']}</li>
                        </c:if>
                        <c:if test="${s.deductFavorable==0}">
                            <li class="co-green">${views.fund['withdraw.edit.playerWithdraw.passThrough']}</li>
                        </c:if>
                        <c:if test="${s.deductFavorable>0}">
                            <li class="co-red3">
                                    ${dicts.common.currency_symbol[user.defaultCurrency]}
                                -
                                <span class="fee-show-span">${soulFn:formatInteger(s.deductFavorable)}${soulFn:formatDecimals(s.deductFavorable)}</span>
                                <input type="text" name="feeList[${vs.index}].deductFavorable" placeholder="${soulFn:formatCurrency(s.deductFavorable)}" value="<fmt:formatNumber value="${s.deductFavorable}" pattern="0.00"/>" class="hide input input-money m-45 fee-money" style="width: 70px">
                                <input type="hidden" name="feeList[${vs.index}].maxDeductFavorable" value="<fmt:formatNumber value="${s.deductFavorable}" pattern="0.00"/>">
                            </li>
                        </c:if>
                        <c:set var="depositComleteTime" value="${s.completionTime}"></c:set>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>


