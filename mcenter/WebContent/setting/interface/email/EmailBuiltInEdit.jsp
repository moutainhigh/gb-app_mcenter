<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.VNoticeEmailRankVo"--%>
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

<form:form id="editForm" action="${root}/vNoticeEmailInterface/edit.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <input name="original" type="hidden" value="${command.result.emailAccount}"/>
    <input name="result.original" type="hidden" value="${command.result.emailAccount}"/>
    <form:hidden path="result.builtIn"/>
    <form:hidden path="result.name"/>
    <form:hidden path="result.id"/>

    <!--//region your codes 3-->
    <div class="modal-body">
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span
                    class="co-red3 m-r-xs">*</span>${views.setting['mail.Edit.name']}：</label>
            <div class="col-xs-8 p-x">
                    ${command.result.name}
            </div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span class="co-red3 m-r-xs">*</span>${views.setting['mail.Edit.rankName']}：</label>

            <div class="col-xs-8 p-x m-b rankStatus">
                    ${views.setting['mail.Index.allRank']}
            </div>
        </div>
        <div class="form-group clearfix  m-b-xxs">
            <label class="col-xs-3 al-right"><span
                    class="co-red3 m-r-xs">*</span>${views.setting['mail.Edit.smtp']}：</label>

            <div class="col-xs-8 p-x"><form:input path="result.serverAddress" cssClass="form-control m-b"/></div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span
                    class="co-red3 m-r-xs">*</span>${views.setting['mail.Edit.port']}：</label>

            <div class="col-xs-8 p-x"><form:input path="result.serverPort" cssClass="form-control m-b"/></div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span class="co-red3 m-r-xs">*</span>${views.setting['mail.Edit.userName']}：</label>

            <div class="col-xs-8 p-x"><form:input path="result.emailAccount" cssClass="form-control m-b"/></div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span class="co-red3 m-r-xs">*</span>${views.setting['mail.Edit.password']}：</label>

            <div class="col-xs-8 p-x">
                <input style="display: none">
                <%--<form:password path="result.accountPassword" cssClass="form-control m-b"/>--%>
                <input type="password" name="result.accountPassword"
                                                    class="form-control m-b" value="${command.result.accountPassword}"/>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.setting['common.ok']}" opType="ajax" dataType="json"
                     target="${root}/vNoticeEmailInterface/updateBuiltIn.html" precall="validateForm" post="getCurrentFormData"
                     callback="saveCallbak"/>
        <soul:button target="closePage" text="${views.setting['common.cancel']}" cssClass="btn btn-outline btn-filter"
                     opType="function"/>
    </div>
    <!--//endregion your codes 3-->

</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import type="edit"/>
<!--//endregion your codes 4-->
</html>