<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
    <!-- Gritter -->
</head>
<body>
<!--强制踢出弹窗-->
<form:form method="post">
    <input type="hidden" name="hasReason" value="${not empty noticeLocaleTmpls?'yes':''}">
    <div class="modal-body">
        <div class="form-group clearfix m-b-sm col-xs-12 editor">
            <label class="col-xs-3 al-right">${messages["playerTag"]["account"]}：</label>
            <div class="col-xs-9 p-x">${vo.username}
                <c:choose>
                    <c:when test="${onLineId>0}"><span class="m-l-sm co-green">${messages["playerTag"]["online"]}</span></c:when>
                    <c:otherwise><span class="m-l-sm co-grayc2">${messages["playerTag"]["notOnline"]}</span></c:otherwise>
                </c:choose>
            </div>
        </div>
        <c:if test="${not empty noticeLocaleTmpls}">
            <div class="form-group clearfix m-b-sm col-xs-12 editor">
                <label class="col-xs-3 al-right">${messages["playerTag"]["kickOutTheReason"]}：</label>
                <div class="col-xs-8 p-x">
                    <div class="input-group date">
                        <select name="result.remarkTitle" callback="reasonTitleChange"  class="btn-group chosen-select-no-single" tabindex="9" id="reasonTitle">
                            <option value="">${messages["playerTag"]["chooseToKickOutTheReason"]}</option>
                            <c:forEach items="${noticeLocaleTmpls}" var="i">
                                <option value="${i.title}" holder="${i.content}" groupCode="${i.groupCode}">
                                     ${fn:substring(i.title, 0, 20)}<c:if test="${fn:length(i.title)>20}">...</c:if>
                                </option>
                            </c:forEach>
                        </select>
                        <span class="input-group-addon bdn">
                            <soul:button target="tmpIndex" text="${messages['playerTag']['disabled_edit']}" opType="function">${messages["playerTag"]["disabled_edit"]}</soul:button>
                        </span>
                    </div>
                    <br>
                </div>
            </div>
            <div class="form-group clearfix m-b-sm col-xs-12 editor">
                <label class="col-xs-3 al-right">${messages["playerTag"]["disabled_content"]}：</label>
                <div class="col-xs-8 p-x">
                    <textarea id="reasonContent" name="reasonContent" class="form-control m-t-xs"></textarea>
                    <input type="hidden" id="rContent" />
                </div>
            </div>
        </c:if>
        <div class="form-group clearfix m-b-sm col-xs-12 editor">
            <label class="col-xs-3 al-right">${messages["playerTag"]["remark"]}：</label>
            <div class="col-xs-8 p-x">
                <textarea class="form-control" maxlength="500" id="remark" name="result.remarkContent"></textarea>
            </div>
        </div>
    </div>
    <div class="modal-footer editor">
        <input type="hidden" id="username" value="${vo.username}"/>
        <input type="hidden" name="result.entityUserId" id=playerId" value="${vo.id}">
        <input type="hidden" id="title" name="title" value="">
        <input type="hidden" id="groupCode" name="groupCode" value=""/>
        <input type="hidden" id="type" value="2"/>
        <soul:button target="savePreview" precall="myValidate" callback="saveOffline" title="${messages['playerTag']['compulsoryKickOut']}" text="${messages['common']['previewAndSubmit']}" cssClass="btn btn-filter ${onLineId>0?'':'ui-button-disable disabled'}" opType="function"/>
        <soul:button target="closePage" text="${messages['common']['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
    </div>
    <div class="modal-footer preview" style="display: none">
        <%--<soul:button target="lastStep" text="${messages['common']['lastStep']}" cssClass="btn btn-outline btn-filter" opType="function"/>
        --%>
        <soul:button target="${root}/player/view/saveOffline.html" text="${views['common']['OK']}"
                     cssClass="btn btn-filter" opType="ajax" post="getCurrentFormData" callback="saveCallbak"
                     dataType="json"/>
        <soul:button target="closePage" text="${messages['common']['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/player/moreoperate/Moreoperate"/>
</html>
