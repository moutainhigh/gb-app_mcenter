<%-- @elvariable id="command" type="org.soul.model.sys.po.SysParam" --%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<html lang="zh-CN">
<head>
    <title>上传自定义提示音</title>
    <%@ include file="/include/include.head.jsp" %>
</head>

<body>

<form:form id="" action="" method="post">
    <gb:token></gb:token>
    <input hidden id="toneId"  name="toneId" value="${toneDefined.id}">
    <input hidden id="toneType" name="" value="${toneDefined.paramCode}">
    <input hidden id="toneid" value="${tone.id}">
    <div class="modal-body">
        <c:set value="${toneDefined}" var="p"></c:set>
        <div class="form-group">
            <label><span class="co-red">*</span>上传提示音：</label><span class="m-l co-grayc2">（请上传mp3,wav格式音频文件,大小限制5M以内.）</span>
            <div class="form-group m-b-sm">
                <input id="tone_file_path" class="file" type="file" value="" name="tone_file_path" target="result.paramValue">
                <input type="hidden"class="tone-path" name="result.paramCode" value="${p.paramCode}">
                <input type="hidden"class="tone-id" name="result.id" value="${p.id}">
                <input type="hidden" name="result.paramValue">
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.common['OK']}" opType="function"
                     target="saveUserDefinedTone" precall="uploadFile" post="getCurrentFormData" callback="saveCallbak"/>
        <soul:button cssClass="btn btn-outline btn-filter" opType="function" target="closePage" text="${views.common['cancel']}"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/setting/preference/UploadUserDefinedTone"/>
<!--//endregion your codes 1-->
</html>