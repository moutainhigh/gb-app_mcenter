<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.SiteConfineAreaVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<html lang="zh-CN">
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>

<body>
<form:form id="editForm" action="${root}/sysRole/edit.html" method="post">
    <form:hidden path="result.id"/>
    <form:hidden path="result.status"/>
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="modal-body">
        <div class="form-group clearfix line-hi34 m-b-sm">
            <label class="col-xs-3 al-right">${views.column['SiteConfineIp.remark']}：</label>

            <div class="col-xs-8">
                <form:textarea cssClass="form-control" path="result.remark"  readonly="true"/>
            </div>
        </div>

    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-outline btn-filter" text="${views.common['close']}" opType="function"
                     target="closePage"/>
    </div>
    </div>

</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<%--<soul:import type="edit"/>--%>
<soul:import type="edit"/>
</html>
