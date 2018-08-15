<%@ page import="org.soul.commons.data.json.JsonTool" %>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html lang="zh-CN">
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>

<body>
<form:form>
    <gb:token/>
    <div style="display: none" id="bossSmsInterfaceMap">
        ${bossSmsInterfaceMap}
    </div>
    <div style="display: none" id="siteSmsInterfaceMap">
        ${siteSmsInterfaceMap}
    </div>
    <div class="clearfix">
        <div id="smsInterface" class="col-lg-6 site-switch">
            <ul class="clearfix">
                <div class="clearfix m-b">
                    <div class="ft-bold pull-left line-hi34"
                         style="width: 100px;text-align: right;">${views.setting_auto['接口名称']}：
                    </div>
                    <div class="col-xs-5">
                        <gb:select name="sms.id" value="${smsInterfaceVo.result.id}" callback="changeSmsInterface"
                                   list="${interfaceListVo}" listKey="id" listValue="fullName" />
                    </div>
                </div>
                <div id="smsInterfaceForm"></div>
                <div class="modal-footer">
                    <soul:button cssClass="btn btn-filter" text="${views.common['save']}"
                                 opType="function"
                                 dataType="json"
                                 target="saveSubmit"
                                 precall="validSmsInterface"
                                 post="getSmsInterfaceDateForm" callback="saveCallbak"/>
                </div>
            </ul>
        </div>
    </div>
</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/setting/param/siteParam/EditSmsInterface"/>
</html>