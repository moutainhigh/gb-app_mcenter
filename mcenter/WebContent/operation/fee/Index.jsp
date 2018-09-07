<%--@elvariable id="command" type="so.wwb.gamebox.model.gamebox.vo.WithdrawAccountListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<!--//endregion your codes 1-->
<body>
<form:form action="${root}/withdrawAccount/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <!--//region your codes 2-->
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}</span><span>/</span>
            <span>手续费设置</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>

        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <!--筛选条件-->
                <div class="clearfix filter-wraper border-b-1">
                    <a href="/rechargeFeeSchema/create.html" class="btn btn-info btn-addon pull-left m-r-sm" nav-target="mainFrame"><i class="fa fa-plus"></i><span class="hd">${views.common['create']}</span></a>
                    <soul:button tag="button" precall="" target="query" opType="function" cssClass="btn btn-primary-hide" text="${views.common['refresh']}"><i class="fa fa-refresh"></i><span class="hd">${views.common['refresh']}</span></soul:button>
                        <%--删除--%>
                    <div class="function-menu-show hide">
                        <div class="btn-group" style="padding-left: 10px">
                            <shiro:hasPermission name="content:withdraw_account_delete">
                                <soul:button tag="button" text="${views.common['delete']}" confirm="确认删除吗？"
                                             target="${root}/withdrawAccount/delete.html" post="getSelectIds"
                                             opType="ajax" cssClass="btn btn-danger-hide"
                                             callback="deleteCallbak"><i class="fa fa-trash-o"></i><span
                                        class="hd">${views.common['delete']}</span></soul:button>
                            </shiro:hasPermission>
                        </div>
                    </div>
                    <div class="search-wrapper btn-group pull-right m-r-n-xs">
                        <div class="input-group">
                            <%--下拉筛选--%>
                            <div class="input-group-btn">
                                <select id="searchlist" data-placeholder="${views.column['VPayAccount.accountName']}" class="btn-group chosen-select-no-single" tabindex="-1">
                                    <%--<c:forEach items="${command.searchList()}" var="item" varStatus="status">--%>
                                        <%--<option value="${item.key}" ${status.index==0?'selected':''}>${item.value}</option>--%>
                                        <%--<c:if test="${status.index==0}">--%>
                                            <%--<c:set value="${item.key}" var="firstSelectKey"/>--%>
                                        <%--</c:if>--%>
                                    <%--</c:forEach>--%>
                                </select>
                            </div>
                            <input type="text" class="form-control list-search-input-text" id="searchtext" name="${firstSelectKey}">
                                <%--查询--%>
                            <span class="input-group-btn">
                                <soul:button cssClass="btn btn-filter btn-query-css _enter_submit" precall="checksearch" tag="button" opType="function" text="${views.common['search']}" target="query">
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
    </div>
    <!--//endregion your codes 2-->
</form:form>
</body>
<!--//region your codes 3-->
<soul:import res="site/content/withdrawAccount/Index"/>
<!--//endregion your codes 3-->