<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.rebate.vo.AgentRebateListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<div class="row">
    <form action="${root}/fund/rebate/agent/list.html" method="post">
    <input type="hidden" name="search.agentId" value="${command.search.agentId}">
    <input type="hidden" name="search.rebateYear" value="${command.search.rebateYear}">
    <input type="hidden" name="search.rebateMonth" value="${command.search.rebateMonth}">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.fund_auto['资金管理']}</span>
            <span>/</span><span>${views.fund_auto['返佣结算']}</span>
            <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <!--表格内容-->
                <div id="editable_wrapper" class="search-list-container dataTables_wrapper" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </form>
</div>

<!--//region your codes 3-->
<soul:import type="list"/>
<!--//endregion your codes 3-->