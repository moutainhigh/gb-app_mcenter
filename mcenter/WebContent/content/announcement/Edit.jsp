<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.CttAnnouncementListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html lang="zh-CN">
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>

<body>

<form:form id="editForm" action="${root}/vRakebackSet/edit.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <gb:token/>
    <%--<input type="hidden" name="token" value="${token}">--%>
    <input type="hidden" name="uuid" value="${command.uuid}">
    <div id="resource">
        <div class="modal-body">
            <input type="hidden" name="announcementType" value="${command.announcementType}" title="${dicts.content.ctt_announcement_type[command.announcementType]}">
            <div class="clearfix save lgg-version">
                <label>${views.content['类型']}：</label>
                <label>${dicts.content.ctt_announcement_type[command.announcementType]}</label>
            </div>
            <c:if test="${command.announcementType=='4'}">
                <div class="clearfix">
                    <label style="float: left;">${views.content['展示时间']}：</label>
                    <div class="col-xs-1" style="margin-top: -9px;">
                        <select class="chosen-select-no-single params_data" name="countdown">
                            <c:forEach items="${intervalTime}" var="it">
                                <option <c:if test="${it.time eq countdown}"> selected </c:if> value="${it.time}">${it.content}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </c:if>
            <div class="clearfix save lgg-version">
                <c:forEach items="${languageList}" var="p" varStatus="status">
                    <a id="tag${status.index+1}" aria-expanded="${index.index==0?'true':'false'}" name="tag" tagIndex="${status.index+1}" class="${status.index=='0'?'current':''} a_${p.language} tag${status.index+1}"
                       tagIndex="${status.index+1}" siteSize="${command.cttAnnouncementMap.size()}"
                       href="javascript:void(0)" local="${p.language}">${dicts.common.local[p.language]}
                        <span id="span${p.language}">
                                ${status.index=='0'?views.setting['switch.CloseReminder.editing']:command.cttAnnouncementMap.get(p.language).title.length()>0?views.setting['switch.CloseReminder.edited']:views.setting['switch.CloseReminder.unedited']}
                        </span>
                    </a>
                </c:forEach>
                <div class="pull-right inline">
                    <div class="btn-group">
                        <button class="btn btn-link dropdown-toggle fzyx" data-toggle="dropdown">${views.setting['serviceTrems.copy']}&nbsp;&nbsp;<span class="caret"></span></button>
                        <ul class="dropdown-menu pull-right">
                            <c:forEach items="${languageList}" var="p" varStatus="status">
                                <li ${empty cttAnnouncementMap.get(p.language)||status.index==0?"hidden":""} id="option${p.language}" class="temp">
                                    <a class="co-gray copy" href="javascript:void(0)" local="${p.language}">${dicts.common.local[p.language]}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="hfsj-wrap">
                    <%--标题--%>
                <c:forEach items="${languageList}" var="p" varStatus="status">

                    <input type="hidden"  name="result[${status.index}].id" value="${command.cttAnnouncementMap[p.language].id}">
                    <input type="hidden"  name="result[${status.index}].language" value="${p.language}">
                    <input type="hidden"  name="result[${status.index}].code" value="${command.cttAnnouncementMap[p.language].code}">
                    <div class="content${p.language} ann tab-pane" lang="${p.language}">
                        <textarea maxlength="2000" tt="${p.language}" style="display: ${status.index=='0'?'':'none'}" placeholder="${views.content['announcement.contentTips']}"
                                  name="result[${status.index}].content" class="form-control contentSource ann m-b content${status.index} content${p.language} contentVal${p.language}"
                                  value="${command.cttAnnouncementMap[p.language].content}">${command.cttAnnouncementMap[p.language].content}</textarea>
                    </div>
                </c:forEach>
                            <%--定时发送--%>
                        <div class="clearfix form-group m-b-xxs">
                            <div class="dsfb">
                                <label>
                                    <input type="checkbox" id="task" class="i-checks">${views.content['announcement.inTheTime']}
                                </label>
                            </div>
                            <input type="hidden" name="task" value="${command.task}"/>
                            <div class="dsfb-data">
                                <div class="input-group date hide">
                                    <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:160px"  position="up"
                                                  minDate="${dateQPicker.now}" name="timing" value="${command.timing}" ></gb:dateRange>
                                </div>
                            </div>
                        </div>
            </div>
        </div>

        <c:set var="siteLang" value="${languageList}" />
        <input type="hidden" placeholder="" class="form-control m-b" name="langSize" value="${siteLang.size()}">
        <!--//region your codes 3-->
        <div class="modal-footer">
                <%--站长语言  大于1时 有下一步--%>
            <c:if test="${siteLang.size() > 1}">
                <%--上一步--%>
                <soul:button target="previous" opType="function" cssClass="btn btn-filter previous_lang hide enter-submit" text="${views.common['previous']}"></soul:button>
                <%--下一步--%>
                <soul:button target="next" opType="function" cssClass="btn btn-filter next_step next_lang enter-submit" text="${views.common['next']}"></soul:button>
            </c:if>

                    <soul:button target="Preview" cssClass="btn btn-filter preview hide enter-submit" opType="function" text="${views.common['previewAndSave']}" post="getCurrentFormData" precall="saveValid" callback="saveCallbak"></soul:button>

                    <soul:button target="closePage" opType="function" cssClass="btn btn-outline btn-filter" text="${views.common['cancel']}"></soul:button>
        </div>
    </div>

    <div id="target" class="hide">
        <div class="modal-body">
            <div class="clearfix save lgg-version">
                <label>${views.content['类型']}：</label><label id="targetType"></label>
            </div>
            <c:if test="${command.announcementType=='4'}">
                <div class="clearfix">
                    <label>${views.content['展示时间']}：</label>
                    <label id="countdown"></label>
                </div>
            </c:if>
            <div class="clearfix save lgg-version">
                <c:forEach items="${languageList}" var="p" varStatus="status">
                    <a href="javascript:void(0)" name="targetTag" class="target${status.index}" local="${p.language}">${dicts.common.local[p.language]}</a>
                </c:forEach>
            </div>
            <div class="hfsj-wrap">
                    <%--标题--%>
                <c:forEach items="${languageList}" var="p" varStatus="status">
                    <div class="content${p.language} ann tab-pane" style="display: ${index.index=='0'?'':'none'}" lang="${p.language}">
                            <%-- <input   style="display: ${status.index=='0'?'':'none'}" readonly="readonly"   class="form-control ann_target  m-b content${p.language} targetTitleVal${p.language}" type="text"/>--%>
                        <textarea   style="display: ${status.index=='0'?'':'none'}" readonly="readonly" class="form-control field ann_target m-b content${status.index} content${p.language} targetContent${p.language}"></textarea>
                    </div>
                </c:forEach>
                        <div class="clearfix form-group m-b-xxs">
                            <div class="dsfb"><label>${views.content['announcement.inTheTime']}：<span id="showTime"></span> </label></div>
                            <input type="hidden" name="task" value="${command.task}"/>
                        </div>
            </div>
        </div>
        <c:set var="siteLang" value="${languageList}" />
        <input type="hidden" placeholder="" class="form-control m-b" name="langSize" value="${siteLang.size()}">
        <div class="modal-footer">
            <soul:button target="${root}/cttAnnouncement/batchSave.html" dataType="json" cssClass="btn btn-filter preview hide enter-submit"
                         opType="ajax" text="${views.common['release']}" precall="saveValid" post="getCurrentFormData" callback="saveCallbak"></soul:button>
            <soul:button target="returnEdit" opType="function" cssClass="btn btn-outline btn-filter" text="${views.content['announcement.returnEdit']}"></soul:button>
        </div>
    </div>
</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/content/cttannouncement/Edit"/>
<!--//endregion your codes 4-->
</html>