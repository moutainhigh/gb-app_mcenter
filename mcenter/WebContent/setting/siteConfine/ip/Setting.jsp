<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.SiteConfineIpListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<html lang="zh-CN">
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>

<body>
<form:form id="editForm" action="${root}/sysRole/edit.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <form:hidden path="sysParam.paramValue" id="paramValue"/>
    <form:hidden path="sysParam.id" id="paramId"/>
    <form:hidden path="type" id="type"/>
    <div class="modal-body">
        <div class="clearfix line-hi34 m-b-sm">
            <label class="ft-bold">${views.setting_auto['启用']}：</label>
                <input type="checkbox" open2="${views.setting['siteConfine.ip.site.playerMsg']}" close2="${views.setting['siteConfine.ip.site.playerMsg.colse']}" open3="${views.setting["siteConfine.ip.site.admin.playerMsg"]}" close3="${views.setting['siteConfine.ip.site.admin.playerMsg.colse']}" id="paramValue" data-size="mini" name="my-checkbox" ${command.sysParam.paramValue.equals("true")?'checked':''}/>
        </div>
        <div class="clearfix m-b bg-gray p-t-xs">
                    <span class="co-orange fs36 line-hi25 col-xs-1 al-right m-r-sm">
                        <i class="fa fa-exclamation-circle"></i>
                    </span>

            <div class="line-hi34 m-b-sm"><span id="showMsg">${command.sysParam.paramValue.equals("true")?views.setting[command.type.equals("2")?"siteConfine.ip.site.playerMsg.colse":"siteConfine.ip.site.admin.playerMsg.colse"]:views.setting[command.type.equals("2")?"siteConfine.ip.site.playerMsg":"siteConfine.ip.site.admin.playerMsg"]}</span></div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.common['OK']}" opType="ajax" dataType="json" target="${root}/siteConfineIp/changeParamValue.html" precall="validateForm" post="getCurrentFormData" callback="saveCallbak" />
        <soul:button cssClass="btn btn-outline btn-filter" text="${views.common['cancel']}" opType="function"
                     target="closePage"/>
    </div>

</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<%--<soul:import type="edit"/>--%>
<soul:import res="site/setting/siteConfine/ip/Setting"/>
</html>
