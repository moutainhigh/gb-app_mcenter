<%@ page import="org.soul.commons.lang.string.I18nTool" %>
<%@ page import="java.util.Locale" %>
<%@ page import="org.soul.model.security.privilege.po.SysRole" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= SysRole.class %>"></c:set>
<div class="table-responsive">
    <table class="table table-condensed table-hover table-striped table-bordered">
        <thead>
        <tr>
            <%--<th width="30px"><input type="checkbox"> </th>--%>
            <th>#</th>
            <c:forEach items="${command.fields}" var="p">
                <soul:orderColumn poType="${poType}" property="${p.key}" column="${views.column[p.value.displayName]}"/></c:forEach>
            <th>${views.common['operate']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr>
                <%--<th><input type="checkbox" value="${p.id}" > </th>--%>
                <td>${status.index+1}</td>
                <c:forEach items="${command.fields}" var="f" varStatus="status">
                    <td>
                        <c:if test="${f.key=='status'}">
                            <c:choose>
                                <c:when test="${p[f.value.feildName] eq 1}">${views.common['enable']}</c:when>
                                <c:when test="${p[f.value.feildName] eq 2}">${views.common['forbidden']}</c:when>
                            </c:choose>
                        </c:if>
                        <c:if test="${f.key!='status'}">
                            ${p[f.value.feildName]}
                        </c:if>
                    </td>
                </c:forEach>
                <td>
                    <div class="joy-list-row-operations">
                        <soul:button target="${root}/msysRole/view.html?id=${p.id}" text="${views.common['view']}" opType="dialog" callback="query"/>
                        <soul:button target="${root}/msysRole/edit.html?id=${p.id}" text="${views.common['edit']}" opType="dialog" callback="query"/>
                        <c:if test="${p.status eq '1'}"><soul:button target="${root}/msysRole/role_permission.html?roleId=${p.id}" text="${views.common['permission']}" opType="dialog" callback="query"/></c:if>
                        <soul:button target="${root}/msysRole/delete.html?id=${p.id}" text="${views.common['delete']}" opType="ajax" dataType="json" confirm="${views.common['confirm.delete']}" callback="query" />
                    </div>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(command.result)<1}">
            <tr>
                <td colspan="${fn:length(command.fields)+2}" class="no-content_wrap">
                    <div>
                        <i class="fa fa-exclamation-circle"></i> ${views.setting_auto['未找到符合条件的信息']}
                    </div>
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<soul:pagination/>
