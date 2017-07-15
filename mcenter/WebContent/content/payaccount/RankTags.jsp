<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-6-30
  Time: 下午5:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<c:forEach items="${tags}" var="pt">
  <li class="player_tags" title="${pt.tagName}" data-search="${pt.tagName}">

    <label>
          <c:choose>
            <c:when test="${pt.playerCount eq userLen}">
              <input type="checkbox" class="tag_checkbox" data-value="${pt.id}" data-status="full_checked" value="1" data-toggle="checkbox-x" data-size="xs" data-three-state="false">
            </c:when>
            <c:when test="${pt.playerCount eq 0}">
              <input type="checkbox" class="tag_checkbox" data-value="${pt.id}" data-status="no_checked" value="0" data-toggle="checkbox-x"  data-size="xs" data-three-state="false">
            </c:when>
            <c:otherwise>
              <input type="checkbox" class="tag_checkbox" data-value="${pt.id}" data-status="half_checked" data-check-status="half" value="" data-toggle="checkbox-x" data-size="xs" data-three-state="true">
            </c:otherwise>
          </c:choose>
         <c:out value="${pt.tagName}"/>
    </label></li>
</c:forEach>

  <c:set var="tag_userId"></c:set>
  <c:forEach items="${userIds}" var="userId">
    <c:choose>
      <c:when test="${tag_userId eq ''}">
        <c:set var="tag_userId" value="${userId}"></c:set>
      </c:when>
      <c:otherwise>
        <c:set var="tag_userId" value="${tag_userId},${userId}"></c:set>
      </c:otherwise>
    </c:choose>
  </c:forEach>
<input type="hidden" value="${tag_userId}" id="tag_userId"/>
