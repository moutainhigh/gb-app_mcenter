<%--@elvariable id="command" type="so.wwb.gamebox.model.company.site.vo.VSiteGameListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<!--//region your codes 2-->
<form:form action="" method="post">
    <div class="row">

        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>棋牌</span><span>/</span><span>${views.sysResource['游戏管理']}</span>
            <soul:button target="goToLastPage" refresh="true"
                         cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text=""
                         opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>
        <form:hidden path="validateRule"/>
        <input type="hidden" name="siteId" value="${siteId}">
        <input type="hidden" name="search.apiTypeId" value="${command.search.apiTypeId}">
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="clearfix filter-wraper border-b-1">
                    <div class=" clearfix m-sm">
                        <i class="fa fa-exclamation-circle"></i><span
                            class="co-yellow m-l-sm">${views.common['DynamicLie.draggingSort']}</span>
                    </div>
                </div>
                <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                    <table class="table table-striped table-hover dataTable m-b-sm dragdd"
                           aria-describedby="editable_info">
                        <thead>
                        <tr role="row" class="bg-gray">
                            <th>${views.column['VSiteGame.orderNum']}</th>
                            <th>游戏大厅陈列项</th>
                            <th>图标</th>
                            <th>展示状态</th>
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
                                <input type="hidden" name="gameId" value="${p.id}" class="td-handle1"/>
                                <td class="td-handle1">${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                                <td class="td-handle1">${gbFn:getGameName(p.gameId).toString()}</td>
                                    <%--<td class="td-handle1">${gbFn:getSiteGameName(p.gameId).toString()}</td>--%>
                                <td class="">
                                    <c:if test="${not empty siteGames[p.gameId.toString()].cover}">
                                        <soul:button target="previewImg" text="" opType="function" tag="a">
                                            <img id="cover${p.id}"
                                                 data-src="${soulFn:getImagePath(domain,siteGames[p.gameId.toString()].cover)}"
                                                 src="${soulFn:getThumbPath(domain, siteGames[p.gameId.toString()].cover,66,24)}"/>
                                        </soul:button>
                                    </c:if>
                                    <c:if test="${empty siteGames[p.id.toString()].cover}">
                                        <soul:button target="previewImg" text="" opType="function" tag="a">
                                            <img data-src="${soulFn:getImagePath(domain,apis[p.gameId.toString()].cover)}"
                                                 src="${soulFn:getThumbPath(domain, apis[p.gameId.toString()].cover,66,24)}"/>
                                        </soul:button>
                                    </c:if>
                                </td>

                                <td class="td-handle1">
                                    <c:if test="${p.status=='normal'}">
                                        <span class="label label-success">${views.setting['status.normal']}</span>
                                    </c:if>
                                    <c:if test="${p.status=='maintain'}">
                                        <span class="label label-warning">${views.setting['status.maintain']}</span>
                                    </c:if>
                                    <c:if test="${p.status=='disable'}">
                                        <span class="label label-danger">${views.setting['status.disable']}</span>
                                    </c:if>

                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="operate-btn" style="text-align: center">
                    <soul:button target="saveSiteGameOrder" text="${views.common['OK']}" opType="function"
                                 cssClass="btn btn-filter btn-lg m-r">${views.common['OK']}</soul:button>
                    <soul:button target="goToLastPage" text="${views.common['cancel']}" opType="function"
                                 cssClass="btn btn-outline btn-filter btn-lg m-r">${views.common['cancel']}</soul:button>
                </div>
            </div>
        </div>

    </div>
</form:form>
<!--//endregion your codes 2-->
<!--//region your codes 3-->
<!--//region your codes 4-->
<soul:import res="site/chess/gameManager/OrderSiteGame"/>
<!--//endregion your codes 4-->

<!--//endregion your codes 1-->
