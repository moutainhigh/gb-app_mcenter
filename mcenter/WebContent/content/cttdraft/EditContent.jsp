<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/userAgentRebate/list.html" method="post">
<div class="row">
  <div class="position-wrap clearfix">
    <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
    <span>${views.content['内容管理']}</span>
    <span>/</span><span>${views.content['首页文案管理']}</span>
    <a href="javascript:void(0)" nav-target="mainFrame" class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn"><em class="fa fa-caret-left"></em>${views.content_auto['返回']}</a>
    <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
  </div>
  <label id="languageJson" style="display: none;"><%--${languageJson}--%></label>
  <input type="hidden" id="langNum" value="${listLanguage.size()}">
  <div class="col-lg-12">
    <div class="wrapper white-bg shadow">
      <div class="present_wrap">${views.content['当前正在编辑']}：${title}</div>
      <ul class="artificial-tab clearfix">
        <c:forEach items="${listLanguage}" var="p" varStatus="status">
          <c:choose>
            <c:when test="${status.index==0}">
              <li>
                <a class="lang current" id="a_${status.index}" lnum="${status.index+1}" lname="${p.language}" href="javascript:void(0)"><span class="con">${dicts.common.local[p.language]}<sl> ${views.content_auto['编辑中']}</sl></span></a>
                <%--<soul:button cssClass="lang current" target="changeLang" tag="a" opType="function" post="${p.language}" text="${dicts.common.local[p.language]}">
                  <span class="con">${dicts.common.local[p.language]}<span> ${views.content_auto['编辑中']}</span></span>
                </soul:button>--%>
              </li>
            </c:when>
            <c:otherwise>
              <li>
                <a class="lang" id="a_${status.index}" lnum="${status.index+1}" lname="${p.language}" href="javascript:void(0)">
                  <span class="con">${dicts.common.local[p.language]}
                    <t> ${empty p.content?'${views.content[\'未编辑\']}':'${views.content[\'已编辑\']}'}</t>
                  </span>
                </a>
                <%--<soul:button cssClass="lang" target="changeLang" tag="a" opType="function" post="${p.language}" text="${dicts.common.local[p.language]} 未编辑">
                  <span class="con">${dicts.common.local[p.language]} <span> ${views.content_auto['编辑中']}</span></span>
                </soul:button>--%>
              </li>
            </c:otherwise>
          </c:choose>
        </c:forEach>
        <li class="pull-right m-t-md">
          <a href="javascript:void(0)" class="lge" id="hfmr">${views.content['恢复默认']}</a>
          <div class="btn-group">
            <button data-toggle="dropdown" class="btn btn-link dropdown-toggle fzyx">${views.content['复制语系']}&nbsp;&nbsp;<span class="caret"></span></button>
            <ul class="dropdown-menu pull-right">
              <c:forEach items="${listLanguage}" var="p" varStatus="status">
                <c:choose>
                  <c:when test="${not empty p.content}">
                    <li class="temp" id="fz_${p.language}"><a href="javascript:void(0)" class="co-gray">${dicts.common.local[p.language]}</a></li>
                  </c:when>
                  <c:otherwise>
                    <li class="temp" id="fz_${p.language}" style="display: none;"><a href="javascript:void(0)" class="co-gray">${dicts.common.local[p.language]}</a></li>
                  </c:otherwise>
                </c:choose>
              </c:forEach>
            </ul>
          </div>
        </li>
      </ul>
      <textarea id="editContent" name="editContent"></textarea>
      <div class="operate-btn">
        <c:if test="${listLanguage.size() > 1}">
          <%--上一步--%>
          <soul:button target="changeCurrentLang" opType="function" cssClass="btn btn-filter btn-outline  btn-lg m-r previous_lang hide" text="${views.content_auto['上一步']}"></soul:button>

          <%--下一步--%>
          <soul:button target="changeCurrentLang" opType="function" cssClass="btn btn-filter btn-lg m-r next_step" text="${views.content_auto['下一步']}"></soul:button>
        </c:if>
        <soul:button target="${root}/cttAnnouncement/batchSave.html" dataType="json" cssClass="btn btn-filter btn-lg preview hide" opType="ajax" text="${views.content_auto['预览并发布']}" precall="validateForm" post="getCurrentFormData" callback="saveCallbak"></soul:button>
        <c:if test="${empty firstLanguage.id}">
          <button type="button" class="btn btn-default btn-warning btn-lg pull-right" ><i class="fa fa-floppy-o icon-bold"></i>${views.content['保存']}</button>
        </c:if>
      </div>
    </div>
  </div>

</div>
  </form:form>
<soul:import res="site/content/cttdraft/EditContent"/>