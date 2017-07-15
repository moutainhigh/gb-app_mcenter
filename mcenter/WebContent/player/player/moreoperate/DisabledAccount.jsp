<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/include/include.inc.jsp" %>
<%--@elvariable id="userPlayerVo" type="so.wwb.gamebox.model.master.player.vo.VUserPlayerVo"--%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<!--账号停用弹窗-->
<form:form method="post" id="frm">
<div name="editor" class="modal-body">
    <div class="form-group clearfix m-b-sm col-xs-12">
        <label class="col-xs-3 al-right">${messages["playerTag"]["account"]}：</label>
        <div class="col-xs-9 p-x"><span name="un">${vo.username}</span>
            <c:choose>
                <c:when test="${vo.onLineId>0}"><span class="m-l-sm co-green">${messages["playerTag"]["online"]}</span></c:when>
                <c:otherwise><span class="m-l-sm co-grayc2">${messages["playerTag"]["notOnline"]}</span></c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="form-group clearfix m-b-sm col-xs-12">
        <label class="col-xs-3 al-right">${messages["playerTag"]["accountDisabled"]}：</label>
        <div class="col-xs-9 p-x"><input type="checkbox" name="my-checkbox" data-size="mini" ${vo.status==2?'checked':''}></div>
    </div>
    <div class="form-group clearfix m-b-sm col-xs-12">
        <label class="col-xs-3 al-right line-hi34">${messages["playerTag"]["disableReason"]}：</label>
        <div class="col-xs-8 p-x">
            <div class="input-group date">
                <select callback="reasonTitleChange" class="btn-group chosen-select-no-single" tabindex="9" id="reasonTitle">
                        <option value="">${messages["playerTag"]["disabled_please_reason"]}</option>
                    <c:forEach items="${noticeLocaleTmpls}" var="i">
                        <option value="${i.title}" holder="${i.content}" groupCode="${i.groupCode}">${i.title}</option>
                    </c:forEach>
                </select>
                <span class="input-group-addon bdn">
                <soul:button target="toTmplButton" text="${messages['playerTag']['disabled_edit']}" cssClass="m-l-sm" opType="function"/>
                </span>
            </div>
            <span class="help-block m-b-none"><br></span>
            <div class="clearfix m-t-sm">${messages["playerTag"]["disabled_content"]}：<a href="javascript:void(0)" class="pull-right">${messages["playerTag"]["disabled_preview_more"]}</a></div>
            <textarea class="form-control m-t-xs" readonly id="reasonContent"></textarea>
        </div>
    </div>
    <input type="hidden" name="result.entityUserId" value="${vo.id}">
    <input type="hidden" id="title" name="title" value="">
    <input type="hidden" id="status" value="false"  />
    <input type="hidden" id="groupCode" name="groupCode" value=""/>
    <input type="hidden" name="bo" value="true"/>
    <input type="hidden" id="type" value="1"/>
    <div class="form-group clearfix m-b-sm col-xs-12">
        <label class="col-xs-3 al-right">${messages["playerTag"]["remark"]}：</label>
        <div class="col-xs-8 p-x">
            <textarea class="form-control" maxlength="500" id="remark" name="result.remarkContent"></textarea>
        </div>
    </div>
</div>
<div name="editor" class="modal-footer">
    <%--<soul:button target="${root}/player/view/disablePreview.html?username=${vo.username}&onLineId=${vo.onLineId}&title={title}&remark={remark}&reasonContent={reasonContent}" precall="myValidate" callback="sureDialogsureDialog" title="${messages['playerTag']['accountDisabled']}" text="${messages['common']['previewAndSubmit']}" cssClass="btn btn-filter" opType="dialog"/>--%>
    <soul:button target="previewDisable" precall="myValidate" title="${messages['playerTag']['accountDisabled']}" text="${messages['common']['previewAndSubmit']}" cssClass="btn btn-filter" opType="function"/>
    <soul:button target="closePage" text="${messages['common']['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
</div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/player/moreoperate/DisabledAccount"/>
</html>

