<%--@elvariable id="command" type="org.soul.model.security.privilege.vo.SysRoleVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<html lang="zh-CN">
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>

<body>
<form:form id="editForm" action="${root}/sysRole/edit.html" method="post" >
    <form:hidden path="result.id"  />
    <form:hidden path="result.status"  />
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="table-responsive">
        <%--<div class="">${views.role['page.role.info']}</div>--%>
        <table
                class="table table-condensed table-hover table-bordered">
            <tr>
                <td>${views.column['SysRole.name']}</td>
                <td><form:input path="result.name" cssClass="form-control input-sm"/></td>
            </tr>
            <c:if test="${!empty command.result.status}">
                <tr>
                    <td>${views.column['SysRole.status']}</td>
                    <td>
                        <%--<form:select path="result.status" cssClass="chosen-select-no-single"
                                items="${statusItems}" itemLabel="key" itemValue="value">
                        </form:select>--%>
                        <input type="checkbox" id="status" data-size="mini" value="${command.result.status}" ${command.result.status eq '1'?'checked':''}>
                    </td>
                </tr>
            </c:if>

        </table>
    </div>
    <div class="">
        <soul:button cssClass="btn btn-default" text="${views.common['OK']}" dataType="json" opType="ajax" target="${root}/msysRole/persist.html" precall="validateForm"  post="getCurrentFormData" callback="saveCallbak"/>
    </div>

</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<%--<soul:import type="edit"/>--%>
<soul:import res="site/setting/sysrole/SysRole"/>
</html>
