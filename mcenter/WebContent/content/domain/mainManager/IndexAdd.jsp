<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-8-14
  Time: 下午2:10
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.SysDomainVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
  <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form>
  <div class="modal-body">
    <form:hidden path="result.id"/>
    <input name="result.isDefault" value="true" hidden>
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <input type="hidden" value="${command.result.isForAllRank eq null ? 'false':command.result.isForAllRank}" name="result.isForAllRank">
    <div class="form-group clearfix">
      <label class="col-xs-3 al-right line-hi34" for="result.domain">${views.content['domain.name']}：</label>
      <div class="col-xs-9">

        <form:input path="result.name" cssClass="form-control m-b-xs"/>

      </div>
    </div>

    <div class="form-group clearfix">
      <label class="col-xs-3 al-right line-hi34">${views.content['domain.typeTitle']}：</label>
      <div class="col-xs-5" aria-disabled="true">
        <select class="chosen-select-no-single" name="result.pageUrl">
          <c:forEach items="${command.domainTypes}" var="type">
            <c:choose>
              <c:when test="${type.defaultValue eq indexPageUrl}">
                <option value="${type.defaultValue}" selected>${views.content[type.resourceKey]}</option>
              </c:when>
            </c:choose>
          </c:forEach>
        </select>
      </div>
    </div>

    <div class="form-group clearfix">
      <label class="col-xs-3 al-right line-hi34" for="result.domain">${views.column['CttDomain.domainLinkAddress']}：</label>
      <div class="col-xs-9">
        <form:input path="result.domain" cssClass="form-control m-b-xs"/>
        <div class="co-grayc2"> ${views.content['indexdomain.edit.urlTitle']}</div>
      </div>
    </div>

    <div class="form-group clearfix m-t-sm" ${command.result.pageUrl eq '/mcenter/index.html'?'hidden':''}>
      <label class="col-xs-3 al-right">${views.content['domain.useRankTitle']}：</label>
      <div class="col-xs-9">${views.column['CttDomainRank.isForAllRank']}</div>
      <div class="col-xs-9" hidden>
        <c:set var="is4AllRank" value="${command.result.id ne null && command.result.isForAllRank}"/>
        <label class="m-r-sm"><input type="radio" class="i-checks some_rank" ${!is4AllRank && command.result.id ne null ? 'checked':''} name="result.rankType">${views.content_auto['部分层级']}</label>
        <label class="m-r-sm"><input type="radio" class="i-checks all_rank" ${is4AllRank ? 'checked':''} name="result.rankType">${views.column['CttDomainRank.isForAllRank']}</label><br>
          <%--player rank--%>
        <c:forEach items="${command.playerRanks}" var="playerRanks">
          <c:set var="hasRankChecked" value="0"/>
          <c:forEach items="${command.domainRanks}" var="domainRanks" varStatus="status">
            <c:choose>
              <c:when test="${domainRanks.rankId eq playerRanks.id}">
                <c:set var="hasRankChecked" value="1"/>
                <label class="m-r-sm"><input type="checkbox" ${is4AllRank ? 'disabled checked':''} checked class="i-checks rank"  value="${playerRanks.id}" name="rankIds">${playerRanks.rankName}</label>
              </c:when>
              <c:when test="${hasRankChecked eq 0 && status.last}">
                <label class="m-r-sm"><input type="checkbox" ${is4AllRank ? 'disabled checked':''} class="i-checks rank"  value="${playerRanks.id}" name="rankIds">${playerRanks.rankName}</label>
              </c:when>
            </c:choose>
          </c:forEach>
          <c:if test="${empty command.domainRanks}">
            <label class="m-r-sm" data-test="1"><input type="checkbox" ${is4AllRank ? 'disabled checked':''} class="i-checks rank"  value="${playerRanks.id}" name="rankIds">${playerRanks.rankName}</label>
          </c:if>
        </c:forEach>
      </div>
    </div>
  </div>
  <div class="modal-footer">
    <soul:button target="${root}/content/sysDomain/saveIndexDomain.html" post="getCurrentFormData"  precall="saveDomain" text="" opType="ajax" dataType="json" cssClass="btn btn-filter _search" callback="saveCallbak" tag="button">${views.common['confirm']}</soul:button>
    <soul:button target="closePage" text="" opType="function" cssClass="btn btn-outline btn-filter" tag="button">${views.common['cancel']}</soul:button>
  </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/domain/mainManager/IndexAdd"/>
</html>
