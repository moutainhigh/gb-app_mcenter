<%--@elvariable id="command" type="so.wwb.gamebox.model.company.lottery.vo.LotteryResultVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
	<title>详情</title>
	<%@ include file="/include/include.head.jsp" %>
</head>
<body>
	<!--//region your codes 3-->
	<div class="table-responsive">
		<div class="">日志详情</div>
		<table class="table table-condensed table-hover table-bordered">
		</table>
	</div>
	<!--//endregion your codes 3-->
</body>
<div class="table-responsive">
	<table class="table table-condensed table-hover table-bordered">
		${soulFn:formatLogDesc(result)}
	</table>
</div>
<!--//endregion your codes 4-->
</html>