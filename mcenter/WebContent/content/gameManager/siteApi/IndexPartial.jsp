<%@ page import="so.wwb.gamebox.model.company.site.po.VSiteApiTypeRelation" %>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
        <c:set var="poType" value="<%= VSiteApiTypeRelation.class %>"></c:set>
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.column['VSiteApi.orderNum']}</th>
            <th>${views.column['VSiteApi.defaultName']}</th>
            <th>${views.column['VSiteApi.apiName']}</th>
            <%--<th>${views.column['VSiteApi.cover']}</th>--%>
            <th>${views.column['VSiteApi.gameCount']}</th>
            <th>${views.column['VSiteApi.playerCount']}</th>
            <th>${views.column['VSiteApi.status']}</th>
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
                    <c:if test="${p.apiStatus=='disable'}">
                        --
                    </c:if>
                    <c:if test="${p.apiStatus=='normal'}">
                        <c:if test="${p.status=='normal'}">
                            ${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}
                        </c:if>
                        <c:if test="${p.status=='disable'}">
                            --
                        </c:if>
                    </c:if>
                </td>
                <td>${gbFn:getApiName(p.apiId).toString()}</td>
                <td>${gbFn:getSiteApiNameByApiType(p.apiTypeId,p.apiId,p.siteId).toString()}</td>
                <%--<td>
                    <c:if test="${not empty siteApiI18ns[p.apiId.toString()].cover}">
                        <soul:button target="previewImg" text="" opType="function" tag="a">
                        <img id="cover${p.apiId}" data-src="${soulFn:getImagePath(domain,siteApiI18ns[p.apiId.toString()].cover)}" src="${soulFn:getThumbPath(domain, siteApiI18ns[p.apiId.toString()].cover,66,24)}"/>
                        </soul:button>
                    </c:if>
                    <c:if test="${empty siteApiI18ns[p.apiId.toString()].cover}">
                        <soul:button target="previewImg" text="" opType="function" tag="a">
                        <img id="cover${p.apiId}" data-src="${soulFn:getImagePath(domain,apiI18ns[p.apiId.toString()].cover)}" src="${soulFn:getThumbPath(domain, apiI18ns[p.apiId.toString()].cover,66,24)}"/>
                        </soul:button>
                    </c:if>
                </td>--%>
                <td>${p.gameCount}</td>
                <td>${p.playerCount}</td>
                <td>
                    <c:if test="${p.apiStatus=='normal'}">
                        <c:if test="${p.status=='normal'}">
                            <c:if test="${p.systemStatus=='normal'}">
                                <span class="label label-success">${dicts.game.status['normal']}</span>
                            </c:if>
                            <c:if test="${p.systemStatus=='pre_maintain'}">
                                <span class="label label-success">${dicts.game.status['normal']}</span>
                                ${soulFn:formatDateTz(p.maintainStartTime, DateFormat.DAY_SECOND,timeZone)}
                                ${views.content['game.inToMaintain']}
                            </c:if>
                            <c:if test="${p.systemStatus=='maintain'}">
                                <span class="label label-warning">${dicts.game.status['maintain']}</span>
                                ${soulFn:formatDateTz(p.maintainEndTime, DateFormat.DAY_SECOND,timeZone)}
                                ${views.content['game.endOfMaintain']}
                            </c:if>
                        </c:if>
                        <c:if test="${p.status=='disable'}">
                            <span class="label label-danger">${dicts.game.status['disable']}</span>
                        </c:if>
                    </c:if>
                    <c:if test="${p.apiStatus=='disable'}">
                        <span class="label label-danger">${dicts.game.status['disable']}</span>
                    </c:if>

                </td>
                <td>
                    <div class="joy-list-row-operations">
                        <soul:button target="${root}/siteApiTypeRelationI18n/edit.html?id=${p.id}&search.relationId=${p.id}&siteApi.apiId=${p.apiId}" title="${views.common['edit']} API" text="${views.common['edit']}" opType="dialog" callback="callBackQuery"/>
                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                        <a href="/vSiteGame/list.html?search.apiId=${p.apiId}&search.apiTypeId=${p.apiTypeId}" nav-target="mainFrame">${views.common['manage']}</a>
                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                        <soul:button target="toSiteApiRecord" text="${views.content['vSiteApi.record']}" opType="function" siteApiId="${p.apiId}"/>
                        <%--<span class="dividing-line m-r-xs m-l-xs">|</span>
                        <a href="javascript:void(0)">${views.content['vSiteApi.report']}</a>--%>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination/>
<!--//endregion your codes 1-->
