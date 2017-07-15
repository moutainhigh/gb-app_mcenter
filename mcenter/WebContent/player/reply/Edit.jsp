<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.reply.vo.PlayerAdvisoryReplyVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>

<body>

<form:form id="editForm" action="${root}${controller}/edit.html" method="post">
    <form:hidden path="result.id" />

    <!--//region your codes 3-->
    <div class="">
        <soul:button cssClass="btn btn-default" text="${views.common['save']}" opType="ajax" dataType="json" target="${root}${controller}/persist.html" post="getCurrentFormData" callback="saveCallbak" />
        <soul:button cssClass="btn btn-default" text="${views.common['delete']}" opType="ajax" dataType="json" target="${root}${controller}/delete.html?id=${result.id}" callback="deleteCallbak" confirm="${views.common['confirm.delete']}" />
    </div>

    <div class="table-responsive">
        <div class=""></div>
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