<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.po.vplayerwithdraw"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
    <c:forEach items="${command.result}" var="p" varStatus="status">
        <tr class="tab-detail">
            <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
            <td>
                <shiro:hasPermission name="role:player_detail"><a  href="/player/playerView.html?search.id=${p.playerId}" nav-Target="mainFrame"></shiro:hasPermission>
                        ${p.username}
                <shiro:hasPermission name="role:player_detail"></a></shiro:hasPermission>

                <c:if test="${p.riskMarker == true}">
                    <span data-content="${views.fund_auto['危险层级']}"
                          data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                          role="button" class="ico-lock co-red3 help-popover" tabindex="0"
                          data-original-title="" title=""><i class="fa fa-warning"></i>&nbsp;</span>
                </c:if>
                <c:if test="${p.onLineId>0}">
                    <span data-content="${views.role['player.list.icon.online']}"
                          data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                          role="button" class="ico-lock help-popover" tabindex="0"
                          data-original-title="" title=""><i class="fa fa-flash"></i></span>
                </c:if>
            </td>
            <td>
                <a href="/vPlayerRankStatistics/view.html?id=${p.rankId}" nav-target="mainFrame">
                    <c:choose>
                        <c:when test="${p.riskMarker}">
                    <span data-content="${views.fund_auto['危险层级']}" data-placement="right" data-trigger="focus" data-toggle="popover"
                          data-container="body" role="button" class="help-popover" tabindex="0">
                        <span class="label label-danger">${p.rankName}</span>
                    </span>
                        </c:when>
                        <c:otherwise>
                            <span class="label label-info">${p.rankName}</span>
                        </c:otherwise>
                    </c:choose>
                </a>
            </td>
            <td>
                <span data-content="${soulFn:formatDateTz(p.createTime, DateFormat.DAY_SECOND,timeZone)}" data-placement="top" data-trigger="focus" data-toggle="popover"
                      data-container="body" role="button" class="help-popover" tabindex="0">
                    <a name="copy" data-clipboard-text="${soulFn:formatDateTz(p.createTime, DateFormat.DAY_SECOND, timeZone)}">
                        <span class="co-grayc2">${p.createTimeMemo}</span>
                    </a>
                </span>
            </td>
            <td>${p.successCount == null ? 0 : p.successCount}${views.fund_auto['次']}</td>
            <td class="money">
                <c:set var="counterFee" value="${p.counterFee>0?'-':''}${soulFn:formatInteger(p.counterFee)}${soulFn:formatDecimals(p.counterFee)}"/>
                <c:set var="administrativeFee" value="${p.administrativeFee>0?'-':''}${soulFn:formatInteger(p.administrativeFee)}${soulFn:formatDecimals(p.administrativeFee)}"/>
                <c:set var="deductFavorable" value="${p.deductFavorable>0?'-':''}${soulFn:formatInteger(p.deductFavorable)}${soulFn:formatDecimals(p.deductFavorable)}"/>

                <span data-content="<c:choose><c:when test="${p.counterFee eq 0 ||empty p.counterFee}">${views.fund_auto['无手续费']}</c:when><c:otherwise>${views.fund_auto['手续费']}${dicts.common.currency_symbol[p.withdrawMonetary]}${counterFee}</c:otherwise></c:choose>" data-placement="top" data-trigger="focus" data-toggle="popover"
                      data-container="body" role="button" class="help-popover" tabindex="0">
                    <span class="fee <c:if test="${p.counterFee eq 0 ||empty p.counterFee}">none</c:if><c:if test="${not empty p.counterFee && p.counterFee ne 0}">red</c:if>"></span>
                </span>
                <span data-content="<c:choose><c:when test="${p.administrativeFee eq 0 ||empty p.administrativeFee}">${views.fund_auto['无行政费']}</c:when><c:otherwise>${views.fund_auto['行政费']}${dicts.common.currency_symbol[p.withdrawMonetary]}${administrativeFee}</c:otherwise></c:choose>" data-placement="top" data-trigger="focus" data-toggle="popover"
                      data-container="body" role="button" class="help-popover" tabindex="0">
                    <span class="fee <c:if test="${p.administrativeFee eq 0 ||empty p.administrativeFee}">none</c:if><c:if test="${not empty p.administrativeFee && p.administrativeFee ne 0}">blue</c:if>"></span>
                </span>
                <span data-content="<c:choose><c:when test="${p.deductFavorable eq 0 ||empty p.deductFavorable}">${views.fund_auto['无扣除优惠']}</c:when><c:otherwise>${views.fund_auto['扣除优惠']}${dicts.common.currency_symbol[p.withdrawMonetary]}${deductFavorable}</c:otherwise></c:choose>" data-placement="top" data-trigger="focus" data-toggle="popover"
                      data-container="body" role="button" class="help-popover" tabindex="0">
                    <span class="fee <c:if test="${p.deductFavorable eq 0||empty p.deductFavorable}">none</c:if><c:if test="${not empty p.deductFavorable && p.deductFavorable ne 0}">orange</c:if>"></span>
                </span>
            </td>
            <td class="money">
                <c:if test="${p.withdrawActualAmount != null }">
                    ${dicts.common.currency_symbol[p.withdrawMonetary]}&nbsp;${soulFn:formatInteger(p.withdrawActualAmount)}<i>${soulFn:formatDecimals(p.withdrawActualAmount)}</i>
                    <a name="copy" data-clipboard-text="${soulFn:formatInteger(p.withdrawActualAmount)}${soulFn:formatDecimals(p.withdrawActualAmount)}"
                       class="btn btn-xs btn-info btn-stroke"><li class="fa fa-copy" ></li></a>
                    <%--<a type="button" class="btn btn-xs btn-info btn-stroke"><span class="fa fa-copy" title="${views.fund_auto['复制']}"></span></a>--%>
                </c:if>
            </td>
            <td>
                <input type="hidden" name="id" value="${p.id}"/>
                <c:if test="${p.withdrawStatus=='1'}">
                    <soul:button permission="fund:playerwithdraw_check" target="withdrawAuditView" size="auditLogCss" cssClass="label label-info p-x-md" text="${dicts.fund.withdraw_status[p.withdrawStatus]}" opType="function" />
                </c:if>
                <c:if test="${p.withdrawStatus=='4'}">
                    <soul:button permission="fund:playerwithdraw_check" target="withdrawAuditView" size="auditLogCss" cssClass="label label-success p-x-md" text="${dicts.fund.withdraw_status[p.withdrawStatus]}" opType="function" />
                </c:if>
                <c:if test="${p.withdrawStatus=='5'}">
                    <soul:button permission="fund:playerwithdraw_check" target="withdrawAuditView" size="auditLogCss" cssClass="label label-danger p-x-md" text="${dicts.fund.withdraw_status[p.withdrawStatus]}" opType="function" />
                </c:if>
                <c:if test="${p.withdrawStatus=='6'}">
                    <soul:button permission="fund:playerwithdraw_check" target="withdrawAuditView" size="auditLogCss" cssClass="label label-warning p-x-md" text="${dicts.fund.withdraw_status[p.withdrawStatus]}" opType="function" />
                </c:if>
            </td>
            <td>
                <c:choose>
                    <c:when test="${p.withdrawStatus != '1' }">
                        ${p.checkUserName}
                    </c:when>
                    <c:otherwise>
                        --
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                <span class="co-grayc2">
                <c:choose>
                    <c:when test="${p.withdrawStatus != '1' }">
                        <span data-content="${soulFn:formatDateTz(p.checkTime, DateFormat.DAY_SECOND,timeZone)}" data-placement="top" data-trigger="focus" data-toggle="popover"
                                      data-container="body" role="button" class="help-popover" tabindex="0">
                            <a name="copy" data-clipboard-text="${soulFn:formatDateTz(p.checkTime, DateFormat.DAY_SECOND, timeZone)}">
                                <span class="co-grayc2" >${p.checkTimeMemo}</span>
                            </a>
                        </span>
                    </c:when>
                    <c:otherwise>
                        --
                    </c:otherwise>
                </c:choose>
                </span>
            </td>
            <td>
                <input type="hidden" name="id" value="${p.id}"/><!--fund/withdraw/withdrawAuditView.html?search.id="+id+"&pageType="+pageType-->
                <a href="/fund/withdraw/withdrawAuditView.html?search.id=${p.id}&pageType=detail" nav-target="mainFrame" class="co-blue">${views.common['detail']}</a>
                <%--<soul:button tag="a" permission="fund:playerwithdraw_check" pageType="detail" target="withdrawAuditView"
                             size="auditLogCss" cssClass="co-blue" text="${views.common['detail']}" opType="function" />--%>
            </td>
            <td>
                <c:choose>
                    <c:when test="${fn:length(p.checkRemark) > 21}">
                        <span title="${p.checkRemark}"><c:out value="${fn:substring(p.checkRemark, 0, 20)}..." /></span>
                    </c:when>
                    <c:otherwise>
                        ${p.checkRemark}
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
