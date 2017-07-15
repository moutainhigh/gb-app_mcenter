<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.CttLogoVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<html lang="zh-CN">
<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
</head>

<body>

<form:form id="editForm" action="${root}/cttLogo/edit.html" method="post">
    <form:hidden path="result.id" />
    <gb:token></gb:token>
    <input hidden value="${command.logoId}" name="logoId" id="logoId">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="modal-body">
        <c:set value="${command.result}" var="p"></c:set>
        <%--logo名称输入框--%>
        <div class="form-group">
            <label><span class="co-red">*</span>${views.column['CttLogo.name']}：</label>
            <input name="result.name" class="form-control" placeholder="${views.content['logo.logoName.tips']}"
                ${p.isDefault?'readonly':''} maxlength="20" value="${p.name}" />
        </div>
        <div class="form-group">
            <label><span class="co-red">*</span>${views.column['CttLogo.path']}：</label><span class="m-l co-grayc2">（${views.content['logo.size.introduce']}）</span>
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
        <div class="form-group">
            <label>${views.content['logo.flash']}：</label><span class="m-l co-grayc2">（${views.content['flashlogo.size.introduce']}）</span>
            <div class="form-group m-b-sm">
                <div>
                    <c:if test="${not empty p.flashLogoPath}">
                        <div class="file-preview">
                            <div class="close fileinput-remove delete-img-btn">×</div>
                            <div class="">
                                <div class="file-preview-thumbnails">
                                    <div class="file-preview-frame" id="" data-fileindex="0">
                                        <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="274" height="103" id="logo" align="middle">
                                            <param name="movie" value="${soulFn:getImagePath(domain,p.flashLogoPath)}" />
                                            <param name="wmode" value="transparent" />
                                            <param name="menu" value="false" />
                                            <object type="application/x-shockwave-flash" data="${soulFn:getImagePath(domain,p.flashLogoPath)}" width="274" height="103">
                                                <param name="movie" value="${soulFn:getImagePath(domain,p.flashLogoPath)}" />
                                                <param name="wmode" value="transparent" />
                                                <param name="menu" value="false" />
                                            </object>
                                        </object>
                                        <div class="file-thumbnail-footer">
                                            <div class="file-footer-caption"></div>

                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>    <div class="file-preview-status text-center text-success"></div>
                                <div class="kv-fileinput-error file-error-message" style="display: none;"></div>
                            </div>
                        </div>

                    </c:if>
                </div>
                <input id="flash_file_path" class="file" type="file" accept="swf" name="image_file_path" target="result.flashLogoPath">
                <input type="hidden" class="logo-path" name="result.flashLogoPath" value="${p.flashLogoPath}">
            </div>
        </div>

        <%--使用时间选择--%>
        <div class="form-group ${p.isDefault == true?'hide':''}">

            <label><span class="co-red">*</span>${views.column['CttLogo.useTime']}</label>
            <div class="input-daterange input-group" id="datepicker" style="width:100%">
                <gb:dateRange format="${DateFormat.DAY_SECOND}"  style="width:160px" useRange="true" startDate="${p.startTime}" endDate="${p.endTime}"
                              position="up" startName="result.startTime" endName="result.endTime"
                              minDate="${maxEndTime}"></gb:dateRange>
                    <span id="status" style="padding-left: 10px"></span>
           </div>
            <%--编辑页面显示当前操作logo的状态--%>

        </div>

        <%--隐藏域--%>
        <div id="hidden">
            <input hidden value="${soulFn:formatDateTz(p.createTime, DateFormat.DAY_SECOND,timeZone)}" name="result.createTime">
            <input hidden value="${p.createUser}" name="result.createUser">
            <input hidden value="${p.isDefault}" name="result.isDefault">
            <input hidden value="${p.isDelete}" name="result.isDelete">
            <input hidden value="${p.isRemove}" name="result.isRemove">
            <input hidden value="${p.isRead}" name="result.isRead">
            <input hidden value="${p.checkParentId}" name="result.checkParentId">
            <input hidden value="${p.checkStatus}" name="result.checkStatus">
        </div>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter ok-btn disabled" text="${views.common['OK']}" opType="ajax"
                     target="${root}${p.isDefault?'/cttLogo/editDefault.html':'/cttLogo/persist.html'}" precall="uploadFile" post="getCurrentFormData" callback="saveCallbak"/>
        <soul:button cssClass="btn btn-outline btn-filter" opType="function" target="close" text="${views.common['cancel']}"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/cttlogo/LogoEdit"/>
<!--//endregion your codes 1-->
</html>