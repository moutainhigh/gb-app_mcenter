<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<button class="close btn btn-default">${views.common['cancel']}</button>
    <div class="container">
        <div id="MuLuHtml" style="">

        </div>
    </div>
<form action="${root}/sysResource/resetPermissions.html" class="tree"><%--
<soul:button cssClass="btn btn-default" text="${views.setting_auto['保存']}" opType="ajax" dataType="json" target="${root}/sysResource/resetPermissions.html" post="getCurrentFormData1" callback="saveCallbak" />--%>
<soul:button cssClass="btn btn-default" text="${views.common['OK']}" opType="function" target="saveResource" /><%--
    <button class="class" type="button">sadasd</button>--%>
    <input class="roleId" name="search.roleId" hidden="hidden" value="${roleId}"/>

</form>
</body>
<script>

</script>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="gb/role/sysResource"/>
</html>
