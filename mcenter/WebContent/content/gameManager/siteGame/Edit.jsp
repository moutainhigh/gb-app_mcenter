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
<form:form id="editForm" action="${root}/siteGameI18n/edit.html?id=${command.search.id}" method="post">
    <form:hidden path="result.id" />
    <input type="hidden" name="search.id" id="id" value="${command.search.id}">
    <input type="hidden" name="search.gameId" id="siteGameId" value="${command.search.gameId}">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="modal-body">
        <div class="input-group m-t-sm">
            <span ><b>${views.column['VSiteGame.status']}：</b></span>
            <label>
                <input type="radio" id="statusNormal" class="i-checks statusRadio" name="siteGameStatus" ${command.siteGameVo.status=="normal"?"checked":""}  value="normal"> ${views.content_auto['启用']}
            </label>
            <label class="m-l-sm">
                <input type="radio" id="statusDisable" class="i-checks statusRadio" name="siteGameStatus" ${command.siteGameVo.status=="disable"?"checked":""} value="disable"> ${views.content_auto['停用']}
            </label>
            <span class="m-l co-grayc2">${views.content['game.stopGameTips']}</span>
            <input type="hidden" name="tempStatusVal" id="tempStatusVal" value="${command.siteGameVo.status}">
        </div>
        <%--<div class="input-group m-t-sm">
            <div class="clearfix">
                <label>${views.content_auto['标签']}：</label>
                <span>
                    <c:forEach var="tag" items="${command.gameTagI18nList}" varStatus="status">
                        <input type="checkbox" name="gameTagList[${status.index}].tagId" value="${tag.gameTagI18n.key}" <c:if test="${tag.isCheck}">checked</c:if> >${tag.gameTagI18n.value}
                        <input type="hidden" name="gameTagList[${status.index}].gameId" value="${command.search.gameId}">
                        <input type="hidden" name="gameTagList[${status.index}].siteId" value="${tag.gameTagI18n.siteId}">
                    </c:forEach>
                </span>
                <soul:button target="${root}/siteGameTag/gameTagEdit.html" text="${views.content['game.tagManage']}"
                             opType="dialog" title="${views.content['game.gameTagManage']}" cssClass="m-l-sm" callback="query"/>
            </div>
        </div>--%>

        <div class="clearfix save lgg-version">
            <c:forEach items="${languageList}" var="p" varStatus="status">
                <a id="tag${status.index+1}" aria-expanded="${index.index==0?'true':'false'}" name="tag"
                   class="${status.index=='0'?'current':''} a_${p.language} tag${status.index+1} tabLanguage"
                   tagIndex="${status.index+1}" href="javascript:void(0)" local="${p.language}">${dicts.common.local[p.language]}
                <span id="span${p.language}">
                        ${status.index=='0'?views.setting['switch.CloseReminder.editing']:typeI18nMap.get(p.language).name.length()>0&&typeI18nMap.get(p.language).cover.length()>0?views.setting['switch.CloseReminder.edited']:views.setting['switch.CloseReminder.unedited']}
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
                                <a class="co-gray copy" href="javascript:void(0)" local="${p.language}" orderIndex="${status.index+1}">${dicts.common.local[p.language]}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <!--test-->
        </div>

        <div class="hfsj-wrap">

            <c:forEach begin="0" end="${fn:length(languageList)}" var="p" items="${languageList}" varStatus="index">
                <c:forEach var="game" items="${command.siteGameI18ns}">
                    <c:if test="${game.local==p.language}">
                        <input type="hidden" name="siteGameI18ns[${index.index}].id" value="${game.id}">
                        <input type="hidden" name="siteGameI18ns[${index.index}].local" value="${game.local}">
                        <input type="hidden" name="siteGameI18ns[${index.index}].gameId" value="${game.gameId}">
                        <div class="content${p.language} ann tab-pane" style="display: ${index.index=='0'?'':'none'}" lang="${p.language}">
                            <div class="form-group" >
                                <div class="clearfix">
                                    <label>${views.column['VSiteGame.customerName']}：</label><span class="m-l co-grayc2">${messages.common['gameManage.showInFront']}</span>
                                    <soul:button tag="a" target="revertDefault" cssClass="lge pull-right" local="${game.local}" gameId="${game.gameId}"
                                                 text="${messages.common['gameManage.showRevertDefaultMessage']}" opType="function">${messages.common['gameManage.revertDefault']}</soul:button>
                                </div>
                                <input type="text" placeholder="" tt="${p.language}" class="form-control m-b field siteGameNameVal${p.language}"
                                       name="siteGameI18ns[${index.index}].name" value="${game.name}">
                            </div>

                            <div class="form-group">
                                <label>${views.column['VSiteGame.cover']}：</label><span class="m-l co-grayc2">${views.content['game.uploadCoverTips']}</span>
                                <div class="form-group m-b-sm">
                                    <div id="apiTypeI18nsCover${index.index}">
                                        <c:if test="${not empty game.cover}">
                                            <img id="apiTypeCoverImg${p.language}" src="${soulFn:getThumbPath(domain, game.cover,300,250)}"/>
                                        </c:if>
                                    </div>
                                    <input id="activityContentFile${index.index}" class="file" type="file" accept="image/*" name="apiTypeCoverFile"
                                           target="siteGameI18ns[${index.index}].cover">
                                    <input type="hidden" class="apiTypeCoverVal${p.language}" bbb="${index.index}" tt="${p.language}"
                                           name="siteGameI18ns[${index.index}].cover" id="apiTypeCover${index.index}" value="${game.cover}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label>${views.content_auto['备用图片']}：</label><span class="m-l co-grayc2">${views.content['game.uploadCoverTips']}</span>
                                <div class="form-group m-b-sm">
                                    <div id="backupCoverDiv${index.index}">
                                        <c:if test="${not empty game.backupCover}">
                                            <img id="backupCoverImg${p.language}" src="${soulFn:getThumbPath(domain, game.backupCover,300,250)}"/>
                                        </c:if>
                                    </div>
                                    <input id="backupCover${index.index}" class="file" type="file" accept="image/*" name="backupCover"
                                           target="siteGameI18ns[${index.index}].backupCover">
                                    <input type="hidden" class="backupCoverVal${p.language}" bbb="${index.index}" tt="${p.language}"
                                           name="siteGameI18ns[${index.index}].backupCover" id="backupCover${index.index}" value="${game.backupCover}">
                                </div>
                            </div>
                            <div class="form-group m-t">
                                <div class="clearfix">
                                    <label>${views.column['SiteGameI18n.gameIntroduce']}：</label>
                                    <input type="checkbox" name="introduceStatus${p.language}" local="${p.language}"
                                           class="check-box" <%--value="${game.introduceStatus=="normal"?"on":"off"}"--%>
                                           data-size="mini" ${game.introduceStatus=="normal"?"checked":""}> <span class="m-l co-grayc2">${views.content['game.colseGameIntroduce']}</span>
                                    <input type="hidden" name="siteGameI18ns[${index.index}].introduceStatus" value="${game.introduceStatus}"
                                           class="siteGameIntroduceStatusVal${p.language}">
                                </div>
                                <div class="col-sm-9" style="padding-left: 0px;">
                                    <textarea class="m-t m-b form-textarea siteGameIntroduceVal${p.language}" name="siteGameI18ns[${index.index}].gameIntroduce" id="editContent${index.index}" tt="${p.language}">${game.gameIntroduce}</textarea>
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
                     target="${root}/siteGameI18n/persist.html" precall="uploadFile"
                     post="getCurrentFormData" callback="saveCallbak"/>

        <soul:button cssClass="btn btn-outline btn-filter" opType="function" target="closePage"
                     text="${views.common['cancel']}"/>

    </div>
    <c:set var="siteLang" value="${languageList}" />
    <input type="hidden" placeholder="" class="form-control m-b" name="langSize" value="${siteLang.size()}">

    <!--//endregion your codes 3-->

</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/content/gameManage/siteGame/SiteGame"/>
<!--//endregion your codes 4-->
</html>