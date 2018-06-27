<%@ page import="so.wwb.gamebox.model.master.fund.enums.TransactionWayEnum" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--运营状况-->
<div>
    <div class="operate">
        <div class="sys_tab_wrap clearfix m-b-sm">
            <div class="m-sm">
                <b class="fs16">${views.home_auto['运营状况']}</b>
            </div>
        </div>
        <span id="effective" hidden>
</span>
        <div class="dataTables_wrapper" role="grid">
            <div class="panel-body">
                <div class="tab-content">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info" id="operate">
                            <thead>
                            <tr>
                                <td class="ft-bold" rowspan="2"></td>
                                <td class="ft-bold t-a-c" rowspan="2">${views.home_auto['新增代理/人']}</td>
                                <td class="ft-bold t-a-c" colspan="3" style="text-align: center;">${views.home_auto['新玩家']}</td>
                                <td class="ft-bold t-a-r" rowspan="2">
                                <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                      data-html="true" data-content="${views.content['annotation.deposit']}">
                                    <i class="fa fa-question-circle"></i>
                                </span>${views.home_auto['存款总额']}
                                </td>
                                <td class="ft-bold t-a-r" rowspan="2">
                                <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                      data-html="true" data-content="${views.content['annotation.withdrawal']}">
                                    <i class="fa fa-question-circle"></i>
                                </span>${views.home_auto['取款总额']}
                                </td>
                                <td class="ft-bold t-a-r" rowspan="2">
                                <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                      data-max="" data-html="true" data-content="${views.home_auto['包含返水、优惠、推荐、返手续费、返佣']}<br>${views.home_auto['其中']}：<br>1.${views.home_auto['返水和优惠也包含人工送出的']}；<br>2.${views.home_auto['返水和返佣按实际送出的时间来计算']}。<br>${views.home_auto['例如：7月返水账单，8月才发放，那么数据会被统计在8月份']}">
                                    <i class="fa fa-question-circle"></i>
                                </span>${views.home_auto['支出']}
                                </td>
                                <td class="ft-bold t-a-r" rowspan="2">${views.home_auto['有效投注额（万）']}</td>
                                <td class="ft-bold t-a-r" rowspan="2">
                                    <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                          data-html="true" data-content="${views.home_auto['本站点所有玩家的派彩总和']}">
                                    <i class="fa fa-question-circle"></i>
                                </span>${views.home_auto['报表损益']}</td>
                            </tr>
                            <tr>
                                <td class="ft-bold t-a-c">${views.home_auto['新增玩家']}</td>
                                <td class="ft-bold t-a-c">
                                    <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                          data-html="true" data-content="${views.content['annotation.deposit']}">
                                    <i class="fa fa-question-circle"></i>
                                    </span>${views.home_auto['存款人数']}
                                </td>
                                <td class="ft-bold t-a-r">
                                    <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                          data-html="true" data-content="${views.content['annotation.deposit']}">
                                    <i class="fa fa-question-circle"></i>
                                </span>${views.home_auto['存款金额']}
                                </td>
                            </tr>
                            </thead>
                            <tbody>
                            <c:set var="sign" value="${siteCurrencySign}" />
                            <c:forEach var="r" items="${profiles}" varStatus="vs">
                                <c:set var="v" value="${r.value[0]}"/>
                                <tr class="tab-detail">
                                    <td class="t-a-c">${views.report[r.key]}</td>
                                    <td class="t-a-c">
                                        <c:set var="newAgent" value="${v.newAgent}" />
                                        <c:choose>
                                            <c:when test="${newAgent == 0}">
                                                0
                                            </c:when>
                                            <c:otherwise>
                                                <a href="/vUserAgentManage/list.html?search.hasReturn=true&outer=${vs.count}" nav-target="mainFrame">${newAgent}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="t-a-c">
                                        <c:set var="newPlayer" value="${v.newPlayer}" />
                                        <c:choose>
                                            <c:when test="${newPlayer == 0}">
                                                0
                                            </c:when>
                                            <c:otherwise>
                                                <a href="/player/list.html?outer=${vs.count}&search.hasReturn=true" nav-target="mainFrame">${newPlayer}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="t-a-c">
                                        <c:set var="newDeposit" value="${v.newPlayerDeposit}" />
                                        <c:choose>
                                            <c:when test="${newDeposit == 0}">
                                                0
                                            </c:when>
                                            <c:otherwise>
                                                <a href="/player/list.html?outer=${vs.count}&comp=1&search.hasReturn=true" nav-target="mainFrame">${newDeposit}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="t-a-r money">
                                        <c:set var="depositNew" value="${v.depositNewPlayer}" />
                                        <c:choose>
                                            <c:when test="${depositNew == 0}">
                                                ${sign}0
                                            </c:when>
                                            <c:otherwise>
                                                <soul:button target="${root}/report/vPlayerFundsRecordLinkPopup/fundsRecord.html?linkType=byHomeIndex&search.outer=${vs.count}&search.comp=1&search.transactionWays=online_deposit,online_bank,wechatpay_scan,alipay_scan,qqwallet_scan,atm_counter,easy_pay,atm_money,wechatpay_fast,alipay_fast,bitcoin_fast,other_fast,atm_money,atm_counter,atm_recharge,digiccy_scan,jdwallet_fast,bdwallet_fast,onecodepay_fast,jdpay_scan,bdwallet_san,union_pay_scan,qqwallet_fast&search.manualSaves=manual_deposit"
                                                             size="open-dialog-95p" callback="" text="" title="资金记录" opType="dialog">
                                                    ${sign}${soulFn:formatInteger(depositNew)}<i>${soulFn:formatDecimals(depositNew)}</i>
                                                </soul:button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                        <%--存款总额--%>
                                    <td class="t-a-r money">
                                        <c:set var="deposit" value="${v.depositTotal}" />
                                        <c:choose>
                                            <c:when test="${deposit == 0.0}">
                                                ${sign}0
                                            </c:when>
                                            <c:otherwise>
                                                <soul:button target="${root}/report/vPlayerFundsRecordLinkPopup/fundsRecord.html?linkType=byHomeIndex&search.outer=${vs.count}&search.transactionType=deposit"
                                                             size="open-dialog-95p" callback="" text="" title="资金记录" opType="dialog">
                                                    ${sign}${soulFn:formatInteger(deposit)}<i>${soulFn:formatDecimals(deposit)}</i>
                                                </soul:button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="t-a-r money">
                                        <c:set var="withdraw" value="${v.withdrawalAmount}" />
                                        <c:choose>
                                            <c:when test="${withdraw == 0.0}">
                                                ${sign}0
                                            </c:when>
                                            <c:otherwise>
                                                <soul:button target="${root}/report/vPlayerFundsRecordLinkPopup/fundsRecord.html?linkType=byHomeIndex&search.outer=${vs.count}&search.transactionWays=player_withdraw&search.manualWithdraws=manual_deposit"
                                                             size="open-dialog-95p" callback="" text="" title="资金记录" opType="dialog">
                                                    ${sign}${soulFn:formatInteger(withdraw)}<i>${soulFn:formatDecimals(withdraw)}</i>
                                                </soul:button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="t-a-r money">
                                        <c:if test="${vs.index<2}">
                                            <c:set var="rakeback" value="${fn:replace(views.home_auto['返水人'],'[0]' ,v.rakebackPlayer )}、<i>${sign}</i>${soulFn:formatInteger(v.rakebackAmount)}${soulFn:formatDecimals(v.rakebackAmount)}" />
                                            <c:set var="rebate" value="${fn:replace(views.home_auto['返佣人'],'[0]' ,v.rebatePlayer )}、<i>${sign}</i>${soulFn:formatInteger(v.rebateAmount)}${soulFn:formatDecimals(v.rebateAmount)}" />
                                            <c:set var="favorable" value="${fn:replace(views.home_auto['优惠人'],'[0]' ,v.favorablePlayer )}、<i>${sign}</i>${soulFn:formatInteger(v.favorableAmount)}${soulFn:formatDecimals(v.favorableAmount)}" />

                                            <c:set var="recommendAmount" value="、<i>${sign}</i>${soulFn:formatInteger(v.recommendAmount)}${soulFn:formatDecimals(v.recommendAmount)}" />
                                            <c:set var="recommend" value="${fn:replace(views.home_auto['推荐人'],'[0]' ,v.recommendPlayer )}${recommendAmount}" />
                                            <c:set var="refund" value="${fn:replace(views.home_auto['返手续费人'],'[0]' ,v.refundPlayer )}、<i>${sign}</i>${soulFn:formatInteger(v.refundAmount)}${soulFn:formatDecimals(v.refundAmount)}" />
                                        </c:if>
                                        <c:if test="${vs.index>=2}">
                                            <c:set var="rakeback" value="${fn:replace(views.home_auto['返水人次'],'[0]' ,v.rakebackPlayer )}、<i>${sign}</i>${soulFn:formatInteger(v.rakebackAmount)}${soulFn:formatDecimals(v.rakebackAmount)}" />
                                            <c:set var="rebate" value="${fn:replace(views.home_auto['返佣人次'],'[0]' ,v.rebatePlayer )}、<i>${sign}</i>${soulFn:formatInteger(v.rebateAmount)}${soulFn:formatDecimals(v.rebateAmount)}" />
                                            <c:set var="favorable" value="${fn:replace(views.home_auto['优惠人次'],'[0]' ,v.favorablePlayer )}、<i>${sign}</i>${soulFn:formatInteger(v.favorableAmount)}${soulFn:formatDecimals(v.favorableAmount)}" />

                                            <c:set var="recommendAmount" value="、<i>${sign}</i>${soulFn:formatInteger(v.recommendAmount)}${soulFn:formatDecimals(v.recommendAmount)}" />
                                            <c:set var="recommend" value="${fn:replace(views.home_auto['推荐人次'],'[0]' ,v.recommendPlayer )}${recommendAmount}" />
                                            <c:set var="refund" value="${fn:replace(views.home_auto['返手续费人次'],'[0]' ,v.refundPlayer )}、<i>${sign}</i>${soulFn:formatInteger(v.refundAmount)}${soulFn:formatDecimals(v.refundAmount)}" />
                                        </c:if>

                                            <span tabindex="0" class="help-popover m-r-xs" role="button" data-container="body" data-toggle="popover"
                                                  data-trigger="focus" data-original-title="" title="" data-placement="right" data-html="true"
                                                  data-content="${rakeback}<br>${rebate}<br>${favorable}<br>${recommend}<br>${refund}">
                                                ${sign}${soulFn:formatInteger(v.expenditure)}<i>${soulFn:formatDecimals(v.expenditure)}</i>
                                            </span>
                                    </td>
                                    <td class="t-a-r money">
                                        <c:set var="effective" value="${v.effectiveTransactionVolume}" />
                                        <c:choose>
                                            <c:when test="${effective == 0.0}">
                                                0&nbsp;
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="effe" value="${effective / 10000}" />
                                                <c:if test="${vs.index==0}">
                                                    <c:choose>
                                                        <c:when test="${effective lt 0}">
                                                            <strong class="co-tomato">${soulFn:formatInteger(effective)}<i>${soulFn:formatDecimals(effe)}</i></strong>
                                                        </c:when>
                                                        <c:otherwise>
                                                                <span tabindex="0" class="help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus"
                                                                      data-placement="top" data-html="true" data-content="${soulFn:formatInteger(v.effectiveTransactionVolume)}${soulFn:formatDecimals(v.effectiveTransactionVolume)}" data-original-title="" title="">
                                                                    ${soulFn:formatInteger(effe)}<i>${soulFn:formatDecimals(effe)}</i>
                                                                </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>
                                                <c:if test="${vs.index>0}">
                                                    <a href="/report/operate/operateIndex.html?outer=${vs.count}" nav-target="mainFrame">
                                                        <c:choose>
                                                            <c:when test="${effective lt 0}">
                                                                <strong class="co-tomato">${soulFn:formatInteger(effective)}<i>${soulFn:formatDecimals(effe)}</i></strong>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span tabindex="0" class="help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus"
                                                                      data-placement="top" data-html="true" data-content="${soulFn:formatInteger(v.effectiveTransactionVolume)}${soulFn:formatDecimals(v.effectiveTransactionVolume)}" data-original-title="" title="">
                                                                    ${soulFn:formatInteger(effe)}<i>${soulFn:formatDecimals(effe)}</i>
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a>
                                                </c:if>

                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="t-a-r money">
                                        <c:set var="profit" value="${v.transactionProfitLoss}" />
                                        <c:choose>
                                            <c:when test="${profit == 0.0}">
                                                ${sign}0
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${vs.index == 0}">
                                                        <c:choose>
                                                            <c:when test="${profit lt 0}">
                                                                <strong class="co-tomato">${sign}${soulFn:formatInteger(profit)}<i>${soulFn:formatDecimals(profit)}</i></strong>
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${sign}${soulFn:formatInteger(profit)}<i>${soulFn:formatDecimals(profit)}</i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="/report/operate/operateIndex.html?outer=${vs.count}" nav-target="mainFrame">
                                                            <c:choose>
                                                                <c:when test="${profit lt 0}">
                                                                    <strong class="co-tomato">${sign}${soulFn:formatInteger(profit)}<i>${soulFn:formatDecimals(profit)}</i></strong>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${sign}${soulFn:formatInteger(profit)}<i>${soulFn:formatDecimals(profit)}</i>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

