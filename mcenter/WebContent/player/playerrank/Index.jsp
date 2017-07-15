<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerRankStatisticsListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/vPlayerRankStatistics/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['角色']}</span><span>/</span>
            <span>${views.sysResource['层级设置']}</span>
            <c:if test="${not empty command.hasReturn}">
                <soul:button tag="a" target="goToLastPage" text="" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
                    <em class="fa fa-caret-left"></em>${views.common['return']}
                </soul:button>
            </c:if>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <!--筛选条件-->
                <div class="clearfix filter-wraper border-b-1">
                    <a id="forwardAddPayLimit" cssClass="btn btn-outline btn-filter" href="" nav-target="mainFrame" data-rankId=""></a>
                    <soul:button permission="role:rank:add" tag="button" target="${root}/playerRank/add.html" title="${views.role['addTitle']}" callback="saveOrForward" text="${views.common['create']}" opType="dialog" cssClass="btn btn-info btn-addon" ><i class="fa fa-plus"></i><span class="hd">${views.common['create']}</span></soul:button>
                    <soul:button tag="button" target="query" text="${views.common['refresh']}" opType="function" cssClass="btn btn-primary-hide" ><i class="fa fa-refresh"></i><span class="hd">${views.common['refresh']}</span></soul:button>
                    <div class="function-menu-show hide">
                        <soul:button permission="role:rank:delete" tag="button" text="${views.common['delete']}" precall="checkPrivilege" target="${root}/playerRank/rank_delete.html" post="getSelectIds" opType="ajax" cssClass="btn btn-danger-hide" callback="deleteCallbak"><i class="fa fa-trash-o"></i><span class="hd">${views.common['delete']}</span></soul:button>
                    </div>
                </div>
                <!--表格内容-->
                <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </div>
</form:form>

<!--//region your codes 3-->
<soul:import res="site/player/player/level/PlayerRank"/>
<!--//endregion your codes 3-->