<%--@elvariable id="command" type="so.wwb.gamebox.model.gamebox.vo.WithdrawAccountListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<!--//endregion your codes 1-->
<body>
<form:form action="${root}/rechargeFeeSchema/list.html" method="post">
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
                    <shiro:hasPermission name="operate:recharge_fee_create">
                        <a href="/rechargeFeeSchema/create.html" class="btn btn-info btn-addon pull-left m-r-sm" nav-target="mainFrame"><i class="fa fa-plus"></i><span class="hd">${views.common['create']}</span></a>
                    </shiro:hasPermission>

                    <div class="search-wrapper btn-group pull-right m-r-n-xs">
                        <div class="input-group">

                            <input type="text" class="form-control list-search-input-text" name="search.schemaName"
                                   placeholder="请输入手续费方案名称">
                                <%--查询--%>
                            <span class="input-group-btn">
                                <soul:button cssClass="btn btn-filter btn-query-css _enter_submit" precall="" tag="button" opType="function" text="${views.common['search']}" target="query">
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
<soul:import type="list"/>
<!--//endregion your codes 3-->