<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<!--//region your codes 2-->
<form:form action="${root}/vSiteApiTypeRelation/orderSiteApi.html?search.status=normal" method="post">
<div class="row">

    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['内容']}</span><span>/</span><span>${views.sysResource['游戏管理']}</span>
        <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
    </div>


        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">

                <div class="clearfix filter-wraper border-b-1">
                    <div class=" clearfix m-sm">
                        <i class="fa fa-exclamation-circle"></i><span class="co-yellow m-l-sm">${views.common['DynamicLie.draggingSort']}</span>
                    </div>
                </div>
                <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                    <table class="table table-striped table-hover dataTable m-b-sm dragdd" aria-describedby="editable_info">
                        <thead>
                        <tr role="row" class="bg-gray">
                            <th>${views.column['VSiteApi.orderNum']}</th>
                            <th>${views.column['VSiteApi.defaultName']}</th>
                            <th>${views.column['VSiteApi.apiName']}</th>
                            <th>${views.column['VSiteApi.cover']}</th>
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
                        <tbody class="dd-list1">
                        <c:if test="${empty command.result}">
                            <td colspan="7" class="no-content_wrap">
                                <div>
                                    <i class="fa fa-exclamation-circle"></i> ${views.common['noResult']}
                                </div>
                            </td>
                        </c:if>
                        <c:forEach items="${command.result}" var="p" varStatus="status">
                            <tr class="tab-detail dd-item1">
                                <input type="hidden" name="apiTypeId" value="${p.id}" class="td-handle1"/>
                                <td class="td-handle1">${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                                <td class="td-handle1">${gbFn:getApiName(p.apiId).toString()}</td>
                                <td class="td-handle1">${gbFn:getSiteApiNameByApiType(p.apiTypeId,p.apiId ,p.siteId ).toString()}</td>
                                <td class="">
                                    <c:if test="${not empty siteApiI18ns[p.apiId.toString()].cover}">
                                        <soul:button target="previewImg" text="" opType="function" tag="a">
                                            <img id="cover${p.apiId}" data-src="${soulFn:getImagePath(domain,siteApiI18ns[p.apiId.toString()].cover)}" src="${soulFn:getThumbPath(domain, siteApiI18ns[p.apiId.toString()].cover,66,24)}"/>
                                        </soul:button>
                                    </c:if>
                                    <c:if test="${empty siteApiI18ns[p.apiId.toString()].cover}">
                                        <soul:button target="previewImg" text="" opType="function" tag="a">
                                            <img id="cover${p.apiId}" data-src="${soulFn:getImagePath(domain,apiI18ns[p.apiId.toString()].cover)}" src="${soulFn:getThumbPath(domain, apiI18ns[p.apiId.toString()].cover,66,24)}"/>
                                        </soul:button>
                                        <%--<img id="cover${p.apiId}" src="${root}/static/mcenter/images//def.png" width="66" height="24">--%>
                                    </c:if>
                                </td>
                                <td class="td-handle1">${p.gameCount}</td>
                                <td class="td-handle1">${p.playerCount}</td>
                                <td class="td-handle1">
                                    <c:if test="${p.apiStatus=='normal'}">
                                        <c:if test="${p.status=='normal'}">
                                            <c:if test="${p.systemStatus=='normal'}">
                                                <span class="label label-success">${dicts.game.status['normal']}</span>
                                            </c:if>
                                            <c:if test="${p.systemStatus=='pre_maintain'}">
                                                <span class="label label-success">${dicts.game.status['normal']}</span>
                                                <br />
                                                ${soulFn:formatDateTz(p.maintainStartTime, DateFormat.DAY_SECOND,timeZone)}
                                                ${views.content['后进入维护']}
                                            </c:if>
                                            <c:if test="${p.systemStatus=='maintain'}">
                                                <span class="label label-warning">${dicts.game.status['maintain']}</span>
                                                <br />
                                                ${soulFn:formatDateTz(p.maintainEndTime, DateFormat.DAY_SECOND,timeZone)}
                                                ${views.content['后维护结束']}
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
                                <td class="td-handle1">
                                    <div class="joy-list-row-operations">
                                            ${views.common['edit']}
                                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                                            ${views.common['manage']}
                                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                                            ${views.content['vSiteApi.record']}
                                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                                            ${views.content['vSiteApi.report']}
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="operate-btn" style="text-align: center">
                    <soul:button target="saveSiteApiOrder" text="${views.common['OK']}" opType="function"
                                 cssClass="btn btn-filter btn-lg m-r" >${views.common['OK']}</soul:button>
                    <soul:button target="goToLastPage" text="${views.common['cancel']}" opType="function"
                                 cssClass="btn btn-outline btn-filter btn-lg m-r" >${views.common['cancel']}</soul:button>
                </div>
            </div>
        </div>

</div>
</form:form>
<!--//endregion your codes 2-->


<!--//region your codes 3-->
<!--//region your codes 4-->
<soul:import res="site/content/gameManage/siteApi/OrderSiteApi"/>
<!--//endregion your codes 4-->

<!--//endregion your codes 1-->
