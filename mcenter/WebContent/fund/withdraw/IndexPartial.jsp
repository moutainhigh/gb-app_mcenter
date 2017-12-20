<%@ page import="org.soul.web.session.RedisSessionDao" %>
<%@ page import="so.wwb.gamebox.model.enums.UserTypeEnum" %><%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerWithdrawListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<style type="text/css">
    .auditLogCss .modal-dialog{
        max-width:900px;
        width: 100%;
    }
</style>
<a href="" id="showDetail" nav-target="mainFrame" class="co-blue"></a>
<input type="hidden" name="search.deductSum" value="${command.search.deductSum}">
<span id="totalSumSource" hidden>${command.totalSum}</span>
<span id="todayTotalSource" hidden>${command.todayTotal}</span>
<input id="todaySales" value="${command.search.todaySales}" hidden>
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
            <thead>
            <tr role="row" class="bg-gray">
                <th>${views.fund['交易号']}</th>
                <th>${views.column["VPlayerWithdraw.username"]}</th>
                <th>${views.fund_auto['玩家层级']}</th>
                <th>${views.column["VPlayerWithdraw.createTime"]}</th>
                <th>${views.column["VPlayerWithdraw.successCount"]}</th>
                <th>${views.fund_auto['费用扣除']}</th>
                <th>${views.column["VPlayerWithdraw.withdrawActualAmount"]}</th>
                <th class="inline" style="padding-left: 30px;">
                    <div>
                        <gb:select name="search.withdrawStatus" cssClass="btn-group chosen-select-no-single" prompt="${views.fund['withdraw.index.playerWithdraw.all']}" list="${siteWithdrawStatus}" value="${command.search.withdrawStatus}" callback="query" />
                    </div>
                </th>
                <th>${views.fund_auto['审核人']}</th>
                <th>${views.fund_auto['审核时间']}</th>
                <th>${views.fund_auto['备注']}</th>
            </tr>
            </thead>
            <tbody class="table-tbody withdraw-tbody-record">
            <%--<% RedisSessionDao redisSessionDao = (RedisSessionDao) SpringTool.getBean("redisSessionDao"); %>
            <c:set var="redisSessionDao" value='<%=redisSessionDao%>'/>--%>
                <c:forEach items="${command.result}" var="p" varStatus="status">
                    <tr class="tab-detail" id="record_id_${p.id}">
                        <td>
                            <input type="hidden" name="id" value="${p.id}"/>
                            <a href="/fund/withdraw/withdrawAuditView.html?search.id=${p.id}&pageType=detail" nav-target="mainFrame" class="co-blue">${p.transactionNo}</a></td>
                        <td>
                            <shiro:hasPermission name="role:player_detail">
                                <a  href="/player/playerView.html?search.id=${p.playerId}" nav-Target="mainFrame">
                            </shiro:hasPermission>
                                    ${p.username}
                            <shiro:hasPermission name="role:player_detail">
                                </a>
                            </shiro:hasPermission>

                            <c:if test="${p.riskMarker == true}">
                                <span data-content="${views.fund_auto['危险层级']}"
                                      data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                      role="button" class="ico-lock co-red3 help-popover" tabindex="0"
                                      data-original-title="" title=""><i class="fa fa-warning"></i>&nbsp;</span>
                            </c:if>
                            <%--<c:if test="${redisSessionDao.getUserActiveSessions(UserTypeEnum.PLAYER.getCode(), playerId).size()>0}">
                                <span data-content="${views.role['player.list.icon.online']}"
                                      data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                      role="button" class="ico-lock help-popover" tabindex="0"
                                      data-original-title="" title=""><i class="fa fa-flash"></i></span>
                            </c:if>--%>
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
                        <td>${p.successCount == null ? 0 : p.successCount}${views.fund['次']}</td>
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
                                <a name="copy" data-clipboard-text="${p.withdrawActualAmount}"
                                   class="btn btn-xs btn-info btn-stroke"><li class="fa fa-copy" ></li></a>
                                <c:if test="${!empty p.bitAmount && p.bitAmount!=0}">
                                    &nbsp;Ƀ<fmt:formatNumber pattern="#.########" value="${p.bitAmount}"/>
                                </c:if>
                                <%--<a type="button" class="btn btn-xs btn-info btn-stroke"><span class="fa fa-copy" title="${views.fund_auto['复制']}"></span></a>--%>
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${p.withdrawStatus=='1'}">
                                <c:choose>
                                    <c:when test="${p.isLock=='1'}">
                                        <span data-content="${views.fund_auto['锁定人']}${p.lockPersonName}" data-placement="left" data-trigger="focus"
                                              data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                                            <c:if test="${command.thisUserId==p.lockPersonId}">
                                                <soul:button target="cancelLockOrder" text="${views.fund_auto['取消锁定']}" opType="function" objId="${p.id}">
                                                    <span class="fa fa-lock" style="width: 12.67px;"></span>
                                                </soul:button>
                                            </c:if>
                                            <c:if test="${command.thisUserId!=p.lockPersonId}">
                                                <soul:button target="cancelLockOrder" text="${views.fund_auto['取消锁定']}" opType="function"
                                                             confirm="${fn:replace(views.fund_auto['当前'],'[0]',p.lockPersonName )}" objId="${p.id}">
                                                    <span class="fa fa-lock" style="width: 12.67px;"></span>
                                                </soul:button>
                                            </c:if>

                                        </span>


                                    </c:when>
                                    <c:otherwise>
                                        <soul:button target="lockOrder" text="${views.fund_auto['点击锁定']}" opType="function" objId="${p.id}">
                                            <span class="fa fa-unlock"></span>
                                        </soul:button>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                            <c:if test="${p.withdrawStatus!='1'}">
                                <span style="width:12.67px; display: inline-block"></span>
                            </c:if>
                            <c:if test="${p.withdrawStatus=='1'||p.withdrawStatus=='2'}">
                                <soul:button  dataId="${p.id}" target="withdrawAuditView"  callback="query"  size="auditLogCss" cssClass="label label-info p-x-md" text="${dicts.fund.withdraw_status[p.withdrawStatus]}" opType="function" />
                            </c:if>
                            <c:if test="${p.withdrawStatus=='4'}">
                                <soul:button target="withdrawAuditView" dataId="${p.id}" size="auditLogCss" cssClass="label label-success p-x-md" text="${dicts.fund.withdraw_status[p.withdrawStatus]}" opType="function" />
                                <c:if test="${p.remittanceWay=='2'&&p.checkStatus=='success'}">
                                    [${views.fund_auto['未兑币']}]
                                </c:if>
                                <c:if test="${p.remittanceWay=='2'&&p.checkStatus=='exchange_bit'}">
                                    [${views.fund_auto['已兑币']}]
                                </c:if>
                                <c:if test="${p.remittanceWay=='2'&&p.checkStatus=='automatic_pay'}">
                                    [${views.fund_auto['已打款']}]
                                </c:if>
                            </c:if>
                            <c:if test="${p.withdrawStatus=='5'}">
                                <soul:button target="withdrawAuditView" dataId="${p.id}" size="auditLogCss" cssClass="label label-danger p-x-md" text="${dicts.fund.withdraw_status[p.withdrawStatus]}" opType="function" />
                            </c:if>
                            <c:if test="${p.withdrawStatus=='6'}">
                                <soul:button target="withdrawAuditView" dataId="${p.id}" size="auditLogCss" cssClass="label label-warning p-x-md" text="${dicts.fund.withdraw_status[p.withdrawStatus]}" opType="function" />
                            </c:if>
                            <c:if test="${p.origin eq 'MOBILE'}">
                                <span class="fa fa-mobile mobile" data-content="${views.fund_auto['手机取款']}" data-placement="top" data-trigger="focus"
                                      data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0" style="padding-left: 5px;">
                                    </span>
                            </c:if>
                            <input type="hidden" name="id" value="${p.id}"/>
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
                        <%--<td>
                            <input type="hidden" name="id" value="${p.id}"/><!--fund/withdraw/withdrawAuditView.html?search.id="+id+"&pageType="+pageType-->
                            <a href="/fund/withdraw/withdrawAuditView.html?search.id=${p.id}&pageType=detail" nav-target="mainFrame" class="co-blue">${views.common['detail']}</a>
                            <soul:button tag="a" permission="fund:playerwithdraw_check" pageType="detail" target="withdrawAuditView"
                                         size="auditLogCss" cssClass="co-blue" text="${views.common['detail']}" opType="function" />
                        </td>--%>
                        <td>
                            <c:if test="${not empty p.ipWithdraw}">
                                IP:
                                <span data-content="${gbFn:getIpRegion(p.ipDictCode)}" data-placement="bottom" data-trigger="focus" data-toggle="popover"
                                      data-container="body" role="button" class="help-popover" tabindex="0">
                                    <span>
                                        <a nav-target="mainFrame" href="/report/log/logList.html?search.roleType=player&search.ip=${gbFn:ipv4LongToString(p.ipWithdraw)}&keys=search.ip&hasReturn=true">${gbFn:ipv4LongToString(p.ipWithdraw)}</a>
                                    </span>
                                </span>
                                <br/>
                            </c:if>
                            <c:choose>
                                <c:when test="${fn:length(p.checkRemark)>20}">
                                    <span data-content="${p.checkRemark}" data-placement="bottom" data-trigger="focus" data-toggle="popover"
                                          data-container="body" role="button" class="help-popover" tabindex="0">
                                        ${fn:substring(p.checkRemark, 0, 20)}...
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    ${p.checkRemark}
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <%--<div class="table-responsive text-center">
        <input type="hidden" name="search.fromCount" value="${fn:length(command.result)}">
        <input type="hidden" name="paging.totalCount" value="${command.paging.totalCount}">
        <input type="hidden" name="paging.pageNumber" value="${command.paging.pageNumber}">
        <input type="hidden" name="paging.pageSize" value="${command.paging.pageSize}">
        <soul:button target="loadMoreRecord" text="${views.fund_auto['加载更多']}" opType="function" cssClass="btn btn-outline btn-filter btn-sm m-l-sm show-more-record"></soul:button>
    </div>--%>
