<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<!--//region your codes 2-->

    <form:form action="${root}/vSiteApiType/orderApiType.html?search.status=normal" method="post">
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
                        <div class="table-responsive table-min-h">
                            <table class="table table-striped table-hover dataTable dragdd" aria-describedby="editable_info">
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
                                    <td class="td-handle1">${apiTypes[p.apiTypeId.toString()].name}</td>
                                    <td class="td-handle1">${siteApiTypes[p.apiTypeId.toString()].name}</td>
                                    <td class="td-handle1">
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
                                        <%--
                                        <c:if test="${not empty siteApiTypes[p.id.toString()].cover}">
                                            <img id="cover${p.id}" src="${soulFn:getThumbPath(domain, siteApiTypes[p.id.toString()].cover,500,500)}" class="logo-size-h100" style="margin: 10px 0; width: auto;height: 24px;"/>
                                        </c:if>--%>
                                    </td>
                                    <td class="td-handle1">${p.apiCount}</td>
                                    <td class="td-handle1">${p.playerCount}</td>
                                    <td class="td-handle1">
                                        <c:if test="${p.status=='normal'}">
                                            <span class="label label-success">${views.setting['status.normal']}</span>
                                        </c:if>
                                        <c:if test="${p.status=='disable'}">
                                            <span class="label label-danger">${views.setting['status.disable']}</span>
                                        </c:if>
                                    </td>
                                    <td class="td-handle1">
                                        <div class="joy-list-row-operations">
                                                ${views.common['edit']}
                                            <span class="dividing-line m-r-xs m-l-xs">|</span>
                                                ${views.common['manage']}
                                            <span class="dividing-line m-r-xs m-l-xs">|</span>
                                                ${views.content['vSiteApi.record']}

                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        </div>
                    </div>
                    <div class="operate-btn" style="text-align: center">
                        <soul:button target="saveApiTypeOrder" text="${views.common['OK']}" opType="function"
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
<soul:import res="site/content/gameManage/apiType/OrderApiType"/>
<!--//endregion your codes 4-->

<!--//endregion your codes 1-->
