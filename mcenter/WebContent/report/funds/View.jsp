<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.vplayerfundsrecordvo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<form:form  action="" method="post">
	<div class="row">
		<div class="position-wrap clearfix">
			<h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
			<span>${views.sysResource['统计']}</span>
			<span>/</span>
			<span>${views.sysResource['资金记录']}</span>
			<soul:button tag="a" target="goToLastPage" text="" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
				<em class="fa fa-caret-left"></em>${views.common['return']}
			</soul:button>
			<!--        <a href="javascript:void(0)" nav-target="mainFrame" class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn"><em class="fa fa-caret-left"></em>${views.report_auto['返回']}</a>-->
			<a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
		</div>

		<c:choose>
			<c:when test="${command.result.transactionType eq 'backwater'}">
				<%--返水--%>
				<%@ include file="views/BackwaterView.jsp" %>
			</c:when>
			<c:when test="${command.result.transactionType eq 'favorable' && command.result.transactionWay ne 'refund_fee'}">
				<%--优惠--%>
				<%@ include file="views/FavorableView.jsp" %>
			</c:when>
			<c:when test="${command.result.transactionType eq 'recommend'}">
				<%--推荐 --%>
				<%@ include file="views/RecommendView.jsp" %>
			</c:when>
			<c:when test="${command.result.transactionWay eq 'refund_fee'}">
				<%--返手续费 --%>
				<%@ include file="views/RefundView.jsp" %>
			</c:when>
		</c:choose>

	</div>
</form:form>
<soul:import res="site/report/funds/views"/>
<!--//endregion your codes 1-->