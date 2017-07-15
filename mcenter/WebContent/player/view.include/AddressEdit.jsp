<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerAddressVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<c:if test="${command.result==null}">
    <div class="no-content_wrap">
        <i class="fa fa-exclamation-circle"></i> ${views.role['player.view.address.noresult']}
    </div>
</c:if>
<c:if test="${command.result!=null}">
    <form:form method="post">
        <div id="validateRule" style="display: none">${validate}</div>
        <form:input type="hidden" path="search.id" value="${command.result.id}"/>
        <div class="modal-body">
            <div class="form-group over clearfix">
                <label for="result.consignee" class="col-xs-3 al-right">${views.column['PlayerAddress.consignee']}：</label>
                <div class="col-xs-9 p-x">
                    <form:input path="result.consignee" type="text" class="form-control" value="${command.result.consignee}"/>
                </div>
            </div>
            <div class="form-group over clearfix">
                <label class="col-xs-3 al-right">${views.column['PlayerAddress.area']}：</label>
                <div class="col-xs-9 p-x">
                    <div class="pull-left m-r-sm">
                        <gb:select name="result.nation" value="${command.result.nation}" prompt="${views.common['pleaseSelect']}"
                                   ajaxListPath="${root}/regions/site.html" listValue="remark" listKey="dictCode"
                                   relSelect="result.province" cssClass="btn-group chosen-select-no-single"/>
                    </div>
                    <div class="pull-left m-l-sm">
                        <gb:select name="result.province" prompt="${views.common['pleaseSelect']}" value="${command.result.province}"
                                   ajaxListPath="${root}/regions/states/${command.result.nation}.html"
                                   relSelectPath="${root}/regions/states/#result.nation#.html" listValue="remark"
                                   listKey="dictCode" cssClass="btn-group chosen-select-no-single" relSelect="result.city"/>
                    </div>
                    <div class="pull-left m-l-sm">
                        <gb:select name="result.city" prompt="${views.common['pleaseSelect']}" value="${command.result.city}"
                                   ajaxListPath="${root}/regions/cities/${command.result.nation}-${command.result.city}.html"
                                   relSelectPath="${root}/regions/cities/#result.nation#-#result.province#.html" listValue="remark"
                                   listKey="dictCode" cssClass="btn-group chosen-select-no-single"/>
                    </div>
                </div>
            </div>
            <div class="form-group over clearfix">
                <label for="result.address" class="col-xs-3 al-right">${views.column['PlayerAddresss.address']}：</label>
                <div class="col-xs-9 p-x">
                    <form:input path="result.address" type="text" class="form-control" value="${command.result.address}"/>
                </div>
            </div>
            <div class="form-group over clearfix">
                <label for="result.zipCode" class="col-xs-3 al-right">${views.column['PlayerAddress.zipCode']}：</label>
                <div class="col-xs-9 p-x">
                    <form:input path="result.zipCode" type="text" class="form-control" value="${command.result.zipCode}"/>
                </div>
            </div>
            <div class="form-group over clearfix">
                <label class="col-xs-3 al-right">${views.column['PlayerAddress.phone']}：</label>
                <div class="col-xs-9 p-x">
                    <form:input path="result.phone" type="text" class="form-control" value="${command.result.phone}"/>
                </div>
            </div>
            <div class="form-group over clearfix">
                <label class="col-xs-3 al-right">${views.column['PlayerAddress.mobile']}：</label>
                <div class="col-xs-9 p-x">
                    <form:input path="result.mobile" type="text" class="form-control" value="${command.result.mobile}"/>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <soul:button precall="validateForm" cssClass="btn btn-filter" callback="saveCallbak" text="${views.common['OK']}" opType="ajax" dataType="json" target="${root}/player/view/addressSave.html" post="getCurrentFormData"/>
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
        </div>
    </form:form>
</c:if>
</body>
<%@ include file="/include/include.js.jsp" %>
<script type="text/javascript">
    curl(['common/BaseEditPage', 'gb/components/selectPure'], function(Page, SelectPure) {
        page = new Page();
        page.bindButtonEvents();
        selectPure = new SelectPure();
    });
</script>
</html>