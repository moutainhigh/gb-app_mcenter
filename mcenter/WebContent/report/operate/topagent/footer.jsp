<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.OperatePlayerListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="col-lg-12">
    <div class="wrapper white-bg shadow">
        <div class="p-sm b-title-black">
            <h2 class="pull-left m-b-none m-t-none">
                <c:choose>
                    <c:when test="${command.sites.size() > 0}">
                        ${views.report['operate.list.site']}<span class="co-blue">${gbFn:getSiteName(command.site.id)}</span>
                    </c:when>
                    <c:otherwise>
                        ${views.report['operate.list.gather']}
                    </c:otherwise>
                </c:choose>
            </h2>
            <span class="co-grayc2 m-l">${soulFn:formatDateTz(startDate, DateFormat.DAY, timeZone)} ~ ${soulFn:formatDateTz(endDate, DateFormat.DAY, timeZone)}</span>
            <div class="pull-right m-t-n-xxs" style="margin-top: -8px">
                <soul:button tag="button" cssClass="btn btn-export-btn btn-primary-hide" callback="gotoExportHistory"
                             text="${views.report['fund.list.export']}" precall="validExportCount" title="${views.report['fund.list.export']}" post="getCurrentFormData"
                             target="${root}/report/operate/exportRecords.html?result.siteId=${command.search.siteId}" opType="ajax">
                    <i class="fa fa-sign-out"></i><span class="hd">${views.report['operate.list.export']}</span>
                </soul:button>
                <c:if test="${command.sites.size() > 0}">
                    &nbsp;<soul:button target="query" opType="function" precall="prevSite" cssClass="btn btn-primary-hide pull-right" text="${views.report['operate.list.prev']}" />
                </c:if>
                <input type="hidden" value="${conditionJson}" id="conditionJson">
                <input type="hidden" value="${subSysCode}" id="subSysCode">
            </div>
            <div class="search-params-div hide"></div>
        </div>
        <div class="dataTables_wrapper" role="grid">
            <div class="panel-body">
                <div class="tab-content">
                    <div class="table-responsive">
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
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <c:if test="${sameDay}">
                                    <td>
                                        <c:if test="${command.topagent.playerNum>0}">
                                            <soul:button target="topagentShowPlayer" text="${soulFn:formatNumber(command.topagent.playerNum)}" opType="function">
                                                ${soulFn:formatNumber(command.topagent.playerNum)}
                                            </soul:button>

                                        </c:if>
                                        <c:if test="${empty command.topagent.playerNum || command.topagent.playerNum<=0}">
                                            ${soulFn:formatNumber(command.topagent.playerNum)}
                                        </c:if>
                                    </td>
                                </c:if>
                                <td>${soulFn:formatNumber(command.topagent.transactionOrder)}</td>
                                <td>${soulFn:formatCurrency(command.topagent.transactionVolume)}</td>
                                <td>${soulFn:formatCurrency(command.topagent.effectiveTransaction)}</td>
                                <td>${soulFn:formatCurrency(command.topagent.profitLoss)}</td>
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
                                <th>${views.report['operate.detail.account.topagent']}</th>
                                <th>${views.report['operate.list.playerNum']}</th>
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
                                    <input type="hidden" name="topAgentId" value="${res.topagentId}"/>
                                    <td><soul:button target="query" opType="function" precall="detailTopAgent" text="${res.topagentName}" /></td>
                                    <td>${soulFn:formatNumber(res.playerNum)}</td>
                                    <td>${soulFn:formatNumber(res.transactionOrder)}</td>
                                    <td>${soulFn:formatCurrency(res.transactionVolume)}</td>
                                    <td>${soulFn:formatCurrency(res.effectiveTransaction)}</td>
                                    <td>${soulFn:formatCurrency(res.profitLoss)}</td>
                                    <td><soul:button target="query" opType="function" precall="detailTopAgent" text="${views.common['detail']}" /></td>
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
