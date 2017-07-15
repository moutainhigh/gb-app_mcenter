<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

    <td>${rowIndex}</td>
    <td>
        <a  href="/player/playerView.html?search.id=${withdraw.playerId}" nav-Target="mainFrame">
                ${withdraw.username}
        </a>

        <c:if test="${withdraw.riskMarker == true}">
            <span data-content="${views.fund_auto['危险层级']}"
                  data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                  role="button" class="ico-lock co-red3 help-popover" tabindex="0"
                  data-original-title="" title=""><i class="fa fa-warning"></i>&nbsp;</span>
        </c:if>
        <c:if test="${withdraw.onLineId>0}">
            <span data-content="${views.role['player.list.icon.online']}"
                  data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                  role="button" class="ico-lock help-popover" tabindex="0"
                  data-original-title="" title=""><i class="fa fa-flash"></i></span>
        </c:if>
    </td>
    <td>
        <a href="/vPlayerRankStatistics/view.html?id=${withdraw.rankId}" nav-target="mainFrame">
            <c:choose>
                <c:when test="${withdraw.riskMarker}">
            <span data-content="${views.fund_auto['危险层级']}" data-placement="right" data-trigger="focus" data-toggle="popover"
                  data-container="body" role="button" class="help-popover" tabindex="0">
                <span class="label label-danger">${withdraw.rankName}</span>
            </span>
                </c:when>
                <c:otherwise>
                    <span class="label label-info">${withdraw.rankName}</span>
                </c:otherwise>
            </c:choose>
        </a>
    </td>
    <td>
        <span data-content="${soulFn:formatDateTz(withdraw.createTime, DateFormat.DAY_SECOND,timeZone)}" data-placement="top" data-trigger="focus" data-toggle="popover"
              data-container="body" role="button" class="help-popover" tabindex="0">
            <a name="copy" data-clipboard-text="${soulFn:formatDateTz(withdraw.createTime, DateFormat.DAY_SECOND, timeZone)}">
                <span class="co-grayc2">${withdraw.createTimeMemo}</span>
            </a>
        </span>
    </td>
    <td>${withdraw.successCount == null ? 0 : withdraw.successCount}${views.fund_auto['次']}</td>
    <td class="money">
        <c:set var="counterFee" value="${withdraw.counterFee>0?'-':''}${soulFn:formatInteger(withdraw.counterFee)}${soulFn:formatDecimals(withdraw.counterFee)}"/>
        <c:set var="administrativeFee" value="${withdraw.administrativeFee>0?'-':''}${soulFn:formatInteger(withdraw.administrativeFee)}${soulFn:formatDecimals(withdraw.administrativeFee)}"/>
        <c:set var="deductFavorable" value="${withdraw.deductFavorable>0?'-':''}${soulFn:formatInteger(withdraw.deductFavorable)}${soulFn:formatDecimals(withdraw.deductFavorable)}"/>

        <span data-content="<c:choose><c:when test="${withdraw.counterFee eq 0 ||empty withdraw.counterFee}">${views.fund_auto['无手续费']}</c:when><c:otherwise>${views.fund_auto['手续费']}${dicts.common.currency_symbol[withdraw.withdrawMonetary]}${counterFee}</c:otherwise></c:choose>" data-placement="top" data-trigger="focus" data-toggle="popover"
              data-container="body" role="button" class="help-popover" tabindex="0">
            <span class="fee <c:if test="${withdraw.counterFee eq 0 ||empty withdraw.counterFee}">none</c:if><c:if test="${not empty withdraw.counterFee && withdraw.counterFee ne 0}">red</c:if>"></span>
        </span>
        <span data-content="<c:choose><c:when test="${withdraw.administrativeFee eq 0 ||empty withdraw.administrativeFee}">${views.fund_auto['无行政费']}</c:when><c:otherwise>${views.fund_auto['行政费']}${dicts.common.currency_symbol[withdraw.withdrawMonetary]}${administrativeFee}</c:otherwise></c:choose>" data-placement="top" data-trigger="focus" data-toggle="popover"
              data-container="body" role="button" class="help-popover" tabindex="0">
            <span class="fee <c:if test="${withdraw.administrativeFee eq 0 ||empty withdraw.administrativeFee}">none</c:if><c:if test="${not empty withdraw.administrativeFee && withdraw.administrativeFee ne 0}">blue</c:if>"></span>
        </span>
        <span data-content="<c:choose><c:when test="${withdraw.deductFavorable eq 0 ||empty withdraw.deductFavorable}">${views.fund_auto['无扣除优惠']}</c:when><c:otherwise>${views.fund_auto['扣除优惠']}${dicts.common.currency_symbol[withdraw.withdrawMonetary]}${deductFavorable}</c:otherwise></c:choose>" data-placement="top" data-trigger="focus" data-toggle="popover"
              data-container="body" role="button" class="help-popover" tabindex="0">
            <span class="fee <c:if test="${withdraw.deductFavorable eq 0||empty withdraw.deductFavorable}">none</c:if><c:if test="${not empty withdraw.deductFavorable && withdraw.deductFavorable ne 0}">orange</c:if>"></span>
        </span>
    </td>
    <td class="money">
        <c:if test="${withdraw.withdrawActualAmount != null }">
            ${dicts.common.currency_symbol[withdraw.withdrawMonetary]}&nbsp;${soulFn:formatInteger(withdraw.withdrawActualAmount)}<i>${soulFn:formatDecimals(withdraw.withdrawActualAmount)}</i>
            <a name="copy" data-clipboard-text="${withdraw.withdrawActualAmount}"
               class="btn btn-xs btn-info btn-stroke"><li class="fa fa-copy" ></li></a>
            <%--<a type="button" class="btn btn-xs btn-info btn-stroke"><span class="fa fa-copy" title="${views.fund_auto['复制']}"></span></a>--%>
        </c:if>
    </td>
    <td>
        <c:choose>
            <c:when test="${withdraw.origin eq 'MOBILE'}">
                <span class="fa fa-mobile mobile" data-content="${views.fund_auto['手机取款']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                </span>
            </c:when>
            <c:otherwise>
                <span style="width:8px; display: inline-block"></span>
            </c:otherwise>
        </c:choose>
        <input type="hidden" name="id" value="${withdraw.id}"/>
        <c:if test="${withdraw.withdrawStatus=='1'||withdraw.withdrawStatus=='2'}">
            <soul:button permission="fund:playerwithdraw_check" dataId="${withdraw.id}" target="withdrawAuditView"  callback="query"  size="auditLogCss" cssClass="label label-info p-x-md" text="${dicts.fund.withdraw_status[withdraw.withdrawStatus]}" opType="function" />
        </c:if>
        <c:if test="${withdraw.withdrawStatus=='4'}">
            <soul:button target="withdrawAuditView" dataId="${withdraw.id}" size="auditLogCss" cssClass="label label-success p-x-md" text="${dicts.fund.withdraw_status[withdraw.withdrawStatus]}" opType="function" />
        </c:if>
        <c:if test="${withdraw.withdrawStatus=='5'}">
            <soul:button target="withdrawAuditView" dataId="${withdraw.id}" size="auditLogCss" cssClass="label label-danger p-x-md" text="${dicts.fund.withdraw_status[withdraw.withdrawStatus]}" opType="function" />
        </c:if>
        <c:if test="${withdraw.withdrawStatus=='6'}">
            <soul:button target="withdrawAuditView" dataId="${withdraw.id}" size="auditLogCss" cssClass="label label-warning p-x-md" text="${dicts.fund.withdraw_status[withdraw.withdrawStatus]}" opType="function" />
        </c:if>
        <c:if test="${withdraw.withdrawStatus=='1'}">
            <c:choose>
                <c:when test="${withdraw.isLock=='1'}">
                                        <span data-content="${views.fund_auto['锁定人']}${withdraw.lockPersonName}" data-placement="top" data-trigger="focus"
                                              data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                                            <c:if test="${command.thisUserId==withdraw.lockPersonId}">
                                                <soul:button target="cancelLockOrder" text="${views.fund_auto['取消锁定']}" opType="function" objId="${withdraw.id}">
                                                    <span class="fa fa-lock" style="padding-left: 5px"></span>
                                                </soul:button>
                                            </c:if>
                                            <c:if test="${command.thisUserId!=withdraw.lockPersonId}">
                                                <soul:button target="cancelLockOrder" text="${views.fund_auto['取消锁定']}" opType="function"
                                                             confirm="${fn:replace(views.fund_auto['当前已对该订单进行锁定'],'[0]',withdraw.lockPersonName)}" objId="${withdraw.id}">
                                                    <span class="fa fa-lock" style="padding-left: 5px"></span>
                                                </soul:button>
                                            </c:if>

                                        </span>


                </c:when>
                <c:otherwise>
                    <soul:button target="lockOrder" text="${views.fund_auto['点击锁定']}" opType="function" objId="${withdraw.id}">
                        <span class="fa fa-unlock" style="padding-left: 5px"></span>
                    </soul:button>
                </c:otherwise>
            </c:choose>
        </c:if>
    </td>
    <td>
        <c:choose>
            <c:when test="${withdraw.withdrawStatus != '1' }">
                ${withdraw.checkUserName}
            </c:when>
            <c:otherwise>
                --
            </c:otherwise>
        </c:choose>
    </td>
    <td>
        <span class="co-grayc2">
        <c:choose>
            <c:when test="${withdraw.withdrawStatus != '1' }">
                <span data-content="${soulFn:formatDateTz(withdraw.checkTime, DateFormat.DAY_SECOND,timeZone)}" data-placement="top" data-trigger="focus" data-toggle="popover"
                              data-container="body" role="button" class="help-popover" tabindex="0">
                    <a name="copy" data-clipboard-text="${soulFn:formatDateTz(withdraw.checkTime, DateFormat.DAY_SECOND, timeZone)}">
                        <span class="co-grayc2" >${withdraw.checkTimeMemo}</span>
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
        <input type="hidden" name="id" value="${withdraw.id}"/><!--fund/withdraw/withdrawAuditView.html?search.id="+id+"&pageType="+pageType-->
        <a href="/fund/withdraw/withdrawAuditView.html?search.id=${withdraw.id}&pageType=detail" nav-target="mainFrame" class="co-blue">${views.common['detail']}</a>
        <%--<soul:button tag="a" permission="fund:playerwithdraw_check" pageType="detail" target="withdrawAuditView"
                     size="auditLogCss" cssClass="co-blue" text="${views.common['detail']}" opType="function" />--%>
    </td>
    <td>
        <c:if test="${not empty withdraw.ipWithdraw}">
            IP:
            <span data-content="${gbFn:getIpRegion(withdraw.ipDictCode)}" data-placement="bottom" data-trigger="focus" data-toggle="popover"
                  data-container="body" role="button" class="help-popover" tabindex="0">
                <span>
                    <a nav-target="mainFrame" href="/report/log/logList.html?search.roleType=player&search.ip=${gbFn:ipv4LongToString(withdraw.ipWithdraw)}&keys=search.ip&hasReturn=true">${gbFn:ipv4LongToString(withdraw.ipWithdraw)}</a>
                </span>
            </span>
            <br/>
        </c:if>
        <c:choose>
            <c:when test="${fn:length(withdraw.checkRemark)>20}">
                <span data-content="${withdraw.checkRemark}" data-placement="bottom" data-trigger="focus" data-toggle="popover"
                      data-container="body" role="button" class="help-popover" tabindex="0">
                    ${fn:substring(withdraw.checkRemark, 0, 20)}...
                </span>
            </c:when>
            <c:otherwise>
                ${withdraw.checkRemark}
            </c:otherwise>
        </c:choose>
    </td>


