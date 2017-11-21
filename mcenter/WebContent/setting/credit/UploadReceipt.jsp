<%--@elvariable id="command" type="so.wwb.gamebox.model.company.credit.vo.CreditRecordVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<html lang="zh-CN">
<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
</head>

<body>

<form:form id="editForm" action="${root}/creditRecord/uploadReceipt.html" method="post">
    <form:hidden path="result.id" />
    <gb:token></gb:token>
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="modal-body">
        <c:set value="${command.result}" var="p"></c:set>
        <div class="form-group">
            <label><span class="co-red">*</span>${views.setting['credit.creditRecord.uploadReceipt']}：</label><span class="m-l co-grayc2"></span>
            <div class="form-group m-b-sm">
                <div id="logoDiv">
                    <c:if test="${not empty p.path}">
                    <div class="file-preview">
                        <div class="close fileinput-remove delete-img-btn">×</div>
                        <div class="">
                            <div class="file-preview-thumbnails">
                                <div class="file-preview-frame" id="preview-1473681532977-0" data-fileindex="0" style="height: auto">
                                    <img id="picUrl" src="${soulFn:getThumbPath(domain, p.path,0,0)}" style="max-width: 201px;max-height:191px"/>
                                    <div class="file-thumbnail-footer">
                                        <div class="file-footer-caption" ></div>

                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>    <div class="file-preview-status text-center text-success"></div>
                            <div class="kv-fileinput-error file-error-message" style="display: none;"></div>
                        </div>
                    </div>
                    </c:if>
                </div>
                <input id="image_file_path" class="file" type="file" accept="image/png" name="image_file_path" target="result.path">
                <input type="hidden"class="logo-path" name="result.path" id="path" value="${p.path}">
            </div>
        </div>


    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter ok-btn" text="${views.common['OK']}" opType="ajax"
                     target="${root}/creditRecord/saveUploadReceipt.html" precall="uploadFile" post="getCurrentFormData" callback="mySaveCallbak"/>
        <soul:button cssClass="btn btn-outline btn-filter" opType="function" target="closePage" text="${views.common['cancel']}"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/setting/credit/UploadReceipt"/>
<!--//endregion your codes 1-->
</html>