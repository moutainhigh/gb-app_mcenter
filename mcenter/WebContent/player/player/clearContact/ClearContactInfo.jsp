<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html lang="zh-CN">
<head>
  <title>${views.role['Player.clearcontact.title']}</title>
  <%@ include file="/include/include.head.jsp" %>
  <!-- Gritter -->
  <link href="${resComRoot}/themes/${curTheme}/style.css" rel="stylesheet">
  <link href="${resComRoot}/themes/${curTheme}/content.css" rel="stylesheet">
</head>
<body>
<!--清除联系方式弹窗-->
<form>
  <%--<c:set var="userId"></c:set>--%>
  <%--<c:forEach items="${model.ids}" var="ids">--%>
    <%--<c:choose>--%>
      <%--<c:when test="${userId eq ''}">--%>
        <%--<c:set var="userId" value="${ids}"></c:set>--%>
      <%--</c:when>--%>
      <%--<c:otherwise>--%>
        <%--<c:set var="userId" value="${userId},${ids}"></c:set>--%>
      <%--</c:otherwise>--%>
    <%--</c:choose>--%>
  <%--</c:forEach>--%>
  <input type="hidden" name="ids" id="userId" value="${model.playerId}">
  <div class="modal-body">
    <div class="m-b-md">${views.role['Player.clearcontact.ClearContactInfo.operating']}<span class="co-yellow">${model.idsLength}</span>${views.role['Player.clearcontact.ClearContactInfo.data']}</div>
    <%--<div class="m-b-sm">${views.role['Player.clearcontact.ClearContactInfo.hint']}!</div>--%>
    <div class="form-group bg-gray" id="type-div">
      <%--<label class="m-r"><input type="checkbox" name="contactType" value="mobilePhone"/>${views.column['VUserPlayer.phone']}</label>--%>
      <%--<label class="m-r"><input type="checkbox" name="contactType" value="mail"/>${views.column['VUserPlayer.mail']}</label>--%>
      <c:forEach var="type" items="${model.contactTypeMap}" varStatus="i">
        <c:if test="${type.value.dictCode!='302'&&type.value.dictCode!='303'}">
        <label class="m-r">
          <input type="checkbox" name="contactType" value="${type.value.dictCode}"/>
          ${dicts[type.value.module][type.value.dictType][type.value.dictCode]}
        </label>
        </c:if>
      </c:forEach>
    </div>
  </div>
  <div class="modal-footer">
    <soul:button target="${root}/userPlayer/clear.html"  precall="validForm" post="getCurrentFormData" opType="ajax" callback="deleteCallbak" dataType="json" cssClass="btn btn-filter" text="${views.common['OK']}"></soul:button>
    <soul:button target="closePage" opType="function" cssClass="btn btn-outline btn-filter" text="${views.common['cancel']}"></soul:button>
  </div>
</form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/player/clearcontact/clearContact"/>
</html>