<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="variable_wrap">
  <input type="hidden" value="" id="focusFlag"/>
  ${views.setting['NoticeTmp.varLabel']}：
  <c:forEach items="${tags}" var="tag" varStatus="index">
    <a href="javascript:void(0)" class="variable" style="display: ${index.index<3?'':'none'}">${views.setting[tag.paramName]} <span>${tag.paramCode}</span></a>
  </c:forEach>
  <%--
  <a href="javascript:void(0)" class="variable">${views.setting['NoticeTmp.varLabel.pwd']} <span><{$upwd}></span></a>--%>
  <a href="javascript:void(0)" class="more" style="display: ${empty tags?'none':''};">${views.setting['NoticeTmp.varLabel.viewMore']} <i class="fa fa-angle-double-right"></i></a>
</div>
