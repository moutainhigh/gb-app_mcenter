<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerDepositListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="so.wwb.gamebox.model.master.fund.enums.RechargeStatusEnum" %>
<%@ include file="/include/include.inc.jsp" %>

<c:set var="deal" value="<%= RechargeStatusEnum.DEAL.getCode() %>"/>
<c:set var="success" value="<%= RechargeStatusEnum.SUCCESS.getCode() %>"/>
<c:set var="exchange" value="<%= RechargeStatusEnum.EXCHANGE.getCode() %>"/>
<input type="hidden" name="search.playerId" value="${command.search.playerId}" />
<input id="todaySales" value="${command.search.todaySales}" hidden>
<div class="table-responsive table-min-h">
    <span id="totalSumSource" hidden>${command.totalSum}</span>
    <span id="todayTotalSource" hidden>${command.todayTotal}</span>
    <table class="table table-striped table-hover dataTable" id="editable" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.fund['交易号']}</th>
            <th>${views.column['VPlayerDeposit.username']}</th>
            <th>${views.column['VPlayerDeposit.rankName']}</th>
            <th>${views.fund_auto['创建时间']}</th>
            <th class="inline" style="width: 20%">
                <gb:select name="search.rechargeType" value="${command.search.rechargeType}"
                           cssClass="btn-group chosen-select-no-single" callback="query"
                           prompt="${views.fund['desposit.index.allType']}" list="${command.rechargeType}" listKey="key"
                           listValue="${dicts.fund.recharge_type[key]}"/>
            </th>
            <th>${views.column['VPlayerDeposit.bankCode.fullName']}</th>
            <th>${views.column['VPlayerDeposit.rechargeAmount']}</th>
            <th class="inline" style="text-align: center; padding-left: 30px">
                <gb:select name="search.rechargeStatus" value="${command.search.rechargeStatus}"
                           cssClass="btn-group chosen-select-no-single" callback="query"
                           prompt="${views.fund['desposit.index.allStatus']}" list="${command.rechargeStatus}"
                           listKey="key" listValue="${dicts.fund.recharge_status[key]}"/>
            </th>
            <th>${views.column['VPlayerDeposit.checkUsername']}</th>
            <th>${views.column['VPlayerDeposit.checkTime']}</th>
            <%--<th>${views.common['operate']}</th>--%>
            <th>${views.fund['备注']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="r" varStatus="vs">
            <c:set var="rs" value="${r.rechargeStatus}"/>
            <tr class="tab-detail">
                <c:choose>
                    <c:when test="${deal eq rs}">
                        <c:set var="url" value="/fund/deposit/company/check.html?search.id=${r.id}"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="url" value="/fund/deposit/company/view.html?search.id=${r.id}"/>
                    </c:otherwise>
                </c:choose>
                <td>
                    <a href="${url}" nav-target="mainFrame" class="co-blue">${r.transactionNo}</a></td>
                <td>
                    <div class="al-cleft">
                        <shiro:hasPermission name="role:player_detail">
                        <a href="/player/playerView.html?search.id=${r.playerId}" nav-target="mainFrame"
                           title="${r.username}">
                        </shiro:hasPermission>
                        ${r.username}<shiro:hasPermission name="role:player_detail"></a></shiro:hasPermission>
                        <c:if test="${r.riskMarker}">
                            <a href="javascript:void(0)" class="ico-lock co-red3" tabindex="0" data-content="${views.fund_auto['危险层级']}"
                               data-placement="right" data-trigger="focus" data-toggle="popover" data-container="body"
                               role="button"><i class="fa fa-warning"></i></a>
                        </c:if>
                    </div>
                </td>
                <td>
                    <a href="/vPlayerRankStatistics/view.html?id=${r.rankId}" nav-target="mainFrame">
                        <span class="label label-info">${r.rankName}</span>
                    </a>
                </td>
                <td>
                    <span data-content="${soulFn:formatDateTz(r.createTime, DateFormat.DAY_SECOND,timeZone)}"
                          data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                          role="button" class="ico-lock" tabindex="0" data-original-title="" title="">
                        <apan class="co-grayc2">${soulFn:formatTimeMemo(r.createTime, locale)}</apan>
                    </span>
                </td>
                <td style="width: 20%">
                    <a href="${url}" nav-target="mainFrame">
                        <c:set var="rt" value="${r.rechargeType}"/>
                            ${dicts.fund.recharge_type[rt]}
                        <c:if test="${r.isFirstRecharge}">
                            <span class="co-orange">&nbsp;${views.fund['首存']}</span>
                        </c:if>
                        <div class="list-note">
                            <c:if test="${!empty r.payerBankcard}">
                                <c:if test="${rt eq 'wechatpay_fast'}">
                                    <c:set value="${views.fund_auto['微信账号']}" var="data"/>
                                </c:if>
                                <c:if test="${rt eq 'alipay_fast'}">
                                    <c:set value="${views.fund_auto['支付宝账号']}" var="data"/>
                                </c:if>
                                <c:if test="${rt eq 'qqwallet_fast'}">
                                    <c:set value="${views.fund_auto['QQ钱包账号']}" var="data"/>
                                </c:if>
                                <c:if test="${rt eq 'jdwallet_fast'}">
                                    <c:set value="${views.fund_auto['京东钱包账号']}" var="data"/>
                                </c:if>
                                <c:if test="${rt eq 'bdwallet_fast'}">
                                    <c:set value="${views.fund_auto['百度钱包账号']}" var="data"/>
                                </c:if>
                                <c:if test="${rt eq 'onecodepay_fast'}">
                                    <c:set value="${views.fund_auto['一码付账号']}" var="data"/>
                                </c:if>
                                <c:if test="${rt eq 'other_fast'}">
                                    <c:set value="${views.fund_auto['其他电子账号']}" var="data"/>
                                </c:if>
                                <c:if test="${rt eq 'bitcoin_fast'}">
                                    <c:set value="${views.fund_auto['比特币地址']}" var="data"/>
                                </c:if>
                                <span class="co-orange" data-content="${data}" data-placement="bottom"
                                      data-trigger="focus" data-toggle="popover" data-container="body" role="button"
                                      class="help-popover" tabindex="0">${r.payerBankcard}</span>
                            </c:if>
                            <c:if test="${!empty r.bankOrder && rt != 'bitcoin_fast'}">
                                <c:if test="${rt eq 'wechatpay_fast'||rt eq 'alipay_fast'||rt eq 'qqwallet_fast'||rt eq 'jdwallet_fast'
                                ||rt eq 'bdwallet_fast'||rt eq 'onecodepay_fast'||rt eq 'other_fast'}">
                                    <c:set value="${views.fund_auto['订单尾号']}" var="data"/>
                                </c:if>
                                <span data-content="${data}" data-placement="bottom" data-trigger="focus"
                                      data-toggle="popover" data-container="body" role="button" class="help-popover"
                                      tabindex="0"><em>[${r.bankOrder}]</em></span>
                            </c:if>
                            <c:if test="${rt eq 'atm_money'}">
                                <span data-content="${views.fund_auto['交易地点']}" data-placement="bottom" data-trigger="focus"
                                      data-toggle="popover" data-container="body" role="button" class="help-popover"
                                      tabindex="0">${r.rechargeAddress}</span>
                            </c:if>
                            <c:if test="${!empty r.payerName}">
                                <span data-content="${views.fund_auto['存款人姓名']}" data-placement="bottom" data-trigger="focus"
                                      data-toggle="popover" data-container="body" role="button" class="help-popover"
                                      tabindex="0">${r.payerName}</span>
                            </c:if>
                        </div>
                    </a>
                </td>
                <td>
                    <a href="/vPayAccount/detail.html?result.id=${r.payAccountId}&search.type=1" nav-target="mainFrame">
                        <c:choose>
                            <c:when test="${r.customBankName != null && r.customBankName != ''}">
                                ${r.customBankName}-
                            </c:when>
                            <c:otherwise>
                                ${dicts.common.bankname[r.bankCode]}-
                            </c:otherwise>
                        </c:choose>
                            ${r.fullName}
                    </a>
                </td>
                <td class="money">
                    <c:if test="${r.favorableTotalAmount > 0}">
                        <c:set var="poundage"
                               value="${views.fund_auto['优惠金额']}<span class='co-blue'>${sysCurrency[r.defaultCurrency].currencySign}&nbsp;${soulFn:formatInteger(r.favorableTotalAmount)}${soulFn:formatDecimals(r.favorableTotalAmount)}</span>"/>
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
                               value="${views.fund_auto['手续费']}<span class='co-red'>${sysCurrency[r.defaultCurrency].currencySign}&nbsp;${soulFn:formatInteger(r.counterFee)}${soulFn:formatDecimals(r.counterFee)}</span>"/>
                            <span data-content="${poundage }" data-placement="top" data-trigger="focus"
                                  data-toggle="popover" data-html="true"
                                  data-container="body" role="button" class="help-popover" tabindex="0">
                                <span class="fee negative"></span>
                            </span>
                    </c:if>
                    <c:if test="${r.counterFee > 0}">
                        <c:set var="poundage"
                               value="${views.fund_auto['返还手续费']}<span class='co-green'>${sysCurrency[r.defaultCurrency].currencySign}&nbsp;${soulFn:formatInteger(r.counterFee)}${soulFn:formatDecimals(r.counterFee)}</span>"/>
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
                    <c:if test="${r.rechargeAmount!=0}">
                        ${sysCurrency[r.defaultCurrency].currencySign}&nbsp;${soulFn:formatInteger(r.rechargeAmount)}<i>${soulFn:formatDecimals(r.rechargeAmount)}</i>
                    </c:if>
                    <c:if test="${r.bitAmount>0}">
                        &nbsp;
                        <span data-content="${views.fund_auto['比特币']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                            Ƀ<fmt:formatNumber value="${r.bitAmount}" pattern="#.########"/>
                        </span>
                    </c:if>
                </td>
                <td align="center">
                    <c:choose>
                        <c:when test="${deal eq rs}">
                            <shiro:hasPermission name="fund:companydeposit_check">
                            <soul:button permission="fund:companydeposit_check" deposit_id="${r.id}" target="confirmCheckPass" text="${views.fund_auto['通过']}" opType="function"
                                         cssClass="btn btn-sm btn-success-hide m-x-xs" tag="button">
                                <i class="fa fa-check"></i>${views.fund['通过']}
                            </soul:button>
                            <soul:button permission="fund:companydeposit_check" deposit_id="${r.id}" target="checkFailure" text="${views.fund_auto['失败']}" opType="function"
                                         cssClass="btn btn-sm btn-danger-hide m-x-xs" tag="button">
                                <i class="fa fa-close"></i>${views.fund['失败']}
                            </soul:button>
                            </shiro:hasPermission>
                            <shiro:lacksPermission name="fund:companydeposit_check">
                                <a href="/fund/deposit/company/view.html?search.id=${r.id}" nav-target="mainFrame" class="co-blue">
                                <span class="label ${r.statusCss} p-x-md">
                                        ${dicts.fund.recharge_status[r.rechargeStatus]}
                                </span>
                                </a>
                            </shiro:lacksPermission>
                        </c:when>
                        <c:when test="${exchange eq rs}">
                            <!--permission="fund:companydeposit_exchange" -->
                            <soul:button  target="${root}/fund/deposit/company/exchange.html?search.id=${r.id}" text="${views.fund_auto['兑换']}" opType="dialog"
                                         cssClass="btn btn-sm btn-success-hide m-x-xs" tag="button" callback="callBackQuery">
                                <i class="fa fa-check"></i>${views.fund_auto['兑现']}
                            </soul:button>
                            <soul:button permission="fund:companydeposit_check" deposit_id="${r.id}" target="checkFailure" text="${views.fund_auto['失败']}" opType="function"
                                         cssClass="btn btn-sm btn-danger-hide m-x-xs" tag="button">
                                <i class="fa fa-close"></i>${views.fund['失败']}
                            </soul:button>
                        </c:when>
                        <c:otherwise>
                            <a href="${url}" nav-target="mainFrame">
                                <span class="label ${r.statusCss} p-x-md">${dicts.fund.recharge_status[r.rechargeStatus]}</span>
                            </a>
                        </c:otherwise>
                    </c:choose>
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
                    <c:choose>
                        <c:when test="${deal eq rs}">
                            --
                        </c:when>
                        <c:otherwise>
                            ${r.checkUsername}
                        </c:otherwise>
                    </c:choose>
                </td>
                <td colspan="co-grayc2">
                    <c:choose>
                        <c:when test="${deal eq rs}">
                            --
                        </c:when>
                        <c:otherwise>
                            <span data-content="${soulFn:formatDateTz(r.checkTime, DateFormat.DAY_SECOND, timeZone)}"
                                  data-placement="top" data-trigger="focus" data-toggle="popover"
                                  data-container="body" role="button" class="help-popover co-grayc2" tabindex="0">
                                <a name="copy"
                                   data-clipboard-text="${soulFn:formatDateTz(r.checkTime, DateFormat.DAY_SECOND, timeZone)}">
                                    <apan class="co-grayc2">${soulFn:formatTimeMemo(r.checkTime, locale)}</apan>
                                </a>
                            </span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <%--<td>
                    <a href="${url}" nav-target="mainFrame" class="co-blue">${views.common['detail']}</a>
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
