<%--@elvariable id="command" type="so.wwb.gamebox.model.report.operation.vo.StationBillListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/operation/stationbill/generalBill.html" method="post">
    <!--//region your codes 2-->
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['资金']}</span><span>/</span><span>${views.sysResource['结算账单']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <ul class="clearfix sys_tab_wrap">
                    <li><a href="/operation/stationbill/list.html" nav-target="mainFrame">${views.operation['Bill.station']}</a></li>
                    <li class="active"><a href="/operation/stationbill/generalBill.html" nav-target="mainFrame">${views.operation['Bill.distributor']}</a></li>
                </ul>
                <div class="operate-btn n-o-margin border-b-1 clearfix">
                    <span class="co-yellow"><i class="fa fa-exclamation-circle"></i></span>
                        ${views.operation['Bill.distributor.list.message']}</div>
                <div class="filter-wraper clearfix p-xs">
                    <div class="form-group clearfix pull-left col-sm-5 p-x">
                        <div class="input-group date">
                            <span class="input-group-addon abroder-no"><b>${views.operation['Bill.distributor.list.settlementTime']}：</b></span>
                            <div class="pull-left">
                                <gb:select name="year" notUseDefaultPrompt="true" value="${year}" list="${years}" listKey="key" listValue="value"
                                        callback="getMonths"></gb:select>
                            </div>
                            <div class="pull-left">
                                <gb:select name="month" notUseDefaultPrompt="true" value="${month}" list="${months}"></gb:select>
                            </div>
                        </div>
                    </div>
                    <div class="search-wrapper btn-group pull-right">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="${views.operation['Bill.distributor.list.topAgentName']}" name="search.topagentName">
                            <span class="input-group-btn">
                                <soul:button target="query" text="${views.common['search']}" opType="function" cssClass="btn btn-filter"><i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span></soul:button>
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
<soul:import res="site/operation/stationbill/Index"/>
<!--//endregion your codes 3-->