<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserPlayerVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="balanceTime" value="<%=SessionManager.getLastRefreshApiBalanceTime()%>"/>
<div class="detect-title">${views.fund['playerDetect.view.fundRecord']}</div>
<c:set var="isLotterySite" value="<%=ParamTool.isLotterySite()%>"/>
<div class="al-left assets-wrap">
    ${views.fund['playerDetect.view.totalAssets']}：
    <span class="co-red ass" id="totalAssets">${soulFn:formatCurrency(apiList.totalAssets)}</span>
    <span class="m-loading-icon-x" style="display: none"><img src="${resRoot}/images/022b.gif"></span>
        <c:if test="${!isLotterySite}">
         <span class="co-gray9 m-l-md">
            <soul:button target="refresh" nowTime="${soulFn:formatDateTz(nowTime, DateFormat.DAY_SECOND, timeZone)}" synTime="${soulFn:formatDateTz(balanceTime, DateFormat.DAY_SECOND,timeZone)}" text="" opType="function" cssClass="co-gray9 totalRefresh" playerId="${command.result.id}"><i class="fa fa-refresh"></i></soul:button>
            ${views.fund['playerDetect.view.synchronizationTime']}：${soulFn:formatDateTz(command.result.synchronizationTime, DateFormat.DAY_SECOND,timeZone)}
        </span>
    </c:if>
    <c:if test="${isLotterySite}">
        <span class="m-l-md">
             <shiro:hasPermission name="fund:artificial">
                 <a href="/fund/manual/index.html?username=${command.result.username}&hasReturn=true" nav-target="mainFrame">${views.fund_auto['人工存入']}</a>
                 <a style="margin-left: 10px;" href="/fund/manual/index.html?username=${command.result.username}&type=withdraw&hasReturn=true" nav-target="mainFrame">${views.fund_auto['人工取出']}</a>
             </shiro:hasPermission>
        </span>
    </c:if>
</div>
<c:if test="${!isLotterySite}">
    <dl class="clearfix funds-wrap tooltip-demo p-xs">
        <dt class="m-l-sm">
            <b>${views.fund['playerDetect.view.walletBalance']}</b>
            <span id="walletBalance">${soulFn:formatCurrency(command.result.walletBalance)}</span>
            <span class="m-loading-icon-x" style="display: none"><img src="${resRoot}/images/022b.gif"></span>
        <shiro:hasPermission name="fund:artificial">
                <a style="float: left" href="/fund/manual/index.html?username=${command.result.username}&hasReturn=true" nav-target="mainFrame">${views.fund_auto['人工存入']}</a>
                <a style="float: left;margin-left: 10px;" href="/fund/manual/index.html?username=${command.result.username}&type=withdraw&hasReturn=true" nav-target="mainFrame">${views.fund_auto['人工取出']}</a>
            </shiro:hasPermission>
        </dt>
        <div class="zj">
            <c:forEach items="${apiList.result}" var="playerApi" varStatus="status">
                <dd id="game" <c:if test="${playerApi.synchronizationStatus=='abnormal'&&!empty playerApi.abnormalReason}">data-toggle="tooltip" data-placement="left" title="${fn:replace(views.home['index.assets.abnormalTips'], '{0}', playerApi.abnormalReason)}"</c:if>>
                    <div class="m-r-xs pull-left prog">
                        <input type="text" value="${playerApi.scale}" class="dial m-r-sm jdt" data-readOnly=true
                                <c:choose>
                                    <c:when test="${!playerApi.isTransaction&&empty playerApi.money}">
                                        data-fgcolor="#999"
                                    </c:when>
                                    <c:when test="${playerApi.synchronizationStatus=='abnormal'}">
                                        data-fgColor="#f88311"
                                    </c:when>
                                    <c:when test="${apis[playerApi.apiId.toString()].status=='maintain'}">
                                        data-fgColor="#18b160"
                                    </c:when>
                                    <c:otherwise>data-fgcolor="#2772ee"</c:otherwise>
                                </c:choose> data-width="60" data-height="60" data-thickness=".1"/>
                    </div>
                    <span class="con">${gbFn:getSiteApiName(playerApi.apiId.toString())}</span>
                <span class="con">
                      <c:choose>
                          <c:when test="${!playerApi.isTransaction&&empty playerApi.money}">
                              0.00
                          </c:when>
                          <c:when test="${apis[playerApi.apiId.toString()].status=='maintain'}">
                              ${soulFn:formatCurrency(playerApi.money)}&nbsp; ${views.role['player.view.funds.gameMaintenance']}
                          </c:when>
                          <c:otherwise>${soulFn:formatCurrency(playerApi.money)}</c:otherwise>
                      </c:choose>
                </span>
                    <soul:button target="refresh" text="" opType="function" cssClass="refresh refreshApi" title="${soulFn:formatDateTz(playerApi.synchronizationTime, DateFormat.DAY_SECOND,timeZone)}" apiId="${playerApi.apiId}" playerId="${command.result.id}"><i class="fa fa-refresh"></i></soul:button>
                </dd>
                <div class="game onmouse loading-api loading-${playerApi.apiId}" style="display: none;">
                    <div class="g-loading-icon"><img src="${resRoot}/images/022b.gif"></div>
                </div>
            </c:forEach>
        </div>
    </dl>
</c:if>


