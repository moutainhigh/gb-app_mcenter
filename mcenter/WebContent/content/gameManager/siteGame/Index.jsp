<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<!--//region your codes 2-->
<form:form action="${root}/vSiteGame/list.html?search.apiId=${command.search.apiId}&search.apiTypeId=${command.search.apiTypeId}" method="post">
<div class="row">
    <input type="hidden" name="apiId" id="apiId" value="${command.search.apiId}">
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
                <div class="clearfix filter-wraper border-b-1">
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
                            <b class="title">${gbFn:getSiteApiNameByApiType(command.search.apiTypeId, command.siteApi.apiId, command.siteApi.siteId).toString()}
                                <span class="label ${command.siteApi.systemStatus=='disable'?'label-danger':command.siteApi.systemStatus=='maintain'?'label-warning':'label-success'} m-l-sm">${dicts.game.status[command.siteApi.systemStatus]}</span></b>
                                <%--<a href="/vSiteGame/orderSiteGame.html?search.apiId=${command.search.apiId}&search.gameRealStatus=normal" nav-target="mainFrame" class="m-l-sm">${views.common['order']}</a>--%>
                            <div class="m-t-sm">
                                <soul:button tag="button" target="${root}/vSiteGame/kickoutApiPlayer.html?search.apiId=${command.siteApi.apiId}" confirm="${views.content['game.kickoutConfirm']}"
                                             opType="ajax" text="${views.content['game.kickout']}" cssClass="btn btn-outline btn-filter" callback="myCallBack" >
                                </soul:button>
                                <%--
                                <soul:button tag="button" permission="content:game:withdrawBalance" target="${root}/vSiteGame/withdrawBalance.html?search.apiId=${command.siteApi.apiId}"
                                             confirm="${views.content['game.withdrawConfirm']}" opType="ajax" text="${views.content['game.withdrawBalance']}"
                                             cssClass="btn btn-outline btn-filter withdrawBalance-btn-css ${command.apiBalance==0?'disabled':''}"
                                             callback="myCallBack" >
                                </soul:button>--%>
                            </div>
                        </div>
                        <div class="col-md-3 m-t-md m-b-md">
                            <div class="indicators-item blue al-center clearfix" style="border: 1px solid #e6e6e6;">
                                <div class="bold-fs16 p-t-xxs co-gray6" title="2015-12-19">
                                    ${views.content['game.currentBalance']}
                                    <span class="tip-fs14 m-l-xs"><%--precall="refreshPage" --%>
                                        <soul:button tag="a" target="refreshBalance"
                                                     title="${views.content['game.lastRefreshTime']}：${soulFn:formatDateTz(SESSION_REFRESH_API_BALANCE_TIME, DateFormat.DAY_SECOND,timeZone)}"
                                                     opType="function" text="" cssClass="ico-lock refresh-btn-css" >
                                            <i class="fa fa-refresh"></i>
                                        </soul:button>
                                        <%----%>
                                    </span>
                                </div>
                                <div class="fs24 p-b-xs al-center" id="apiBalance">
                                    ${soulFn:formatCurrency(command.apiBalance) }
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 m-t-md m-b-md">
                            <div class="indicators-item blue al-center clearfix" style="border: 1px solid #e6e6e6;">
                                <div class="bold-fs16 p-t-xxs co-gray6">${views.column['VSiteGame.yesterdayCount']}</div>
                                <div class="fs24 p-b-xs al-center">${command.yesterdayPlayerCount}</div>
                            </div>
                        </div>
                    </div>
                    <div class="search-wrapper btn-group pull-left">
                        <div class="input-group">
                            <input type="text" class="form-control" id="searchtext" placeholder="${views.column['VSiteGame.customerName']}" name="search.siteGameName">
                                <span class="input-group-btn">
                                    <soul:button target="query" opType="function" tag="button" text="${views.common['search']}" cssClass="btn btn-filter btn-query-css"><i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span></soul:button>
                                </span>
                        </div>
                    </div>
                </div>

                <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>

</div>
</form:form>
<!--//endregion your codes 2-->


<!--//region your codes 3-->
<soul:import res="site/content/gameManage/siteGame/Index"/>
<!--//endregion your codes 3-->