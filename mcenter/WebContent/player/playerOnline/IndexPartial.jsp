<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerOnlineListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
            <thead>
            <tr class="bg-gray">
                <th class="inline">${views.column['VPlayerOnline.username']}</th>
                <th class="inline">${views.column['VPlayerOnline.realName']}</th>
                <th class="inline">${views.player_auto['总资产']}</th>
                <th class="inline">${views.column['VPlayerOnline.loginTime']}/${views.column['VPlayerOnline.ip']}</th>
                <th class="inline">${views.column['VPlayerOnline.currentingame']}</th>
                <%--<th class="inline">${views.column['VPlayerOnline.lastActiveTime']}</th>--%>
                <%--<th class="inline">${views.column['VPlayerOnline.onlineDuration']}</th>--%>
                <th class="inline">${views.column['VPlayerOnline.useLine']}</th>
                <%--<th class="inline">${views.column['VPlayerOnline.lastLoginTime']}/${views.column['VPlayerOnline.ip']}</th>--%>
                <th class="inline">${views.column['VPlayerOnline.totalOnlineTime']}</th>
                <th class="inline">${views.common['operate']}</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <td>
                        <div>
                            <a href="/player/playerView.html?search.id=${p.id}" nav-Target="mainFrame">${p.username }</a>
                        </div>
                    </td>
                    <td>${p.realName }</td>
                    <td>${soulFn:formatInteger(p.assets)}${soulFn:formatDecimals(p.assets)}</td>
                    <td>
                        <c:if test="${p.terminal eq '2'}">
                            <span class="fa fa-mobile mobile" data-content="${views.player_auto['手机登录']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                            </span>
                        </c:if>
                        ${soulFn:formatDateTz(p.loginTime, DateFormat.DAY_SECOND,timeZone)}
                        <span class="co-red" style="padding-left: 5px">
                        ${soulFn:formatIp(p.loginIp)}
                        </span>
                        ${gbFn:getShortIpRegion(p.loginIpDictCode)}
                    </td>
                    <td>
                        <div style="width: 150px;overflow-x: hidden" id="gamenames">
                            <c:if test="${fn:length(fn:split(p.gameids, ',')) > 0}">
                                <c:forEach items="${fn:split(p.gameids, ',')}" var="id" varStatus="vs">
                                    ${gbFn:getGameName(id)}<c:if test="${fn:length(fn:split(p.gameids, ',')) != vs.index+1}">，</c:if>
                                </c:forEach>
                            </c:if>
                        </div>
                    </td>
                    <%--<td>${soulFn:formatDateTz(p.lastActiveTime, DateFormat.DAY_SECOND,timeZone)}</td>--%>
                    <%--<td>
                        <c:if test="${p.hours!=0||p.minutes!=0||p.seconds!=0}">
                            ${p.hours}${views.common['hour']}${p.minutes}${views.common['minute']}${p.seconds}${views.common['second']}
                        </c:if>
                        <c:if test="${p.hours==0&&p.minutes==0&&p.seconds==0}">
                            ${views.role['OnlinePlayer.list.notEnoughFiveinutes']}
                        </c:if>
                    </td>--%>
                    <td>${p.useLine }</td>
                    <%--<td>${soulFn:formatDateTz(p.lastLoginTime, DateFormat.DAY_SECOND,timeZone)}&nbsp;<span class="co-red">${soulFn:formatIp(p.lastLoginIp)}</span><c:if test="${p.loginIpDictCode!=''}">:</c:if>${gbFn:getIpRegion(p.lastLoginIpDictCode)}</td>--%>
                    <td>${p.days_total}${views.common['day']}${p.hours_total}${views.common['hour']}${p.minutes_total}${views.common['minute']}${p.seconds_total}${views.common['second']}</td>
                    <td>
                        <div class="joy-list-row-operations">
                            <!--TODO cj-->
                            <a href="/report/log/logList.html?search.roleType=player&search.operator=${p.username}&search.moduleType=1" nav-target="mainFrame">${views.common['logRecord']}</a>
                            <%--<soul:button target="${root}/vPlayerOnline/view.html?id=${p.id}" text="${views.common['logRecord']}" opType="dialog"/><span class="dividing-line m-r-xs m-l-xs">|</span>--%>
                            <soul:button permission="role:player:offline" target="${root}/player/view/offlineForced.html?userId=${p.id}" callback="callbackquery" text="${views.common['kickout']}" opType="dialog">${views.common['kickout']}</soul:button>
                            <%--<soul:button target="${root}/player/view/saveOffline?id=${p.id}" text="${views.common['kickout']}" opType="ajax"/>--%>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

<soul:pagination/>
<!--//endregion your codes 1-->
