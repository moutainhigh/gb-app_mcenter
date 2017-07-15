<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="clearfix p-xs border-b-1 line-hi34">
    <soul:button tag="button" text="${views.setting['userplayerImport.importIntroduce']}" target="showImportList" opType="function" cssClass="btn btn-filter btn_list"></soul:button>
    <soul:button tag="button" text="${views.setting['userplayerImport.importProcess']}" target="showImportIntroduce" opType="function" cssClass="btn btn-filter btn-outline btn_introduce"></soul:button>
</div>
<%--${fn:replace(fn:replace(fn:replace(views.setting['userplayerImport.introduceContent'],"#{endTime}" ,soulFn:formatDateTz(endImportTime, DateFormat.DAY_SECOND,timeZone)),"#{downloadUrl}",resRoot.concat("/template/user_player_template_zh_CN.xlsx")),"#{toImportUrl}","/userPlayerImport/playerImport.html")}--%>
<div class="clearfix line-hi34 p-sm" id="introduce-div">
    <dd class="m-b-sm">1、${views.setting_auto['您可通过该功能将你其他站点的玩家资料导入到本站点；']}</dd>
    <dd class="m-b-sm">2、${views.setting_auto['导入后，即可将原站点域名解析到本站点；']}</dd>
    <dd class="m-b-sm">3、${views.setting_auto['原站点玩家登录时需要进行验证，验证通过后即可正常使用；']}</dd>
</div>
<div class="clearfix line-hi34 p-sm hide" id="process-div">
    <dd class="m-b-sm">1、${views.setting_auto['建议可先在原站点发布升级维护公告，公告内容大概如下：']}
        <div class="m-t-sm m-l-md">
            <div class="gray-chunk clearfix">
                <p>${views.setting_auto['尊敬的玩家，您好！']}</p>
                ${views.setting_auto['年月日']}


            </div>
        </div>
    </dd>
    <dd class="m-b-sm">2、${views.setting_auto['进入维护后，按要求填写《导入玩家资料》表格；']}</dd>
    <dd class="m-b-sm">3、${views.setting_auto['在本站点上传《导入玩家资料》表格，并将原站点域名解析到本站点；']}</dd>
</div>
<div class="clearfix line-hi34 p-sm">
    <dd class="m-b-sm m-t-lg"><b>${views.setting_auto['导入玩家功能开放截止时间']}：</b>${soulFn:formatDateTz(endImportTime, DateFormat.DAY_SECOND,timeZone)}<span class="m-l co-grayc2">${views.setting_auto['超过截止时间，将关闭导入玩家功能；']}</span></dd>
    <dd class="m-b-sm m-t-md"><b>${views.setting_auto['《导入玩家资料》文档：']}</b>
        <a href="${resRoot}/template/user_player_template_zh_CN.xlsx" target="_blank" class="btn btn-filter" download="${views.setting_auto['导入玩家资料']}.xlsx">${views.setting_auto['下载']}</a>
        <%--<a type="button" href="javascript:void(0)" class="btn btn-filter">${views.setting_auto['下载']}</a>--%>
        <span class="m-l co-orange">${views.setting_auto['填写前请仔细阅读填写要求；']}</span>
    </dd>
    <dd class="m-b-sm m-t-md"><b>${views.setting_auto['导入玩家资料']}</b>
        <soul:button target="toImportPlayer" text="${views.setting_auto['导入']}" opType="function" cssClass="btn btn-filter m-l"></soul:button>
    </dd>
</div>
<div id="editable_wrapper" class="dataTables_wrapper search-list-container  import_list panel-body " role="grid">
    <%@ include file="IndexPartial.jsp" %>
</div>
${views.setting['userplayerImport.processContent']}
