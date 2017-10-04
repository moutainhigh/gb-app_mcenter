<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.VRakebackSetListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<form:form action="${root}/setting/vRakebackSet/list.html" method="post">
<div class="row">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['运营']}</span><span>/</span><span>${views.setting['rakeback.edit.title']}</span>
        <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        <c:if test="${not empty command.hasReturn}">
            <soul:button tag="a" target="goToLastPage" text="" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </c:if>
    </div>
    <div class="col-lg-12">
        <div class="wrapper white-bg shadow">
            <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                <div class="clearfix filter-wraper border-b-1">
                    <!--                    <button type="button" class="btn btn-info btn-addon"><i class="fa fa-plus"></i><span class="hd">${views.setting_auto['新增返水']}</span></button>-->
                    <a href="/setting/rakebackSet/create.html" nav-target="mainFrame" type="button" class="btn btn-info btn-addon pull-left m-r-sm">
                        <i class="fa fa-plus"></i><span class="hd">${views.setting['rakeback.list.createPlan']}</span>
                    </a>
                    <soul:button tag="button" cssClass="btn btn-primary-hide" text="${views.setting['rakeback.settlement.period']}" target="${root}/setting/vRakebackSet/rakebackPeriod/view.html" opType="dialog"><i class="fa fa-sign-out"></i><span class="hd">${views.setting['rakeback.settlement.period']}</span></soul:button>
                    <%--<button type="button" class="btn btn-danger-hide"><i class="fa fa-trash-o"></i><span class="hd">${views.common['delete']}</span></button>--%>
                    <div class="search-wrapper btn-group pull-right m-r-n-xs">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="${views.column['VRakebackSet.name']}" name="search.name" value="${command.search.name}">
                            <span class="input-group-btn">
                                <soul:button target="query" tag="button" text="" cssClass="btn btn-filter" opType="function">
                                    <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span>
                                </soul:button>
                        </div>
                    </div>
                </div>
                <div class="search-list-container">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </div>
</div>
</form:form>

<!--//region your codes 3-->
<soul:import res="site/setting/rakeback/Index"/>
<!--//endregion your codes 3-->