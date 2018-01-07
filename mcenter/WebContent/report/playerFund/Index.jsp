<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RebateBillVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/rebateBill/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <!--//region your codes 2-->
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['统计']}</span>
            <span>/</span><span>${views.sysResource['资金记录']}</span>
            <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <%--<div class="clearfix filter-wraper border-b-1 line-hi34">
                    <a href="/rebateBill/rebateNosettled.html" nav-target="mainFrame" class="btn btn-outline btn-filter">${views.operation['Rebate.list.noRecord']}</a>
                    <soul:button target="query" text="${views.common['refresh']}" opType="function" cssClass="btn btn-filter"></soul:button>
                    <a href="/rebateSet/list.html?hasReturn=change" nav-target="mainFrame" class="pull-right">${views.operation['Rebate.list.setRebate']}</a>
                </div>--%>

                <div id="editable_wrapper" class="dataTables_wrapper m-t-md search-list-container" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </div>
    <!--//endregion your codes 2-->
</form:form>
<!--//endregion your codes 2-->
<!--//region your codes 3-->
<soul:import res="site/operation/rebate/Rebate"/>
<!--//endregion your codes 3-->