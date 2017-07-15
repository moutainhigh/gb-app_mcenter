<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="col-sm-6">
    <div class="p-b-xs p-t-sm"><span class="label label-info p-x-lg">${views.home_auto['站点状况']}</span></div>
    <div class="chart-warp shadow">
        <div id="siteData" class="chart"></div>
    </div>
</div>
<div class="col-sm-6">
    <div class="p-b-xs p-t-sm"><span class="label label-warning p-x-lg">${views.home_auto['玩家状况']}</span></div>
    <div class="chart-warp shadow">
        <div id="playerData" class="chart"></div>
    </div>
</div>
<div class="col-sm-6">
    <div class="p-b-xs p-t-sm"><span class="label label-success p-x-lg">${views.home_auto['存款走势']}</span></div>
    <div class="chart-warp shadow">
        <div id="depositData" class="chart"></div>
    </div>
</div>
<div class="col-sm-6">
    <div class="p-b-xs p-t-sm">
        <span class="label label-danger p-x-lg" style="vertical-align: middle; margin-right: 15px">${views.home_auto['游戏盈亏']}</span>
    </div>
    <div class="chart-warp shadow">
        <div id="gameData" class="chart" style="height: 372px; margin-bottom: 2px;"></div>
        <div class="days">
            <span class="stat-day">
                <c:forEach var="d" items="${days}" varStatus="vs">
                    <c:choose>
                        <c:when test="${vs.index == 6}">
                            <c:set var="clz" value="sel" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="clz" value="" />
                        </c:otherwise>
                    </c:choose>
                    <soul:button cssClass="${clz}" target="chart.changeGameData" text="${d}" opType="function" data_day="${vs.index - 7}" />
                </c:forEach>
                <input type="hidden" id="currDay" value="-1" />
            </span>
        </div>
    </div>
</div>

