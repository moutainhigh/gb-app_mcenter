<%@ page import="so.wwb.gamebox.model.master.player.po.VUserPlayer" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserPlayerListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= VUserPlayer.class %>"></c:set>
<input type="hidden" id="conditionJson" value="${params}">
<div class="search-params-div hide"></div>
<div class="table-responsive table-min-h">
    <input type="hidden" name="search.rankId" value="${command.search.rankId}">
    <table class="table table-striped table-hover dataTable" id="editable" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th class="user_checkbox"><label><input type="checkbox" class="i-checks"></label></th>
            <th>${views.common['number']}</th>
            <th>${views.player_auto['账号']}</th>
            <th>${views.player_auto['真实姓名']}</th>
            <th>${views.player_auto['所属代理']}</th>
            <soul:orderColumn poType="${poType}" property="createTime" column="${views.player_auto['注册时间']}"/>
            <%--<th>${views.player_auto['注册时间']}</th>--%>
            <th>${views.player_auto['层级']}</th>
            <%--<th>${views.player_auto['钱包余额']}</th>--%>
            <soul:orderColumn poType="${poType}" property="walletBalance" column="${views.player_auto['钱包余额']}"/>
            <soul:orderColumn poType="${poType}" property="totalAssets" column="${views.player_auto['总资产']}"/>
            <soul:orderColumn poType="${poType}" property="rechargeTotal" column="${views.player_auto['存款总额']}"/>
            <soul:orderColumn poType="${poType}" property="txTotal" column="${views.player_auto['取款总额']}"/>
            <soul:orderColumn poType="${poType}" property="loginTime" column="${views.player_auto['最后登录时间']}"/>
            <th>
                <gb:select name="search.status" value="${command.search.status}"
                           prompt="${views.role['player.list.title.status']}" list="${playerStatus}" callback="query"/>
            </th>
            <th>${views.player_auto['操作']}</th>
        </tr>
        <tr class="bd-none hide">
            <th colspan="${fn:length(command.fields)+4}">
                <div class="select-records"><i
                        class="fa fa-exclamation-circle"></i>${views.role['player.cancelSelectAll.prefix']}&nbsp;<span
                        id="page_selected_total_record"></span>${views.role['player.cancelSelectAll.middlefix']}
                    <soul:button target="cancelSelectAll" opType="function"
                                 text="${views.role['player.cancelSelectAll']}"/>${views.role['player.cancelSelectAll.suffix']}
                </div>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${command.result}" varStatus="status">
            <tr class="tab-detail">
                <td><input type="checkbox" value="${item.id}"></td>
                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                <td>
                    <a href="/player/playerDetail.html?search.id=${item.id}" nav-target="mainFrame">${item.username}</a>

                    <c:if test="${item.createChannel=='3'}">
                        <span data-content="${not empty item.importUsername && item.username!=fn:toLowerCase(item.importUsername)?'${views.player_auto[\'导入玩家，原账号\']}'.concat(item.importUsername):'${views.player_auto[\'导入玩家\']}'}"
                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                              role="button" class="ico-lock" tabindex="0"
                              data-original-title="" title=""><i class="fa fa-download"></i></span>
                    </c:if>
                    <c:if test="${item.onLineId>0}">
                        <span data-content="${views.role['player.list.icon.online']}"
                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                              role="button" class="ico-lock" tabindex="0"
                              data-original-title="" title=""><i class="fa fa-flash"></i></span>
                    </c:if>
                        <%--<c:if test="${not empty item.remarkcount && item.remarkcount > 0}"><span class="ico-lock"><i class="fa fa-flag" title="${views.role['player.list.icon.remark']}"></i></span></c:if>--%>
                    <c:if test="${item.riskMarker == true}">
                        <span data-content="${views.player_auto['危险层级']}"
                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                              role="button" class="ico-lock co-red3" tabindex="0"
                              data-original-title="" title=""><i class="fa fa-warning"></i></span>
                    </c:if>
                </td>
                <td>${item.realName}</td>
                <td>
                        <%--<a href="/vUserTopAgentManage/list.html?search.username=${item.generalAgentName}" nav-target="mainFrame">
                                ${item.generalAgentName}
                        </a>
                        >--%>
                    <a href="/vUserAgentManage/list.html?search.id=${item.agentId}" nav-target="mainFrame">
                        <c:choose>
                            <c:when test="${item.agentName.equals('defaultagent')}">
                                ${views.player_auto['默认代理']}
                            </c:when>
                            <c:otherwise>
                                ${item.agentName}
                            </c:otherwise>
                        </c:choose>
                    </a>
                </td>
                    <%--<td>
                            ${soulFn:formatDateTz(item.createTime, DateFormat.DAY,timeZone)}
                    </td>--%>
                <td>
                    <span data-content="${soulFn:formatDateTz(item.createTime, DateFormat.DAY_SECOND,timeZone)}"
                          data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                          role="button" class="ico-lock" tabindex="0" data-original-title="" title="">
                        <span class="${not empty item.rigistLessThanAMonth && item.rigistLessThanAMonth ? 'co-yellow' : ''}">
                                ${soulFn:formatDateTz(item.createTime, DateFormat.DAY,timeZone)}
                        </span>
                    </span>
                </td>
                <td>
                    <a href="/vPlayerRankStatistics/view.html?id=${item.rankId}" nav-target="mainFrame">
                        <span class="label ${item.riskMarker?'label-danger':'label-info'}">${item.rankName}</span>
                    </a>
                </td>
                <td class="money">
                        ${dicts.common.currency_symbol[item.defaultCurrency]}&nbsp;
                        ${soulFn:formatInteger(item['walletBalance'])}<i>${soulFn:formatDecimals(item['walletBalance'])}</i>
                </td>
                <td class="money">
                        ${dicts.common.currency_symbol[item.defaultCurrency]}&nbsp;
                        ${soulFn:formatInteger(item['totalAssets'])}<i>${soulFn:formatDecimals(item['totalAssets'])}</i>
                </td>
                <td class="money">
                        ${dicts.common.currency_symbol[item.defaultCurrency]}&nbsp;
                        ${soulFn:formatInteger(item['rechargeTotal'])}<i>${soulFn:formatDecimals(item['rechargeTotal'])}</i>
                </td>
                <td class="money">
                        ${dicts.common.currency_symbol[item.defaultCurrency]}&nbsp;
                        ${soulFn:formatInteger(item['txTotal'])}<i>${soulFn:formatDecimals(item['txTotal'])}</i>
                </td>
                <td>${soulFn:formatDateTz(item.loginTime, DateFormat.DAY_SECOND,timeZone)}</td>
                <td>
                    <c:if test="${item.playerStatus=='1'}">
                        <span class="label label-success">
                                ${dicts.player.player_status[item.playerStatus]}
                        </span>
                    </c:if>
                    <c:if test="${item.playerStatus=='2'}">
                        <span class="label label-danger">
                                ${dicts.player.player_status[item.playerStatus]}
                        </span>
                    </c:if>
                    <c:if test="${item.playerStatus=='3'}">
                        <span class="label label-info">
                                ${dicts.player.player_status[item.playerStatus]}
                        </span>
                    </c:if>
                    <c:if test="${item.playerStatus=='4'}">
                        <span class="label label-warning">
                                ${dicts.player.player_status[item.playerStatus]}
                        </span>
                    </c:if>
                </td>
                <td>
                    <shiro:hasPermission name="role:player_edit">
                        <c:if test="${item.playerStatus!='2'}">
                            <a href="/player/getVUserPlayer.html?search.id=${item.id}"
                               nav-target="mainFrame">${views.common['edit']}</a>
                        </c:if>
                        <c:if test="${item.playerStatus=='2'}">
                            <span CLASS="co-gray">${views.common['edit']}</span>
                        </c:if>

                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                    </shiro:hasPermission>
                    <a href="/player/playerView.html?search.id=${item.id}"
                       nav-target="mainFrame">${views.common['detail']}</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>

    </table>
</div>

<soul:pagination/>