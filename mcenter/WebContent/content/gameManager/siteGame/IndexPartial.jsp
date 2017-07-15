<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.column['VSiteGame.orderNum']}</th>
            <th>${views.column['VSiteGame.defaultName']}</th>
            <th>${views.column['VSiteGame.customerName']}</th>
            <th>${views.column['VSiteGame.supportTerminal']}</th>
            <th>${views.column['VSiteGame.canTry']}</th>
            <th>${views.column['VSiteGame.cover']}</th>
            <th>${views.column['SiteGameI18n.backupCover']}</th>
            <th>${views.column['VSiteGame.tagCount']}</th>
            <th>${views.column['VSiteGame.playerCount']}</th>
            <th>${views.column['VSiteGame.yesterdayCount']}</th>
            <th>${views.column['VSiteGame.status']}</th>
            <th>${views.common['operate']}</th>
        </tr>
        <tr class="bd-none hide">
            <th colspan="7">
                <%-- <div class="select-records"><i class="fa fa-exclamation-circle"></i>${views.role['player.cancelSelectAll.prefix']}&nbsp;<span id="page_selected_total_record"></span>${views.role['player.cancelSelectAll.middlefix']}
                     <soul:button target="cancelSelectAll" opType="function" text="${views.role['player.cancelSelectAll']}"/>${views.role['player.cancelSelectAll.suffix']}
                 </div>--%>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty command.result}">
            <td colspan="7" class="no-content_wrap">
                <div>
                    <i class="fa fa-exclamation-circle"></i> ${views.common['noResult']}
                </div>
            </td>
        </c:if>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr class="tab-detail">
                <td>
                    <c:if test="${p.status=='disable'||p.systemStatus=='disable'}">--</c:if>
                    <c:if test="${p.status!='disable'&&p.systemStatus!='disable'}">
                    ${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}
                    </c:if>

                </td>
                <td>${gbFn:getGameName(p.gameId).toString()}</td>
                <td>${gbFn:getSiteGameName(p.gameId).toString()}</td>
                <td>
                    <c:choose>
                        <c:when test="${empty p.supportTerminal}">
                            --
                        </c:when>
                        <c:when test="${p.supportTerminal=='1'}">
                            ${views.content['电脑']}
                        </c:when>
                        <c:when test="${p.supportTerminal=='2'}">
                            ${views.content['手机']}
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:if test="${p.canTry}">${views.content['game.support']}</c:if>
                    <c:if test="${!p.canTry}">${views.content['game.notSupport']}</c:if>

                </td>
                <td>
                    <c:if test="${not empty siteGames[p.gameId.toString()].cover}">
                        <soul:button target="previewImg" text="" opType="function" tag="a">
                            <img id="cover${p.gameId}" data-src="${soulFn:getImagePath(domain,siteGames[p.gameId.toString()].cover)}" src="${soulFn:getThumbPath(domain, siteGames[p.gameId.toString()].cover,66,24)}"/>
                        </soul:button>
                    </c:if>
                    <c:if test="${empty siteGames[p.gameId.toString()].cover}">
                        <soul:button target="previewImg" text="" opType="function" tag="a">
                        <img id="cover${p.gameId}" data-src="${soulFn:getImagePath(domain,game[p.gameId.toString()].cover)}" src="${soulFn:getThumbPath(domain, game[p.gameId.toString()].cover,66,24)}"/>
                        </soul:button>
                    </c:if>
                </td>
                <td>

                    <c:if test="${not empty siteGames[p.gameId.toString()].backupCover}">
                        <soul:button target="previewImg" text="" opType="function" tag="a">
                            <img id="cover${p.id}" data-src="${soulFn:getImagePath(domain,siteGames[p.gameId.toString()].backupCover)}" src="${soulFn:getThumbPath(domain, siteGames[p.gameId.toString()].backupCover,66,24)}"/>
                        </soul:button>
                    </c:if>
                    <c:if test="${empty siteGames[p.gameId.toString()].backupCover}">
                        --
                    </c:if>
                </td>
                <td>${p.tagCount}</td>
                <td>${p.playerCount}</td>
                <td>${p.yesterdayCount}</td>
                <td>
                    <c:if test="${p.gameStatus=='normal'}">
                        <c:if test="${p.status=='normal'}">
                            <c:if test="${p.realStatus=='normal'}">
                                <span class="label label-success">${dicts.game.status['normal']}</span>
                            </c:if>
                            <c:if test="${p.realStatus=='pre_maintain'}">
                                <span class="label label-success">${dicts.game.status['normal']}</span>
                                <c:if test="${p.gameStatus=='maintain'}">
                                    ${soulFn:formatDateTz(p.maintainStartTime, DateFormat.DAY_SECOND,timeZone)}
                                    ${views.content['game.inToMaintain']}
                                </c:if>
                            </c:if>
                            <c:if test="${p.realStatus=='maintain'}">
                                <span class="label label-warning">${dicts.game.status['maintain']}</span>
                                    ${soulFn:formatDateTz(p.maintainEndTime, DateFormat.DAY_SECOND,timeZone)}
                                ${views.content['game.endOfMaintain']}
                            </c:if>
                        </c:if>
                        <c:if test="${p.status=='disable'}">
                            <span class="label label-danger">${dicts.game.status['disable']}</span>
                        </c:if>
                    </c:if>
                    <c:if test="${p.gameStatus=='disable'}">
                        <span class="label label-danger">${dicts.game.status['disable']}</span>
                    </c:if>

                </td>
                <td>
                    <div class="joy-list-row-operations">
                        <soul:button target="${root}/siteGameI18n/edit.html?id=${p.id}&search.gameId=${p.gameId}" title="${views.content['game.editgame']}" text="${views.common['edit']}" opType="dialog" callback="query"/>
                        <%--<span class="dividing-line m-r-xs m-l-xs">|</span>
                        <a href="javascript:void(0)">${views.content_auto['踢出']}</a>
                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                        <a href="javascript:void(0)">${views.content_auto['回收']}</a>--%>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
