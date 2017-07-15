<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
    <!-- Gritter -->
</head>
<body>
<!--账号停用预览-->
<form:form id="editForm" method="post" >
    <div class="modal-body">
        <div class="form-group clearfix m-b-sm">
            <label class="col-xs-3 al-right">${messages["playerTag"]["account"]}：</label>
            <div class="col-xs-9">${vo.username}
                <c:choose>
                    <c:when test="${vo.onLineId>0}"><span class="m-l-sm co-green">${messages["playerTag"]["online"]}</span></c:when>
                    <c:otherwise><span class="m-l-sm co-grayc2">${messages["playerTag"]["notOnline"]}</span></c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="form-group clearfix m-b-sm">
            <label class="col-xs-3 al-right">${messages["playerTag"]["accountDisabled"]}：</label>
            <div class="col-xs-9"><input type="checkbox" name="my-checkbox" data-size="mini" ${vo.status==2?'checked':''}></div>
        </div>
        <div class="form-group line-hi34 clearfix m-b-sm">
            <label class="col-xs-3 al-right">${messages["playerTag"]["disableReason"]}：</label>
            <div class="col-xs-9">
                    ${send.title}
                <div class="clearfix">${messages["playerTag"]["disabled_content"]}：</div>
                <textarea class="form-control" disabled>${send.content}</textarea>
            </div>
        </div>
        <div class="form-group clearfix m-b-sm">
            <label class="col-xs-3 al-right line-hi34">${messages["playerTag"]["remark"]}：</label>
            <div class="col-xs-9">
                <textarea class="form-control" disabled>${send.remarks}</textarea>
            </div>
        </div>
        <div class="form-group clearfix">
            <label class="col-xs-3 al-right">${messages["playerTag"]["operator"]}：</label>
            <div class="col-xs-9">
                ${send.createUsername!=null?send.createUsername:'admin'} &nbsp;
                ${soulFn:formatDateTz(send.createTime, DateFormat.DAY_SECOND,timeZone)}
            </div>
        </div>
    </div>
    <input type="hidden" id="status" value="true">
    <div class="modal-footer">
        <soul:button target="${root}/player/view/cancelDisabled.html?userId=${vo.id}" precall="yzStatus" callback="closePage" text="${views['common']['commit']}" cssClass="btn btn-filter" opType="ajax"/>
        <soul:button target="closePage" text="${views['common']['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/player/moreoperate/Moreoperate"/>
</html>
