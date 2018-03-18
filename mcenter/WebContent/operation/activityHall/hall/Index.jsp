<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/vActivityMessageHall/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <!--//region your codes 2-->
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}&nbsp;&nbsp;/</span><span>${views.sysResource['活动大厅']}</span>
            <soul:button tag="a" target="goToLastPage" text="" opType="function"
                         cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <!--筛选条件-->
                <div class="clearfix filter-wraper border-b-1">
                    <shiro:hasPermission name="operate:activity_add">
                        <a href="/operation/activityType/customList.html" nav-target="mainFrame"
                           class="btn btn-info btn-addon pull-left　m-r-sm">
                            <i class="fa fa-plus"></i><span class="hd">${views.operation['Activity.create']}</span>
                        </a>
                    </shiro:hasPermission>
                        <%--TODO 增加权限--%>
                    <a class="btn btn-outline btn-filter pull-left　m-r-sm" nav-target="mainFrame"
                       href="/operation/activity/order/list.html">
                        <i class="fa fa-sort-amount-desc m-r-xs"></i>${views.operation['活动归类顺序']}
                    </a>
                    <a class="btn btn-outline btn-filter pull-left　m-r-sm" nav-target="mainFrame"
                       href="/operation/activity/order/list.html">
                        <i class="fa fa-sort-amount-desc m-r-xs"></i>${views.operation['活动效果监控']}
                    </a>
                    <div class="search-wrapper btn-group pull-right">
                        <div class="input-group">
                            <input type="text" class="form-control list-search-input-text"
                                   placeholder="${views.operation['Activity.name']}" name="search.activityName">
                            <span class="input-group-btn">
                                    <soul:button target="query" opType="function" tag="button"
                                                 text="${views.common['search']}"
                                                 cssClass="btn btn-filter _enter_submit"><i
                                            class="fa fa-search"></i><span
                                            class="hd">&nbsp;${views.common['search']}</span></soul:button>
                                </span>
                        </div>
                    </div>
                </div>
                <!--表格内容-->
                <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </div>
    <!--//endregion your codes 2-->
</form:form>

<!--//region your codes 3-->
<soul:import res="site/operation/activity/Activity"/>
<!--//endregion your codes 3-->