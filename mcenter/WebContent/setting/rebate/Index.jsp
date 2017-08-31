<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.RebateSetListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/rebateSet/list.html?topAgentId=${command.topAgentId}" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>

    <!--//region your codes 2-->
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}</span><span>/</span><span>${views.sysResource['返佣设置']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
            <c:if test="${not empty command.hasReturn}">
                <soul:button tag="a" target="goToLastPage" text="" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
                    <em class="fa fa-caret-left"></em>${views.common['return']}
                </soul:button>
            </c:if>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="dataTables_wrapper" role="grid" id="editable_wrapper">
                    <div class="filter-wraper clearfix">
                        <a href="/rebateSet/create.html" nav-target="mainFrame" type="button" class="btn btn-info btn-addon pull-left m-r-sm"><i class="fa fa-plus"></i><span class="hd">${views.setting['rebate.list.addRebate']}</span></a>
                        <%--<soul:button tag="button" cssClass="btn btn-primary-hide" text="${views.setting['rakeback.settlement.period']}" target="${root}/rebateSet/rebatePeriod/view.html" opType="dialog"><i class="fa fa-sign-out"></i><span class="hd">${views.setting['rakeback.settlement.period']}</span></soul:button>--%>
                        <%--<div class="function-menu-show hide">
                            <button type="button" class="btn btn-danger-hide"><i class="fa fa-trash-o"></i><span class="hd">${views.common['delete']}</span></button>
                        </div>--%>
                        <soul:button tag="button" cssClass="btn btn-primary-hide" text="${views.setting['rebate.deposit.withdraw.fee']}"
                                     target="${root}/rebateSet/agentRebateDAWF.html" opType="dialog">
                            <i class="fa fa-sign-out"></i><span class="hd">${views.setting['rebate.deposit.withdraw.fee']}</span>
                        </soul:button>
                        <div class="search-wrapper btn-group pull-right m-r-n-xs">
                            <div class="input-group pull-left  m-r-sm">
                                <input type="text" class="form-control" name="search.name" placeholder="${views.setting['rebate.list.scheduleName']}">
                            </div>
                            <div class="input-group pull-left  m-r-sm">
                                <input type="text" class="form-control" name="search.ownerName" placeholder="${views.wc_fund['代理账号']}">
                            </div>
                            <span class="input-group-btn">
                                        <soul:button cssClass="btn btn-filter" tag="button" opType="function" text="${views.common['search']}" target="query">
                                            <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span>
                                        </soul:button>
                                    </span>
                        </div>
                    </div>
                    <div class="search-list-container">
                        <%@ include file="IndexPartial.jsp" %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--//endregion your codes 2-->
</form:form>

<!--//region your codes 3-->
<soul:import res="site/setting/rebate/RebateListPage"/>
<!--//endregion your codes 3-->