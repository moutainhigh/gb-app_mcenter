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
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="clearfix filter-wraper border-b-1">
                    <div class="search-wrapper btn-group pull-left m-r-n-xs">
                        <div class="input-group">
                            <div class="input-group-btn">
                                <select id="searchlist" class="btn-group chosen-select-no-single" tabindex="-1">
                                    <c:forEach items="${command.searchList()}" var="item" varStatus="status">
                                        <option value="${item.key}" ${status.index==0?'selected':''}>${item.value}</option>
                                        <c:if test="${status.index==0}">
                                            <c:set value="${item.key}" var="firstSelectKey"/>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                            <input type="text" class="form-control list-search-input-text " placeholder="多个账号,用半角逗号隔开" id="searchtext" name="${firstSelectKey}"  style="width: 250px">
                            <div class="input-group" style="padding-left: 10px;">
                                <span class="input-group-addon bg-gray">真实姓名</span>
                                <input type="text" class="form-control list-search-input-text" name="search.realName" style="width: 150px">
                            </div>
                            <span class="input-group-btn">
                                        <soul:button cssClass="btn btn-filter btn-query-css" precall="checksearch" tag="button" opType="function" text="${views.common['search']}" target="query">
                                            <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span>
                                        </soul:button>
                                    </span>
                        </div>
                    </div>
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