<%--@elvariable id="command" type="so.wwb.gamebox.model.report.operation.vo.StationBillListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/operation/stationbill/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
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
                    <li class="active"><a href="/operation/stationbill/list.html"
                                          nav-target="mainFrame">${views.operation['Bill.station']}</a></li>
                    <li><a href="/operation/stationbill/generalBill.html"
                           nav-target="mainFrame">${views.operation['Bill.distributor']}</a></li>
                </ul>
                <div class="operate-btn n-o-margin border-b-1 clearfix">
                    <span class="co-yellow"><i class="fa fa-exclamation-circle"></i></span>
                        ${views.operation['Bill.station.list.message']}</div>

                <div class="clearfix filter-wraper border-b-1 line-hi34 al-right">
                    <a href="/operation/stationbill/viewContractScheme.html"
                       nav-target="mainFrame">${views.operation['Bill.station.list.contract']}</a>
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
<soul:import type="list"/>
<!--//endregion your codes 3-->