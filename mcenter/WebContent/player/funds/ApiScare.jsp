<%--@elvariable id="listVo" type="so.wwb.gamebox.model.master.player.vo.PlayerApiListVo"--%>
<%--@elvariable id="player" type="so.wwb.gamebox.model.master.player.po.UserPlayer"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="apis" value="<%=Cache.getApi()%>"/>
<c:set var="balanceTime" value="<%=SessionManager.getLastRefreshApiBalanceTime()%>"/>
<!--api占比-->
<div class="al-left assets-wrap">
    ${views.role['player.view.funds.totalAssets']}：
    <span class="co-red ass">${soulFn:formatCurrency(listVo.totalAssets)}</span>
    <span class="co-gray9 m-l-lg tbsj">
        <soul:button target="refresh" text="" nowTime="${soulFn:formatDateTz(nowTime, DateFormat.DAY_SECOND, timeZone)}" synTime="${soulFn:formatDateTz(balanceTime, DateFormat.DAY_SECOND,timeZone)}" cssClass="co-gray9 totalRefresh" opType="function" playerId="${player.id}">
            <i class="fa fa-refresh"></i>
        </soul:button>
        ${views.role['player.view.funds.synchronizationTime']}：${soulFn:formatDateTz(player.synchronizationTime, DateFormat.DAY_SECOND,timeZone)}
    </span>
    <c:if test="${fn:length(listVo.result)>0}">
        <soul:button cssClass="btn btn-filter btn-xs pull-right m-t-xs" text="${views.role['player.view.funds.recoveryFunds']}" target="${root}/playerFunds/recoveryFunds.html?search.userId=${player.id}" opType="dialog" playerId="${player.id}" callback="refresh" url="${root}/playerFunds/refresh.html?playerId=${player.id}&type=all"></soul:button>
    </c:if>
    <c:if test="${fn:length(listVo.result)<=0}">
        <span class="btn btn-filter btn-xs pull-right m-t-xs disabled">${views.role['player.view.funds.recoveryFunds']}</span>
    </c:if>
</div>
<dl class="clearfix funds-wrap">
    <dt>
        <b>${views.role['player.view.funds.walletBalance']}</b>
        <span>${soulFn:formatCurrency(player.walletBalance)}</span>
        <a href="/fund/manual/index.html?username=${player.username}" nav-target="mainFrame" >${views.role['player.view.funds.manualDeposit']}</a>
    </dt>
    <div class="zj">
        <c:forEach items="${listVo.result}" var="i" end="7">
            <dd <c:if test="${i.synchronizationStatus=='abnormal'}">data-toggle="tooltip" data-placement="left" title="${fn:replace(views.home['index.assets.abnormalTips'], '{0}', i.abnormalReason)}"</c:if>>
                <div class="m-r-xs pull-left prog">
                    <div style="display: inline; width: 60px; height: 60px;">
                        <input type="text" value="${i.scale}" class="dial m-r-sm" data-readOnly=true
                                <c:choose>
                                    <c:when test="${!i.isTransaction&&empty i.money}">
                                        data-fgcolor="#999"
                                    </c:when>
                                    <c:when test="${i.synchronizationStatus=='abnormal'}">
                                        data-fgColor="#f88311"
                                    </c:when>
                                    <c:when test="${apis[i.apiId.toString()].status=='maintain'}">
                                        data-fgColor="#18b160"
                                    </c:when>
                                    <c:otherwise>data-fgcolor="#2772ee"</c:otherwise>
                                </c:choose> data-width="60" data-height="60" data-thickness=".1"/>
                    </div>
                </div>
                <span class="con">${gbFn:getSiteApiName(i.apiId.toString())}</span>
                <span class="con">
                    <c:choose>
                        <c:when test="${!i.isTransaction&&empty i.money}">
                           0.00
                        </c:when>
                        <c:when test="${apis[i.apiId.toString()].status=='maintain'}">
                            ${soulFn:formatCurrency(i.money)}&nbsp; ${views.role['player.view.funds.gameMaintenance']}
                        </c:when>
                        <c:otherwise>${soulFn:formatCurrency(i.money)}</c:otherwise>
                    </c:choose>
                </span>
                <soul:button cssClass="refresh refreshApi" target="refresh" text="" opType="function" playerId="${i.playerId}" apiId="${i.apiId}" title="${soulFn:formatDateTz(i.synchronizationTime, DateFormat.DAY_SECOND,timeZone)}">
                    <i class="fa fa-refresh"></i>
                </soul:button>
            </dd>
        </c:forEach>
        <c:if test="${fn:length(listVo.result)>8}">
            <dd>
                <span class="add-ico-a"></span>
                <soul:button target="moreApi" text="${views.role['player.view.funds.moreGame']}" opType="function" cssClass="pull-left m-t-md m-l-sm"/>
            </dd>
        </c:if>
        <div name="moreApi" style="display: none">
        <c:forEach items="${listVo.result}" var="i" begin="8">
            <dd <c:if test="${i.synchronizationStatus=='abnormal'&&!empty i.abnormalReason}">data-toggle="tooltip" data-placement="left" title="${fn:replace(views.home['index.assets.abnormalTips'], '{0}', i.abnormalReason)}"</c:if>>
                <div class="m-r-xs pull-left prog">
                    <div style="display: inline; width: 60px; height: 60px;">
                        <input type="text" value="${i.scale}" class="dial m-r-sm" data-readOnly=true
                                <c:choose>
                                    <c:when test="${!i.isTransaction&&empty i.money}">
                                        data-fgcolor="#999"
                                    </c:when>
                                    <c:when test="${i.synchronizationStatus=='abnormal'}">
                                        data-fgColor="#f88311"
                                    </c:when>
                                    <c:when test="${apis[i.apiId.toString()].status=='maintain'}">
                                        data-fgColor="#18b160"
                                    </c:when>
                                    <c:otherwise>data-fgcolor="#2772ee"</c:otherwise>
                                </c:choose> data-width="60" data-height="60" data-thickness=".1"/>
                    </div>
                </div>
                <span class="con">${gbFn:getSiteApiName(i.apiId.toString())}</span>
                <span class="con">
                    <c:choose>
                        <c:when test="${apis[i.apiId.toString()].status=='maintain'}">
                            ${soulFn:formatCurrency(i.money)}&nbsp;${views.role['player.view.funds.gameMaintenance']}
                        </c:when>
                        <c:when test="${!i.isTransaction&&empty i.money}">
                            0.00
                        </c:when>
                        <c:otherwise>${soulFn:formatCurrency(i.money)}</c:otherwise>
                    </c:choose>
                </span>
                <soul:button cssClass="refresh refreshApi" target="refresh" text="" opType="function" apiId="${i.apiId}" playerId="${i.playerId}" title="${soulFn:formatDateTz(i.synchronizationTime, DateFormat.DAY_SECOND,timeZone)}">
                    <i class="fa fa-refresh"></i>
                </soul:button>
            </dd>
        </c:forEach>
        </div>
    </div>
</dl>


