<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.reply.vo.PlayerAdvisoryReplyVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
	<title>${views.common['detail']}</title>
	<%@ include file="/include/include.head.jsp" %>
	<!--//region your codes 2-->

	<!--//endregion your codes 2-->
</head>
<body>
	<!--//region your codes 3-->
	<form:form method="post" name="addSimulationAccount">
		<input type="hidden" name="search.id" value="${id}"/>
		<div id="validateRule" style="display: none">${validateRule}</div>
		<div class="modal-body">
				<div class="form-group over clearfix">
                    <label class="col-xs-2 al-right">${views.player_auto['额度']}：</label>
                    <div class="col-xs-9 p-x">
                        <input type="text" name="search.walletBalance" class="form-control" id="walletBalance"/>
                    </div>
                </div>
			<div class="modal-footer">
				<soul:button precall="validateForm" cssClass="btn btn-filter" callback="saveCallbak" text="${views.common['OK']}" opType="function" target="updatePlayer" />
				<soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
			</div>
		</div>
	</form:form>
	<!--//endregion your codes 3-->
</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/player/simulationAccount/simulationQuota"/>
<!--//endregion your codes 4-->
</html>