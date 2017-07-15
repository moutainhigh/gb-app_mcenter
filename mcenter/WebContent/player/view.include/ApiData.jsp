<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="apis" value="<%=Cache.getApi()%>"/>
    <input type="hidden" name="allIsNormal" value="${allIsNormal}">
    <div class="table-responsive" style="background: #fff;">
        <table class="table table-bordered table-desc-list" aria-describedby="editable_info">
            <thead>
            <tr>
                <th class="bg-green" style="width: 150px"></th>
                <th class="bg-green" style="width: 150px">${views.player_auto['本站']}</th>
                <c:forEach items="${allApiMap}" var="item">
                    <c:set var="hasApi" value="false"></c:set>
                    <c:forEach var="api" items="${listVo.result}" varStatus="vs">
                        <c:if test="${item.key==api.apiId}">
                            <c:set var="hasApi" value="true"></c:set>
                            <th class="${empty apiAccountMap[api.apiId]?'':'bg-blue'}">${gbFn:getSiteApiName(api.apiId.toString())}</th>
                        </c:if>
                    </c:forEach>
                    <c:if test="${hasApi=='false'}">
                        <c:if test="${item.key!=api.apiId}"><th>${gbFn:getSiteApiName(item.key)}</th></c:if>
                    </c:if>
                </c:forEach>

            </tr>
            </thead>
            <tbody>
            <tr class="gradeA odd">
                <th>${views.player_auto['账号']}</th>
                <td>${player.username}</td>

                <c:forEach items="${allApiMap}" var="item">
                    <c:set var="hasApi" value="false"></c:set>
                    <c:forEach var="api" items="${listVo.result}" varStatus="vs">
                        <c:if test="${item.key==api.apiId}">
                            <c:set var="hasApi" value="true"></c:set>
                            <td>
                                <c:if test="${not empty apiAccountMap[api.apiId]}">${apiAccountMap[api.apiId].account}</c:if>
                            </td>
                        </c:if>
                    </c:forEach>
                    <c:if test="${hasApi=='false'}">
                        <td class="co-gray">
                            ${views.player_auto['尚未创建']}
                        </td>
                    </c:if>
                </c:forEach>
            </tr>
            <tr class="gradeA even">
                <th>${views.player_auto['游戏余额']}</th>
                <td>
                    <c:if test="${not empty listVo.result}">
                    <a type="button" class="co-gray m-r-sm">
                        <soul:button cssClass="co-gray m-r-sm refresh refreshApi" target="showApiData" text="" opType="function"
                                     showLoading="true" title="${soulFn:formatDateTz(i.synchronizationTime, DateFormat.DAY_SECOND,timeZone)}">
                            <i class="fa fa-refresh"></i>
                        </soul:button>
                    </a>
                    </c:if>
                    ${dicts.common.currency_symbol[player.defaultCurrency]}
                    ${soulFn:formatInteger(apiTotalBalance)}${soulFn:formatDecimals(apiTotalBalance)}
                </td>
                <c:forEach items="${allApiMap}" var="item">
                    <c:set var="hasApi" value="false"></c:set>
                    <c:forEach var="api" items="${listVo.result}" varStatus="vs">
                        <c:if test="${item.key==api.apiId}">
                            <c:set var="hasApi" value="true"></c:set>
                            <td>
                                <soul:button cssClass="co-gray m-r-sm refresh refreshApi" target="fetchSingleApiBalance" text="" opType="function"
                                             playerId="${api.playerId}" apiId="${api.apiId}"  showLoading="true" title="${soulFn:formatDateTz(i.synchronizationTime, DateFormat.DAY_SECOND,timeZone)}">
                                    <i class="fa fa-refresh"></i>
                                </soul:button>
                        <span id="api_balance_${api.apiId}">
                            <c:choose>
                                <c:when test="${api.synchronizationStatus=='abnormal'}">
                                    ${views.player_auto['获取中...']}
                                </c:when>
                                <c:when test="${!api.isTransaction&&empty api.money}">
                                    ${dicts.common.currency_symbol[player.defaultCurrency]} 0
                                </c:when>
                                <c:otherwise>
                                    ${dicts.common.currency_symbol[player.defaultCurrency]}
                                    ${soulFn:formatInteger(api.money)}${soulFn:formatDecimals(api.money)}
                                </c:otherwise>
                            </c:choose>
                        </span>
                            </td>
                        </c:if>
                    </c:forEach>
                    <c:if test="${hasApi=='false'}">
                        <td>
                            --
                        </td>
                    </c:if>
                </c:forEach>
            </tr>
            <tr class="gradeA odd">
                <td></td>
                <td>
                    <c:if test="${fn:length(listVo.result)>0}">
                        <soul:button target="${root}/playerFunds/recovery.html?search.playerId=${player.id}" text="${views.role['player.view.funds.allRecovery']}"
                                     confirm="${fn:replace(views.role['player.view.funds.confirmPlayerAllGameRecoveryWallect'], '{}', player.username)}"
                                     opType="ajax" cssClass="btn btn-outline btn-filter btn-xs" callback="showApiData" placement="right"/>
                    </c:if>
                </td>
                <c:forEach items="${allApiMap}" var="item">
                    <c:set var="hasApi" value="false"></c:set>
                    <c:forEach var="api" items="${listVo.result}" varStatus="vs">
                        <c:if test="${item.key==api.apiId}">
                            <c:set var="hasApi" value="true"></c:set>
                            <td>
                                <c:choose>
                                    <c:when test="${apis[api.apiId.toString()].systemStatus=='maintain'}">
                                        ${views.player_auto['维护中...']}
                                    </c:when>
                                    <c:when test="${api.synchronizationStatus=='abnormal'}">
                                        --
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${not empty apiAccountMap[api.apiId]}">
                                            <c:if test="${not empty playerApiMap[api.apiId]}">
                                                <c:if test="${playerApiMap[api.apiId].taskStatus}">
                                                    <span class="co-gray">${views.player_auto['回收中...']}</span>
                                                </c:if>
                                                <c:if test="${!playerApiMap[api.apiId].taskStatus}">
                                                    <soul:button target="${root}/playerFunds/recovery.html?type=singlePlayerApi&search.id=${api.id}&search.apiId=${api.apiId}&search.playerId=${player.id}"
                                                                 text="${views.player_auto['回收']}" opType="ajax" precall="" callback="showApiData" cssClass="btn btn-outline btn-filter btn-xs"/>
                                                </c:if>
                                            </c:if>

                                        </c:if>
                                        <c:if test="${empty apiAccountMap[api.apiId]}">
                                            --
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </c:if>
                    </c:forEach>
                    <c:if test="${hasApi=='false'}">
                        <td>
                            --
                        </td>
                    </c:if>
                </c:forEach>
            </tr>

            </tbody>
        </table>
    </div>