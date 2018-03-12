<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
	<table align="center" id="previewImgDiv">
		<tr><th style="text-align: center;">${views.content['预览效果']}</th></tr>
		<tr>

			<td style="text-align: center;">
				<a href="javascript:void(0);" onclick="javascript:document.getElementsByTagName('BODY')[0].scrollTop=0;" id="areamap"></a>
				<c:forEach var="pic" items="${command.itemList}">
					<c:set value="${pic.normalEffect}" var="image"></c:set>
					<c:if test="${command.result.singleMode}">
						<c:set var="image" value="${command.floatPicItem.normalEffect}"></c:set>
					</c:if>
					<%--<c:if test="${command.result.singleMode&&not empty command.floatPicItem.normalEffect}">
						<img src="${resRoot}/${command.floatPicItem.normalEffect}" alt="${command.result.title}" class="singleModeTemplateImageType">
					</c:if>--%>
					<c:if test="${not empty image}">
						<img src="${soulFn:getThumbPath(domain, image, 160, 170)}" class="listModeTemplateImageType"><br>
					</c:if>
				</c:forEach>
				<%--<c:if test="${!command.result.hideCloseButton}">
					<img src="${resRoot}/mcenter/images/floatpic/close.png">
				</c:if>--%>
			</td>
		</tr>
		<tr>
			<td style="padding: 50px 0px 0px 0px;">
				<soul:button target="returnEdit" text="${views.content_auto['返回修改']}" opType="function" cssClass="btn btn-filter btn-lg m-r"></soul:button>
				<soul:button cssClass="btn btn-filter btn-lg m-r _enter_submit" text="${views.content_auto['发布']}"
							 opType="ajax" dataType="json" target="${root}/cttFloatPic/persist.html"
							 precall="valiDateFormAndSubmit" post="getCurrentFormData" callback="goToLastPage" refresh="true"/>
			</td>
		</tr>
	</table>
