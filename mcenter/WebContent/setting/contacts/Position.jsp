<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.SiteContactsVo"--%>
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

<form:form id="editForm" action="${root}/vSiteContacts/edit.html" method="post">
    <div id="validateRule" style="display: none">${validateRule}</div>
    <gb:token/>
    <!--//region your codes 3-->
    <input id="div_size" type="hidden" value="${list.size()}"/>
    <div class="modal-body">
        <%--<div class="col-xs-12 co-grayc2 al-right m-b-sm">${views.setting_auto['点击名称修改']}</div>--%>
        <c:forEach items="${list}" var="p" varStatus="status">
        <div class="line-hi34 input-group date" id="div_${status.index}">
            <input type="hidden" value="${p.id}" name="sp[${status.index}].id">
            <input type="text" value="${p.name}" name="sp[${status.index}].name" maxlength="20" class="form-control">
            <span class="input-group-addon"><a href="javascript:void(0)" tc="${p.count}" class="delCss" tt="div_${status.index}"><i class="fa fa-minus"></i></a></span>
        </div>
        </c:forEach>
        <div id="add_div"><a href="javascript:void(0)" id="addPosition"><i class="fa fa-plus"></i> ${views.setting['contacts.Position.add']} </a></div>
    </div>
    <input type="hidden" value="1" name="test">
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.setting['common.ok']}" opType="ajax" dataType="json"
                     target="${root}/vSiteContacts/savePosition.html" precall="validateForm" post="getCurrentFormData"
                     callback="saveCallbak"/>
        <soul:button target="closePage" text="${views.setting['common.cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
    </div>
    <!--//endregion your codes 3-->

</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/setting/contacts/Position"/>
<!--//endregion your codes 4-->
</html>