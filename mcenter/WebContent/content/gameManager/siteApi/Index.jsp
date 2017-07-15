<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<!--//region your codes 2-->
<form:form action="${root}/vSiteApiTypeRelation/list.html?search.apiTypeId=${command.search.apiTypeId}" method="post">
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
                <%--<div class="clearfix filter-wraper border-b-1">
                    <div class="pull-right m-t-n-xxs">
                        <a class="btn btn-outline btn-filter" nav-target="mainFrame"
                           href="/vSiteApiTypeRelation/orderSiteApi.html?search.apiStatus=disable&search.status=disable&search.apiTypeId=${command.search.apiTypeId}">
                            <i class="fa fa-sort-amount-desc m-r-xs"></i>${views.common['order']}
                        </a>
                        <a href="" id="tot" nav-target="mainFrame" style="display: none"></a>
                    </div>
                </div>--%>
                <a href="" id="tot" nav-target="mainFrame" style="display: none"></a>
                <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </div>
</form:form>
<!--//endregion your codes 2-->


<!--//region your codes 3-->
<soul:import res="site/content/gameManage/siteApi/Index"/>
<!--//endregion your codes 3-->