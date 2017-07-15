<%--@elvariable id="command" type="so.wwb.gamebox.model.company.site.vo.SiteCustomerServiceListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
            <thead>
            <tr role="row" class="bg-gray">
                <%--<th><input type="checkbox" class="i-checks"></th>--%>
                    <th>${views.common['number']}</th>
                <th>ID</th>
                <th>${views.setting['customerServiceType']}</th>
                <th>${views.setting['customerservice.Index.name']}</th>
                <th>${views.setting['customerservice.Index.parameter']}</th>
                <th>${views.setting['common.operate']}</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr>
                    <%--<td><label><input type="checkbox" class="i-checks" value="${p.id}"></label></td>--%>
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                    <td>${p.code}</td>
                    <td>
                        ${empty p.type ? views.setting['siteCustomerService.1']:views.setting['siteCustomerService.'.concat(p.type)]}
                    </td>
                    <td>${p.name}</td>
                    <td>${empty p.parameter?'----':p.parameter}</td>
                    <td>
                        <%--<c:if test="${!p.builtIn}">
                            <soul:button text="${views.setting['common.delete']}" key="${p.id}" precall="validateDelete" target="${root}/siteCustomerService/del.html?id=${p.id}" post="getSelectIds" opType="ajax" callback="showMsg"></soul:button>
                        </c:if>--%>
                        <soul:button target="${root}/siteCustomerService/edit.html?id=${p.id}" text="${views.setting['common.edit']}" opType="dialog" callback="query"/>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
