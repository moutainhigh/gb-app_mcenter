<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form id="editForm" action="${root}/cttDocumentI18n/editContent.html?id=${command.cttDocumentVo.id}&search.documentId=${command.cttDocumentVo.id}" method="post">
<div class="row">
  <div class="position-wrap clearfix">
    <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
    <span>${views.sysResource['内容']}</span><span>/</span><span>${views.sysResource['文案管理']}</span>
    <soul:button target="goToList" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
      <em class="fa fa-caret-left"></em>${views.common['return']}
    </soul:button>
    <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
  </div>
  <gb:token></gb:token>
  <input type="hidden" name="result.noblank" value="noblank">
  <input type="hidden" id="langNum" value="${languageList.size()}">
  <input type="hidden" name="cttDocumentVo.id" id="searchId" value="${command.cttDocumentVo.id}">
  <input type="hidden" name="parentVo.id" value="${command.parentVo.id}">
  <input type="hidden" name="cttDocumentVo.code" value="${command.cttDocumentVo.code}">
  <input type="hidden" name="result.id" id="resultId" value="${command.documentId}">
  <input type="hidden" name="documentId" id="documentId" value="${command.documentId}">
  <div id="validateRule" style="display: none">${command.validateRule}</div>
  <div class="col-lg-12" id="content-div">
    <div class="wrapper white-bg shadow" id="editor">
      <div class="present_wrap">${views.content['document.editing']}：${localTitle}</div>
      <ul class="artificial-tab clearfix">
        <c:forEach items="${languageList}" var="p" varStatus="status">
          <c:choose>
            <c:when test="${status.index==0}">
              <li>
                <a class="lang current a_${p.language}" id="a_${status.index+1}" lnum="${status.index+1}" lname="${p.language}" name="tag"
                   href="javascript:void(0)">${dicts.common.local[p.language]}
                  &nbsp;[<span class="con" id="span${p.language}" style="color: darkorange">${messages.common['switch.CloseReminder.editing']}</span>]
                </a>
              </li>
            </c:when>
            <c:otherwise>
              <li>
                <a class="lang a_${p.language}" id="a_${status.index+1}" lnum="${status.index+1}" lname="${p.language}" name="tag" href="javascript:void(0)">${dicts.common.local[p.language]}
                  &nbsp;[<span class="con" id="span${p.language}" style="color: darkorange">${i18nMap.get(p.language).content.length()>0?messages.common['switch.CloseReminder.edited']:messages.common['switch.CloseReminder.unedited']}</span>]
                </a>
              </li>
            </c:otherwise>
          </c:choose>
        </c:forEach>
        <li class="pull-right m-t-md">
          <%--<a href="javascript:void(0)" class="lge" id="hfmr">${views.content_auto['恢复默认']}</a>--%>
          <c:if test="${command.cttDocumentVo!=null&&not empty command.cttDocumentVo.buildIn}">
            <soul:button target="revertDefault" text="${views.content['document.revertDefault']}" opType="function" cssClass="lge"></soul:button>
            <input type="hidden" name="saveFrom" value="3">
          </c:if>
          <div class="btn-group">
            <button data-toggle="dropdown" class="btn btn-link dropdown-toggle fzyx">${views.setting['serviceTrems.copy']}&nbsp;&nbsp;<span class="caret"></span></button>
            <ul class="dropdown-menu pull-right">
              <c:forEach items="${languageList}" var="p" varStatus="status">
                <li class="temp ${empty typeI18nMap.get(p.language).content||status.index==0?'hide':''}" id="fz_${p.language}" >
                  <a href="javascript:void(0)" class="co-gray copy" local="${p.language}" index="${status.index}">
                  ${dicts.common.local[p.language]}
                  </a>
                </li>
              </c:forEach>
            </ul>
          </div>
        </li>
      </ul>
      <c:forEach items="${languageList}" var="lang" varStatus="status">
        <c:forEach var="doc" items="${command.documentI18ns}" varStatus="index">
          <c:if test="${lang.language==doc.local}">
            <div class="tab-pane ann content${lang.language}" lang="${doc.local}" style="display: ${status.index=='0'?'':'none'}">
              <div>
              <textarea id="editContent${status.index}" name="documentI18ns[${status.index}].content" tt="${lang.language}" ueditorId="editContent${status.index}"
                        class="form-textarea field" >${doc.content}</textarea>
                <input type="hidden" name="documentI18ns[${status.index}].contentText" class="contentTextVal" tt="${lang.language}" textIdx="${status.index}" id="contentText${status.index}">
              </div>

              <input type="hidden" name="documentI18ns[${status.index}].id" value="${doc.id}">
              <input type="hidden" name="documentI18ns[${status.index}].local" value="${doc.local}">
              <input type="hidden" name="documentI18ns[${status.index}].documentId" value="${doc.documentId}">
              <input type="hidden" name="documentI18ns[${status.index}].title" class="document_validtitle" value="${doc.title}">
              <textarea id="hiddenContentDefault${status.index}" name="hiddenContent[${status.index}].contentDefault" class="hide" >${doc.contentDefault}</textarea>
            </div>
          </c:if>
        </c:forEach>
      </c:forEach>
      <input type="hidden" name="curLanguage" id="curLanguage" value="1">
      <a href="/vCttDocument/list.html" nav-target="mainFrame" id="reback_btn"></a>
      <div class="operate-btn">
        <c:if test="${languageList.size() > 1}">
          <%--上一步--%>
          <soul:button target="changeCurrentLang" opType="function" cssClass="btn btn-filter btn-outline  btn-lg m-r previous_lang hide" text="${views.common['previous']}"></soul:button>

          <%--下一步--%>
          <soul:button target="changeCurrentLang" opType="function" cssClass="btn btn-filter btn-lg m-r next_step" text="${views.common['next']}"></soul:button>
        </c:if>
        <%--<soul:button target="preSaveValid" dataType="json" cssClass="btn btn-filter btn-lg preview hide"
                     opType="function" text="${views.common['previewAndSave']}" precall="myValidateForm" ></soul:button>savePreview--%>
        <%--<soul:button target="${root}/cttDocumentI18n/persist.html?isPublish=true" dataType="json" cssClass="btn btn-filter btn-lg preview ${languageList.size()>1?'hide':''}"
                     opType="ajax" text="${views.common['previewAndSave']}" precall="myValidateForm" post="getCurrentFormData" callback="toDocumentList"></soul:button>--%>
        <soul:button target="${root}/cttDocumentI18n/saveFromEditContent.html" dataType="json" cssClass="btn btn-default btn-warning btn-lg pull-right auto-save-btn"
                     opType="ajax" text="${views.common['save']}" precall="myValidateForm" post="getCurrentFormData" callback="autoSaveCallbak"></soul:button>

        <soul:button target="savePreview" dataType="json" cssClass="btn btn-filter btn-lg preview ${languageList.size()>1?'hide':''}"
                     opType="function" text="${views.common['previewAndSave']}" precall="myValidateForm" post="getCurrentFormData"></soul:button>
        <%--
        <soul:button target="${root}/cttDocumentI18n/persist.html?isPublish=true" dataType="json" cssClass="btn btn-filter btn-lg preview hide"
                     opType="ajax" text="${views.content_auto['预览并发布']}" precall="myValidateForm" post="getCurrentFormData" callback="toDocumentList"></soul:button>
        --%>
      </div>
    </div>
  </div>

</div>
  </form:form>
<soul:import res="site/content/cttdocument/EditContent"/>