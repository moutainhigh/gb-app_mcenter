<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>

<body>

<form:form id="editForm" action="${root}/cttDocumentI18n/edit.html" method="post">
    <gb:token></gb:token>
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <input type="hidden" name="cttDocumentVo.id" value="${command.cttDocumentVo.id}">
    <input type="hidden" name="parentVo.id" value="${command.parentVo.id}">
    <input type="hidden" name="documentId" id="documentId" value="${command.documentId}">

    <%--<input type="hidden" name="search.childId" value="${command.search.childId}">--%>
    <!--//region your codes 3-->
    <div class="modal-body">
        <input type="hidden" name="result.noblank" value="blank">
        <div class="form-group clearfix m-b-xxs">
            <label class="col-xs-5 al-right line-hi34 ft-bold p-x"><span class="co-red m-r-sm">*</span>Code：</label>
            <div class="input-group m-b col-xs-7 p-x">
                <input type="text" value="${command.cttDocumentVo.code}" name="cttDocumentVo.code" ${command.cttDocumentVo.id!=null?'readonly':''}
                       class="form-control not-null-css" maxlength="20"  />
                    ${views.content['document.codeTips']}
            </div>
        </div>
        <c:forEach var="p" items="${languageList}" varStatus="i">
            <c:forEach var="document" items="${command.documentI18ns}">
                <c:if test="${p.language==document.local}">
                    <div class="form-group clearfix m-b-xxs">
                        <label class="col-xs-5 al-right line-hi34 ft-bold p-x"><span class="co-red m-r-sm">*</span>（${views.common[p.language]}）${views.content['document.projectName']}：</label>
                        <div class="input-group m-b col-xs-7 p-x">
                            <input type="text" value="${document.title}" name="documentI18ns[${i.index}].title" ${command.cttDocumentVo.buildIn&&document.id!=null?'readonly':''}
                                   class="form-control not-null-css" maxlength="20" ${command.cttDocumentVo.buildIn&&document.id!=null?'style="background-color: #eee"':''}/>
                        </div>
                        <input type="hidden" name="documentI18ns[${i.index}].id" value="${document.id}">
                        <input type="hidden" name="documentI18ns[${i.index}].local" value="${p.language}">
                        <input type="hidden" name="documentI18ns[${i.index}].documentId" value="${document.documentId}">
                        <input type="hidden" name="documentI18ns[${i.index}].content" value="">
                    </div>
                </c:if>
            </c:forEach>
        </c:forEach>
    </div>

    <div class="modal-footer">
        <c:if test="${empty command.parentVo.id}">
            <soul:button cssClass="btn btn-filter ok-btn disabled" text="${views.common['save']}" opType="ajax" dataType="json"
                         target="${root}/cttDocumentI18n/persist.html?isPublish=true&saveFrom=1" precall="validateForm" post="getCurrentFormData" callback="saveCallbak"/>
        </c:if>
        <soul:button cssClass="btn btn-filter cancel-btn disabled" text="${views.common['next']}" opType="ajax" dataType="json"
                     target="${root}/cttDocumentI18n/saveInSession.html" precall="validateForm" post="getCurrentFormData" callback="saveNext"/>

    </div>
    <!--//endregion your codes 3-->

</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/content/cttdocument/Edit"/>
<!--//endregion your codes 4-->
</html>