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

<form:form id="editForm" action="${root}/vSiteApiType/updateApiType.html" method="post">
    <form:hidden path="result.id" />
    <%--<div id="validateRule" style="display: none">${command.validateRule}</div>--%>
    <div id="validateRule" style="display: none">${validateRule}</div>
    <input type="hidden" id="siteApiTypeId" name="siteApiTypeId" value="${command.siteApiTypeId}">
    <input type="hidden" name="search.apiTypeId" value="${command.search.apiTypeId}">
    <!--//region your codes 3-->
    <div class="modal-body">
        <div class="input-group m-t-sm">
                <span ><b>${views.column['VSiteApiType.status']}：</b></span>
                <label>
                    <input type="radio" id="statusNormal" class="i-checks statusRadio" name="apiTypeStatus" ${command.apiTypeStatus=="normal"?"checked":""} value="normal"> ${views.content_auto['启用']}
                </label>
                <label class="m-l-sm">
                    <input type="radio" id="statusDisable" class="i-checks statusRadio" name="apiTypeStatus" ${command.apiTypeStatus=="disable"?"checked":""} value="disable"> ${views.content_auto['停用']}
                </label>
            <div>
                <span class="co-grayc2">
                ${views.content['gameManage.apiType.disableMessage']}
                </span>
            </div>
                <input type="hidden" name="tempStatusVal" id="tempStatusVal" value="${command.apiTypeStatus}">

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
                <c:forEach var="type" items="${command.apiTypeI18ns}" varStatus="status">
                    <c:if test="${type.local==p.language}">
                        <input type="hidden" name="apiTypeI18ns[${index.index}].local" value="${type.local}">
                        <input type="hidden" name="apiTypeI18ns[${index.index}].apiTypeId" value="${type.apiTypeId}">
                        <div class="content${p.language} ann tab-pane" style="display: ${index.index=='0'?'':'none'}" lang="${p.language}">
                            <div class="form-group" >
                                <div class="clearfix">
                                    <label>${views.column['VSiteApiType.customerName']}：</label><span class="m-l co-grayc2">${messages.common['gameManage.showInFront']}</span>
                                    <soul:button tag="a" target="revertDefault" cssClass="lge pull-right" local="${type.local}" apiTypeId="${type.apiTypeId}"
                                                 confirm="${messages.common['gameManage.showRevertDefaultMessage']}" opType="function" text="${messages.common['gameManage.revertDefault']}"></soul:button>
                                    <%--<a href="javascript:void(0)"  class="lge pull-right">${views.content_auto['恢复默认']}</a>--%>
                                </div>
                                <input type="text" placeholder="" tt="${p.language}" class="form-control m-b field apiTypeNameVal${p.language}"
                                       name="apiTypeI18ns[${index.index}].name" value="${type.name}">
                            </div>

                            <div class="form-group">
                                <label>${views.column['VSiteApiType.cover']}：</label><span class="m-l co-grayc2">${views.content['game.uploadCoverTips']}</span>
                                    <div class="form-group m-b-sm">
                                        <div id="apiTypeI18nsCover${index.index}">
                                            <c:if test="${not empty type.cover}">
                                                <img id="apiTypeCoverImg${p.language}" src="${soulFn:getThumbPath(domain, type.cover,0,0)}" class="logo-size-h100" />
                                            </c:if>
                                        </div>
                                        <input id="activityContentFile" class="file" type="file" accept="image/*" name="apiTypeCoverFile"
                                               target="apiTypeI18ns[${index.index}].cover">
                                        <input type="hidden" class=" apiTypeCoverVal${p.language}" bbb="${index.index}" tt="${p.language}"
                                               name="apiTypeI18ns[${index.index}].cover" id="apiTypeCover${index.index}" value="${type.cover}">
                                    </div>


                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </c:forEach>

        </div>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.common['OK']}" opType="ajax"
                     target="${root}/siteApiTypeI18n/persist.html" precall="uploadFile"
                      post="getCurrentFormData" callback="saveCallbak"/>

        <soul:button cssClass="btn btn-outline btn-filter" opType="function" target="closePage"
                     text="${views.common['cancel']}"/>
    </div>
    <!--//endregion your codes 3-->
    <c:set var="siteLang" value="${languageList}" />
    <input type="hidden" placeholder="" class="form-control m-b" name="langSize" value="${siteLang.size()}">
</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/content/gameManage/apiType/ApiTypeEdit"/>
<!--//endregion your codes 4-->
</html>