<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.CttDraftVo"--%>
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

<form:form id="editForm" action="${root}/cttDraft/edit.html" method="post">
    <form:hidden path="result.id" />
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <input type="hidden" name="type" value="1">
    <input type="hidden" name="search.childId" value="${command.search.childId}">
    <!--//region your codes 3-->
    <div class="modal-body">
        <c:forEach var="p" items="${languageList}" varStatus="i">
            <%--<div class="form-group clearfix m-b-xxs">
                <label class="col-xs-4 al-right line-hi34 ft-bold">项目名称（${views.common[p.language]}）<span class="co-red">*</span></label>
                <input type="hidden" name="cttDraftList[${i.index}].language" value="${p.language}">
                <div class="input-group m-b col-sm-7 p-x"><input class="form-control _title" name="cttDraftList[${i.index}].title"/></div>
            </div>--%>
            <div class="form-group clearfix m-b-xxs">
                <label class="col-xs-4 al-right line-hi34 ft-bold"><span class="co-red m-r-sm">*</span>${views.content['项目名称']}（${views.common[p.language]}）</label>
                <div class="input-group m-b col-xs-7 p-x"><input type="text" ${p.isInternal?'readonly':''}  value="${p.title}" name="cttDraftList[${i.index}].title" class="form-control" maxlength="20"/></div>
                <input type="hidden" name="cttDraftList[${i.index}].language" value="${p.language}">
                <input type="hidden" name="cttDraftList[${i.index}].parentId" value="${command.search.parentId}">
                <input type="hidden" name="cttDraftList[${i.index}].id" value="${p.id}">
            </div>
        </c:forEach>
    </div>

    <div class="modal-footer">
        <c:if test="${command.search.parentId==0}">
            <soul:button cssClass="btn btn-filter" text="${views.content_auto['保存']}" opType="ajax" dataType="json" target="${root}/cttDraft/persist.html" precall="validateForm" post="getCurrentFormData" callback="saveCallbak"/>
        </c:if>
        <soul:button cssClass="btn btn-outline btn-filter" text="${views.content_auto['下一步']}" opType="function" precall="validateForm" target="toNext"/>
        <%--<a class="btn btn-default" nav-target="mainFrame" href="/cttDraft/editContent.html"></a>--%>
    </div>
    <!--//endregion your codes 3-->

</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/content/cttdraft/EditTitle"/>
<!--//endregion your codes 4-->
</html>