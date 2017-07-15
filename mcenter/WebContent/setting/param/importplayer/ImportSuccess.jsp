<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

    <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
        <div class="clearfix al-center p-lg">
            <i class="fa fa-check-circle co-green fs36 caution-icon"></i>
            <div class="caution-content m-l-sm fs16"><span>${views.setting['userplayerImport.importSuccess']}！</span></div>
        </div>
    </div>
    <div style="padding-left: 20px">
        <soul:button target="toImportPlayer" text="${views.setting['userplayerImport.continueImport']}" opType="function" cssClass="btn btn-filter m-r"></soul:button>
        <%--<a href="/userPlayerImport/playerImport.html" class="btn btn-filter btn-lg m-r" nav-target="mainFrame"
           title="${views.setting['userplayerImport.continueImport']}">${views.setting['userplayerImport.continueImport']}</a>--%>
        <%--<a href="/vUserPlayerImport/list.html" class="btn btn-outline btn-filter btn-lg" nav-target="mainFrame" title="${views.setting['userplayerImport.viewImportRecord']}">${views.setting['userplayerImport.viewImportRecord']}</a>--%>
        <soul:button target="playerImportIndex" text="${views.setting['userplayerImport.viewImportRecord']}" opType="function" cssClass="btn btn-outline btn-filter" ></soul:button>
    </div>

