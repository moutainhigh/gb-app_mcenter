<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/operation/rakebackBill/list.html">
<div class="row">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
        <span>${views.sysResource['资金']}</span>
        <span>/</span>
        <span>${views.sysResource['返水结算']}</span>
        <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
    </div>
    <div class="col-lg-12">
        <div class="wrapper white-bg shadow clearfix">
            <div class="clearfix filter-wraper border-b-1 line-hi34">
                <a href="/operation/rakebackBill/rakebackNosettled.html" nav-target="mainFrame" class="btn btn-outline btn-filter">${views.operation['Rakeback.list.nosettled']}</a>
                <a href="/setting/vRakebackSet/list.html?hasReturn=change" nav-target="mainFrame" class="pull-right">${views.operation['backwater.index.backwaterSetting']}</a>
            </div>
            <div class="search-list-container dataTables_wrapper table-min-h" role="grid">
                <%@ include file="IndexPartial.jsp" %>
            </div>
        </div>
    </div>
</div>
</form:form>
<soul:import type="list"/>