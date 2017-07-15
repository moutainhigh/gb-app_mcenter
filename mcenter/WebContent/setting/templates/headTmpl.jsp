<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<input type="hidden" name="result.eventType" value="${noticeTmpl.eventType}">
<input type="hidden" name="result.groupCode" value="${noticeTmpl.groupCode}">
<input type="hidden" name="result.builtIn" value="${noticeTmpl.builtIn}">
<input type="hidden" name="result.tmplType" value="${noticeTmpl.tmplType}"/>
<input type="hidden" name="result.active" value="${noticeTmpl.active}"/>
<label id="noticeTmplListJson" style="display: none;">${noticeTmplListJson}<%--${fn:escapeXml(noticeTmplListJson)}--%></label>
<input type="checkbox" class="i-checks" value="${noticeTmpl.publishMethod}" name="result.publishMethod" checked="checked" style="display: none">

    <%--<c:if test="${noticeTmpl.builtIn}">
        <div class="clearfix m-b">
            <soul:button tag="a" target="fillDefault" cssClass="lge pull-right" text="${views.setting_auto['确认恢复所有默认原因的文案及勾选项吗']}" opType="function">${views.setting_auto['恢复默认文案']}</soul:button>&lt;%&ndash;<a href="javascript:void(0)" class="lge">${views.setting_auto['恢复默认']}</a>&ndash;%&gt;
        </div>
    </c:if>--%>
    <c:if test="${noticeTmpl.publishMethod eq 'sms'}">
        <div class="clearfix m-b bg-gray p-t-xs">
                        <span class="co-orange fs36 col-xs-1 al-right m-r-sm">
                            <i class="fa fa-exclamation-circle"></i>
                        </span>
            <div class="line-hi25 m-b-sm">${views.setting['NoticeTmp.addNotice.phoneMsgSendTip']}</div>
        </div>
    </c:if>
    <div class="clearfix save lgg-version">
        <c:set value="0" var="langLen"></c:set>

        <c:forEach begin="0" end="4" var="sl" items="${siteLang}" varStatus="index">
            <%--<c:forEach items="${noticeTmplList}" var="nt" varStatus="ntStatus">
                <c:if test="${sl.language eq nt.locale}">
                    <c:set var="hasContent${index.index}" value="${!empty nt.title && !empty nt.content}"/>
                </c:if>
            </c:forEach>--%>
            <c:set value="${langLen + 1}" var="langLen"></c:set>
            <c:set value="language.${sl.language}" var="siteLangCode"></c:set>
            <soul:button target="changeLang" tag="a" opType="function"
                         dataType="${fn:substringBefore(dicts.common.language[sl.language], '#')}"
                         text="${fn:substringBefore(dicts.common.language[sl.language], '#')}"
                         post="${sl.language}" cssClass="lang ${index.index eq 0 ?'current':''} ${index.index+1 > maxLang ? 'hide':''} ${((index.index+1)%3 eq 0) ?'fenge':''  }">
                ${fn:substringBefore(dicts.common.language[sl.language], '#')}<span class="unedited" data-unedit-title="${views.setting['NoticeTmp.addNotice.unedited']}" data-edited-title="${views.setting['NoticeTmp.addNotice.edited']}" data-editting-title="${views.setting['NoticeTmp.addNotice.editing']}">
                ${sl.isEdit?views.setting['NoticeTmp.addNotice.edited']:views.setting['NoticeTmp.addNotice.unedited']}
            </span>
            </soul:button>
        </c:forEach>

        <span class="more">
            <soul:button target="changeCurrentLang" tag="a" opType="function" cssClass="next_lang" text=""><i class="fa fa-angle-double-right"></i></soul:button>
        </span>

        <div class="pull-right inline">
            <div class="btn-group">
                <button data-toggle="dropdown" class="btn btn-link dropdown-toggle fzyx">${views.setting['NoticeTmp.addNotice.copyFromLanguage']}&nbsp;&nbsp;<span class="caret"></span></button>
                <ul class="dropdown-menu pull-right" id="copy_lang">
                    <c:forEach begin="1" end="4" var="sl" items="${siteLang}" varStatus="index">
                        <li class="temp" lang-code="${sl.language}"><a class="co-gray" href="javascript:void(0)">${fn:substringBefore(dicts.common.language[sl.language], '#')}</a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
    <div class="hfsj-wrap">
          <div class="form-group">
              <div class="clearfix">
                <label>${views.setting['NoticeTmp.addNotice.title']}</label>
              </div>
              <c:if test="${!noticeTmpl.builtIn || noticeTmpl.tmplType eq 'auto'}">
                  <input type="text" placeholder="" maxlength="100" id="title" class="form-control m-b" value="${firstLang.title}">
              </c:if>
              <c:if test="${noticeTmpl.builtIn && noticeTmpl.tmplType ne 'auto'}">
                  <div class="template-edit-readonly">${firstLang.title}</div>
              </c:if>
              <%--<input type="text" ${!noticeTmpl.builtIn || noticeTmpl.tmplType eq 'auto' ?'':'readonly'} placeholder="" maxlength="100" id="title" class="form-control m-b" value="${firstLang.title}">--%>
          </div>
          <div class="form-group">
              <div class="clearfix"><label>${views.setting['NoticeTmp.addNotice.msgContent']}</label></div>
                <c:if test="${!noticeTmpl.builtIn || noticeTmpl.tmplType eq 'auto'}">
                    <textarea ${'siteMsg' eq noticeTmpl.publishMethod?'maxlength="1000"':''}
                            class="${'email' eq noticeTmpl.publishMethod?'':'form-control m-b'}"
                            id="editContent">${firstLang.content}</textarea>
                </c:if>
                <c:if test="${noticeTmpl.builtIn && noticeTmpl.tmplType ne 'auto'}">
                    <div class="template-edit-readonly">${firstLang.content}</div>
                </c:if>

          </div>
        <%@include file="VariableLabel.jsp"%>
    </div>
