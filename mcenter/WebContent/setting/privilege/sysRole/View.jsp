<%--@elvariable id="command" type="org.soul.model.security.privilege.vo.SysRoleVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html lang="zh-CN">
<html>
<head>
	<title>${views.role['page.role.detail']}</title>
	<%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form id="editForm" action="${root}/sysRole/edit.html" method="post" >
	<div class="table-responsive">
		<%--<div class="">${views.setting_auto['角色信息']}</div>--%>
		<%--<div class="">${views.role['page.role.info']}</div>--%>
		<table
				class="table table-condensed table-hover table-bordered">
			<tr>
				<%--<td>${views.column['SysRole.code']}</td>
				<td><form:input path="result.code" cssClass="form-control input-sm" disabled="true"/></td>--%>
				<td>${views.column['SysRole.name']}</td>
				<td><form:input path="result.name" cssClass="form-control input-sm" disabled="true"/></td>
			</tr>
			<tr>
				<%--<td>${views.column['SysRole.SubsysCode']}</td>
				<td><form:input path="result.subsysCode" cssClass="form-control input-sm" disabled="true"/></td>--%>
				<td>${views.column['SysRole.status']}</td>
				<td>
					<input type="checkbox" id="status" disabled="true" data-size="mini" value="${command.result.status}" ${command.result.status eq '1'?'checked':''}>
				</td>
			</tr>
		</table>
	</div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/setting/sysrole/SysRole"/>
</html>