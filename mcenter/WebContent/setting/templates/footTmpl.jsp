<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:if test="${true || !noticeTmpl.builtIn}">
    <div class="modal-footer">
    <c:if test="${!noticeTmpl.builtIn || noticeTmpl.tmplType eq 'auto'}">
        <soul:button precall="_validateForm" tag="button" opType="function" target="saveNoticeTmpl" cssClass="btn btn-filter" text="${views.common['commit']}">${views.common['commit']}</soul:button>
    </c:if>
        <soul:button target="closePage" tag="button" opType="function" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter">${views.common['cancel']}</soul:button>
    </div>
</c:if>
<input type="hidden" value="${maxLang}" id="maxLang">
<input type="hidden" value="${langLen}" id="langLen">
