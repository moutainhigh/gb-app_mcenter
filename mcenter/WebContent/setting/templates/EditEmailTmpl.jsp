<!DOCTYPE HTML>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html lang="zh-CN">
<html>
<head>
  <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form>
    <gb:token/>
    <div id="validateRule" style="display: none">${validateRule}</div>
    <div class="modal-body">
        <%@ include file="headTmpl.jsp"%>
    </div>
    <%@ include file="footTmpl.jsp"%>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/setting/noticetmpl/NoticeTmplEdit"/>
</html>