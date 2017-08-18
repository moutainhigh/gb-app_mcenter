<%--
  Created by IntelliJ IDEA.
  User: snekey
  Date: 15-7-30
  Time: 下午3:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

  <div class="clearfix save lgg-version lang_label">
      <%--站长语言个数--%>
    <c:set value="0" var="langLen"></c:set>

    <c:forEach begin="0" end="4" var="siteLang" items="${languageList}" varStatus="index">
      <c:set value="${langLen + 1}" var="langLen"></c:set>
      <c:set value="language.${siteLang.language}" var="siteLangCode"></c:set>
      <soul:button target="changeLang" tag="a" opType="function"
                   dataType="${fn:substringBefore(dicts.common.language[siteLang.language], '#')}"
                   text="${fn:substringBefore(dicts.common.language[siteLang.language], '#')}"
                   post="${siteLang.language}" cssClass="lang ${index.index eq 0 ?'current':''} ${index.index+1 > maxLang ? 'hide':''} ${((index.index+1)%3 eq 0) ?'fenge':''  }">
        ${fn:substringBefore(dicts.common.language[siteLang.language], '#')}<span class="unedited" data-edited-title="${views.content_auto['已编辑']}" data-editting-title="${views.content_auto['编辑中']}">${views.content['未编辑']}</span>
      </soul:button>
    </c:forEach>

  </div>
  <div class="hfsj-wrap">
    <div class="form-group">
      <div class="clearfix">
        <label>${views.content['标题']}</label>
        <div class="pull-right inline bg-gray">
          <div class="btn-group">
            <button data-toggle="dropdown" class="btn btn-link dropdown-toggle fzyx">${views.content['复制语系']}&nbsp;&nbsp;<span class="caret"></span></button>
            <ul class="dropdown-menu pull-right" id="copy_lang">
              <li class="temp" lang-code="fanti"><a href="javascript:void(0)" class="co-gray">${views.content['复制语系']}</a></li>
              <li class="temp"><a href="javascript:void(0)" class="co-gray">${views.content['复制语系']}</a></li>
            </ul>
          </div>
        </div>
      </div>
      <input type="text" placeholder="" id="title" class="form-control m-b">
    </div>
    <div class="form-group"><label>${views.content['信息内容']}</label><textarea <c:if test="${sendType ne 'mail'}">class="form-control m-b" </c:if>id="editContent"></textarea></div>
  </div>
  <div class="modal-footer">
      <%--<button type="button" class="btn btn-filter">${views.content_auto['确认']}</button>--%>

      <%--站长语言  大于1时 有下一步--%>
    <c:if test="${langLen > 1}">
      <%--上一步--%>
      <soul:button target="changeCurrentLang" opType="function" cssClass="btn btn-filter previous_lang hide" text="${views.content_auto['上一步']}"></soul:button>

      <%--下一步--%>
      <soul:button target="changeCurrentLang" opType="function" cssClass="btn btn-filter next_step next_lang" text="${views.content_auto['下一步']}"></soul:button>
    </c:if>

    <soul:button target="${root}" cssClass="btn btn-filter ${langLen > 1 ? 'hide':''} preview" opType="ajax" text="${views.content_auto['预览并发布']}"></soul:button>
      <%--<button type="button" class="btn btn-outline btn-filter">${views.common_report['取消']}</button>--%>
    <soul:button target="closePage" opType="function" cssClass="btn btn-outline btn-filter" text="${views.common_report['取消']}"></soul:button>
  </div>
  <%--隐藏域--%>
  <input type="hidden" value="${maxLang}" id="maxLang">
  <input type="hidden" value="${langLen}" id="langLen">
  <input type="hidden" value="${sendType}" id="sendType">

<soul:import res="site/content/cttdraft/EditContent"/>

