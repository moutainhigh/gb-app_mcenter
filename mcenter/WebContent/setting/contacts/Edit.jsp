<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.SiteContactsVo"--%>
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

<form:form id="editForm" action="${root}/vSiteContacts/edit.html" method="post">
    <form:hidden path="result.id" />
    <gb:token/>
    <div id="validateRule" style="display: none">${command.validateRule}</div>

    <!--//region your codes 3-->
    <div class="modal-body" style="height: 400px;">
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span class="co-red3 m-r-xs">*</span>${views.setting['contacts.Index.name']}：</label>
            <div class="col-xs-8 p-x"><form:input path="result.name" placeholder="${messages.contacts['valid.fullName']}" maxlength="30" cssClass="form-control m-b" /></div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span class="co-red3 m-r-xs">*</span>${views.setting['contacts.Index.mail']}：</label>
            <div class="col-xs-8 p-x"><form:input path="result.mail" maxlength="50" cssClass="form-control m-b" /></div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span class="co-red3 m-r-xs">*</span>${views.setting['contacts.Index.phone']}：</label>
            <div class="col-xs-8 p-x"><form:input path="result.phone" maxlength="20" cssClass="form-control m-b" /></div>
        </div>
        <div class="form-group clearfix line-hi34">
            <label class="col-xs-3 al-right"><span class="co-red3 m-r-xs">*</span>${views.setting['contacts.Index.position']}：</label>
            <div class="col-xs-8 p-x">
                <div class="input-group date">
                    <%--<gb:select name="result.positionId" value="${command.result.positionId}" list="${command.positionList}" listKey="id" listValue="name" cssClass="btn-primary"/>--%>
                    <gb:select name="result.positionId" prompt="${views.common['pleaseSelect']}" ajaxListPath="${root}/vSiteContacts/queryPositionList.html" value="${command.result.positionId}" listKey="id" listValue="name" cssClass="btn-primary"/>
                <span class="input-group-addon bdn">
                    <soul:button target="${root}/vSiteContacts/toPosition.html"  text="${views.setting['common.manage']}" title="${views.setting['contacts.edit.Position']}" callback="reselect" opType="dialog"/>
                </span>
                </div>
            </div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right">${views.setting['contacts.Index.sex']}：</label>
            <div class="col-xs-8 p-x">
                <gb:select name="result.sex" list="${command.sexDict}" value="${command.result.sex}"
                           prompt="${views.common['pleaseSelect']}"
                           cssClass="btn-primary"/>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.setting['common.ok']}" opType="ajax" dataType="json"
                     target="${root}/vSiteContacts/save.html" precall="validateForm" post="getCurrentFormData"
                     callback="saveCallbak"/>
        <soul:button target="closePage" text="${views.setting['common.cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
    </div>
    <!--//endregion your codes 3-->

</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/setting/contacts/Edit"/>
<!--//endregion your codes 4-->
</html>