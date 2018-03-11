<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <form:form action="${root}/simulationAccount/playerView.html" method="post">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['角色']}</span><span>/</span><span>${views.player_auto['模拟账号']}</span>
            <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="clearfix filter-wraper border-b-1">
                    <soul:button tag="button" cssClass="btn btn-info btn-addon" precall=""
                                 text="${views.player_auto['新增账号']}" target="${root}/simulationAccount/addPlayer.html"
                                 opType="dialog" callback="query">
                        <i class="fa fa-plus"></i>
                        <span class="hd">${views.player_auto['新增']}</span>
                    </soul:button>
                    <div class="function-menu-show">
                        <soul:button tag="button" target="${root}/simulationAccount/addQuota.html" precall="getIds" opType="dialog" text="${views.player_auto['增加额度']}"
                                     cssClass="btn btn-danger-hide _delete" callback="query">
                            <span class="hd">${views.player_auto['额度调整']}</span></soul:button>
                        <soul:button tag="button" target="${root}/simulationAccount/deletePlayer.html" precall="" opType="ajax" text="${views.common['delete']}"
                                     post="getSelectIds" cssClass="btn btn-danger-hide _delete" callback="query" confirm="${views.content_auto['确认删除']}?">
                            <i class="fa fa-trash-o"></i><span class="hd">${views.player_auto['删除']}</span></soul:button>
                    </div>
                    <div class="col-sm-3 btn-group pull-right m-r-n-xs">
                        <div class="input-group">
                            <input type="text" name="search.username" class="form-control" placeholder="${views.player_auto['模拟账号']}" value="${command1.search.username}"/>
                            <span class="input-group-btn">
                                <soul:button target="query" opType="function" cssClass="btn btn-filter btn-query-css enter-submit" tag="button" text="">
                                    <i class="fa fa-search"></i>
                                    <span class="hd">&nbsp;${views.common['detection']}</span>
                                </soul:button>
                            </span>
                        </div>
                    </div>
                </div>
                <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                    <div class="search-list-container">
                        <%@ include file="IndexPartial.jsp" %>
                    </div>
                </div>
            </div>
        </div>
    </form:form>
</div>
<soul:import res="site/player/simulationAccount/simulation"/>
