<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/include/include.inc.jsp" %>
<nav>
  <h1 class="name">捷报系统中心 <font>statement system</font></h1>
  <ul class="list-group" id="side-menu">
      <c:forEach items="${command}" var="obj" varStatus="status">
        <li class="list-group-item <c:if test='${status.count==1}'>active</c:if>"><p class="tit">
          <i class="${obj.object.resourceIcon}"></i>
          <a href="<c:if test='${empty obj.object.resourceUrl}'>#</c:if>${obj.object.resourceUrl}">${views.sysResource[obj.object.resourceName]}</a></p>
          <c:if test='${not empty obj.children}'>
          <ul class="hideMenu" style="display: <c:if test='${status.count==1}'>block</c:if><c:if test='${status.count!=1}'>none</c:if>;">
            <c:forEach items="${obj.children}" var="cobj" varStatus="cstatus">
              <li><a nav-target='mainFrame' href="<c:if test='${empty cobj.object.resourceUrl}'>#</c:if>${cobj.object.resourceUrl}">${views.sysResource[cobj.object.resourceName]}</a></li>
            </c:forEach>
          </ul>
          </c:if>
        </li>
      </c:forEach>
  </ul>
</nav>