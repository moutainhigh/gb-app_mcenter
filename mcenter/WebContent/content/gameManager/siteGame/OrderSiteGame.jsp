<%--@elvariable id="command" type="so.wwb.gamebox.model.company.site.vo.VSiteGameListVo"--%>
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


            <form:hidden path="validateRule" />
            <div class="col-lg-12">
                <div class="wrapper white-bg shadow">
                    <div class="clearfix game_img">
                        <div class="con clearfix">
                            <div class="col-md-6 m-t-md m-b-md">
                                <div class="pull-left m-r-sm" style="border: 1px solid #e5e7ec">
                                    <c:if test="${not empty siteApis[command.siteApi.apiId.toString()].cover}">
                                        <soul:button target="previewImg" text="" opType="function" tag="a">
                                            <img data-src="${soulFn:getImagePath(domain,siteApis[command.siteApi.apiId.toString()].cover)}" src="${soulFn:getThumbPath(domain, siteApis[command.siteApi.apiId.toString()].cover,144,72)}"/>
                                        </soul:button>
                                    </c:if>
                                    <c:if test="${empty siteApis[command.siteApi.apiId.toString()].cover}">
                                        <soul:button target="previewImg" text="" opType="function" tag="a">
                                            <img data-src="${soulFn:getImagePath(domain,apis[command.siteApi.apiId.toString()].cover)}" src="${soulFn:getThumbPath(domain, apis[command.siteApi.apiId.toString()].cover,144,72)}"/>
                                        </soul:button>
                                    </c:if>
                                </div>
                                <%--<div class="img pull-left m-r-sm">
                                    <c:if test="${not empty siteApis[command.siteApi.id.toString()].cover}">
                                        <img src="${soulFn:getThumbPath(domain, siteApis[command.siteApi.id.toString()].cover,500,500)}" style="height:72px;width: 144px;"/>
                                    </c:if>
                                    <c:if test="${empty siteApis[command.siteApi.id.toString()].cover}">
                                        <img src="${soulFn:getThumbPath(domain, apis[command.siteApi.id.toString()].cover,144,72)}"/>
                                    </c:if>
                                </div>--%>
                                <b class="title">${gbFn:getSiteApiNameByApiType(command.search.apiTypeId, command.siteApi.apiId,command.siteApi.siteId ).toString()}
                                    <span class="label ${command.siteApi.systemStatus=='disable'?'label-danger':command.siteApi.systemStatus=='normal'?'label-success':'label-warning'} m-l-sm">${dicts.game.status[command.siteApi.systemStatus]}</span></b>
                                <div class="m-t-sm">
                                    <a href="javascript:void(0)" class="btn btn-outline btn-filter">${views.content['强制踢出']}</a>
                                    <a href="javascript:void(0)" class="btn btn-outline btn-filter">${views.content['回收资金']}</a>
                                </div>
                            </div>
                            <div class="col-md-3 m-t-md m-b-md">
                                <div class="indicators-item blue al-center clearfix" style="border: 1px solid #e6e6e6;">
                                    <div class="bold-fs16 p-t-xxs co-gray6">
                                            ${views.content['当前游戏总余额']}<span class="tip-fs14 m-l-xs"><a href="javascript:void(0)" class="ico-lock">
                                        <%--<i class="fa fa-refresh"></i>--%>
                                    </a></span></div>
                                    <div class="fs24 p-b-xs al-center">${soulFn:formatCurrency(command.apiBalance) }</div>
                                </div>
                            </div>
                            <div class="col-md-3 m-t-md m-b-md">
                                <div class="indicators-item blue al-center clearfix" style="border: 1px solid #e6e6e6;">
                                    <div class="bold-fs16 p-t-xxs co-gray6">${views.content['昨日玩家']}</div>
                                    <div class="fs24 p-b-xs al-center">${command.yesterdayPlayerCount}</div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="clearfix filter-wraper border-b-1">
                        <div class=" clearfix m-sm">
                            <i class="fa fa-exclamation-circle"></i><span class="co-yellow m-l-sm">${views.common['DynamicLie.draggingSort']}</span>
                        </div>
                    </div>
                    <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                        <table class="table table-striped table-hover dataTable m-b-sm dragdd" aria-describedby="editable_info">
                            <thead>
                            <tr role="row" class="bg-gray">
                                <th width="60">${views.column['VSiteGame.orderNum']}</th>
                                <th>${views.column['VSiteGame.defaultName']}</th>
                                <th>${views.column['VSiteGame.customerName']}</th>
                                <th>${views.column['VSiteGame.supportTerminal']}</th>
                                <th>${views.column['VSiteGame.canTry']}</th>
                                <th>${views.column['VSiteGame.cover']}</th>
                                <th>${views.column['SiteGameI18n.backupCover']}</th>
                                <th>${views.column['VSiteGame.tagCount']}</th>
                                <th>${views.column['VSiteGame.playerCount']}</th>
                                <th>${views.column['VSiteGame.yesterdayCount']}</th>
                                <th>${views.column['VSiteGame.status']}</th>
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
                                    <input type="hidden" name="gameId" value="${p.id}" class="td-handle1"/>
                                    <td class="td-handle1">${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                                    <td class="td-handle1">${gbFn:getGameName(p.gameId).toString()}</td>
                                    <td class="td-handle1">${gbFn:getSiteGameName(p.gameId).toString()}</td>
                                    <td>${empty p.supportTerminal?"--":p.supportTerminal}</td>
                                    <td>
                                        <c:if test="${p.canTry}">${views.content['game.support']}</c:if>
                                        <c:if test="${!p.canTry}">${views.content['game.notSupport']}</c:if>

                                    </td>
                                    <td class="">
                                        <c:if test="${not empty siteGames[p.gameId.toString()].cover}">
                                            <soul:button target="previewImg" text="" opType="function" tag="a">
                                            <img id="cover${p.id}" data-src="${soulFn:getImagePath(domain,siteGames[p.gameId.toString()].cover)}" src="${soulFn:getThumbPath(domain, siteGames[p.gameId.toString()].cover,66,24)}"/>
                                            </soul:button>
                                        </c:if>
                                        <c:if test="${empty siteGames[p.id.toString()].cover}">
                                            <soul:button target="previewImg" text="" opType="function" tag="a">
                                            <img data-src="${soulFn:getImagePath(domain,apis[p.gameId.toString()].cover)}" src="${soulFn:getThumbPath(domain, apis[p.gameId.toString()].cover,66,24)}"/>
                                            </soul:button>
                                        </c:if>
                                    </td>
                                    <td>

                                        <c:if test="${not empty siteGames[p.gameId.toString()].backupCover}">
                                            <soul:button target="previewImg" text="" opType="function" tag="a">
                                                <img id="cover${p.id}" data-src="${soulFn:getImagePath(domain,siteGames[p.gameId.toString()].backupCover)}" src="${soulFn:getThumbPath(domain, siteGames[p.gameId.toString()].backupCover,66,24)}"/>
                                            </soul:button>
                                        </c:if>
                                        <c:if test="${empty siteGames[p.gameId.toString()].backupCover}">
                                            --
                                        </c:if>
                                    </td>
                                    <td>${p.tagCount}</td>
                                    <td class="td-handle1">${p.playerCount}</td>
                                    <td class="td-handle1">${p.yesterdayCount}</td>
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
                                    <td class="td-handle1">
                                        <div class="joy-list-row-operations">
                                                ${views.common['edit']}
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="operate-btn" style="text-align: center">
                        <soul:button target="saveSiteGameOrder" text="${views.common['OK']}" opType="function"
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
<soul:import res="site/content/gameManage/siteGame/OrderSiteGame"/>
<!--//endregion your codes 4-->

<!--//endregion your codes 1-->
