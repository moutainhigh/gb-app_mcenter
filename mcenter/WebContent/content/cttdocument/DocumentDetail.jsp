<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
    <title>${views.common['detail']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>

<body>
<form:form action="${root}/cttDocument/showDocumentDetail.html?search.id=${command.search.id}" method="post">

    <div class="modal-body">
        <div class="${fn:length(languageList)>1?'input-group':''} m-t-sm">
            <ul class="artificial-tab clearfix">
                <c:forEach var="lang" items="${languageList}" varStatus="status">
                    <li data-target="#content${lang.language}">
                        <a href="javascript:void(0)" class="${status.index==0?'current':''} langtag" id="${lang.language}" name="${lang.language}">
                            <span class="con">${dicts.common.local[lang.language]}</span>
                        </a>
                    </li>
                </c:forEach>
            </ul>
            <c:if test="${not empty command.i18nMap.get(command.result.id.toString()).result}">
                <c:forEach var="lang" items="${languageList}" varStatus="status">
                    <c:forEach var="i18n" items="${command.i18nMap.get(command.result.id.toString()).result}">
                        <c:if test="${lang.language==i18n.local}">
                            <div class="note-editable m-l m-r ${status.index==0?'':'hide'} contentDiv" id="content${lang.language}">
                                <h2 style="text-align: center">
                                    <c:if test="${not empty command.parentMap.get(command.result.id)}">
                                        <c:forEach var="parentI18n" items="${command.i18nMap.get(command.result.parentId.toString()).result}">
                                            <c:if test="${lang.language==parentI18n.local}">
                                                <font style="font-size: 12px;">${parentI18n.title}-</font>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                ${i18n.title}</h2>
                                ${i18n.content}
                            </div>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </c:if>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-outline btn-filter" opType="function" target="closePage"
                     text="${views.common['cancel']}"/>

    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 3-->
<soul:import res="site/content/cttdocument/DocumentDetail"/>
<!--//endregion your codes 3-->
</html>