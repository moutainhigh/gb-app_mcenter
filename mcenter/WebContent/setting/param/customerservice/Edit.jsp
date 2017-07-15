<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.SiteCustomerServiceVo"--%>
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

<form:form id="editForm" action="${root}/siteCustomerService/edit.html" method="post">
    <form:hidden path="result.id" />
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <!--//region your codes 3-->
    <div class="modal-body">
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span class="co-red3 m-r-xs">*</span>ID：</label>
            <div class="col-xs-8 p-x"><form:input path="result.code" readonly="true" cssClass="form-control m-b" /></div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span class="co-red3 m-r-xs">*</span>${views.setting['customerServiceType']}：</label>
            <div class="col-xs-8 p-x">
                <span>
                    <%--<form:radiobutton path="result.type" value="1"/>${views.setting['siteCustomerService.1']}
                    &nbsp;&nbsp;
                    <form:radiobutton path="result.type" value="2"/>${views.setting['siteCustomerService.2']}--%>
                    ${views.setting['siteCustomerService.'.concat(command.result.type)]}
                    <input type="hidden" name="result.type" value="${command.result.type}">
                </span>
            </div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span class="co-red3 m-r-xs">*</span>${views.setting['customerservice.Index.name']}：</label>
            <div class="col-xs-8 p-x"><form:input path="result.name" maxlength="30" cssClass="form-control m-b" readonly="${command.result.builtIn?true:false}"/></div>
        </div>
        <div class="form-group clearfix line-hi34 m-b-xxs">
            <label class="col-xs-3 al-right"><span class="co-red3 m-r-xs">*</span>${views.setting['customerservice.Index.parameter']}：</label>
            <div class="col-xs-8 p-x"><form:textarea path="result.parameter" maxlength="500" cssClass="form-control m-b" /></div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.setting['common.ok']}" opType="ajax" dataType="json"
                     target="${root}/siteCustomerService/persist.html" precall="validateForm" post="getCurrentFormData"
                     callback="saveCallbak"/>
        <soul:button target="closePage" text="${views.setting['common.cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
    </div>
    <!--//endregion your codes 3-->

</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/setting/param/customerservice/Edit"/>
<!--//endregion your codes 4-->
</html>