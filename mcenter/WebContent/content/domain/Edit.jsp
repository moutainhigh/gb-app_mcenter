<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-8-14
  Time: 下午2:10
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.SysDomainVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
    <form:form id="editForm">
        <div id="validateRule" style="display: none">${command.validateRule}</div>
        <form:hidden path="result.id"/>
        <form:hidden path="result.isDefault"/>
        <form:hidden path="result.resolveStatus"/>
        <form:hidden path="result.isEnable"/>
        <form:hidden path="result.buildIn"/>
        <gb:token/>


        <div hidden>
            <span data-value="/mcenter/passport/login.html">${views.content['也用于您的子账号登录站长后台']}</span>
            <span data-value="/tcenter/passport/login.html">${views.content['也用于您的总代的子账号登录']}</span>
            <span data-value="/acenter/passport/login.html">${views.content['也用于您的代理的子账号登录']}</span>
        </div>
        <%--<input type="hidden" name="token" value="${token}"/>--%>
        <input type="hidden" value="${command.result.pageUrl}" id="old_page_url">
        <div class="modal-body">
            <div class="form-group clearfix">
                <label class="col-xs-3 al-right line-hi34" for="result.domain">${views.content['domain.name']}：</label>
                <div class="col-xs-9">
                        <form:input path="result.name" cssClass="form-control m-b-xs"/>
                </div>
            </div>

            <div class="form-group clearfix">
                <label class="col-xs-3 al-right line-hi34">${views.content['domain.typeTitle']}：</label>
                <div class="col-xs-8">
                    <div class="input-group date">
                    <select class="chosen-select-no-single input-group-btn" callback="isShowRank" name="result.pageUrl">
                        <c:if test="${command.result.id eq null}">
                            <option value="">${views.common['pleaseSelect']}</option>
                        </c:if>
                        <c:forEach items="${command.domainTypes}" var="type">
                            <c:choose>
                                <%--主页或者线路检测--%>
                                <c:when test="${command.result.id ne null}">
                                    <c:if test="${type.paramCode == 'index' || type.paramCode == 'detection'}">
                                        <option value="${type.defaultValue}" ${type.defaultValue eq command.result.pageUrl?'selected':''}> ${views.content[type.resourceKey]}</option>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <option value="${type.defaultValue}"> ${views.content[type.resourceKey]}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                    <span id="managerMsg" class="co-grayc2 m-l-xs line-hi34" style="white-space: nowrap">
                    </span>
                    </div>
                </div>
            </div>

            <div class="form-group clearfix">
                <label class="col-xs-3 al-right line-hi34" for="result.domain">${views.column['CttDomain.domainLinkAddress']}：</label>
                <div class="col-xs-9">
                    <div class="input-group">
                        <form:textarea path="result.domain" cssClass="form-control m-b-xs resize-vertical text-lowercase" readonly="${command.result.id ne null?true:''}"></form:textarea>
                            <span  class="input-group-addon abroder-no"><i id="isCorrect" class="fa fa-check-circle co-green" style="display: none;"></i></span>
                    </div>
                    <div class="co-grayc2"> ${views.content['domain.edit.urlTitle']}</div>
                </div>
            </div>

            <div class="form-group clearfix isDefault" style="display: ${command.result.pageUrl=='/'&&command.result.resolveStatus=='5'&&command.result.isEnable?'':'none'};">
                <label class="col-xs-3 al-right" >${views.content['domain.defaultDomain']}：</label>
                <div class="col-xs-9">
                    <label><input type="checkbox" id="isDefault">${views.content['domain.setDefault']}</label>
                </div>
            </div>
            <div class="form-group clearfix" id="user_for_agent" style="display: ${(command.result.pageUrl=='/' || command.result.pageUrl=='/netLine/findLines.html')?'':'none'};">
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
            </br>
            </br>
            </br>
            </br>
        </div>
        <div class="modal-footer">
            <soul:button target="${root}/content/sysDomain/persistDomain.html" post="getCurrentFormData" precall="saveDomain" text="" opType="ajax" dataType="json" cssClass="btn btn-filter _search" callback="saveCallbak" tag="button">${views.common['confirm']}</soul:button>
            <soul:button target="closePage" text="" opType="function" cssClass="btn btn-outline btn-filter" tag="button">${views.common['cancel']}</soul:button>
        </div>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/domain/Edit"/>
</html>
