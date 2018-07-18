<%-- @elvariable id="command" type="org.soul.model.sys.po.SysParam" --%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<html lang="zh-CN">
<head>
    <title>棋牌包网分享图片</title>
    <%@ include file="/include/include.head.jsp" %>
</head>

<body>

<form:form id="" action="" method="post">
    <gb:token></gb:token>
    <input hidden id="paramId"  name="paramId" value="${chessShareParam.id}">
    <input hidden id="paramCode" name="paramCode" value="${chessShareParam.paramCode}">
    <div class="modal-body">
        <c:set value="${chessShareParam}" var="p"></c:set>
        <div class="form-group">
            <label>${views.content['carousel.uploadPicture']}：</label>
            <span class=" m-l-xs co-grayc2">${views.content['carousel.uploadPictureTips']}</span>
            <div class="form-group m-b-sm">
                <input id="chess_file_path" class="file" type="file" value="" name="chess_file_path" target="result.paramValue">
                <input type="hidden"class="chess-path" name="result.paramCode" value="${p.paramCode}">
                <input type="hidden"class="chess-id" name="result.id" value="${p.id}">
                <input type="hidden" name="result.paramValue">
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.common['OK']}" opType="function"
                     target="saveParam" precall="uploadFile" post="getCurrentFormData" callback=""/>
        <soul:button cssClass="btn btn-outline btn-filter" opType="function" target="closePage" text="${views.common['cancel']}"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/setting/param/siteParam/UploadChessSharePicture"/>
<!--//endregion your codes 1-->
</html>