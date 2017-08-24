<!DOCTYPE HTML>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html lang="zh-CN">
<html>
<head>
  <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form>
    <gb:token/>
    <div id="validateRule" style="display: none">${validateRule}</div>
    <div class="modal-body">
        <div class="form-group clearfix m-b-xxs">
          <label class="form_lab_block line-hi34 m-r-sm">${views.setting['NoticeTmp.addNotice.chooseType']} : </label>
          <div class="col-xs-6 p-x">
              <select class="btn-group chosen-select-no-single" name="result.eventType" callback="changeTag">
                  <option value="">${views.common['pleaseSelect']}</option>
                  <c:forEach items="${reasonType}" var="item">
                      <c:if test="${item.key!='DOMAIN_CHECK'&&item.key!='GROUP_SEND'}">
                          <option value="${item.key}">${dicts[item.value.module][item.value.dictType][item.value.dictCode]}</option>
                      </c:if>
                  </c:forEach>
              </select>
          </div>
        </div>
        <div class="form-group clearfix m-b-xxs" style="display: none;">
            <label class="form_lab_block line-hi34 m-r-sm">${views.setting['NoticeTmp.addNotice.noticeWay']} : </label>
            <div class="col-xs-6 p-x">
                <select  class="chosen-select-no-single" callback="showTip" name="result.publishMethod">
                    <option value="">${views.common['pleaseSelect']}</option>
                    <c:forEach items="${publishMethod}" var="item">
                        <option value="${item.value.dictCode}" ${item.value.dictCode eq 'siteMsg'?'selected':''}>${dicts[item.value.module][item.value.dictType][item.value.dictCode]}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div id="tip" class="clearfix m-b bg-gray p-t-xs" style="display: none">
                    <span class="co-orange fs36 col-xs-1 al-right m-r-sm">
                        <i class="fa fa-exclamation-circle"></i>
                    </span>
          <div class="line-hi25 m-b-sm">${views.setting['NoticeTmp.addNotice.phoneMsgSendTip']}</div>
        </div>

        <div class="clearfix save lgg-version">
            <c:set value="0" var="langLen"></c:set>

            <c:forEach begin="0" end="4" var="sl" items="${siteLang}" varStatus="index">
                <c:set value="${langLen + 1}" var="langLen"></c:set>
                <c:set value="language.${sl.language}" var="siteLangCode"></c:set>
                <soul:button target="changeLang" tag="a" opType="function"
                             dataType="${fn:substringBefore(dicts.common.language[sl.language], '#')}"
                             text="${fn:substringBefore(dicts.common.language[sl.language], '#')}"
                             post="${sl.language}" cssClass="lang ${index.index eq 0 ?'current':''} ${index.index+1 > maxLang ? 'hide':''} ${((index.index+1)%3 eq 0) ?'fenge':''  }">
                    ${fn:substringBefore(dicts.common.language[sl.language], '#')}<span class="unedited" data-unedit-title="${views.setting['NoticeTmp.addNotice.unedited']}" data-edited-title="${views.setting['NoticeTmp.addNotice.edited']}" data-editting-title="${views.setting['NoticeTmp.addNotice.editing']}">${views.setting['NoticeTmp.addNotice.unedited']}</span>
                </soul:button>
            </c:forEach>

            <span class="more">
                <soul:button target="changeCurrentLang" tag="a" opType="function" cssClass="next_lang" text=""><i class="fa fa-angle-double-right"></i></soul:button>
            </span>
        </div>
        <div class="hfsj-wrap">
           <div class="form-group">
              <label>${views.setting['NoticeTmp.addNotice.title']}</label>
              <div class="pull-right inline bg-gray">
                  <div class="btn-group">
                      <button data-toggle="dropdown" class="btn btn-link dropdown-toggle fzyx">${views.setting['NoticeTmp.addNotice.copyFromLanguage']}&nbsp;&nbsp;<span class="caret"></span></button>
                      <ul class="dropdown-menu pull-right" id="copy_lang">
                      </ul>
                  </div>
              </div>
           </div>

           <input type="text" placeholder="" id="title" name="result.title" class="form-control m-b">
        </div>
        <div class="form-group"><label>${views.setting['NoticeTmp.addNotice.msgContent']}</label><textarea class="form-control m-b" id="editContent"></textarea></div>
        <%@include file="VariableLabel.jsp"%>
    </div>
    <div class="modal-footer">
        <soul:button precall="_validateForm" tag="button" opType="function" type="noemail" target="saveNoticeTmpl" cssClass="btn btn-filter" text="${views.common['commit']}">${views.common['commit']}</soul:button>
        <soul:button precall="_validateForm" tag="button" opType="function" target="saveNoticeTmpl" cssClass="btn btn-filter" text="${views.setting['NoticeTmp.addNotice.commitAndSetEmail']}">${views.setting['NoticeTmp.addNotice.commitAndSetEmail']}</soul:button>
        <%--<soul:button target="closePage" tag="button" opType="function" text="${views.common_report['取消']}" cssClass="btn btn-outline btn-filter">${views.common['cancel']}</soul:button>--%>
    </div>
    <input type="hidden" value="${maxLang}" id="maxLang">
    <input type="hidden" value="${langLen}" id="langLen">
    <input TYPE="hidden" value="false" name="result.builtIn">
    <input type="hidden" value="add" id="addNotice"/>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/setting/noticetmpl/NoticeTmplEdit"/>
</html>