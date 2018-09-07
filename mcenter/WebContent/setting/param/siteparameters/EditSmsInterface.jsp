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
    <div style="display: none" id="existedSmsInterfaceMap">
            ${existedSmsInterfaceMap}
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
                <div class="clearfix m-b">
                    <div class="ft-bold pull-left line-hi34"
                         style="width: 100px;text-align: right;">
                            ${views.setting_auto['接口用户名']}：
                    </div>
                    <div class="col-xs-5"><input type="text" name="sms.username"
                                                 value="${smsInterfaceVo.result.username}"
                                                 class="form-control"></div>
                </div>
                <div class="clearfix m-b">
                    <div class="ft-bold pull-left line-hi34"
                         style="width: 100px;text-align: right;">${views.setting_auto['接口密码']}：
                    </div>
                    <div class="col-xs-5"><input type="password" name="sms.password"
                                                 value="${smsInterfaceVo.result.password}"
                                                 class="form-control"></div>
                </div>
                <div class="clearfix m-b">
                    <div class="ft-bold pull-left line-hi34"
                         style="width: 100px;text-align: right;">
                            ${views.setting_auto['短信应用ID']}：
                    </div>
                    <div class="col-xs-5"><input type="text" name="sms.appId"
                                                 value="${smsInterfaceVo.result.appId}"
                                                 class="form-control"></div>
                </div>
                <div class="clearfix m-b">
                    <div class="ft-bold pull-left line-hi34"
                         style="width: 100px;text-align: right;">${views.setting_auto['接口密钥']}：
                    </div>
                    <div class="col-xs-5">
                        <textarea name="sms.dataKey"class="form-control">${smsInterfaceVo.result.dataKey}</textarea>
                    </div>
                </div>
                <div class="clearfix m-b">
                    <div class="ft-bold pull-left line-hi34" style="width: 100px;text-align: right;">${views.setting_auto['接口签名']}：
                    </div>
                    <div class="col-xs-5"><input type="text" name="sms.signature" maxlength="30"
                                                 value="${smsInterfaceVo.result.signature}"
                                                 class="form-control"></div>
                </div>
                <div class="modal-footer">
                    <soul:button cssClass="btn btn-filter" text="${views.common['save']}"
                                 opType="ajax"
                                 dataType="json"
                                 target="${root}/smsInterface/saveSmsInterface.html"
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