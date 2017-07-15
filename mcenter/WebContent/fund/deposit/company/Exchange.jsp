<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerDepositVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.fund['despoit.check.confirmCheck']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <%@ include file="/include/include.js.jsp" %>
</head>

<body>
<form:form method="post">
    <c:set var="r" value="${command.result}"/>
    <c:choose>
        <c:when test="${empty r}">
            <div class="modal-body clearfix">
                <div class="m-b">无该存款记录</div>
            </div>
        </c:when>
        <c:when test="${r.rechargeStatus != '8'}">
            <div class="modal-body clearfix">
                <div class="m-b">该笔存款已兑现过</div>
            </div>
        </c:when>
        <c:otherwise>
            <form:input type="hidden" path="search.id" value="${r.id}" />
            <form:input type="hidden" path="search.transactionNo" value="${r.transactionNo}" />
            <div class="modal-body clearfix">
                <div class="m-b">${views.fund['despoit.check.player']}： <span class="co-blue">${r.username}</span></div>
                <div class="m-b">${views.column['VPlayerRecharge.realName']}： ${command.realName}</div>
                <div class="m-b">玩家比特币地址： ${r.payerBankcard}</div>
                <div class="m-b">
                       比特币：
                    <b class="co-yellow"><fmt:formatNumber pattern="#.########" value="${r.bitAmount}"/></b>
                </div>
                <div class="m-b">收款比特币地址： ${r.account}</div>
                <br/>
                <div class="m-b co-yellow">温馨提示：兑换比特币过程会比较慢，请耐心等待！</div>
            </div>
            <div class="modal-footer">
                <soul:button tag="button" cssClass="btn btn-warning btn-deposit-result-btn" text="兑换" opType="function" target="exchange"/>
                <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-default" opType="function" />
            </div>
        </c:otherwise>
    </c:choose>
</form:form>
</body>
<soul:import res="site/fund/deposit/company/Exchange"/>
</html>

