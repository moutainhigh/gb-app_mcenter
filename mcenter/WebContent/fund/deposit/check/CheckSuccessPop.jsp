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
            <div class="m-b">${views.fund['despoit.check.player']}： <span class="co-blue">${r.username}</span></div>
            <div class="m-b">${views.column['VPlayerRecharge.realName']}： ${command.realName}</div>
            <div class="m-b">${views.column['VPlayerRecharge.payerBank']}： ${dicts.common.bankname[r.payerBank]}</div>
            <div class="m-b">
                ${views.column['VPlayerRecharge.rechargeAmount']}${r.defaultCurrency}：
                <b class="co-yellow">${soulFn:formatCurrency(r.rechargeAmount)}</b>
            </div>
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

