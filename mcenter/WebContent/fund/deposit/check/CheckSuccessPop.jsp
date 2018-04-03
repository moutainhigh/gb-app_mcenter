<%--suppress ALL --%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerDepositVo"--%>
<%--@elvariable id="remark" type="so.wwb.gamebox.model.master.player.po.Remark"--%>
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
    <form:form>
        <c:set var="r" value="${command.result}" />
        <form:input type="hidden" path="search.id" value="${r.id}" />
        <form:input type="hidden" path="search.checkStatus" value="${r.checkStatus}" />
        <form:input type="hidden" path="search.rechargeStatus" value="${r.rechargeStatus}" />
        <form:input type="hidden" path="search.transactionNo" value="${r.transactionNo}" />
        <form:input type="hidden" path="search.rechargeTypeParent" value="${r.rechargeTypeParent}" />
        <input type="hidden" name="username" value="${r.username}" />
        <input type="hidden" name="search.checkRemark" />
        <div class="modal-body clearfix">
            <div class="m-b">${views.fund['despoit.check.player']}： <span class="co-blue" id="userName">${r.username}</span>
                    ${gbFn:riskImgByName(r.username)}
                <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${r.username}" name="copy">
                    <i class="fa fa-copy" title="${views.common['copy']}"></i>
                </a>
            </div>
            <div class="m-b">${views.column['VPlayerRecharge.realName']}：<span id="realName">${command.realName}</span>
                <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${command.realName}" name="copy">
                    <i class="fa fa-copy" title="${views.common['copy']}"></i>
                </a>
            </div>
            <c:if test="${r.rechargeAmount>0}">
                <div class="m-b">${views.column['VPlayerRecharge.payerBank']}： ${dicts.common.bankname[r.payerBank]}</div>
                <div class="m-b">
                        ${views.column['VPlayerRecharge.rechargeAmount']}${r.defaultCurrency}：

                    <b class="co-yellow" id="rechargeAmount">${soulFn:formatCurrency(r.rechargeAmount)}</b>
                    <a class="btn btn-sm btn-info btn-stroke m-l-sm" type="button" data-clipboard-text="${soulFn:formatCurrency(r.rechargeAmount)}" name="copy">
                        <i class="fa fa-copy" title="${views.common['copy']}"></i>
                    </a>
                </div>
            </c:if>
            <c:if test="${r.bitAmount>0}">
                <div class="m-b">
                    ${r.payerBank}：
                    <b class="co-yellow">${dicts.common.currency_symbol[r.payerBank]}<fmt:formatNumber value="${r.bitAmount}" pattern="#.########"/></b>
                </div>
            </c:if>
        </div>
        <div class="modal-footer">
            <c:set var="url" value="${r.rechargeTypeParent=='company_deposit'?'fund/deposit/company/confirmCheck.html':'fund/deposit/online/confirmCheck.html'}" />
            <soul:button tag="button" cssClass="btn btn-warning btn-deposit-result-btn" text="${views.common['confirmPass']}" opType="ajax" dataType="json"
                         target="${root}/${url}" post="getCurrentFormData" callback="saveCallbak" />
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-default" opType="function" />
        </div>
    </form:form>
</body>
<soul:import res="site/fund/deposit/check/ConfirmCheck"/>
</html>

