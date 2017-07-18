<%--@elvariable id="vSystemAnnouncementListVo" type="so.wwb.gamebox.model.company.operator.vo.SystemAnnouncementListVo"--%>
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
            ${vSystemAnnouncementListVo.result.get(0).shortContentText100}
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
