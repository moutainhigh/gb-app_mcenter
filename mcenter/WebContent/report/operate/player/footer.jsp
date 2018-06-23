<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.OperatePlayerListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="col-lg-12">
    <div class="wrapper white-bg shadow">
        <div class="p-sm b-title-black">
            <h2 class="pull-left m-b-none m-t-none">
                <c:choose>
                    <c:when test="${command.sites.size() > 0}">
                        ${views.report['operate.list.site']}<span class="co-blue">${gbFn:getSiteName(command.site.id)}</span> -
                        ${views.report['operate.search.account.topagent']}<span class="co-blue">${command.userTop.username}</span> -
                        ${views.report['operate.search.account.agent']}<span class="co-blue">${command.userAgent.username}</span>
                    </c:when>
                    <c:otherwise>
                        ${views.report['operate.search.account.topagent']}
                        <span class="co-blue">
                            <c:if test="${not empty command.userTop.username}">${command.userTop.username}</c:if>
                            <c:if test="${empty command.userTop.username && command.result.size() > 0 && not empty command.result.get(0)}">
                                ${command.result.get(0).topagentName}
                            </c:if>
                        </span> -
			            ${views.report['operate.search.account.agent']}
                        <span class="co-blue">
                            <c:if test="${not empty command.userAgent.username}">${command.userAgent.username}</c:if>
                            <c:if test="${empty command.userAgent.username && command.result.size() > 0 && not empty command.result.get(0)}">
                                ${command.result.get(0).agentName}
                            </c:if>
                        </span>
                    </c:otherwise>
                </c:choose>
            </h2>
            <span class="co-grayc2 m-l">${soulFn:formatDateTz(startDate, DateFormat.DAY, timeZone)} ~ ${soulFn:formatDateTz(endDate, DateFormat.DAY, timeZone)}</span>
            <div class="pull-right m-t-n-xxs" style="margin-top: -8px">
                <soul:button tag="button" cssClass="btn btn-export-btn btn-primary-hide" callback="gotoExportHistory" post="getCurrentFormData"
                             text="${views.report['fund.list.export']}" precall="validExportCount" title="${views.report['fund.list.export']}"
                             target="${root}/report/operate/exportRecords.html?result.siteId=${command.search.siteId}" opType="ajax">
                    <i class="fa fa-sign-out"></i><span class="hd">${views.report['operate.list.export']}</span>
                </soul:button>
                &nbsp;
                <soul:button target="query" opType="function" precall="prevAgent" cssClass="btn btn-primary-hide pull-right" text="${views.report['operate.list.prev']}" />
                <input type="hidden" value="${conditionJson}" id="conditionJson">
                <input type="hidden" value="${subSysCode}" id="subSysCode">
            </div>
            <div class="search-params-div hide"></div>
        </div>
        <div class="dataTables_wrapper" role="grid">
            <div class="panel-body">
                <div class="tab-content">
                    <div class="table-responsive">
                        <c:set var="hasSubAgent" value="hidden"></c:set>
                        <c:if test="${command.canAddSubAgent}">
                            <c:set var="hasSubAgent" value=""></c:set>
                        </c:if>
                        <input type="hidden" id="agentId" value="${command.search.agentId}">
                        <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
                            <thead>
                            <tr class="bg-gray">
                                <th colspan="9">
                                    <span class="pull-left">${views.report['operate.list.info']}</span>
                                </th>
                            </tr>
                            <tr>
                                <c:if test="${sameDay}"><th>${views.report['operate.list.playerNum']}</th></c:if>
                                <th>${views.report['operate.list.price']}</th>
                                <th>${views.report['operate.list.orderprice']}</th>
                                <th>${views.report['operate.list.effePrice']}</th>
                                <th>${views.report['operate.list.prosfit']}</th>
                                <th class="${hasSubAgent}">
                                    ${views.report['下级代理数']}
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <c:if test="${sameDay}"><td>${soulFn:formatNumber(command.player.playerNum)}</td></c:if>
                                <td>${soulFn:formatNumber(command.player.transactionOrder)}</td>
                                <td>${soulFn:formatCurrency(command.player.transactionVolume)}</td>
                                <td>${soulFn:formatCurrency(command.player.effectiveTransaction)}</td>
                                <td>${soulFn:formatCurrency(command.player.profitLoss)}</td>
                                <td class="${hasSubAgent}">
                                    <c:choose>
                                        <c:when test="${command.agentNum > 0}">
                                            <a href="/report/operate/subAgentDetail.html?search.startDate=${command.search.startDate}&search.endDate=${command.search.endDate}&search.agentId=${command.search.agentId}" nav-target="mainFrame">
                                                    ${command.agentNum}
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            0
                                        </c:otherwise>
                                    </c:choose>

                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="col-lg-12 m-t">
    <div class="wrapper white-bg clearfix shadow">
        <div class="dataTables_wrapper" role="grid">
            <div class="panel-body">
                <div class="tab-content">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
                            <thead>
                            <tr class="bg-gray">
                                <th colspan="7">
                                    <span class="pull-left">${views.report['operate.detail.info']}</span>
                                </th>
                            </tr>
                            <tr>
                                <th>${views.report['operate.detail.account.player']}</th>
                                <th>${views.report['operate.list.price']}</th>
                                <th>${views.report['operate.list.orderprice']}</th>
                                <th>${views.report['operate.list.effePrice']}</th>
                                <th>${views.report['operate.list.prosfit']}</th>
                                <th>${views.common['operate']}</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="res" items="${command.result}">
                                <tr>
                                    <c:set var="url" value="/report/gameTransaction/list.html?isLink=true&search.outer=7&search.siteId=${command.search.siteId}&search.username=${res.playerName}&search.searchCondition=true&search.payoutStart=${command.search.startDate}&search.payoutEnd=${command.search.endDate}&search.apiTypeList=${command.search.apiTypeList}&search.orderState=settle"/>
                                    <td>
                                        <soul:button target="${root}/report/gameOrderLinkPopup/gameTransaction.html?linkType=byOperate&search.siteId=${command.search.siteId}&search.username=${res.playerName}&search.payoutStart=${command.search.startDate}&search.payoutEnd=${command.search.endDate}&search.orderState=settle&search.topagentid=${command.userTop.id}&search.agentid=${command.userAgent.id}&${searchApiCondition}" size="open-dialog-95p"
                                                     callback="" text="" title="投注记录" opType="dialog">${res.playerName}
                                        </soul:button>
                                        ${gbFn:riskImgByName(res.playerName)}
                                    </td>
                                    <td>${soulFn:formatNumber(res.transactionOrder)}</td>
                                    <td>${soulFn:formatCurrency(res.transactionVolume)}</td>
                                    <td>${soulFn:formatCurrency(res.effectiveTransaction)}</td>
                                    <td>${soulFn:formatCurrency(res.profitLoss)}</td>
                                    <td>
                                        <soul:button target="${root}/report/gameOrderLinkPopup/gameTransaction.html?linkType=byOperate&search.siteId=${command.search.siteId}&search.username=${res.playerName}&search.payoutStart=${command.search.startDate}&search.payoutEnd=${command.search.endDate}&search.orderState=settle&search.topagentid=${command.userTop.id}&search.agentid=${command.userAgent.id}&${searchApiCondition}" size="open-dialog-95p"
                                                     callback="" text="" title="投注记录" opType="dialog">${views.common['detail']}
                                        </soul:button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <soul:pagination/>
        </div>
    </div>
</div>