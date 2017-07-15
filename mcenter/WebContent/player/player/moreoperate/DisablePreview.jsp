<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/include/include.inc.jsp" %>
<%--<!DOCTYPE html>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
    <title>玩家管理-玩家列表</title>
    <!-- Gritter -->
</head>
<body>
<!--账号停用预览-->
<form:form id="editForm" method="post" >--%>
    <div name="preview" class="modal-body">
        <div class="form-group clearfix m-b-sm">
            <label class="col-xs-3 al-right">${messages["playerTag"]["account"]}：</label>
            <div class="col-xs-9">${username}
                <c:choose>
                    <c:when test="${onLineId>0}"><span class="m-l-sm co-green">${messages["playerTag"]["online"]}</span></c:when>
                    <c:otherwise><span class="m-l-sm co-grayc2">${messages["playerTag"]["notOnline"]}</span></c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="form-group clearfix m-b-sm">
            <label class="col-xs-3 al-right">${messages["playerTag"]["accountDisabled"]}：</label>
            <div class="col-xs-9"><input type="checkbox" name="my-checkbox" data-size="mini" checked disabled></div>
        </div>
        <div class="form-group line-hi34 clearfix m-b-sm">
            <label class="col-xs-3 al-right">${messages["playerTag"]["disableReason"]}：</label>
            <div class="col-xs-9">
                    ${title}
                <div class="clearfix">${messages["playerTag"]["disabled_content"]}：</div>
                <textarea class="form-control" disabled>${reasonContent}</textarea>
            </div>
        </div>
        <div class="form-group clearfix m-b-sm">
            <label class="col-xs-3 al-right line-hi34">${messages["playerTag"]["remark"]}：</label>
            <div class="col-xs-9">
                <textarea class="form-control" disabled>${remark}</textarea>
            </div>
        </div>
    </div>
    <div name="preview"  class="modal-footer">
        <soul:button target="cancelPreview" text="${messages['common']['lastStep']}" cssClass="btn btn-outline btn-filter" opType="function"/>
        <soul:button target="sureDialog" text="${views['common']['OK']}" cssClass="btn btn-filter" opType="function"/>
            <%--<soul:button cssClass="btn btn-filter" text="${views.player_auto['确定']}" opType="ajax" dataType="json" target="${root}/player/view/saveDisable.html" post="getCurrentFormData" callback="saveCallbak"></soul:button>--%>
    </div>
<%--</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/player/moreoperate/Moreoperate"/>
</html>--%>
