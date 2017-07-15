<%--@elvariable id="command" type="so.wwb.gamebox.model.company.site.vo.VSiteApiVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>

<body>
<!--//region your codes 3-->
<form:form id="editForm" action="${root}/siteApiI18n/updateSiteApi.html" method="post">
    <form:hidden path="result.id" />
    <%--<input type="hidden" name="search.apiId" value="${command.search.apiId}">--%>
    <input type="hidden" name="siteApi.id" value="${command.siteApi.id}">
    <input type="hidden" name="siteApi.apiId" value="${command.siteApi.apiId}">
    <input type="hidden" name="siteApi.siteId" value="${command.siteApi.siteId}">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="modal-body">
        <div class="input-group m-t-sm">
            <span ><b>${views.column['VSiteApi.status']}：</b></span>
            <label>
                <input type="radio" id="statusNormal" class="i-checks statusRadio" name="siteApi.status" ${command.siteApi.status=="normal"?"checked":""}  value="normal"> ${views.content_auto['启用']}
            </label>
            <label class="m-l-sm">
                <input type="radio" id="statusDisable" class="i-checks statusRadio" name="siteApi.status" ${command.siteApi.status=="disable"?"checked":""} value="disable"> ${views.content_auto['停用']}
            </label>
            <input type="hidden" name="tempStatusVal" id="tempStatusVal" value="${command.siteApi.status}">
            <span class="m-l co-grayc2">${views.content['gameManage.siteApi.disableMessage']}</span>
        </div>

        <div class="clearfix save lgg-version">
            <c:forEach items="${languageList}" var="p" varStatus="status">
                <a id="tag${status.index+1}" aria-expanded="${index.index==0?'true':'false'}" name="tag" tagIndex="${status.index+1}"
                   class="${status.index=='0'?'current':''} a_${p.language} tag${status.index+1} tabLanguage"
                   tagIndex="${status.index+1}" siteSize="" href="javascript:void(0)" local="${p.language}">${dicts.common.local[p.language]}
                <span id="span${p.language}">
                        ${status.index=='0'?views.setting['switch.CloseReminder.editing']:typeI18nMap.get(p.language).name.length()>0?views.setting['switch.CloseReminder.edited']:views.setting['switch.CloseReminder.unedited']}
                </span>
                </a>
            </c:forEach>
            <input type="hidden" name="curLanguage" id="curLanguage" value="1">
        <span class="more">
            <soul:button target="changeCurrentLang" tag="a" opType="function" cssClass="next_lang" text="">
                <i class="fa fa-angle-double-right"></i>
            </soul:button>
        </span>
            <div class="pull-right inline">
                <div class="btn-group">

                    <button class="btn btn-link dropdown-toggle fzyx" data-toggle="dropdown">${views.setting['serviceTrems.copy']}&nbsp;&nbsp;<span class="caret"></span></button>
                    <ul class="dropdown-menu pull-right">
                        <c:forEach items="${languageList}" var="p" varStatus="status">
                            <li ${empty typeI18nMap.get(p.language).name||status.index==0?"hidden":""} id="option${p.language}" class="temp">
                                <a class="co-gray copy" href="javascript:void(0)" local="${p.language}">${dicts.common.local[p.language]}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <!--test-->
        </div>

        <div class="hfsj-wrap">

            <c:forEach begin="0" end="${fn:length(languageList)}" var="p" items="${languageList}" varStatus="index">
                <c:forEach var="api" items="${command.relationI18nList}" varStatus="status">
                    <c:if test="${api.local==p.language}">
                        <input type="hidden" name="relationI18nList[${index.index}].id" value="${api.id}">
                        <input type="hidden" name="relationI18nList[${index.index}].local" value="${api.local}">
                        <input type="hidden" name="relationI18nList[${index.index}].relationId" value="${api.relationId}">
                        <input type="hidden" name="relationI18nList[${index.index}].siteId" value="${api.siteId}">
                        <input type="hidden" name="relationI18nList[${index.index}].apiId" value="${api.apiId}">
                        <input type="hidden" name="relationI18nList[${index.index}].apiTypeId" value="${api.apiTypeId}">
                        <div class="content${p.language} ann tab-pane" style="display: ${index.index=='0'?'':'none'}" lang="${p.language}">
                            <div class="form-group" >
                                <div class="clearfix">
                                    <label>${views.column['VSiteApi.apiName']}：</label><span class="m-l co-grayc2">${messages.common['gameManage.showInFront']}</span>
                                    <soul:button tag="a" target="revertDefault" cssClass="lge pull-right" local="${api.local}" relationId="${api.relationId}" text="${messages.common['gameManage.revertDefault']}"
                                                 confirm="${messages.common['gameManage.showRevertDefaultMessage']}" opType="function"></soul:button>
                                    <%--<a href="javascript:void(0)"  class="lge pull-right">${views.content_auto['恢复默认']}</a>--%>
                                </div>
                                <input type="text" placeholder="" tt="${p.language}" class="form-control m-b field siteApiNameVal${p.language}"
                                       name="relationI18nList[${index.index}].name" value="${api.name}">
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </c:forEach>
        </div>
    </div>
    <c:set var="siteLang" value="${languageList}" />
    <input type="hidden" placeholder="" class="form-control m-b" name="langSize" value="${siteLang.size()}">
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.common['OK']}" opType="ajax"
                     target="${root}/siteApiTypeRelationI18n/persist.html" precall="uploadFile"
                     post="getCurrentFormData" callback="saveCallbak"/>

        <soul:button cssClass="btn btn-outline btn-filter" opType="function" target="closePage"
                     text="${views.common['cancel']}"/>

    </div>
</form:form>
<!--//endregion your codes 3-->
</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/content/gameManage/siteApi/SiteApi"/>
<!--//endregion your codes 4-->
</html>