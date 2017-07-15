<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-6-30
  Time: 上午11:20
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <title></title>
  <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form id="editForm" action="${root}/tags/persist.html" method="POST">
  <div class="modal-body">
    <div class="form-group over clearfix">
      <input type="hidden" value="12321" name="max50Tags">
      <form:hidden path="result.id" />
      <div id="validateRule" style="display: none">${command.validateRule}</div>
      <input type="hidden" value="0" name="result.tagType" />
      <label class="control-label">${views.role['Player.list.playerTag.editeTagName']}</label>
      <div class="col-sm-12 p-x">
        <form:input path="result.tagName" cssClass="form-control"></form:input>
      </div>
    </div>
    <div class="form-group over clearfix">
      <label class="control-label">${views.role['Player.list.playerTag.editTagDescribe']}</label>
      <div class="col-sm-12 p-x">
        <form:textarea path="result.tagDescribe" cssClass="form-control"></form:textarea>
      </div>
    </div>
  </div>
  <div class="modal-footer">
    <soul:button target="save" tag="button" opType="function" callback="closePage" post="getCurrentFormData" cssClass="btn btn-filter" precall="validateForm" text="${views.common['confirm']}"></soul:button>
    <soul:button target="closePage" tag="button" opType="function" cssClass="btn btn-outline btn-filter" text="${views.common['cancel']}"></soul:button>
  </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/player/tag/Tags"/>
</html>