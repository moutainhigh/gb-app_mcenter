<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.SiteConfineAreaVo"--%>
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
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <form:hidden path="ipRegIntervalId"/>
    <form:hidden path="ipDayMaxRegNumId"/>
    <form:hidden path="regAddressId"/>
    <!--//region your codes 3-->
                <div class="modal-body">
                    <div class="form-group clearfix m-b-xxs">
                        <label for="ipRegInterval">${views.setting['PlayerReg.ip_reg_interval']}:</label>
                        <form:input path="ipRegInterval" cssClass="form-control m-b"/>
                    </div>
                    <div class="form-group clearfix m-b-xxs">
                        <label for="ipDayMaxRegNum">${views.setting['PlayerReg.ip_day_max_regNum']}:</label>
                        <form:input path="ipDayMaxRegNum" cssClass="form-control m-b"/>
                    </div>
                    <div class="form-group clearfix m-b-xxs">
                        <label for="regAddress">${views.setting['PlayerReg.reg_address']}:</label>
                        <div class="input-group date">
                            <form:input path="regAddress" cssClass="form-control m-b"/>
                            <span class="input-group-addon"><i class="fa fa-question-circle"></i></span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <soul:button cssClass="btn btn-filter" text="${views.setting['common.ok']}" opType="ajax" dataType="json"
                                 target="${root}/param/saveRegLimit.html" precall="validateForm" post="getCurrentFormData"
                                 callback="saveCallbak"/>
                    <soul:button target="closePage" text="${views.setting['common.cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
                </div>
    <!--//endregion your codes 3-->

</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import type="edit"/>
<!--//endregion your codes 4-->
</html>