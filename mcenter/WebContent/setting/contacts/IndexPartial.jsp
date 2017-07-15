<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VPayAccountListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th><input type="checkbox" class="i-checks"></th>
            <th>${views.setting['contacts.Index.name']}</th>
            <th>${views.setting['contacts.Index.mail']}</th>
            <th>${views.setting['contacts.Index.phone']}</th>
            <th class="inline">
                <gb:select name="search.sex" value="${command.search.sex}" cssClass="btn-group chosen-select-no-single" prompt="${views.setting['contacts.Index.sex']}" list="${command.sexDict}" callback="query"/>
            </th>
            <th class="inline">
                <gb:select name="search.positionId" value="${command.search.positionId}" cssClass="btn-group chosen-select-no-single" prompt="${views.setting['contacts.Index.position']}" ajaxListPath="${root}/vSiteContacts/queryPositionList.html" listKey="id" listValue="name" callback="query"/>
            </th>
            <th>${views.setting['common.operate']}</th>
        </tr>
        <tr class="bd-none hide">
            <th colspan="${fn:length(command.fields)+3}">
                <div class="select-records"><i class="fa fa-exclamation-circle"></i>${views.role['player.cancelSelectAll.prefix']}&nbsp;<span id="page_selected_total_record"></span>${views.role['player.cancelSelectAll.middlefix']}
                    <soul:button target="cancelSelectAll" opType="function" text="${views.role['player.cancelSelectAll']}"/>${views.role['player.cancelSelectAll.suffix']}
                </div>
            </th>
        </tr>
        </thead>
        <tbody>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <td><label><input type="checkbox" class="i-checks" value="${p.id}"></label></td>
                    <td>${p.name}</td>
                    <td>${soulFn:overlayEmaill(p.mail)}</td>
                    <td>${soulFn:overlayTel(p.phone)}</td>
                    <td>${dicts.common.sex[p.sex]}</td>
                    <td>${p.positionName}</td>
                    <td><soul:button target="${root}/vSiteContacts/edit.html?id=${p.id}" text="${views.setting['common.edit']}" opType="dialog" callback="query"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<soul:pagination/>
</div>
<!--//endregion your codes 1-->
