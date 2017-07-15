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
        <gb:token></gb:token>
        <div id="validateRule" style="display: none">${command.validateRule}</div>
        <form:hidden path="result.id"/>
        <div class="modal-body">
            <div class="form-group clearfix">
                <label class="col-xs-3 al-right line-hi34">${views.content['domain.agent.account']}：</label>
                <div class="col-xs-8 input-group">
                    ${command.agentUserName}
                </div>
            </div>
            <div class="form-group clearfix">
                <label class="col-xs-3 al-right line-hi34">${views.content['domain.tgym']}：</label>
                <div class="col-xs-9">
                    <form:textarea path="result.domain" cssClass="form-control m-b-xs resize-vertical text-lowercase" readonly="${command.result.id ne null?true:''}"></form:textarea>
                            <%--<form:input path="result.domain" cssClass="form-control m-b-xs"/>--%>
                    <div class="co-grayc2">${views.content['domain.tgym.prompt']}</div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <soul:button target="${root}/content/sysDomain/updateAgentDomain.html" callback="viewPrompt" post="getCurrentFormData"  precall="validateForm" text=""   opType="ajax" dataType="json" cssClass="btn btn-filter" tag="button">${views.common['confirm']}</soul:button>
            <soul:button target="closePage" text="" opType="function" cssClass="btn btn-outline btn-filter" tag="button">${views.common['cancel']}</soul:button>
        </div>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/domain/agent/Edit"/>
</html>
