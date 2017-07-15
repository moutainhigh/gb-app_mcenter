<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.rebate.vo.AgentRebateVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
    <title>${views.fund_auto['编辑']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>

<body>

<form:form id="editForm" action="${root}/agentRebate/edit.html" method="post">
    <form:hidden path="result.id" />
    <div id="validateRule" style="display: none">${command.validateRule}</div>

    <!--//region your codes 3-->
    <div class="">
        <soul:button cssClass="btn btn-default" text="${views.fund_auto['保存']}" opType="ajax" dataType="json" target="${root}/agentRebate/persist.html" precall="validateForm" post="getCurrentFormData" callback="saveCallbak" />
        <soul:button cssClass="btn btn-default" text="${views.fund_auto['删除']}" opType="ajax" dataType="json" target="${root}/agentRebate/delete.html?id=${result.id}" callback="deleteCallbak" confirm="${views.fund_auto['您确定要删除该条记录吗？']}" />
    </div>

    <div class="table-responsive">
        <div class="">${views.fund_auto['代理返佣账单']}</div>
        <table class="table table-condensed table-hover table-bordered">
        </table>
    </div>
    <!--//endregion your codes 3-->

</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import type="edit"/>
<!--//endregion your codes 4-->
</html>