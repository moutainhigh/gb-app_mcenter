<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.RemarkVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="form-group clearfix m-b-sm col-xs-12 preview">
    <label class="col-xs-3 al-right">${messages["playerTag"]["account"]}：</label>

    <div class="col-xs-9 p-x">${username}
        <c:choose>
            <c:when test="${onLineId>0}"><span
                    class="m-l-sm co-green">${messages["playerTag"]["online"]}</span></c:when>
            <c:otherwise><span
                    class="m-l-sm co-grayc2">${messages["playerTag"]["notOnline"]}</span></c:otherwise>
        </c:choose>
    </div>
</div>
<c:if test="${not empty title}">
    <div class="form-group line-hi34 clearfix m-b-sm col-xs-12 preview">
        <label class="col-xs-3 al-right">${messages["playerTag"]["kickOutTheReason"]}：</label>
        <div class="col-xs-9 p-x">
            ${title}
            <div class="clearfix">${messages["playerTag"]["disabled_content"]}：</div>
        </div>
    </div>
    <div class="form-group clearfix m-b-sm col-xs-12 preview">
        <label class="col-xs-3 al-right line-hi34">${messages["playerTag"]["disabled_content"]}：</label>
        <div class="col-xs-9 p-x">
            <textarea id="s_reasonContent" name="reasonContent" class="form-control m-t-xs" disabled>${reasonContent}</textarea>
            <input id="s_rContent" value="${reasonContent}" type="hidden"/>
        </div>
    </div>
</c:if>
<div class="form-group clearfix m-b-sm col-xs-12 preview">
    <label class="col-xs-3 al-right line-hi34">${messages["playerTag"]["remark"]}：</label>
    <div class="col-xs-9 p-x">
        <textarea class="form-control" disabled>${remark}</textarea>
    </div>
</div>
