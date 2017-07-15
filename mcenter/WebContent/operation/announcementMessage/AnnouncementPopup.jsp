<%--
  Created by IntelliJ IDEA.
  User: orange
  Date: 15-12-2
  Time: 下午8:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <title></title>
  <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form>
  <div class="modal-body">
      <pre style="white-space: pre-wrap;word-wrap: break-word;border: 0px;background-color: white;text-indent: -75px;">
          <c:if test="${vSystemAnnouncementListVo.result.size()!=0}">
            ${fn:substring(vSystemAnnouncementListVo.result.get(0).content,0,100)}<c:if test="${fn:length(vSystemAnnouncementListVo.result.get(0).content)>100}">...</c:if>
          </c:if>
      </pre>
  </div>
<c:if test="${vSystemAnnouncementListVo.result.size()!=0}">
    <div class="modal-footer" apiId="${vSystemAnnouncementListVo.result.get(0).apiId}">
        <soul:button target="systemNoticeDetail" text="${views.common['searchDetail']}" opType="function" cssClass="btn btn-filter"/>
    </div>
</c:if>
</form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/operation/SystemNoticeDetail"/>
</html>
