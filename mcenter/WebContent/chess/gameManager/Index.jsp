<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<!--//region your codes 2-->
<form:form action="${root}/chessSiteGame/gameManager.html" method="post">
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>棋牌</span><span>/</span><span>${views.sysResource['游戏管理']}（手机端）</span>
        </div>
        <form:hidden path="validateRule"/>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="clearfix filter-wraper border-b-1">
                    <div class="con clearfix">
                        <div class="col-md-6 m-t-md m-b-md">
                            <span class="label ${command.siteApi.systemStatus=='disable'?'label-danger':command.siteApi.systemStatus=='maintain'?'label-warning':'label-success'} m-l-sm">${dicts.game.status[command.siteApi.systemStatus]}</span></b>
                            <a href="/chessSiteGame/orderSiteGame.html" nav-target="mainFrame"
                               class="btn btn-outline btn-filter"><i class="fa fa-sort-amount-desc m-r-xs"></i>手机端排序</a>
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
<soul:import res="site/chess/gameManager/Index"/>
<!--//endregion your codes 3-->