<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VCttDomainListVo"--%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<div class="table-responsive">
    <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">

            <th>${views.content['项目名称']}</th>
            <th>${views.content['指向地址']}</th>
            <th>${views.content['操作']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="domainTypes" items="${command.result}" varStatus="">
            <tr>
                <td>${domainTypes.name}</td>
                <td>${domainTypes.linkAddress}</td>
                <td>
                        <%--<a href="javascript:void(0)" data-toggle="modal" data-target="#editType">${views.delete-content_auto['编辑']}</a>--%>
                    <soul:button tag="a" target="${root}/content/cttDomain/type/edit.html?id=${domainTypes.id}" callback="reloadDialog" text="${views.content['编辑']}" opType="dialog">

                    </soul:button>
                    <span class="dividing-line m-r-xs m-l-xs">|</span>
                            <soul:button target="${root}/content/cttDomain/type/delete.html?id=${domainTypes.id}" tag="a" confirm="${views.common['confirm.delete']}" text="${views.content['删除']}" opType="ajax" callback="reloadDialog"></soul:button>
                    <%--<a href="javascript:void(0)">${views.delete-content_auto['删除']}</a>--%>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
</div>
<div class="line-hi34"><a href="javascript:void(0)" data-toggle="modal" data-target="#addType">${views.content['新增类型']}</a></div>
<soul:pagination cssClass="row" mode="mini"/>
<!--//endregion your codes 1-->
