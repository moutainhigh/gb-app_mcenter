<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%@ include file="/include/include.head.jsp" %>
<form:form>
    <div id="validateRule" style="display: none">${validateRule}</div>
    <label id="cttListJson" style="display: none;">${cttListJson}</label>
    <gb:token/>
    <div class="modal-body">
        <div class="clearfix save lgg-version">
            <c:set value="0" var="langLen"></c:set>
            <c:forEach var="sl" items="${siteLang}" varStatus="index">
                <c:set value="${langLen + 1}" var="langLen"></c:set>
                <c:set value="language.${sl.language}" var="siteLangCode"></c:set>
                <soul:button target="changeLang" tag="a" opType="function"
                              dataType="${fn:substringBefore(dicts.common.language[sl.language], '#')}"
                              text="${fn:substringBefore(dicts.common.language[sl.language], '#')}"
                              post="${sl.language}" cssClass="locale${index.index} lang ${index.index eq 0 ?'current':''}
                              ${index.index+1 > maxLang ? 'hide':''} ${((index.index+1)%3 eq 0) ?'fenge':''  }">
                              ${fn:substringBefore(dicts.common.language[sl.language], '#')}
                        <span class="unedited" data-unedit-title="${views.setting['switch.CloseReminder.unedited']}"
                              data-edited-title="${views.setting['switch.CloseReminder.edited']}"
                              data-editting-title="${views.setting['switch.CloseReminder.editing']}">
                              ${index.index==0?views.setting['switch.CloseReminder.editing']:sl.isEdit?views.setting['switch.CloseReminder.edited']:views.setting['switch.CloseReminder.unedited']}
                        </span>
                </soul:button>
            </c:forEach>

            <%--<span class="more">--%>
                <%--<soul:button target="changeCurrentLang" tag="a" opType="function" cssClass="next_lang" text=""><i class="fa fa-angle-double-right"></i></soul:button>--%>
            <%--</span>--%>
            <div class="pull-right inline">
                <div class="btn-group">
                    <button data-toggle="dropdown" class="btn btn-link dropdown-toggle fzyx">${views.setting['serviceTrems.copy']}&nbsp;&nbsp;<span class="caret"></span></button>
                    <ul class="dropdown-menu pull-right" id="copy_lang">
                        <c:forEach var="sl" items="${siteLang}" varStatus="index">
                            <li class="temp" lang-code="${sl.language}"><a class="co-gray" href="javascript:void(0)">${fn:substringBefore(dicts.common.language[sl.language], '#')}</a></li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>

        <div class="hfsj-wrap">
            <div class="form-group">
                <div class="clearfix">
                    <label>${views.content['material.documentContent']}：</label>
                </div>
                <c:set var="contentarea" value="${fn:escapeXml(firstLang.content)}"/>
                <textarea class="form-control m-b-xs" id="editContent">${fn:escapeXml(firstLang.content)}</textarea>
                <span class="pull-right m-l co-grayc2">${views.content['material.inputCount']}<var class="word">${fn:length(contentarea)}</var>/200</span>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button precall="_validateForm" tag="button" opType="function" target="saveCttText" cssClass="btn btn-filter" text="${views.common['OK']}">${views.common['OK']}</soul:button>
        <soul:button target="closePage" tag="button" opType="function" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter">${views.common['cancel']}</soul:button>
    </div>
    <input type="hidden" value="${maxLang}" id="maxLang">
    <input type="hidden" value="${langLen}" id="langLen">
    <input type="hidden" name="groupCode" value="${groupCode}">
    <script>
        var languageCounts = ${fn:length(siteLang)};
    </script>
</form:form>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/material/EditMaterial"/>