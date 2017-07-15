<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.CttDraftVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<c:forEach items="${cttDrafts}" var="p" varStatus="status">
	<tr>
		<td>${p.title}</td>
		<td>${p.status}</td>
		<td>
			<div class="btn-group">
				<c:set value="${0}" var="y"></c:set>
				<c:set value="${0}" var="n"></c:set>
				<c:forEach var="r" items="${cttDrafts}" varStatus="i">
					<c:if test="${r.childId eq p.childId}">
						<c:set var="n" value="${n+1}"></c:set>
						<c:if test="${r.content ne null}">
							<c:set var="y" value="${y+1}"></c:set>
						</c:if>
					</c:if>
				</c:forEach>
				<button data-toggle="dropdown" class="btn btn-warning dropdown-toggle btn-xs">${y}/${n}</button>
				<ul class="dropdown-menu lang">
					<c:forEach var="r" items="${cttDrafts}" varStatus="i">
						<c:if test="${r.childId eq p.childId}">
							<li class=${r.content ne null?"":"current"}><a>${views.common[r.language]}</a></li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</td>
		<td>${p.publishTime}</td>
		<td class="_ss"></td>
		<td><input type="checkbox" name="my-checkbox" data-size="mini" checked></td>
		<td>
			<div class="joy-list-row-operations">
				<c:if test="${p.isInternal!=true}">
					<soul:button target="${root}/cttDraft/deleteDraft.html?search.childId=${p.childId}" text="${views.content_auto['删除']}" opType="ajax"
								 dataType="json" confirm="${views.content_auto['您确定要删除该条记录吗']}？" callback="query"/>
				</c:if>
				<soul:button target="${root}/cttDraft/edit.html?id=${p.id}" text="${views.content_auto['编辑']}" opType="dialog"/>
			</div>
		</td>
	</tr>
</c:forEach>
<tr>
	<td><soul:button target="${root}/cttDraft/create.html" text="${views.content_auto['新增子项']}" opType="dialog"/></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
</tr>