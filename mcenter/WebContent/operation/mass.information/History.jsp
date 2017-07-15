<%--@elvariable id="rakebackBillVo" type="so.wwb.gamebox.model.master.operation.vo.RakebackBillVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/operation/massInformation/history.html">
    <div class="row">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
        <span>${views.sysResource['内容']}</span>
        <span>/</span>
        <span>${views.sysResource['信息群发']}</span>
        <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
    </div>
    <div class="col-lg-12">
        <div class="wrapper white-bg shadow search-list-container">
            <div class="dataTables_wrapper search-list-container">
                <%@include file="HistoryPartial.jsp"%>
            </div>
        </div>
    </div>
    </div>
</form:form>
<soul:import type="list"/>