<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="m-t-sm" id="preview-content">
	<ul class="artificial-tab clearfix">
		<c:forEach var="lang" items="${languageList}" varStatus="status">
			<li data-target="#content${lang.language}">
				<a href="javascript:void(0)" class="${status.index==0?'current':''} langtag" id="${lang.language}" name="${lang.language}">
					<span class="con">${dicts.common.local[lang.language]}</span>
				</a>
			</li>
		</c:forEach>
	</ul>
	<c:if test="${not empty command.documentI18ns}">
		<c:forEach var="lang" items="${languageList}" varStatus="status">
			<c:forEach var="i18n" items="${command.documentI18ns}">
				<c:if test="${lang.language==i18n.local}">
					<div class="note-editable m-l m-r ${status.index==0?'':'hide'} contentDiv" id="content${lang.language}">
						<h2 style="text-align: center">${i18n.title}</h2>
						${i18n.content}
					</div>
				</c:if>
			</c:forEach>
		</c:forEach>
	</c:if>
	<div class="operate-btn">

		<soul:button target="toPrevious" dataType="json" cssClass="btn btn-filter btn-lg" opType="function" text="${views.common['previous']}" ></soul:button>
		<soul:button target="${root}/cttDocumentI18n/saveFromEditContent.html?isPublish=true" dataType="json" cssClass="btn btn-filter btn-lg pull-right"
					 opType="ajax" text="${views.common['release']}" precall="myValidateForm" post="getCurrentFormData" callback="toDocumentList"></soul:button>
	</div>
</div>

