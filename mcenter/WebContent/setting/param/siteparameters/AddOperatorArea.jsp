<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.SiteOperateAreaVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<html lang="zh-CN">
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <%@ include file="/include/include.js.jsp" %>
</head>

<body>
<form:form id="editForm" action="${root}/sysRole/edit.html" method="post" >
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="modal-body" style="height: 200px">

        <div class="form-group clearfix line-hi34">
            <label class="col-xs-3 al-right"></label>
            <div class="col-xs-8 p-x">
                <div class="pull-left">
                    ${views.setting['siteConfine.area.pormpt']}
                </div>
            </div>
        </div>


        <div class="form-group clearfix line-hi34">
            <label class="col-xs-3 al-right">${views.setting['siteConfine.addConfineArea']}：</label>
            <div class="col-xs-8 p-x">
                <div class="pull-left m-l-sm">
                    <gb:select name="result.code" prompt="${views.common['pleaseSelect']}${views.common['nation']}"
                               ajaxListPath="${root}/regions/list.html"
                               relSelectPath="${root}/regions/list.html" listValue="remark" listKey="dictCode"
                               cssClass="btn-group chosen-select-no-single"/>
                </div>
            </div>
        </div>

    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.common['OK']}" dataType="json" opType="ajax" target="${root}/param/saveOperatorArea.html" precall="validateForm"  post="getCurrentFormData" callback="saveCallbak"/>
        <soul:button cssClass="btn btn-outline btn-filter" text="${views.common['cancel']}" opType="function" target="closePage"/>
    </div>
</form:form>

</body>

<%--<soul:import type="edit"/>--%>
<soul:import res="site/setting/param/siteParam/AddOperatorArea"/>
</html>
