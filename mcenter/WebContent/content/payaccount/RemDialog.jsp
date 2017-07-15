<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body style="max-height: 200px;">
<form:form action="${root}/" method="post">
        <div class="animated bounceInRight family" style="padding:15px;">
            ${messages.content["payAccount.remDialog.prompt"]}
            <%--当某支付方式/渠道下有多个账号时，玩家存款将按照站长设置的账号顺序依次入账。降低因短时间内大量入款，导致被第三方平台或银行视为违规，被停用账号的风险--%>
            <div>
                <br/><input type="checkbox" class="i-checks" id="remember" name="next">${views.content_auto['下次不提醒']}</div>
            <div class="modal-footer">
                <soul:button target="rememberFn" text="" opType="function" cssClass="btn btn-filter" tag="button">${views.content_auto['继续关闭']}</soul:button>
                <soul:button target="closePage" text="${views.common['cancel']}" opType="function" cssClass="btn btn-outline btn-filter"></soul:button>
            </div>
        </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/payaccount/PayAccountEdit"/>