<%@ page import="so.wwb.gamebox.model.master.fund.enums.TransactionWayEnum" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div>
    <div class="dataTables_wrapper table" role="grid">
        <c:set var="sign" value="${siteCurrencySign}" />
        <div class="panel-body">
            <div class="tab-content">
                <div class="table-responsive">
                    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
                        <thead>
                        <tr>
                            <td class="ft-bold"></td>
                            <td class="ft-bold t-a-c">${views.home_auto['新增玩家']}</td>
                            <td class="ft-bold t-a-c">
                                <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                      data-html="true" data-content="${views.content['annotation.deposit']}">
                                    <i class="fa fa-question-circle"></i>
                                </span>${views.home_auto['新增存款玩家']}
                            </td>
                            <td class="ft-bold t-a-c">
                                <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus"
                                      data-placement="top" data-html="true" data-content="${views.content['annotation.deposit']}" data-original-title="" title="">
                                    <i class="fa fa-question-circle"></i>
                                </span>${views.home_auto['存款总人数']}
                            </td>
                            <td class="ft-bold t-a-r">
                                <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus"
                                      data-placement="top" data-html="true" data-content="${views.home_auto['来自PC端提交的线上支付存款总额']}" data-original-title="" title="">
                                    <i class="fa fa-question-circle"></i>
                                </span>${views.home_auto['线上支付']}
                            </td>
                            <td class="ft-bold t-a-r">
                                <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus"
                                      data-placement="top" data-html="true" data-content="${views.home_auto['来自PC端提交的公司入款存款总额']}" data-original-title="" title="">
                                    <i class="fa fa-question-circle"></i>
                                </span>${views.home_auto['公司入款']}
                            </td>
                            <td class="ft-bold t-a-r">
                                <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus"
                                      data-placement="top" data-html="true" data-content="${views.home_auto['仅']}${views.content['annotation.deposit']}" data-original-title="" title="">
                                    <i class="fa fa-question-circle"></i>
                                </span>${views.home_auto['人工存入']}
                            </td>
                            <%--<td class="ft-bold t-a-r">
                                <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus"
                                      data-placement="top" data-html="true" data-content="${views.home_auto['来自手机提交的所有存款总额']}" data-original-title="" title="">
                                    <i class="fa fa-question-circle"></i>
                                </span>${views.home_auto['手机存款']}
                            </td>--%>
                            <td class="ft-bold t-a-c">${views.home_auto['投注人数']}</td>
                            <td class="ft-bold t-a-c">
                                <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus"
                                      data-placement="top" data-html="true" data-content="${views.home_auto['仅统计已结算注单']}" data-original-title="" title="">
                                    <i class="fa fa-question-circle"></i>
                                </span>${views.home_auto['投注单量']}
                            </td>
                            <td class="ft-bold t-a-r">${views.home_auto['有效投注额（万）']}</td>
                            <td class="ft-bold t-a-r">
                                <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus"
                                      data-placement="top" data-html="true" data-content="${views.home_auto['存取差额存款']}；<br/><span class='ps-color'>PS：${views.home_auto['此处存款总额和取款总额']}</span>" data-original-title="" title="">
                                    <i class="fa fa-question-circle"></i>
                                </span>
                                ${views.home_auto['存取差额']}
                            </td>
                            <td class="ft-bold t-a-r">
                                <span tabindex="0" class=" help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus"
                                      data-placement="top" data-html="true" data-content="${views.home_auto['本站点所有玩家的派彩总和']}" data-original-title="" title="">
                                    <i class="fa fa-question-circle"></i>
                                </span>${views.home_auto['报表损益']}
                            </td>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="r" items="${tables}" varStatus="vs">
                            <tr class="tab-detail">
                                <td class="t-a-c">${r.date}</td>
                                <td class="t-a-c">
                                    <c:set var="player" value="${r.player}" />
                                    <c:choose>
                                        <c:when test="${player == null || player == 0}">
                                            0
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/player/list.html?outer=${10 + vs.count}&search.hasReturn=true" nav-target="mainFrame">${player}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="t-a-c">
                                    <c:set var="deposit" value="${r.deposit}" />
                                    <c:choose>
                                        <c:when test="${deposit == null || deposit == 0}">
                                            0
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/player/list.html?outer=${10 + vs.count}&comp=1&search.hasReturn=true" nav-target="mainFrame">${deposit}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="t-a-c">
                                    <c:set var="depositPlayer" value="${r.depositPlayer}" />
                                    <c:choose>
                                        <c:when test="${depositPlayer == null || depositPlayer == 0}">
                                            0
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/player/list.html?outer=${10+vs.count}&comp=2&search.hasReturn=true" nav-target="mainFrame">${depositPlayer}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="t-a-r money">
                                    <c:set var="online" value="${r.online}" />
                                    <c:choose>
                                        <c:when test="${online == null || online == 0.0}">
                                            ${sign}0
                                        </c:when>
                                        <c:otherwise>
                                            <soul:button target="${root}/report/vPlayerFundsRecordLinkPopup/fundsRecord.html?linkType=byHomeIndex&search.outer=${10 + vs.count}&search.origin=PC&search.transactionWays=online_deposit,wechatpay_scan,alipay_scan,qqwallet_scan,union_pay_scan,bdwallet_san,jdpay_scan,digiccy_scan,easy_pay"
                                                         size="open-dialog-95p" callback="" text="" title="资金记录" opType="dialog">
                                                ${sign}${soulFn:formatInteger(online)}<i>${soulFn:formatDecimals(online)}</i>
                                            </soul:button>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="t-a-r money">
                                    <c:set var="company" value="${r.company}" />
                                    <c:choose>
                                        <c:when test="${company == null || company == 0}">
                                            ${sign}0
                                        </c:when>
                                        <c:otherwise>
                                            <soul:button target="${root}/report/vPlayerFundsRecordLinkPopup/fundsRecord.html?linkType=byHomeIndex&search.outer=${10 + vs.count}&search.origin=PC&search.transactionWays=online_bank,wechatpay_fast,alipay_fast,other_fast,atm_counter,bitcoin_fast,jdwallet_fast,bdwallet_fast,onecodepay_fast,qqwallet_fast,atm_money,atm_recharge"
                                                         size="open-dialog-95p" callback="" text="" title="资金记录" opType="dialog">
                                                ${sign}${soulFn:formatInteger(company)}<i>${soulFn:formatDecimals(company)}</i>
                                            </soul:button>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="t-a-r money">
                                    <c:set var="manualDeposit" value="${r.manualDeposit}" />
                                    <c:choose>
                                        <c:when test="${manualDeposit == null || manualDeposit == 0}">
                                            ${sign}0
                                        </c:when>
                                        <c:otherwise>
                                            <soul:button target="${root}/report/vPlayerFundsRecordLinkPopup/fundsRecord.html?linkType=byHomeIndex&search.outer=${10 + vs.count}&search.manualSaves=manual_deposit"
                                                         size="open-dialog-95p" callback="" text="" title="资金记录" opType="dialog">
                                                ${sign}${soulFn:formatInteger(manualDeposit)}<i>${soulFn:formatDecimals(manualDeposit)}</i>
                                            </soul:button>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <%--<td class="t-a-r money">
                                    <c:set var="mobile" value="${r.mobile}" />
                                    <c:choose>
                                        <c:when test="${mobile == null || mobile == 0}">
                                            ${sign}0
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/report/vPlayerFundsRecord/fundsLog.html?search.hasReturn=true&search.outer=${10 + vs.count}&search.transactionType=deposit&search.origin=2,8,12,16" nav-target="mainFrame">
                                                ${sign}${soulFn:formatInteger(mobile)}<i>${soulFn:formatDecimals(mobile)}</i>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>--%>
                                <td class="t-a-c">
                                    <c:set var="bet" value="${r.bet}" />
                                    <c:choose>
                                        <c:when test="${bet == null || bet == 0}">
                                            0
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/player/list.html?outer=${10 + vs.count}&comp=3&search.hasReturn=true" nav-target="mainFrame">${bet}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="t-a-c">
                                    <c:set var="single" value="${r.single}" />
                                    <c:choose>
                                        <c:when test="${single == null || single == 0.0}">
                                            0
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/report/operate/operateIndex.html?outer=${10 + vs.count}" nav-target="mainFrame">${soulFn:formatNumber(single)}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="t-a-r money">
                                    <c:set var="effeAmount" value="${r.effeAmount}" />
                                    <c:choose>
                                        <c:when test="${effeAmount == null || effeAmount == 0.0}">
                                            0&nbsp;
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="effe" value="${effeAmount / 10000}" />
                                            <a href="/report/operate/operateIndex.html?outer=${10 + vs.count}" nav-target="mainFrame">
                                                <span tabindex="0" class="help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus"
                                                      data-placement="top" data-html="true" data-content="${soulFn:formatInteger(r.effeAmount)}<i>${soulFn:formatDecimals(r.effeAmount)}</i>" data-original-title="" title="">
                                                    ${soulFn:formatInteger(effe)}<i>${soulFn:formatDecimals(effe)}</i>
                                                </span>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="t-a-r money">
                                    <c:set var="profit" value="${r.profit}" />
                                    <c:choose>
                                        <c:when test="${profit == null || profit == 0.0}">
                                            ${sign}0
                                        </c:when>
                                        <c:otherwise>
                                            <soul:button target="${root}/report/vPlayerFundsRecordLinkPopup/fundsRecord.html?linkType=byHomeIndex&search.outer=${10 + vs.count}&search.transactionType=deposit&search.transactionWays=player_withdraw&search.manualSaves=manual_deposit,manual_favorable,manual_rakeback,manual_payout,manual_other&search.manualWithdraws=manual_deposit,manual_favorable,manual_rakeback,manual_payout,manual_other"
                                                         size="open-dialog-95p" callback="" text="" title="资金记录" opType="dialog">
                                                <c:choose>
                                                    <c:when test="${profit gt 0}">
                                                        ${sign}${soulFn:formatInteger(profit)}<i>${soulFn:formatDecimals(profit)}</i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <strong class="co-tomato">${sign}${soulFn:formatInteger(profit)}<i>${soulFn:formatDecimals(profit)}</i></strong>
                                                    </c:otherwise>
                                                </c:choose>
                                            </soul:button>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="t-a-r money">
                                    <c:set var="payout" value="${r.payout}" />
                                    <c:choose>
                                        <c:when test="${payout == null || payout == 0.0}">
                                            ${sign}0
                                        </c:when>
                                        <c:otherwise>
                                            <%--<a href="#" nav-target="mainFrame">--%>
                                                <c:choose>
                                                    <c:when test="${payout > 0}">
                                                        <a href="/report/operate/operateIndex.html?outer=${10 + vs.count}" nav-target="mainFrame">
                                                            ${sign}${soulFn:formatInteger(payout)}<i>${soulFn:formatDecimals(payout)}</i>
                                                        </a>
                                                    </c:when>
                                                    <c:when test="${payout < 0}">
                                                        <a href="/report/operate/operateIndex.html?outer=${10 + vs.count}" nav-target="mainFrame">
                                                            <strong class="co-tomato">${sign}${soulFn:formatInteger(payout)}<i>${soulFn:formatDecimals(payout)}</i></strong>
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        0
                                                    </c:otherwise>
                                                </c:choose>
                                            <%--</a>--%>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty tables}">
                            <c:forEach var="item" items="${listDateDay}">
                                <tr>
                                    <td class="t-a-c">${item}</td>
                                    <td class="t-a-c">--</td>
                                    <td class="t-a-c">--</td>
                                    <td class="t-a-r">--</td>
                                    <td class="t-a-r">--</td>
                                    <td class="t-a-r">--</td>
                                    <td class="t-a-r">--</td>
                                    <td class="t-a-r">--</td>
                                    <td class="t-a-r">--</td>
                                    <td class="t-a-r">--</td>
                                    <td class="t-a-r">--</td>
                                    <td class="t-a-r">--</td>
                                    <td class="t-a-r">--</td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            <c:set var="isLotterySite" value="<%=ParamTool.isLotterySite()%>"/>
            <div class="tab-content m-t-lg">
                <div class="table-responsive">
                    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
                        <thead>
                        <tr>
                            <td class="ft-bold"></td>
                            <c:if test="${!isLotterySite}">
                                <td class="ft-bold t-a-r">${views.home_auto['真人视讯']}<br>${views.home_auto['有效投注额']}</td>
                                <td class="ft-bold t-a-r">${views.home_auto['电子游艺']}<br>${views.home_auto['有效投注额']}</td>
                                <td class="ft-bold t-a-r">${views.home_auto['体育竞技']}<br>${views.home_auto['有效投注额']}</td>
                                <td class="ft-bold t-a-r">${views.home_auto['彩票游戏']}<br>${views.home_auto['有效投注额']}</td>
                            </c:if>
                           <c:if test="${isLotterySite}">
                               <td class="ft-bold t-a-r">${views.home_auto['彩票游戏']}<br>${views.home_auto['有效投注额']}</td>
                           </c:if>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="t" items="${gameTables}" varStatus="vs">
                            <tr class="tab-detail">
                                <td class="t-a-c">${t.key}</td>
                                <c:forEach var="i" items="${t.value}">
                                    <td style="empty-cells: show;" class="t-a-r money">
                                        <span tabindex="0" class="help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="auto right" data-html="true"
                                              data-content='<c:forEach var="a" items="${apiTables}">
                                                                <c:if test="${a.key == i.value.apiTypeId}">
                                                                    <c:forEach var="p" items="${a.value}">
                                                                        <c:if test="${p.key == t.key}">
                                                                            <c:forEach var="d" items="${p.value}">
                                                                                    ${gbFn:getSiteApiName(d.key.toString())}:
                                                                                    <c:set var="effeAmount1" value="${d.value.effeAmount}" />
                                                                                    <c:set var="effe1" value="${effeAmount1 / 10000}" />
                                                                                    <c:choose>
                                                                                        <c:when test="${effeAmount1 == null || effeAmount1 == 0.0}">
                                                                                            0
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            ${soulFn:formatInteger(effe1)}${soulFn:formatDecimals(effe1)}
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                    /
                                                                                    <c:set var="payout1" value="${d.value.payout}" />
                                                                                    <c:choose>
                                                                                        <c:when test="${payout1 == null || payout1 == 0.0}">
                                                                                            <i>${sign}</i>0
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <c:choose>
                                                                                                <c:when test="${payout1 > 0}">
                                                                                                    <i>${sign}</i>${soulFn:formatInteger(payout1)}${soulFn:formatDecimals(payout1)}
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    <strong class="co-tomato"><i>${sign}</i>${soulFn:formatInteger(payout1)}${soulFn:formatDecimals(payout1)}</strong>
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                    <br/>
                                                                            </c:forEach>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </c:if>
                                                            </c:forEach>' data-original-title="" title="">
                                            <!-- 表格显示内容 S -->
                                            <c:set var="effeAmount" value="${i.value.effeAmount}" />
                                            <c:set var="effe" value="${effeAmount / 10000}" />
                                            <c:choose>
                                                <c:when test="${effeAmount == null || effeAmount == 0.0}">
                                                    0
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="/report/operate/operateIndex.html?outer=${10+vs.count}&search.apiTypeId=${i.value.apiTypeId}" nav-target="mainFrame">
                                                        <span tabindex="0" class="help-popover m-r-xs" role="button" data-container="body" data-toggle="popover" data-trigger="focus"
                                                              data-placement="top" data-html="true" data-content="${soulFn:formatInteger(i.value.effeAmount)}${soulFn:formatDecimals(i.value.effeAmount)}" data-original-title="" title="">
                                                            ${soulFn:formatInteger(effe)}<i>${soulFn:formatDecimals(effe)}</i>
                                                        </span>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                            /
                                            <c:set var="payout" value="${i.value.payout}" />
                                            <c:choose>
                                                <c:when test="${payout == null || payout == 0.0}">
                                                    ${sign}0
                                                </c:when>
                                                <c:otherwise>
                                                    <c:choose>
                                                        <c:when test="${payout > 0}">
                                                            <a href="/report/operate/operateIndex.html?outer=${10+vs.count}&search.apiTypeId=${i.value.apiTypeId}" nav-target="mainFrame">
                                                            ${sign}${soulFn:formatInteger(payout)}<i>${soulFn:formatDecimals(payout)}</i>
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="/report/operate/operateIndex.html?outer=${10+vs.count}&search.apiTypeId=${i.value.apiTypeId}" nav-target="mainFrame">
                                                            <strong class="co-tomato">${sign}${soulFn:formatInteger(payout)}<i>${soulFn:formatDecimals(payout)}</i></strong>
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:otherwise>
                                            </c:choose>
                                            <!-- 表格显示内容 E -->
                                        </span>
                                    </td>
                                </c:forEach>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>