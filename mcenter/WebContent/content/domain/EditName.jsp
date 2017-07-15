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
        <input name="result.pageUrl" value="true" hidden>
        <div id="validateRule" style="display: none">${command.validateRule}</div>
        <input type="hidden" value="${command.result.isForAllRank eq null ? 'false':command.result.isForAllRank}" name="result.isForAllRank">
        <div class="form-group clearfix">
            <label class="col-xs-3 al-right line-hi34">${views.content['domain.name']}：</label>
            <div class="col-xs-9">

                <form:input path="result.name" cssClass="form-control m-b-xs"/>

            </div>
        </div>


        <div class="form-group clearfix">
            <label class="col-xs-3 al-right">${views.content['domain.typeTitle']}：</label>
            <c:forEach items="${command.domainTypes}" var="type">
                <c:choose>
                    <c:when test="${type.defaultValue eq command.result.pageUrl}">
                        <div class="col-xs-8">${views.content[type.resourceKey]}
                            <c:if test="${command.result.pageUrl!='/'}">
                                <span class="co-grayc2 m-l">${views.content['domain.manageMessage']}</span>
                            </c:if>

                        </div>
                    </c:when>
                </c:choose>
            </c:forEach>
        </div>

        <div class="form-group clearfix">
            <label class="col-xs-3 al-right " >${views.column['CttDomain.domainLinkAddress']}：</label>
            <div class="col-xs-9">
                ${command.result.domain}
            </div>
        </div>
        <c:if test="${command.result.pageUrl=='/index.html'}">
            <div class="form-group clearfix">
                <label class="col-xs-3 al-right " >${views.content['domain.useRankTitle']}：</label>
                <div class="col-xs-9">
                        ${views.column['CttDomainRank.isForAllRank']}
                </div>
            </div>
        </c:if>

        <div class="form-group clearfix">
            <label class="col-xs-3 al-right " >${views.content['domain.defaultDomain']}：</label>
            <div class="col-xs-9">
                ${views.content['domain.alreadyDomain']}
            </div>
        </div>
        <c:if test="${command.result.pageUrl=='/'}">
        <div class="form-group clearfix " id="user_for_agent">
            <label class="col-xs-3 al-right" >${views.content['代理']}：</label>
            <div class="col-xs-9">
                <label><input type="checkbox" name="result.forAgent" id="forAgent" ${command.result.forAgent?'checked':''} >${views.content['用该域名生成总代及代理推广链接']}</label>
                    <span data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                          role="button" class="help-popover" tabindex="0"
                          data-original-title="" title="" data-content="${views.content['勾选后']}">
                        <i class="fa fa-question-circle"></i>
                    </span>
            </div>
        </div>
        </c:if>
    </div>
    <div class="modal-footer">
        <soul:button target="${root}/content/sysDomain/updateMainManager.html" post="getCurrentFormData"  precall="validateForm" text="" opType="ajax" dataType="json" cssClass="btn btn-filter" callback="saveCallbak" tag="button">${views.common['confirm']}</soul:button>
        <soul:button target="closePage" text="" opType="function" cssClass="btn btn-outline btn-filter" tag="button">${views.common['cancel']}</soul:button>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/domain/mainManager/Add"/>
</html>
