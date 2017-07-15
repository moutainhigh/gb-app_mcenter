<%@ page import="so.wwb.gamebox.model.company.site.po.VSiteApiType" %>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
        <c:set var="poType" value="<%= VSiteApiType.class %>"></c:set>
        <thead>
        <tr role="row" class="bg-gray">
            <th width="60">${views.column['VSiteApiType.orderNum']}</th>
            <th>${views.column['VSiteApiType.defaultName']}</th>
            <th>${views.column['VSiteApiType.customerName']}</th>
            <th>${views.column['VSiteApiType.cover']}</th>
            <th>${views.column['VSiteApiType.apiCount']}</th>
            <th>${views.column['VSiteApiType.playerCount']}</th>
            <th>${views.column['VSiteApiType.status']}</th>
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
                    <c:if test="${p.status=='normal'}">
                        ${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}
                    </c:if>
                    <c:if test="${p.status=='disable'}">
                        --
                    </c:if>

                </td>
                <td>
                    ${apiTypes[p.apiTypeId.toString()].name}
                </td>
                <td>
                    ${siteApiTypes[p.apiTypeId.toString()].name}
                </td>
                <td>
                    <c:if test="${not empty siteApiTypes[p.apiTypeId.toString()].cover}">
                        <soul:button target="previewImg" text="" opType="function" tag="a">
                            <img id="cover${p.apiTypeId}" data-src="${soulFn:getImagePath(domain,siteApiTypes[p.apiTypeId.toString()].cover)}"
                                 src="${soulFn:getThumbPath(domain, siteApiTypes[p.apiTypeId.toString()].cover,66,24)}"/>
                        </soul:button>
                    </c:if>
                    <c:if test="${empty siteApiTypes[p.apiTypeId.toString()].cover}">
                        <soul:button target="previewImg" text="" opType="function" tag="a">
                        <img id="cover${p.apiTypeId}" data-src="${soulFn:getImagePath(domain,apiTypes[p.apiTypeId.toString()].cover)}"
                             src="${soulFn:getThumbPath(domain, apiTypes[p.apiTypeId.toString()].cover,66,24)}"/>
                        </soul:button>
                    </c:if>

                </td>
                <td>${p.apiCount}</td>
                <td>${p.playerCount}</td>
                <td>
                    <c:if test="${p.status=='normal'}">
                        <span class="label label-success">${dicts.game.status[p.status]}</span>
                    </c:if>
                    <c:if test="${p.status=='disable'}">
                        <span class="label label-danger">${dicts.game.status[p.status]}</span>
                    </c:if>
                </td>
                <td>
                    <div class="joy-list-row-operations">
                        <soul:button target="${root}/siteApiTypeI18n/edit.html?id=${p.id}&search.apiTypeId=${p.apiTypeId}&siteApiTypeId=${p.apiTypeId}" title="${views.content['game.editApiType']}" text="${views.common['edit']}" opType="dialog" callback="callBackQuery"/>
                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                        <a href="/vSiteApiTypeRelation/list.html?search.apiTypeId=${p.apiTypeId}" nav-target="mainFrame">${views.common['manage']}</a>
                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                        <a href="/report/operate/operateIndex.html?search.apiTypeId=${p.apiTypeId}&outer=7" nav-target="mainFrame">${views.content['vSiteApi.record']}</a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>


<soul:pagination/>
<!--//endregion your codes 1-->
