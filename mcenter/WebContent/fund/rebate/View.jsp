<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.rebate.vo.AgentRebateVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
	<title>${views.fund_auto['详情']}</title>
	<%@ include file="/include/include.head.jsp" %>
	<!--//region your codes 2-->

	<!--//endregion your codes 2-->
</head>
<body>
	<!--//region your codes 3-->
	<div class="table-responsive">
		<div class="">${views.fund_auto['代理返佣账单']}</div>
		<table class="table table-condensed table-hover table-bordered">
		</table>
	</div>
	<!--//endregion your codes 3-->
</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import type="view"/>
<!--//endregion your codes 4-->
</html>