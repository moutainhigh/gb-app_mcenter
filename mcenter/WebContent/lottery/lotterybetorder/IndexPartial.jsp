<%@ page import="so.wwb.gamebox.model.master.lottery.po.LotteryBetOrder" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.lottery.vo.LotteryBetOrderListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%@taglib uri="http://soul/tags" prefix="soul" %>

<!--//region your codes 1-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
            <c:set var="poType" value="<%= LotteryBetOrder.class %>"></c:set>
            <thead>
            <tr role="row" class="bg-gray">
                <th style="width: 3%">${views.lottery_auto['序号']}</th>
                <th style="width: 5%">${views.lottery_auto['投注帐号']}</th>
                <th style="width: 7%">${views.lottery_auto['所属彩种']}</th>
                <th style="width: 5%">${views.lottery_auto['注单号']}</th>
                <th style="width: 7%">${views.lottery_auto['彩票期号']}</th>
                <th style="width: 10%">玩法</th>
                <th style="width: 14%">${views.lottery_auto['投注内容']}</th>
                <th style="width: 3%">${views.lottery_auto['倍数']}</th>
                <th style="width: 5%">${views.lottery_auto['奖金模式']}</th>
                <th style="width: 5%">投注</th>
                <th style="width: 5%">返点</th>
                <th style="width: 4%">${views.lottery_auto['赔率|奖金']}</th>
                <th style="width: 4%">${views.lottery_auto['派彩']}</th>
                <th style="width: 8%">${views.lottery_auto['投注时间']}</th>
                <th style="width: 5%">
                    <gb:select name="search.status" cssClass="btn-group chosen-select-no-single" prompt="${views.common['status']}"
                               list="${orderStatus}" value="${command.search.status}" callback="query"/>
                </th>
                <th style="width: 5%">${views.lottery_auto['操作']}</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${empty command.result}">
                <td colspan="16" class="no-content_wrap">
                    <div>
                        <i class="fa fa-exclamation-circle"></i> ${views.common['noResult']}
                    </div>
                </td>
            </c:if>
            <c:set var="allBetAmount" value="${0}"></c:set>
            <c:set var="allPayout" value="${0}"></c:set>
            <c:set var="allRebateAmount" value="${0}"></c:set>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                    <td>${p.username}</td>
                    <td>${dicts.lottery.lottery[p.code]}</td>
                    <td>
                        ${p.id}
                            <c:choose>
                                <c:when test="${p.terminal eq '2'}">
                            <span class="fa fa-mobile mobile" data-content="手机投注" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                            </span>
                                </c:when>
                                <c:otherwise>
                                    <span style="width:8px; display: inline-block"></span>
                                </c:otherwise>
                            </c:choose>&nbsp;
                    </td>
                    <td>${p.expect}</td>
                    <td class="td-width-150" title="${dicts.lottery.lottery_betting[p.betCode]}-${dicts.lottery.lottery_play[p.playCode]}">${dicts.lottery.lottery_betting[p.betCode]}-${dicts.lottery.lottery_play[p.playCode]}</td>
                    <td class="td-width-150" title="${p.betNum}">${p.betNum}</td>
                    <td><c:if test="${empty p.multiple}">1</c:if>
                        <c:if test="${not empty p.multiple}">${p.multiple}</c:if>
                    </td>
                    <td><c:if test="${empty p.bonusModel || p.bonusModel eq 1}">元</c:if>
                        <c:if test="${p.bonusModel eq 10}">角</c:if>
                        <c:if test="${p.bonusModel eq 100}">分</c:if>
                    </td>
                    <td>${p.betAmount}</td>
                    <td>${p.rebateAmount}</td>
                    <c:if test="${p.status !=3}">
                        <c:set var="allRebateAmount" value="${allRebateAmount+p.rebateAmount}"/>
                        <c:set var="allBetAmount" value="${allBetAmount+p.betAmount}"/>
                        <c:set var="allPayout" value="${allPayout+p.payout}"></c:set>
                    </c:if>
                    <c:choose>
                        <c:when test="${p.playCode eq 'keno_selection_five'}">
                            <c:set var="pOdd" value="中5@${p.odd} 中4@${p.odd2} 中3@${p.odd3}"/>
                        </c:when>
                        <c:when test="${p.playCode eq 'keno_selection_four'}">
                            <c:set var="pOdd" value="中4@${p.odd} 中3@${p.odd2} 中2@${p.odd3}"/>
                        </c:when>
                        <c:when test="${p.playCode eq 'keno_selection_three'}">
                            <c:set var="pOdd" value="中3@${p.odd} 中2@${p.odd2}"/>
                        </c:when>
                        <c:when test="${p.playCode eq 'lhc_three_in_two'}">
                            <c:set var="pOdd" value="中二@${p.odd} 中三@${p.odd2}"/>
                        </c:when>
                        <c:when test="${p.playCode eq 'lhc_two_in_special'}">
                            <c:set var="pOdd" value="中特@${p.odd} 中二@${p.odd2}"/>
                        </c:when>
                        <c:when test="${p.betCode eq 'ssc_sanxing_zhixuan_qszh' || p.betCode eq 'ssc_sanxing_zhixuan_hszh'}">
                            <c:set var="pOdd" value="三星@${p.odd} 二星@${p.odd2} 一星@${p.odd3}"/>
                        </c:when>
                        <c:when test="${p.betCode eq 'ssc_sanxing_zuxuan_qshhzx' || p.betCode eq 'ssc_sanxing_zuxuan_hshhzx'
                                        || p.betCode eq 'ssc_sanxing_zuxuan_qszxhz' || p.betCode eq 'ssc_sanxing_zuxuan_hszxhz'
                                        || p.betCode eq 'ssc_sanxing_zuxuan_qszxbd' || p.betCode eq 'ssc_sanxing_zuxuan_hszxbd'}">
                            <c:set var="pOdd" value="组三@${p.odd} 组六@${p.odd2}"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="pOdd" value="${p.odd}"/>
                        </c:otherwise>
                    </c:choose>
                    <td class="td-width-150" title="${pOdd}">${pOdd}</td>
                    <td>${p.payout}</td>
                    <td>${soulFn:formatDateTz(p.betTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    <td>
                        <c:if test="${p.status=='1'}">
                            <span class="label label-orange">${dicts.lottery.order_status[p.status]}</span>
                        </c:if>
                        <c:if test="${p.status=='2'}">
                            <span class="label label-green">${dicts.lottery.order_status[p.status]}</span>
                        </c:if>
                        <c:if test="${p.status=='3'}">
                            <span class="label label-danger">${dicts.lottery.order_status[p.status]}</span>
                        </c:if>
                        <c:if test="${p.status=='4'}">
                            <span class="label label-danger">${dicts.lottery.order_status[p.status]}</span>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${p.status=='1'}">
                            <soul:button text="${views.lottery_auto['撤单']}" opType="ajax" target="${root}/lotteryBetOrder/revokeOrder.html?search.id=${p.id}"
                                         confirm="${views.lottery_auto['撤单将会返回投注金额,请谨慎操作！']}" callback="query"></soul:button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="p-sm all-statistics">
    <b>小计：  投注</b>&nbsp;&nbsp;<span class="co-red3">${fn:replace(soulFn:formatCurrency(allBetAmount),",","")}</span> 元
    <b class="m-l">返点</b>&nbsp;&nbsp;<span class="co-red3">${fn:replace(soulFn:formatCurrency(allRebateAmount),",","")}</span>元
    <b class="m-l">派彩</b>&nbsp;&nbsp;<span class="co-red3">${fn:replace(soulFn:formatCurrency(allPayout),",","")}</span>元
    <b class="m-l">损益</b>&nbsp;&nbsp;<span class="co-red3">${fn:replace(soulFn:formatCurrency(allBetAmount-allPayout-allRebateAmount),",","")}</span>元
</div>
<soul:pagination cssClass="bdtop3"/>
<!--//endregion your codes 1-->
