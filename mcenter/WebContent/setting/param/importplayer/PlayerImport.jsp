<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

        <div id="validateRule" style="display: none">${command.validateRule}</div>

        <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
            <div class="form-group clearfix m-t-lg">
                <label class="col-sm-3 al-right line-hi34 ft-bold">${views.setting['userplayerImport.selectPlayerFile']}：</label>
                <div class="col-sm-5">
                    <a href="javascript:void(0)" class="btn btn-filter load-w-btn" style="cursor: pointer">
                        <input id="playerFilename" type="file" accept=".xls,.xlsx" name="fileName" target="fileName" style="cursor: pointer">${views.setting['userplayerImport.selectFileButton']}
                    </a>
                    <span class="m-l co-grayc2">${views.setting['userplayerImport.fileSize']}</span>
                </div>
            </div>
            <div class="form-group clearfix line-hi34 hide" id="file-div">
                <label class="col-sm-3 al-right ft-bold">${views.setting['userplayerImport.hasSelectFile']}：</label>
                <div class="col-sm-5">
                    <span id="filename-span"></span><span class="m-l-lg" id="filesize-span"></span>
                </div>
            </div>
        </div>
        <div style="padding-left: 20px">
            <a href="/vUserPlayerImport/list.html" nav-target="mainFrame" class="btn btn-filter btn-outline m-r">${views.common['return']}</a>
            <%--<soul:button target="playerImportIndex" text="${views.common['return']}" opType="function" cssClass="btn btn-filter btn-outline m-r" ></soul:button>--%>
            <soul:button target="doAjax" text="${views.setting['userplayerImport.importButton']}" opType="function" callback="myCallBack" precall="myValidateForm"
                         cssClass="btn btn-filter m-r save-import" ></soul:button>


        </div>

