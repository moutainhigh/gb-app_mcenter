<%--@elvariable id="command" type="so.wwb.gamebox.model.master.analyze.vo.VAnalyzePlayerVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
    <title>${views.analyze['编辑']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>

<body>

<form:form id="editForm" action="${root}/vAnalyzePlayer/edit.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="modal-body">

        <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm ">
            <div class="input-group date">
                <span class="input-group-addon bg-gray">${views.analyze['存款次数']}</span>
                <form:hidden path="depositCountParam.id"/>
                <shiro:hasPermission name="mcenter:analyze-param">
                    <form:input path="depositCountParam.paramValue" cssClass="form-control"/>
                </shiro:hasPermission>
                <shiro:lacksPermission name="mcenter:analyze-param">
                    <input name="depositCountParam.paramValue" class="form-control" value="${command.depositCountParam.paramValue}" disabled>
                </shiro:lacksPermission>
            </div>
        </div>


        <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm ">
            <div class="input-group date">
                <form:hidden path="depositParam.id"/>
                <span class="input-group-addon bg-gray">${views.analyze['存款金额']}</span>
                <shiro:hasPermission name="mcenter:analyze-param">
                    <form:input path="depositParam.paramValue" cssClass="form-control"/>
                </shiro:hasPermission>
                <shiro:lacksPermission name="mcenter:analyze-param">
                    <input name="depositParam.paramValue" class="form-control" value="${command.depositParam.paramValue}" disabled>
                </shiro:lacksPermission>

            </div>
        </div>


        <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm ">
            <div class="input-group date">
                <span class="input-group-addon bg-gray">${views.analyze['有效投注额']}</span>
                <form:hidden path="effectiveParam.id"/>
                <shiro:hasPermission name="mcenter:analyze-param">
                    <form:input path="effectiveParam.paramValue" cssClass="form-control"/>
                </shiro:hasPermission>
                <shiro:lacksPermission name="mcenter:analyze-param">
                    <input name="effectiveParam.paramValue" class="form-control" value="${command.effectiveParam.paramValue}" disabled>
                </shiro:lacksPermission>
            </div>
        </div>


    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" permission="mcenter:analyze-param" text="${views.common.OK}" opType="ajax" precall="validateForm" target="${root}/vAnalyzePlayer/saveAnalyzeParam.html" dataType="json" post="getCurrentFormData" callback="closePage"/>
        <soul:button cssClass="btn btn-outline btn-filter" target="closePage" opType="function" text="${views.common.cancel}"/>
    </div>
    <!--//endregion your codes 3-->

</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import type="edit"/>
<!--//endregion your codes 4-->
</html>