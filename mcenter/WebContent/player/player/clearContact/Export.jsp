<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html lang="zh-CN">
<head>
  <%@ include file="/include/include.head.jsp" %>
  <!-- Gritter -->
</head>
<div>
<form>
  <c:set var="userId"></c:set>
  <c:forEach items="${model.ids}" var="ids">
  <c:choose>
  <c:when test="${userId eq ''}">
    <c:set var="userId" value="${ids}"></c:set>
  </c:when>
  <c:otherwise>
    <c:set var="userId" value="${userId},${ids}"></c:set>
  </c:otherwise>
  </c:choose>
  </c:forEach>
  <input type="hidden" name="ids" id="userId" value="${userId}">
  <div class="modal-body clearfix">
  <div class="tip">
    <ul>
      <li>${views.role['Player.clearcontact.Export.tip1']}</li>
      <li>${views.role['Player.clearcontact.Export.tip2']}</li>
    </ul>
    <i class="fa fa-exclamation-circle"></i>
  </div>
  <input type="hidden" id="idsLength" value="${fn:length(model.ids)}">
  <div class="m-b-sm">${views.role['Player.clearcontact.Export.currentSelect']}<span class="co-yellow _idsLength"></span>
  ${views.role['Player.clearcontact.Export.playerCount']}<span class="co-yellow" id="exportCount"></span>${views.role['Player.clearcontact.Export.suggest']}</div>
<%--</div>--%>

  </div>
  <div class="modal-footer">
    <%--<button type="button" class="btn btn-filter" data-toggle="modal" data-target="#sign-out">${views.player_auto['先导出']}</button>--%>
<c:if test="${queryparamValue.paramValue}">
    <soul:button tag="button" text="${views.role['Player.clearcontact.Export.ExportFrist']}" target="exportData" opType="function" cssClass="btn btn-filter"></soul:button>
</c:if>
    <soul:button precall="getIds" callback="clearCallback" tag="button" text="${views.role['Player.clearcontact.Export.clear']}" title="${views.role['Player.clearcontact.Export.clearcontact']}"
                 target="${root}/userPlayer/clearContact.html?playerId={playerIds}&idsLength={length}" opType="dialog" cssClass="btn btn-outline btn-filter"></soul:button>

  </div>
</form>
  <form id="exportForm" action="${root}/player/exportRecords.html" method="post" >
    <input type="hidden" name="ids" value="" id="exportIds">
    <input type="hidden" name="exportFrom" value="clearContract" id="exportFrom">
    <input type="hidden" name="needCallBack" value="true" id="needCallBack">
  </form>
</div>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/player/clearcontact/clearContact"/>
</html>
