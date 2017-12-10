<%--suppress ALL --%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerDepositListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="so.wwb.gamebox.model.master.fund.enums.RechargeStatusEnum" %>
<%@ include file="/include/include.inc.jsp" %>

<c:set var="overTime" value="<%= RechargeStatusEnum.OVER_TIME.getCode() %>" />
<c:set var="success" value="<%= RechargeStatusEnum.ONLINE_SUCCESS.getCode() %>" />
<c:set var="pending" value="<%= RechargeStatusEnum.PENDING_PAY.getCode() %>" />
<input type="hidden" name="search.playerId" value="${command.search.playerId}" />
<input id="todaySales" value="${command.search.todaySales}" hidden>
<div class="table-responsive table-min-h">
    <span id="totalSumSource" hidden>${command.totalSum}</span>
    <span id="todayTotalSource" hidden>${command.todayTotal}</span>
    <table class="table table-striped table-hover dataTable m-b-none" id="editable" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.fund['交易号']}</th>
            <th>${views.column['VPlayerDeposit.username']}</th>
            <th>${views.column['VPlayerDeposit.rankName']}</th>
            <th>${views.fund['创建时间']}</th>
            <th>${views.column['VPlayerDeposit.rechargeAmount']}</th>
            <th class="inline" style="padding-left: 30px;">
                <gb:select name="search.rechargeStatus" value="${command.search.rechargeStatus}" cssClass="btn-group chosen-select-no-single" callback="query"
                           prompt="${views.fund['desposit.index.allStatus']}" list="${command.rechargeStatus}" listKey="key" listValue="${dicts.fund.recharge_status[key]}" />
            </th>
            <th>${views.column['VPlayerDeposit.payName']}</th>
            <th>${views.fund['审核时间']}</th>
            <th>${views.column['VPlayerDeposit.checkUsername']}</th>
            <%--<th>${views.common['operate']}</th>--%>
            <th>${views.fund['备注']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="r" varStatus="status">
            <tr class="tab-detail">
                <td><a href="/fund/deposit/online/view.html?search.id=${r.id}" nav-target="mainFrame" class="co-blue">${r.transactionNo}</a></td>
                <td>
                    <div class="al-cleft">
                        <shiro:hasPermission name="role:player_detail">
                        <a href="/player/playerView.html?search.id=${r.playerId}" nav-target="mainFrame">
                        </shiro:hasPermission>${r.username}<shiro:hasPermission name="role:player_detail"></a></shiro:hasPermission>
                        <c:if test="${r.riskMarker}">
                            <a href="javascript:void(0)" class="ico-lock co-red3" tabindex="0" data-content="${views.fund_auto['危险层级']}" data-placement="right" data-trigger="focus" data-toggle="popover" data-container="body" role="button"><i class="fa fa-warning"></i></a>
                        </c:if>
                    </div>
                </td>
                <td>
                    <a href="/vPlayerRankStatistics/view.html?id=${r.rankId}" nav-target="mainFrame">
                        <span class="label label-info">${r.rankName}</span>
                    </a>
                </td>
                <td>
                    <span data-content="${soulFn:formatDateTz(r.createTime, DateFormat.DAY_SECOND, timeZone)}" data-placement="top" data-trigger="focus" data-toggle="popover"
                      data-container="body" role="button" class="help-popover co-grayc2" tabindex="0">
                            <a name="copy" data-clipboard-text="${soulFn:formatDateTz(r.createTime, DateFormat.DAY_SECOND, timeZone)}">
                                <apan class="co-grayc2">${soulFn:formatTimeMemo(r.createTime, locale)}</apan>
                            </a>
                    </span>
                </td>
                <td class="money">
                    <c:if test="${r.favorableTotalAmount > 0}">
                        <c:set var="poundage"
                               value="${views.fund_auto['优惠金额']}<span class='co-blue'>${siteCurrencySign}${soulFn:formatInteger(r.favorableTotalAmount)}${soulFn:formatDecimals(r.favorableTotalAmount)}</span>"/>
                            <span data-content="${poundage }" data-placement="top" data-trigger="focus"
                                  data-toggle="popover" data-html="true"
                                  data-container="body" role="button" class="help-popover" tabindex="0">
                                <span class="fee blue"></span>
                            </span>
                    </c:if>
                    <c:if test="${empty r.favorableTotalAmount||r.favorableTotalAmount == 0}">
                          <span data-content="${views.fund_auto['无优惠金额']}" data-placement="top" data-trigger="focus"
                                data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                                <span class="fee none"></span>
                            </span>
                    </c:if>
                    <c:if test="${r.counterFee < 0}">
                        <c:set var="poundage"
                               value="${views.fund_auto['手续费']}<span class='co-red'>${siteCurrencySign}${soulFn:formatInteger(r.counterFee)}${soulFn:formatDecimals(r.counterFee)}</span>"/>
                            <span data-content="${poundage }" data-placement="top" data-trigger="focus"
                                  data-toggle="popover" data-html="true"
                                  data-container="body" role="button" class="help-popover" tabindex="0">
                                <span class="fee negative"></span>
                            </span>
                    </c:if>
                    <c:if test="${r.counterFee > 0}">
                        <c:set var="poundage"
                               value="${views.fund_auto['返还手续费']}<span class='co-green'>${siteCurrencySign}+${soulFn:formatInteger(r.counterFee)}${soulFn:formatDecimals(r.counterFee)}</span>"/>
                            <span data-content="${poundage }" data-placement="top" data-trigger="focus"
                                  data-toggle="popover" data-html="true"
                                  data-container="body" role="button" class="help-popover" tabindex="0">
                                <span class="fee positive"></span>
                            </span>
                    </c:if>
                    <c:if test="${empty r.counterFee||r.counterFee == 0}">
                        <span data-content="${views.fund_auto['免手续费']}" data-placement="top" data-trigger="focus"
                              data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                                <span class="fee none"></span>
                            </span>
                    </c:if>
                    <c:if test="${!empty r.bitAmount}">
                        ${dicts.common.currency_symbol[r.payerBank]}<fmt:formatNumber value="${r.bitAmount}" pattern="#.########"/>
                    </c:if>
                    <c:if test="${r.rechargeAmount!=0}">
                        &nbsp; ${siteCurrencySign}${soulFn:formatInteger(r.rechargeAmount)}<i>${soulFn:formatDecimals(r.rechargeAmount)}</i>
                    </c:if>

                </td>
                <td>
                    <a href="/fund/deposit/online/view.html?search.id=${r.id}" nav-target="mainFrame" class="co-blue">
                        <span class="label ${r.statusCss} p-x-md">
                                ${dicts.fund.recharge_status[r.rechargeStatus]}
                        </span>
                    </a>
                    <c:choose>
                        <c:when test="${r.origin eq 'MOBILE'}">
                            <span class="fa fa-mobile mobile" data-content="${views.fund_auto['手机存款']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span style="width:8px; display: inline-block"></span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <a href="/vPayAccount/detail.html?result.id=${r.payAccountId}&search.type=2" nav-target="mainFrame">${r.payName}</a>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${!empty r.checkTime}">
                            <span data-content="${soulFn:formatDateTz(r.checkTime, DateFormat.DAY_SECOND, timeZone)}" data-placement="top" data-trigger="focus" data-toggle="popover"
                                  data-container="body" role="button" class="help-popover co-grayc2" tabindex="0">
                                <a name="copy" data-clipboard-text="${soulFn:formatDateTz(r.checkTime, DateFormat.DAY_SECOND, timeZone)}">
                                    <apan class="co-grayc2">${soulFn:formatTimeMemo(r.checkTime, locale)}</apan>
                                </a>
                            </span>
                        </c:when>
                        <c:otherwise>
                            --
                        </c:otherwise>
                    </c:choose>
                </td>
                <td><c:set var="rs" value="${r.rechargeStatus}" />
                    <c:choose>
                        <c:when test="${overTime eq rs || pending eq rs}">
                            --
                        </c:when>
                        <c:when test="${success eq rs}">
                            <c:choose>
                                <c:when test="${r.checkUserId != null}">
                                    ${r.checkUsername}
                                </c:when>
                                <c:otherwise>
                                    ${views.fund['系统自动']}
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${r.checkUserId != null}">
                                    ${r.checkUsername}
                                </c:when>
                                <c:otherwise>
                                    ${views.fund['系统自动']}
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </td>
                <%--<td>
                    <a href="/fund/deposit/online/view.html?search.id=${r.id}" nav-target="mainFrame" class="co-blue">${views.common['detail']}</a>
                </td>--%>
                <td>
                    <c:if test="${not empty r.ipDeposit}">
                        IP:
                        <span data-content="${gbFn:getIpRegion(r.ipDictCode)}" data-placement="bottom" data-trigger="focus" data-toggle="popover"
                              data-container="body" role="button" class="help-popover" tabindex="0">
                            <span>
                                <a nav-target="mainFrame" href="/report/log/logList.html?search.roleType=player&search.ip=${gbFn:ipv4LongToString(r.ipDeposit)}&keys=search.ip&hasReturn=true">${gbFn:ipv4LongToString(r.ipDeposit)}</a>
                            </span>
                        </span>
                        <br/>
                    </c:if>
                    <c:if test="${not empty r.payUrl}">
                        <span data-content="${views.fund_auto['支付网址']}" data-placement="bottom" data-trigger="focus" data-toggle="popover"
                              data-container="body" role="button" class="help-popover" tabindex="0">
                            <span>
                                ${r.payUrl}
                            </span>
                        </span>
                        <br/>
                    </c:if>
                    <c:choose>
                        <c:when test="${fn:length(r.checkRemark)>20}">
                                    <span data-content="${r.checkRemark}" data-placement="bottom" data-trigger="focus" data-toggle="popover"
                                          data-container="body" role="button" class="help-popover" tabindex="0">
                                        ${fn:substring(r.checkRemark, 0, 20)}...
                                    </span>
                        </c:when>
                        <c:otherwise>
                            ${r.checkRemark}
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
