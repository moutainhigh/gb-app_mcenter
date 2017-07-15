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
        <%--<div id="tip" class="clearfix m-b bg-gray p-t-xs">
                    <span class="co-orange fs36 col-xs-1 al-right m-r-sm">
                        <i class="fa fa-exclamation-circle"></i>
                    </span>
            <div class="line-hi25 m-b-sm">因运营商对手机短信内容中的敏感字和字符长度有限制，
                建议新增或修改模板前，先测试新模板是否能通过运营商成功发送！</div>
        </div>--%>
        <%@ include file="headTmpl.jsp"%>
    </div>
    <%@ include file="footTmpl.jsp"%>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/setting/noticetmpl/NoticeTmplEdit"/>
</html>