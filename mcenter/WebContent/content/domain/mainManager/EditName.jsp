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
        <form:hidden path="result.updateUser"/>
        <form:hidden path="result.isDefault"/>
        <form:hidden path="result.pageUrl"/>
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
                            <c:if test="${command.result.pageUrl =='/mcenter/passport/login.html'}">
                                <span class="co-grayc2 m-l">${views.content['domain.manageMessage']}</span>
                            </c:if>
                            <c:if test="${command.result.pageUrl =='/tcenter/passport/login.html'}">
                                <span class="co-grayc2 m-l">${views.content['也用于您的总代的子账号登录']}</span>
                            </c:if>
                            <c:if test="${command.result.pageUrl =='/acenter/passport/login.html'}">
                                <span class="co-grayc2 m-l">${views.content['也用于您的代理的子账号登录']}</span>
                            </c:if>

                        </div>
                    </c:when>
                </c:choose>
            </c:forEach>
        </div>

        <div class="form-group clearfix">
            <label class="col-xs-3 al-right " >${views.column['CttDomain.domainLinkAddress']}：</label>
           <c:if test="${command.result.pageUrl=='/index/cname.html'}">
               <div class="form-group clearfix">
                   <div class="col-xs-9">
                       <div class="input-group">
                           <form:textarea path="result.domain" cssClass="form-control m-b-xs resize-vertical text-lowercase" readonly="${command.result.id ne null?true:''}"></form:textarea>
                           <span  class="input-group-addon abroder-no"><i id="isCorrect" class="fa fa-check-circle co-green" style="display: none;"></i></span>
                       </div>
                       <div class="co-grayc2"> ${views.content['domain.edit.urlTitle']}</div>
                   </div>
               </div>
           </c:if>
            <c:if test="${command.result.pageUrl!='/index/cname.html'}">
                <div class="col-xs-9">
                        ${command.result.domain}
                </div>
            </c:if>
        </div>
        <c:if test="${command.result.pageUrl=='/index.html'}">
            <div class="form-group clearfix">
                <label class="col-xs-3 al-right " >${views.content['domain.useRankTitle']}：</label>
                <div class="col-xs-9">
                       ${views.column['CttDomainRank.isForAllRank']}
                </div>
            </div>
        </c:if>
            <%--默认域名--%>
        <c:choose>
            <c:when test="${command.result.isDefault}">
                <div class="form-group clearfix">
                    <label class="col-xs-3 al-right " >${views.content['domain.defaultDomain']}：</label>
                    <div class="col-xs-9">
                            ${views.content['domain.alreadyDomain']}
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <c:if test="${command.result.pageUrl == '/mcenter/passport/login.html'&&command.result.resolveStatus=='5'&&command.result.isEnable ||command.result.pageUrl=='/index/cname.html'}">
                  <%-- <c:if test="${command.result.pageUrl=='/pay/cname.html'}">--%>
                <div class="form-group clearfix isDefault">
                        <label class="col-xs-3 al-right" >${views.content['domain.defaultDomain']}：</label>
                        <div class="col-xs-9">
                            <label><input type="checkbox" id="isDefault">${views.content['domain.setDefault']}</label>
                        </div>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>
        <c:if test="${command.result.pageUrl=='/' || command.result.pageUrl == '/index/cname.html'}">
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
        <soul:button target="${root}/content/sysDomain/updateName.html" post="getCurrentFormData"  precall="validateForm" text="" opType="ajax" dataType="json" cssClass="btn btn-filter" callback="saveCallbak" tag="button">${views.common['confirm']}</soul:button>
        <soul:button target="closePage" text="" opType="function" cssClass="btn btn-outline btn-filter" tag="button">${views.common['cancel']}</soul:button>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/domain/mainManager/Add"/>
</html>
