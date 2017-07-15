<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<!--//region your codes 2-->

<div class="row">
    <form:form action="${root}/userPlayerTransfer/list.html?search.importId=${command.search.importId}&search.isActive=${command.search.isActive}" method="post">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['站点参数']}</span>
            <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <%--<a href="/vUserPlayerImport/list.html" nav-target="mainFrame">
                    ${views.setting['setting.parameter.importPlayer']}</a>--%>
        </div>
        <form:hidden path="validateRule" />
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="clearfix filter-wraper border-b-1">
                </div>
                <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
        <%--<div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="tab-content">
                    <div class="table-responsive">
                        <div id="editable_wrapper" class="dataTables_wrapper search-list-container  import_list panel-body" role="grid">
                            <%@ include file="IndexPartial.jsp" %>
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>
    </form:form>
</div>

<!--//endregion your codes 2-->


<!--//region your codes 3-->
<soul:import res="site/setting/param/importplayer/Index"/>
<!--//endregion your codes 3-->