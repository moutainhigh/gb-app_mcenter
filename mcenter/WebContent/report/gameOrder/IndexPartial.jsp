<%--@elvariable id="command" type="so.wwb.gamebox.model.site.report.vo.VPlayerGameOrderListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="so.wwb.gamebox.model.site.report.po.VPlayerGameOrder" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= VPlayerGameOrder.class %>" />
<input type="hidden" name="search.searchCondition" value="${command.search.searchCondition}"/>
<input type="hidden" name="search.beginWinningAmount" value="${command.search.beginWinningAmount}"/>
<input type="hidden" name="outer" value="${command.outer}">
<input type="hidden" name="listFlag" value="${listFlag}"/>
<div class="sys_tab_wrap clearfix">
    <div class="m-sm">
        <b>${views.report_auto['已选']}：</b><span class="co-yellow" id="selectGame">${messages.report['operate.list.all']}</span>
        <div class="pull-right m-t-n-xxs">
            <soul:button cssClass="btn btn-outline btn-filter m-r-sm btn-total" text="${views.column['VPlayerGameOrder.tjsj']}" opType="function" target="staticData"/>
            <soul:button permission="report:betorder_export" tag="button" cssClass="btn btn-export-btn btn-primary-hide" post="getCurrentFormData" callback="gotoExportHistory"
                         text="${views.column['VPlayerGameOrder.dcsj']}" precall="validExportCount" title="${views.column['VPlayerGameOrder.dcsj']}"
                         target="${root}/report/gameTransaction/exportRecords.html?result.siteId=${command.search.siteId}" opType="ajax">
                <i class="fa fa-sign-out"></i><span class="hd">${views.column['VPlayerGameOrder.dcsj']}</span>
            </soul:button>
        </div>
    </div>
</div>
<div style="display: none;" class="p-sm con-total"></div>
<c:if test="${listFlag}">

</c:if>
<div class="table-responsive table-min-h">
    <input type="hidden" value="${conditionJson}" id="conditionJson">
    <div class="search-params-div hide"></div>
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.common['number']}</th>
            <th>${views.column['VUserPlayerGameOrder.username']}</th>
            <th style="padding-left: 30px;">${views.column['VPlayerGameOrder.orderNo']}</th>
            <th>${views.column['PlayerApi.apiName']}</th>
            <%--<th>${views.column['userAgent.funds.type.rebateDetail.order.description']}</th>--%>
            <th>${views.column['VPlayerGameOrder.createTime']}</th>
            <soul:orderColumn poType="${poType}" property="singleAmount" column="${views.column['PlayerApiOrder.tranaction']}"/>
            <soul:orderColumn poType="${poType}" property="effectiveTradeAmount" column="${views.column['RakebackGrads.validValue']}"/>
            <soul:orderColumn poType="${poType}" property="profitAmount" column="${views.column['VPlayerGameOrder.payout']}"/>
            <th>${views.column['VPlayerGameOrder.status']}</th>
            <th>${views.column['VPlayerGameOrder.operation']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr>
                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                <td class="co-blue">
                    <shiro:hasPermission name="role:player_detail"><a href="/player/playerView.html?search.id=${p.playerId}" nav-target="mainFrame"></shiro:hasPermission>
                    ${p.username}
                    <shiro:hasPermission name="role:player_detail"></a></shiro:hasPermission>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${p.terminal eq '2'}">
                            <span class="fa fa-mobile mobile" data-content="${views.report_auto['手机投注']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span style="width:8px; display: inline-block"></span>
                        </c:otherwise>
                    </c:choose>&nbsp;
                        ${p.betId}
                </td>
                <c:set value="${gbFn:getApiName(p.apiId.toString())}" var="apiName"/>
                <c:set value="${gbFn:getSiteApiName(p.apiId.toString())}" var="siteApiName"/>
                <c:set value="${gbFn:getSiteGameName(p.gameId.toString())}" var="siteGameName"/>
                <c:set value="${gbFn:getGameName(p.gameId.toString())}" var="gameName"/>

                <td>${empty siteApiName?apiName:siteApiName}<br>${empty siteGameName?gameName:siteGameName}</td>
                    <%-- <td></td>--%>
                <td>${soulFn:formatDateTz(p.betTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    <%--<td>${soulFn:formatDateTz(p.payoutTime, DateFormat.DAY_SECOND,timeZone)}</td>--%>
                <td>${soulFn:formatCurrency(p.singleAmount)}</td>
                <td>${empty p.effectiveTradeAmount?'--':soulFn:formatCurrency(p.effectiveTradeAmount)}</td>
                    <%-- <td><span class="co-red3">${p.resultJson}庄</span>(4),<span class="co-blue3">${views.report_auto['闲']}</span>(9)</td>--%>

                <c:choose>
                    <c:when test="${p.profitAmount gt 0}">
                        <td class="co-green">+${soulFn:formatCurrency(p.profitAmount)}</td>
                    </c:when>
                    <c:otherwise>
                        <td class="co-red3">${soulFn:formatCurrency(p.profitAmount)}</td>
                    </c:otherwise>
                </c:choose>
                <c:if test="${p.orderState=='settle'}">
                    <td><span class="label label-success">${dicts.player.order[p.orderState]}</span></td>
                </c:if>
                <c:if test="${p.orderState=='pending_settle'}">
                    <td><span class="label label-orange">${dicts.player.order[p.orderState]}</span></td>
                </c:if>
                <c:if test="${p.orderState=='cancel'}">
                    <td><span class="label label-danger">${dicts.player.order[p.orderState]}</span></td>
                </c:if>
                <td><a href="/report/gameTransaction/Details.html?search.id=${p.id}" nav-target="mainFrame">${views.report_auto['详细']}</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination/>