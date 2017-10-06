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
		<div id="validateRule" style="display: none">${validateRule}</div>
		<div class="modal-body">
			<div class="form-group over clearfix">
				<label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>${views.player_auto['账号']}：</label>
				<div class="col-xs-9 p-x">
					<input type="text" name="sysUser.username" class="form-control"/>
				</div>
			</div>
			<div class="form-group over clearfix">
				<label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>${views.player_auto['密码']}：</label>
				<div class="col-xs-9 p-x">
					<input type="text" name="sysUser.password" class="form-control"/>
				</div>
			</div>
			<div class="form-group over clearfix">
				<label class="col-xs-3 al-right"><span class="co-red m-r-sm">*</span>${views.player_auto['额度']}：</label>
				<div class="col-xs-9 p-x">
					<input type="text" name="result.walletBalance" class="form-control"/>
				</div>
			</div>
			<div class="form-group over clearfix">
				<label class="col-xs-3 al-right">${views.player_auto['有效时间截止']}：</label>
				<div class="col-xs-9 p-x">
				<gb:dateRange format="${DateFormat.DAY}" style="width:38%"
							  useRange="false"
							  opens="right" position="down"
							  name="sysUser.freezeStartTime"/>
					<div><span>若未设置，虚拟账号有效期默认为永久！</span></div>
				</div>
			</div>

			<div class="form-group clearfix">
				<label class="col-xs-3 al-right line-hi34">${views.player_auto['备注']}：</label>
				<div class="col-xs-9 p-x">
					<textarea class="form-control" name="sysUser.memo"></textarea>
				</div>
			</div>
			<div class="modal-footer">
				<soul:button precall="validateForm" cssClass="btn btn-filter" callback="saveCallbak" text="${views.common['OK']}" opType="ajax" dataType="json" target="${root}/simulationAccount/savePlayer.html" post="getCurrentFormData"/>
				<soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
			</div>
		</div>
	</form:form>
	<!--//endregion your codes 3-->
</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import type="edit"/>
<!--//endregion your codes 4-->
</html>